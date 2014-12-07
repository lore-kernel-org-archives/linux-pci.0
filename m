Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:5006 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753349AbaLGT0o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Dec 2014 14:26:44 -0500
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kernel-janitors@vger.kernel.org, linux@rasmusvillemoes.dk,
	joe@perches.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/20] PCI: fix misspelling of current function in string
Date: Sun,  7 Dec 2014 20:20:45 +0100
Message-Id: <1417980062-25151-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace a misspelled function name by %s and then __func__.

The function name begins with pci, not cpci.

This was done using Coccinelle, including the use of Levenshtein distance,
as proposed by Rasmus Villemoes.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The semantic patch is difficult to summarize, but is available in the cover
letter of this patch series.

 drivers/pci/hotplug/pci_hotplug_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 56d8486..d3f8330 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -532,7 +532,7 @@ static int __init pci_hotplug_init(void)
 
 	result = cpci_hotplug_init(debug);
 	if (result) {
-		err("cpci_hotplug_init with error %d\n", result);
+		err("%s with error %d\n", __func__, result);
 		return result;
 	}
 

