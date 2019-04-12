Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032E5C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 03:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38492083E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 03:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OvIjFl1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDLDOB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:14:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40981 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLDOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 23:14:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id g6so3057748edc.8
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2019 20:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BA318eIq/ox3LrTa6ojnh5Fujqy32l0ECRZ1GgahC8Q=;
        b=OvIjFl1cf6jHzfn8YkMI1A76F+PXL0/0dP+dQwBBo1jDqx6NVXCv6xprWX4fpMpNqw
         ptmG61OeALgLt9CLXh8FDB4qXP2nnGcvfUbDpXdATIpmOYzIheh+48cV7O7tcgZyGzKo
         nVW6VtcPYRH92qy3BltSNDlt5hjNzwyJPcVk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BA318eIq/ox3LrTa6ojnh5Fujqy32l0ECRZ1GgahC8Q=;
        b=lS8zp7Zaa4g8sHh0NK+L8EgAqcb9BcB+5Dr20Zs7redd9qXsuwai51Hpl3HcV9Ea5J
         Y/8t4BvprKoZ3BBS3T5VVTZT9OameRO4DpHwhu+FA3Z1HUY0rFbjz2mMxQJfofmSLBI2
         fypRK1HJaKGDgWWIiShfRcPsmRWEQGMdustgTg6SbiCICG4YyuskPVRMlCSfR/6oqYql
         xf/5nxOBjoVCOygNv6iFLALdS+pvFfOzqPob2E2wifiwFXk6hXP/X3xxctyVHKGrI1h0
         qPngZATCDwYm732G8ZnCuWqVV477vXxEaIwzcZlQiPDziwrFUcKjn8cSumyTxEvUs6lC
         JC1w==
X-Gm-Message-State: APjAAAX8W1oyP1MKqZwi8p3O4O6x9WD4iI2vfly24k5wvhTVAesJK+hO
        j6tpFi2NQ2rFKsRLC+XkwfhV7Q==
X-Google-Smtp-Source: APXvYqxIz+I4MHNrPKhgdy5fSwvOcaDMNK06XD7IWR8nOVbYPGDMhBVPDSd6C/ppYxHeJUSAax7pAg==
X-Received: by 2002:a17:906:54d1:: with SMTP id c17mr4317274ejp.223.1555038839109;
        Thu, 11 Apr 2019 20:13:59 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c7sm11533352edt.70.2019.04.11.20.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Apr 2019 20:13:58 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 1/3] PCI: Add dma_ranges window list
Date:   Fri, 12 Apr 2019 08:43:33 +0530
Message-Id: <1555038815-31916-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a dma_ranges field in PCI host bridge structure to hold resource
entries list of memory regions in sorted order given through dma-ranges
DT property.

While initializing IOMMU domain of PCI EPs connected to that host bridge
This list of resources will be processed and IOVAs for the address holes
will be reserved.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6..ce5505f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -544,6 +544,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
@@ -572,6 +573,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;
@@ -581,6 +583,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_ranges);
 
 	kfree(bridge);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c..016a044 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -487,6 +487,7 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
+	struct list_head dma_ranges;	/* dma ranges resource list */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.7.4

