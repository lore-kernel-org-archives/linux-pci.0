Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Mar 2015 22:16:21 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [pci:pci/enumeration-yw8 33/34] drivers/pci/host-bridge.c:220:6:
 sparse: symbol 'pci_host_assign_domain_nr' was not declared. Should it be
 static?
Message-ID: <201503242214.tdp6GlHv%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration-yw8
head:   4a5e3fc210d3aef19eaa32255183534aa4ac031d
commit: d72e727590caa7bd9f7e82a2cf23f6325aa3e75e [33/34] PCI: Remove pci_bus_assign_domain_nr()
reproduce:
  # apt-get install sparse
  git checkout d72e727590caa7bd9f7e82a2cf23f6325aa3e75e
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/host-bridge.c:220:6: sparse: symbol 'pci_host_assign_domain_nr' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
