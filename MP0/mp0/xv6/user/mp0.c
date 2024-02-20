#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

#define MAX 512

void find(char *path, char *key, int *file_num, int *dir_num, int fd) {
    char buf[MAX], *p;
    int fd_dir;
    struct dirent de;
    struct stat st;

    if((fd_dir = open(path, 0)) < 0){
        fprintf(2, "%s [error opening dir]\n", path);
        return;
    }

    if(fstat(fd_dir, &st) < 0){
        fprintf(2, "Cannot stat %s\n", path);
        close(fd_dir);
        return;
    }

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
        switch(st.type){
            case T_FILE:
                (*file_num)++;
                // Logic to count occurrences of key in file names could be added here
                break;
            case T_DIR:
                (*dir_num)++;
                find(buf, key, file_num, dir_num, fd);
                break;
        }
    }
    close(fd_dir);
}

int main(int argc, char *argv[]) {
    int fd[2], pid;
    int file_num = 0, dir_num = 0;

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
        find(argv[1], argv[2], &file_num, &dir_num, fd[1]);
        write(fd[1], &file_num, sizeof(file_num));
        write(fd[1], &dir_num, sizeof(dir_num));
        close(fd[1]);
        exit(0);
    } else {
        close(fd[1]);
        wait((int *) 0);
        read(fd[0], &file_num, sizeof(file_num));
        read(fd[0], &dir_num, sizeof(dir_num));
        printf("\n%d directories, %d files\n", dir_num, file_num);
        close(fd[0]);
    }
    exit(0);
}
