Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F803C43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 00:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE81620645
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 00:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLrfencs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE81620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeK2LMD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:12:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34809 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeK2LMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 06:12:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so136119otk.1;
        Wed, 28 Nov 2018 16:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xICuYGJFIVC010WL+cgzN1jRnwq76q1669QvCJY3WAw=;
        b=VLrfencsB/0m1qawUYLPan5i5jpLdYzA3G4EQjwzSHV3npQogeUN35aKW/KNPECfpp
         tegQZ4tWC0paFK9j7599M0PMl5YkfQel2Y8sAafzetwmkOvtS5QEhXzPi9snJoGVHcc3
         Gnq8kaHbSULD68Vrf81vzAakLGH81gteyh4+aEgO2YrEGK4ZZk69VIK8osYhJKhOIiW8
         Oa5KZIIwmVpxtbEq2jsEkg7p3WdSZYSuT/574QKz5xbkp1MeYr8RYM0fKJa+vJN47b4W
         rewAR2yIfhB5VW+Lfb4sBDFCRGvOYLUPNDiKAtbu0G58ovs9ioSdQimYrdPrPqDltCkJ
         2KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xICuYGJFIVC010WL+cgzN1jRnwq76q1669QvCJY3WAw=;
        b=oKlhItcnM0OX0CRR12PPxJAKyDfiyHSw0XCgWu6hXokfPCCJu2uTuMj6huKmxHNc9g
         JhAXV4Ni5LOAwsSjN1/ZWiniYXke0vxlihj5GOjGsyaRqmEG8nSjLF2OlabwzijuJ9sL
         dpLAqNxVUVXMI7RWNhgxdDh8T7A0ZCDPvZR8YAgknx/59TGUlM7S/ey13LwmbxukFsuh
         DZOc4KX9hQt8UbHaIy7hfGSb0G2NVi6V0YqkRmsk5qzVcrtcEgFKkj5vvapr3z0HD4Mm
         ry8+nXlnr1kxaFHpLorq3lRtUqO+LWGlqXGWNatbxDLgecW/KFCFOc+jLTYhkEYheCi7
         a86Q==
X-Gm-Message-State: AA+aEWaUX7PZAgGO4Pf7HDi0aSsCKP/y95MF9vmCeFZp6ZaKkIxIcxxf
        fCrWR5q4CbcDxD8NbXTiivzSgjIicl4=
X-Google-Smtp-Source: AFSGD/VlHk3sJEHb2a4+pONmk57NpjPSvrC9WEPzmpYZl98Zq9iT9XvHkYPgTozjyThCRLIH+VXYPg==
X-Received: by 2002:a9d:2015:: with SMTP id n21mr19609221ota.289.1543450118454;
        Wed, 28 Nov 2018 16:08:38 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id r17sm68400otn.0.2018.11.28.16.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:08:37 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: pciehp: Report degraded links via link bandwidth notification
Date:   Wed, 28 Nov 2018 18:08:24 -0600
Message-Id: <20181129000829.14751-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A warning is generated when a PCIe device is probed with a degraded
link, but there was no similar mechanism to warn when the link becomes
degraded after probing. The Link Bandwidth Notification provides this
mechanism.

Use the link bandwidth notification interrupt to detect bandwidth
changes, and rescan the bandwidth, looking for the weakest point. This
is the same logic used in probe().

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 35 +++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7dd443aea5a5..834672000b59 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -515,7 +515,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	struct device *parent = pdev->dev.parent;
-	u16 status, events;
+	struct pci_dev *endpoint;
+	u16 status, events, link_status;
 
 	/*
 	 * Interrupts only occur in D3hot or shallower and only if enabled
@@ -525,6 +526,17 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
 		return IRQ_NONE;
 
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);
+
+	if (link_status & PCI_EXP_LNKSTA_LBMS) {
+		if (pdev->subordinate && pdev->subordinate->self)
+			endpoint = pdev->subordinate->self;
+		else
+			endpoint = pdev;
+		__pcie_print_link_status(endpoint, false);
+		pcie_capability_write_word(pdev, PCI_EXP_LNKSTA, link_status);
+	}
+
 	/*
 	 * Keep the port accessible by holding a runtime PM ref on its parent.
 	 * Defer resume of the parent to the IRQ thread if it's suspended.
@@ -677,6 +689,24 @@ static int pciehp_poll(void *data)
 	return 0;
 }
 
+static bool pcie_link_bandwidth_notification_supported(struct controller *ctrl)
+{
+	int ret;
+	u32 cap;
+
+	ret = pcie_capability_read_dword(ctrl_dev(ctrl), PCI_EXP_LNKCAP, &cap);
+	return (ret == PCIBIOS_SUCCESSFUL) && (cap & PCI_EXP_LNKCAP_LBNC);
+}
+
+static void pcie_enable_link_bandwidth_notification(struct controller *ctrl)
+{
+	u16 lnk_ctl;
+
+	pcie_capability_read_word(ctrl_dev(ctrl), PCI_EXP_LNKCTL, &lnk_ctl);
+	lnk_ctl |= PCI_EXP_LNKCTL_LBMIE;
+	pcie_capability_write_word(ctrl_dev(ctrl), PCI_EXP_LNKCTL, lnk_ctl);
+}
+
 static void pcie_enable_notification(struct controller *ctrl)
 {
 	u16 cmd, mask;
@@ -713,6 +743,9 @@ static void pcie_enable_notification(struct controller *ctrl)
 	pcie_write_cmd_nowait(ctrl, cmd, mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
+
+	if (pcie_link_bandwidth_notification_supported(ctrl))
+		pcie_enable_link_bandwidth_notification(ctrl);
 }
 
 static void pcie_disable_notification(struct controller *ctrl)
-- 
2.17.1

