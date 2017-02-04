Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34890 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753138AbdBDBg0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 20:36:26 -0500
Date: Sat, 4 Feb 2017 09:35:31 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [pci:pci/host-designware 2/6] drivers/pci/dwc/pcie-qcom.c:215:1-3:
 WARNING: PTR_ERR_OR_ZERO can be used
Message-ID: <201702040917.XTwXdmmt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-designware
head:   ac4108c530acc8f1c964a8b1c04d4523d026fd29
commit: 2b5839db931bcc499fe85e843297f1518385780a [2/6] PCI: dwc: Add COMPILE_TEST to all DesignWare-based drivers


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/dwc/pcie-qcom.c:215:1-3: WARNING: PTR_ERR_OR_ZERO can be used
   drivers/pci/dwc/pcie-qcom.c:247:1-3: WARNING: PTR_ERR_OR_ZERO can be used
   drivers/pci/dwc/pcie-qcom.c:481:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
