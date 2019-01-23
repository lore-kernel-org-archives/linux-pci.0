Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0869C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 13:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4BE21848
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 13:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSImpivu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfAWNSf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:18:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42871 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAWNSf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 08:18:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so1172263pfr.9;
        Wed, 23 Jan 2019 05:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yeQZUst3szUtse1rNYD2HazCWJM4cvJaQarIDmvvznI=;
        b=YSImpivuAaM/+DsgeLKyDRWYoeqPbSwffNXc/wFkdvxOjBtd2gxJVwxvzaFcix2pKe
         FghV7Di/C+6KWf2pnNMjkIlAcTupNsmPmtylXZCnwD7s2qLlLlr1xnxCFRRiukJrZCjd
         siSEHEkbcGoI/RJ4oLP3dyPSZgVjhOKEM9cOc4luwyHiOnEf+3/8xqOGESbhUY+1BplW
         1lLJCn3iBwQFbe3X8AYLhnpOz54jH2X+EDQ78nM/U8ZO5e82RyEr7wRadRiKwG+zpBe6
         kDkVtT3s4O8BeiICT39HzoHCijWljPruMc+5/7If4K3b+Gvl2y15q5+lirezEPUjrDTZ
         ek0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yeQZUst3szUtse1rNYD2HazCWJM4cvJaQarIDmvvznI=;
        b=R9kIdS6IbLH4HN7FcL/MskGkugG7oCA0+cFOrUl4Sp5grYHcmEEFoqBb1CYUOEUlcb
         QdEXk4eicOz6cBZjancKlYuPQVWzBIqFS7OZFV9+4aiPvXDRXGmHlW+C9TKJULkO2CuC
         SD7fqMgVdudAAA9L1pLR572oRmB+QfZRqoPJBE3XgcpD7sjvQpE5yWL8zhxWeBOmPdLl
         ShfZWwkgSNocFfnEmeRAmwPOB5HG51uEemjIxIWI5uuVLRPLjj300bLgNFqbzJ11iY25
         VtWRHxLFX7fT7KODBCxOqcW5Fg3D5HE6T4+sNizUEftEE3T6S7sNj3oegJs12i76LMnj
         mh9A==
X-Gm-Message-State: AJcUukdeUaOnEXP/QkocABqAS4ZeE/cnphWRJemRT/chnRuClq+Zg4yc
        tUZPl4OpBw8hftREdgp2iJ4lLQ2Q
X-Google-Smtp-Source: ALg8bN7ccCtmYRO3R5jkWXvc/9sj29EcqWS83JoJh3SqZmtYYZtir88racON8tOlzgYbBj0siVfa/A==
X-Received: by 2002:a63:9e58:: with SMTP id r24mr2005711pgo.264.1548249514168;
        Wed, 23 Jan 2019 05:18:34 -0800 (PST)
Received: from hyd1358.caveonetworks.com. ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id r187sm64600381pfc.63.2019.01.23.05.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 05:18:33 -0800 (PST)
From:   sundeep.lkml@gmail.com
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sean.stalley@intel.com, sgoutham@marvell.com, helgaas@kernel.org,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [v3 PATCH 1/2] PCI: read fixed bus numbers in EA for type 1 functions
Date:   Wed, 23 Jan 2019 18:48:00 +0530
Message-Id: <1548249481-24645-1-git-send-email-sundeep.lkml@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

As per the spec - ECN_Enhanced_Allocation_23_Oct_2014_Final
and section 6.9.1.2, EA capability contains fixed secondary
and subordinate bus numbers for type 1 functions.
This patch adds support to read the fixed bus numbers
from EA capability for bridge.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v3:
  As per Bjorn's suggestion placed EA stuff in pci_ea_init and
  captured bus numbers in pci_dev
v2:
  None just added Sean

 drivers/pci/pci.c             | 10 ++++++++--
 include/linux/pci.h           |  4 ++++
 include/uapi/linux/pci_regs.h |  4 ++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c25acac..484b63e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2909,6 +2909,7 @@ void pci_ea_init(struct pci_dev *dev)
 	u8 num_ent;
 	int offset;
 	int i;
+	u32 dw;
 
 	/* find PCI EA capability in list */
 	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
@@ -2922,9 +2923,14 @@ void pci_ea_init(struct pci_dev *dev)
 
 	offset = ea + PCI_EA_FIRST_ENT;
 
-	/* Skip DWORD 2 for type 1 functions */
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+	/* Note fixed bus numbers for type 1 functions */
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		pci_read_config_dword(dev, offset, &dw);
+		dev->fixed_sec_busnr = dw & PCI_EA_FIXED_SEC_BUS;
+		dev->fixed_sub_busnr = (dw & PCI_EA_FIXED_SUB_BUS) >>
+					PCI_EA_FIXED_SUB_SHIFT;
 		offset += 4;
+	}
 
 	/* parse each EA entry */
 	for (i = 0; i < num_ent; ++i)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c..3e9a3ae 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -459,6 +459,10 @@ struct pci_dev {
 	char		*driver_override; /* Driver name to force a match */
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
+
+	/* bus numbers from EA capability if this device is a bridge */
+	u8 fixed_sec_busnr; /* Fixed Secondary Bus number */
+	u8 fixed_sub_busnr; /* Fixed Subordinate Bus number */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e1e9888..51e9ac0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -372,6 +372,10 @@
 #define PCI_EA_FIRST_ENT_BRIDGE	8	/* First EA Entry for Bridges */
 #define  PCI_EA_ES		0x00000007 /* Entry Size */
 #define  PCI_EA_BEI		0x000000f0 /* BAR Equivalent Indicator */
+/* Fixed Secondary and Subordinate bus numbers in EA for Bridge */
+#define   PCI_EA_FIXED_SEC_BUS		0xff
+#define   PCI_EA_FIXED_SUB_BUS		0xff00
+#define   PCI_EA_FIXED_SUB_SHIFT	8
 /* 0-5 map to BARs 0-5 respectively */
 #define   PCI_EA_BEI_BAR0		0
 #define   PCI_EA_BEI_BAR5		5
-- 
1.8.3.1

