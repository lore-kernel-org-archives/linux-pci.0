Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B75C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3C120811
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L0Ec6l3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3C120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeLMKdh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:33:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44254 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbeLMKd1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 05:33:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so1417413wrt.11
        for <linux-pci@vger.kernel.org>; Thu, 13 Dec 2018 02:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vmdixF+4jff1Pn/iHQJssFMMOyTTldk15RkZzWSnpiw=;
        b=L0Ec6l3UbT8a8xiH2W75tnUq0uKiWojGPxSUBkgnk3sBtJ+P7QOug09BrbFOtCfxal
         ql7iQa5HRHCUS/RO1Yx9SAoW5UlMbfty1c1sPtSHcWH5JT5tOqhwvjYtpTd20xCfdCd6
         6NTiGjJIPOVMvnb/n0WD9QLNsIjo1mkCNsQmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vmdixF+4jff1Pn/iHQJssFMMOyTTldk15RkZzWSnpiw=;
        b=p8P8fdyzVbmEEvdlkqvvgGEoXoXBP0OXR+N0S/m/7jBR7KSxU5jODbzEsSEzX1aAcE
         ExJz+uAjnBLIMar6iqEHvdVkiKElg4bF4W2bWYVlFjkcfjs23wwdzAlps/64Ry4LMDOS
         PmhmquAnWyKwBdYetgp1xJ7A8nJiWW9SIH1OkOMOdeJn4YVZGMapphEAotZZmKeEb8MU
         nBdqCzuizvd1t5ePBxELOhdQviwdPMh2Xgu6DfOyixlebH67cAXanfEO7jWFWwenVPMd
         5Gnrl1G6Dbwd/LL3iuXWRFvseghvNz+t8S+qOjgJFHdbQ6iZWd0i2PvKWUOf+hOlZGuA
         a/cg==
X-Gm-Message-State: AA+aEWYaHTFuY5vO8UK8DZDZDsPoJjDUaPe7hTQBxUO2igm+t+akoa05
        5ZW6vnr+wHDWFI0zel8C0DHqFg==
X-Google-Smtp-Source: AFSGD/WLBl/V80JpcwucGpQTqKjIsmak/RHQEVVg/hKcJ3DwRQJca63BL19EFJroHAXB0FW1lIjS8Q==
X-Received: by 2002:adf:9168:: with SMTP id j95mr19904609wrj.217.1544697205094;
        Thu, 13 Dec 2018 02:33:25 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x76sm3327058wmd.27.2018.12.13.02.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 02:33:24 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>, poza@codeaurora.org,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 2/3] iommu/dma: IOVA reserve for PCI host reserve address list
Date:   Thu, 13 Dec 2018 16:02:53 +0530
Message-Id: <1544697174-6029-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
References: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI host bridge has list of resource entries contain address ranges for
which IOVA address mapping has to be reserve.
These address ranges are the address holes in dma-ranges DT property.

It is similar to PCI IO resources address ranges reserving in IOMMU for
each EP connected to host bridge.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
---
 drivers/iommu/dma-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 511ff9a..346da81 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -220,6 +220,14 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* Get reserved DMA windows from host bridge */
+	resource_list_for_each_entry(window, &bridge->dma_resv) {
+
+		lo = iova_pfn(iovad, window->res->start - window->offset);
+		hi = iova_pfn(iovad, window->res->end - window->offset);
+		reserve_iova(iovad, lo, hi);
+	}
 }
 
 static int iova_reserve_iommu_regions(struct device *dev,
-- 
2.7.4

