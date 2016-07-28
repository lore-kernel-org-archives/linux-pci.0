Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo02.seg.att.com ([209.65.160.78]:25437 "EHLO
	nbfkord-smmo02.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161010AbcG1Rbc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 13:31:32 -0400
From: Edward Cree <ecree@solarflare.com>
Subject: [PATCH] pci: quirks: Add ACS quirk to Solarflare SFC9220
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <linux-net-drivers@solarflare.com>
Message-ID: <df310014-18d6-0f65-e902-107b04577090@solarflare.com>
Date: Thu, 28 Jul 2016 18:13:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Device does not perform peer-to-peer between functions.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b69321c..37ff015 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4095,6 +4095,7 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_AMD, 0x7809, pci_quirk_amd_sb_acs },
 	{ PCI_VENDOR_ID_SOLARFLARE, 0x0903, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_SOLARFLARE, 0x0923, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_SOLARFLARE, 0x0A03, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x10C6, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x10DB, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x10DD, pci_quirk_mf_endpoint_acs },
