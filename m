Return-Path: <SRS0=zEjk=FS=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=zEjk=FS=h08.hostsharing.net=foo00@kernel.org>
Date: Sat, 24 Feb 2018 17:26:04 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/7] PCI: Restore BARs on runtime resume despite being
 unbound
Message-ID: <20180224162604.GA25961@wunner.de>
References: <cover.1518941072.git.lukas@wunner.de>
 <f7593132608eb9a83d7268cc5b3ef12b3dd9c52d.1518941073.git.lukas@wunner.de>
 <20180220212922.GC32228@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0h+qipaKKDxxFFpkwUKgMjnoaUB8_p+FRDb+fSM_v+wBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0h+qipaKKDxxFFpkwUKgMjnoaUB8_p+FRDb+fSM_v+wBw@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

[trimming cc a bit to avoid spamming folks likely uninterested in PCI PM
intricacies]

On Wed, Feb 21, 2018 at 10:57:14AM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 20, 2018 at 10:29 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sun, Feb 18, 2018 at 09:38:32AM +0100, Lukas Wunner wrote:
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -1277,10 +1277,14 @@ static int pci_pm_runtime_resume(struct device *dev)
> > >
> > >       /*
> > >        * If pci_dev->driver is not set (unbound), the device should
> > > -      * always remain in D0 regardless of the runtime PM status
> > > +      * always remain in D0 regardless of the runtime PM status.
> > > +      * But if its parent can go to D3cold, this device may have
> > > +      * been in D3cold as well and require restoration of its BARs.
> > >        */
> > > -     if (!pci_dev->driver)
> > > +     if (!pci_dev->driver) {
> > > +             pci_restore_bars(pci_dev);
> >
> > If we do decide not to do a full-blown restore, how do we decide
> > whether to use pci_restore_bars() or pci_restore_config_space()?
> >
> > I'm not sure why we have both.
> 
> Me neither.

pci_restore_config_space() configures the BARs from saved_config_space[]
in struct pci_dev.  This array needs to have been populated beforehand.
If it's never been populated, the function can't be used.  The sole
caller of that function, pci_restore_state(), therefore checks whether
the state_saved bit in stuct pci_dev is true.

According to the code comment in the sole caller of pci_restore_bars(),
pci_raw_set_power_state(), there are systems where device are in D3hot
on boot.  Moreover devices where the No_Soft_Reset bit is 0 are in
D0uninitialized when coming out of D3hot.

For those devices, pci_restore_bars() is called to configure the BARs
from resource[] in struct pci_dev, which was populated on bus scan.
pci_restore_config_space() can't be used here because the first time
the devices are brought into D0, saved_config_space[] hasn't been
populated yet.  It's normally only populated when the device is suspended.

It might be possible to replace the invocation of pci_restore_bars()
with pci_restore_state() if pci_save_state() is called on bus scan for
devices in D3hot whose No_Soft_Reset bit is 0.

An alternative approach would be to avoid storing BARs in
saved_config_space[], and modify pci_restore_config_space() to restore
those from resource[].  That would save 24 bytes in struct pci_dev.
But it would only work if the BARs are always in sync with resource[],
I'm not sure if there are situations when this isn't the case.

Thanks,

Lukas
