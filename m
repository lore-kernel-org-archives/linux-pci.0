Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Feb 2015 09:06:19 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [pci:pci/enumeration 21/30] drivers/pci/pci.c:111:15: sparse: symbol
 'pci_bus_max_busnr' was not declared. Should it be static?
Message-ID: <201502270911.8Duq6eJc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
head:   84dad4dda42cbf93ecf029c5a6b0af35305d6f75
commit: 762f920d602e28bf32d27003c93ca05244957aff [21/30] PCI: Introduce pci_bus_child_max_busnr()
reproduce:
  # apt-get install sparse
  git checkout 762f920d602e28bf32d27003c93ca05244957aff
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/pci.c:111:15: sparse: symbol 'pci_bus_max_busnr' was not declared. Should it be static?
   drivers/pci/pci.c:579:13: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:579:21: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:579:31: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:579:39: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:586:35: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:586:54: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:587:19: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:587:37: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:609:23: sparse: invalid assignment: |=
   drivers/pci/pci.c:609:23:    left side has type unsigned short
   drivers/pci/pci.c:609:23:    right side has type restricted pci_power_t
   drivers/pci/pci.c:614:57: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:634:28: sparse: incorrect type in assignment (different base types)
   drivers/pci/pci.c:634:28:    expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:634:28:    got int
   drivers/pci/pci.c:683:36: sparse: incorrect type in assignment (different base types)
   drivers/pci/pci.c:683:36:    expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:683:36:    got int
   drivers/pci/pci.c:810:13: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:810:22: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:840:13: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:840:21: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:842:18: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:842:26: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:860:13: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:860:22: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:867:46: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:867:54: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1309:36: sparse: incorrect type in assignment (different base types)
   drivers/pci/pci.c:1309:36:    expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1309:36:    got int
   drivers/pci/pci.c:1685:44: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1920:61: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1921:45: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:3265:13: sparse: invalid assignment: |=
   drivers/pci/pci.c:3265:13:    left side has type unsigned short
   drivers/pci/pci.c:3265:13:    right side has type restricted pci_power_t
   drivers/pci/pci.c:3270:13: sparse: invalid assignment: |=
   drivers/pci/pci.c:3270:13:    left side has type unsigned short
   drivers/pci/pci.c:3270:13:    right side has type restricted pci_power_t
   drivers/pci/pci.c:4501:1: sparse: symbol 'bus_attr_resource_alignment' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
