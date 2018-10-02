Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE7DC43143
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 09:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7320878
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 09:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC7320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJBQ0a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:26:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33392 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbeJBQ03 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 12:26:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C59EA7A9;
        Tue,  2 Oct 2018 02:44:06 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C839F3F5B3;
        Tue,  2 Oct 2018 02:44:05 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:44:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/VMD: Detach resources after stopping root bus
Message-ID: <20181002094452.GB23618@red-moon>
References: <1536109791-2672-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536109791-2672-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 04, 2018 at 07:09:50PM -0600, Jon Derrick wrote:
> Fixes the ugly warning:
> [  181.940162] Trying to free nonexistent resource <e5a10000-e5a13fff>

It would be good to explain why that warning triggers and why this
patch fixes it.

Lorenzo

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
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
