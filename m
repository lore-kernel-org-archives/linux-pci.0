Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Fri, 13 Apr 2018 09:29:56 +0200
Message-ID: <10732937.eAR6mAEfiz@aspire.rjw.lan>
In-Reply-To: <798A7C7A-A3DA-4C0E-A774-48042430EE1A@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com> <798A7C7A-A3DA-4C0E-A774-48042430EE1A@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
> Hi Bjorn and Rafael,
> 
> > On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> > wrote:
> >
> > USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> > core: Drop run_wake flag from struct dev_pm_info").
> >
> > The device in question is not power managed by platform firmware,
> > furthermore, it only supports PME# from D3cold:
> > Capabilities: [78] Power Management version 3
> >        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >
> > Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> > After that commit, the device gets runtime suspended, so it does not
> > respond to any PME#.
> >
> > usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> > device_can_wakeup() in pci_dev_run_wake() always returns true.
> >
> > So pci_dev_run_wake() needs to check PME wakeup capability as its first
> > condition.
> >
> > In addition, change wakeup flag passed to pci_target_state() from false
> > to true, because we want to find the deepest state that the device can
> > still generate PME#.
> >
> > Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
> > dev_pm_info")
> > Cc: stable@vger.kernel.org # 4.13+
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3: State the reason why the wakeup flag gets changed.
> >
> > v2: Explicitly check dev->pme_support.
> 
> If this patch is good enough, I am hoping it can get merged in v4.17.

OK

Bjorn, if you want to take this:

 Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Otherwise please let me know and I'll queue it up.


> >
> >  drivers/pci/pci.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index f6a4dd10d9b0..52821a21fc07 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
> >  {
> >  	struct pci_bus *bus = dev->bus;
> >
> > -	if (device_can_wakeup(&dev->dev))
> > -		return true;
> > -
> >  	if (!dev->pme_support)
> >  		return false;
> >
> >  	/* PME-capable in principle, but not from the target power state */
> > -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
> > +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
> >  		return false;
> >
> > +	if (device_can_wakeup(&dev->dev))
> > +		return true;
> > +
> >  	while (bus->parent) {
> >  		struct pci_dev *bridge = bus->self;
> >
> 
