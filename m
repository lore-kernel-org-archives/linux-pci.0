Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5366C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B668D2075C
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553631659;
	bh=WlX3mKU7ybiZhB/KyE7ButxaXqtd5qA2M5Dl9dJjWTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dwcl8RdIqgCpadhfeT60+KL82I97gRiyZEHaJphdEiHXOViVvMgmyjJ16JTON9TJh
	 y/OOiXI3iYD+CFuD2u1vNSeu1fqv+uHUFinvW/BwQsexfCRNbKQuK88xW/HT2OyOt9
	 GDCUQhw859p+WKgCfvEoc32LBj1ZC+QIlg2dmjzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfCZUU7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731736AbfCZUU7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 16:20:59 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5473820657;
        Tue, 26 Mar 2019 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553631657;
        bh=WlX3mKU7ybiZhB/KyE7ButxaXqtd5qA2M5Dl9dJjWTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCpYKWtMfFgGUD3pGqWHfPg5Urxvob4sjxEJnjqf/ReMO4qSgGqsTwea34UhdNTdM
         Ybd46hyXcUeIUeC/pupENwrrx5bFZQOdDI6cmbUXvw6W44eeGc4n2KHUH6pbi+ztCh
         Crmf+Kk96tntguibsrvalzBYHjq6SwDnIWnBax4k=
Date:   Tue, 26 Mar 2019 15:20:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v4 08/21] nvme-pci: Handle movable BARs
Message-ID: <20190326202055.GP24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-9-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-9-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Keith, Jens, Christoph, Sagi, linux-nvme, LKML]

On Mon, Mar 11, 2019 at 04:31:09PM +0300, Sergey Miroshnichenko wrote:
> Hotplugged devices can affect the existing ones by moving their BARs.
> PCI subsystem will inform the NVME driver about this by invoking
> reset_prepare()+reset_done(), then iounmap()+ioremap() must be called.

Do you mean the PCI core will invoke ->rescan_prepare() and
->rescan_done() (as opposed to *reset*)?

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/nvme/host/pci.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 92bad1c810ac..ccea3033a67a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -106,6 +106,7 @@ struct nvme_dev {
>  	unsigned int num_vecs;
>  	int q_depth;
>  	u32 db_stride;
> +	resource_size_t current_phys_bar;
>  	void __iomem *bar;
>  	unsigned long bar_mapped_size;
>  	struct work_struct remove_work;
> @@ -1672,13 +1673,16 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
> -	if (size <= dev->bar_mapped_size)
> +	if (dev->bar &&
> +	    dev->current_phys_bar == pci_resource_start(pdev, 0) &&
> +	    size <= dev->bar_mapped_size)
>  		return 0;
>  	if (size > pci_resource_len(pdev, 0))
>  		return -ENOMEM;
>  	if (dev->bar)
>  		iounmap(dev->bar);
> -	dev->bar = ioremap(pci_resource_start(pdev, 0), size);
> +	dev->current_phys_bar = pci_resource_start(pdev, 0);
> +	dev->bar = ioremap(dev->current_phys_bar, size);

dev->current_phys_bar is different from pci_resource_start() in the
case where the PCI core has moved the nvme BAR, but nvme has not yet
remapped it.

I'm not sure it's worth keeping track of current_phys_bar, as opposed
to always unmapping and remapping.  Is this a performance path?  I
think there are advantages to always exercising the same code path,
regardless of whether the BAR happened to be moved, e.g., if there's a
bug in the "BAR moved" path, it may be a heisenbug because whether we
exercise that path depends on the current configuration.

If you do need to cache current_phys_bar, maybe this, so it's a little
easier to see that you're not changing the ioremap() itself:

  dev->bar = ioremap(pci_resource_start(pdev, 0), size);
  dev->current_phys_bar = pci_resource_start(pdev, 0);

>  	if (!dev->bar) {
>  		dev->bar_mapped_size = 0;
>  		return -ENOMEM;
> @@ -2504,6 +2508,8 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
>  		goto out;
>  
> +	nvme_remap_bar(dev, db_bar_size(dev, 0));

How is this change connected to rescan?  This looks reset-related.

>  	/*
>  	 * If we're called to reset a live controller first shut it down before
>  	 * moving on.
> @@ -2910,6 +2916,23 @@ static void nvme_error_resume(struct pci_dev *pdev)
>  	flush_work(&dev->ctrl.reset_work);
>  }
>  
> +void nvme_rescan_prepare(struct pci_dev *pdev)
> +{
> +	struct nvme_dev *dev = pci_get_drvdata(pdev);
> +
> +	nvme_dev_disable(dev, false);
> +	nvme_dev_unmap(dev);
> +	dev->bar = NULL;
> +}
> +
> +void nvme_rescan_done(struct pci_dev *pdev)
> +{
> +	struct nvme_dev *dev = pci_get_drvdata(pdev);
> +
> +	nvme_dev_map(dev);
> +	nvme_reset_ctrl_sync(&dev->ctrl);
> +}
> +
>  static const struct pci_error_handlers nvme_err_handler = {
>  	.error_detected	= nvme_error_detected,
>  	.slot_reset	= nvme_slot_reset,
> @@ -2974,6 +2997,8 @@ static struct pci_driver nvme_driver = {
>  	},
>  	.sriov_configure = pci_sriov_configure_simple,
>  	.err_handler	= &nvme_err_handler,
> +	.rescan_prepare	= nvme_rescan_prepare,
> +	.rescan_done	= nvme_rescan_done,
>  };
>  
>  static int __init nvme_init(void)
> -- 
> 2.20.1
> 
