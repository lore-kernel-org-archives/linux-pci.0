Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6BDC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 03:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899702186A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 03:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J9hWhQyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDLDOG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:14:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42976 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDLDOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 23:14:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id x61so7001509edc.9
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2019 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lcdd/bPKb2XUUzHHJ4Ig8E0QGdqRPLhszQ1yDGy5ZoU=;
        b=J9hWhQySSKQQY/XopWADH/wdNBV0kNkG//jg+fm5ydk4AhhSp4gHwr1RUmnOT9S+KM
         QHb3rpEr99GzSx6C8Dpp35JjOjX+qGTA4QuIfW0QOgTuNkCplW3PyO0jEGB6hpN++Erv
         VyD/WxxOIeNgUM1EpxGp+vagG6TfquBJVcLyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lcdd/bPKb2XUUzHHJ4Ig8E0QGdqRPLhszQ1yDGy5ZoU=;
        b=pXcnJrfoC0ZBp3euQE8X804E78FcmL6KYobo8+pfGDaG9qOHjfdngu5KFPQQiNSVlS
         k3ux2Tiws+iTzAfzmY3fWitqtaxhJG8RoNVx6RWGvry92V4ChniF73fOMsxE8QHsKYXw
         c3D6CrnVsUDQdjnaDBXrYeDlpURLiNguoJ8rFFnuSbsIh3jGkzVxk+9/hwCx79NogMAr
         83PH8yBNgm7gg7pn6xspF8UVs/r285CGZCNouoWCJyAKVSuyq/ladeRzAv0BMfux/Mbg
         ZY/GQ03zGMIAHqHe3WvN/p+JT3aL0SSpbLtbdvIHJuPoMk5ocRnxqijBk61nVoqhGxaJ
         Do4g==
X-Gm-Message-State: APjAAAUahPJJI1v37YrPtMvDvQGIgsAuPtW0PdiEa9VL60uq22GYjhv6
        th4x9ZB56wFmuBNTTR/2rCZWvQ==
X-Google-Smtp-Source: APXvYqyF17DtGNMMVaBx6A9eheF/VVXMsZT2lLxxTqgX/YA0cIoSQ3aE7MBfBF9RiDuoupVXJBcmfQ==
X-Received: by 2002:a17:906:d72:: with SMTP id s18mr18238050ejh.111.1555038844689;
        Thu, 11 Apr 2019 20:14:04 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c7sm11533352edt.70.2019.04.11.20.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Apr 2019 20:14:04 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
Date:   Fri, 12 Apr 2019 08:43:34 +0530
Message-Id: <1555038815-31916-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dma_ranges field of PCI host bridge structure has resource entries in
sorted order of address range given through dma-ranges DT property. This
list is the accessible DMA address range. So that this resource list will
be processed and reserve IOVA address to the inaccessible address holes in
the list.

This method is similar to PCI IO resources address ranges reserving in
IOMMU for each EP connected to host bridge.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6..fb42d7c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -212,6 +212,7 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
 	unsigned long lo, hi;
+	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
@@ -221,6 +222,24 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* Get reserved DMA windows from host bridge */
+	resource_list_for_each_entry(window, &bridge->dma_ranges) {
+		end = window->res->start - window->offset;
+resv_iova:
+		if (end - start) {
+			lo = iova_pfn(iovad, start);
+			hi = iova_pfn(iovad, end);
+			reserve_iova(iovad, lo, hi);
+		}
+		start = window->res->end - window->offset + 1;
+		/* If window is last entry */
+		if (window->node.next == &bridge->dma_ranges &&
+		    end != DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE)) {
+			end = DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE);
+			goto resv_iova;
+		}
+	}
 }
 
 static int iova_reserve_iommu_regions(struct device *dev,
-- 
2.7.4

