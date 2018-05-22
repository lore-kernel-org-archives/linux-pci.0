Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53554 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbeEVByI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 May 2018 21:54:08 -0400
Date: Tue, 22 May 2018 09:53:21 +0800
From: kbuild test robot <lkp@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org
Subject: [pci:pci/sparc 4/8] arch/sparc/kernel/pcic.c:668:53: error:
 'old_cmd' undeclared; did you mean 'oldcmd'?
Message-ID: <201805220917.MIqt7nxj%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/sparc
head:   bcc2b2c282ef2234b183d979f0cac647231b5ce2
commit: 2b625e33479aa77d59fb39fc90bd024f0069583a [4/8] sparc/PCI: Use dev_printk() when possible
config: sparc-defconfig (attached as .config)
compiler: sparc-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2b625e33479aa77d59fb39fc90bd024f0069583a
        # save the attached .config to linux build tree
        make.cross ARCH=sparc 

All error/warnings (new ones prefixed by >>):

   arch/sparc/kernel/pcic.c: In function 'pcibios_fixup_bus':
   arch/sparc/kernel/pcic.c:606:15: error: unused variable 'cmd' [-Werror=unused-variable]
     unsigned int cmd = 0;
                  ^~~
   arch/sparc/kernel/pcic.c:605:17: error: unused variable 'has_mem' [-Werror=unused-variable]
     int i, has_io, has_mem;
                    ^~~~~~~
   arch/sparc/kernel/pcic.c:605:9: error: unused variable 'has_io' [-Werror=unused-variable]
     int i, has_io, has_mem;
            ^~~~~~
   arch/sparc/kernel/pcic.c:605:6: error: unused variable 'i' [-Werror=unused-variable]
     int i, has_io, has_mem;
         ^
   In file included from include/linux/pci.h:31:0,
                    from arch/sparc/kernel/pcic.c:25:
   arch/sparc/kernel/pcic.c: In function 'pcibios_enable_device':
>> arch/sparc/kernel/pcic.c:668:53: error: 'old_cmd' undeclared (first use in this function); did you mean 'oldcmd'?
      pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
                                                        ^
   include/linux/device.h:1382:58: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                             ^~~
>> arch/sparc/kernel/pcic.c:668:3: note: in expansion of macro 'pci_info'
      pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
      ^~~~~~~~
   arch/sparc/kernel/pcic.c:668:53: note: each undeclared identifier is reported only once for each function it appears in
      pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
                                                        ^
   include/linux/device.h:1382:58: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                             ^~~
>> arch/sparc/kernel/pcic.c:668:3: note: in expansion of macro 'pci_info'
      pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
      ^~~~~~~~
   arch/sparc/kernel/pcic.c: At top level:
   arch/sparc/kernel/pcic.c:746:5: error: redefinition of 'pcibios_enable_device'
    int pcibios_enable_device(struct pci_dev *pdev, int mask)
        ^~~~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/pcic.c:646:5: note: previous definition of 'pcibios_enable_device' was here
    int pcibios_enable_device(struct pci_dev *dev, int mask)
        ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +668 arch/sparc/kernel/pcic.c

   598	
   599	/*
   600	 * Normally called from {do_}pci_scan_bus...
   601	 */
   602	void pcibios_fixup_bus(struct pci_bus *bus)
   603	{
   604		struct pci_dev *dev;
 > 605		int i, has_io, has_mem;
   606		unsigned int cmd = 0;
   607		struct linux_pcic *pcic;
   608		/* struct linux_pbm_info* pbm = &pcic->pbm; */
   609		int node;
   610		struct pcidev_cookie *pcp;
   611	
   612		if (!pcic0_up) {
   613			pci_info(bus, "pcibios_fixup_bus: no PCIC\n");
   614			return;
   615		}
   616		pcic = &pcic0;
   617	
   618		/*
   619		 * Next crud is an equivalent of pbm = pcic_bus_to_pbm(bus);
   620		 */
   621		if (bus->number != 0) {
   622			pci_info(bus, "pcibios_fixup_bus: nonzero bus 0x%x\n",
   623				 bus->number);
   624			return;
   625		}
   626	
   627		list_for_each_entry(dev, &bus->devices, bus_list) {
   628			node = pdev_to_pnode(&pcic->pbm, dev);
   629			if(node == 0)
   630				node = -1;
   631	
   632			/* cookies */
   633			pcp = pci_devcookie_alloc();
   634			pcp->pbm = &pcic->pbm;
   635			pcp->prom_node = of_find_node_by_phandle(node);
   636			dev->sysdata = pcp;
   637	
   638			/* fixing I/O to look like memory */
   639			if ((dev->class>>16) != PCI_BASE_CLASS_BRIDGE)
   640				pcic_map_pci_device(pcic, dev, node);
   641	
   642			pcic_fill_irq(pcic, dev, node);
   643		}
   644	}
   645	
   646	int pcibios_enable_device(struct pci_dev *dev, int mask)
   647	{
   648		u16 cmd, oldcmd;
   649		int i;
   650	
   651		pci_read_config_word(dev, PCI_COMMAND, &cmd);
   652		oldcmd = cmd;
   653	
   654		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
   655			struct resource *res = &dev->resource[i];
   656	
   657			/* Only set up the requested stuff */
   658			if (!(mask & (1<<i)))
   659				continue;
   660	
   661			if (res->flags & IORESOURCE_IO)
   662				cmd |= PCI_COMMAND_IO;
   663			if (res->flags & IORESOURCE_MEM)
   664				cmd |= PCI_COMMAND_MEMORY;
   665		}
   666	
   667		if (cmd != oldcmd) {
 > 668			pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
   669			pci_write_config_word(dev, PCI_COMMAND, cmd);
   670		}
   671		return 0;
   672	}
   673	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
xpBAQExWDUuUGI1uzWTSKJOx6f//9CS37pqzAAA=

--M9NhX3UHpAaciwkO--
