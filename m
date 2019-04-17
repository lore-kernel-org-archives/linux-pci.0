Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD1BC282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7DB217F4
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfDQS2K (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:28:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49664 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfDQS2K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 14:28:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7675E15AB;
        Wed, 17 Apr 2019 11:28:09 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C687B3F59C;
        Wed, 17 Apr 2019 11:28:06 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        okaya@kernel.org, zhongmiao@hisilicon.com, eric.auger@redhat.com,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 0/9] Add PCI ATS support to Arm SMMUv3
Date:   Wed, 17 Apr 2019 19:24:39 +0100
Message-Id: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series enables PCI ATS in SMMUv3. Changes since v2 [1]:

* Fix build failure when building arm-smmu-v3 without CONFIG_PCI
  Patches 1 and 2 are new.

* Only enable ATS if the root complex supports it. For the moment, only
  IORT provides this information. I have patches for devicetree but
  they are less mature and I'd rather make it a separate series.

* Tried to address most comments. I'll see if I can improve the firmware
  code when adding devicetree support (see [2]).

Note that there is a small conflict with the SVA API. This series
applies on top of Joerg's api-features branch for v5.2.

[1] https://www.spinics.net/lists/arm-kernel/msg719722.html
[2] git://linux-arm.org/linux-jpb.git ats/current

Jean-Philippe Brucker (9):
  PCI: Move ATS declarations outside of CONFIG_PCI
  PCI: Add a stub for pci_ats_disabled()
  ACPI/IORT: Check ATS capability in root complex nodes
  iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
  iommu/arm-smmu-v3: Store SteamIDs in master
  iommu/arm-smmu-v3: Add a master->domain pointer
  iommu/arm-smmu-v3: Link domains and devices
  iommu/arm-smmu-v3: Add support for PCI ATS
  iommu/arm-smmu-v3: Disable tagged pointers

 drivers/acpi/arm64/iort.c   |  11 ++
 drivers/iommu/arm-smmu-v3.c | 345 ++++++++++++++++++++++++++++--------
 include/linux/iommu.h       |   4 +
 include/linux/pci.h         |  31 ++--
 4 files changed, 306 insertions(+), 85 deletions(-)

-- 
2.21.0

