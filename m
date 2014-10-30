Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0111.outbound.protection.outlook.com ([157.56.110.111]:29824
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933367AbaJ3KLO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 06:11:14 -0400
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
Subject: [PATCH v4 13/20] usb: dwc3: set SUSPHY bit for all cores
Date: Thu, 30 Oct 2014 18:08:38 +0800
Message-ID: <1414663725-2195-14-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is recommended to set USB3 and USB2 SUSPHY bits to '1' after the core
initialization is completed above the dwc3 revision 1.94a.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 11b0ab08..e02c3b0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -374,6 +374,15 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
+	/*
+	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
+	 * to '0' during coreConsultant configuration. So default value
+	 * will be '0' when the core is reset. Application needs to set it
+	 * to '1' after the core initialization is completed.
+	 */
+	if (dwc->revision > DWC3_REVISION_194A)
+		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
 
@@ -395,6 +404,21 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	mdelay(100);
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+
+	/*
+	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
+	 * '0' during coreConsultant configuration. So default value will
+	 * be '0' when the core is reset. Application needs to set it to
+	 * '1' after the core initialization is completed.
+	 */
+	if (dwc->revision > DWC3_REVISION_194A)
+		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
+	mdelay(100);
 }
 
 /**
-- 
1.9.1

