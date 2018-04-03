Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:51368 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754924AbeDCIWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2018 04:22:24 -0400
Date: Tue, 3 Apr 2018 11:08:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@01.org, Tal Gilboa <talgi@mellanox.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [pci:pci/enumeration 5/15] drivers/pci/pci.c:5190
 pcie_bandwidth_available() warn: variable dereferenced before check 'speed'
 (see line 5171)
Message-ID: <20180403080803.o37a2effl4cmiqkd@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
head:   4ca0362aafeb3b357f85ae3121328edbf979fc9a
commit: a88de411b5ed7ff28f3cac96581eb3b5d5bf8b61 [5/15] PCI: Add pcie_bandwidth_available() to compute bandwidth available to device

smatch warnings:
drivers/pci/pci.c:5190 pcie_bandwidth_available() warn: variable dereferenced before check 'speed' (see line 5171)
drivers/pci/pci.c:5192 pcie_bandwidth_available() warn: variable dereferenced before check 'width' (see line 5172)

# https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=a88de411b5ed7ff28f3cac96581eb3b5d5bf8b61
git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
git remote update pci
git checkout a88de411b5ed7ff28f3cac96581eb3b5d5bf8b61
vim +/speed +5190 drivers/pci/pci.c

81377c8d Jacob Keller 2013-07-31  5148  
81377c8d Jacob Keller 2013-07-31  5149  /**
a88de411 Tal Gilboa   2018-03-30  5150   * pcie_bandwidth_available - determine minimum link settings of a PCIe
a88de411 Tal Gilboa   2018-03-30  5151   *			      device and its bandwidth limitation
a88de411 Tal Gilboa   2018-03-30  5152   * @dev: PCI device to query
a88de411 Tal Gilboa   2018-03-30  5153   * @limiting_dev: storage for device causing the bandwidth limitation
a88de411 Tal Gilboa   2018-03-30  5154   * @speed: storage for speed of limiting device
a88de411 Tal Gilboa   2018-03-30  5155   * @width: storage for width of limiting device
a88de411 Tal Gilboa   2018-03-30  5156   *
a88de411 Tal Gilboa   2018-03-30  5157   * Walk up the PCI device chain and find the point where the minimum
a88de411 Tal Gilboa   2018-03-30  5158   * bandwidth is available.  Return the bandwidth available there and (if
a88de411 Tal Gilboa   2018-03-30  5159   * limiting_dev, speed, and width pointers are supplied) information about
a88de411 Tal Gilboa   2018-03-30  5160   * that point.
a88de411 Tal Gilboa   2018-03-30  5161   */
a88de411 Tal Gilboa   2018-03-30  5162  u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
a88de411 Tal Gilboa   2018-03-30  5163  			     enum pci_bus_speed *speed,
a88de411 Tal Gilboa   2018-03-30  5164  			     enum pcie_link_width *width)
a88de411 Tal Gilboa   2018-03-30  5165  {
a88de411 Tal Gilboa   2018-03-30  5166  	u16 lnksta;
a88de411 Tal Gilboa   2018-03-30  5167  	enum pci_bus_speed next_speed;
a88de411 Tal Gilboa   2018-03-30  5168  	enum pcie_link_width next_width;
a88de411 Tal Gilboa   2018-03-30  5169  	u32 bw, next_bw;
a88de411 Tal Gilboa   2018-03-30  5170  
a88de411 Tal Gilboa   2018-03-30 @5171  	*speed = PCI_SPEED_UNKNOWN;
a88de411 Tal Gilboa   2018-03-30 @5172  	*width = PCIE_LNK_WIDTH_UNKNOWN;
                                                ^^^^^^
a88de411 Tal Gilboa   2018-03-30  5173  	bw = 0;
a88de411 Tal Gilboa   2018-03-30  5174  
a88de411 Tal Gilboa   2018-03-30  5175  	while (dev) {
a88de411 Tal Gilboa   2018-03-30  5176  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
a88de411 Tal Gilboa   2018-03-30  5177  
a88de411 Tal Gilboa   2018-03-30  5178  		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
a88de411 Tal Gilboa   2018-03-30  5179  		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
a88de411 Tal Gilboa   2018-03-30  5180  			PCI_EXP_LNKSTA_NLW_SHIFT;
a88de411 Tal Gilboa   2018-03-30  5181  
a88de411 Tal Gilboa   2018-03-30  5182  		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
a88de411 Tal Gilboa   2018-03-30  5183  
a88de411 Tal Gilboa   2018-03-30  5184  		/* Check if current device limits the total bandwidth */
a88de411 Tal Gilboa   2018-03-30  5185  		if (!bw || next_bw <= bw) {
a88de411 Tal Gilboa   2018-03-30  5186  			bw = next_bw;
a88de411 Tal Gilboa   2018-03-30  5187  
a88de411 Tal Gilboa   2018-03-30  5188  			if (limiting_dev)
a88de411 Tal Gilboa   2018-03-30  5189  				*limiting_dev = dev;
a88de411 Tal Gilboa   2018-03-30 @5190  			if (speed)
a88de411 Tal Gilboa   2018-03-30  5191  				*speed = next_speed;
a88de411 Tal Gilboa   2018-03-30 @5192  			if (width)
                                                                    ^^^^^
a88de411 Tal Gilboa   2018-03-30  5193  				*width = next_width;
a88de411 Tal Gilboa   2018-03-30  5194  		}
a88de411 Tal Gilboa   2018-03-30  5195  
a88de411 Tal Gilboa   2018-03-30  5196  		dev = pci_upstream_bridge(dev);
a88de411 Tal Gilboa   2018-03-30  5197  	}
a88de411 Tal Gilboa   2018-03-30  5198  
a88de411 Tal Gilboa   2018-03-30  5199  	return bw;
a88de411 Tal Gilboa   2018-03-30  5200  }
a88de411 Tal Gilboa   2018-03-30  5201  EXPORT_SYMBOL(pcie_bandwidth_available);
a88de411 Tal Gilboa   2018-03-30  5202  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
