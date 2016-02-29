Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46406 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbcB2RlJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Feb 2016 12:41:09 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Lennert Buytenhek <kernel@wantstofly.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@arm.linux.org.uk>
Subject: [RFC PATCH] arm: kernel: pci: remove pci=firmware command line parameter handling
Date: Mon, 29 Feb 2016 17:43:20 +0000
Message-Id: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to kernel documentation, the pci=firmware command line
parameter is only meant to be used on IXP2000 ARM platforms to prevent
the kernel from assigning PCI resources configured by the bootloader.

Since the IXP2000 ARM platforms support has been removed from the
kernel in commit:

commit c65f2abf54a6 ("ARM: remove ixp23xx and ixp2000 platforms")

its platforms specific kernel parameters should be removed
too from the kernel documentation along with the kernel code
currently handling them in that they have just become obsolete.

This patch removes the pci=firmware command line parameter handling
from ARM code and the related kernel parameters documentation
section.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 Documentation/kernel-parameters.txt | 5 -----
 arch/arm/kernel/bios32.c            | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 9a53c92..e213acc 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2875,11 +2875,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				for broken drivers that don't call it.
 		skip_isa_align	[X86] do not align io start addr, so can
 				handle more pci cards
-		firmware	[ARM] Do not re-enumerate the bus but instead
-				just use the configuration from the
-				bootloader. This is currently used on
-				IXP2000 systems where the bus has to be
-				configured a certain way for adjunct CPUs.
 		noearly		[X86] Don't do any early type 1 scanning.
 				This might help on some broken boards which
 				machine check when some devices' config space
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 066f7f9..05e61a2 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -550,9 +550,6 @@ char * __init pcibios_setup(char *str)
 	if (!strcmp(str, "debug")) {
 		debug_pci = 1;
 		return NULL;
-	} else if (!strcmp(str, "firmware")) {
-		pci_add_flags(PCI_PROBE_ONLY);
-		return NULL;
 	}
 	return str;
 }
-- 
2.5.1

