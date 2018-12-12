Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1810BC04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22CD2086D
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hNkJ0s9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22CD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLLFqt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:46:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52001 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeLLFqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 00:46:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so4471502wmh.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Dec 2018 21:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4aT+lpIc+NJpqnZ6pq48JRajzcrSuiEPbqJBDas7aFM=;
        b=hNkJ0s9Nm8OfkASjOtmSpBDFwguWfVpT0QPfrdhUguj4qkvQj62N0NNuETViSSyqrA
         iU1mq/wR8sHku5gV8M6kcIsL2XYszCnuFGjD5VUwdl283ynfCIT1PuWrOdPvXDwjcDPK
         H1pkccsxROjIe65x2bT3DEB1wXzUD3pofvqcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4aT+lpIc+NJpqnZ6pq48JRajzcrSuiEPbqJBDas7aFM=;
        b=sJjCmTKgxSh3CiRpj/Ssx9V2WKjTvW979zBU0v29OJC/GtWJTkPccYKE5V+Lo//0Za
         XIieV9z6bORAC1dFKctTq4SvTCfI3xxVpCg8CLGFwkuluLc//P5KF5PH7WWluNs2GbIr
         v9QosjnLMlCh/fmWKwxnluclfqVpHzGgX5NbiqRhhr4Bb+8x45HgdlEHikZJ+M8ADPjU
         PUzDTDW2tIQP701ZeLuW7iXQvVyi+/Ugq4ZckPHVuNErPq9WO1V0wNVHvLzPkI/ad5uA
         CGuaZpSXgVS/X+FgH2eLr3j46FZWyhn6l16ONLu/MfwyIQ4T/wryEO6WBKCCqZ/fjKBX
         gpUg==
X-Gm-Message-State: AA+aEWaF0xU7BoURdW4fzP3Jc8JQXR+NiObKNCoZAj5lbc8NTXUf0R9r
        0GcrUW1siXBgos91t9B68CTzDw==
X-Google-Smtp-Source: AFSGD/WC/pO8MUYC1vKvP8mhgQKOmFpXuOmOPa5/1MOXw37ADAW+FKEBCzvjBAVaelSkEYb8dEh1Lw==
X-Received: by 2002:a1c:888d:: with SMTP id k135mr5166553wmd.137.1544593600964;
        Tue, 11 Dec 2018 21:46:40 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z206sm2015947wmc.18.2018.12.11.21.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 21:46:40 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH 2/3] iommu/dma: IOVA reserve for PCI host reserve address list
Date:   Wed, 12 Dec 2018 11:16:08 +0530
Message-Id: <1544593569-8923-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
References: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI host has list of resource entries contain memory
address range for which IOVA address mapping has to
be reserve.
These address ranges are the address holes in
dma-ranges property.

It is similar to PCI IO resources address range
reserving in IOMMU for each EP connected to
corresponding host.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
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

