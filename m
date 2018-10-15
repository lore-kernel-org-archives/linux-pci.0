Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871BAC04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 10:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F543208AE
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 10:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F543208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeJOSg7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOSg7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Oct 2018 14:36:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B49B23001FCD;
        Mon, 15 Oct 2018 10:52:15 +0000 (UTC)
Received: from redhat.com (ovpn-120-81.rdu2.redhat.com [10.10.120.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1980918503;
        Mon, 15 Oct 2018 10:52:10 +0000 (UTC)
Date:   Mon, 15 Oct 2018 06:52:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, peter.maydell@linaro.org,
        joro@8bytes.org, jasowang@redhat.com, robh+dt@kernel.org,
        mark.rutland@arm.com, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
Message-ID: <20181015065024-mutt-send-email-mst@kernel.org>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-4-jean-philippe.brucker@arm.com>
 <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 15 Oct 2018 10:52:16 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 12, 2018 at 02:41:59PM -0500, Bjorn Helgaas wrote:
> s/iommu/IOMMU/ in subject
> 
> On Fri, Oct 12, 2018 at 03:59:13PM +0100, Jean-Philippe Brucker wrote:
> > Using the iommu-map binding, endpoints in a given PCI domain can be
> > managed by different IOMMUs. Some virtual machines may allow a subset of
> > endpoints to bypass the IOMMU. In some case the IOMMU itself is presented
> 
> s/case/cases/
> 
> > as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). Currently, when a
> > PCI root complex has an iommu-map property, the driver requires all
> > endpoints to be described by the property. Allow the iommu-map property to
> > have gaps.
> 
> I'm not an IOMMU or virtio expert, so it's not obvious to me why it is
> safe to allow devices to bypass the IOMMU.  Does this mean a typo in
> iommu-map could inadvertently allow devices to bypass it?


Thinking about this comment, I would like to ask: can't the
virtio device indicate the ranges in a portable way?
This would minimize the dependency on dt bindings and ACPI,
enabling support for systems that have neither but do
have virtio e.g. through pci.

>  Should we
> indicate something in dmesg (and/or sysfs) about devices that bypass
> it?
> 
> > Relaxing of_pci_map_rid also allows the msi-map property to have gaps,
> 
> s/of_pci_map_rid/of_pci_map_rid()/
> 
> > which is invalid since MSIs always reach an MSI controller. Thankfully
> > Linux will error out later, when attempting to find an MSI domain for the
> > device.
> 
> Not clear to me what "error out" means here.  In a userspace program,
> I would infer that the program exits with an error message, but I
> doubt you mean that Linux exits.
> 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > ---
> >  drivers/pci/of.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 1836b8ddf292..2f5015bdb256 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -451,9 +451,10 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
> >  		return 0;
> >  	}
> >  
> > -	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
> > -		np, map_name, rid, target && *target ? *target : NULL);
> > -	return -EFAULT;
> > +	/* Bypasses translation */
> > +	if (id_out)
> > +		*id_out = rid;
> > +	return 0;
> >  }
> >  
> >  #if IS_ENABLED(CONFIG_OF_IRQ)
> > -- 
> > 2.19.1
> > 
