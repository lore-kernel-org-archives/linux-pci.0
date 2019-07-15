Return-Path: <SRS0=G7Xz=VM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E0C7618F
	for <linux-pci@archiver.kernel.org>; Mon, 15 Jul 2019 14:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D208620868
	for <linux-pci@archiver.kernel.org>; Mon, 15 Jul 2019 14:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="j0SfsQte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbfGOOPs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:15:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40234 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbfGOOPs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 10:15:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so16376824lji.7
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2019 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=W+qk5OnSKLZ1W0b2CWtyeg4mP08iNsbFE5IgLVqWcUc=;
        b=j0SfsQte78cK9hbAhj79vvGVSTrc2dngg0iU0JoRrc0iQM7bJk0AuWcFbNsoTZZz2q
         BB8rEZwcXgja1dD0KLstxyqZasNSJ+SSgzghdlDewpRKkiCSuuX2gwLRm0sWFCeAsTzy
         jKj0AJnb++vzbJnm7TbBXpI6Hdz+WIp25loiYjRYZ1cApyX0TUSs8UT9M6uenIz3hLbk
         d6xMqdygpWwh4AdjVYhXgmEsWCsb/rmf+Gfmn7qAPBMoKL0cm6cn+8Rq+Rune2ED0/vD
         gsGlv/BvnazEnQzkBSB9yDyW7Wv9JyZW4fWoR4teb2JnBHWKTPGYQ7tjLHN/0bBvG/FZ
         wRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W+qk5OnSKLZ1W0b2CWtyeg4mP08iNsbFE5IgLVqWcUc=;
        b=Taan7tcXwY8hcy+YPAVHmxcedWN8EojR0yYZMeUkJsOuTTH2WASEvC50xyzE/EuipL
         cgI0M7s2oJDz+bWGAyqa0CPXl/SdK/zHEoBvz/JxQz8AppOH+Qm046YwOybaS4XI8MXh
         aBNBPyLoHxvmxKqr8LQZMMF0VhuDvl5u2tDlFBb6UqDD1pJ+tlxdHCNZO9L3g/X1TxO3
         pFLAfz5GDr5l/F3QlMEmE7dteJQOMxPGdVoEMyBFW0ezFiYZWc8ulFbSOXH4SkDPyhtD
         qmrmzMRZaDxaBz+tJq1op2Nc+5twon2kspvGtd3+d6Y+3ITGvCOYntRZIJjjMiwFm7Yo
         4yGQ==
X-Gm-Message-State: APjAAAXq1i8ER8stO+oHEgIdInMu2d11a4i7poFK4tP3aV0lDtqO+PIA
        xrbvGnZ9+odDP12TM73i+dU=
X-Google-Smtp-Source: APXvYqzAfg0cKEaU6tGImHXKQpAH3vstfYCt2zgZXZGOBqeH+wJYNSJDV9XiP5gQt1Al6Ut9gQXbTQ==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr14271444lja.230.1563200146300;
        Mon, 15 Jul 2019 07:15:46 -0700 (PDT)
Received: from gilgamesh.semihalf.com (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id s20sm2326646lfb.95.2019.07.15.07.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jul 2019 07:15:45 -0700 (PDT)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [PATCH] PCI: aardvark: fix big endian support
Date:   Mon, 15 Jul 2019 16:15:22 +0200
Message-Id: <1563200122-8323-1-git-send-email-jaz@semihalf.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Initialise every not-byte wide fields of emulated pci bridge config
space with proper cpu_to_le* macro. This is required since the structure
describing config space of emulated bridge assumes little-endian
convention.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 drivers/pci/controller/pci-aardvark.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 134e030..06a12749 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -479,8 +479,10 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 {
 	struct pci_bridge_emul *bridge = &pcie->bridge;
 
-	bridge->conf.vendor = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff;
-	bridge->conf.device = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16;
+	bridge->conf.vendor =
+		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
+	bridge->conf.device =
+		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16);
 	bridge->conf.class_revision =
 		advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;
 
@@ -489,8 +491,8 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
 
 	/* Support 64 bits memory pref */
-	bridge->conf.pref_mem_base = PCI_PREF_RANGE_TYPE_64;
-	bridge->conf.pref_mem_limit = PCI_PREF_RANGE_TYPE_64;
+	bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
+	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
 
 	/* Support interrupt A for MSI feature */
 	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
-- 
2.7.4

