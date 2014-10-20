Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0148.outbound.protection.outlook.com ([157.56.110.148]:32428
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752322AbaJTGic (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Oct 2014 02:38:32 -0400
Date: Mon, 20 Oct 2014 14:38:28 +0800
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul Zimmerman" <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/16] usb: dwc3: add disscramble quirk
Message-ID: <20141020063827.GB24357@hr-slim.amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
 <1413536021-4886-7-git-send-email-ray.huang@amd.com>
 <20141017144532.GB26260@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141017144532.GB26260@saruman>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 17, 2014 at 09:45:32AM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Oct 17, 2014 at 04:53:31PM +0800, Huang Rui wrote:
> > AMD NL fpga needs to enable disscramble quirk. And this quirk doesn't need on
> > the true soc.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/usb/dwc3/core.c          | 8 +++++++-
> >  drivers/usb/dwc3/dwc3-pci.c      | 5 +++++
> >  drivers/usb/dwc3/platform_data.h | 4 ++++
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 50c0eae..819e501 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -422,7 +422,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
> >  
> >  	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> >  	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
> > -	reg &= ~DWC3_GCTL_DISSCRAMBLE;
> >  
> >  	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
> >  	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
> > @@ -461,6 +460,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
> >  		dwc->is_fpga = true;
> >  	}
> >  
> > +	if ((dwc->quirks & DWC3_QUIRK_AMD_NL) && dwc->is_fpga)
> > +		dwc->quirks |= DWC3_QUIRK_DISSCRAMBLE;
> > +
> > +	if (dwc->quirks & DWC3_QUIRK_DISSCRAMBLE)
> 
> this should only be set if is_fpga, and this quirk should be a 1-bit
> flag, so here's what you should do:
> 
> 	WARN_ONCE(dwc->disable_scramble_quirk && !dwc->is_fpga,
> 		"disable_scramble cannot be used on non-FPGA builds\n");
> 
> 	if (dwc->disable_scramble && dwc->is_fpga)
> 		reg |= DWC3_GCTL_DISSCRAMBLE;
> 	else
> 		reg &= ~DWC3_GCTL_DISSCRAMBLE;
> 

OK, will update it in V3.

> > +		reg |= DWC3_GCTL_DISSCRAMBLE;
> > +	else
> > +		reg &= ~DWC3_GCTL_DISSCRAMBLE;
> 
> add a blank line here, to aid readability.
> 

OK, will add it.

> >  	/*
> >  	 * WORKAROUND: DWC3 revisions <1.90a have a bug
> >  	 * where the device can fail to connect at SuperSpeed
> > diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> > index 18569a4..a89db6c 100644
> > --- a/drivers/usb/dwc3/dwc3-pci.c
> > +++ b/drivers/usb/dwc3/dwc3-pci.c
> > @@ -146,6 +146,11 @@ static int dwc3_pci_probe(struct pci_dev *pci,
> >  	res[1].name	= "dwc_usb3";
> >  	res[1].flags	= IORESOURCE_IRQ;
> >  
> > +	if (pci->vendor == PCI_VENDOR_ID_AMD && pci->device ==
> > +			PCI_DEVICE_ID_AMD_NL) {
> > +		dwc3_pdata.quirks |= DWC3_QUIRK_AMD_NL;
> > +	}
> 
> should be part of another patch and the quirk is
> "disable_scramble_quirk", not AMD.
> 

Got it, you would like to keep this patch just for fpga disscramble
quirk and do not add any 3rd platform info, right?

Thanks,
Rui
