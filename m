Return-Path: <SRS0=CMcD=H6=lip6.fr=julia.lawall@kernel.org>
Return-Path: <SRS0=CMcD=H6=lip6.fr=julia.lawall@kernel.org>
Date: Fri, 11 May 2018 07:08:24 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Jan Kiszka <jan.kiszka@siemens.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
    kbuild-all@01.org
Subject: [pci:pci/resource 8/10] drivers/pci/of.c:332:3-8: WARNING: invalid
 free of devm_ allocated data
Message-ID: <alpine.DEB.2.20.1805110706001.3191@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

The devm_kzalloc on line 324 makes the kfrees on lines 332 and 355
incorrect.  They can just be removed.

julia

---------- Forwarded message ----------
Date: Fri, 11 May 2018 10:49:38 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [pci:pci/resource 8/10] drivers/pci/of.c:332:3-8: WARNING: invalid free
     of devm_ allocated data

CC: kbuild-all@01.org
CC: linux-pci@vger.kernel.org
TO: Jan Kiszka <jan.kiszka@siemens.com>
CC: Bjorn Helgaas <helgaas@kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
head:   f2837b7a1764f7b58d2febec2fe37fb0cd99de24
commit: 67ed62eb921e31fd51c1d83ca6313b9aa3cead46 [8/10] PCI: Remove unused of_pci_get_host_bridge_resources()
:::::: branch date: 4 hours ago
:::::: commit date: 4 hours ago

>> drivers/pci/of.c:332:3-8: WARNING: invalid free of devm_ allocated data
   drivers/pci/of.c:355:1-6: WARNING: invalid free of devm_ allocated data

# https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=67ed62eb921e31fd51c1d83ca6313b9aa3cead46
git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
git remote update pci
git checkout 67ed62eb921e31fd51c1d83ca6313b9aa3cead46
vim +332 drivers/pci/of.c

