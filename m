Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C4C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A4921773
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vX4S0FZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfBTBUw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:20:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33156 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBTBUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 20:20:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so37573890otl.0;
        Tue, 19 Feb 2019 17:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0csvRJO9q2/FaX/o0eEuWXuIPQ1fh/fIC0tbNVmVNFY=;
        b=vX4S0FZEiZ6zhRlOjEZNXfZ7KpkNT2TAXtdAYVwhS5CLiFK0gDnMguL6fT6pkt+EeW
         +VqkzSm1taxY8ev+qPvjrFH6yf6xSnRYjrBwpvif3wz+GTHqyfA99hD1AQAri6vTqdEX
         AqEYUaaSgdTk9rtbLz4kgIIULSEBrrKmwZEYP7b6nBxsA72DtW26qArpLeLgoHlr6qIO
         syU/uaYmXEIpH2XAuJ946sE4e8yZsl6c/GrvF4wz/Ka1OD59qlRLh75n+qyFX9r0X6vF
         yII5QXryk3F2xREfz2136R34wuR4Ko7/OuYNNExMMCO0qTjB2Z3vbEOl99RPO6crsvVF
         Ohsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0csvRJO9q2/FaX/o0eEuWXuIPQ1fh/fIC0tbNVmVNFY=;
        b=RzOQgIDNSdeTTctD0VUVbr51PJAT3IAC2nBG8WPCwJ8Mm27mAxgfnZloz9JEoYAjb5
         9H9CRB7PrOab+tsf/da6b8Ll6/EeikfexVuIrs1pcDUoYPWBK/ZuWG1FQ/Wy5dp79fbE
         56F5JRG7lETcdmQ7NKsBQHOQLEtm70BXlEzKDULM8W4hX27S1UVgoZs59HoZzeX3WCmc
         bJXUbQmYMz+TKxTkiekYmV6cl+LMXdg0PRXYIUgoK2+lCMP+IpPirJnGoFhIovdy9eEc
         7rAJD4zaRHqs69VNw8EsnmkAG80g6wzQsAhHllMsKKKlZsFtSDIPLjxzeIvcRu/nfo9u
         odlA==
X-Gm-Message-State: AHQUAuYOkiFRQXHDOYD7R/xrXstVZAkN6uSLnRkAVup4gvsqCEnx6E2q
        Td/B6HjMnUVbpqxNH7X42W0=
X-Google-Smtp-Source: AHgI3IZU08WTMWIwwZlfeWAm3wMV40RmxOr3ER9crN5MJvmKZ+s34D9tS5Vz86uJJ3Dy2lOYqodjLg==
X-Received: by 2002:aca:4d3:: with SMTP id 202mr4217306oie.31.1550625650495;
        Tue, 19 Feb 2019 17:20:50 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id d67sm8000424oig.36.2019.02.19.17.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:20:50 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, linux-pci@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 1/4] PCI: hotplug: Add support for disabling in-band presence
Date:   Tue, 19 Feb 2019 19:20:27 -0600
Message-Id: <20190220012031.10741-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190220012031.10741-1-mr.nuke.me@gmail.com>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
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
 drivers/pci/hotplug/pciehp.h     |  1 +
 drivers/pci/hotplug/pciehp_hpc.c | 12 +++++++++++-
 include/linux/pci.h              |  1 +
 include/uapi/linux/pci_regs.h    |  2 ++
 4 files changed, 15 insertions(+), 1 deletion(-)

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
index 7dd443aea5a5..f77dc7c38f9a 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -824,7 +824,7 @@ static inline void dbg_ctrl(struct controller *ctrl)
 struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
-	u32 slot_cap, link_cap;
+	u32 slot_cap, slot_cap2, link_cap;
 	u8 poweron;
 	struct pci_dev *pdev = dev->port;
 	struct pci_bus *subordinate = pdev->subordinate;
@@ -846,6 +846,9 @@ struct controller *pcie_init(struct pcie_device *dev)
 	if (pdev->is_thunderbolt)
 		slot_cap |= PCI_EXP_SLTCAP_NCCS;
 
+	if (pdev->no_in_band_presence)
+		ctrl->inband_presence_disabled = 1;
+
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
 	mutex_init(&ctrl->state_lock);
@@ -882,6 +885,13 @@ struct controller *pcie_init(struct pcie_device *dev)
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c2f082..9d08cdbca459 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -413,6 +413,7 @@ struct pci_dev {
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
 	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
+	unsigned int	no_in_band_presence:1;	/* Device does not report in-band presence */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e1e9888c85e6..5423dc476c77 100644
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
2.19.2

