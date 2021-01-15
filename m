Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EC7C433DB
	for <linux-pci@archiver.kernel.org>; Fri, 15 Jan 2021 21:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895CD239EE
	for <linux-pci@archiver.kernel.org>; Fri, 15 Jan 2021 21:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbhAOVmc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Jan 2021 16:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbhAOVmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2021 16:42:31 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE55C061757;
        Fri, 15 Jan 2021 13:41:51 -0800 (PST)
Received: from dslb-188-096-136-022.188.096.pools.vodafone-ip.de ([188.96.136.22] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1l0WRp-00052t-MJ; Fri, 15 Jan 2021 22:15:57 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v4] PCI: brcmstb: Remove chained IRQ handler and data in one go
Date:   Fri, 15 Jan 2021 22:15:32 +0100
Message-Id: <20210115211532.19837-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108184208.19790-1-martin@kaiser.cx>
References: <20201108184208.19790-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call irq_set_chained_handler_and_data() to clear the chained handler
and the handler's data under irq_desc->lock.

See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained
IRQ handler").

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
Hi Lorenzo,
I sent this simple patch back in November, it seems that it got lost
somehow. Is there any chance that you can apply it?
Thanks, Martin

v4:
 - resend after two months
 - clean up the commit message while at it
v3:
 - rewrite the commit message again. this is no race condition if we
   remove the interrupt handler. sorry for the noise.
v2:
 - rewrite the commit message to clarify that this is a bugfix

 drivers/pci/controller/pcie-brcmstb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index d41257f43a8f..95f6dd93ceae 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -603,8 +603,7 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
 
 	if (!msi)
 		return;
-	irq_set_chained_handler(msi->irq, NULL);
-	irq_set_handler_data(msi->irq, NULL);
+	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
 	brcm_free_domains(msi);
 }
 
-- 
2.20.1

