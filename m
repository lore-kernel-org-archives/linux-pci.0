Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0133.outbound.protection.outlook.com ([157.56.111.133]:48621
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758072AbaJ3KKQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 06:10:16 -0400
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
Subject: [PATCH v4 02/20] usb: dwc3: add a flag to check if it is FPGA board
Date: Thu, 30 Oct 2014 18:08:27 +0800
Message-ID: <1414663725-2195-3-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some chip vendor is on pre-silicon phase, which needs to use the simulation
board. It should have the same product and vendor id with the true SoC, but
might have some minor different configurations.

Below thread discussion proposes to find a method to distinguish between
simulation board and SoC.

http://marc.info/?l=linux-usb&m=141194772206369&w=2

In Advanced Configuration of coreConsultant, there is the parameter of
DWC_USB_EN_FPGA. This bit has the function we need. And it would response
as 7 bit of GHWPARAMS6 register. So it's able to check this functional bit
to confirm if works on FPGA board.

Reported-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/core.c | 6 ++++++
 drivers/usb/dwc3/core.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 5a47482..c8ae098 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -460,6 +460,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dev_dbg(dwc->dev, "No power optimization available\n");
 	}
 
+	/* check if current dwc3 is on simulation board */
+	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
+		dev_dbg(dwc->dev, "it is on FPGA board\n");
+		dwc->is_fpga = true;
+	}
+
 	/*
 	 * WORKAROUND: DWC3 revisions <1.90a have a bug
 	 * where the device can fail to connect at SuperSpeed
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a715ee1..f6ee623 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -210,6 +210,9 @@
 #define DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(n)	(((n) & (0x0f << 13)) >> 13)
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
 
+/* Global HWPARAMS6 Register */
+#define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -662,6 +665,7 @@ struct dwc3_scratchpad_array {
  * @ep0_expect_in: true when we expect a DATA IN transfer
  * @has_hibernation: true when dwc3 was configured with Hibernation
  * @is_selfpowered: true when we are selfpowered
+ * @is_fpga: true when we are using the FPGA board
  * @needs_fifo_resize: not all users might want fifo resizing, flag it
  * @pullups_connected: true when Run/Stop bit is set
  * @resize_fifos: tells us it's ok to reconfigure our TxFIFO sizes.
@@ -765,6 +769,7 @@ struct dwc3 {
 	unsigned		ep0_expect_in:1;
 	unsigned		has_hibernation:1;
 	unsigned		is_selfpowered:1;
+	unsigned		is_fpga:1;
 	unsigned		needs_fifo_resize:1;
 	unsigned		pullups_connected:1;
 	unsigned		resize_fifos:1;
-- 
1.9.1

