Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A82C282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55A5222AF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxLxSIUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfDSSSL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:18:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42107 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfDSSSK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:18:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id w139so4520017oie.9;
        Fri, 19 Apr 2019 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vd6QC5/kh1+k2njWGbBmVOB+Wb//gDgVPntsiNP/wHU=;
        b=uxLxSIUPcUT7maJmNU2OlubOxwiXC5vvjb9k7HjpgLBBDVNMC/gk/AM7EdHkcwKYP0
         5qDRvrxhT9+hniMPoHB0e4eZc5dR4WgqrlQ9cHpYy3kmEWuMFX96EBYg1cxFbw/Vnk57
         YOVnEHlPxpVIM675XegQGNqqEHYywW4wCQa3oFieuyci43T+4IFzgQ5Kgo2LVqmlcQNU
         hZ7610Jfx9G9q9sQ8bjMSSKr/r3juCsv97mkpwsAFln/hmdlgV2MW04t7b9LtbALPZ4h
         z/nniWYxSUhgwNKiauMjPaUzXjmHrj8wRjLJhUBLX3K0W6v5vNg73T4d7ICsZ25zAm5t
         E2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vd6QC5/kh1+k2njWGbBmVOB+Wb//gDgVPntsiNP/wHU=;
        b=HfHRDo4KnNzZKQTDkKW31X1EkPmQMmY5ld+g9LFxb3qa409XpxE7hAYi0p0fPOCpLx
         2/UguFyBF6xfBsQ0TZdHfKCSG0DuDBiN/tAdnH7uMo+uVrtkO5lTn/u2Lbefp8haoukI
         JHlY0iWaj1HP5A5KxicVSQFL9CIDKwHDs+3I0Om8xr68Lh/IzybEj0HxtK29tVmLMPXW
         HNQ0hLJP1DMdhd0CFxkOzr2dgkv4E+WQo6y/AwQ84nSUhl0ofzn7JyOh0y5pABlv9kNn
         RXE3flCtP9LL5zz6XlN7oh/q/QhiP0MV5d3xIHDeE/cMeVLVDDXPudSuLWvjaL9kCEG+
         IBlA==
X-Gm-Message-State: APjAAAXsOU3ogixbQlLc0nXuKQAQ8+gf0p8MG+cM+al0iJamCuwzB7yj
        rB3PPGDOq2woCMEpmAKMlDdIvNWYn9M=
X-Google-Smtp-Source: APXvYqxTs9S6QFx3ORJhQTczfnDLFv3JUp9cYjVp9VXMwTBYVCvlsOuNE8ewMSpDQBEMfbtIGmsk3g==
X-Received: by 2002:aca:d595:: with SMTP id m143mr2139444oig.31.1555687380781;
        Fri, 19 Apr 2019 08:23:00 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id y9sm1981723otk.20.2019.04.19.08.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 08:23:00 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] PCI: hotplug: Add support for disabling in-band presence
Date:   Fri, 19 Apr 2019 10:22:23 -0500
Message-Id: <20190419152238.12251-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419152238.12251-1-mr.nuke.me@gmail.com>
References: <20190419000148.GI126710@google.com>
 <20190419152238.12251-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The presence detect state (PDS) is normally a logical or of in-band
and out-of-band presence. In PCIe 4.0, there is the option to disable
in-band presence so that the PDS bit always reflects the state of the
out-of-band presence.

The recommendation of the PCIe spec is to disable in-band presence
whenever supported.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/hotplug/pciehp.h     | 1 +
 drivers/pci/hotplug/pciehp_hpc.c | 9 ++++++++-
 include/uapi/linux/pci_regs.h    | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 506e1d923a1f..6f729ce4a7b9 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -98,6 +98,7 @@ struct controller {
 	struct pcie_device *pcie;
 
 	u32 slot_cap;				/* capabilities and quirks */
+	unsigned int inband_presence_disabled:1;
 
 	u16 slot_ctrl;				/* control register access */
 	struct mutex ctrl_lock;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6a2365cd794e..078d78a7437d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -837,7 +837,7 @@ static inline void dbg_ctrl(struct controller *ctrl)
 struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
-	u32 slot_cap, link_cap;
+	u32 slot_cap, slot_cap2, link_cap;
 	u8 poweron;
 	struct pci_dev *pdev = dev->port;
 	struct pci_bus *subordinate = pdev->subordinate;
@@ -895,6 +895,13 @@ struct controller *pcie_init(struct pcie_device *dev)
 		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
 		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
 
+	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP2, &slot_cap2);
+	if (slot_cap2 & PCI_EXP_SLTCAP2_IBPD) {
+		pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_IBPD_DISABLE,
+				      PCI_EXP_SLTCTL_IBPD_DISABLE);
+		ctrl->inband_presence_disabled = 1;
+	}
+
 	/*
 	 * If empty slot's power status is on, turn power off.  The IRQ isn't
 	 * requested yet, so avoid triggering a notification with this command.
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 5c98133f2c94..c7afdc4c098c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -597,6 +597,7 @@
 #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
 #define  PCI_EXP_SLTCTL_EIC	0x0800	/* Electromechanical Interlock Control */
 #define  PCI_EXP_SLTCTL_DLLSCE	0x1000	/* Data Link Layer State Changed Enable */
+#define  PCI_EXP_SLTCTL_IBPD_DISABLE	0x4000 /* In-band PD disable */
 #define PCI_EXP_SLTSTA		26	/* Slot Status */
 #define  PCI_EXP_SLTSTA_ABP	0x0001	/* Attention Button Pressed */
 #define  PCI_EXP_SLTSTA_PFD	0x0002	/* Power Fault Detected */
@@ -667,6 +668,7 @@
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
+#define  PCI_EXP_SLTCAP2_IBPD	0x0001	/* In-band PD Disable Supported */
 #define PCI_EXP_SLTCTL2		56	/* Slot Control 2 */
 #define PCI_EXP_SLTSTA2		58	/* Slot Status 2 */
 
-- 
2.20.1

