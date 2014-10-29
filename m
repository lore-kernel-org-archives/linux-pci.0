Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0144.outbound.protection.outlook.com ([65.55.169.144]:45904
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751680AbaJ2GwO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Oct 2014 02:52:14 -0400
Date: Wed, 29 Oct 2014 14:50:55 +0800
From: Huang Rui <ray.huang@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>,
	"Vincent Wan" <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	USB list <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] usb: dwc3: add disscramble quirk
Message-ID: <20141029065055.GA8935@hr-slim.amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
 <1414497280-3126-5-git-send-email-ray.huang@amd.com>
 <CAErSpo5vRcGxu=e61tCEwNVL913_Lxne=1KW+JtQVpc6jgCaHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo5vRcGxu=e61tCEwNVL913_Lxne=1KW+JtQVpc6jgCaHg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Oct 28, 2014 at 10:39:26AM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 28, 2014 at 5:54 AM, Huang Rui <ray.huang@amd.com> wrote:
> > This patch adds disscramble quirk, and it only needs to be enabled at fpga
> 
> "disscramble" (in subject and above) is not a real word.
> 
> I see that DWC3_GCTL_DISSCRAMBLE is already defined in
> drivers/usb/dwc3/core.h even before your patches, so I suppose it's
> something the hardware designers made up.
> 
> Maybe it means "descramble" (or "unscramble").  Or maybe it means
> "disable scrambling"?  A comment might make this clearer.  A better
> name would be even better.
> 

Your mention is right. "disscramble" is writed by HW designers in
DesignWare databook. It could confuse reader, I will update subject
and add note (disscramble = disable scramble) at commit log.

Thanks,
Rui
