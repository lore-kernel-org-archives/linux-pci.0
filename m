Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC87C282D5
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F4921848
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 07:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfA3HlB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:41:01 -0500
Received: from verein.lst.de ([213.95.11.211]:50653 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfA3HlB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 02:41:01 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 402C968CEC; Wed, 30 Jan 2019 08:40:59 +0100 (CET)
Date:   Wed, 30 Jan 2019 08:40:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        John Garry <john.garry@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        anthony.jebson@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC PATCH] USB: PCI: set 32bit DMA mask for PCI based USB
 controllers
Message-ID: <20190130074059.GA29458@lst.de>
References: <1548831714-3706-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548831714-3706-1-git-send-email-guohanjun@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 03:01:54PM +0800, Hanjun Guo wrote:
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

dma_coerce_mask_and_coherent is only for platform devices (and I'm
not sure it is a good idea to start with, but that is a different
story).

PCI device should have the dma_mask pointer set already, so you should
use dma_set_mask_and_coherent here.
