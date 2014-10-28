Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0139.outbound.protection.outlook.com ([65.55.169.139]:44032
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754945AbaJ1Lzz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 07:55:55 -0400
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
Subject: [PATCH v3 01/19] usb: dwc3: enable hibernation if to be supported
Date: Tue, 28 Oct 2014 19:54:22 +0800
Message-ID: <1414497280-3126-2-git-send-email-ray.huang@amd.com>
In-Reply-To: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It enables hibernation if the function is set in coreConsultant.

Suggested-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/usb/dwc3/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index fa396fc..bf77509 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -449,6 +449,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	case DWC3_GHWPARAMS1_EN_PWROPT_HIB:
 		/* enable hibernation here */
 		dwc->nr_scratch = DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwparams4);
+		reg |= DWC3_GCTL_GBLHIBERNATIONEN;
 		break;
 	default:
 		dev_dbg(dwc->dev, "No power optimization available\n");
-- 
1.9.1

