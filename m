Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org
Cc: jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jszhang@marvell.com,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v4 1/3] pcie-designware: move definitions
Date: Tue,  9 Aug 2016 17:35:32 +0100
Message-Id: <fe7e06c25a022d49a17ece0a1ce0c7d94b338f5c.1470758382.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470758382.git.jpinto@synopsys.com>
References: <cover.1470758382.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470758382.git.jpinto@synopsys.com>
References: <cover.1470758382.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

This patch moves the sleep definitions to the *.c file like suggested
by Jisheng Zhang in a previous patch.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
CC: Jisheng Zhang <jszhang@marvell.com>
---
changes v3->v4:
- Just to keep up with the patch version
changes v2->v3 (Bjorn Helgaas):
- Separated from the new iATU unroll mechanism patch

 drivers/pci/host/pcie-designware.c | 5 +++++
 drivers/pci/host/pcie-designware.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..6fb88de 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -26,6 +26,11 @@
 
 #include "pcie-designware.h"
 
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES		10
+#define LINK_WAIT_USLEEP_MIN		90000
+#define LINK_WAIT_USLEEP_MAX		100000
+
 /* Synopsis specific PCIE configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		(0x3f << 16)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index f437f9b..384e79b 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -22,11 +22,6 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_USLEEP_MIN		90000
-#define LINK_WAIT_USLEEP_MAX		100000
-
 struct pcie_port {
 	struct device		*dev;
 	u8			root_bus_nr;
-- 
1.8.1.5
