Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Apr 2018 11:01:15 +0800
From: kbuild test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, Brijesh Singh <brijesh.singh@amd.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-pci@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        linux-input@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devel@linuxdriverproject.org
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Message-ID: <201804261045.v9iHAD1T%fengguang.wu@intel.com>
References: <20180419001848.3041-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <20180419001848.3041-2-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baoquan,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc2 next-20180424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180419-223752
config: microblaze-mmu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=microblaze 

All errors (new ones prefixed by >>):

   arch/microblaze/pci/pci-common.c: In function 'pci_process_bridge_OF_ranges':
>> arch/microblaze/pci/pci-common.c:536:44: error: incompatible types when assigning to type 'struct list_head' from type 'void *'
       res->parent = res->child = res->sibling = NULL;
                                               ^
   arch/microblaze/pci/pci-common.c: In function 'reparent_resources':
>> arch/microblaze/pci/pci-common.c:631:10: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
     for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
             ^
   arch/microblaze/pci/pci-common.c:631:50: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
     for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
                                                     ^
>> arch/microblaze/pci/pci-common.c:644:13: error: incompatible types when assigning to type 'struct list_head' from type 'struct resource *'
     res->child = *firstpp;
                ^
   arch/microblaze/pci/pci-common.c:645:15: error: incompatible types when assigning to type 'struct list_head' from type 'struct resource *'
     res->sibling = *pp;
                  ^
