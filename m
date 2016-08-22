Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755731AbcHVTgZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 15:36:25 -0400
Date: Mon, 22 Aug 2016 14:36:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: hv: Use list_move_tail instead of
 list_del/list_add_tail
Message-ID: <20160822193618.GK18628@localhost>
References: <1469722608-14956-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469722608-14956-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 04:16:48PM +0000, Wei Yongjun wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Applied to pci/host-hv for v4.9, thanks!

> ---
>  drivers/pci/host/pci-hyperv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 6955ffdb..a8deeca 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1466,8 +1466,7 @@ static void pci_devices_present_work(struct work_struct *work)
>  			if (hpdev->reported_missing) {
>  				found = true;
>  				put_pcichild(hpdev, hv_pcidev_ref_childlist);
> -				list_del(&hpdev->list_entry);
> -				list_add_tail(&hpdev->list_entry, &removed);
> +				list_move_tail(&hpdev->list_entry, &removed);
>  				break;
>  			}
>  		}
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
