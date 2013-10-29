Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:53719 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3J2TgV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 15:36:21 -0400
Received: by mail-ie0-f179.google.com with SMTP id aq17so563091iec.24
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2013 12:36:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1381409891-4704-1-git-send-email-wangyijing@huawei.com>
References: <1381409891-4704-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 29 Oct 2013 13:36:00 -0600
Message-ID: <CAErSpo46G7AvQokffpn5YDD9bjCU5fSwdurk3yTd5T5CGmwZtA@mail.gmail.com>
Subject: Re: [Update PATCH -v2] PCI: Avoid initialize MSI/MSIX if device power
 state != PCI_D0
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 10, 2013 at 6:58 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Currently, if device power state != PCI_D0, we still initialize
> device MSI/MSIX, but we won't write the MSI message to device
> MSI/MSIX registers. It's weird, we don't configure MSI/MSIX
> registers properly, but pci_enable_msi() or pci_enable_msix()
> return success, and even these registers will never be updated later.
> So I think it should return error if device power state != PCI_D0.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Acked-by: Ben Hutchings <bhutchings@solarflare.com>

Applied to my pci/misc branch for v3.13, thanks!

Bjorn

>
> ---
>
> v1->v2: keep __write_msi_msg() function device power state statement,
>             because Ben Hutchings point out this function may be called
>                 during device in D3 state to set irq affinity. We should not
>                 touch that.
> ---
>  drivers/pci/msi.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d5f90d6..604265c 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -831,7 +831,7 @@ int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
>         int status, maxvec;
>         u16 msgctl;
>
> -       if (!dev->msi_cap)
> +       if (!dev->msi_cap || dev->current_state != PCI_D0)
>                 return -EINVAL;
>
>         pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
> @@ -862,7 +862,7 @@ int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec)
>         int ret, nvec;
>         u16 msgctl;
>
> -       if (!dev->msi_cap)
> +       if (!dev->msi_cap || dev->current_state != PCI_D0)
>                 return -EINVAL;
>
>         pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
> @@ -955,7 +955,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
>         int status, nr_entries;
>         int i, j;
>
> -       if (!entries || !dev->msix_cap)
> +       if (!entries || !dev->msix_cap || dev->current_state != PCI_D0)
>                 return -EINVAL;
>
>         status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSIX);
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
