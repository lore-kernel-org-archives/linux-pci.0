Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:63697 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761698Ab3DDQCj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 12:02:39 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn14so1747623obc.32
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2013 09:02:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365075572-20763-2-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com> <1365075572-20763-2-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Apr 2013 10:02:19 -0600
Message-ID: <CAErSpo6eSz_7yUFGQcfrwH1U838Z_iwgqS3mi=+OkCcTHbcakA@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI: Cache MSI/MSI-X cap in PCI device
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 4, 2013 at 5:39 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> The patch caches the MSI and MSI-X capability offset in PCI device
> (struct pci_dev) so that we needn't poll it from the config space
> upon enabling or disabling MSI or MSI-X interrupts.
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/msi.c   |   36 +++++++++++++++++++-----------------
>  include/linux/pci.h |    2 ++
>  2 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 00cc78c..3459bdf 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -111,31 +111,31 @@ void default_restore_msi_irqs(struct pci_dev *dev, int irq)
>  }
>  #endif
>
> -static void msi_set_enable(struct pci_dev *dev, int pos, int enable)
> +static void msi_set_enable(struct pci_dev *dev, int enable)
>  {
>         u16 control;
>
> -       BUG_ON(!pos);
> +       BUG_ON(!dev->msi_cap);
>
> -       pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
> +       pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
>         control &= ~PCI_MSI_FLAGS_ENABLE;
>         if (enable)
>                 control |= PCI_MSI_FLAGS_ENABLE;
> -       pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
> +       pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
>  }
>
>  static void msix_set_enable(struct pci_dev *dev, int enable)
>  {
> -       int pos;
>         u16 control;
>
> -       pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> -       if (pos) {
> -               pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
> +       if (dev->msix_cap) {
> +               pci_read_config_word(dev,
> +                       dev->msix_cap + PCI_MSIX_FLAGS, &control);
>                 control &= ~PCI_MSIX_FLAGS_ENABLE;
>                 if (enable)
>                         control |= PCI_MSIX_FLAGS_ENABLE;
> -               pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
> +               pci_write_config_word(dev,
> +                       dev->msix_cap + PCI_MSIX_FLAGS, control);
>         }
>  }
>
> @@ -402,7 +402,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
>         pos = entry->msi_attrib.pos;
>
>         pci_intx_for_msi(dev, 0);
> -       msi_set_enable(dev, pos, 0);
> +       msi_set_enable(dev, 0);
>         arch_restore_msi_irqs(dev, dev->irq);
>
>         pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
> @@ -557,7 +557,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>         unsigned mask;
>
>         pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> -       msi_set_enable(dev, pos, 0);    /* Disable MSI during set up */
> +       msi_set_enable(dev, 0); /* Disable MSI during set up */
>
>         pci_read_config_word(dev, msi_control_reg(pos), &control);
>         /* MSI Entry Initialization */
> @@ -598,7 +598,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>
>         /* Set MSI enabled bits  */
>         pci_intx_for_msi(dev, 0);
> -       msi_set_enable(dev, pos, 1);
> +       msi_set_enable(dev, 1);
>         dev->msi_enabled = 1;
>
>         dev->irq = entry->irq;
> @@ -885,7 +885,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
>         desc = list_first_entry(&dev->msi_list, struct msi_desc, list);
>         pos = desc->msi_attrib.pos;
>
> -       msi_set_enable(dev, pos, 0);
> +       msi_set_enable(dev, 0);
>         pci_intx_for_msi(dev, 1);
>         dev->msi_enabled = 0;
>
> @@ -1048,15 +1048,17 @@ EXPORT_SYMBOL(pci_msi_enabled);
>
>  void pci_msi_init_pci_dev(struct pci_dev *dev)
>  {
> -       int pos;
>         INIT_LIST_HEAD(&dev->msi_list);
>
>         /* Disable the msi hardware to avoid screaming interrupts
>          * during boot.  This is the power on reset default so
>          * usually this should be a noop.
>          */
> -       pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> -       if (pos)
> -               msi_set_enable(dev, pos, 0);
> +       dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
> +       if (dev->msi_cap)
> +               msi_set_enable(dev, 0);
> +
> +       /* We needn't check if we have valid MSI-X capability here */
> +       dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
>         msix_set_enable(dev, 0);

Sheesh, this is a gratuitous difference between msi_set_enable() and
msix_set_enable().

Personally, I would remove the BUG_ON from msi_set_enable() and remove
the "if (pos)" from msix_set_enable() and make sure we never call them
when dev->msi_cap or dev->msix_cap are NULL, respectively.  This is
probably the only place where we'd need to add a guard to keep from
calling msix_set_enable().

>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2461033a..f8314c7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -249,6 +249,8 @@ struct pci_dev {
>         pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
>                                            this is D0-D3, D0 being fully functional,
>                                            and D3 being off. */
> +       int             msi_cap;        /* MSI capability offset */
> +       int             msix_cap;       /* MSI-X capability offset */

MSI and MSI-X are defined by PCI 3.0, so these capabilities must be in
PCI Configuration Space (not in the PCIe Extended Configuration
Space).  So u8 is big enough for these.  The same is true for pm_cap
below.

>         int             pm_cap;         /* PM capability offset in the
>                                            configuration space */
>         unsigned int    pme_support:5;  /* Bitmask of states from which PME#
> --
> 1.7.5.4
>
