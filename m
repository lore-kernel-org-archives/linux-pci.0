Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:55371 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeC3JAf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Mar 2018 05:00:35 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Fri, 30 Mar 2018 11:00:51 +0200
Message-ID: <1748267.LlfkqdCPEG@aspire.rjw.lan>
In-Reply-To: <5DC805B1-51DA-4D0F-9A43-9D5FE549AB13@canonical.com>
References: <20180319140910.26496-1-kai.heng.feng@canonical.com> <5DC805B1-51DA-4D0F-9A43-9D5FE549AB13@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, March 26, 2018 7:54:35 AM CEST Kai Heng Feng wrote:
> Hi Bjorn, Rafael,
> 
> > On Mar 19, 2018, at 10:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
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
> > Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
> > dev_pm_info")
> > Cc: stable@vger.kernel.org # 4.13+
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> 
> Is there any improvement I can address?
> Or do you have any concern about this patch?
> 
> Kai-Heng
> 
> > ---
> > v2: Explicitly check dev->pme_support.
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

So why do you change 'false' to 'true' here?

At least that change should be mentioned in the changelog too.

> >  		return false;
> >
> > +	if (device_can_wakeup(&dev->dev))
> > +		return true;
> > +
> >  	while (bus->parent) {
> >  		struct pci_dev *bridge = bus->self;
> >
> 
