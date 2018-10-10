Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D6C46462
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEAA2087A
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vUTKnIGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEAA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeJKEFo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeJKEFo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 00:05:44 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8973120870;
        Wed, 10 Oct 2018 20:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539204113;
        bh=Swwq1DMY1Sz5FOiw74uGrBLHaVbP85Alkw7aTRecPAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vUTKnIGD/ba+jEIzvvNxOhAW4LF+COJPM0Qt++XUvA3NBW3+nbVOkK0/MbApHIvIT
         uq09cbAnp7nTPAKC1p18Ig/DgJnRRhWM5wdbnchVF4gyDi7+WTdeWUBMrvQRlKS5av
         DiN8NzKo1l4mTSzs2hLtQJKNIBQg/Mk6x9RuTtME=
Date:   Wed, 10 Oct 2018 15:41:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: remove pci_set_dma_seg_boundary
Message-ID: <20181010204152.GH5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181009140824.18667-1-hch@lst.de>
 <20181009140824.18667-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009140824.18667-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc s390 network maintainers]

On Tue, Oct 09, 2018 at 04:08:23PM +0200, Christoph Hellwig wrote:
> The two callers can just use dma_set_seg_boundary directly.

I intend to apply this trivial patch, so just FYI.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/probe.c            | 2 +-
>  drivers/s390/net/ism_drv.c     | 2 +-
>  include/linux/pci-dma-compat.h | 9 ---------
>  3 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 201f9e5ff55c..fc6340d76814 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2398,7 +2398,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
>  
>  	pci_set_dma_max_seg_size(dev, 65536);
> -	pci_set_dma_seg_boundary(dev, 0xffffffff);
> +	dma_set_seg_boundary(&dev->dev, 0xffffffff);
>  
>  	/* Fix up broken headers */
>  	pci_fixup_device(pci_fixup_header, dev);
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index c0631895154e..8688c0fff761 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -515,7 +515,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (ret)
>  		goto err_unmap;
>  
> -	pci_set_dma_seg_boundary(pdev, SZ_1M - 1);
> +	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
>  	pci_set_dma_max_seg_size(pdev, SZ_1M);
>  	pci_set_master(pdev);
>  
> diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
> index c3f1b44ade29..558a109ab497 100644
> --- a/include/linux/pci-dma-compat.h
> +++ b/include/linux/pci-dma-compat.h
> @@ -125,12 +125,6 @@ static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
>  {
>  	return dma_set_max_seg_size(&dev->dev, size);
>  }
> -
> -static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
> -					   unsigned long mask)
> -{
> -	return dma_set_seg_boundary(&dev->dev, mask);
> -}
>  #else
>  static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
>  { return -EIO; }
> @@ -139,9 +133,6 @@ static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
>  static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
>  					   unsigned int size)
>  { return -EIO; }
> -static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
> -					   unsigned long mask)
> -{ return -EIO; }
>  #endif
>  
>  #endif
> -- 
> 2.19.0
> 
