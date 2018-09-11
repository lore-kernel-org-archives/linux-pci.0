Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38185 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbeIKONu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Sep 2018 10:13:50 -0400
Date: Tue, 11 Sep 2018 12:15:20 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        anthony.wong@canonical.com, djb@cr.yp.to,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 05/10] PCI: portdrv: Resume upon exit from system suspend
 if left runtime suspended
Message-ID: <20180911091520.GU14465@lahna.fi.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
 <20180906155020.51700-6-mika.westerberg@linux.intel.com>
 <CAJZ5v0imJOe25MxUiutOg+55xX4+ZwY5VULk8WKP3G8Diz+=8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0imJOe25MxUiutOg+55xX4+ZwY5VULk8WKP3G8Diz+=8w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 11, 2018 at 10:00:07AM +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 6, 2018 at 5:50 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Currently we try to keep PCIe ports runtime suspended over system
> > suspend if possible. This mostly happens when entering suspend-to-idle
> > because there is no need to re-configure wake settings.
> >
> > This causes problems if the parent port goes into D3cold and it gets
> > resumed upon exit from system suspend. This may happen for example if
> > the port is part of PCIe switch and the same switch is connected to a
> > PCIe endpoint that needs to be resumed. The way exit from D3cold works
> > according PCIe 4.0 spec 5.3.1.4.2 is that power is restored and cold
> > reset is signaled. After this the device is in D0unitialized state
> > keeping PME context if it supports wake from D3cold.
> >
> > The problem occurs when a PCIe hotplug port is left suspended and the
> > parent port goes into D3cold and back to D0, the port keeps its PME
> > context but since everything else is reset back to defaults
> > (D0unitialized) it is not set to detect hotplug events anymore.
> >
> > For this reason change the PCIe portdrv power management logic so that
> > it is fine to keep the port runtime suspended over system suspend but it
> > needs to be resumed upon exit to make sure it gets properly re-initialized.
> > The custom ->prepare() hook with DPM_FLAG_SMART_PREPARE is needed
> > because otherwise pci_pm_prepare() instructs the PM core to go directly
> > to pci_pm_complete() on resume and this skips resuming the port.
> 
> Thanks for the detailed explanation, it helps quite a bit!
> 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/pcie/portdrv_pci.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> > index eef22dc29140..74761f660a30 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -43,6 +43,21 @@ __setup("pcie_ports=", pcie_port_setup);
> >  /* global data */
> >
> >  #ifdef CONFIG_PM
> > +int pcie_port_prepare(struct device *dev)
> > +{
> > +       /*
> > +        * Return 0 here to indicate PCI core that:
> > +        *   - Direct complete path should be avoided
> > +        *   - It is OK to leave the port runtime suspended over system
> > +        *     suspend
> > +        *
> > +        * However, the port needs to be resumed afterwards because it may
> > +        * have been in D3cold in which case we need to re-initialize the
> > +        * hardware as it is in D0uninitialized in that case.
> > +        */
> > +       return 0;
> > +}
> 
> You wouldn't need this if you passed DPM_FLAG_NEVER_SKIP to
> dev_pm_set_driver_flags() (instead of DPM_FLAG_SMART_SUSPEND), would
> you?

Yes, I think it would work. I did not use it here because I thought it
would be better to leave the port runtime suspended during system
suspend (to idle) but in both cases we end up resuming them at some
point (before or after system suspend).

DPM_FLAG_NEVER_SKIP would result a cleaner patch, I think.
