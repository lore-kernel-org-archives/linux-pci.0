Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34102 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbcEUMPq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 21 May 2016 08:15:46 -0400
Received: by mail-lf0-f66.google.com with SMTP id 65so37213lfq.1
        for <linux-pci@vger.kernel.org>; Sat, 21 May 2016 05:15:46 -0700 (PDT)
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, bhelgaas@google.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0289/1529] Fix typo
Date: Sat, 21 May 2016 14:15:39 +0200
Message-Id: <20160521121539.15485-1-andrea.gelmini@gelma.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/x86/pci/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 8196054..7b6a9d1 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -133,7 +133,7 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev)
 	if (pci_probe & PCI_NOASSIGN_BARS) {
 		/*
 		* If the BIOS did not assign the BAR, zero out the
-		* resource so the kernel doesn't attmept to assign
+		* resource so the kernel doesn't attempt to assign
 		* it later on in pci_assign_unassigned_resources
 		*/
 		for (bar = 0; bar <= PCI_STD_RESOURCE_END; bar++) {
-- 
2.8.2.534.g1f66975

