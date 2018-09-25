Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34226C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 01:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BD520C0A
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 01:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BD520C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeIYHTJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 03:19:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:49700 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbeIYHTJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 03:19:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8P1DgF0004521;
        Mon, 24 Sep 2018 20:13:43 -0500
Message-ID: <4fc055a6ead393b4adac20929291b7ca9ae959b6.camel@kernel.crashing.org>
Subject: Re: [PATCH 11/12] PCI/AER: Use managed resource allocations
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
        poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>,
        Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Tue, 25 Sep 2018 11:13:42 +1000
In-Reply-To: <20180918235848.26694-12-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
         <20180918235848.26694-12-keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-09-18 at 17:58 -0600, Keith Busch wrote:
> This uses the managed device resource allocations for the service data
> so that the aer driver doesn't need to manage it, further simplifying
> this driver.

Just be careful (it migh be ok, I haven't audited everything, but I got
bitten by something like that in the past) that the devm stuff will get
disposed of in two cases:

 - The owner device going away (so far so good)

 - The owner device's driver being unbound

The latter is something not completely obvious, ie, even if the owner
device still has held references, the successful completion of
->remove() on the driver will be followed by a cleanup of the managed
stuff.

As I said, it might be ok in the AER case, but you might want to at
least keep the set_service_data(dev, NULL) to make sure you don't leave
a stale pointer there.

Cheers,
Ben.

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1878d9d7760b..7ecad011458d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1366,11 +1366,7 @@ static void aer_remove(struct pcie_device *dev)
>  {
>  	struct aer_rpc *rpc = get_service_data(dev);
>  
> -	if (rpc) {
> -		aer_disable_rootport(rpc);
> -		kfree(rpc);
> -		set_service_data(dev, NULL);
> -	}
> +	aer_disable_rootport(rpc);
>  }
>  
>  /**
> @@ -1383,10 +1379,9 @@ static int aer_probe(struct pcie_device *dev)
>  {
>  	int status;
>  	struct aer_rpc *rpc;
> -	struct device *device = &dev->port->device;
> +	struct device *device = &dev->device;
>  
> -	/* Alloc rpc data structure */
> -	rpc = kzalloc(sizeof(struct aer_rpc), GFP_KERNEL);
> +	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
>  	if (!rpc) {
>  		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
>  		return -ENOMEM;
> @@ -1394,13 +1389,11 @@ static int aer_probe(struct pcie_device *dev)
>  	rpc->rpd = dev->port;
>  	set_service_data(dev, rpc);
>  
> -	/* Request IRQ ISR */
> -	status = request_threaded_irq(dev->irq, aer_irq, aer_isr,
> -				      IRQF_SHARED, "aerdrv", dev);
> +	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
> +					   IRQF_SHARED, "aerdrv", dev);
>  	if (status) {
>  		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
>  			   dev->irq);
> -		aer_remove(dev);
>  		return status;
>  	}
>  

