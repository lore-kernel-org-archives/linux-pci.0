Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:43714 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbaE2WNf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 May 2014 18:13:35 -0400
Received: by mail-ie0-f182.google.com with SMTP id x19so968580ier.27
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2014 15:13:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1401346866-11648-4-git-send-email-wangyijing@huawei.com>
References: <1401346866-11648-1-git-send-email-wangyijing@huawei.com>
	<1401346866-11648-4-git-send-email-wangyijing@huawei.com>
Date: Thu, 29 May 2014 15:13:35 -0700
Message-ID: <CAE9FiQULQuKk2yFePQu90fRBtB0eDjhOfJtYHYb_Hx2ANrpvCw@mail.gmail.com>
Subject: Re: [PATCH 3/3] edac: remove the unnecessary checking for pci_bus_add_device
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>, Ingo Molnar <mingo@elte.hu>,
	Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 29, 2014 at 12:01 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Pci_bus_add_device() always return 0, remove the unnecessary
> checking for pci_bus_add_device().
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/edac/i82875p_edac.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
> index 8d0450b..8705ba6 100644
> --- a/drivers/edac/i82875p_edac.c
> +++ b/drivers/edac/i82875p_edac.c
> @@ -293,12 +293,7 @@ static int i82875p_setup_overfl_dev(struct pci_dev *pdev,
>                 if (dev == NULL)
>                         return 1;
>
> -               err = pci_bus_add_device(dev);
> -               if (err) {
> -                       i82875p_printk(KERN_ERR,
> -                               "%s(): pci_bus_add_device() Failed\n",
> -                               __func__);
> -               }
> +               pci_bus_add_device(dev);
>                 pci_bus_assign_resources(dev->bus);
>         }

Bjorn,

At same time, can you please apply

http://patchwork.ozlabs.org/patch/242480/

PCI, EDAC: fix ordering assign resource and bus_add

Thanks

Yinghai
