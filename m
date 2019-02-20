Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9856C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84CD21738
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz7KGAxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfBTBVI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:21:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33200 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBTBVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 20:21:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so37574757otl.0;
        Tue, 19 Feb 2019 17:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icSMYWZ1TCBph2yK3xUDD7lbSKqUZW49ipCB4B2lztg=;
        b=Dz7KGAxdD8LlyCChAE9NNDESeqrpxN+Hwwj/rCZ4/qp5y1IvN1ZRitfyT86HSJhCH8
         +/PmeI0tmxcz0AGFyEUYD1FinVcQTmN30VhY7eAsLNolBbfkfP9700WFltQVmTGNRDqt
         QOVsrflazXIpj4DhWQngSigF1bXJERIHOZJ+mRlfAWqIEt1LfTOEFPdkfpEuCc5GQ89U
         JRDTbP6mLrA7FSpgEwqfpFZIuolL6JwoikurvmvhLm11rKDdvBxz2sNUVpPBO8uPoYBx
         YmfzdizOTvCHu8LkX8y20P7GNCVoXr7U19TbjNf4NhP+SY7bzqdrD+Gp6sAMw4lpF3VH
         t95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icSMYWZ1TCBph2yK3xUDD7lbSKqUZW49ipCB4B2lztg=;
        b=VAJcHRTlaJcJy9RpA77p2KqxH5/FmbnmfRkDJm8P6A+vQhEkVfoqY6DwERhpooFvlG
         uHtw80T98DP6di/MVGgzPfm8m3N2UBssOND/YVNiIiBW+OF1gk2GvF7UBxbXaIXYuu9F
         XJy7gQzEDNiXio9/3z0qk5Paa9QOVaPJylATC7I39Ajk/wYRkVnj+R8F6P6DohDGqnXb
         hkdlromoztKIAh4pOue7WHSwxi0Kb9HI8Oec4B2vDUfMIYhrKmUHV905mT6lOYAac0G2
         yo8VjB7lohad8vShvFz2vn6cpLLGncRT39PCb9K4dy1MxVXiF0HxPMzkLirP5tdJksjh
         Umfg==
X-Gm-Message-State: AHQUAubGZ4/8OureyIrPULpsXE5MJJglE112NLEUoNc/XBpPUPuDIYmN
        zusUKbCGDMj+7A3sLAsFMg4=
X-Google-Smtp-Source: AHgI3IY6M895F7dzLE9D3NjCgb8tt1X0wIv3/YKD52ruvWoSR9Qfc0XEeVBYszqOvpD78wbaA8yKaQ==
X-Received: by 2002:aca:4205:: with SMTP id p5mr4510977oia.15.1550625666880;
        Tue, 19 Feb 2019 17:21:06 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id d67sm8000424oig.36.2019.02.19.17.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:21:06 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, linux-pci@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 4/4] PCI: hotplug: Add quirk For Dell nvme pcie switches
Date:   Tue, 19 Feb 2019 19:20:30 -0600
Message-Id: <20190220012031.10741-5-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190220012031.10741-1-mr.nuke.me@gmail.com>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
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
 drivers/pci/hotplug/pciehp_hpc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 9bcadb5d3561..853fb4ab53de 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -952,3 +952,23 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0400,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+
+
+static void fixup_dell_nvme_backplane_switches(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	if (pdev->subsystem_vendor != PCI_VENDOR_ID_DELL
+		|| pdev->subsystem_device != 0x1fc7)
+		return;
+
+	pdev->no_in_band_presence = 1;
+}
+
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_PLX, 0x9733,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      fixup_dell_nvme_backplane_switches);
-- 
2.19.2

