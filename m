Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:33317 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781AbaB0GB6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 01:01:58 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <bhelgaas@google.com>
Cc: Mohit Kumar <mohit.kumar@st.com>, <spear-devel@list.st.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH V2 1/2] PCI: designware: Fix comment for setting number of lanes
Date: Thu, 27 Feb 2014 11:31:27 +0530
Message-ID: <60f5de0e4513e1a55c51c3c80c3a51cf595dbe59.1392904207.git.mohit.kumar@st.com>
In-Reply-To: <cover.1392904207.git.mohit.kumar@st.com>
References: <cover.1392904207.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Corrects comment for setting number of lanes.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: spear-devel@list.st.com
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/host/pcie-designware.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 6d23d8c..391966f 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -766,7 +766,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	u32 membase;
 	u32 memlimit;
 
-	/* set the number of lines as 4 */
+	/* set the number of lanes */
 	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
 	val &= ~PORT_LINK_MODE_MASK;
 	switch (pp->lanes) {
-- 
1.7.3.4

