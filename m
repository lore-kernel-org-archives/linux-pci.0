Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755873AbeDZNzr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Apr 2018 09:55:47 -0400
Date: Thu, 26 Apr 2018 08:55:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for
 runtime wakeup support
Message-ID: <20180426135545.GB225403@bhelgaas-glaptop.roam.corp.google.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com>
 <798A7C7A-A3DA-4C0E-A774-48042430EE1A@canonical.com>
 <10732937.eAR6mAEfiz@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10732937.eAR6mAEfiz@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 13, 2018 at 09:29:56AM +0200, Rafael J. Wysocki wrote:
> On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
> > Hi Bjorn and Rafael,
> > 
> > > On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> > > wrote:
> > >
> > > USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> > > core: Drop run_wake flag from struct dev_pm_info").
> > >
> > > The device in question is not power managed by platform firmware,
> > > furthermore, it only supports PME# from D3cold:
> > > Capabilities: [78] Power Management version 3
> > >        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> > >        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > >
> > > Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> > > After that commit, the device gets runtime suspended, so it does not
> > > respond to any PME#.

Apologies for my lack of PM expertise.  I don't think the device would
*respond* to PME#, would it?  I would think the device would
potentially *generate* a PME#.

And I guess since this device can generate PME# only from D3cold, the
implication is that runtime suspending the device may put it into D1,
D2, or D3hot, but not D3cold?  Is that an axiom of the runtime suspend
design?

> > > usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> > > device_can_wakeup() in pci_dev_run_wake() always returns true.

I think "mandatorily" means "always" or "unconditionally", right?

> > > So pci_dev_run_wake() needs to check PME wakeup capability as its first
> > > condition.
> > >
> > > In addition, change wakeup flag passed to pci_target_state() from false
> > > to true, because we want to find the deepest state that the device can
> > > still generate PME#.

Is this a separate bug fix?  I don't understand how it fits in here
because the wakeup flag means "Whether or not wakeup functionality
will be enabled for the device", and you're not changing anything
about whether wakeup functionality will be enabled.

> > > Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
> > > dev_pm_info")
> > > Cc: stable@vger.kernel.org # 4.13+
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v3: State the reason why the wakeup flag gets changed.
> > >
> > > v2: Explicitly check dev->pme_support.
> > 
> > If this patch is good enough, I am hoping it can get merged in v4.17.
> 
> OK
> 
> Bjorn, if you want to take this:
> 
>  Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Otherwise please let me know and I'll queue it up.

de3ef1eb1cd0 went through your tree, so I think this fix should go
through your tree, too.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Not directly related to this patch, but I think these comments in
pci_target_state() are slightly misleading:

   * Call the platform to choose the target state of the device
   * and enable wake-up from this state if supported.

   * Find the deepest state from which the device can generate
   * wake-up events, make it the target state and enable device
   * to generate PME#.

AFAICT, pci_target_state() does not actually "enable wake-up from this
state" or "enable device to generate PME#".

> > >  drivers/pci/pci.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index f6a4dd10d9b0..52821a21fc07 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
> > >  {
> > >  	struct pci_bus *bus = dev->bus;
> > >
> > > -	if (device_can_wakeup(&dev->dev))
> > > -		return true;
> > > -
> > >  	if (!dev->pme_support)
> > >  		return false;
> > >
> > >  	/* PME-capable in principle, but not from the target power state */
> > > -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
> > > +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
> > >  		return false;
> > >
> > > +	if (device_can_wakeup(&dev->dev))
> > > +		return true;
> > > +
> > >  	while (bus->parent) {
> > >  		struct pci_dev *bridge = bus->self;
> > >
> > 
> 
> 
