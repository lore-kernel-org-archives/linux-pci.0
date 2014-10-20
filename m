Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Oct 2014 16:41:54 +0800
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>
CC: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 16/16] usb: dwc3: enable usb suspend phy
Message-ID: <20141020084153.GD24357@hr-slim.amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
 <1413536021-4886-17-git-send-email-ray.huang@amd.com>
 <20141017145942.GL26260@saruman>
 <A2CA0424C0A6F04399FB9E1CD98E0304844E3423@US01WEMBX2.internal.synopsys.com>
 <20141017184819.GX26260@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141017184819.GX26260@saruman>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 17, 2014 at 01:48:19PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Oct 17, 2014 at 06:41:04PM +0000, Paul Zimmerman wrote:
> > > From: Felipe Balbi [mailto:balbi@ti.com]
> > > Sent: Friday, October 17, 2014 8:00 AM
> > > 
> > > On Fri, Oct 17, 2014 at 04:53:41PM +0800, Huang Rui wrote:
> > > > AMD NL needs to suspend usb3 ss phy, but this doesn't enable on simulation
> > > > board.
> > > >
> > > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > ---
> > > >  drivers/usb/dwc3/core.c          | 7 ++++++-
> > > >  drivers/usb/dwc3/dwc3-pci.c      | 3 ++-
> > > >  drivers/usb/dwc3/platform_data.h | 1 +
> > > >  3 files changed, 9 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index 3ccfe41..4a98696 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -395,6 +395,9 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
> > > >  	if (dwc->quirks & DWC3_QUIRK_TX_DEEPH)
> > > >  		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(1);
> > > >
> > > > +	if (dwc->quirks & DWC3_QUIRK_SUSPHY)
> > > 
> > > should be:
> > > 
> > > 	if (!dwc->suspend_usb3_phy_quirk)
> > > 
> > > > +		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
> > > 
> > > IIRC, databook asks us to set that bit anyway, so the quirk is disabling
> > > that bit. Am I missing something ? Paul ?
> > 
> > It looks to me that Huang's patch is enabling that bit, not disabling
> > it.
> 
> right, but that's what's actually quirky right ? IIRC, Databook asks us
> to set usb2 and usb3 suspend phy bits and we're just not doing it.
> 
> > Currently the driver does not set either DWC3_GUSB3PIPECTL_SUSPHY or
> > DWC3_GUSB2PHYCFG_SUSPHY (unless it has been added by that big patch
> > series you just posted). According to the databook, both of those
> > bits should be set to 1 after the core initialization has completed.
> 
> there you go. So unless that quirk bit flag is set, we're safe of
> setting SUSPHY bit for everybody.
> 

So I can update to set these two suspend phy bits defaultly in my next
patch set, is it OK? :)

Thanks,
Rui

> > So I think the driver should be changed to enable both of those by
> > default, and then maybe you want quirks to disable them if there is
> > some platform out there which needs that.
> 
> Yeah, that's what I thought too :-) Thanks for confirming
> 
> -- 
> balbi
