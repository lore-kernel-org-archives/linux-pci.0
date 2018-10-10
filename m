Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74150C43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000F20841
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPC5LgvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0000F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbeJKEJH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbeJKEJH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 00:09:07 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E2B20870;
        Wed, 10 Oct 2018 20:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539204315;
        bh=qvD/jdZOiiyU3/nRCjwi3j+750OH6qLF4skxF9WBP2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPC5LgvIdq4BiQY13f/bozT0m6DECh/6tKa3kLVQ3JnDiOhlIIAIibqR/pMbLPQfK
         tEW0N5oy7U8WVhuSvBZEFpFHk+RIMOHv/5qg/B9xx5D0XJc2r3Sr+X34re94qzwFHG
         jOA+S7o7njKu0/E4O9/wVQ4yabFriUKGzsYMXWUc=
Date:   Wed, 10 Oct 2018 15:45:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: remove pci_set_dma_max_seg_size
Message-ID: <20181010204514.GI5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181009140824.18667-1-hch@lst.de>
 <20181009140824.18667-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009140824.18667-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc maintainers]

On Tue, Oct 09, 2018 at 04:08:24PM +0200, Christoph Hellwig wrote:
> The few callers can just use dma_set_max_seg_size directly.

I intend to apply this, just FYI about these trivial changes to your
drivers.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/sata_inic162x.c    | 2 +-
>  drivers/block/rsxx/core.c      | 2 +-
>  drivers/pci/probe.c            | 2 +-
>  drivers/s390/net/ism_drv.c     | 2 +-
>  drivers/scsi/aacraid/linit.c   | 2 +-
>  include/linux/pci-dma-compat.h | 9 ---------
>  6 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
> index 9b6d7930d1c7..e0bcf9b2dab0 100644
> --- a/drivers/ata/sata_inic162x.c
> +++ b/drivers/ata/sata_inic162x.c
> @@ -873,7 +873,7 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	 * like others but it will lock up the whole machine HARD if
>  	 * 65536 byte PRD entry is fed. Reduce maximum segment size.
>  	 */
> -	rc = pci_set_dma_max_seg_size(pdev, 65536 - 512);
> +	rc = dma_set_max_seg_size(&pdev->dev, 65536 - 512);
>  	if (rc) {
>  		dev_err(&pdev->dev, "failed to set the maximum segment size\n");
>  		return rc;
> diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
> index f2c631ce793c..37df486c7c3c 100644
> --- a/drivers/block/rsxx/core.c
> +++ b/drivers/block/rsxx/core.c
> @@ -780,7 +780,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
>  		goto failed_enable;
>  
>  	pci_set_master(dev);
> -	pci_set_dma_max_seg_size(dev, RSXX_HW_BLK_SIZE);
> +	dma_set_max_seg_size(&dev->dev, RSXX_HW_BLK_SIZE);
>  
>  	st = pci_set_dma_mask(dev, DMA_BIT_MASK(64));
>  	if (st) {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index fc6340d76814..f97513b3d030 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2397,7 +2397,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
>  
> -	pci_set_dma_max_seg_size(dev, 65536);
> +	dma_set_max_seg_size(&dev->dev, 65536);
>  	dma_set_seg_boundary(&dev->dev, 0xffffffff);
>  
>  	/* Fix up broken headers */
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 8688c0fff761..f96ec68af2e5 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -516,7 +516,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err_unmap;
>  
>  	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
> -	pci_set_dma_max_seg_size(pdev, SZ_1M);
> +	dma_set_max_seg_size(&pdev->dev, SZ_1M);
>  	pci_set_master(pdev);
>  
>  	ism->smcd = smcd_alloc_dev(&pdev->dev, dev_name(&pdev->dev), &ism_ops,
> diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
> index 04443577d48b..53eb2e9569b9 100644
> --- a/drivers/scsi/aacraid/linit.c
> +++ b/drivers/scsi/aacraid/linit.c
> @@ -1747,7 +1747,7 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  		shost->max_sectors = (shost->sg_tablesize * 8) + 112;
>  	}
>  
> -	error = pci_set_dma_max_seg_size(pdev,
> +	error = dma_set_max_seg_size(&pdev->dev,
>  		(aac->adapter_info.options & AAC_OPT_NEW_COMM) ?
>  			(shost->max_sectors << 9) : 65536);
>  	if (error)
> diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
> index 558a109ab497..cb1adf0b78a9 100644
> --- a/include/linux/pci-dma-compat.h
> +++ b/include/linux/pci-dma-compat.h
> @@ -119,20 +119,11 @@ static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
>  {
>  	return dma_set_coherent_mask(&dev->dev, mask);
>  }
> -
> -static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
> -					   unsigned int size)
> -{
> -	return dma_set_max_seg_size(&dev->dev, size);
> -}
>  #else
>  static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
>  { return -EIO; }
>  static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
>  { return -EIO; }
> -static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
> -					   unsigned int size)
> -{ return -EIO; }
>  #endif
>  
>  #endif
> -- 
> 2.19.0
> 
