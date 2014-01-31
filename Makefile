# The "download" section
download:
	./download.sh

# The full site
www.opendata500.com:
	wget -r http://www.opendata500.com/

www.opendata500.com/addData/52eb5431def7fa00029abc8f/index.html: 
	mkdir -p www.opendata500.com/addData/52eb5431def7fa00029abc8f/ 
	wget -O www.opendata500.com/addData/52eb5431def7fa00029abc8f/index.html http://www.opendata500.com/addData/52eb5431def7fa00029abc8f/

forbes.html:
	wget -O forbes.html http://www.forbes.com/sites/bethsimonenoveck/2014/01/08/from-faith-based-to-evidence-based-the-open-data-500-and-understanding-how-open-data-helps-the-american-economy/

informationweek.html:
	wget -O informationweek.html http://www.informationweek.com/government/open-government/open-government-data-companies-cash-in/d/d-id/1113143

fedscoop.html:
	wget -O fedscoop.html http://fedscoop.com/open-data-500-intersection-open-data-economy/
