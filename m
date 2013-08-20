Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:43246 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab3HTRJR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2013 13:09:17 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so1062335obb.18
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2013 10:09:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.03.1308201637390.1566@linux.vnet.ibm.com>
References: <alpine.LFD.2.03.1308201637390.1566@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 20 Aug 2013 11:08:56 -0600
Message-ID: <CAErSpo4qnDyQQt+sZi=1tj0PP+HUmLfMp4zQ2hdqjJ+mOcAzYA@mail.gmail.com>
Subject: Re: [PATCH] PCI: add hibernation hooks
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 20, 2013 at 8:41 AM, Sebastian Ott
<sebott@linux.vnet.ibm.com> wrote:
> Hello Bjorn,
>
> I'm currently trying to implement hibernate support for pci on s390. To access
> the config space of a pci function on s390 the function has to be enabled first.
> So I need some kind of callback to achieve this before the pci core or the device
> driver tries to access the function after a resume from hibernate.
>
> Would you be OK with the following patch?

I think doing something like this is fine.

What would it look like if we provided empty weak definitions of the
eight functions you need to hook: pcibios_pm_freeze(),
pcibios_pm_freeze_noirq(), etc.?  Then the callers wouldn't have to do
a test before making the call.  Not sure which would be better, but it
might be more obvious that this is a build-time binding rather than a
dynamic binding.

Should we check return values from the arch code?

> ---
> PCI: add hibernation hooks
>
> Platforms may want to provide architecture-specific functionality when
> a PCI device is doing a hibernate transition. Add a weak symbol
> pcibios_pm_ops that architectures can override to do so.
>
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci-driver.c |   30 ++++++++++++++++++++++++++++++
>  include/linux/pci.h      |    4 ++++
>  2 files changed, 34 insertions(+)
>
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -763,6 +763,13 @@ static int pci_pm_resume(struct device *
>
>  #ifdef CONFIG_HIBERNATE_CALLBACKS
>
> +
> +/*
> + * pcibios_pm_ops - provide arch specific hooks when a pci device is doing
> + * a hibernate transition
> + */
> +struct dev_pm_ops __weak pcibios_pm_ops;

For example:

int __weak pcibios_pm_freeze(struct device *) { return 0; }

>  static int pci_pm_freeze(struct device *dev)
>  {
>         struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -786,6 +793,9 @@ static int pci_pm_freeze(struct device *
>                         return error;
>         }
>
> +       if (pcibios_pm_ops.freeze)
> +               pcibios_pm_ops.freeze(dev);

    return pcibios_pm_freeze(dev);

>         return 0;
>  }
>
> @@ -811,6 +821,9 @@ static int pci_pm_freeze_noirq(struct de
>
>         pci_pm_set_unknown_state(pci_dev);
>
> +       if (pcibios_pm_ops.freeze_noirq)
> +               pcibios_pm_ops.freeze_noirq(dev);
> +
>         return 0;
>  }
>
> @@ -820,6 +833,9 @@ static int pci_pm_thaw_noirq(struct devi
>         struct device_driver *drv = dev->driver;
>         int error = 0;
>
> +       if (pcibios_pm_ops.thaw_noirq)
> +               pcibios_pm_ops.thaw_noirq(dev);
> +
>         if (pci_has_legacy_pm_support(pci_dev))
>                 return pci_legacy_resume_early(dev);
>
> @@ -837,6 +853,9 @@ static int pci_pm_thaw(struct device *de
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>         int error = 0;
>
> +       if (pcibios_pm_ops.thaw)
> +               pcibios_pm_ops.thaw(dev);
> +
>         if (pci_has_legacy_pm_support(pci_dev))
>                 return pci_legacy_resume(dev);
>
> @@ -878,6 +897,9 @@ static int pci_pm_poweroff(struct device
>   Fixup:
>         pci_fixup_device(pci_fixup_suspend, pci_dev);
>
> +       if (pcibios_pm_ops.poweroff)
> +               pcibios_pm_ops.poweroff(dev);
> +
>         return 0;
>  }
>
> @@ -911,6 +933,9 @@ static int pci_pm_poweroff_noirq(struct
>         if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
>                 pci_write_config_word(pci_dev, PCI_COMMAND, 0);
>
> +       if (pcibios_pm_ops.poweroff_noirq)
> +               pcibios_pm_ops.poweroff_noirq(dev);
> +
>         return 0;
>  }
>
> @@ -920,6 +945,9 @@ static int pci_pm_restore_noirq(struct d
>         struct device_driver *drv = dev->driver;
>         int error = 0;
>
> +       if (pcibios_pm_ops.restore_noirq)
> +               pcibios_pm_ops.restore_noirq(dev);
> +
>         pci_pm_default_resume_early(pci_dev);
>
>         if (pci_has_legacy_pm_support(pci_dev))
> @@ -937,6 +965,8 @@ static int pci_pm_restore(struct device
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>         int error = 0;
>
> +       if (pcibios_pm_ops.restore)
> +               pcibios_pm_ops.restore(dev);
>         /*
>          * This is necessary for the hibernation error path in which restore is
>          * called without restoring the standard config registers of the device.
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1648,6 +1648,10 @@ int pcibios_set_pcie_reset_state(struct
>  int pcibios_add_device(struct pci_dev *dev);
>  void pcibios_release_device(struct pci_dev *dev);
>
> +#ifdef CONFIG_HIBERNATE_CALLBACKS
> +extern struct dev_pm_ops pcibios_pm_ops;
> +#endif
> +
>  #ifdef CONFIG_PCI_MMCONFIG
>  void __init pci_mmcfg_early_init(void);
>  void __init pci_mmcfg_late_init(void);
>
