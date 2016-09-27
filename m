Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58177 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932747AbcI0UMo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Sep 2016 16:12:44 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Lukas Wunner <lukas@wunner.de>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCHv3 1/5] mips/pci: Reduce stack frame usage
Date: Tue, 27 Sep 2016 16:23:31 -0400
Message-Id: <1475007815-28354-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The struct pci_dev is too large to allocate on the stack. This patch
removes the fake pci device in early config access and instead uses the
pci bus to get the same functionality.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Got the 'ok' (link below), but I don't see this is merged yet. That's
okay, since I need to include it in this series to avoid 0'day build
failure. If this is ok with everyone, perhaps this can go through 'pci'.

  https://www.linux-mips.org/archives/linux-mips/2016-09/msg00255.html

 arch/mips/txx9/generic/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 1f6bc9a..285d84e 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -29,12 +29,8 @@ static int __init
 early_read_config_word(struct pci_controller *hose,
 		       int top_bus, int bus, int devfn, int offset, u16 *value)
 {
-	struct pci_dev fake_dev;
 	struct pci_bus fake_bus;
 
-	fake_dev.bus = &fake_bus;
-	fake_dev.sysdata = hose;
-	fake_dev.devfn = devfn;
 	fake_bus.number = bus;
 	fake_bus.sysdata = hose;
 	fake_bus.ops = hose->pci_ops;
@@ -45,7 +41,7 @@ early_read_config_word(struct pci_controller *hose,
 	else
 		fake_bus.parent = NULL;
 
-	return pci_read_config_word(&fake_dev, offset, value);
+	return pci_bus_read_config_word(&fake_bus, devfn, offset, value);
 }
 
 int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
-- 
2.7.2

