Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E372C41518
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3F92184B
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OUkU7jW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfAYKOP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:14:15 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40506 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfAYKOO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 05:14:14 -0500
Received: by mail-yb1-f194.google.com with SMTP id i6so3611560ybo.7
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 02:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=063dcY3/vP5rDMt/yMZyLAKDPwT36w8/uKywwVSqR7A=;
        b=OUkU7jW5T0JFjB5c1nbeePMkV51tr14zOf7WXdsd5B45p4Bd28foWEwE0WcL3pJjl8
         FlYibvC8s9aUinlGQ/v1A84bDetYuMhxkrRF5F0JlZsF0oERQjwbqJaxf4VQQKwxee7d
         s/jLCYa7iktz9Q6rYS7yJVYA3JbU9WtyDbCl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=063dcY3/vP5rDMt/yMZyLAKDPwT36w8/uKywwVSqR7A=;
        b=ndF4glb/czwaVxm23gOj37QOvematEnpQrOMJ/BQ3QlVNOOdZNXuASw5T0RhLZFhRB
         FPsKwvtCmWFie1/MzmaL1IDqSlEJ4aboEm7lTLn+Z9IiSBMPOMrV9cFmu7U+MqSMw+Qv
         AyIeRb9PDe4VyBXBTsFvFlileHwbl7JKPr8HU8PDOjHTQ5l+zwzc0lMGC15Dd7cYcl0E
         5LL2Q01CH/x8ZppzwXbOcce9Msr8qBClfpWeMx86tWj6Qny6tZnWoFG6ilLo4ltAjwXR
         Mf1/gDWzgWVDt7nj8E1gmefLNFh2U5P5H+QpHhqNavntr7QyWbb2oc43jGmySIvUhjvl
         PwAg==
X-Gm-Message-State: AJcUukcOaTDSc/nrYVp/fAqHOuEbrnhvK4CcbAsauQ2aOGNONpCKgo+a
        GIzha6hd8Zt2s4bqTD/R5SgBXg==
X-Google-Smtp-Source: ALg8bN4bS7lzAX6NAn3Eb5Yap4JAGs/S7bRbtsHiCTSU4QWQns8Dasr+086aBZzCfltTNuydH6o/Rw==
X-Received: by 2002:a25:6e42:: with SMTP id j63mr9601386ybc.302.1548411253878;
        Fri, 25 Jan 2019 02:14:13 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x203sm11868695ywd.41.2019.01.25.02.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jan 2019 02:14:13 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 2/3] iommu/dma: Reserve IOVA for PCI host reserve address list
Date:   Fri, 25 Jan 2019 15:43:50 +0530
Message-Id: <1548411231-27549-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI host bridge has list of resource entries contain address ranges for
which IOVA address mapping has to be reserve. These address ranges are
the address holes in dma-ranges DT property.

It is similar to PCI IO resources address ranges reserving in IOMMU for
each EP connected to host bridge.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/iommu/dma-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6..81b591b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -221,6 +221,14 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
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

