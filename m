Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0122.outbound.protection.outlook.com ([207.46.100.122]:19808
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933938AbaJ3KLj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 06:11:39 -0400
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Jason Chang <jason.chang@amd.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Huang Rui <ray.huang@amd.com>
Subject: [PATCH v4 18/20] PCI: Prevent xHCI driver from claiming AMD Nolan USB3 DRD device
Date: Thu, 30 Oct 2014 18:08:43 +0800
Message-ID: <1414663725-2195-19-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The AMD Nolan (NL) SoC contains a DesignWare USB3 Dual-Role Device that can
be operated either as a USB Host or a USB Device.  In the AMD NL platform,
this device ([1022:7912]) has a class code of PCI_CLASS_SERIAL_USB_XHCI
(0x0c0330), which means the xhci driver will claim it.

But the dwc3 driver is a more specific driver for this device, and we'd
prefer to use it instead of xhci.  To prevent xhci from claiming the
device, change the class code to 0x0c03fe, which the PCI r3.0 spec defines
as "USB device (not host controller)".  The dwc3 driver can then claim it
based on its Vendor and Device ID.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Chang <jason.chang@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/pci/quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 90acb32..ed6f89b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -379,6 +379,26 @@ static void quirk_ati_exploding_mce(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
 
 /*
+ * In the AMD NL platform, this device ([1022:7912]) has a class code of
+ * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
+ * claim it.
+ * But the dwc3 driver is a more specific driver for this device, and we'd
+ * prefer to use it instead of xhci. To prevent xhci from claiming the
+ * device, change the class code to 0x0c03fe, which the PCI r3.0 spec
+ * defines as "USB device (not host controller)". The dwc3 driver can then
+ * claim it based on its Vendor and Device ID.
+ */
+static void quirk_amd_nl_class(struct pci_dev *pdev)
+{
+	/*
+	 * Use 'USB Device' (0x0c03fe) instead of PCI header provided
+	 */
+	pdev->class = 0x0c03fe;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
+		quirk_amd_nl_class);
+
+/*
  * Let's make the southbridge information explicit instead
  * of having to worry about people probing the ACPI areas,
  * for example.. (Yes, it happens, and if you read the wrong
-- 
1.9.1

