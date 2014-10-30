Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0101.outbound.protection.outlook.com ([207.46.100.101]:48743
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758689AbaJ3KKu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 06:10:50 -0400
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
Subject: [PATCH v4 08/20] usb: dwc3: add request P1/P2/P3 quirk
Date: Thu, 30 Oct 2014 18:08:33 +0800
Message-ID: <1414663725-2195-9-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds request P1/P2/P3 quirk for U2/U2/U3, and some special
platforms can configure that if it is needed.

[ balbi@ti.com : added DeviceTree binding documentation ]

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
 drivers/usb/dwc3/core.c                        | 6 ++++++
 drivers/usb/dwc3/core.h                        | 3 +++
 drivers/usb/dwc3/platform_data.h               | 1 +
 4 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index f714357..9de11fd 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -20,6 +20,8 @@ Optional properties:
  - snps,lpm-nyet-threshold: LPM NYET threshold
  - snps,u2exit_lfps_quirk: set if we want to enable U2Exit LFPS quirk
  - snps,u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
+ - snps,req_p1p2p3_quirk: when set, the core will always request for
+			P1/P2/P3 transition sequence.
 
 This is usually a subnode to DWC3 glue to which it is connected.
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0a935cb..e951984 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -377,6 +377,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
 
+	if (dwc->req_p1p2p3_quirk)
+		reg |= DWC3_GUSB3PIPECTL_REQP1P2P3;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
@@ -753,6 +756,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,u2exit_lfps_quirk");
 		dwc->u2ss_inp3_quirk = of_property_read_bool(node,
 				"snps,u2ss_inp3_quirk");
+		dwc->req_p1p2p3_quirk = of_property_read_bool(node,
+				"snps,req_p1p2p3_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -765,6 +770,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
 		dwc->u2exit_lfps_quirk = pdata->u2exit_lfps_quirk;
 		dwc->u2ss_inp3_quirk = pdata->u2ss_inp3_quirk;
+		dwc->req_p1p2p3_quirk = pdata->req_p1p2p3_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3843511..cbb8593 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -177,6 +177,7 @@
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
+#define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 
 /* Global TX Fifo Size Register */
@@ -683,6 +684,7 @@ struct dwc3_scratchpad_array {
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable U2Exit LFPS quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
+ * @req_p1p2p3_quirk: set if we enable request P1/P2/P3 quirk
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -793,6 +795,7 @@ struct dwc3 {
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
 	unsigned		u2ss_inp3_quirk:1;
+	unsigned		req_p1p2p3_quirk:1;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index cf92c81..d3e6ec2 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -31,4 +31,5 @@ struct dwc3_platform_data {
 	unsigned has_lpm_erratum:1;
 	unsigned u2exit_lfps_quirk:1;
 	unsigned u2ss_inp3_quirk:1;
+	unsigned req_p1p2p3_quirk:1;
 };
-- 
1.9.1

