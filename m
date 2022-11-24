Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64435C433FE
	for <linux-pci@archiver.kernel.org>; Thu, 24 Nov 2022 23:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKXXYf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Nov 2022 18:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKXXYZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BBB8757C;
        Thu, 24 Nov 2022 15:24:20 -0800 (PST)
Message-ID: <20221124230313.747627287@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+CkTPHTMXOvRSl4YB673TzHqsVFLjHUDowE8deLkwuw=;
        b=iHZCIG/cHXpD7WKPRYdgcDW35TWhbcCwmEj1hHREbZK+wJZiDn7hcg4f4bZX5hg4GCPQJB
        xlLigskN1507vPq6NLK55NNEcB1SMKTUHKcznSBb34c2hDmPbmDHoIQ2yjvySwOC6dceu0
        FT+IrAwleEdy35HvzApWQNWCq7ki/zrjvPHhuqO5fdpiYiv70eUv2l8nddVUofTnt3Zo4p
        m3sfa0us8oaxzd9vI2KbOqDmixC3WipVjKUtlNXN8qSn3/Wim0H5/T6bSWI0L1qgkxwU1V
        baA46kEEU03IzcehgEfAYwT5WADk49/l19oA5fqPaijIWXH2zEnd6/YQtEpW7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+CkTPHTMXOvRSl4YB673TzHqsVFLjHUDowE8deLkwuw=;
        b=zJfPk91OdvfHBBvIw058Rm2gSOpHIDNVtmli3FpQqrdhf4wbK8EO0F3yMcEJdH/6GGCLF4
        koEXG5vYC7ar4CAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V3 06/22] genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_DEVICE
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:17 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to marking parent MSI domains it's required to identify per device
domains. Add flag and helpers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -192,6 +192,9 @@ enum {
 	/* Irq domain is a MSI parent domain */
 	IRQ_DOMAIN_FLAG_MSI_PARENT	= (1 << 8),
 
+	/* Irq domain is a MSI device domain */
+	IRQ_DOMAIN_FLAG_MSI_DEVICE	= (1 << 9),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -559,6 +562,11 @@ static inline bool irq_domain_is_msi_par
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_PARENT;
 }
 
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
+}
+
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
@@ -609,6 +617,11 @@ static inline bool irq_domain_is_msi_par
 {
 	return false;
 }
+
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return false;
+}
 
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 

