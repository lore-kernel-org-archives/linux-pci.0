Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38626 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763682Ab3DDRRK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 13:17:10 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so3005849oag.22
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2013 10:17:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365075572-20763-4-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com> <1365075572-20763-4-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Apr 2013 11:16:49 -0600
Message-ID: <CAErSpo73=V5eHF4uWtc0FsEaFygGG7uDTsqCWzQsTEeiyH9gCA@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: Use cached MSI cap while enabling MSI interrupts
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 4, 2013 at 5:39 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> The patch intends to use the cached MSI capability offset in
> pci_dev instead of polling that from config space when enabling
> MSI interrupts.
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/msi.c |   19 +++++++++----------
>  1 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 5f51e10..182474d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -552,14 +552,14 @@ out_unroll:
>  static int msi_capability_init(struct pci_dev *dev, int nvec)
>  {
>         struct msi_desc *entry;
> -       int pos, ret;
> +       int ret;
>         u16 control;
>         unsigned mask;
>
> -       pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> -       msi_set_enable(dev, 0); /* Disable MSI during set up */
> +       /* Disable MSI during set up */
> +       msi_set_enable(dev, 0);
>
> -       pci_read_config_word(dev, msi_control_reg(pos), &control);
> +       pci_read_config_word(dev, msi_control_reg(dev->msi_cap), &control);

While you're at at, can you get rid of msi_control_reg() and friends?
They are needlessly different from the common style in this file,
e.g., "pos + PCI_MSI_FLAGS".

>         /* MSI Entry Initialization */
>         entry = alloc_msi_entry(dev);
>         if (!entry)
> @@ -570,9 +570,9 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>         entry->msi_attrib.entry_nr      = 0;
>         entry->msi_attrib.maskbit       = is_mask_bit_support(control);
>         entry->msi_attrib.default_irq   = dev->irq;     /* Save IOAPIC IRQ */
> -       entry->msi_attrib.pos           = pos;
> +       entry->msi_attrib.pos           = dev->msi_cap;
>
> -       entry->mask_pos = msi_mask_reg(pos, entry->msi_attrib.is_64);
> +       entry->mask_pos = msi_mask_reg(dev->msi_cap, entry->msi_attrib.is_64);
>         /* All MSIs are unmasked by default, Mask them all */
>         if (entry->msi_attrib.maskbit)
>                 pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
> @@ -818,13 +818,12 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
>   */
>  int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
>  {
> -       int status, pos, maxvec;
> +       int status, maxvec;
>         u16 msgctl;
>
> -       pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> -       if (!pos)
> +       if (!dev->msi_cap)
>                 return -EINVAL;
> -       pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
> +       pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
>         maxvec = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
>         if (nvec > maxvec)
>                 return maxvec;
> --
> 1.7.5.4
>
