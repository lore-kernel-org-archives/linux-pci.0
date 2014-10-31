Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0143.outbound.protection.outlook.com ([157.56.110.143]:13568
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934093AbaJaDNS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 23:13:18 -0400
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
Subject: [PATCH v5 8/8] usb: dwc3: point host-mode hibernation enablement not device-mode
Date: Fri, 31 Oct 2014 11:11:19 +0800
Message-ID: <1414725079-11490-9-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414725079-11490-1-git-send-email-ray.huang@amd.com>
References: <1414725079-11490-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since the discussion of below thread, current enablement works for
host-mode, device-mode hibernation is not implemented yet.

http://marc.info/?l=linux-usb&m=141452396814414&w=2

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c   | 7 ++++++-
 drivers/usb/dwc3/gadget.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8753792..a785fdd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -512,8 +512,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 			reg &= ~DWC3_GCTL_DSBLCLKGTNG;
 		break;
 	case DWC3_GHWPARAMS1_EN_PWROPT_HIB:
-		/* enable hibernation here */
 		dwc->nr_scratch = DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwparams4);
+		/*
+		 * Enable hibernation here.
+		 *
+		 * Enabling this bit so that host-mode hibernation will
+		 * work, device-mode hibernation is not implemented yet.
+		 */
 		reg |= DWC3_GCTL_GBLHIBERNATIONEN;
 		break;
 	default:
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 01e22d7..398c12f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2300,7 +2300,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		/*
 		 * When dwc3 revisions >= 2.40a, LPM Erratum is enabled and
 		 * DCFG.LPMCap is set, core responses with an ACK and the
-		 * BESL value in the LPM token is less than or equal to lPM
+		 * BESL value in the LPM token is less than or equal to LPM
 		 * NYET threshold.
 		 */
 		WARN_ONCE(dwc->revision < DWC3_REVISION_240A
-- 
1.9.1

