Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0124.outbound.protection.outlook.com ([207.46.100.124]:13659
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933177AbaJ3KKy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 06:10:54 -0400
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
Subject: [PATCH v4 09/20] usb: dwc3: add delay P1/P2/P3 quirk
Date: Thu, 30 Oct 2014 18:08:34 +0800
Message-ID: <1414663725-2195-10-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds delay P0 to P1/P2/P3 quirk for U2/U2/U3, and some special
platforms can configure that if it is needed.

[ balbi@ti.com : added DeviceTree binding documentation ]

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
 drivers/usb/dwc3/core.c                        | 6 ++++++
 drivers/usb/dwc3/core.h                        | 5 +++++
 drivers/usb/dwc3/platform_data.h               | 1 +
 4 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 9de11fd..a406bb5 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -22,6 +22,8 @@ Optional properties:
  - snps,u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
  - snps,req_p1p2p3_quirk: when set, the core will always request for
 			P1/P2/P3 transition sequence.
+ - snps,del_p1p2p3_quirk: when set core will delay P1/P2/P3 until a certain
+			amount of 8B10B errors occur.
 
 This is usually a subnode to DWC3 glue to which it is connected.
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e951984..4429de7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -380,6 +380,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->req_p1p2p3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_REQP1P2P3;
 
+	if (dwc->del_p1p2p3_quirk)
+		reg |= DWC3_GUSB3PIPECTL_DEP1P2P3_EN;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
@@ -758,6 +761,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,u2ss_inp3_quirk");
 		dwc->req_p1p2p3_quirk = of_property_read_bool(node,
 				"snps,req_p1p2p3_quirk");
+		dwc->del_p1p2p3_quirk = of_property_read_bool(node,
+				"snps,del_p1p2p3_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -771,6 +776,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->u2exit_lfps_quirk = pdata->u2exit_lfps_quirk;
 		dwc->u2ss_inp3_quirk = pdata->u2ss_inp3_quirk;
 		dwc->req_p1p2p3_quirk = pdata->req_p1p2p3_quirk;
+		dwc->del_p1p2p3_quirk = pdata->del_p1p2p3_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index cbb8593..750e473 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -178,6 +178,9 @@
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
 #define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
+#define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
+#define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
+#define DWC3_GUSB3PIPECTL_DEP1P2P3_EN	DWC3_GUSB3PIPECTL_DEP1P2P3(1)
 #define DWC3_GUSB3PIPECTL_SUSPHY	(1 << 17)
 
 /* Global TX Fifo Size Register */
@@ -685,6 +688,7 @@ struct dwc3_scratchpad_array {
  * @u2exit_lfps_quirk: set if we enable U2Exit LFPS quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
  * @req_p1p2p3_quirk: set if we enable request P1/P2/P3 quirk
+ * @del_p1p2p3_quirk: set if we enable delay P1/P2/P3 quirk
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -796,6 +800,7 @@ struct dwc3 {
 	unsigned		u2exit_lfps_quirk:1;
 	unsigned		u2ss_inp3_quirk:1;
 	unsigned		req_p1p2p3_quirk:1;
+	unsigned                del_p1p2p3_quirk:1;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index d3e6ec2..a421cec 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -32,4 +32,5 @@ struct dwc3_platform_data {
 	unsigned u2exit_lfps_quirk:1;
 	unsigned u2ss_inp3_quirk:1;
 	unsigned req_p1p2p3_quirk:1;
+	unsigned del_p1p2p3_quirk:1;
 };
-- 
1.9.1

