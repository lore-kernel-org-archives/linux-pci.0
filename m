Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:65326 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884AbaHEQME (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:04 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so1616421wib.8
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:03 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 08/22] Added (untested) workaround to ia64 architecture to accomodate new irq init code. Unfortunately adding runtime irq assignment will not work but avoided breaking the existing code.
Date: Tue,  5 Aug 2014 17:11:09 +0100
Message-Id: <1407255083-9356-9-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/ia64/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 291a582..398d5d4 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -483,6 +483,9 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
 	struct pci_controller *controller = bridge->bus->sysdata;
 
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = NULL;
+
 	ACPI_COMPANION_SET(&bridge->dev, controller->companion);
 	return 0;
 }
-- 
2.0.4

