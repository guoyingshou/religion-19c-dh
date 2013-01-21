SYLLABUSFILENAME = religion-19c-dh.pdf
COMPONENTS = syllabus.md.pdf schedule.md.pdf policies.md.pdf

all : $(SYLLABUSFILENAME) proposal.md.pdf

$(SYLLABUSFILENAME) : vc $(COMPONENTS)
	pdftk $(COMPONENTS) cat output $(SYLLABUSFILENAME)

policies.md.pdf : policies.md
	pandoc $< -o $@ \
		--template=syllabus-additional \
		--variable=twocolumn

syllabus.md.pdf : syllabus.md
	pandoc $< -o $@ \
		--template=syllabus \
		--variable=coursenumber:'' \
		--variable=university:'Brandeis University' \
		--variable=office:'' \
		--variable=hours:'' \
		--variable=semester:'Course Proposal' \
		--variable=classroom:'' \
		--variable=times:'' \
		--variable=mailbox:'' \
		--variable=email:'lmullen@brandeis.edu' \
		--variable=web:'http://lincolnmullen.com' \
		--variable=courseweb:'' \
		--variable=draft:true

schedule.md.pdf : schedule.md
	pandoc $< -o $@ \
		--template=syllabus-additional

proposal.md.pdf : proposal.md
	pandoc $< -o $@ \
		--variable documentclass=acadpaper \
		--bibliography=/Users/lmullen/bib/master.bib \
		--csl=chicago-mullen.csl

# upload syllabus to website
upload : $(SYLLABUSFILENAME)
	scp $(SYLLABUSFILENAME) lam:public_html/docs/

# update the version control information
.PHONY : vc
vc	: 
	./vc

clean:
	rm $(SYLLABUSFILENAME) $(COMPONENTS) proposal.md.pdf

rebuild : clean $(SYLLABUSFILENAME)
