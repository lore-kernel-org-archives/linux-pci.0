Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E092C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 21:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01CA2086A
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 21:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9UpPl6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01CA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeKGHTw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeKGHTv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 02:19:51 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707572083D;
        Tue,  6 Nov 2018 21:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541541152;
        bh=vpT1/ROwhYEut9Vg+7lXeVffTQuCJHKjwLeUwR/9PV0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L9UpPl6znyVSkEqw3PmyihLXZqqZ/tjmZR+gqC1Oe3RdNIYXjjlX3ctrcRXDRJfEC
         K4cBLfL7ZJDhNTtButERe1aA8pFAwYS6tZoAZJtR+/kd7x0IU+irItVblIt+H14Dzi
         /an27nvOfNZFEBbVBjuPbeRVJJShZUZc+uFvrftQ=
Subject: [PATCH 1/2] lspci: Decode Multicast Extended Capability
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     linux-pci@vger.kernel.org
Date:   Tue, 06 Nov 2018 15:52:31 -0600
Message-ID: <154154115111.78911.820638647771761075.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <154154102296.78911.760432131801074864.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154154102296.78911.760432131801074864.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Decode the Multicast Extended Capability described in PCIe r4.0, sec
7.9.11.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h        |   18 ++++
 ls-ecaps.c          |   59 ++++++++++++
 tests/cap-multicast |  257 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 tests/cap-multicast

diff --git a/lib/header.h b/lib/header.h
index d785473..b563073 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1095,6 +1095,24 @@
 #define PCI_IOV_MSA_BIR(x)	((x) & 7) /* VF Migration State BIR */
 #define PCI_IOV_MSA_OFFSET(x)	((x) & 0xfffffff8) /* VF Migration State Offset */
 
+/* Multicast */
+#define PCI_MCAST_CAP		0x04	/* Multicast Capability */
+#define  PCI_MCAST_CAP_MAX_GROUP(x) ((x) & 0x3f)
+#define  PCI_MCAST_CAP_WIN_SIZE(x) (((x) >> 8) & 0x3f)
+#define  PCI_MCAST_CAP_ECRC	0x8000	/* ECRC Regeneration Supported */
+#define PCI_MCAST_CTRL		0x06	/* Multicast Control */
+#define  PCI_MCAST_CTRL_NUM_GROUP(x) ((x) & 0x3f)
+#define  PCI_MCAST_CTRL_ENABLE	0x8000	/* MC Enabled */
+#define PCI_MCAST_BAR		0x08	/* Base Address */
+#define  PCI_MCAST_BAR_INDEX_POS(x)	((u32) ((x) & 0x3f))
+#define  PCI_MCAST_BAR_MASK	(~0xfffUL)
+#define PCI_MCAST_RCV		0x10	/* Receive */
+#define PCI_MCAST_BLOCK		0x18	/* Block All */
+#define PCI_MCAST_BLOCK_UNTRANS	0x20	/* Block Untranslated */
+#define PCI_MCAST_OVL_BAR	0x28	/* Overlay BAR */
+#define  PCI_MCAST_OVL_SIZE(x)	((u32) ((x) & 0x3f))
+#define  PCI_MCAST_OVL_MASK	(~0x3fUL)
+
 /* Page Request Interface */
 #define PCI_PRI_CTRL		0x04	/* PRI Control Register */
 #define  PCI_PRI_CTRL_ENABLE	0x01	/* Enable */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 5505948..3deb535 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -396,6 +396,62 @@ cap_sriov(struct device *d, int where)
 	PCI_IOV_MSA_BIR(l));
 }
 
