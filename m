Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60250C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 19:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A1920878
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 19:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A1920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438368AbeKWGUT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:20:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56358 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbeKWGUS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 01:20:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07F2D2E96;
        Thu, 22 Nov 2018 11:39:30 -0800 (PST)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B89B3F575;
        Thu, 22 Nov 2018 11:39:26 -0800 (PST)
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
Subject: [PATCH v5 0/7] Add virtio-iommu driver
Date:   Thu, 22 Nov 2018 19:37:54 +0000
Message-Id: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement the virtio-iommu driver, following specification v0.9 [1].

Since v4 [2] I fixed the issues reported by Eric, and added Reviewed-by
from Eric and Rob. Thanks!

I changed the specification to fix one inconsistency discussed in v4.
That the device fills the probe buffer with zeroes is now a "SHOULD"
instead of a "MAY", since it's the only way for the driver to know if
the device wrote the status. Existing devices already do this. In
addition the device now needs to fill the three padding bytes at the
tail with zeroes.

You can find Linux driver and kvmtool device on branches
virtio-iommu/v0.9 [3]. I also lightly tested with Eric's latest QEMU
device [4].

[1] Virtio-iommu specification v0.9, sources, pdf and diff from v0.8
    git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
    http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
    http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.8-v0.9.pdf

[2] [PATCH v4 0/7] Add virtio-iommu driver
    https://lists.linuxfoundation.org/pipermail/iommu/2018-November/031074.html

[3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9
    git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9

[4] [RFC v9 00/17] VIRTIO-IOMMU device
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html

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
 drivers/iommu/virtio-iommu.c                  | 1157 +++++++++++++++++
 drivers/of/base.c                             |   10 +-
 drivers/pci/of.c                              |    7 +
 include/uapi/linux/virtio_ids.h               |    1 +
 include/uapi/linux/virtio_iommu.h             |  161 +++
 10 files changed, 1448 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h

-- 
2.19.1

