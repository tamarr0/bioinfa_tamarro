
#!/bin/bash

#1
awk '{sum=0; for (i=1;i<=NF;i++) sum+=$i; print sum}' fin > fout


#2
echo "Hello, world!" > fout

#3
cut -c10 fin > fout

#4
paste - - < fin | grep '777' > fout

#5
sort -k2,2V -k3,3n -k4,4n fin > fout

#6
grep -i '[0-9]' fin | grep -vi '[xy]' | sed 's/\r//' | awk '{total += length} END {print total}'

#7
VCF="fin"

insertion=$(awk -F'\t' '
    !/^#/ {
        len_ref = length($4);
        len_alt = length($5);
        if (len_alt > len_ref) {
            ins_len = len_alt - len_ref;
            if (ins_len > max_len) {
                max_len = ins_len;
                insertion = substr($5, len_ref + 1);
            }
        }
    }
    END { print insertion }
' "$VCF")

deletion=$(awk -F'\t' '
    !/^#/ {
        len_ref = length($4);
        len_alt = length($5);
        if (len_ref > len_alt) {
            del_len = len_ref - len_alt;
            if (del_len > max_len) {
                max_len = del_len;
                deletion = substr($4, len_alt + 1);
            }
        }
    }
    END { print deletion }
' "$VCF")

{
    echo "Longest insertion:"
    echo "$insertion"
    echo "Longest deletion:"
    echo "$deletion"
} > fout


#8
awk -F':' '
    NR > 1 && tolower(substr($1, 1, 1)) ~ /^[ab]/ {
        printf "Username: %s, Home: %s, Password: %s\n", $1, $6, $2
    }
' fin > fout