+static void
+cap_multicast(struct device *d, int where, int type)
+{
+  u16 w;
+  u32 l;
+  u64 bar, rcv, block;
+
+  printf("Multicast\n");
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + PCI_MCAST_CAP, 0x30))
+    return;
+
+  w = get_conf_word(d, where + PCI_MCAST_CAP);
+  printf("\t\tMcastCap: MaxGroups %d", PCI_MCAST_CAP_MAX_GROUP(w) + 1);
+  if (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_ROOT_INT_EP)
+    printf(", WindowSz %d (%d bytes)",
+      PCI_MCAST_CAP_WIN_SIZE(w), 1 << PCI_MCAST_CAP_WIN_SIZE(w));
+  if (type == PCI_EXP_TYPE_ROOT_PORT ||
+      type == PCI_EXP_TYPE_UPSTREAM || type == PCI_EXP_TYPE_DOWNSTREAM)
+    printf(", ECRCRegen%c\n", FLAG(w, PCI_MCAST_CAP_ECRC));
+  w = get_conf_word(d, where + PCI_MCAST_CTRL);
+  printf("\t\tMcastCtl: NumGroups %d, Enable%c\n",
+    PCI_MCAST_CTRL_NUM_GROUP(w) + 1, FLAG(w, PCI_MCAST_CTRL_ENABLE));
+  bar = get_conf_long(d, where + PCI_MCAST_BAR);
+  l = get_conf_long(d, where + PCI_MCAST_BAR + 4);
+  bar |= (u64) l << 32;
+  printf("\t\tMcastBAR: IndexPos %d, BaseAddr %016" PCI_U64_FMT_X "\n",
+    PCI_MCAST_BAR_INDEX_POS(bar), bar & PCI_MCAST_BAR_MASK);
+  rcv = get_conf_long(d, where + PCI_MCAST_RCV);
+  l = get_conf_long(d, where + PCI_MCAST_RCV + 4);
+  rcv |= (u64) l << 32;
+  printf("\t\tMcastReceiveVec:      %016" PCI_U64_FMT_X "\n", rcv);
+  block = get_conf_long(d, where + PCI_MCAST_BLOCK);
+  l = get_conf_long(d, where + PCI_MCAST_BLOCK + 4);
+  block |= (u64) l << 32;
+  printf("\t\tMcastBlockAllVec:     %016" PCI_U64_FMT_X "\n", block);
+  block = get_conf_long(d, where + PCI_MCAST_BLOCK_UNTRANS);
+  l = get_conf_long(d, where + PCI_MCAST_BLOCK_UNTRANS + 4);
+  block |= (u64) l << 32;
+  printf("\t\tMcastBlockUntransVec: %016" PCI_U64_FMT_X "\n", block);
+
+  if (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_ROOT_INT_EP)
+    return;
+  bar = get_conf_long(d, where + PCI_MCAST_OVL_BAR);
+  l = get_conf_long(d, where + PCI_MCAST_OVL_BAR + 4);
+  bar |= (u64) l << 32;
+  printf("\t\tMcastOverlayBAR: OverlaySize %d ", PCI_MCAST_OVL_SIZE(bar));
+  if (PCI_MCAST_OVL_SIZE(bar) >= 6)
+    printf("(%d bytes)", 1 << PCI_MCAST_OVL_SIZE(bar));
+  else
+    printf("(disabled)");
+  printf(", BaseAddr %016" PCI_U64_FMT_X "\n", bar & PCI_MCAST_OVL_MASK);
+}
+
 static void
 cap_vc(struct device *d, int where)
 {
@@ -789,6 +845,9 @@ show_ext_caps(struct device *d, int type)
 	  case PCI_EXT_CAP_ID_MRIOV:
 	    printf("Multi-Root I/O Virtualization <?>\n");
 	    break;
+	  case PCI_EXT_CAP_ID_MCAST:
+	    cap_multicast(d, where, type);
+	    break;
 	  case PCI_EXT_CAP_ID_PRI:
 	    cap_pri(d, where);
 	    break;
diff --git a/tests/cap-multicast b/tests/cap-multicast
new file mode 100644
index 0000000..3fd2c31
--- /dev/null
+++ b/tests/cap-multicast
@@ -0,0 +1,257 @@
+07:00.0 PCI bridge: PLX Technology, Inc. Device 8796 (rev ab)
+00: b5 10 96 87 07 01 10 48 ab 00 04 06 08 00 01 00
+10: 00 00 10 c7 00 00 00 00 07 08 13 00 f1 01 00 00
+20: 00 c2 00 c7 01 00 f1 01 e0 2f 00 00 fc 2f 00 00
+30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 12 00
+40: 01 48 03 c8 08 00 00 00 05 68 86 01 00 00 00 00
+50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+60: 00 00 00 00 00 00 00 00 10 a4 52 00 04 80 00 00
+70: 20 08 0b 00 03 69 41 00 00 00 03 01 00 00 00 00
+80: 00 00 00 00 00 00 00 00 00 00 00 00 40 08 04 00
+90: 00 00 00 00 0e 01 00 00 03 00 1e 00 00 00 00 00
+a0: 00 00 00 00 0d 00 00 00 e0 1a 31 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+100: 03 00 41 fb 00 0e df b5 10 00 87 ab 19 00 81 14
+110: 01 00 00 00 00 00 00 00 55 55 55 55 55 55 55 55
+120: 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
+130: 55 55 55 55 55 55 55 55 04 00 c1 10 00 00 00 00
+140: 00 00 00 00 01 00 00 00 02 00 01 e0 00 0c 00 00
+150: 00 00 00 00 00 00 00 00 04 00 00 03 01 00 04 80
+160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+170: 00 00 00 00 00 00 00 00 00 04 08 0c 10 14 1f 1f
+180: 00 1f 08 0c 1f 1f 1f 1f 00 1f 08 0c 1f 1f 1f 1f
+190: 00 1f 08 0c 1f 1f 1f 1f 00 1f 08 0c 1f 1f 1f 1f
+1a0: 00 1f 08 0c 1f 1f 1f 1f 00 1f 08 0c 1f 1f 1f 1f
+1b0: 00 1f 08 0c 1f 1f 1f 1f 00 00 00 00 00 00 00 00
+1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1d0: 00 00 00 00 00 00 00 00 00 00 00 00 07 00 00 00
+1e0: 02 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b00: 18 00 01 b7 00 00 00 00 00 00 00 00 00 00 00 00
+b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b70: 0b 00 01 00 01 00 00 01 b5 10 96 87 ab 00 00 00
+b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e00: 12 00 01 b0 3f 80 3f 80 00 00 00 00 00 00 00 00
+e10: ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00
+e20: ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00
+e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f20: 11 11 11 00 00 00 00 00 00 00 00 00 00 00 00 00
+f30: 40 00 a0 0a 00 00 00 00 03 00 06 00 00 00 00 00
+f40: 00 00 00 00 00 00 00 00 00 00 00 00 11 11 11 00
+f50: 0e 00 00 00 0e 00 0e 00 00 00 00 00 ff 1f 00 00
+f60: 02 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00
+f70: 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
+f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fa0: 00 00 00 00 00 00 00 00 4c 00 00 00 00 00 00 00
+fb0: 00 00 00 00 01 00 81 13 00 00 00 00 00 00 40 00
+fc0: 30 20 46 00 00 00 00 00 00 e0 00 00 bf 00 00 00
+fd0: 01 00 00 60 0f 02 00 00 f8 2f 00 00 00 00 00 00
+fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

