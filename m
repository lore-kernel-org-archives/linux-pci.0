Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48590 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbcCHRmm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 12:42:42 -0500
Subject: [PATCH] unicore32: Remove unused HAVE_ARCH_PCI_SET_DMA_MASK
 definition
To: Xuetao <gxt@mprc.pku.edu.cn>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 08 Mar 2016 11:42:39 -0600
Message-ID: <20160308174238.20498.35018.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

HAVE_ARCH_PCI_SET_DMA_MASK is unused, so remove the #define for it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/unicore32/include/mach/hardware.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/unicore32/include/mach/hardware.h b/arch/unicore32/include/mach/hardware.h
index 9e20b5d..2514623 100644
--- a/arch/unicore32/include/mach/hardware.h
+++ b/arch/unicore32/include/mach/hardware.h
@@ -28,11 +28,6 @@
 #define PCIBIOS_MIN_IO			0x4000 /* should lower than 64KB */
 #define PCIBIOS_MIN_MEM			io_v2p(PKUNITY_PCIMEM_BASE)
 
-/*
- * We override the standard dma-mask routines for bouncing.
- */
-#define	HAVE_ARCH_PCI_SET_DMA_MASK
-
 #define pcibios_assign_all_busses()	1
 
 #endif  /* __MACH_PUV3_HARDWARE_H__ */

