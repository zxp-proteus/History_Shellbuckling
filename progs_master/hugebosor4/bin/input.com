# THIS IS THE INPUT COM FILE...

# THIS PROCEDURE IS FOR GENERATING A FILE CONTAINING DATA FOR
# STRUCTURAL SEGMENTS AND GLOBAL AND CONSTRAINT DATA...

if ($MACHINE == "cray") then
  setenv FILENV /tmp/ass.input$$
  assign -a ${HUGEBOSOR4}/execute/PROMPT.DAT PROMPT.DAT
  assign -a ${HUGEBOSOR4}/execute/PROMPT2.DAT PROMPT2.DAT
  assign -a ${HUGEBOSOR4}/execute/PROMPT3.DAT PROMPT3.DAT
else
  ln -s ${HUGEBOSOR4}/execute/PROMPT.DAT   PROMPT.DAT
  ln -s ${HUGEBOSOR4}/execute/PROMPT2.DAT   PROMPT2.DAT
  ln -s ${HUGEBOSOR4}/execute/PROMPT3.DAT   PROMPT3.DAT
endif

echo -n "Please enter case name: "
set case = $<
${HUGEBOSOR4}/execute/input.${MACHINE} $case

if ($MACHINE == "cray") then
  'rm' -f $FILENV
else
  'rm' -f {PROMPT,PROMPT2,PROMPT3}.DAT
endif
