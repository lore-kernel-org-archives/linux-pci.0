Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64440C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 14:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358EC2083C
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 14:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358EC2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJPWl7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:41:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:26640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJPWl6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 18:41:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 07:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="78444225"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2018 07:51:10 -0700
Date:   Tue, 16 Oct 2018 08:48:20 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] PCI/VMD: Detach resources after stopping root bus
Message-ID: <20181016144819.GA17974@localhost.localdomain>
References: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
 <1539650888-3792-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539650888-3792-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 05:48:07PM -0700, Jon Derrick wrote:
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

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>

> ---
>  drivers/pci/controller/vmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
