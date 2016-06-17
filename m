Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:3711 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755152AbcFQD4i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jun 2016 23:56:38 -0400
Date: Fri, 17 Jun 2016 11:55:29 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [pci:pci/resource 5/6] arch/powerpc/kernel/pci-common.c:587:27:
 error: passing argument 1 of 'pcibios_resource_to_bus' from incompatible
 pointer type
Message-ID: <201606171127.qMfex2eA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
head:   2ad70d5e96f3945656cfca8c005384f2a858a8c5
commit: 8549d796d788da46236d22be8da283819d5b5a12 [5/6] powerpc/pci: Implement pci_resource_to_user() with pcibios_resource_to_bus()
config: powerpc-tqm8548_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8549d796d788da46236d22be8da283819d5b5a12
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/pci-common.c: In function 'pci_resource_to_user':
>> arch/powerpc/kernel/pci-common.c:587:27: error: passing argument 1 of 'pcibios_resource_to_bus' from incompatible pointer type [-Werror=incompatible-pointer-types]
      pcibios_resource_to_bus(dev, &region, rsrc);
                              ^
   In file included from arch/powerpc/kernel/pci-common.c:20:0:
   include/linux/pci.h:804:6: note: expected 'struct pci_bus *' but argument is of type 'const struct pci_dev *'
    void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
         ^
>> arch/powerpc/kernel/pci-common.c:587:41: error: passing argument 3 of 'pcibios_resource_to_bus' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
      pcibios_resource_to_bus(dev, &region, rsrc);
                                            ^
   In file included from arch/powerpc/kernel/pci-common.c:20:0:
   include/linux/pci.h:804:6: note: expected 'struct resource *' but argument is of type 'const struct resource *'
    void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
         ^
   cc1: all warnings being treated as errors

vim +/pcibios_resource_to_bus +587 arch/powerpc/kernel/pci-common.c

   581				  const struct resource *rsrc,
   582				  resource_size_t *start, resource_size_t *end)
   583	{
   584		struct pci_bus_region region;
   585	
   586		if (rsrc->flags & IORESOURCE_IO) {
 > 587			pcibios_resource_to_bus(dev, &region, rsrc);
   588			*start = region.start;
   589			*end = region.end;
   590			return;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cNdxnHkX5QqsyA0e
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--cNdxnHkX5QqsyA0e--
