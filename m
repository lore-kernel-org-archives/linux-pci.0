Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4550C64EB1
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A9520837
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 16:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A9520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeLGQbt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:31:49 -0500
Received: from foss.arm.com ([217.140.101.70]:49052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbeLGQbs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Dec 2018 11:31:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7014315BE;
        Fri,  7 Dec 2018 08:31:48 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 394FF3F575;
        Fri,  7 Dec 2018 08:31:46 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     iommu@lists.linux-foundation.org, m.szyprowski@samsung.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI / scan: Refactor _CCA enforcement
Date:   Fri,  7 Dec 2018 16:31:35 +0000
Message-Id: <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544199754.git.robin.murphy@arm.com>
References: <cover.1544199754.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rather than checking the DMA attribute at each callsite, just pass it
through for acpi_dma_configure() to handle directly. That can then deal
with the relatively exceptional DEV_DMA_NOT_SUPPORTED case by explicitly
installing dummy DMA ops instead of just skipping setup entirely. This
will then free up the dev->dma_ops == NULL case for some valuable
fastpath optimisations.

CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Len Brown <lenb@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/scan.c      | 5 +++++
 drivers/base/platform.c  | 3 +--
 drivers/pci/pci-driver.c | 3 +--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bd1c59fb0e17..b75ae34ed188 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1456,6 +1456,11 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 	const struct iommu_ops *iommu;
 	u64 dma_addr = 0, size = 0;
 
+	if (attr == DEV_DMA_NOT_SUPPORTED) {
+		set_dma_ops(dev, &dma_dummy_ops);
+		return 0;
+	}
+
 	iort_dma_setup(dev, &dma_addr, &size);
 
 	iommu = iort_iommu_configure(dev);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 41b91af95afb..c6daca875c17 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1138,8 +1138,7 @@ int platform_dma_configure(struct device *dev)
 		ret = of_dma_configure(dev, dev->of_node, true);
 	} else if (has_acpi_companion(dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
-		if (attr != DEV_DMA_NOT_SUPPORTED)
-			ret = acpi_dma_configure(dev, attr);
+		ret = acpi_dma_configure(dev, attr);
 	}
 
 	return ret;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bef17c3fca67..f899a28b90f8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
 
-		if (attr != DEV_DMA_NOT_SUPPORTED)
-			ret = acpi_dma_configure(dev, attr);
+		ret = acpi_dma_configure(dev, attr);
 	}
 
 	pci_put_host_bridge_device(bridge);
-- 
2.19.1.dirty

