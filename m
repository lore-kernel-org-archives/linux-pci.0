Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4687C282C7
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 09:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49A5218D3
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 09:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfAaJyl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:54:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbfAaJyl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 04:54:41 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B956D4BE696AC09AFFF3;
        Thu, 31 Jan 2019 17:54:38 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 17:54:31 +0800
Subject: Re: [RFC PATCH] USB: PCI: set 32bit DMA mask for PCI based USB
 controllers
To:     Hanjun Guo <guohanjun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <1548831714-3706-1-git-send-email-guohanjun@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <anthony.jebson@huawei.com>, Hanjun Guo <hanjun.guo@linaro.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f9a8ab1f-d560-0fb6-dfc9-61be3c1a2d82@huawei.com>
Date:   Thu, 31 Jan 2019 09:54:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1548831714-3706-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/01/2019 07:01, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> We met an issue that when we update the IORT table to revision D,
> and the kernel update to 4.19, the USB on D06 (ARM64 based server)
> will probe fail:
>
> [   13.495751] CPU: 0 PID: 15 Comm: kworker/0:1 Not tainted 4.19.0-00115-gb2b5200 #5
> [   13.503219] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 - V1.09.02 12/25/2018
> [   13.511645] Workqueue: events work_for_cpu_fn
> [   13.515989] pstate: a0c00009 (NzCv daif +PAN +UAO)
> [   13.520767] pc : dma_pool_alloc+0x218/0x270
> [   13.524937] lr : dma_pool_alloc+0xa0/0x270
> [   13.529019] sp : ffff000009e23b20
> [   13.532320] x29: ffff000009e23b20 x28: ffff8027c58ad098
> [   13.537619] x27: 0000000000001000 x26: ffff8027d7a790a8
> [   13.542918] x25: ffff000008fa7000 x24: ffff000009e23bc0
> [   13.548216] x23: 00000000006000c0 x22: ffff8027c58ad010
> [   13.553515] x21: ffff0000097e1000 x20: ffff8027c58ad000
> [   13.558814] x19: ffff8027c58ad080 x18: ffffffffffffffff
> [   13.564112] x17: 0000000000000000 x16: 0000000000007fff
> [   13.569411] x15: ffff0000097e16c8 x14: ffff8027c5d39885
> [   13.574709] x13: ffff8027c5d39884 x12: 0000000000000038
> [   13.580008] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> [   13.585307] x9 : 0000000000000000 x8 : ffff8027c587c400
> [   13.590605] x7 : 0000000000000000 x6 : 000000000000003f
> [   13.595904] x5 : ffff8027dc5b8000 x4 : ffff8027e09b91e0
> [   13.601202] x3 : 00000000008d2280 x2 : ffff8027c58ad100
> [   13.606501] x1 : 0000000000000028 x0 : 0000000000000000
> [   13.611800] Call trace:
> [   13.614234]  dma_pool_alloc+0x218/0x270
> [   13.617710] ata1: SATA link down (SStatus 0 SControl 300)
> [   13.618059]  ehci_qh_alloc+0x5c/0xf8
> [   13.627002]  ehci_setup+0x17c/0x4b8
> [   13.630478]  ehci_pci_setup+0x18c/0x5b8
> [   13.634301]  usb_add_hcd+0x290/0x7a0
> [   13.637863]  usb_hcd_pci_probe+0x2cc/0x3e8
> [   13.641946]  ehci_pci_probe+0x34/0x48
> [   13.645596]  local_pci_probe+0x3c/0xb0
> [   13.649331]  work_for_cpu_fn+0x18/0x28
> [   13.653067]  process_one_work+0x1e4/0x458
> [   13.657063]  worker_thread+0x228/0x450
> [   13.660798]  kthread+0x12c/0x130
> [   13.664014]  ret_from_fork+0x10/0x18
> [   13.667577] ---[ end trace 6f8757456e2ec456 ]---
>
> It turns out the the IORT revision D introduce the DMA address
> limit size for PCI RC and in commit 5ac65e8c8941 ("ACPI/IORT: Support
> address size limit for root complexes"), will set the DMA mask
> for the RC and that will be inherited by device under the RC.
>
> D06 only enables 1 RC but has EPs with different DMA address sizes,
> for USB it use 32bit DMA, and 64bit for HNS and SAS, so this will
> cause probe failure if we use 64bit DMA for USB controllers.
>
> Set the DMA mask to 32bit for PCI based USB controllers,
> EHCI and OHCI USB controllers are using 32bit DMA address,
> XHCI will set the DMA mask in its probe after the pci probe,
> so it's safe just add dma_coerce_mask_and_coherent() in
> usb_hcd_pci_probe().
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
> Hi all,
>
> This is the RFC version, I'm not sure this is the best solution,
> comments are warmly welcomed.
>
> Thanks
> Hanjun
>
>  drivers/usb/core/hcd-pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 0343246..a9c33e6 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -188,6 +188,10 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (pci_enable_device(dev) < 0)
>  		return -ENODEV;
>
> +	retval = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
> +	if (retval)
> +		return retval;

Hi Hanjun,

You're missing tidy-up upon failure.

thanks,
John

> +
>  	/*
>  	 * The xHCI driver has its own irq management
>  	 * make sure irq setup is not touched for xhci in generic hcd code
>


