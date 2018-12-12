Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560FC6783B
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 00:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044D22086D
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 00:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044D22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLLAjc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:39:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLLAjc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 19:39:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7606B3082202;
        Wed, 12 Dec 2018 00:39:31 +0000 (UTC)
Received: from redhat.com (ovpn-120-67.rdu2.redhat.com [10.10.120.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id 01FB260C44;
        Wed, 12 Dec 2018 00:39:28 +0000 (UTC)
Date:   Tue, 11 Dec 2018 19:39:28 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org,
        mark.rutland@arm.com, kevin.tian@intel.com,
        tnowicki@caviumnetworks.com, marc.zyngier@arm.com,
        robin.murphy@arm.com, jasowang@redhat.com, will.deacon@arm.com,
        robh+dt@kernel.org, bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Message-ID: <20181211193249-mutt-send-email-mst@kernel.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
 <20181211183101.GA31936@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211183101.GA31936@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 12 Dec 2018 00:39:31 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 11, 2018 at 10:31:01AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
> > Implement the virtio-iommu driver, following specification v0.9 [1].
> > 
> > Only minor changes since v5 [2]. I fixed issues reported by Michael and
> > added tags from Eric and Bharat. Thanks!
> > 
> > You can find Linux driver and kvmtool device on v0.9 branches [3],
> > module and x86 support on virtio-iommu/devel. Also tested with Eric's
> > QEMU device [4].
> 
> Just curious, what is the use case for it?

If what I saw is any indication, it allows a very simple implementation
of page table shadowing on the host, at the cost of not being able to
accelerate with a hardware nested page tables support when available.

-- 
MST
