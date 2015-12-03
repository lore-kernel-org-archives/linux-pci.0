Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>
Subject: [PATCH 3/3] PCI: altera: fix error when INTX is 4
Date: Thu, 3 Dec 2015 17:54:49 +0800
Message-ID: <1449136489-2559-4-git-send-email-lftan@altera.com>
In-Reply-To: <1449136489-2559-1-git-send-email-lftan@altera.com>
References: <1449136489-2559-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI interrupt lines start at 1, not at 0. So, change INTX_NUM to 5.

Error when PCIe devices have 4 INTX:
WARNING: CPU: 1 PID: 1 at kernel/irq/irqdomain.c:280
	irq_domain_associate+0x17c/0x1cc()
error: hwirq 0x4 is too large for dummy

Tested on Ethernet adapter card with multi-functions.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index e4176b3..8b30d4a 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -60,7 +60,7 @@
 #define TLP_LOOP			500
 #define RP_DEVFN			0
 
-#define INTX_NUM			4
+#define INTX_NUM			5
 
 #define DWORD_MASK			3
 
-- 
1.8.2.1

