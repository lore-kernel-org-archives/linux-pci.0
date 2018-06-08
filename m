Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7974 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbeFHPpq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 11:45:46 -0400
Date: Fri, 8 Jun 2018 23:44:49 +0800
From: kbuild test robot <lkp@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org
Subject: [pci:pci/aer-squash 12/12] drivers/pci/pcie/aer.c:1038:6: sparse:
 symbol 'aer_isr' was not declared. Should it be static?
Message-ID: <201806082323.j7tfjHHX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aer-squash
head:   8079c81ec30626bea7c07c1e4b814efbe3d81044
commit: 8079c81ec30626bea7c07c1e4b814efbe3d81044 [12/12] PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/
reproduce:
        # apt-get install sparse
        git checkout 8079c81ec30626bea7c07c1e4b814efbe3d81044
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/pcie/aer.c:1038:6: sparse: symbol 'aer_isr' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
