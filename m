Return-Path: <SRS0=02Cu=A2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A141BC433EA
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jul 2020 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770192072E
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jul 2020 14:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IEMKm4L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGOOgL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:36:11 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45714 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729187AbgGOOgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 10:36:10 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id DC9F130C048;
        Wed, 15 Jul 2020 07:35:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com DC9F130C048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1594823757;
        bh=OBC+b/6h51w/vA3bCYwKpB9PHCkDoS7uVvFOTBt/wN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEMKm4L1Hp98zLPElkCX7Tv2wZvsLLNTIKahBgrjiO+ok/Z0iJWyIhNWMevymNj4q
         c1KEmaasFy/UjVg3575lRmZdxwNNPNZk+EOgN0eFolFjBEFVkEUrOLvXHFBGhgDbCL
         fkxrBzHW/Gd1pyEouAZ21XHqm/dU424EZq6njnvA=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id B64BD14008B;
        Wed, 15 Jul 2020 07:36:07 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 11/12] PCI: brcmstb: Set bus max burst size by chip type
Date:   Wed, 15 Jul 2020 10:35:14 -0400
Message-Id: <20200715143530.9702-12-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715143530.9702-1-james.quinlan@broadcom.com>
References: <20200715143530.9702-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

The proper value of the parameter SCB_MAX_BURST_SIZE varies per chip.  The
2711 family requires 128B whereas other devices can employ 512.  The
assignment is complicated by the fact that the values for this two-bit
field have different meanings;

  Value   Type_Generic    Type_7278

     00       Reserved         128B
     01           128B         256B
     10           256B         512B
     11           512B     Reserved

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 3fb468de4f6f..7a4e0cead7c2 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -55,7 +55,7 @@
 #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
 #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
-#define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128		0x0
+
 #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
 #define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
 #define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
@@ -847,7 +847,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int num_out_wins = 0;
 	u16 nlw, cls, lnksta;
 	int i, ret, memc;
-	u32 tmp, aspm_support;
+	u32 tmp, burst, aspm_support;
 
 	/* Reset the bridge */
 	brcm_pcie_bridge_sw_init_set(pcie, 1);
@@ -867,11 +867,22 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	/* Wait for SerDes to be stable */
 	usleep_range(100, 200);
 
+	/*
+	 * SCB_MAX_BURST_SIZE is a two bit field.  For GENERIC chips it
+	 * is encoded as 0=128, 1=256, 2=512, 3=Rsvd, for BCM7278 it
+	 * is encoded as 0=Rsvd, 1=128, 2=256, 3=512.
+	 */
+	if (pcie->type == BCM2711)
+		burst = 0x0; /* 128B */
+	else if (pcie->type == BCM7278)
+		burst = 0x3; /* 512 bytes */
+	else
+		burst = 0x2; /* 512 bytes */
+
 	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
-	u32p_replace_bits(&tmp, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128,
-			  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
+	u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
 	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
-- 
2.17.1

