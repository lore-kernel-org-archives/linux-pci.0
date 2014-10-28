Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0115.outbound.protection.outlook.com ([65.55.169.115]:3098
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751647AbaJ1L4U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 07:56:20 -0400
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
Subject: [PATCH v3 06/19] usb: dwc3: add u2exit lfps quirk
Date: Tue, 28 Oct 2014 19:54:27 +0800
Message-ID: <1414497280-3126-7-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds u2exit lfps quirk, and some special platforms can configure
that if it is needed.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c          | 6 ++++++
 drivers/usb/dwc3/core.h          | 3 +++
 drivers/usb/dwc3/platform_data.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4f37a43..6abf4e9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -468,6 +468,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	else
 		reg &= ~DWC3_GCTL_DISSCRAMBLE;
 
+	if (dwc->u2exit_lfps_quirk)
+		reg |= DWC3_GCTL_U2EXIT_LFPS;
+
 	/*
 	 * WORKAROUND: DWC3 revisions <1.90a have a bug
 	 * where the device can fail to connect at SuperSpeed
@@ -724,6 +727,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 		dwc->disable_scramble_quirk = of_property_read_bool(node,
 				"snps,disable_scramble_quirk");
+		dwc->u2exit_lfps_quirk = of_property_read_bool(node,
+				"snps,u2exit_lfps_quirk");
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -734,6 +739,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->dr_mode = pdata->dr_mode;
 
 		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
+		dwc->u2exit_lfps_quirk = pdata->u2exit_lfps_quirk;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 19d1ecb..03e0505 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -166,6 +166,7 @@
 #define DWC3_GCTL_SCALEDOWN(n)		((n) << 4)
 #define DWC3_GCTL_SCALEDOWN_MASK	DWC3_GCTL_SCALEDOWN(3)
 #define DWC3_GCTL_DISSCRAMBLE		(1 << 3)
+#define DWC3_GCTL_U2EXIT_LFPS		(1 << 2)
 #define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
 #define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
 
@@ -679,6 +680,7 @@ struct dwc3_scratchpad_array {
  * @start_config_issued: true when StartConfig command has been issued
  * @three_stage_setup: set if we perform a three phase setup
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
+ * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -787,6 +789,7 @@ struct dwc3 {
 	unsigned		three_stage_setup:1;
 
 	unsigned		disable_scramble_quirk:1;
+	unsigned		u2exit_lfps_quirk:1;
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 2e546ac..4e91e09 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -28,4 +28,5 @@ struct dwc3_platform_data {
 	unsigned disable_scramble_quirk:1;
 	unsigned has_lpm_erratum:1;
 	unsigned lpm_nyet_thres:4;
+	unsigned u2exit_lfps_quirk:1;
 };
-- 
1.9.1

