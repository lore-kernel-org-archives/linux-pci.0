Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE2ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E546E2152A
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 15:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E546E2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeJQXKS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:10:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQXKS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 19:10:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42536C04BD42;
        Wed, 17 Oct 2018 15:14:09 +0000 (UTC)
Received: from redhat.com (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D85319E63;
        Wed, 17 Oct 2018 15:14:05 +0000 (UTC)
Date:   Wed, 17 Oct 2018 11:14:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-philippe Brucker <jphilippe.brucker@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, kevin.tian@intel.com,
        tnowicki@caviumnetworks.com, peter.maydell@linaro.org,
        linux-pci@vger.kernel.org, will.deacon@arm.com,
        robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        marc.zyngier@arm.com, jasowang@redhat.com,
        kvmarm@lists.cs.columbia.edu, jean-philippe.brucker@arm.com
Subject: Re: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
Message-ID: <20181017111100-mutt-send-email-mst@kernel.org>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-4-jean-philippe.brucker@arm.com>
 <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
 <20181015065024-mutt-send-email-mst@kernel.org>
 <482d0eb9-8c4c-9d64-7b32-25d5d11a8b8f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482d0eb9-8c4c-9d64-7b32-25d5d11a8b8f@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 17 Oct 2018 15:14:09 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 08:46:41PM +0100, Jean-philippe Brucker wrote:
> [Replying with my personal address because we're having SMTP issues]
> 
> On 15/10/2018 11:52, Michael S. Tsirkin wrote:
> > On Fri, Oct 12, 2018 at 02:41:59PM -0500, Bjorn Helgaas wrote:
> >> s/iommu/IOMMU/ in subject
> >>
> >> On Fri, Oct 12, 2018 at 03:59:13PM +0100, Jean-Philippe Brucker wrote:
> >>> Using the iommu-map binding, endpoints in a given PCI domain can be
> >>> managed by different IOMMUs. Some virtual machines may allow a subset of
> >>> endpoints to bypass the IOMMU. In some case the IOMMU itself is presented
> >>
> >> s/case/cases/
> >>
> >>> as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). Currently, when a
> >>> PCI root complex has an iommu-map property, the driver requires all
> >>> endpoints to be described by the property. Allow the iommu-map property to
> >>> have gaps.
> >>
> >> I'm not an IOMMU or virtio expert, so it's not obvious to me why it is
> >> safe to allow devices to bypass the IOMMU.  Does this mean a typo in
> >> iommu-map could inadvertently allow devices to bypass it?
> > 
> > 
> > Thinking about this comment, I would like to ask: can't the
> > virtio device indicate the ranges in a portable way?
> > This would minimize the dependency on dt bindings and ACPI,
> > enabling support for systems that have neither but do
> > have virtio e.g. through pci.
> 
> I thought about adding a PROBE request for this in virtio-iommu, but it
> wouldn't be usable by a Linux guest because of a bootstrapping problem.

Hmm. At some level it seems wrong to design hardware interfaces
around how Linux happens to probe things. That can change at any time
...

> Early on, Linux needs a description of device dependencies, to determine
> in which order to probe them. If the device dependency was described by
> virtio-iommu itself, the guest could for example initialize a NIC,
> allocate buffers and start DMA on the physical address space (which aborts
> if the IOMMU implementation disallows DMA by default), only to find out
> once the virtio-iommu module is loaded that it needs to cancel all DMA and
> reconfigure the NIC. With a static description such as iommu-map in DT or
> ACPI remapping tables, the guest can defer probing of the NIC until the
> IOMMU is initialized.
> 
> Thanks,
> Jean

Could you point me at the code you refer to here?

-- 
MST
