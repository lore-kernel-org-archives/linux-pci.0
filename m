Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8597 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbbCWSJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Mar 2015 14:09:34 -0400
Date: Tue, 24 Mar 2015 02:08:59 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [pci:pci/enumeration-yw7 32/35] drivers/pci/host-bridge.c:147:24:
 sparse: symbol 'pci_find_host_bridge' was not declared. Should it be static?
Message-ID: <201503240247.Lu2Ttzhc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration-yw7
head:   2681a1f3d2011d4cbb888d3e974a13bda85d225c
commit: 2577ed41b6a6db3117713069e49b72091b60c867 [32/35] PCI: rename to pci_find_host_bridge()
reproduce:
  # apt-get install sparse
  git checkout 2577ed41b6a6db3117713069e49b72091b60c867
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/host-bridge.c:147:24: sparse: symbol 'pci_find_host_bridge' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
