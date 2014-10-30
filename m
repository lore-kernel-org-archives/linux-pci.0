Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0137.outbound.protection.outlook.com ([65.55.169.137]:27680
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758835AbaJ3KK2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 06:10:28 -0400
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
Subject: [PATCH v4 04/20] usb: dwc3: add disable scramble quirk
Date: Thu, 30 Oct 2014 18:08:29 +0800
Message-ID: <1414663725-2195-5-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds disable scramble quirk, and it only needs to be enabled at
FPGA board on some vendor platforms.

[Note] In DesignWare databook, HW designer describes:
disscramble = disable scramble

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt |  2 ++
 drivers/usb/dwc3/core.c                        | 11 ++++++++++-
 drivers/usb/dwc3/core.h                        |  3 +++
 drivers/usb/dwc3/platform_data.h               |  2 ++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 471366d..8ec2256 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -14,6 +14,8 @@ Optional properties:
  - phys: from the *Generic PHY* bindings
  - phy-names: from the *Generic PHY* bindings
  - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
+ - snps,disable_scramble_quirk: true when SW should disable data scrambling.
+	Only really useful for FPGA builds.
 
 This is usually a subnode to DWC3 glue to which it is connected.
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c8ae098..fae095f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -422,7 +422,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
-	reg &= ~DWC3_GCTL_DISSCRAMBLE;
 
 	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
 	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
@@ -466,6 +465,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->is_fpga = true;
 	}
 
+	if (dwc->disable_scramble_quirk && dwc->is_fpga)
+		reg |= DWC3_GCTL_DISSCRAMBLE;
+	else
+		reg &= ~DWC3_GCTL_DISSCRAMBLE;
+
 	/*
 	 * WORKAROUND: DWC3 revisions <1.90a have a bug
 	 * where the device can fail to connect at SuperSpeed
@@ -710,11 +714,16 @@ static int dwc3_probe(struct platform_device *pdev)
 
 		dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
 		dwc->dr_mode = of_usb_get_dr_mode(node);
+
+		dwc->disable_scramble_quirk = of_property_read_bool(node,
+				"snps,disable_scramble_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 
 		dwc->needs_fifo_resize = pdata->tx_fifo_resize;
 		dwc->dr_mode = pdata->dr_mode;
+
+		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f6ee623..56bada6 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -672,6 +672,7 @@ struct dwc3_scratchpad_array {
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
  * @start_config_issued: true when StartConfig command has been issued
  * @three_stage_setup: set if we perform a three phase setup
+ * @disable_scramble_quirk: set if we enable the disable scramble quirk
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -776,6 +777,8 @@ struct dwc3 {
 	unsigned		setup_packet_pending:1;
 	unsigned		start_config_issued:1;
 	unsigned		three_stage_setup:1;
+
+	unsigned		disable_scramble_quirk:1;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 7db34f0..9209d02 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -24,4 +24,6 @@ struct dwc3_platform_data {
 	enum usb_device_speed maximum_speed;
 	enum usb_dr_mode dr_mode;
 	bool tx_fifo_resize;
+
+	unsigned disable_scramble_quirk:1;
 };
-- 
1.9.1

