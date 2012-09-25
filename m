Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:35520 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab2IYI0p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:45 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	x86@kernel.org
Subject: [PATCH 16/29] PCI, x86: kill pci_find_next_bus in pcibios_scan_root
Date: Tue, 25 Sep 2012 01:26:17 -0700
Message-Id: <1348561590-28067-17-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/pci/common.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 720e973f..8580a6b 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -446,11 +446,14 @@ void __init dmi_check_pciprobe(void)
 
 struct pci_bus * __devinit pcibios_scan_root(int busnum)
 {
-	struct pci_bus *bus = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
+	struct pci_bus *bus;
 
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		if (bus->number == busnum) {
+	for_each_pci_host_bridge(host_bridge) {
+		if (host_bridge->bus->number == busnum) {
 			/* Already scanned */
+			bus = host_bridge->bus;
+			put_device(&host_bridge->dev);
 			return bus;
 		}
 	}
-- 
1.7.7

