Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD2C10F14
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 23:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F5B2171F
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555631366;
	bh=RdRuENMt2N8EcFqmuOVsp9lgB312z9UdqMSFIAs3IrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WUUVClYy19wXsSI+poyQEo2IcBwHxAVSX2KXlWYSZ+EN50VUj4OfDUEqeamqJ9Jj2
	 ibD5Ea2JEinb9tp5GK7PcoPkCULMjZnJMa+KsqNYuIHV7H1ef1IW8dmSuXc4XndCGH
	 qZuAzniDJrf/+EaGfigka1GXiz6szEtB+MEKUVl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfDRXtZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfDRXtZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 19:49:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361A3206B6;
        Thu, 18 Apr 2019 23:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555631364;
        bh=RdRuENMt2N8EcFqmuOVsp9lgB312z9UdqMSFIAs3IrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0kIFHrENnmKj3GeqVyaIoay2R1vKfYATSAZLzKR0ppVo0/VxojkAn3vYVQt21g5sF
         k52nBSe4aX+ThkElxPakCGtR+U1n15XomqC9njay/plcUFjJZY+Xn9+4ChSmHwVlU9
         U2MZXTBlq0eWeoWWS8uqQMH7GLqpiHcx2T9mr7Q0=
Date:   Thu, 18 Apr 2019 18:49:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: Add dma_ranges window list
Message-ID: <20190418234922.GH126710@google.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <1555038815-31916-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555038815-31916-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 08:43:33AM +0530, Srinath Mannam wrote:
> Add a dma_ranges field in PCI host bridge structure to hold resource
> entries list of memory regions in sorted order given through dma-ranges
> DT property.
> 
> While initializing IOMMU domain of PCI EPs connected to that host bridge
> This list of resources will be processed and IOVAs for the address holes
> will be reserved.

s/bridge This list/bridge, this list/

> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/probe.c | 3 +++
>  include/linux/pci.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 257b9f6..ce5505f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -544,6 +544,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&bridge->windows);
> +	INIT_LIST_HEAD(&bridge->dma_ranges);
>  	bridge->dev.release = pci_release_host_bridge_dev;
>  
>  	/*
> @@ -572,6 +573,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&bridge->windows);
> +	INIT_LIST_HEAD(&bridge->dma_ranges);
>  	bridge->dev.release = devm_pci_release_host_bridge_dev;
>  
>  	return bridge;
> @@ -581,6 +583,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
>  void pci_free_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	pci_free_resource_list(&bridge->windows);
> +	pci_free_resource_list(&bridge->dma_ranges);
>  
>  	kfree(bridge);
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c..016a044 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -487,6 +487,7 @@ struct pci_host_bridge {
>  	void		*sysdata;
>  	int		busnr;
>  	struct list_head windows;	/* resource_entry */
> +	struct list_head dma_ranges;	/* dma ranges resource list */
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> -- 
> 2.7.4
> 
