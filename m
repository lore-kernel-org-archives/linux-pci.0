Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCACC5ACCC
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 16:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4372145D
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 16:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4372145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJSApf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:45:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeJSApf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Oct 2018 20:45:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17EFC341;
        Thu, 18 Oct 2018 09:43:47 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CCF03F5D3;
        Thu, 18 Oct 2018 09:43:46 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:43:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 1/2] PCI/VMD: Detach resources after stopping root bus
Message-ID: <20181018164340.GA32306@e107981-ln.cambridge.arm.com>
References: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
 <1539650888-3792-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539650888-3792-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 06:48:07PM -0600, Jon Derrick wrote:
> The VMD removal path calls pci_stop_root_bus, which tears down the pcie
> tree, including detaching all of the attached drivers. During driver
> detachment, devices may use pci_release_region to release resources.
> This path relies on the resource being accessible in resource tree.
> 
> By detaching the child domain from the parent resource domain prior to
> stopping the bus, we are preventing the list traversal from finding the
> resource to be freed. If we instead detach the resource after stopping
> the bus, we will have properly freed the resource and detaching is
> simply accounting at that point.
> 
> Without this order, the resource is never freed and is orphaned on VMD
> removal, leading to warning:
> [  181.940162] Trying to free nonexistent resource <e5a10000-e5a13fff>
> 
> Fixes 2c2c5c5cd213aea38c850bb6edc9b7f77f29802f:
> "x86/PCI: VMD: Attach VMD resources to parent domain's resource tree"
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I have applied this patch to pci/vmd for v4.20, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index fd2dbd7..46ed80f 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -813,12 +813,12 @@ static void vmd_remove(struct pci_dev *dev)
>  {
>  	struct vmd_dev *vmd = pci_get_drvdata(dev);
>  
> -	vmd_detach_resources(vmd);
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_stop_root_bus(vmd->bus);
>  	pci_remove_root_bus(vmd->bus);
>  	vmd_cleanup_srcu(vmd);
>  	vmd_teardown_dma_ops(vmd);
> +	vmd_detach_resources(vmd);
>  	irq_domain_remove(vmd->irq_domain);
>  }
>  
> -- 
> 1.8.3.1
> 
