Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f202.google.com ([209.85.212.202]:34610 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032736Ab2CPXsc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Mar 2012 19:48:32 -0400
Received: by wibhj13 with SMTP id hj13so60096wib.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Mar 2012 16:48:30 -0700 (PDT)
Subject: [PATCH v2 7/7] unicore32/PCI: move <asm-generic/pci-bridge.h> include
	to asm/pci.h
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>
Date: Fri, 16 Mar 2012 17:48:29 -0600
Message-ID: <20120316234829.6649.19734.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move this include to be consistent with other architectures.

CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/unicore32/include/asm/pci.h |    1 +
 arch/unicore32/kernel/pci.c      |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
index dd38677..f5e108f 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -14,6 +14,7 @@
 
 #ifdef __KERNEL__
 #include <asm-generic/pci-dma-compat.h>
+#include <asm-generic/pci-bridge.h>
 #include <asm-generic/pci.h>
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index 6c1248f..2fc2b1b 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <asm-generic/pci-bridge.h>
 
 static int debug_pci;
 

