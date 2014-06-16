Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:45330 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbaFPUo4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jun 2014 16:44:56 -0400
Received: by mail-ig0-f173.google.com with SMTP id r2so3419533igi.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2014 13:44:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1402918182-13082-1-git-send-email-yan@linux.vnet.ibm.com>
References: <1402918182-13082-1-git-send-email-yan@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 16 Jun 2014 14:44:34 -0600
Message-ID: <CAErSpo5KepA52w0G2aa2y0-5W32FAkxoVQ+Kdo+hHsR2270Oxw@mail.gmail.com>
Subject: Re: [PATCH] PCI: don't UNSET resource even reassign fails
To: Guo Chao <yan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 16, 2014 at 5:29 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> Commit bd064f0a sets IORESOURCE_UNSET flag if resource can not be
> assgined. Part of these changes breaks resource assignment.
>
> If resource is too big, PCI core assgins basic part first and
> extends (reassigns) it to include optional part (notably SR-IOV resources).
> In this case, failure is permitted and IORESOURCE_UNSET should be not set.
> Otherwise, these resources are never updated to hardware even they are
> already propery assigned and we will see errors like this:
>
>         pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
>         pci 0003:00:00.0: Error enabling bridge (-22), continuing

Please attach a complete dmesg log so I can look at this in more
detail.  Thanks!

> Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-res.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index caed1ce..1e1076a 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -334,12 +334,14 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
>         new_size = resource_size(res) + addsize;
>         ret = _pci_assign_resource(dev, resno, new_size, min_align);
>         if (!ret) {
> -               res->flags &= ~IORESOURCE_UNSET;
>                 res->flags &= ~IORESOURCE_STARTALIGN;
>                 dev_info(&dev->dev, "BAR %d: reassigned %pR\n", resno, res);
>                 if (resno < PCI_BRIDGE_RESOURCES)
>                         pci_update_resource(dev, resno);
>         }
> +
> +       res->flags &= ~IORESOURCE_UNSET;
> +
>         return ret;
>  }
>
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
