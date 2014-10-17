Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0124.outbound.protection.outlook.com ([65.55.169.124]:42144
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752279AbaJQJOd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Oct 2014 05:14:33 -0400
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 13/16] usb: dwc3: add lfps filter quirk
Date: Fri, 17 Oct 2014 16:53:38 +0800
Message-ID: <1413536021-4886-14-git-send-email-ray.huang@amd.com>
In-Reply-To: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AMD NL needs to enable lfps filter quirk.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 3 +++
 drivers/usb/dwc3/core.h          | 1 +
 drivers/usb/dwc3/dwc3-pci.c      | 3 ++-
 drivers/usb/dwc3/platform_data.h | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 920a8ab..a1ee586 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -386,6 +386,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->quirks & DWC3_QUIRK_DEPOCHANGE)
 		reg |= DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
+	if (dwc->quirks & DWC3_QUIRK_LFPSFILT)
+		reg |= DWC3_GUSB3PIPECTL_LFPSFILT;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4c0200f..5bdd5f5 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -182,6 +182,7 @@
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEPOCHANGE	(1 << 18)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
+#define DWC3_GUSB3PIPECTL_LFPSFILT	(1 << 9)
 
 /* Global TX Fifo Size Register */
 #define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 0eb8b2a..d1f0901 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -154,7 +154,8 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 			| DWC3_QUIRK_U2SSINP3OK
 			| DWC3_QUIRK_REQP1P2P3
 			| DWC3_QUIRK_DEPP1P2P3
-			| DWC3_QUIRK_DEPOCHANGE;
+			| DWC3_QUIRK_DEPOCHANGE
+			| DWC3_QUIRK_LFPSFILT;
 	}
 
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 934c5e1..ac7860ab 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -35,5 +35,6 @@ struct dwc3_platform_data {
 #define DWC3_QUIRK_REQP1P2P3		(1 << 4)
 #define DWC3_QUIRK_DEPP1P2P3		(1 << 5)
 #define DWC3_QUIRK_DEPOCHANGE		(1 << 6)
+#define DWC3_QUIRK_LFPSFILT		(1 << 7)
 
 };
-- 
1.9.1

