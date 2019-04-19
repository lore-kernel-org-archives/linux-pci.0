Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6A8C282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BD920449
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKL89JIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfDSSbs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:31:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42887 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfDSSbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:31:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id w139so4541803oie.9;
        Fri, 19 Apr 2019 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3d5eGGJw4R7UGVxkj3FtbNAvPKDTO3ueR90+T5iRs0=;
        b=rKL89JIglaL3N3+3WtwQBikjppTKoCm6pWZF9gcdn8r/7HI8bh2nxRjgTUsbCP465G
         ULsIXGPj4suAbAt7YGp5aSF1U2GAj9gyJrV4gSreRD/Nk8CXHwgb7uA0e9qBtG9X9u7l
         h4Qm/tdz961Gi/QiOqkoha/y7eRYXBZA7dMQGjEow/znK4REaZ5YJdkxhRcVR6Gk/5pD
         VcmPllvYoJWSVeq/0RDrkRa1xBy2R6dnwLwoqXWKHsUc3SurGJZqWcGa2Ghhj+UUr/Jx
         Np+mLq3Kf7QZbNRHVgBIUspN2d45OP3FiPEymaa3RGmUHbuy4cKxtVieHxpNhWBxswKs
         9siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3d5eGGJw4R7UGVxkj3FtbNAvPKDTO3ueR90+T5iRs0=;
        b=UuUXVnPwzBNMzs3LjKuwSE6Firlue0IaeWAcKLAileSKMDSTcr99WFAaWlu3X4aHQv
         GJZ9RPuVmcNQ+5sYK1YyAvvv3nYY9Zsrwf7cVtRpwVxnFwDX1drmrB6wm8MMZYvATIxx
         uRchRJ4ZkAB2PmCdcaRw2OyDW12Qy+6HeRBnI9IaLpwdppNOh1+GdMt8yWmSyKkFcyFU
         M+ayIqAnSahxRrYm2/SQuMU88EvP7BdlKQWLLYWYkYCfCCcXypVElIKlsiZ0ZGqVJJx0
         utH04S0B/aCXaSkowkYJkNX88DWyjbAbNdBLt4JUm667RViezjFjW3r+E3qTdsFf9KD0
         1pfg==
X-Gm-Message-State: APjAAAUYr5TG91Yr9JDdqxn/uY8PXWX/3COFmGI5XInTvbglrMGhNtvX
        2UH2Gpju6Npv5MPaM0JTT16GJn3Yv5M=
X-Google-Smtp-Source: APXvYqxcZRdGYykEJapShXtif+/DvI+vwSpOeJfLFlYzqtajt3JHmKM8cVn1YTqHX4A07b7HAa7ZCA==
X-Received: by 2002:aca:5904:: with SMTP id n4mr2086084oib.122.1555687412714;
        Fri, 19 Apr 2019 08:23:32 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id y9sm1981723otk.20.2019.04.19.08.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 08:23:32 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] PCI: hotplug: Add quirk For Dell nvme pcie switches
Date:   Fri, 19 Apr 2019 10:22:26 -0500
Message-Id: <20190419152238.12251-5-mr.nuke.me@gmail.com>
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

These switches are used to fornicate the motherboard's x16 PCIe ports
into four x4 ports for NVMe drives. In conjunction with the storage
backplane, the PDS bit reports only the out-of-band presence. The fact
that inband presence is disabled is not reported in the slot
capabilities 2 (SLTCAP2) register.

Because this does not conform to the PCIe spec, add a quirk to let
hotplug code know to expect and handle this.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 21 +++++++++++++++++++++
 include/linux/pci.h              |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6cd2c4fb4edb..681043f59fa5 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -881,6 +881,9 @@ struct controller *pcie_init(struct pcie_device *dev)
 	if (pdev->is_thunderbolt)
 		slot_cap |= PCI_EXP_SLTCAP_NCCS;
 
+	if (pdev->no_in_band_presence)
+		ctrl->inband_presence_disabled = 1;
+
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
 	mutex_init(&ctrl->state_lock);
@@ -964,3 +967,21 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+
+static void fixup_dell_nvme_backplane_switches(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	if (pdev->subsystem_vendor != PCI_VENDOR_ID_DELL ||
+	    pdev->subsystem_device != 0x1fc7)
+		return;
+
+	pdev->no_in_band_presence = 1;
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_PLX, 0x9733,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      fixup_dell_nvme_backplane_switches);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 77448215ef5b..9594a313064d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -416,6 +416,7 @@ struct pci_dev {
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
 	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
+	unsigned int	no_in_band_presence:1;	/* Device does not report in-band presence */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
-- 
2.20.1

