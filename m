Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v2 02/16] pci: quirks: add quirk to avoid AMD NL to bind with xhci
Date: Fri, 17 Oct 2014 16:53:27 +0800
Message-ID: <1413536021-4886-3-git-send-email-ray.huang@amd.com>
In-Reply-To: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dwc3 controller is the PCI-E device in AMD NL platform, but the class code
of PCI header is 0x0c0330, the same with xHC. That's because it needs to meet
the windows enviroment. The dwc3 controller acted as only host mode to bind with
windows xhci driver.
But on linux, sometimes, it would auto-bind with xhci driver as well (class code
0x0c0330) despite it uses Pid/Vid on dwc3 driver.

Heikki suggested to use the quirk to fix this issue, and the detailed discussion
is at below thread:
http://marc.info/?l=linux-usb&m=141197934712824&w=2

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/pci/quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 90acb32..3c911b7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -378,6 +378,26 @@ static void quirk_ati_exploding_mce(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
 
+/* FIXME should define in <linux/pci_ids.h> */
+#define PCI_DEVICE_ID_AMD_NL	0x7912
+
+/*
+ * AMD NL SoC 7912 PCI device is dwc3 controller, but the class code of PCI
+ * header is 0x0c0330, the same with xHC. That's because it need to meet the
+ * windows enviroment. The dwc3 controller acted as only host mode to bind with
+ * windows xhci driver. But on linux, sometimes, we auto-bind with xhci driver
+ * as well (class code 0x0c0330) despite we use Pid/Vid on dwc3 driver. So this
+ * quirk used a dummy class code to avoid to bind with xhci driver at booting
+ * phase.
+ */
+static void quirk_amd_nl_class(struct pci_dev *pdev)
+{
+	/* Use a dummy class value instead of PCI header provided */
+	pdev->class = 0x0c03fe;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL,
+		quirk_amd_nl_class);
+
 /*
  * Let's make the southbridge information explicit instead
  * of having to worry about people probing the ACPI areas,
-- 
1.9.1

