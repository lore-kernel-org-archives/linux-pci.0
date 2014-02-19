Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:59339 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751245AbaBSMFI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 07:05:08 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <jg1.han@samsung.com>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>, <spear-devel@list.st.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 1/1] Designware:RC BARs setup related fix
Date: Wed, 19 Feb 2014 17:34:35 +0530
Message-ID: <1392811475-17744-1-git-send-email-mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Synopsys  PCIe core provides one pair of 32-bit BARs (BAR 0 and BAR 1).
The BARs can  be configured as follows:

- One 64-bit BAR: BARs 0 and 1 are combined to form a single 64-bit BAR.
- Two 32-bit BARs: BARs 0 and 1 are two independent 32-bit BARs

This patch corrects 64-bit, non-prefetchable memory BAR configuration
implemented in dw driver.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: spear-devel@list.st.com
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/host/pcie-designware.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 17ce88f..6d23d8c 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -800,7 +800,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	/* setup RC BARs */
 	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
-	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_1);
+	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
 
 	/* setup interrupt pins */
 	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
-- 
1.7.0.1

