Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org,
	jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jszhang@marvell.com, CARLOS.PALMINHA@synopsys.com,
	MiguelFalcao.Sousa@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 2/2] pcie-designware: add core version
Date: Thu, 21 Jul 2016 10:48:36 +0100
Message-Id: <90b580a47533713167ec74c15520d2490afff49e.1469094139.git.jpinto@synopsys.com>
In-Reply-To: <cover.1469094139.git.jpinto@synopsys.com>
References: <cover.1469094139.git.jpinto@synopsys.com>
In-Reply-To: <cover.1469094139.git.jpinto@synopsys.com>
References: <cover.1469094139.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

The Core version information is available since version 4.70.
This patch adds to the driver the register and default value for new core
4.80 if needed in some future work.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/host/pcie-designware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index c673e6c..1f40288 100644
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
