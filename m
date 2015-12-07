Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 7 Dec 2015 10:06:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] PCI: constify pci_platform_pm_ops structure
Message-ID: <20151207160649.GG7994@localhost>
References: <1449419625-29045-1-git-send-email-Julia.Lawall@lip6.fr>
 <1556686.IXJIjFBvQx@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1556686.IXJIjFBvQx@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 07, 2015 at 02:41:34AM +0100, Rafael J. Wysocki wrote:
> On Sunday, December 06, 2015 05:33:45 PM Julia Lawall wrote:
> > The pci_platform_pm_ops structure is never modified, so declare it as
> > const.
> > 
> > Done with the help of Coccinelle.
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> OK
> 
> Bjorn, do you want me to handle this one?

Sure, sounds good to me.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> > ---
> >  drivers/pci/pci-acpi.c |    2 +-
> >  drivers/pci/pci.c      |    4 ++--
> >  drivers/pci/pci.h      |    2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a32ba75..8400f80 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -529,7 +529,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
> >  	return !!adev->power.flags.dsw_present;
> >  }
> >  
> > -static struct pci_platform_pm_ops acpi_pci_platform_pm = {
> > +static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
> >  	.is_manageable = acpi_pci_power_manageable,
> >  	.set_state = acpi_pci_set_power_state,
> >  	.choose_state = acpi_pci_choose_state,
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 314db8c..d1a7105 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -527,9 +527,9 @@ static void pci_restore_bars(struct pci_dev *dev)
> >  		pci_update_resource(dev, i);
> >  }
> >  
> > -static struct pci_platform_pm_ops *pci_platform_pm;
> > +static const struct pci_platform_pm_ops *pci_platform_pm;
> >  
> > -int pci_set_platform_pm(struct pci_platform_pm_ops *ops)
> > +int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
> >  {
> >  	if (!ops->is_manageable || !ops->set_state || !ops->choose_state
> >  	    || !ops->sleep_wake)
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index d390fc1..f6f151a 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -68,7 +68,7 @@ struct pci_platform_pm_ops {
> >  	bool (*need_resume)(struct pci_dev *dev);
> >  };
> >  
> > -int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
> > +int pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
> >  void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
> >  void pci_power_up(struct pci_dev *dev);
> >  void pci_disable_enabled_device(struct pci_dev *dev);
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
