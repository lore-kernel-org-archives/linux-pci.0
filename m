Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org,
	jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jszhang@marvell.com, CARLOS.PALMINHA@synopsys.com,
	MiguelFalcao.Sousa@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 2/2] pcie-designware: add core version
Date: Fri, 22 Jul 2016 14:29:39 +0100
Message-Id: <17d796c59a2b63a494d1695a4d04ed6fc9f93c0c.1469193895.git.jpinto@synopsys.com>
In-Reply-To: <cover.1469193895.git.jpinto@synopsys.com>
References: <cover.1469193895.git.jpinto@synopsys.com>
In-Reply-To: <cover.1469193895.git.jpinto@synopsys.com>
References: <cover.1469193895.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
changes v1->v2:
- Nothing changed. Just to keep up the patch set version.

 drivers/pci/host/pcie-designware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 9135725..3e4c600 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -34,6 +34,10 @@
 #define LINK_WAIT_IATU_MIN		9000
 #define LINK_WAIT_IATU_MAX		10000
 
+/* Core version (available from core 4.70) */
+#define PCIE_CORE_VERSION		0x8F8
+#define PCIE_CORE_VERSION_480A		0x3438302a
+
 /* Synopsys specific PCIE configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		(0x3f << 16)
-- 
1.8.1.5
