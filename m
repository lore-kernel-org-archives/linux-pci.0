Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1D5C6783C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15882086A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 15:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15882086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeJLWdg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:33:36 -0400
Received: from foss.arm.com ([217.140.101.70]:52632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbeJLWdg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 18:33:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B359F;
        Fri, 12 Oct 2018 08:00:45 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89CD13F5BC;
        Fri, 12 Oct 2018 08:00:42 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        peter.maydell@linaro.org, joro@8bytes.org, mst@redhat.com,
        jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        eric.auger@redhat.com, tnowicki@caviumnetworks.com,
        kevin.tian@intel.com, marc.zyngier@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com
Subject: [PATCH v3 0/7] Add virtio-iommu driver
Date:   Fri, 12 Oct 2018 15:59:10 +0100
Message-Id: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement the virtio-iommu driver, following specification v0.8 [1].
Changes since v2 [2]:

* Patches 2-4 allow virtio-iommu to use the PCI transport, since QEMU
  would like to phase out the MMIO transport. This produces a complex
  topology where the programming interface of the IOMMU could appear
  lower than the endpoints that it translates. It's not unheard of (e.g.
  AMD IOMMU), and the guest easily copes with this.
  
  The "Firmware description" section of the specification has been
  updated with all combinations of PCI, MMIO and DT, ACPI.

* Fix structures layout, they don't need the "packed" attribute anymore.

* While we're at it, add domain parameter to DETACH request, and leave
  some padding. This way the next version, that adds PASID support,
  won't have to introduce a "DETACH2" request to stay backward
  compatible.

* Require virtio device 1.0+. Remove legacy transport notes from the
  specification.

* Request timeout is now only enabled with DEBUG.

* The patch for VFIO Kconfig (previously patch 5/5) is in next.

You can find Linux driver and kvmtool device on branches
virtio-iommu/v0.8 [3] (currently based on 4.19-rc7 but rebasing onto
next only produced a trivial conflict). Branch virtio-iommu/devel
contains a few patches that I'd like to send once the base is upstream:

* virtio-iommu as a module. It got *much* nicer after Rob's probe
  deferral rework, but I still have a bug to fix when re-loading the
  virtio-iommu module.

* ACPI support requires a minor IORT spec update (reservation of node
  ID). I think it should be easier to obtain once the device and drivers
  are upstream.

[1] Virtio-iommu specification v0.8, diff from v0.7, and sources
    git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.8
    http://jpbrucker.net/virtio-iommu/spec/v0.8/virtio-iommu-v0.8.pdf
    http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.7-v0.8.pdf

[2] [PATCH v2 0/5] Add virtio-iommu driver
    https://www.spinics.net/lists/kvm/msg170655.html

[3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.8
    git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.8

Jean-Philippe Brucker (7):
  dt-bindings: virtio-mmio: Add IOMMU description
  dt-bindings: virtio: Add virtio-pci-iommu node
  PCI: OF: allow endpoints to bypass the iommu
  PCI: OF: Initialize dev->fwnode appropriately
  iommu: Add virtio-iommu driver
  iommu/virtio: Add probe request
  iommu/virtio: Add event queue

 .../devicetree/bindings/virtio/iommu.txt      |   66 +
 .../devicetree/bindings/virtio/mmio.txt       |   30 +
 MAINTAINERS                                   |    7 +
 drivers/iommu/Kconfig                         |   11 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/virtio-iommu.c                  | 1171 +++++++++++++++++
 drivers/pci/of.c                              |   14 +-
 include/uapi/linux/virtio_ids.h               |    1 +
 include/uapi/linux/virtio_iommu.h             |  159 +++
 9 files changed, 1457 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h

-- 
2.19.1

