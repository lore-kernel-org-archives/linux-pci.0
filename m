Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D8C6787C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 19:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B16214C4
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 19:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZFWTuoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B16214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeJMDQE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeJMDQE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 23:16:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D07A420865;
        Fri, 12 Oct 2018 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539373321;
        bh=HshiW5WzSWIcBsOfg5j9VjAfkwfF3ZhuopNc+3rGYz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZFWTuocqAiJL1bK5vg26/8ViKfQh1+jbbyStLb1BL73pwTadxQb7Ng6XqC43Q5w2
         2/NJGIOA/3pJOmsNWB8tCA9lYaqcw9zW/qB5QJAkpyK8qOKTuzW9WtYGkO60uXZtoy
         SFEoO8v+0Nkv2BmxT9mMoWEgOkg1N33268KkDStQ=
Date:   Fri, 12 Oct 2018 14:41:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, peter.maydell@linaro.org,
        joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        robh+dt@kernel.org, mark.rutland@arm.com, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
Message-ID: <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-4-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012145917.6840-4-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/iommu/IOMMU/ in subject

On Fri, Oct 12, 2018 at 03:59:13PM +0100, Jean-Philippe Brucker wrote:
> Using the iommu-map binding, endpoints in a given PCI domain can be
> managed by different IOMMUs. Some virtual machines may allow a subset of
> endpoints to bypass the IOMMU. In some case the IOMMU itself is presented

s/case/cases/

> as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). Currently, when a
> PCI root complex has an iommu-map property, the driver requires all
> endpoints to be described by the property. Allow the iommu-map property to
> have gaps.

I'm not an IOMMU or virtio expert, so it's not obvious to me why it is
safe to allow devices to bypass the IOMMU.  Does this mean a typo in
iommu-map could inadvertently allow devices to bypass it?  Should we
indicate something in dmesg (and/or sysfs) about devices that bypass
it?

> Relaxing of_pci_map_rid also allows the msi-map property to have gaps,

s/of_pci_map_rid/of_pci_map_rid()/

> which is invalid since MSIs always reach an MSI controller. Thankfully
> Linux will error out later, when attempting to find an MSI domain for the
> device.

Not clear to me what "error out" means here.  In a userspace program,
I would infer that the program exits with an error message, but I
doubt you mean that Linux exits.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/pci/of.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 1836b8ddf292..2f5015bdb256 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -451,9 +451,10 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
>  		return 0;
>  	}
>  
> -	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
> -		np, map_name, rid, target && *target ? *target : NULL);
> -	return -EFAULT;
> +	/* Bypasses translation */
> +	if (id_out)
> +		*id_out = rid;
> +	return 0;
>  }
>  
>  #if IS_ENABLED(CONFIG_OF_IRQ)
> -- 
> 2.19.1
> 
