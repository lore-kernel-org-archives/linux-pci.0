Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA31EC64EB1
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 16:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AC220837
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 16:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AC220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLGQbm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:31:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49010 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbeLGQbm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Dec 2018 11:31:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDE6F15AB;
        Fri,  7 Dec 2018 08:31:41 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D6393F575;
        Fri,  7 Dec 2018 08:31:39 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     iommu@lists.linux-foundation.org, m.szyprowski@samsung.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Refactor dummy DMA ops
Date:   Fri,  7 Dec 2018 16:31:33 +0000
Message-Id: <cover.1544199754.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Tangential to Christoph's RFC for mitigating indirect call overhead in
common DMA mapping scenarios[1], this is a little reshuffle to prevent the
CONFIG_ACPI_CCA_REQUIRED case from getting in the way. This would best go
via the dma-mapping tree, so reviews and acks welcome.

Robin.

[1] https://lore.kernel.org/lkml/20181206153720.10702-1-hch@lst.de/

Robin Murphy (2):
  dma-mapping: Factor out dummy DMA ops
  ACPI / scan: Refactor _CCA enforcement

 arch/arm64/include/asm/dma-mapping.h |  4 +-
 arch/arm64/mm/dma-mapping.c          | 92 ----------------------------
 drivers/acpi/scan.c                  |  5 ++
 drivers/base/platform.c              |  3 +-
 drivers/pci/pci-driver.c             |  3 +-
 include/linux/dma-mapping.h          |  1 +
 kernel/dma/mapping.c                 | 54 ++++++++++++++++
 7 files changed, 63 insertions(+), 99 deletions(-)

-- 
2.19.1.dirty

