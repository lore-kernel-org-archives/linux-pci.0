Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org,
	jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jszhang@marvell.com, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v3 3/3] pcie-designware: fix typo
Date: Tue,  2 Aug 2016 18:36:23 +0100
Message-Id: <dbad657c8d8b4566e88967bf634cc1371a389a77.1470158164.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470158164.git.jpinto@synopsys.com>
References: <cover.1470158164.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470158164.git.jpinto@synopsys.com>
References: <cover.1470158164.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

Simple fix typo.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
changes v1->v3:
- Nothing changed. Just to keep up patch set version.

 drivers/pci/host/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 3fb9036..a09455cd 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -36,7 +36,7 @@
 #define LINK_WAIT_IATU_MIN		9000
 #define LINK_WAIT_IATU_MAX		10000
 
-/* Synopsis specific PCIE configuration registers */
+/* Synopsys specific PCIE configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		(0x3f << 16)
 #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
-- 
1.8.1.5
