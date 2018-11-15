Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BAAC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 16:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3780224E0
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 16:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3780224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbeKPDGk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:06:40 -0500
Received: from foss.arm.com ([217.140.101.70]:37944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbeKPDGk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 22:06:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCFA480D;
        Thu, 15 Nov 2018 08:58:03 -0800 (PST)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C6CE3F718;
        Thu, 15 Nov 2018 08:58:00 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc:     frowand.list@gmail.com, jasowang@redhat.com, robh+dt@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com,
        kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
Subject: [PATCH v4 0/7] Add virtio-iommu driver
Date:   Thu, 15 Nov 2018 16:52:27 +0000
Message-Id: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement the virtio-iommu driver, following specification v0.8 [1].

Changes since v3 [2]:
* Rebase onto v4.20-rc2. Patch 3 now touches drivers/of/base.c instead
  of drivers/pci/of.c, since the map_rid() function has moved.
* Removed the request timeout, that depended on DEBUG.
* Other small fixes addressing comments on v3.

You can find Linux driver and kvmtool device on my virtio-iommu/v0.8.1
branches [3]. You can also test it with the latest version of Eric's
QEMU device [4].

[1] Virtio-iommu specification v0.8, sources and pdf
    git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.8
    http://jpbrucker.net/virtio-iommu/spec/v0.8/virtio-iommu-v0.8.pdf

[2] [PATCH v3 0/7] Add virtio-iommu driver
    https://www.spinics.net/lists/linux-pci/msg77110.html

[3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.8.1
    git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.8.1

[4] [RFC v8 00/18] VIRTIO-IOMMU device
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg572637.html

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
 drivers/iommu/virtio-iommu.c                  | 1160 +++++++++++++++++
 drivers/of/base.c                             |   10 +-
 drivers/pci/of.c                              |    7 +
 include/uapi/linux/virtio_ids.h               |    1 +
 include/uapi/linux/virtio_iommu.h             |  161 +++
 10 files changed, 1451 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h

-- 
2.19.1

