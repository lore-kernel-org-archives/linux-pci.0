Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35393 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbbFDVtq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 17:49:46 -0400
Received: by obbgp2 with SMTP id gp2so19783878obb.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 14:49:45 -0700 (PDT)
Subject: [PATCH 3/7] microblaze/PCI: Remove unnecessary struct pci_dev
 declaration
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <monstr@monstr.eu>
Date: Thu, 04 Jun 2015 16:49:43 -0500
Message-ID: <20150604214943.2399.32540.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All users of arch/microblaze/include/asm/pci.h get it by including
include/linux/pci.h, which in turn includes <asm/pci.h> after it declares
struct pci_dev.

The forward declaration here is unnecessary, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/pci.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 541400d..67224d3 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -27,8 +27,6 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
-struct pci_dev;
-
 /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
 #define IOBASE_BRIDGE_NUMBER	0
 #define IOBASE_MEMORY		1

