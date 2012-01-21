Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:22294 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211Ab2AUKJR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2012 05:09:17 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 17/21] PCI: Disable cardbus bridge MEM1 pref CTL
Date: Sat, 21 Jan 2012 02:08:33 -0800
Message-Id: <1327140517-14811-18-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327140517-14811-1-git-send-email-yinghai@kernel.org>
References: <1327140517-14811-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some BIOS enable both pref for MEM0 and MEM1.

but we assume MEM1 is non-pref...

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 090217a..d5897c3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -914,6 +914,14 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	if (realloc_head)
 		add_to_list(realloc_head, bridge, b_res+1, pci_cardbus_io_size, 0 /* dont care */);
 
+	/* MEM1 must not be pref mmio */
+	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
+	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM1) {
+		ctrl &= ~PCI_CB_BRIDGE_CTL_PREFETCH_MEM1;
+		pci_write_config_word(bridge, PCI_CB_BRIDGE_CONTROL, ctrl);
+		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
+	}
+
 	/*
 	 * Check whether prefetchable memory is supported
 	 * by this bridge.
-- 
1.7.7

