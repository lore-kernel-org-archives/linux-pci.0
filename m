Return-Path: <SRS0=Vpie=CC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE8AC433E1
	for <linux-pci@archiver.kernel.org>; Mon, 24 Aug 2020 10:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E484A2075B
	for <linux-pci@archiver.kernel.org>; Mon, 24 Aug 2020 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598264677;
	bh=ZspAYrgKDTmBNHy/ywqplMs3if9rKgSyP7iTSWSHNgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cDe0LwnBhoUr26HdnwJ6y8D2xLKA/FAYB0CjAWtT91X05ABJCBAXF0vFNbug8zBL7
	 6sRmN7ldTanNZicTk8xJvzEjUwdDEBQk8UNhQ42XKP7wnvG21ih9tpw5HNrH+/mvml
	 bGcwYMOGF+7cekbyoLblcT+I1eqObP2QN2W4PPQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHXKYX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgHXKX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Aug 2020 06:23:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 739322075B;
        Mon, 24 Aug 2020 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598264638;
        bh=ZspAYrgKDTmBNHy/ywqplMs3if9rKgSyP7iTSWSHNgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXq/tFSh10d4vDMd+ALSikOHYrTpsiDB51uTg6Nn2FqMGlUH27FvW+vqS4aAmvgMB
         0UQJjd/nqySHqgVtuiKuljYqx0vb8MWop4u0yQ3Woex2LSavoT2mjKlLx3MYUrdxGZ
         aURtHtVy9mnInPTUZ/h3spL+tmxjH0zi70A3pdXM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kA9ds-006BQc-Tj; Mon, 24 Aug 2020 11:23:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 8/9] irqchip/mvebu-sei: Use hierarchy retrigger helper
Date:   Mon, 24 Aug 2020 11:23:16 +0100
Message-Id: <20200824102317.1038259-9-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200824102317.1038259-1-maz@kernel.org>
References: <20200824102317.1038259-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, gregory.clement@bootlin.com, jason@lakedaemon.net, laurentiu.tudor@nxp.com, tglx@linutronix.de, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-mvebu-sei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 18832ccc8ff8..4fc258649785 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -133,6 +133,7 @@ static struct irq_chip mvebu_sei_ap_irq_chip = {
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_set_affinity       = irq_chip_set_affinity_parent,
 	.irq_set_type		= mvebu_sei_ap_set_type,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 };
 
 static void mvebu_sei_cp_compose_msi_msg(struct irq_data *data,
@@ -162,6 +163,7 @@ static struct irq_chip mvebu_sei_cp_irq_chip = {
 	.irq_set_affinity       = irq_chip_set_affinity_parent,
 	.irq_set_type		= mvebu_sei_cp_set_type,
 	.irq_compose_msi_msg	= mvebu_sei_cp_compose_msi_msg,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 };
 
 static int mvebu_sei_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.27.0

