Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34914 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdGRAp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 20:45:57 -0400
Received: by mail-pf0-f174.google.com with SMTP id e199so2848092pfh.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2017 17:45:57 -0700 (PDT)
From: Feng Kan <fkan@apm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, alex.williamson@redhat.com
Cc: Feng Kan <fkan@apm.com>
Subject: [PATCH] pci: quirk: Apply APM ACS quirk to XGene devices
Date: Mon, 17 Jul 2017 17:45:52 -0700
Message-Id: <1500338752-30576-1-git-send-email-fkan@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The APM X-Gene PCIe root port does not support ACS at this point.
Since the root does not allow peer to peer transactions, mask out
ACS capability flag bits.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 085fb78..951064d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4368,6 +4368,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
 	/* Cavium ThunderX */
 	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
+	/* APM XGene */
+	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_mf_endpoint_acs },
 	{ 0 }
 };
 
-- 
1.8.3.1
