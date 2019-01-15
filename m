Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385C9C43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 12:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1446720651
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 12:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfAOMZI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:25:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49234 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbfAOMZI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 07:25:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9967480D;
        Tue, 15 Jan 2019 04:25:07 -0800 (PST)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AFAE3F70D;
        Tue, 15 Jan 2019 04:25:04 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc:     jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
Subject: [PATCH v7 0/7] Add virtio-iommu driver
Date:   Tue, 15 Jan 2019 12:19:52 +0000
Message-Id: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement the virtio-iommu driver, following specification v0.9 [1].

This is a simple rebase onto Linux v5.0-rc2. We now use the
dev_iommu_fwspec_get() helper introduced in v5.0 instead of accessing
dev->iommu_fwspec, but there aren't any functional change from v6 [2].

Our current goal for virtio-iommu is to get a paravirtual IOMMU working
on Arm, and enable device assignment to guest userspace. In this
use-case the mappings are static, and don't require optimal performance,
so this series tries to keep things simple. However there is plenty more
to do for features and optimizations, and having this base in v5.1 would
be good. Given that most of the changes are to drivers/iommu, I believe
the driver and future changes should go via the IOMMU tree.

You can find Linux driver and kvmtool device on v0.9.2 branches [3],
module and x86 support on virtio-iommu/devel. Also tested with Eric's
QEMU device [4]. Please note that the series depends on Robin's
probe-deferral fix [5], which will hopefully land in v5.0.

[1] Virtio-iommu specification v0.9, sources and pdf
    git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
    http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf

[2] [PATCH v6 0/7] Add virtio-iommu driver
    https://lists.linuxfoundation.org/pipermail/iommu/2018-December/032127.html

[3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.2
    git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9.2

[4] [RFC v9 00/17] VIRTIO-IOMMU device
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html

[5] [PATCH] iommu/of: Fix probe-deferral
    https://www.spinics.net/lists/arm-kernel/msg698371.html

Jean-Philippe Brucker (7):
  dt-bindings: virtio-mmio: Add IOMMU description
  dt-bindings: virtio: Add virtio-pci-iommu node
  of: Allow the iommu-map property to omit untranslated devices
  PCI: OF: Initialize dev->fwnode appropriately
  iommu: Add virtio-iommu driver
  iommu/virtio: Add probe request
  iommu/virtio: Add event queue

 .../devicetree/bindings/virtio/iommu.txt      |   66 +
 .../devicetree/bindings/virtio/mmio.txt       |   30 +
 MAINTAINERS                                   |    7 +
 drivers/iommu/Kconfig                         |   11 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/virtio-iommu.c                  | 1158 +++++++++++++++++
 drivers/of/base.c                             |   10 +-
 drivers/pci/of.c                              |    7 +
 include/uapi/linux/virtio_ids.h               |    1 +
 include/uapi/linux/virtio_iommu.h             |  161 +++
 10 files changed, 1449 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h

-- 
2.19.1

