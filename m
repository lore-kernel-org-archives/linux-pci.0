Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53322 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbbDBDy6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Apr 2015 23:54:58 -0400
Date: Thu, 2 Apr 2015 11:54:49 +0800
From: Fam Zheng <famz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v5 04/10] pci: don't disable msi/msix at shutdown
Message-ID: <20150402035449.GG15412@fam-t430.nay.redhat.com>
References: <1427641227-7574-1-git-send-email-mst@redhat.com>
 <1427641227-7574-5-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427641227-7574-5-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 03/29 17:04, Michael S. Tsirkin wrote:
> This partially reverts commit d52877c7b1afb8c37ebe17e2005040b79cb618b0:
> 	"pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2"
> 
> It's un-necessary now that we disable msi at start, and it actually
> turns out to cause problems: some device drivers don't register a level
> interrupt handler when they detect msi/msix capability, switching off
> msi while device is going causes device to assert a level interrupt
> which is never de-asserted, causing a kernel hang.
> 
> In particular, this was observed with virtio.
> 
> Cc: Yinghai Lu <yhlu.kernel.send@gmail.com>
> Cc: Ulrich Obergfell <uobergfe@redhat.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Reported-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Fam Zheng <famz@redhat.com>

> ---
>  drivers/pci/pci-driver.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3cb2210..38a602c 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -450,8 +450,6 @@ static void pci_device_shutdown(struct device *dev)
>  
>  	if (drv && drv->shutdown)
>  		drv->shutdown(pci_dev);
> -	pci_msi_shutdown(pci_dev);
> -	pci_msix_shutdown(pci_dev);
>  
>  #ifdef CONFIG_KEXEC
>  	/*
> -- 
> MST
> 
