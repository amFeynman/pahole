#!/bin/bash
. ~/.bashrc
PAHOLE=$(git rev-parse --show-toplevel)/build/pahole

cat << EOF > test.dot
digraph graphLabel {
  fontname="Helvetica,Arial,sans-serif"
  node [
       fontname="Helvetica,Arial,sans-serif"
       labelloc="c"
   ]
  edge [fontname="Helvetica,Arial,sans-serif"]
  graph [
	rankdir = "LR"
	labeljust="c"
  ];
  node [
  fontsize = "16";
  shape = "record"
  ];
EOF

$PAHOLE -G -C $1 vmlinux | sed 's/^[ \t]*//g' | tr '\n' ' ' | sed 's/| }/}/g' | sed 's#| "]#"]#g' >> test.dot

cat << EOF >> test.dot

}
EOF

dot test.dot -T png -o new.png
cp new.png /mnt/c/Users/Administrator/Pictures/
