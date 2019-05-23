Return-Path: <SRS0=jwu3=TX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5AFC282DD
	for <linux-pci@archiver.kernel.org>; Thu, 23 May 2019 21:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAEE2177E
	for <linux-pci@archiver.kernel.org>; Thu, 23 May 2019 21:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ShEJArcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfEWVqI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 May 2019 17:46:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34602 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388220AbfEWVqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 17:46:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so753046pgg.1
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jLaVtK3dTIBGULW9LqgDdHPCnDBMlxzNCTE/sRHoa70=;
        b=ShEJArcL1KurA1638gz4USiZ00iMtMSug5yVVcXiRtq5yuXns/UC6ym+0dTJvdOUoj
         78DW7v4DCsJEVZi7VsL+DUQGnYD/1Gw8cYLRnzV2fIY9cvZHx4JmP8dJBZ/CkrOvy/r6
         hi6huQyiN4IcB8uajCWgiy5jB/ADDU4MVssRWpr3I9BmE61Qbz5XtRDsAnlSFWRDu5DV
         sPy2ijb70+9EyYSeZQxR5v5/w559ski9jk2+HKGKlMcSUeFIRbXFkN2eGJ3NZx0sXHnv
         YduhiMCdIg52qX7KfA1u3Patzl0qE9lP7Gnrb1Jxs3NK9JufLOthzMFXYm5Ta+3oh9K1
         nr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jLaVtK3dTIBGULW9LqgDdHPCnDBMlxzNCTE/sRHoa70=;
        b=doRFrJOvASUdlvnPkYell80pNux1N4gKixLrxM+88UfX+b5/mdL7w+ES59BRL0qqra
         hNcUmG4ZM8vyPbOwQaUuA5YSf4wJjHEkSbWUQyJNCkGeXa2ZlctwIaUUeBO2HwPUfd+j
         qJDcC8/wQPG0Aaw9e8gYrDaNxfCZB98cQPyo9Il9GzJW5a+zrP40Xw3sdWPmeXJvb0Sd
         pZF2YiQMTEPBzh4vY4Nph90ylm0XtuOH+sf3jEvSfxwAB3rr/erf/6IHMiJmdZUpt342
         AyE2bgXdpNAXR6M/n9pmKzk8v9vtxP4b3yRm63+bEy1gKY822qV5teM8xACCQGSEXdBK
         UEAA==
X-Gm-Message-State: APjAAAVBxDELB1gHbBhf0+YjCxcroA7cRJirWstrfCxPthkkUtPwj3nU
        0NCNDdzYAN91WOKDMP91dYtTnxJrA/I=
X-Google-Smtp-Source: APXvYqynmmrSYP3AvQ6rwIRLvBAGL2pYB9a1i/aJMnlDC2kN1XI9/kUmEwXDShzjnRKLI1X8+9HLCQ==
X-Received: by 2002:a63:5211:: with SMTP id g17mr69897684pgb.405.1558647967581;
        Thu, 23 May 2019 14:46:07 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id q10sm376519pff.132.2019.05.23.14.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 14:46:06 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] PCI: endpoint: Set endpoint controller pointer to null
Date:   Thu, 23 May 2019 14:45:44 -0700
Message-Id: <1558647944-13816-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set endpoint controller pointer to null in pci_epc_remove_epf()
to avoid -EBUSY on subsequent call to pci_epc_add_epf().

Requires checking for null endpoint function pointer.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e4712a0f249c..2091508c1620 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -519,11 +519,12 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
 	unsigned long flags;
 
-	if (!epc || IS_ERR(epc))
+	if (!epc || IS_ERR(epc) || !epf)
 		return;
 
 	spin_lock_irqsave(&epc->lock, flags);
 	list_del(&epf->list);
+	epf->epc = NULL;
 	spin_unlock_irqrestore(&epc->lock, flags);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
-- 
2.7.4