4670d610d Rob Herring 2018-01-17  244
4670d610d Rob Herring 2018-01-17  245  #if defined(CONFIG_OF_ADDRESS)
67ed62eb9 Jan Kiszka  2018-05-09  246  /**
67ed62eb9 Jan Kiszka  2018-05-09  247   * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
67ed62eb9 Jan Kiszka  2018-05-09  248   *                                           host bridge resources from DT
67ed62eb9 Jan Kiszka  2018-05-09  249   * @dev: host bridge device
67ed62eb9 Jan Kiszka  2018-05-09  250   * @busno: bus number associated with the bridge root bus
67ed62eb9 Jan Kiszka  2018-05-09  251   * @bus_max: maximum number of buses for this bridge
67ed62eb9 Jan Kiszka  2018-05-09  252   * @resources: list where the range of resources will be added after DT parsing
67ed62eb9 Jan Kiszka  2018-05-09  253   * @io_base: pointer to a variable that will contain on return the physical
67ed62eb9 Jan Kiszka  2018-05-09  254   * address for the start of the I/O range. Can be NULL if the caller doesn't
67ed62eb9 Jan Kiszka  2018-05-09  255   * expect I/O ranges to be present in the device tree.
67ed62eb9 Jan Kiszka  2018-05-09  256   *
67ed62eb9 Jan Kiszka  2018-05-09  257   * This function will parse the "ranges" property of a PCI host bridge device
67ed62eb9 Jan Kiszka  2018-05-09  258   * node and setup the resource mapping based on its content. It is expected
67ed62eb9 Jan Kiszka  2018-05-09  259   * that the property conforms with the Power ePAPR document.
67ed62eb9 Jan Kiszka  2018-05-09  260   *
67ed62eb9 Jan Kiszka  2018-05-09  261   * It returns zero if the range parsing has been successful or a standard error
67ed62eb9 Jan Kiszka  2018-05-09  262   * value if it failed.
67ed62eb9 Jan Kiszka  2018-05-09  263   */
67ed62eb9 Jan Kiszka  2018-05-09  264  int devm_of_pci_get_host_bridge_resources(struct device *dev,
4670d610d Rob Herring 2018-01-17  265  			unsigned char busno, unsigned char bus_max,
4670d610d Rob Herring 2018-01-17  266  			struct list_head *resources, resource_size_t *io_base)
4670d610d Rob Herring 2018-01-17  267  {
67ed62eb9 Jan Kiszka  2018-05-09  268  	struct device_node *dev_node = dev->of_node;
4670d610d Rob Herring 2018-01-17  269  	struct resource_entry *window;
4670d610d Rob Herring 2018-01-17  270  	struct resource *res;
4670d610d Rob Herring 2018-01-17  271  	struct resource *bus_range;
4670d610d Rob Herring 2018-01-17  272  	struct of_pci_range range;
4670d610d Rob Herring 2018-01-17  273  	struct of_pci_range_parser parser;
4670d610d Rob Herring 2018-01-17  274  	char range_type[4];
4670d610d Rob Herring 2018-01-17  275  	int err;
4670d610d Rob Herring 2018-01-17  276
4670d610d Rob Herring 2018-01-17  277  	if (io_base)
4670d610d Rob Herring 2018-01-17  278  		*io_base = (resource_size_t)OF_BAD_ADDR;
4670d610d Rob Herring 2018-01-17  279
07adab611 Jan Kiszka  2018-04-30  280  	bus_range = devm_kzalloc(dev,sizeof(*bus_range), GFP_KERNEL);
4670d610d Rob Herring 2018-01-17  281  	if (!bus_range)
4670d610d Rob Herring 2018-01-17  282  		return -ENOMEM;
4670d610d Rob Herring 2018-01-17  283
877a66649 Jan Kiszka  2018-04-30  284  	dev_info(dev, "host bridge %pOF ranges:\n", dev_node);
4670d610d Rob Herring 2018-01-17  285
08c1b3b10 Jan Kiszka  2018-04-30  286  	err = of_pci_parse_bus_range(dev_node, bus_range);
4670d610d Rob Herring 2018-01-17  287  	if (err) {
4670d610d Rob Herring 2018-01-17  288  		bus_range->start = busno;
4670d610d Rob Herring 2018-01-17  289  		bus_range->end = bus_max;
4670d610d Rob Herring 2018-01-17  290  		bus_range->flags = IORESOURCE_BUS;
877a66649 Jan Kiszka  2018-04-30  291  		dev_info(dev, "  No bus range found for %pOF, using %pR\n",
08c1b3b10 Jan Kiszka  2018-04-30  292  			 dev_node, bus_range);
4670d610d Rob Herring 2018-01-17  293  	} else {
4670d610d Rob Herring 2018-01-17  294  		if (bus_range->end > bus_range->start + bus_max)
4670d610d Rob Herring 2018-01-17  295  			bus_range->end = bus_range->start + bus_max;
4670d610d Rob Herring 2018-01-17  296  	}
4670d610d Rob Herring 2018-01-17  297  	pci_add_resource(resources, bus_range);
4670d610d Rob Herring 2018-01-17  298
4670d610d Rob Herring 2018-01-17  299  	/* Check for ranges property */
08c1b3b10 Jan Kiszka  2018-04-30  300  	err = of_pci_range_parser_init(&parser, dev_node);
4670d610d Rob Herring 2018-01-17  301  	if (err)
4670d610d Rob Herring 2018-01-17  302  		goto parse_failed;
4670d610d Rob Herring 2018-01-17  303
877a66649 Jan Kiszka  2018-04-30  304  	dev_dbg(dev, "Parsing ranges property...\n");
4670d610d Rob Herring 2018-01-17  305  	for_each_of_pci_range(&parser, &range) {
4670d610d Rob Herring 2018-01-17  306  		/* Read next ranges element */
4670d610d Rob Herring 2018-01-17  307  		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
4670d610d Rob Herring 2018-01-17  308  			snprintf(range_type, 4, " IO");
4670d610d Rob Herring 2018-01-17  309  		else if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
4670d610d Rob Herring 2018-01-17  310  			snprintf(range_type, 4, "MEM");
4670d610d Rob Herring 2018-01-17  311  		else
4670d610d Rob Herring 2018-01-17  312  			snprintf(range_type, 4, "err");
877a66649 Jan Kiszka  2018-04-30  313  		dev_info(dev, "  %s %#010llx..%#010llx -> %#010llx\n",
877a66649 Jan Kiszka  2018-04-30  314  			 range_type, range.cpu_addr,
877a66649 Jan Kiszka  2018-04-30  315  			 range.cpu_addr + range.size - 1, range.pci_addr);
4670d610d Rob Herring 2018-01-17  316
4670d610d Rob Herring 2018-01-17  317  		/*
4670d610d Rob Herring 2018-01-17  318  		 * If we failed translation or got a zero-sized region
4670d610d Rob Herring 2018-01-17  319  		 * then skip this range
4670d610d Rob Herring 2018-01-17  320  		 */
4670d610d Rob Herring 2018-01-17  321  		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
4670d610d Rob Herring 2018-01-17  322  			continue;
4670d610d Rob Herring 2018-01-17  323
67ed62eb9 Jan Kiszka  2018-05-09  324  		res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
4670d610d Rob Herring 2018-01-17  325  		if (!res) {
4670d610d Rob Herring 2018-01-17  326  			err = -ENOMEM;
4670d610d Rob Herring 2018-01-17  327  			goto parse_failed;
4670d610d Rob Herring 2018-01-17  328  		}
4670d610d Rob Herring 2018-01-17  329
08c1b3b10 Jan Kiszka  2018-04-30  330  		err = of_pci_range_to_resource(&range, dev_node, res);
4670d610d Rob Herring 2018-01-17  331  		if (err) {
4670d610d Rob Herring 2018-01-17 @332  			kfree(res);
4670d610d Rob Herring 2018-01-17  333  			continue;
4670d610d Rob Herring 2018-01-17  334  		}
4670d610d Rob Herring 2018-01-17  335
4670d610d Rob Herring 2018-01-17  336  		if (resource_type(res) == IORESOURCE_IO) {
4670d610d Rob Herring 2018-01-17  337  			if (!io_base) {
877a66649 Jan Kiszka  2018-04-30  338  				dev_err(dev, "I/O range found for %pOF. Please provide an io_base pointer to save CPU base address\n",
08c1b3b10 Jan Kiszka  2018-04-30  339  					dev_node);
4670d610d Rob Herring 2018-01-17  340  				err = -EINVAL;
4670d610d Rob Herring 2018-01-17  341  				goto conversion_failed;
4670d610d Rob Herring 2018-01-17  342  			}
4670d610d Rob Herring 2018-01-17  343  			if (*io_base != (resource_size_t)OF_BAD_ADDR)
877a66649 Jan Kiszka  2018-04-30  344  				dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
08c1b3b10 Jan Kiszka  2018-04-30  345  					 dev_node);
4670d610d Rob Herring 2018-01-17  346  			*io_base = range.cpu_addr;
4670d610d Rob Herring 2018-01-17  347  		}
4670d610d Rob Herring 2018-01-17  348
4670d610d Rob Herring 2018-01-17  349  		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
4670d610d Rob Herring 2018-01-17  350  	}
4670d610d Rob Herring 2018-01-17  351
4670d610d Rob Herring 2018-01-17  352  	return 0;
4670d610d Rob Herring 2018-01-17  353
4670d610d Rob Herring 2018-01-17  354  conversion_failed:
4670d610d Rob Herring 2018-01-17  355  	kfree(res);
4670d610d Rob Herring 2018-01-17  356  parse_failed:
4670d610d Rob Herring 2018-01-17  357  	resource_list_for_each_entry(window, resources)
4670d610d Rob Herring 2018-01-17  358  		kfree(window->res);
4670d610d Rob Herring 2018-01-17  359  	pci_free_resource_list(resources);
4670d610d Rob Herring 2018-01-17  360  	return err;
4670d610d Rob Herring 2018-01-17  361  }
83d525c0f Jan Kiszka  2018-04-30  362  EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
4670d610d Rob Herring 2018-01-17  363  #endif /* CONFIG_OF_ADDRESS */
4670d610d Rob Herring 2018-01-17  364

:::::: The code at line 332 was first introduced by commit
:::::: 4670d610d59233b017a6ea1fa25bbf06dabbff42 PCI: Move OF-related PCI functions into PCI core

:::::: TO: Rob Herring <robh@kernel.org>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
