Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B527C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 08:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3865E2184B
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 08:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfAWIei (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:34:38 -0500
Received: from 8bytes.org ([81.169.241.247]:59078 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfAWIei (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jan 2019 03:34:38 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EC6B739A; Wed, 23 Jan 2019 09:34:36 +0100 (CET)
Date:   Wed, 23 Jan 2019 09:34:35 +0100
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
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Message-ID: <20190123083435.x3svwqp472mdgglw@8bytes.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean-Philippe,

thanks for all your hard work on this!

On Tue, Jan 15, 2019 at 12:19:52PM +0000, Jean-Philippe Brucker wrote:
> Implement the virtio-iommu driver, following specification v0.9 [1].

To make progress on this I think the spec needs to be close to something
that can be included into the official virtio-specification. Have you
proposed the specification for inclusion there?

This is because I can't merge a driver that might be incompatible to
future implementations because the specification needs to be changed on
its way to an official standard.

I had a short discussion with Michael S. Tsirkin about that and from
what I understood the spec needs to be proposed for inclusion on the
virtio-comment[1] mailing list and later the TC needs to vote on it.
Please work with Michael on this to get the specification official (or
at least pretty close to something that will be part of the official
virtio standard).

Regards,

	Joerg

[1] https://www.oasis-open.org/committees/comments/index.php?wg_abbrev=virtio
