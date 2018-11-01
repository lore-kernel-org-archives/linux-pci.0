Return-Path: <SRS0=Nkm2=NM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B43DC0044C
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 09:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D571720820
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 09:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/Cdlkjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D571720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeKASeE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:34:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41985 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeKASeE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Nov 2018 14:34:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so8661011plo.9;
        Thu, 01 Nov 2018 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rdX8BdAqCfUip4bFmM2g6AFtBh5t5xlJ1pGrWIXdPJs=;
        b=Q/CdlkjyNyFsirMvob48oweaHJvx5BSHSzWJNdBqGlviTOioCJKlQ+++JnJeqB+v8U
         HGH5LQriOa84rkssDZxY5yekY8xJGXWjK8tgV63/RaOubHBSAINLlFJ1BuQpUenw2qvH
         v7EmVxw2n1XLweXjmiHFA5tCt2Wg/UbQsnd9yd2N5UfiqLZ/+Of+gcGJDvYqtsrIeM2W
         +0IGvunjyXa6vk8KBysLwr0AF4G6pLPssLxR1ev7ufoXEnHy/bO8VkvyKR6moqu5P/40
         z/v6fTgdVnkaqeanzW6mD59nDMyusM67pS778stt+wEzCA1z3wmaOJGzeeMmvr9fmCPU
         vIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rdX8BdAqCfUip4bFmM2g6AFtBh5t5xlJ1pGrWIXdPJs=;
        b=CRgJG/0lYglpYeKKEEzUeaN5jwgZs+KMgHTwfJrQFO1RNsUIs9GTKy+nnNzS4CqaWk
         lizsYOPORkCacw2baC1e8jz8ioXk4FSsMBG9C+hAp194gkIdkgsgRoHGIEKUp0F8EvF2
         T9csKYumfGcIf28oNpz/m/sEpIkP0xOfmIHh9TJa6NX6j+hLRDjaJJe1YJHBszqAGNAx
         KbWrEnNZt58JjIu8FmGi8V3ZKVSHTqmWJWgnhg5QEQsnH0wTQzwFO96h6jhO0AQEKF8u
         Cj27Op6UVpd6J6dUdZFkj2jHd2io2CQqLqqm7LF9EAOwSWiIFC7MvB9CpqXk5aemKy01
         kFbA==
X-Gm-Message-State: AGRZ1gICR2ZA61CJAMH3ZmgVE2vmN1gHPNV4Kw7ngxRKBIUvC6fV/BKs
        a78DQIt1dE+WfzA4jwM2RNc=
X-Google-Smtp-Source: AJdET5foMYDN5aonwbksuR9f5YVHcFDQvQAWcuaG+ofXzenfLcrukEyu2ych8Qo+p0MXe0WFacg4AQ==
X-Received: by 2002:a17:902:7406:: with SMTP id g6-v6mr2256874pll.335.1541064712129;
        Thu, 01 Nov 2018 02:31:52 -0700 (PDT)
Received: from hyd1358.caveonetworks.com. ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id b14-v6sm32587214pgn.49.2018.11.01.02.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 02:31:51 -0700 (PDT)
From:   sundeep.lkml@gmail.com
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sgoutham@marvell.com, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH] PCI: assign bus numbers present in EA capability for bridges
Date:   Thu,  1 Nov 2018 15:01:15 +0530
Message-Id: <1541064675-20324-1-git-send-email-sundeep.lkml@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

As per the spec, bridges with EA capability work
with fixed secondary and subordinate bus numbers.
Hence assign bus numbers to bridges from EA if the
capability exists.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/pci/probe.c           | 58 ++++++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h |  6 +++++
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b1c05b5..f41d2e6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1030,6 +1030,40 @@ static void pci_enable_crs(struct pci_dev *pdev)
 
 static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 					      unsigned int available_buses);
+/*
+ * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
+ * numbers from EA capability.
+ * @dev: Bridge with EA
+ * @secondary: updated with secondary bus number in EA
+ * @subordinate: updated with subordinate bus number in EA
+ *
+ * If it is a bridge with EA capability then fixed bus numbers are
+ * read from EA capability list and secondary, subordinate reference
+ * variables will be updated. Otherwise secondary and subordinate reference
+ * variables will be zeroed.
+ */
+static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *secondary,
+				u8 *subordinate)
+{
+	int ea;
+	int offset;
+	u32 dw;
+
+	*secondary = *subordinate = 0;
+
+	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+		return;
+
+	/* find PCI EA capability in list */
+	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
+	if (!ea)
+		return;
+
+	offset = ea + PCI_EA_FIRST_ENT;
+	pci_read_config_dword(dev, offset, &dw);
+	*secondary =  dw & PCI_EA_SEC_BUS_MASK;
+	*subordinate = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
+}
 
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
@@ -1064,6 +1098,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	u16 bctl;
 	u8 primary, secondary, subordinate;
 	int broken = 0;
+	u8 fixed_sec, fixed_sub;
+	int next_busnr;
 
 	/*
 	 * Make sure the bridge is powered on to be able to access config
@@ -1163,17 +1199,25 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
+		/* read bus numbers from EA */
+		pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
+
+		next_busnr = max + 1;
+		/* Use secondary bus number in EA */
+		if (fixed_sec)
+			next_busnr = fixed_sec;
+
 		/*
 		 * Prevent assigning a bus number that already exists.
 		 * This can happen when a bridge is hot-plugged, so in this
 		 * case we only re-scan this bus.
 		 */
-		child = pci_find_bus(pci_domain_nr(bus), max+1);
+		child = pci_find_bus(pci_domain_nr(bus), next_busnr);
 		if (!child) {
-			child = pci_add_new_bus(bus, dev, max+1);
+			child = pci_add_new_bus(bus, dev, next_busnr);
 			if (!child)
 				goto out;
-			pci_bus_insert_busn_res(child, max+1,
+			pci_bus_insert_busn_res(child, next_busnr,
 						bus->busn_res.end);
 		}
 		max++;
@@ -1234,7 +1278,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			max += i;
 		}
 
-		/* Set subordinate bus number to its real value */
+		/*
+		 * Set subordinate bus number to its real value.
+		 * If fixed subordinate bus number exists from EA
+		 * capability then use it.
+		 */
+		if (fixed_sub)
+			max = fixed_sub;
 		pci_bus_update_busn_res_end(child, max);
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
 	}
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e1e9888..c3d0904 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -372,6 +372,12 @@
 #define PCI_EA_FIRST_ENT_BRIDGE	8	/* First EA Entry for Bridges */
 #define  PCI_EA_ES		0x00000007 /* Entry Size */
 #define  PCI_EA_BEI		0x000000f0 /* BAR Equivalent Indicator */
+
+/* EA fixed Secondary and Subordinate bus numbers for Bridge */
+#define PCI_EA_SEC_BUS_MASK	0xff
+#define PCI_EA_SUB_BUS_MASK	0xff00
+#define PCI_EA_SUB_BUS_SHIFT	8
+
 /* 0-5 map to BARs 0-5 respectively */
 #define   PCI_EA_BEI_BAR0		0
 #define   PCI_EA_BEI_BAR5		5
-- 
1.8.3.1

