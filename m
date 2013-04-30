Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:46400 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761191Ab3D3Qp5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Apr 2013 12:45:57 -0400
Received: by mail-oa0-f47.google.com with SMTP id n9so687901oag.6
        for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2013 09:45:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130430074454.GF7237@elgon.mountain>
References: <20130430074454.GF7237@elgon.mountain>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 30 Apr 2013 10:45:35 -0600
Message-ID: <CAErSpo64WyM=4c3WC8hy-xy2gNgWtkJVTqzawRU6d6=t6nxnoQ@mail.gmail.com>
Subject: Re: [patch] PCI: set ->mask_pos correctly
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 30, 2013 at 1:44 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The "+" operation has higher precedence than "?:" and ->msi_cap is
> always non-zero here so the original statement is equivalent to:
>
>         entry->mask_pos = PCI_MSI_MASK_64;
>
> Which wasn't the intent.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ouch, my fault, sorry about that.  Thanks for finding this.  I put
this in my for-linus branch and will try to get this in before
v3.10-rc1.

How did you find this?  I guess MSI didn't work right on a device with
32-bit message address and per-vector masking?

Bjorn

> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d40bed7..2c10752 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -563,8 +563,10 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>         entry->msi_attrib.default_irq   = dev->irq;     /* Save IOAPIC IRQ */
>         entry->msi_attrib.pos           = dev->msi_cap;
>
> -       entry->mask_pos = dev->msi_cap + (control & PCI_MSI_FLAGS_64BIT) ?
> -               PCI_MSI_MASK_64 : PCI_MSI_MASK_32;
> +       if (control & PCI_MSI_FLAGS_64BIT)
> +               entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
> +       else
> +               entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
>         /* All MSIs are unmasked by default, Mask them all */
>         if (entry->msi_attrib.maskbit)
>                 pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
