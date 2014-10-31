Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0113.outbound.protection.outlook.com ([65.55.169.113]:50692
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422652AbaJaBhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 21:37:23 -0400
Date: Fri, 31 Oct 2014 09:29:55 +0800
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Jason Chang <jason.chang@amd.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 14/20] usb: dwc3: add Tx de-emphasis quirk
Message-ID: <20141031012954.GA20367@hr-slim.amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
 <1414663725-2195-15-git-send-email-ray.huang@amd.com>
 <20141030164210.GM10130@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141030164210.GM10130@saruman>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 11:42:10AM -0500, Felipe Balbi wrote:
> On Thu, Oct 30, 2014 at 06:08:39PM +0800, Huang Rui wrote:
> > This patch adds Tx de-emphasis quirk, and the Tx de-emphasis value is
> > configurable according to PIPE3 specification.
> > 
> > Value		Description
> > 0		-6dB de-emphasis
> > 1		-3.5dB de-emphasis
> > 2		No de-emphasis
> > 3		Reserved
> > 
> > It can be configured on DT or platform data.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> 
> doesn't apply:
> 
> checking file Documentation/devicetree/bindings/usb/dwc3.txt
> checking file drivers/usb/dwc3/core.c
> Hunk #2 succeeded at 718 (offset -2 lines).
> Hunk #3 succeeded at 777 (offset -2 lines).
> Hunk #4 succeeded at 807 (offset -2 lines).
> Hunk #5 succeeded at 829 (offset -2 lines).
> Hunk #6 succeeded at 840 (offset -2 lines).
> checking file drivers/usb/dwc3/core.h
> Hunk #2 FAILED at 697.
> 1 out of 3 hunks FAILED
> checking file drivers/usb/dwc3/platform_data.h
> 
> please rebase on testing/next
> 

That's because in patch 12 and other ones you applied, I changed
addreviations to uppercase such as "lfps" -> "LFPS", "fpga" -> "FPGA".

Previous 13 patches are already applied. Do you mean, I send the other
patches since "Tx de-emphasis" (patch 14) after rebased current
branch.

If yes, at patch 1, "Enabling this bit ... hibernation .. yet", should
it be updated in extra patch?

Thanks,
Rui
