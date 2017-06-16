Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] MAINTAINERS: Add an entry for MediaTek PCIe driver
Date: Fri, 16 Jun 2017 12:53:09 +0800
Message-ID: <1497588789-28607-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add MediaTek PCIe driver maintainer entry.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b..736648e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9957,6 +9957,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/pci-thunder-*
 F:	drivers/pci/host/pci-thunder-*
 
+PCIE DRIVER FOR MEDIATEK
+M:      Ryder Lee <ryder.lee@mediatek.com>
+L:      linux-pci@vger.kernel.org
+L:      linux-mediatek@lists.infradead.org
+S:      Supported
+F:      Documentation/devicetree/bindings/pci/mediatek*
+F:      drivers/pci/host/*mediatek*
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
-- 
1.9.1
