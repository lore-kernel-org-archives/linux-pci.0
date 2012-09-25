Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:39006 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2IYI1F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:27:05 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 22/29] PCI, alpha: kill pci_root_buses
Date: Tue, 25 Sep 2012 01:26:23 -0700
Message-Id: <1348561590-28067-23-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index ef75714..aea6ddc 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -305,10 +305,10 @@ pcibios_claim_one_bus(struct pci_bus *b)
 static void __init
 pcibios_claim_console_setup(void)
 {
-	struct pci_bus *b;
+	struct pci_host_bridge *host_bridge = NULL;
 
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_claim_one_bus(b);
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_claim_one_bus(bridge->bus);
 }
 
 void __init
-- 
1.7.7

