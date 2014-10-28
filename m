Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0118.outbound.protection.outlook.com ([157.56.110.118]:14064
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755107AbaJ1L4F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 07:56:05 -0400
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>,
	"Vincent Wan" <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v3 03/19] usb: dwc3: initialize platform data at pci glue layer
Date: Tue, 28 Oct 2014 19:54:24 +0800
Message-ID: <1414497280-3126-4-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch initializes platform data at pci glue layer, and SoCs x86-based
platform vendor is able to define their flags in platform data at bus glue
layer. Then do some independent behaviors at dwc3 core level.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index a36cf66..ada975f 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -25,6 +25,8 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/usb_phy_generic.h>
 
+#include "platform_data.h"
+
 /* FIXME define these in <linux/pci_ids.h> */
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3	0xabcd
@@ -102,6 +104,9 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 	struct dwc3_pci		*glue;
 	int			ret;
 	struct device		*dev = &pci->dev;
+	struct dwc3_platform_data dwc3_pdata;
+
+	memset(&dwc3_pdata, 0x00, sizeof(dwc3_pdata));
 
 	glue = devm_kzalloc(dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue)
@@ -148,6 +153,10 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(pci, glue);
 
+	ret = platform_device_add_data(dwc3, &dwc3_pdata, sizeof(dwc3_pdata));
+	if (ret)
+		goto err3;
+
 	dma_set_coherent_mask(&dwc3->dev, dev->coherent_dma_mask);
 
 	dwc3->dev.dma_mask = dev->dma_mask;
-- 
1.9.1

