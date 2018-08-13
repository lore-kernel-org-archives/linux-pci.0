Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48711 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbeHMLvo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Aug 2018 07:51:44 -0400
Date: Mon, 13 Aug 2018 17:09:32 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [RFC PATCH] PCI: xilinx-nwl: nwl_setup_service_irqs() can be static
Message-ID: <20180813090932.GA33035@ivb42>
References: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Fixes: 19cbd2e19134 ("PCI: xilinx-nwl: Add method to setup_platform_service_irq hook")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 pcie-xilinx-nwl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 285647b..af07db8 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -820,8 +820,8 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	return 0;
 }
 
-int nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
-			   int plat_mask)
+static int nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
+				  int plat_mask)
 {
 	struct nwl_pcie *pcie;
 
