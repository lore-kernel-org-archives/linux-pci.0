Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:2711 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbdJEHXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Oct 2017 03:23:23 -0400
Date: Thu, 5 Oct 2017 15:22:51 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org
Subject: [pci:pci/misc 7/9] arch/alpha/kernel/pci.c:260:3: error: implicit
 declaration of function 'pdev_save_srm_config'
Message-ID: <201710051545.NPKjjWk8%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
head:   51d7f00f1169641c5d0655a1453f2164eecd4fe0
commit: a05fa0a27a11250ff5dc9321a2e1e1feaa37d345 [7/9] alpha/PCI: Make pdev_save_srm_config() static
config: alpha-allnoconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a05fa0a27a11250ff5dc9321a2e1e1feaa37d345
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All errors (new ones prefixed by >>):

   arch/alpha/kernel/pci.c: In function 'pcibios_fixup_bus':
>> arch/alpha/kernel/pci.c:260:3: error: implicit declaration of function 'pdev_save_srm_config' [-Werror=implicit-function-declaration]
      pdev_save_srm_config(dev);
      ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pdev_save_srm_config +260 arch/alpha/kernel/pci.c

^1da177e Linus Torvalds     2005-04-16  249  
f8d6c8d9 Greg Kroah-Hartman 2012-12-21  250  void pcibios_fixup_bus(struct pci_bus *bus)
^1da177e Linus Torvalds     2005-04-16  251  {
237865f1 Bjorn Helgaas      2015-09-15  252  	struct pci_dev *dev = bus->self;
237865f1 Bjorn Helgaas      2015-09-15  253  
237865f1 Bjorn Helgaas      2015-09-15  254  	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
237865f1 Bjorn Helgaas      2015-09-15  255  	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
237865f1 Bjorn Helgaas      2015-09-15  256  		pci_read_bridge_bases(bus);
237865f1 Bjorn Helgaas      2015-09-15  257  	}
^1da177e Linus Torvalds     2005-04-16  258  
^1da177e Linus Torvalds     2005-04-16  259  	list_for_each_entry(dev, &bus->devices, bus_list) {
^1da177e Linus Torvalds     2005-04-16 @260  		pdev_save_srm_config(dev);
^1da177e Linus Torvalds     2005-04-16  261  	}
^1da177e Linus Torvalds     2005-04-16  262  }
^1da177e Linus Torvalds     2005-04-16  263  

:::::: The code at line 260 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--liOOAslEiF7prFVr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
a6K24v8Bz2Iali9FAAA=

--liOOAslEiF7prFVr--
