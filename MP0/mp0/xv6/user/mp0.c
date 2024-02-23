#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

int count_occurrences(char *str, char key) {
    int count = 0;
    for (; *str != '\0'; str++) {
        if (*str == key) count++;
    }
    return count;
}

int inspect(char *path) {
    int fd_dir;
    struct stat st;
    if((fd_dir = open(path, 0)) < 0){
        fprintf(2, "%s [error opening dir]\n", path);
        close(fd_dir);
        return 1;
    }

    if(fstat(fd_dir, &st) < 0){
        fprintf(2, "Cannot stat %s\n", path);
        close(fd_dir);
        return 1;
    }
    close(fd_dir);
    return 0;
}

void find(char *path, char *key, int depth, int fd[2]) {
    char buf[100], *p;
    int fd_dir;
    struct dirent de;
    struct stat st;

    fd_dir = open(path, 0);
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    
    while(read(fd_dir, &de, sizeof(de)) == sizeof(de)){
        if(de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
            continue;
        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;
        
        if(stat(buf, &st) < 0){
            fprintf(2, "Cannot stat %s\n", buf);
            continue;
        }
        if(st.type == T_FILE){
            printf("%s %d\n", buf, count_occurrences(buf, key[0]));
            write(fd[1], &(int){1}, sizeof(int)); // Send file count
            write(fd[1], &(int){0}, sizeof(int)); // Send dir count
        } else if(st.type == T_DIR && depth < 5){
            printf("%s %d\n", buf, count_occurrences(buf, key[0]));
            if (inspect(buf) == 0){
                find(buf, key, depth + 1, fd);
            }
            write(fd[1], &(int){0}, sizeof(int)); // Send file count
            write(fd[1], &(int){1}, sizeof(int)); // Send dir count
        }
    }
    close(fd_dir);
}

int main(int argc, char *argv[]) {
    int fd[2], pid;
    int file_num = 0, dir_num = 0, n;

    if(argc < 3){
        fprintf(2, "Usage: mp0 <root_directory> <key>\n");
        exit(1);
    }

    if(pipe(fd) < 0) {
        fprintf(2, "Pipe failed\n");
        exit(1);
    }

    pid = fork();
    if(pid < 0){
        fprintf(2, "Fork failed\n");
        exit(1);
    }

    if(pid == 0){
        close(fd[0]);
        if (inspect(argv[1]) == 0) {
            printf("%s %d\n", argv[1], count_occurrences(argv[1], argv[2][0]));
            find(argv[1], argv[2], 0, fd);
        }
        close(fd[1]);
        exit(0);
    } else {
        close(fd[1]);
        wait((int *) 0);
        while(read(fd[0], &n, sizeof(int)) > 0){
            file_num += n;
            read(fd[0], &n, sizeof(int));
            dir_num += n;
        }
        printf("\n%d directories, %d files\n", dir_num, file_num);
        close(fd[0]);
    }
    exit(0);
}
