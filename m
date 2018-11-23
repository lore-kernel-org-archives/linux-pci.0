Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9034C43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C6E20663
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 08:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C6E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393583AbeKWTMN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:12:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390006AbeKWTMN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 14:12:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADF4183F42;
        Fri, 23 Nov 2018 08:28:59 +0000 (UTC)
Received: from [10.36.116.235] (ovpn-116-235.ams2.redhat.com [10.36.116.235])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E282A6013A;
        Fri, 23 Nov 2018 08:28:52 +0000 (UTC)
Subject: Re: [PATCH v5 0/7] Add virtio-iommu driver
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc:     jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu, tnowicki@caviumnetworks.com,
        kevin.tian@intel.com, marc.zyngier@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        bharat.bhushan@nxp.com
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <250a38a9-e6b1-35ae-9261-eb8aab123f43@redhat.com>
Date:   Fri, 23 Nov 2018 09:28:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 23 Nov 2018 08:29:00 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 11/22/18 8:37 PM, Jean-Philippe Brucker wrote:
> Implement the virtio-iommu driver, following specification v0.9 [1].
> 
> Since v4 [2] I fixed the issues reported by Eric, and added Reviewed-by
> from Eric and Rob. Thanks!
> 
> I changed the specification to fix one inconsistency discussed in v4.
> That the device fills the probe buffer with zeroes is now a "SHOULD"
> instead of a "MAY", since it's the only way for the driver to know if
> the device wrote the status. Existing devices already do this. In
> addition the device now needs to fill the three padding bytes at the
> tail with zeroes.
> 
> You can find Linux driver and kvmtool device on branches
> virtio-iommu/v0.9 [3]. I also lightly tested with Eric's latest QEMU
> device [4].
> 
> [1] Virtio-iommu specification v0.9, sources, pdf and diff from v0.8
>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
>     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
>     http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.8-v0.9.pdf
> 
> [2] [PATCH v4 0/7] Add virtio-iommu driver
>     https://lists.linuxfoundation.org/pipermail/iommu/2018-November/031074.html
> 
> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9
>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> 
> [4] [RFC v9 00/17] VIRTIO-IOMMU device
>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html
> 
> Jean-Philippe Brucker (7):
>   dt-bindings: virtio-mmio: Add IOMMU description
>   dt-bindings: virtio: Add virtio-pci-iommu node
>   of: Allow the iommu-map property to omit untranslated devices
>   PCI: OF: Initialize dev->fwnode appropriately
>   iommu: Add virtio-iommu driver
>   iommu/virtio: Add probe request
>   iommu/virtio: Add event queue
> 
>  .../devicetree/bindings/virtio/iommu.txt      |   66 +
>  .../devicetree/bindings/virtio/mmio.txt       |   30 +
>  MAINTAINERS                                   |    7 +
>  drivers/iommu/Kconfig                         |   11 +
>  drivers/iommu/Makefile                        |    1 +
>  drivers/iommu/virtio-iommu.c                  | 1157 +++++++++++++++++
>  drivers/of/base.c                             |   10 +-
>  drivers/pci/of.c                              |    7 +
>  include/uapi/linux/virtio_ids.h               |    1 +
>  include/uapi/linux/virtio_iommu.h             |  161 +++
>  10 files changed, 1448 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>  create mode 100644 drivers/iommu/virtio-iommu.c
>  create mode 100644 include/uapi/linux/virtio_iommu.h
> 
for the whole series
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

