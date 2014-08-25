Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:46164 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933370AbaHYV1N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 17:27:13 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so13925391wes.37
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2014 14:27:12 -0700 (PDT)
From: Mathias Krause <minipli@googlemail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 4/5] x86/PCI: Constify pci_mmcfg_probes[] array
Date: Mon, 25 Aug 2014 23:26:38 +0200
Message-Id: <1409001999-23161-5-git-send-email-minipli@googlemail.com>
In-Reply-To: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
References: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_mmcfg_probes[] array is only ever read, therefore make it const.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/x86/pci/mmconfig-shared.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 63fc0d4d58..326198a443 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -306,7 +306,7 @@ struct pci_mmcfg_hostbridge_probe {
 	const char *(*probe)(void);
 };
 
-static struct pci_mmcfg_hostbridge_probe pci_mmcfg_probes[] __initdata = {
+static const struct pci_mmcfg_hostbridge_probe pci_mmcfg_probes[] __initconst = {
 	{ 0, PCI_DEVFN(0, 0), PCI_VENDOR_ID_INTEL,
 	  PCI_DEVICE_ID_INTEL_E7520_MCH, pci_mmcfg_e7520 },
 	{ 0, PCI_DEVFN(0, 0), PCI_VENDOR_ID_INTEL,
-- 
1.7.10.4

