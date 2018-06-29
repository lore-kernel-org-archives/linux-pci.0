Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36246 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933514AbeF2PjP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 11:39:15 -0400
Date: Fri, 29 Jun 2018 16:41:01 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com, devel@linuxdriverproject.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in new_pcichild_device
Message-ID: <20180629154101.GI9643@red-moon>
References: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 18, 2018 at 10:53:28PM +0800, Jia-Ju Bai wrote:
> new_pcichild_device() is not called in atomic context.
> 
> The call chain ending up at new_pcichild_device() is:
> [1] new_pcichild_device() <- pci_devices_present_work()
> pci_devices_present_work() is only set in INIT_WORK().
> 
> Despite never getting called from atomic context,
> new_pcichild_device() calls kzalloc with GFP_ATOMIC,
> which waits busily for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL
> to avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/hv for v4.19, thanks.

Lorenzo

> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 0fe3ea1..289e31d 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1500,7 +1500,7 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	unsigned long flags;
>  	int ret;
>  
> -	hpdev = kzalloc(sizeof(*hpdev), GFP_ATOMIC);
> +	hpdev = kzalloc(sizeof(*hpdev), GFP_KERNEL);
>  	if (!hpdev)
>  		return NULL;
>  
> -- 
> 1.9.1
> 
