Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481D0ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E583521523
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E583521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeITXJR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50008 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732761AbeITXJQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EBEB7A9;
        Thu, 20 Sep 2018 10:24:46 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A2F53F557;
        Thu, 20 Sep 2018 10:24:42 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, linux-pci@vger.kernel.org, jcrouse@codeaurora.org,
        alex.williamson@redhat.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        eric.auger@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        andrew.murray@arm.com, will.deacon@arm.com, robin.murphy@arm.com,
        ashok.raj@intel.com, baolu.lu@linux.intel.com, xuzaibo@huawei.com,
        liguozhu@hisilicon.com, okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com
Subject: [PATCH v3 00/10] Shared Virtual Addressing for the IOMMU
Date:   Thu, 20 Sep 2018 18:00:36 +0100
Message-Id: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is version 3 of the core changes for Shared Virtual Addressing in
the IOMMU. It provides an API for sharing process address spaces with
devices, using for example PCI PASID and PRI.

This time I didn't append the VFIO and SMMUv3 example users. A smaller
series is easier for me to manage and may be less intimidating for
reviewers. If you're adding or updating SVA support to your IOMMU or
device driver, you can find my complete patch stack at [1] for
inspiration.

Changes to patches 1-9 address feedback from v2 [2]. Mostly small tweaks
and comments, that I tried to detail on each patch.

I added patch 10/10 from Jordan Crouse, for managing PASID without
sharing process address spaces. This interface might get superseded by
auxiliary domains [3], since they are more suitable than io_mm for Intel
vt-d's mdev virtualization. Auxiliary domains reuse existing iommu_map/
iommu_unmap/etc ops instead of introducing new ones, so even though it's
more invasive, I tend to prefer that solution. But since we need
something for testing right now, I'm appending patch 10 to the series.

The series depends on Jacob Pan's patches for fault reporting [4].
  iommu: introduce device fault data
  driver core: add per device iommu param
  iommu: add a timeout parameter for prq response
  iommu: introduce device fault report API
  iommu: introduce page response function

[1] git://linux-arm.org/linux-jpb.git sva/v3
[2] https://www.spinics.net/lists/kvm/msg168742.html
[3] https://lwn.net/ml/linux-kernel/20180830040922.30426-1-baolu.lu@linux.intel.com/
[4] https://lwn.net/ml/linux-kernel/1526072055-86990-1-git-send-email-jacob.jun.pan%40linux.intel.com/

Jean-Philippe Brucker (10):
  iommu: Introduce Shared Virtual Addressing API
  iommu/sva: Bind process address spaces to devices
  iommu/sva: Manage process address spaces
  iommu/sva: Add a mm_exit callback for device drivers
  iommu/sva: Track mm changes with an MMU notifier
  iommu/sva: Search mm by PASID
  iommu: Add a page fault handler
  iommu/iopf: Handle mm faults
  iommu/sva: Register page fault handler
  iommu/sva: Add support for private PASIDs

 drivers/iommu/Kconfig      |   9 +
 drivers/iommu/Makefile     |   2 +
 drivers/iommu/io-pgfault.c | 464 ++++++++++++++++++
 drivers/iommu/iommu-sva.c  | 967 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c      | 143 +++++-
 include/linux/iommu.h      | 289 ++++++++++-
 6 files changed, 1855 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.18.0

