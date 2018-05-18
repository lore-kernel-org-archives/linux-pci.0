Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46525 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbeERTnA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 May 2018 15:43:00 -0400
Date: Sat, 19 May 2018 03:42:27 +0800
From: kbuild test robot <lkp@intel.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [pci:next 15/20] drivers/pci/host/pcie-altera.c:496:53: sparse:
 incompatible types for operation (&)
Message-ID: <201805190321.nss6j8Jn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
head:   f8d3ac43d8cd4cfba337a50794c26c7ca89d86ac
commit: 927da40afdbd6a5fdd31eab6e9aa655dee1f99a4 [15/20] Merge branch 'lorenzo/pci/host/misc'
reproduce:
        # apt-get install sparse
        git checkout 927da40afdbd6a5fdd31eab6e9aa655dee1f99a4
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/host/pcie-altera.c:496:53: sparse: incompatible types for operation (&)
   drivers/pci/host/pcie-altera.c:496:53:    left side has type int
   drivers/pci/host/pcie-altera.c:496:53:    right side has type struct list_head resources
>> drivers/pci/host/pcie-altera.c:495:52: sparse: not enough arguments for function devm_of_pci_get_host_bridge_resources
   drivers/pci/host/pcie-altera.c: In function 'altera_pcie_parse_request_of_pci_ranges':
   drivers/pci/host/pcie-altera.c:496:11: error: invalid operands to binary & (have 'int' and 'struct list_head')
              &pcie->resources, NULL);
              ^~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-altera.c:495:8: error: too few arguments to function 'devm_of_pci_get_host_bridge_resources'
     err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pci/host/pcie-altera.c:20:0:
   drivers/pci/host/../pci.h:443:5: note: declared here
    int devm_of_pci_get_host_bridge_resources(struct device *dev,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> /kbuild/src/sparse/drivers/pci/host/pcie-altera.c:496:53: sparse: incompatible types for operation (&)
   /kbuild/src/sparse/drivers/pci/host/pcie-altera.c:496:53:    left side has type int
   /kbuild/src/sparse/drivers/pci/host/pcie-altera.c:496:53:    right side has type struct list_head resources
>> /kbuild/src/sparse/drivers/pci/host/pcie-altera.c:495:52: sparse: not enough arguments for function devm_of_pci_get_host_bridge_resources
   /kbuild/src/sparse/drivers/pci/host/pcie-altera.c: In function 'altera_pcie_parse_request_of_pci_ranges':
   /kbuild/src/sparse/drivers/pci/host/pcie-altera.c:496:11: error: invalid operands to binary & (have 'int' and 'struct list_head')
              &pcie->resources, NULL);
              ^~~~~~~~~~~~~~~~
   /kbuild/src/sparse/drivers/pci/host/pcie-altera.c:495:8: error: too few arguments to function 'devm_of_pci_get_host_bridge_resources'
     err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from /kbuild/src/sparse/drivers/pci/host/pcie-altera.c:20:0:
   /kbuild/src/sparse/drivers/pci/host/../pci.h:443:5: note: declared here
    int devm_of_pci_get_host_bridge_resources(struct device *dev,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   /kbuild/src/sparse/drivers/pci/host/pcie-rockchip-host.c:996:15: sparse: undefined identifier 'devm_of_pci_get_host_bridge_resources'
>> /kbuild/src/sparse/drivers/pci/host/pcie-rockchip-host.c:996:52: sparse: call with no type!
   /kbuild/src/sparse/drivers/pci/host/pcie-rockchip-host.c: In function 'rockchip_pcie_probe':
   /kbuild/src/sparse/drivers/pci/host/pcie-rockchip-host.c:996:8: error: implicit declaration of function 'devm_of_pci_get_host_bridge_resources'; did you mean 'pci_get_host_bridge_device'? [-Werror=implicit-function-declaration]
     err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           pci_get_host_bridge_device
   cc1: some warnings being treated as errors

vim +496 drivers/pci/host/pcie-altera.c

eaa6111b Ley Foon Tan  2015-10-23  488  
eaa6111b Ley Foon Tan  2015-10-23  489  static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
eaa6111b Ley Foon Tan  2015-10-23  490  {
eaa6111b Ley Foon Tan  2015-10-23  491  	int err, res_valid = 0;
eaa6111b Ley Foon Tan  2015-10-23  492  	struct device *dev = &pcie->pdev->dev;
eaa6111b Ley Foon Tan  2015-10-23  493  	struct resource_entry *win;
eaa6111b Ley Foon Tan  2015-10-23  494  
d96b407b Jan Kiszka    2018-05-15 @495  	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff
88e3909a Jan Kiszka    2018-05-15 @496  						    &pcie->resources, NULL);
eaa6111b Ley Foon Tan  2015-10-23  497  	if (err)
eaa6111b Ley Foon Tan  2015-10-23  498  		return err;
eaa6111b Ley Foon Tan  2015-10-23  499  
74462284 Bjorn Helgaas 2016-05-31  500  	err = devm_request_pci_bus_resources(dev, &pcie->resources);
74462284 Bjorn Helgaas 2016-05-31  501  	if (err)
74462284 Bjorn Helgaas 2016-05-31  502  		goto out_release_res;
74462284 Bjorn Helgaas 2016-05-31  503  
eaa6111b Ley Foon Tan  2015-10-23  504  	resource_list_for_each_entry(win, &pcie->resources) {
74462284 Bjorn Helgaas 2016-05-31  505  		struct resource *res = win->res;
eaa6111b Ley Foon Tan  2015-10-23  506  
ba4f6d92 Bjorn Helgaas 2016-05-28  507  		if (resource_type(res) == IORESOURCE_MEM)
eaa6111b Ley Foon Tan  2015-10-23  508  			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
eaa6111b Ley Foon Tan  2015-10-23  509  	}
eaa6111b Ley Foon Tan  2015-10-23  510  
ba4f6d92 Bjorn Helgaas 2016-05-28  511  	if (res_valid)
ba4f6d92 Bjorn Helgaas 2016-05-28  512  		return 0;
ba4f6d92 Bjorn Helgaas 2016-05-28  513  
eaa6111b Ley Foon Tan  2015-10-23  514  	dev_err(dev, "non-prefetchable memory resource required\n");
eaa6111b Ley Foon Tan  2015-10-23  515  	err = -EINVAL;
eaa6111b Ley Foon Tan  2015-10-23  516  
eaa6111b Ley Foon Tan  2015-10-23  517  out_release_res:
ba4f6d92 Bjorn Helgaas 2016-05-28  518  	pci_free_resource_list(&pcie->resources);
eaa6111b Ley Foon Tan  2015-10-23  519  	return err;
eaa6111b Ley Foon Tan  2015-10-23  520  }
eaa6111b Ley Foon Tan  2015-10-23  521  

:::::: The code at line 496 was first introduced by commit
:::::: 88e3909aa1253bb4d41a54d7f4c851d52a470a3a PCI: Pass struct device to of_pci_get_host_bridge_resources()

:::::: TO: Jan Kiszka <jan.kiszka@siemens.com>
:::::: CC: Bjorn Helgaas <helgaas@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
