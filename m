Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F88C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 09:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983A8204FD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 09:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983A8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJPRPY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:15:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRPY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 13:15:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD1653082A2B;
        Tue, 16 Oct 2018 09:25:52 +0000 (UTC)
Received: from [10.36.118.67] (unknown [10.36.118.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B8F35D967;
        Tue, 16 Oct 2018 09:25:43 +0000 (UTC)
Subject: Re: [PATCH v3 0/7] Add virtio-iommu driver
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        peter.maydell@linaro.org, joro@8bytes.org, mst@redhat.com,
        jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <7874471b-3711-ca44-d220-5e756ac7db8c@redhat.com>
Date:   Tue, 16 Oct 2018 11:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 16 Oct 2018 09:25:53 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 10/12/18 4:59 PM, Jean-Philippe Brucker wrote:
> Implement the virtio-iommu driver, following specification v0.8 [1].
> Changes since v2 [2]:
> 
> * Patches 2-4 allow virtio-iommu to use the PCI transport, since QEMU
>   would like to phase out the MMIO transport. This produces a complex
>   topology where the programming interface of the IOMMU could appear
>   lower than the endpoints that it translates. It's not unheard of (e.g.
>   AMD IOMMU), and the guest easily copes with this.
>   
>   The "Firmware description" section of the specification has been
>   updated with all combinations of PCI, MMIO and DT, ACPI.

I have a question wrt the FW specification. The IOMMU consumes 1 slot in
the PCI domain and one needs to leave a RID hole in the iommu-map.  It
is not obvious to me that this RID always is predictable given the pcie
enumeration mechanism. Generally we have a coarse grain mapping of RID
onto iommu phandles/STREAMIDs. Here, if I understand correctly we need
to precisely identify the RID granted to the iommu. On QEMU this may
depend on the instantiation order of the virtio-pci device right? So
this does not look trivial to build this info. Isn't it possible to do
this exclusion at kernel level instead?

Thanks

Eric
> 
> * Fix structures layout, they don't need the "packed" attribute anymore.
> 
> * While we're at it, add domain parameter to DETACH request, and leave
>   some padding. This way the next version, that adds PASID support,
>   won't have to introduce a "DETACH2" request to stay backward
>   compatible.
> 
> * Require virtio device 1.0+. Remove legacy transport notes from the
>   specification.
> 
> * Request timeout is now only enabled with DEBUG.
> 
> * The patch for VFIO Kconfig (previously patch 5/5) is in next.
> 
> You can find Linux driver and kvmtool device on branches
> virtio-iommu/v0.8 [3] (currently based on 4.19-rc7 but rebasing onto
> next only produced a trivial conflict). Branch virtio-iommu/devel
> contains a few patches that I'd like to send once the base is upstream:
> 
> * virtio-iommu as a module. It got *much* nicer after Rob's probe
>   deferral rework, but I still have a bug to fix when re-loading the
>   virtio-iommu module.
> 
> * ACPI support requires a minor IORT spec update (reservation of node
>   ID). I think it should be easier to obtain once the device and drivers
>   are upstream.
> 
> [1] Virtio-iommu specification v0.8, diff from v0.7, and sources
>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.8
>     http://jpbrucker.net/virtio-iommu/spec/v0.8/virtio-iommu-v0.8.pdf
>     http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.7-v0.8.pdf
> 
> [2] [PATCH v2 0/5] Add virtio-iommu driver
>     https://www.spinics.net/lists/kvm/msg170655.html
> 
> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.8
>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.8
> 
> Jean-Philippe Brucker (7):
>   dt-bindings: virtio-mmio: Add IOMMU description
>   dt-bindings: virtio: Add virtio-pci-iommu node
>   PCI: OF: allow endpoints to bypass the iommu
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
>  drivers/iommu/virtio-iommu.c                  | 1171 +++++++++++++++++
>  drivers/pci/of.c                              |   14 +-
>  include/uapi/linux/virtio_ids.h               |    1 +
>  include/uapi/linux/virtio_iommu.h             |  159 +++
>  9 files changed, 1457 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>  create mode 100644 drivers/iommu/virtio-iommu.c
>  create mode 100644 include/uapi/linux/virtio_iommu.h
> 
