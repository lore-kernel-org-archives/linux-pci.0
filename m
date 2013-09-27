Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:60442 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab3I0VEI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 17:04:08 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so5056865iej.6
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2013 14:04:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1378974012-13364-1-git-send-email-wangyijing@huawei.com>
References: <1378974012-13364-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 27 Sep 2013 15:03:46 -0600
Message-ID: <CAErSpo5XWa3qTfE_p5vDqJOkrrdkcM9_Nr-u_qFYSdAob1sEig@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Warn if power_state != PCI_D0 when write MSI message
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ben]

On Thu, Sep 12, 2013 at 2:20 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> When we setup MSI, if device power state is not equal to PCI_D0,
> system will silently ignore writing MSI message, but pci_enable_msi()
> still return 0 which seems setup successfully. So we should warn here
> to help diagnose this issue.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index aca7578..25ed59d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -291,6 +291,8 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
>         if (entry->dev->current_state != PCI_D0) {
>                 /* Don't touch the hardware now */
> +               dev_warn(&entry->dev->dev,
> +                       "current_state != PCI_D0, ignore writing MSI message!\n");

Is there a real problem here?  If there is a real problem, a printk
doesn't help fix it.  If there's no problem, I don't see the point of
this printk.

I would expect that if the device is not in D0, we should remember the
hardware updates that need to be made, and if the device returns to
D0, we should apply the updates then.  If that's the case this is not
an error and we shouldn't warn about it.

Bjorn

>         } else if (entry->msi_attrib.is_msix) {
>                 void __iomem *base;
>                 base = entry->mask_base +
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
