Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:59442 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618AbaHYV1O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 17:27:14 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so13892626wgg.24
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2014 14:27:13 -0700 (PDT)
From: Mathias Krause <minipli@googlemail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 5/5] x86/PCI: Mark PCI BIOS initialization code as such
Date: Mon, 25 Aug 2014 23:26:39 +0200
Message-Id: <1409001999-23161-6-git-send-email-minipli@googlemail.com>
In-Reply-To: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
References: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_find_bios() function is only ever called from initialization
code, therefore can be marked as such, too. This, in turn, allows
marking other functions called only in this context as well.

The bios32_indirect variable can be marked as __initdata as it is only
referenced from __init functions now.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/x86/pci/pcbios.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index c77b24a8b2..9b83b9051a 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -79,13 +79,13 @@ union bios32 {
 static struct {
 	unsigned long address;
 	unsigned short segment;
-} bios32_indirect = { 0, __KERNEL_CS };
+} bios32_indirect __initdata = { 0, __KERNEL_CS };
 
 /*
  * Returns the entry point for the given service, NULL on error
  */
 
-static unsigned long bios32_service(unsigned long service)
+static unsigned long __init bios32_service(unsigned long service)
 {
 	unsigned char return_code;	/* %al */
 	unsigned long address;		/* %ebx */
@@ -124,7 +124,7 @@ static struct {
 
 static int pci_bios_present;
 
-static int check_pcibios(void)
+static int __init check_pcibios(void)
 {
 	u32 signature, eax, ebx, ecx;
 	u8 status, major_ver, minor_ver, hw_mech;
@@ -312,7 +312,7 @@ static const struct pci_raw_ops pci_bios_access = {
  * Try to find PCI BIOS.
  */
 
-static const struct pci_raw_ops *pci_find_bios(void)
+static const struct pci_raw_ops *__init pci_find_bios(void)
 {
 	union bios32 *check;
 	unsigned char sum;
-- 
1.7.10.4

