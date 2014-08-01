Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:46154 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbaHADvO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jul 2014 23:51:14 -0400
Received: by mail-qg0-f49.google.com with SMTP id j107so5190434qga.36
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2014 20:51:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.03.1407311500570.16821@solarflare.com>
References: <53D9288B.5030302@solarflare.com>
	<53D93407.8040308@redhat.com>
	<53D93848.7070203@solarflare.com>
	<53D9602A.4010406@intel.com>
	<53DA3180.5040302@solarflare.com>
	<alpine.LFD.2.03.1407311500570.16821@solarflare.com>
Date: Fri, 1 Aug 2014 11:51:13 +0800
Message-ID: <CABawtvPwxovKV==8RVCL1OcsdfnZDDjr=d1uYp-A=bAzYbmKww@mail.gmail.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
From: Ethan Zhao <ethan.kernel@gmail.com>
To: Edward Cree <ecree@solarflare.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Though I like this patch, it shows direct style, but it will change
the meaning of a function not mentioned here.

  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)

So far seems no driver call pci_sriov_set_totalvfs() with numvfs = 0
and the patch will change the behavior of the drivers, but it will
definitely change the test cases and documents related to IOV.

Thanks,
Ethan

On Thu, Jul 31, 2014 at 10:24 PM, Edward Cree <ecree@solarflare.com> wrote:
> Make a driver_max_VFs of 0 mean 0, instead of total_VFs as previously.
> Initialise driver_max_VFs to total_VFs instead of 0.
>
> Signed-off-by: Edward Cree <ecree@solarflare.com>
> ---
> Only existing callers are ixgbe and igb, and neither passes 0, so this
> doesn't break existing users.
> ---
>  drivers/pci/iov.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index cb6f247..fb51467 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -381,7 +381,7 @@ found:
>         iov->pos = pos;
>         iov->nres = nres;
>         iov->ctrl = ctrl;
> -       iov->total_VFs = total;
> +       iov->driver_max_VFs = iov->total_VFs = total;
>         iov->offset = offset;
>         iov->stride = stride;
>         iov->pgsz = pgsz;
> @@ -686,9 +686,6 @@ int pci_sriov_get_totalvfs(struct pci_dev *dev)
>         if (!dev->is_physfn)
>                 return 0;
>
> -       if (dev->sriov->driver_max_VFs)
> -               return dev->sriov->driver_max_VFs;
> -
> -       return dev->sriov->total_VFs;
> +       return dev->sriov->driver_max_VFs;
>  }
>  EXPORT_SYMBOL_GPL(pci_sriov_get_totalvfs);
> --
> 1.7.11.7
> The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
