Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33241 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbbIOEKj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 00:10:39 -0400
Received: by pacex6 with SMTP id ex6so163833989pac.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2015 21:10:39 -0700 (PDT)
From: Simon Horman <simon.horman@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Simon Horman <simon.horman@netronome.com>
Subject: [PATCH/RFC 3/3] PCI: Support Netronome NFP6000 family quirks
Date: Tue, 15 Sep 2015 13:10:24 +0900
Message-Id: <1442290224-21729-4-git-send-email-simon.horman@netronome.com>
In-Reply-To: <1442290224-21729-1-git-send-email-simon.horman@netronome.com>
References: <1442290224-21729-1-git-send-email-simon.horman@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Jason S. McMullan" <jason.mcmullan@netronome.com>

The NFP6000 has an errata where reading/writing to PCI config
space addresses above 0x600 can cause the NFP to generate PCIe
completion timeouts.

This patch addresses this issue, by limiting the NFP6000's config
space size to 0x600 bytes.

Signed-off-by: Jason S. McMullan <jason.mcmullan@netronome.com>
[simon: edited changelog]
Signed-off-by: Simon Horman <simon.horman@netronome.com>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de5f610e0810..adcdee3e562f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -287,6 +287,17 @@ static void quirk_citrine(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CITRINE,	quirk_citrine);
 
+/*
+ *  This chip can cause bus lockups if config addresses above 0x600
+ *  are read or written to.
+ */
+static void quirk_nfp6000(struct pci_dev *dev)
+{
+	dev->cfg_size = 0x600;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP6000,	quirk_nfp6000);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP6000_VF,	quirk_nfp6000);
+
 /*  On IBM Crocodile ipr SAS adapters, expand BAR to system page size */
 static void quirk_extend_bar_to_page(struct pci_dev *dev)
 {
-- 
2.1.4

