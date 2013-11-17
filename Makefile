SYLLABUSFILENAME = religion-19c-dh.pdf
COMPONENTS = syllabus.md.pdf schedule.md.pdf policies.md.pdf

all : $(SYLLABUSFILENAME) 

$(SYLLABUSFILENAME) : vc $(COMPONENTS)
	pdftk $(COMPONENTS) cat output $(SYLLABUSFILENAME)

policies.md.pdf : policies.md
	pandoc $< -o $@ \
		--template=syllabus-additional \
		--variable=twocolumn

syllabus.md.pdf : syllabus.md
	pandoc $< -o $@ \
		--template=syllabus \
		--variable=coursenumber:'HIST 144A' \
		--variable=university:'Brandeis University' \
		--variable=office:'TBA' \
		--variable=hours:'TBA' \
		--variable=semester:'Spring 2014' \
		--variable=classroom:'TBA' \
		--variable=times:'Tuesday/Friday 12:30-2:00' \
		--variable=email:'lmullen@brandeis.edu' \
		--variable=web:'http://lincolnmullen.com'

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
	scp $(SYLLABUSFILENAME) lam:public_html/downloads/docs/

# update the version control information
.PHONY : vc
vc	: 
	./vc

clean:
	rm $(SYLLABUSFILENAME) $(COMPONENTS) proposal.md.pdf

rebuild : clean $(SYLLABUSFILENAME)