>> arch/microblaze/pci/pci-common.c:648:9: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
     for (p = res->child; p != NULL; p = p->sibling) {
            ^
   arch/microblaze/pci/pci-common.c:648:36: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
     for (p = res->child; p != NULL; p = p->sibling) {
                                       ^
   cc1: some warnings being treated as errors

vim +536 arch/microblaze/pci/pci-common.c

d3afa58c Michal Simek        2010-01-18  387  
d3afa58c Michal Simek        2010-01-18  388  /**
d3afa58c Michal Simek        2010-01-18  389   * pci_process_bridge_OF_ranges - Parse PCI bridge resources from device tree
d3afa58c Michal Simek        2010-01-18  390   * @hose: newly allocated pci_controller to be setup
d3afa58c Michal Simek        2010-01-18  391   * @dev: device node of the host bridge
d3afa58c Michal Simek        2010-01-18  392   * @primary: set if primary bus (32 bits only, soon to be deprecated)
d3afa58c Michal Simek        2010-01-18  393   *
d3afa58c Michal Simek        2010-01-18  394   * This function will parse the "ranges" property of a PCI host bridge device
d3afa58c Michal Simek        2010-01-18  395   * node and setup the resource mapping of a pci controller based on its
d3afa58c Michal Simek        2010-01-18  396   * content.
d3afa58c Michal Simek        2010-01-18  397   *
d3afa58c Michal Simek        2010-01-18  398   * Life would be boring if it wasn't for a few issues that we have to deal
d3afa58c Michal Simek        2010-01-18  399   * with here:
d3afa58c Michal Simek        2010-01-18  400   *
d3afa58c Michal Simek        2010-01-18  401   *   - We can only cope with one IO space range and up to 3 Memory space
d3afa58c Michal Simek        2010-01-18  402   *     ranges. However, some machines (thanks Apple !) tend to split their
d3afa58c Michal Simek        2010-01-18  403   *     space into lots of small contiguous ranges. So we have to coalesce.
d3afa58c Michal Simek        2010-01-18  404   *
d3afa58c Michal Simek        2010-01-18  405   *   - We can only cope with all memory ranges having the same offset
d3afa58c Michal Simek        2010-01-18  406   *     between CPU addresses and PCI addresses. Unfortunately, some bridges
d3afa58c Michal Simek        2010-01-18  407   *     are setup for a large 1:1 mapping along with a small "window" which
d3afa58c Michal Simek        2010-01-18  408   *     maps PCI address 0 to some arbitrary high address of the CPU space in
d3afa58c Michal Simek        2010-01-18  409   *     order to give access to the ISA memory hole.
d3afa58c Michal Simek        2010-01-18  410   *     The way out of here that I've chosen for now is to always set the
d3afa58c Michal Simek        2010-01-18  411   *     offset based on the first resource found, then override it if we
d3afa58c Michal Simek        2010-01-18  412   *     have a different offset and the previous was set by an ISA hole.
d3afa58c Michal Simek        2010-01-18  413   *
d3afa58c Michal Simek        2010-01-18  414   *   - Some busses have IO space not starting at 0, which causes trouble with
d3afa58c Michal Simek        2010-01-18  415   *     the way we do our IO resource renumbering. The code somewhat deals with
d3afa58c Michal Simek        2010-01-18  416   *     it for 64 bits but I would expect problems on 32 bits.
d3afa58c Michal Simek        2010-01-18  417   *
d3afa58c Michal Simek        2010-01-18  418   *   - Some 32 bits platforms such as 4xx can have physical space larger than
d3afa58c Michal Simek        2010-01-18  419   *     32 bits so we need to use 64 bits values for the parsing
d3afa58c Michal Simek        2010-01-18  420   */
b881bc46 Greg Kroah-Hartman  2012-12-21  421  void pci_process_bridge_OF_ranges(struct pci_controller *hose,
b881bc46 Greg Kroah-Hartman  2012-12-21  422  				  struct device_node *dev, int primary)
d3afa58c Michal Simek        2010-01-18  423  {
d3afa58c Michal Simek        2010-01-18  424  	int memno = 0, isa_hole = -1;
d3afa58c Michal Simek        2010-01-18  425  	unsigned long long isa_mb = 0;
d3afa58c Michal Simek        2010-01-18  426  	struct resource *res;
4f7b6de4 Andrew Murray       2013-07-27  427  	struct of_pci_range range;
4f7b6de4 Andrew Murray       2013-07-27  428  	struct of_pci_range_parser parser;
d3afa58c Michal Simek        2010-01-18  429  
f2b8ae0e Rob Herring         2017-06-06  430  	pr_info("PCI host bridge %pOF %s ranges:\n",
f2b8ae0e Rob Herring         2017-06-06  431  	       dev, primary ? "(primary)" : "");
d3afa58c Michal Simek        2010-01-18  432  
4f7b6de4 Andrew Murray       2013-07-27  433  	/* Check for ranges property */
4f7b6de4 Andrew Murray       2013-07-27  434  	if (of_pci_range_parser_init(&parser, dev))
d3afa58c Michal Simek        2010-01-18  435  		return;
d3afa58c Michal Simek        2010-01-18  436  
d3afa58c Michal Simek        2010-01-18  437  	pr_debug("Parsing ranges property...\n");
4f7b6de4 Andrew Murray       2013-07-27  438  	for_each_of_pci_range(&parser, &range) {
d3afa58c Michal Simek        2010-01-18  439  		/* Read next ranges element */
6bd55f0b Michal Simek        2012-12-27  440  		pr_debug("pci_space: 0x%08x pci_addr:0x%016llx ",
4f7b6de4 Andrew Murray       2013-07-27  441  				range.pci_space, range.pci_addr);
6bd55f0b Michal Simek        2012-12-27  442  		pr_debug("cpu_addr:0x%016llx size:0x%016llx\n",
4f7b6de4 Andrew Murray       2013-07-27  443  					range.cpu_addr, range.size);
d3afa58c Michal Simek        2010-01-18  444  
d3afa58c Michal Simek        2010-01-18  445  		/* If we failed translation or got a zero-sized region
d3afa58c Michal Simek        2010-01-18  446  		 * (some FW try to feed us with non sensical zero sized regions
d3afa58c Michal Simek        2010-01-18  447  		 * such as power3 which look like some kind of attempt
d3afa58c Michal Simek        2010-01-18  448  		 * at exposing the VGA memory hole)
d3afa58c Michal Simek        2010-01-18  449  		 */
4f7b6de4 Andrew Murray       2013-07-27  450  		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
d3afa58c Michal Simek        2010-01-18  451  			continue;
d3afa58c Michal Simek        2010-01-18  452  
d3afa58c Michal Simek        2010-01-18  453  		/* Act based on address space type */
d3afa58c Michal Simek        2010-01-18  454  		res = NULL;
4f7b6de4 Andrew Murray       2013-07-27  455  		switch (range.flags & IORESOURCE_TYPE_BITS) {
4f7b6de4 Andrew Murray       2013-07-27  456  		case IORESOURCE_IO:
6bd55f0b Michal Simek        2012-12-27  457  			pr_info("  IO 0x%016llx..0x%016llx -> 0x%016llx\n",
4f7b6de4 Andrew Murray       2013-07-27  458  				range.cpu_addr, range.cpu_addr + range.size - 1,
4f7b6de4 Andrew Murray       2013-07-27  459  				range.pci_addr);
d3afa58c Michal Simek        2010-01-18  460  
d3afa58c Michal Simek        2010-01-18  461  			/* We support only one IO range */
d3afa58c Michal Simek        2010-01-18  462  			if (hose->pci_io_size) {
6bd55f0b Michal Simek        2012-12-27  463  				pr_info(" \\--> Skipped (too many) !\n");
d3afa58c Michal Simek        2010-01-18  464  				continue;
d3afa58c Michal Simek        2010-01-18  465  			}
d3afa58c Michal Simek        2010-01-18  466  			/* On 32 bits, limit I/O space to 16MB */
4f7b6de4 Andrew Murray       2013-07-27  467  			if (range.size > 0x01000000)
4f7b6de4 Andrew Murray       2013-07-27  468  				range.size = 0x01000000;
d3afa58c Michal Simek        2010-01-18  469  
d3afa58c Michal Simek        2010-01-18  470  			/* 32 bits needs to map IOs here */
4f7b6de4 Andrew Murray       2013-07-27  471  			hose->io_base_virt = ioremap(range.cpu_addr,
4f7b6de4 Andrew Murray       2013-07-27  472  						range.size);
d3afa58c Michal Simek        2010-01-18  473  
d3afa58c Michal Simek        2010-01-18  474  			/* Expect trouble if pci_addr is not 0 */
d3afa58c Michal Simek        2010-01-18  475  			if (primary)
d3afa58c Michal Simek        2010-01-18  476  				isa_io_base =
d3afa58c Michal Simek        2010-01-18  477  					(unsigned long)hose->io_base_virt;
d3afa58c Michal Simek        2010-01-18  478  			/* pci_io_size and io_base_phys always represent IO
d3afa58c Michal Simek        2010-01-18  479  			 * space starting at 0 so we factor in pci_addr
d3afa58c Michal Simek        2010-01-18  480  			 */
4f7b6de4 Andrew Murray       2013-07-27  481  			hose->pci_io_size = range.pci_addr + range.size;
4f7b6de4 Andrew Murray       2013-07-27  482  			hose->io_base_phys = range.cpu_addr - range.pci_addr;
d3afa58c Michal Simek        2010-01-18  483  
d3afa58c Michal Simek        2010-01-18  484  			/* Build resource */
d3afa58c Michal Simek        2010-01-18  485  			res = &hose->io_resource;
4f7b6de4 Andrew Murray       2013-07-27  486  			range.cpu_addr = range.pci_addr;
4f7b6de4 Andrew Murray       2013-07-27  487  
d3afa58c Michal Simek        2010-01-18  488  			break;
4f7b6de4 Andrew Murray       2013-07-27  489  		case IORESOURCE_MEM:
6bd55f0b Michal Simek        2012-12-27  490  			pr_info(" MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
4f7b6de4 Andrew Murray       2013-07-27  491  				range.cpu_addr, range.cpu_addr + range.size - 1,
4f7b6de4 Andrew Murray       2013-07-27  492  				range.pci_addr,
4f7b6de4 Andrew Murray       2013-07-27  493  				(range.pci_space & 0x40000000) ?
4f7b6de4 Andrew Murray       2013-07-27  494  				"Prefetch" : "");
d3afa58c Michal Simek        2010-01-18  495  
d3afa58c Michal Simek        2010-01-18  496  			/* We support only 3 memory ranges */
d3afa58c Michal Simek        2010-01-18  497  			if (memno >= 3) {
6bd55f0b Michal Simek        2012-12-27  498  				pr_info(" \\--> Skipped (too many) !\n");
d3afa58c Michal Simek        2010-01-18  499  				continue;
d3afa58c Michal Simek        2010-01-18  500  			}
d3afa58c Michal Simek        2010-01-18  501  			/* Handles ISA memory hole space here */
4f7b6de4 Andrew Murray       2013-07-27  502  			if (range.pci_addr == 0) {
4f7b6de4 Andrew Murray       2013-07-27  503  				isa_mb = range.cpu_addr;
d3afa58c Michal Simek        2010-01-18  504  				isa_hole = memno;
d3afa58c Michal Simek        2010-01-18  505  				if (primary || isa_mem_base == 0)
4f7b6de4 Andrew Murray       2013-07-27  506  					isa_mem_base = range.cpu_addr;
4f7b6de4 Andrew Murray       2013-07-27  507  				hose->isa_mem_phys = range.cpu_addr;
4f7b6de4 Andrew Murray       2013-07-27  508  				hose->isa_mem_size = range.size;
d3afa58c Michal Simek        2010-01-18  509  			}
d3afa58c Michal Simek        2010-01-18  510  
d3afa58c Michal Simek        2010-01-18  511  			/* We get the PCI/Mem offset from the first range or
d3afa58c Michal Simek        2010-01-18  512  			 * the, current one if the offset came from an ISA
d3afa58c Michal Simek        2010-01-18  513  			 * hole. If they don't match, bugger.
d3afa58c Michal Simek        2010-01-18  514  			 */
d3afa58c Michal Simek        2010-01-18  515  			if (memno == 0 ||
4f7b6de4 Andrew Murray       2013-07-27  516  			    (isa_hole >= 0 && range.pci_addr != 0 &&
d3afa58c Michal Simek        2010-01-18  517  			     hose->pci_mem_offset == isa_mb))
4f7b6de4 Andrew Murray       2013-07-27  518  				hose->pci_mem_offset = range.cpu_addr -
4f7b6de4 Andrew Murray       2013-07-27  519  							range.pci_addr;
4f7b6de4 Andrew Murray       2013-07-27  520  			else if (range.pci_addr != 0 &&
4f7b6de4 Andrew Murray       2013-07-27  521  				 hose->pci_mem_offset != range.cpu_addr -
4f7b6de4 Andrew Murray       2013-07-27  522  							range.pci_addr) {
6bd55f0b Michal Simek        2012-12-27  523  				pr_info(" \\--> Skipped (offset mismatch) !\n");
d3afa58c Michal Simek        2010-01-18  524  				continue;
d3afa58c Michal Simek        2010-01-18  525  			}
d3afa58c Michal Simek        2010-01-18  526  
d3afa58c Michal Simek        2010-01-18  527  			/* Build resource */
d3afa58c Michal Simek        2010-01-18  528  			res = &hose->mem_resources[memno++];
d3afa58c Michal Simek        2010-01-18  529  			break;
d3afa58c Michal Simek        2010-01-18  530  		}
70dcd942 Michal Simek        2014-10-27  531  		if (res != NULL) {
70dcd942 Michal Simek        2014-10-27  532  			res->name = dev->full_name;
70dcd942 Michal Simek        2014-10-27  533  			res->flags = range.flags;
70dcd942 Michal Simek        2014-10-27  534  			res->start = range.cpu_addr;
70dcd942 Michal Simek        2014-10-27  535  			res->end = range.cpu_addr + range.size - 1;
70dcd942 Michal Simek        2014-10-27 @536  			res->parent = res->child = res->sibling = NULL;
70dcd942 Michal Simek        2014-10-27  537  		}
d3afa58c Michal Simek        2010-01-18  538  	}
d3afa58c Michal Simek        2010-01-18  539  
d3afa58c Michal Simek        2010-01-18  540  	/* If there's an ISA hole and the pci_mem_offset is -not- matching
d3afa58c Michal Simek        2010-01-18  541  	 * the ISA hole offset, then we need to remove the ISA hole from
d3afa58c Michal Simek        2010-01-18  542  	 * the resource list for that brige
d3afa58c Michal Simek        2010-01-18  543  	 */
d3afa58c Michal Simek        2010-01-18  544  	if (isa_hole >= 0 && hose->pci_mem_offset != isa_mb) {
d3afa58c Michal Simek        2010-01-18  545  		unsigned int next = isa_hole + 1;
6bd55f0b Michal Simek        2012-12-27  546  		pr_info(" Removing ISA hole at 0x%016llx\n", isa_mb);
d3afa58c Michal Simek        2010-01-18  547  		if (next < memno)
d3afa58c Michal Simek        2010-01-18  548  			memmove(&hose->mem_resources[isa_hole],
d3afa58c Michal Simek        2010-01-18  549  				&hose->mem_resources[next],
d3afa58c Michal Simek        2010-01-18  550  				sizeof(struct resource) * (memno - next));
d3afa58c Michal Simek        2010-01-18  551  		hose->mem_resources[--memno].flags = 0;
d3afa58c Michal Simek        2010-01-18  552  	}
d3afa58c Michal Simek        2010-01-18  553  }
d3afa58c Michal Simek        2010-01-18  554  
9413d968 Bharat Kumar Gogada 2016-09-01  555  /* Display the domain number in /proc */
d3afa58c Michal Simek        2010-01-18  556  int pci_proc_domain(struct pci_bus *bus)
d3afa58c Michal Simek        2010-01-18  557  {
9413d968 Bharat Kumar Gogada 2016-09-01  558  	return pci_domain_nr(bus);
d3afa58c Michal Simek        2010-01-18  559  }
d3afa58c Michal Simek        2010-01-18  560  
d3afa58c Michal Simek        2010-01-18  561  /* This header fixup will do the resource fixup for all devices as they are
d3afa58c Michal Simek        2010-01-18  562   * probed, but not for bridge ranges
d3afa58c Michal Simek        2010-01-18  563   */
b881bc46 Greg Kroah-Hartman  2012-12-21  564  static void pcibios_fixup_resources(struct pci_dev *dev)
d3afa58c Michal Simek        2010-01-18  565  {
d3afa58c Michal Simek        2010-01-18  566  	struct pci_controller *hose = pci_bus_to_host(dev->bus);
d3afa58c Michal Simek        2010-01-18  567  	int i;
d3afa58c Michal Simek        2010-01-18  568  
d3afa58c Michal Simek        2010-01-18  569  	if (!hose) {
6bd55f0b Michal Simek        2012-12-27  570  		pr_err("No host bridge for PCI dev %s !\n",
d3afa58c Michal Simek        2010-01-18  571  		       pci_name(dev));
d3afa58c Michal Simek        2010-01-18  572  		return;
d3afa58c Michal Simek        2010-01-18  573  	}
d3afa58c Michal Simek        2010-01-18  574  	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
d3afa58c Michal Simek        2010-01-18  575  		struct resource *res = dev->resource + i;
d3afa58c Michal Simek        2010-01-18  576  		if (!res->flags)
d3afa58c Michal Simek        2010-01-18  577  			continue;
e5b36841 Bjorn Helgaas       2012-02-23  578  		if (res->start == 0) {
6bd55f0b Michal Simek        2012-12-27  579  			pr_debug("PCI:%s Resource %d %016llx-%016llx [%x]",
d3afa58c Michal Simek        2010-01-18  580  				 pci_name(dev), i,
d3afa58c Michal Simek        2010-01-18  581  				 (unsigned long long)res->start,
d3afa58c Michal Simek        2010-01-18  582  				 (unsigned long long)res->end,
d3afa58c Michal Simek        2010-01-18  583  				 (unsigned int)res->flags);
6bd55f0b Michal Simek        2012-12-27  584  			pr_debug("is unassigned\n");
d3afa58c Michal Simek        2010-01-18  585  			res->end -= res->start;
d3afa58c Michal Simek        2010-01-18  586  			res->start = 0;
d3afa58c Michal Simek        2010-01-18  587  			res->flags |= IORESOURCE_UNSET;
d3afa58c Michal Simek        2010-01-18  588  			continue;
d3afa58c Michal Simek        2010-01-18  589  		}
d3afa58c Michal Simek        2010-01-18  590  
aa23bdc0 Bjorn Helgaas       2012-02-23  591  		pr_debug("PCI:%s Resource %d %016llx-%016llx [%x]\n",
d3afa58c Michal Simek        2010-01-18  592  			 pci_name(dev), i,
6bd55f0b Michal Simek        2012-12-27  593  			 (unsigned long long)res->start,
d3afa58c Michal Simek        2010-01-18  594  			 (unsigned long long)res->end,
d3afa58c Michal Simek        2010-01-18  595  			 (unsigned int)res->flags);
d3afa58c Michal Simek        2010-01-18  596  	}
d3afa58c Michal Simek        2010-01-18  597  }
d3afa58c Michal Simek        2010-01-18  598  DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
d3afa58c Michal Simek        2010-01-18  599  
d3afa58c Michal Simek        2010-01-18  600  /*
d3afa58c Michal Simek        2010-01-18  601   * We need to avoid collisions with `mirrored' VGA ports
d3afa58c Michal Simek        2010-01-18  602   * and other strange ISA hardware, so we always want the
d3afa58c Michal Simek        2010-01-18  603   * addresses to be allocated in the 0x000-0x0ff region
d3afa58c Michal Simek        2010-01-18  604   * modulo 0x400.
d3afa58c Michal Simek        2010-01-18  605   *
d3afa58c Michal Simek        2010-01-18  606   * Why? Because some silly external IO cards only decode
d3afa58c Michal Simek        2010-01-18  607   * the low 10 bits of the IO address. The 0x00-0xff region
d3afa58c Michal Simek        2010-01-18  608   * is reserved for motherboard devices that decode all 16
d3afa58c Michal Simek        2010-01-18  609   * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
d3afa58c Michal Simek        2010-01-18  610   * but we want to try to avoid allocating at 0x2900-0x2bff
d3afa58c Michal Simek        2010-01-18  611   * which might have be mirrored at 0x0100-0x03ff..
d3afa58c Michal Simek        2010-01-18  612   */
01cf9d52 Bharat Kumar Gogada 2016-02-11  613  int pcibios_add_device(struct pci_dev *dev)
01cf9d52 Bharat Kumar Gogada 2016-02-11  614  {
01cf9d52 Bharat Kumar Gogada 2016-02-11  615  	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
c86fac43 Michal Simek        2010-04-16  616  
01cf9d52 Bharat Kumar Gogada 2016-02-11  617  	return 0;
d3afa58c Michal Simek        2010-01-18  618  }
01cf9d52 Bharat Kumar Gogada 2016-02-11  619  EXPORT_SYMBOL(pcibios_add_device);
d3afa58c Michal Simek        2010-01-18  620  
d3afa58c Michal Simek        2010-01-18  621  /*
d3afa58c Michal Simek        2010-01-18  622   * Reparent resource children of pr that conflict with res
d3afa58c Michal Simek        2010-01-18  623   * under res, and make res replace those children.
d3afa58c Michal Simek        2010-01-18  624   */
d3afa58c Michal Simek        2010-01-18  625  static int __init reparent_resources(struct resource *parent,
d3afa58c Michal Simek        2010-01-18  626  				     struct resource *res)
d3afa58c Michal Simek        2010-01-18  627  {
d3afa58c Michal Simek        2010-01-18  628  	struct resource *p, **pp;
d3afa58c Michal Simek        2010-01-18  629  	struct resource **firstpp = NULL;
d3afa58c Michal Simek        2010-01-18  630  
d3afa58c Michal Simek        2010-01-18 @631  	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
d3afa58c Michal Simek        2010-01-18  632  		if (p->end < res->start)
d3afa58c Michal Simek        2010-01-18  633  			continue;
d3afa58c Michal Simek        2010-01-18  634  		if (res->end < p->start)
d3afa58c Michal Simek        2010-01-18  635  			break;
d3afa58c Michal Simek        2010-01-18  636  		if (p->start < res->start || p->end > res->end)
d3afa58c Michal Simek        2010-01-18  637  			return -1;	/* not completely contained */
d3afa58c Michal Simek        2010-01-18  638  		if (firstpp == NULL)
d3afa58c Michal Simek        2010-01-18  639  			firstpp = pp;
d3afa58c Michal Simek        2010-01-18  640  	}
d3afa58c Michal Simek        2010-01-18  641  	if (firstpp == NULL)
d3afa58c Michal Simek        2010-01-18  642  		return -1;	/* didn't find any conflicting entries? */
d3afa58c Michal Simek        2010-01-18  643  	res->parent = parent;
d3afa58c Michal Simek        2010-01-18 @644  	res->child = *firstpp;
d3afa58c Michal Simek        2010-01-18  645  	res->sibling = *pp;
d3afa58c Michal Simek        2010-01-18  646  	*firstpp = res;
d3afa58c Michal Simek        2010-01-18  647  	*pp = NULL;
d3afa58c Michal Simek        2010-01-18 @648  	for (p = res->child; p != NULL; p = p->sibling) {
d3afa58c Michal Simek        2010-01-18  649  		p->parent = res;
d3afa58c Michal Simek        2010-01-18  650  		pr_debug("PCI: Reparented %s [%llx..%llx] under %s\n",
d3afa58c Michal Simek        2010-01-18  651  			 p->name,
d3afa58c Michal Simek        2010-01-18  652  			 (unsigned long long)p->start,
d3afa58c Michal Simek        2010-01-18  653  			 (unsigned long long)p->end, res->name);
d3afa58c Michal Simek        2010-01-18  654  	}
d3afa58c Michal Simek        2010-01-18  655  	return 0;
d3afa58c Michal Simek        2010-01-18  656  }
d3afa58c Michal Simek        2010-01-18  657  

:::::: The code at line 536 was first introduced by commit
:::::: 70dcd942dc4af3cc6c3dcc2ba499cd841c7f65a7 microblaze: Fix IO space breakage after of_pci_range_to_resource() change

:::::: TO: Michal Simek <michal.simek@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
+ZU9Wktt8x8mnUmSlMMAAA==

--d6Gm4EdcadzBjdND--
