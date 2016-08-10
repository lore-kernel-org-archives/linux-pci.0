Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org
Cc: jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jszhang@marvell.com,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v4 3/3] pcie-designware: fix typo
Date: Wed, 10 Aug 2016 11:00:30 +0100
Message-Id: <e0c8020666ce92b35b0fa5896ef4ddf3fdc1ae73.1470822461.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470822461.git.jpinto@synopsys.com>
References: <cover.1470822461.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470822461.git.jpinto@synopsys.com>
References: <cover.1470822461.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

Simple fix typo.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
changes v4->v5:
- v4 patch was not done properly
changes v1->v4:
- Nothing changed. Just to keep up patch set version.

 drivers/pci/host/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index d239bc9..7731eda 100644
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
