Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEDBC282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71591218B0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gom59CLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfAYKOO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:14:14 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36110 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbfAYKOK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 05:14:10 -0500
Received: by mail-yb1-f194.google.com with SMTP id c65so2001660ybc.3
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 02:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FyX1ArXOVKvRPOp9yrfUP0CSUTYZC9LeUmgndjP+YYQ=;
        b=Gom59CLttiaYZxslOybT9vf3fqbH7AFri5n3BxXtJ7RNSLMgi0cCWDVthrbS+GZRR2
         6B3qCmBp+yQI7dvQ3hWw/X1/tJvOzj3z4ETB+L5eKi3cuSp8NMp/eru2OUFayEmRH2ge
         DSor2h+FVtKHhp7AJzc1cWNsGhVRmN03vL6Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FyX1ArXOVKvRPOp9yrfUP0CSUTYZC9LeUmgndjP+YYQ=;
        b=Khc6HDXlyEb15Yc5D75NqBZ1aFfYmb7/J33rPnXZfyOfxt3YiUb6+E3GtgvxhhQcqs
         39ut6TM1X5RjK7QTSZWlUmVQ/v/R9BEocS7HSozijvNrpbB/oplfXxrwxQnmDML236NW
         cF2PNAxiPPnShzbb4Kw4wDx1aERIItSfYU+Jt5aENU59hYuya8ox6V5CvPVp28p6kmyk
         C/WRrj6o+3cREZGUETdAR5O+IgR6d6D4wogmp3OF6sgBWmJxXX0+2vDaFXKradS/xZBx
         Iw0k9oVP7AvCcB0gItiMM4LMf2iBUuNmz9sPbz8NebtAg5OkjtlNujB32lqr3eN+RkUe
         +PlQ==
X-Gm-Message-State: AJcUukcbuHDLQE1NlFLl0+7jIuar8nY6zHnmDtKjDs5q8IDFXK9kJoU1
        OwN2VSSD/YBgBA7AVydx8zASSg==
X-Google-Smtp-Source: ALg8bN5NFieCYJeEbFL/ROggRLmjqQxOd+qKsHtnO3lkw1dFFvjboxm5G4RNl+us6HXapOEmhDB1Cg==
X-Received: by 2002:a25:6a44:: with SMTP id f65mr9656151ybc.25.1548411249438;
        Fri, 25 Jan 2019 02:14:09 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x203sm11868695ywd.41.2019.01.25.02.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jan 2019 02:14:08 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 1/3] PCI: Add dma-resv window list
Date:   Fri, 25 Jan 2019 15:43:49 +0530
Message-Id: <1548411231-27549-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a dma_resv parameter in PCI host bridge structure to hold resource
entries list of memory regions for which IOVAs have to reserve.

PCIe host driver will add resource entries to this list based on its
requirements. Few inbound address ranges can't be allowed by few PCIe host,
so those address ranges will be add to this list to avoid IOMMU mapping.

While initializing IOMMU domain of PCI EPs connected to that host bridge
IOVAs for this given list of address ranges will be reserved.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6..fd4b143 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -544,6 +544,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_resv);
 	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
@@ -572,6 +573,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_resv);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;
@@ -581,6 +583,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_resv);
 
 	kfree(bridge);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c..aa06105 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -487,6 +487,7 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
+	struct list_head dma_resv;	/* reserv dma ranges */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.7.4

