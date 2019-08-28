Return-Path: <SRS0=6piv=WY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66698C3A5A1
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 14:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2C82339E
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 14:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8OwXvXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfH1OPB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:15:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfH1OPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 10:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iziR7QTvHIpOdYO2vSn6hrc74fDyyY3IA+Av3LG5GSY=; b=m8OwXvXwzFiA/j1r27uxGKTg90
        zgJM+3IwN0c0/RkgHvSCE85Zd1+zUkeAVj6LUZ7YJuA9/iEhhAH3U8vd/ORy5TAxKB7yxAHyO0m9H
        iPXDiv2P1kywFypQRTCYRRiK0qA55DrFvkK/6sS9yKPtCYMectpiiJL2rCskSpLlI3gXBGXN9mkt+
        PJgXyQOoSlw1MGp85SCHrAz9g5PguUE6yF7AO/wC3aFgC8B7IiBwMympsHNrfLZNbPqO9W7f5KUY7
        +5HLIIQuOJ0IsJhqs9m8QXkl+SiQTARfwtLr/lle4kO7QLCuNfSOM4jxi7N/zUR+8VxjvOTWDTCgx
        KIfEGLVw==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2yiv-0000Tx-I5; Wed, 28 Aug 2019 14:14:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     x86@kernel.org, joro@8bytes.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] x86/pci: Replace the vmd_domain field with a vmd_dev pointer
Date:   Wed, 28 Aug 2019 16:14:41 +0200
Message-Id: <20190828141443.5253-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828141443.5253-1-hch@lst.de>
References: <20190828141443.5253-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Store the actual VMD device in struct pci_sysdata, so that we can later
use it directly for DMA mappings.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pci.h   | 5 ++---
 drivers/pci/controller/vmd.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 75fe28492290..a9bb4cdb66d4 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -25,7 +25,7 @@ struct pci_sysdata {
 	void		*fwnode;	/* IRQ domain for MSI assignment */
 #endif
 #if IS_ENABLED(CONFIG_VMD)
-	bool vmd_domain;		/* True if in Intel VMD domain */
+	struct device	*vmd_dev;	/* Main device if in Intel VMD domain */
 #endif
 };
 
@@ -64,12 +64,11 @@ static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
 #if IS_ENABLED(CONFIG_VMD)
 static inline bool is_vmd(struct pci_bus *bus)
 {
-	return to_pci_sysdata(bus)->vmd_domain;
+	return to_pci_sysdata(bus)->vmd_dev != NULL;
 }
 #else
 #define is_vmd(bus)		false
 #endif /* CONFIG_VMD */
-}
 
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 4575e0c6dc4b..785cb657c8c2 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -660,7 +660,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
-	sd->vmd_domain = true;
+	sd->vmd_dev = &vmd->dev->dev;
 	sd->domain = vmd_find_free_domain();
 	if (sd->domain < 0)
 		return sd->domain;
-- 
2.20.1

