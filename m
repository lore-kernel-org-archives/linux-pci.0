Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA8CC04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 10:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC7C20849
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 10:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC7C20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeLLKfr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:35:47 -0500
Received: from 8bytes.org ([81.169.241.247]:53762 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbeLLKfr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 05:35:47 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 88ECF3D8; Wed, 12 Dec 2018 11:35:45 +0100 (CET)
Date:   Wed, 12 Dec 2018 11:35:45 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, mst@redhat.com,
        jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Message-ID: <20181212103545.GV16835@8bytes.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

to make progress on this, we should first agree on the protocol used
between guest and host. I have a few points to discuss on the protocol
first.

On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
> [1] Virtio-iommu specification v0.9, sources and pdf
>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
>     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf

Looking at this I wonder why it doesn't make the IOTLB visible to the
guest. the UNMAP requests seem to require that the TLB is already
flushed to make the unmap visible.

I think that will cost significant performance for both, vfio and
dma-iommu use-cases which both do (vfio at least to some degree),
deferred flushing.

I also wonder whether the protocol should implement a
protocol version handshake and iommu-feature set queries.

> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.1
>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9

Unfortunatly gitweb seems to be broken on linux-arm.org. What is missing
in this patch-set to make this work on x86?

Regards,

	Joerg
