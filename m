Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DDCC65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE10D20811
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="clm6fJBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE10D20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLLFqh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:46:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55608 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLLFqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 00:46:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so4412140wmc.5
        for <linux-pci@vger.kernel.org>; Tue, 11 Dec 2018 21:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TjZzoCV1HwcD3kCkPdW3dsnMfVHtjGYXi/74QDWB40A=;
        b=clm6fJBQpEqaNOrghAtBGe5lA/Ey3ak+GaomIJPn0+oIBqBXekIw6y/VKEUV43ii3E
         7ygSkwgZOkNu3pqv6zcu7wwsHeY0a9dj8lB1QXoNclqQLeY2Qm5moIpYjPFZMq+xmAY8
         8SWRfaoLIb+bHtcw9pH2i7eqPvwheNOfWsaWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TjZzoCV1HwcD3kCkPdW3dsnMfVHtjGYXi/74QDWB40A=;
        b=FkftG7SvD8nP0wn9fhw78BzYaDdQ5gCCmdci8N8HVHCmei8Q6S4Ejsiv5OyEIw3cZQ
         UnWOj+Kzf5i5CegkuS7ToP7nYF6JmXI/exDnrM+P+Ojvg6qBVP606hKgIcTraSVEqcIK
         /08/6OZUKSfctNiWqFvaVFse/x/OY8ZDrXQba5En/cW4GxT6aaLHGC1a5QdpkQRr4sCU
         FiPHgV+rKpw4YpwiTPE1BDUQaI3a6XRt+qMX61zXrhZ8L6ebtOrzcHTMyxf0w7opKwMB
         bNMDYzvpHSccDbXq1NiLU8TwnaO/B0U1icyFL/PTz0Iot1dB7Gev44yHVVWyzdHJkCYA
         FVpA==
X-Gm-Message-State: AA+aEWZdu/u6pwry7i5axsZUpXBh5o5IabepCeNLNrY68YqNjYmVqaCC
        GCgG2hTP2L4PO2brmCBpcVk/og==
X-Google-Smtp-Source: AFSGD/W+p9w7CY/mPn0iivWBiYRS5RWFY0nfliz6PahBvNEVx9zk1h6sOct5iclAuj2cuTV2iHvLoQ==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr4916307wmj.142.1544593594210;
        Tue, 11 Dec 2018 21:46:34 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z206sm2015947wmc.18.2018.12.11.21.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 21:46:33 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH 1/3] PCI: Add dma-resv window list
Date:   Wed, 12 Dec 2018 11:16:07 +0530
Message-Id: <1544593569-8923-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
References: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a dma_resv parameter in pci host bridge structure
to hold resource entries list of memory regions for
which IOVAs has to reserve.

IOMMU framework reserve IOVA for this list of address
range while initializing IOMMU domain of corresponding
PCI EP connected to the HOST.

PCIe host driver will add resource entries to this
list based on requirements.
Few hosts can't use all inbound address, so those
address regions will be add to this list to avoid
IOMMU mapping.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec78400..bbed0e7 100644
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
index e72ca8d..1f0a32a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -472,6 +472,7 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
+	struct list_head dma_resv;	/* reserv dma ranges */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.7.4

