Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.codelabs.ch ([217.150.249.120]:58089 "EHLO
	fenrir.codelabs.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbcCWKok (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2016 06:44:40 -0400
From: Adrian-Ken Rueegsegger <ken@codelabs.ch>
To: linux-pci@vger.kernel.org
Cc: ken@codelabs.ch
Subject: [RFC PATCH] x86/PCI: Refine PCI support check in pcibios_init()
Date: Wed, 23 Mar 2016 11:34:29 +0100
Message-Id: <1458729269-9440-2-git-send-email-ken@codelabs.ch>
In-Reply-To: <1458729269-9440-1-git-send-email-ken@codelabs.ch>
References: <1458729269-9440-1-git-send-email-ken@codelabs.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Also consider raw_pci_ext_ops when validating if a system has PCI
support. This leads to proper resource allocation via
pcibios_resource_survey() in the case where PCI config space is
exclusively accessed through MMCONFIG.

Signed-off-by: Adrian-Ken Rueegsegger <ken@codelabs.ch>
---
 arch/x86/pci/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 8fd6f44..50b123d 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -517,7 +517,7 @@ void __init pcibios_set_cache_line_size(void)
 
 int __init pcibios_init(void)
 {
-	if (!raw_pci_ops) {
+	if (!raw_pci_ops && !raw_pci_ext_ops) {
 		printk(KERN_WARNING "PCI: System does not support PCI\n");
 		return 0;
 	}
-- 
2.1.4

