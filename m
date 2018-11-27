Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1AEC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF882145D
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF882145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbeK1EPJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:15:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbeK1EPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 23:15:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5606E307DAB6;
        Tue, 27 Nov 2018 17:16:34 +0000 (UTC)
Received: from redhat.com (ovpn-116-85.ams2.redhat.com [10.36.116.85])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5FD725DEDC;
        Tue, 27 Nov 2018 17:16:23 +0000 (UTC)
Date:   Tue, 27 Nov 2018 12:16:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org,
        jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu, tnowicki@caviumnetworks.com,
        kevin.tian@intel.com, marc.zyngier@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        bharat.bhushan@nxp.com
Subject: Re: [PATCH v5 0/7] Add virtio-iommu driver
Message-ID: <20181127121036-mutt-send-email-mst@kernel.org>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
 <20181127114402-mutt-send-email-mst@kernel.org>
 <6c061729-c404-ac25-f86f-7fe222bf5bc7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c061729-c404-ac25-f86f-7fe222bf5bc7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 27 Nov 2018 17:16:34 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 06:09:25PM +0100, Auger Eric wrote:
> Hi Michael,
> 
> On 11/27/18 5:53 PM, Michael S. Tsirkin wrote:
> > On Thu, Nov 22, 2018 at 07:37:54PM +0000, Jean-Philippe Brucker wrote:
> >> Implement the virtio-iommu driver, following specification v0.9 [1].
> >>
> >> Since v4 [2] I fixed the issues reported by Eric, and added Reviewed-by
> >> from Eric and Rob. Thanks!
> >>
> >> I changed the specification to fix one inconsistency discussed in v4.
> >> That the device fills the probe buffer with zeroes is now a "SHOULD"
> >> instead of a "MAY", since it's the only way for the driver to know if
> >> the device wrote the status. Existing devices already do this. In
> >> addition the device now needs to fill the three padding bytes at the
> >> tail with zeroes.
> >>
> >> You can find Linux driver and kvmtool device on branches
> >> virtio-iommu/v0.9 [3]. I also lightly tested with Eric's latest QEMU
> >> device [4].
> > 
> > I tried to get this to work on my x86 box but without
> > success. Any hints? Does this have to do with the IORT table?
> > I think we really should just reserve our own table ID
> > and avoid the pain of trying to add things to the IORT spec.
> > I'm reluctant to merge lots of code that I can't easily test.
> > Again, if we found a way to push more configuration into
> > virtio config space the problem space would be smaller.
> 
> You can at least test it with QEMU ARM virt in TCG mode.

It's slow enough that I generally just focus on KVM.

> Then I have
> worked on the IORT integration in PC/Q35 but this is not yet functional.
> I need to debug what's wrong on guest ACPI probing. I plan to work on
> this this week.
> 
> Thanks
> 
> Eric

Sounds good. Did you need to make changes to IORT?  I don't remember. If
yes it would be very easy to just have a virtio specific ACPI table -
I am assuming ARM guys will be just as hostile to virt changes
to IORT as they were to minor changes to ARM vIOMMU.


> > 
> >> [1] Virtio-iommu specification v0.9, sources, pdf and diff from v0.8
> >>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
> >>     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
> >>     http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.8-v0.9.pdf
> >>
> >> [2] [PATCH v4 0/7] Add virtio-iommu driver
> >>     https://lists.linuxfoundation.org/pipermail/iommu/2018-November/031074.html
> >>
> >> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9
> >>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> >>
> >> [4] [RFC v9 00/17] VIRTIO-IOMMU device
> >>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html
> >>
> >> Jean-Philippe Brucker (7):
> >>   dt-bindings: virtio-mmio: Add IOMMU description
> >>   dt-bindings: virtio: Add virtio-pci-iommu node
> >>   of: Allow the iommu-map property to omit untranslated devices
> >>   PCI: OF: Initialize dev->fwnode appropriately
> >>   iommu: Add virtio-iommu driver
> >>   iommu/virtio: Add probe request
> >>   iommu/virtio: Add event queue
> >>
> >>  .../devicetree/bindings/virtio/iommu.txt      |   66 +
> >>  .../devicetree/bindings/virtio/mmio.txt       |   30 +
> >>  MAINTAINERS                                   |    7 +
> >>  drivers/iommu/Kconfig                         |   11 +
> >>  drivers/iommu/Makefile                        |    1 +
> >>  drivers/iommu/virtio-iommu.c                  | 1157 +++++++++++++++++
> >>  drivers/of/base.c                             |   10 +-
> >>  drivers/pci/of.c                              |    7 +
> >>  include/uapi/linux/virtio_ids.h               |    1 +
> >>  include/uapi/linux/virtio_iommu.h             |  161 +++
> >>  10 files changed, 1448 insertions(+), 3 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
> >>  create mode 100644 drivers/iommu/virtio-iommu.c
> >>  create mode 100644 include/uapi/linux/virtio_iommu.h
> >>
> >> -- 
> >> 2.19.1
