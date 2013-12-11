Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog122.obsmtp.com ([207.126.144.153]:58546 "EHLO
	eu1sys200aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751057Ab3LKKIA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 05:08:00 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, <spear-devel@list.st.com>
Subject: [PATCH 06/12] pcie: designware: Move register definition to the header file
Date: Wed, 11 Dec 2013 15:08:31 +0530
Message-ID: <7bce26f60d847a136f748b5eeac15dc79a7d662e.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

Move synopsis specific register definition from source file to header
file, so that they can be re-used by other files if needed.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: spear-devel@list.st.com
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/host/pcie-designware.c |   42 ------------------------------------
 drivers/pci/host/pcie-designware.h |   42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 212b8b6..73aa13c 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -23,48 +23,6 @@
 
 #include "pcie-designware.h"
 
-/* Synopsis specific PCIE configuration registers */
-#define PCIE_PORT_LINK_CONTROL		0x710
-#define PORT_LINK_MODE_MASK		(0x3f << 16)
-#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
-#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
-#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
-
-#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
-#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1ff << 8)
-#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
-#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
-#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
-
-#define PCIE_MSI_ADDR_LO		0x820
-#define PCIE_MSI_ADDR_HI		0x824
-#define PCIE_MSI_INTR0_ENABLE		0x828
-#define PCIE_MSI_INTR0_MASK		0x82C
-#define PCIE_MSI_INTR0_STATUS		0x830
-
-#define PCIE_ATU_VIEWPORT		0x900
-#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
-#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
-#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
-#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
-#define PCIE_ATU_CR1			0x904
-#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
-#define PCIE_ATU_TYPE_IO		(0x2 << 0)
-#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
-#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
-#define PCIE_ATU_CR2			0x908
-#define PCIE_ATU_ENABLE			(0x1 << 31)
-#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
-#define PCIE_ATU_LOWER_BASE		0x90C
-#define PCIE_ATU_UPPER_BASE		0x910
-#define PCIE_ATU_LIMIT			0x914
-#define PCIE_ATU_LOWER_TARGET		0x918
-#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
-#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
-#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
-#define PCIE_ATU_UPPER_TARGET		0x91C
-
 static struct hw_pci dw_pci;
 
 static unsigned long global_io_offset;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index c15379b..da1ed35 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -74,4 +74,46 @@ int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 
+/* Synopsis specific PCIE configuration registers */
+#define PCIE_PORT_LINK_CONTROL		0x710
+#define PORT_LINK_MODE_MASK		(0x3f << 16)
+#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
+#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
+#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
+
+#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
+#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
+#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1ff << 8)
+#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
+#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
+#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
+
+#define PCIE_MSI_ADDR_LO		0x820
+#define PCIE_MSI_ADDR_HI		0x824
+#define PCIE_MSI_INTR0_ENABLE		0x828
+#define PCIE_MSI_INTR0_MASK		0x82C
+#define PCIE_MSI_INTR0_STATUS		0x830
+
+#define PCIE_ATU_VIEWPORT		0x900
+#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
+#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
+#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
+#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
+#define PCIE_ATU_CR1			0x904
+#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
+#define PCIE_ATU_TYPE_IO		(0x2 << 0)
+#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
+#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
+#define PCIE_ATU_CR2			0x908
+#define PCIE_ATU_ENABLE			(0x1 << 31)
+#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
+#define PCIE_ATU_LOWER_BASE		0x90C
+#define PCIE_ATU_UPPER_BASE		0x910
+#define PCIE_ATU_LIMIT			0x914
+#define PCIE_ATU_LOWER_TARGET		0x918
+#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
+#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
+#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
+#define PCIE_ATU_UPPER_TARGET		0x91C
+
 #endif /* _PCIE_DESIGNWARE_H */
-- 
1.7.0.1

