Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32898 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754913AbdFXCB6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2017 22:01:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so9738989pfk.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Jun 2017 19:01:58 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
To: linux-pci@vger.kernel.org
To: linux-kernel@vger.kernel.org
To: bhelgaas@google.com
To: hch@infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-cris-kernel@axis.com
Cc: linux-ia64@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 3/3] arc: kernel/pcibios.c is empty, delete it
Date: Fri, 23 Jun 2017 18:50:44 -0700
Message-Id: <20170624015044.16746-4-palmer@dabbelt.com>
In-Reply-To: <20170624015044.16746-1-palmer@dabbelt.com>
References: <20170624015044.16746-1-palmer@dabbelt.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/arc/kernel/Makefile  | 1 -
 arch/arc/kernel/pcibios.c | 9 ---------
 2 files changed, 10 deletions(-)
 delete mode 100644 arch/arc/kernel/pcibios.c

diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 8942c5c3b4c5..2dc5f4296d44 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -12,7 +12,6 @@ obj-y	:= arcksyms.o setup.o irq.o reset.o ptrace.o process.o devtree.o
 obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o
 obj-$(CONFIG_ISA_ARCOMPACT)		+= entry-compact.o intc-compact.o
 obj-$(CONFIG_ISA_ARCV2)			+= entry-arcv2.o intc-arcv2.o
-obj-$(CONFIG_PCI)  			+= pcibios.o
 
 obj-$(CONFIG_MODULES)			+= arcksyms.o module.o
 obj-$(CONFIG_SMP) 			+= smp.o
diff --git a/arch/arc/kernel/pcibios.c b/arch/arc/kernel/pcibios.c
deleted file mode 100644
index 05aba5a7b5d2..000000000000
--- a/arch/arc/kernel/pcibios.c
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * Copyright (C) 2014-2015 Synopsys, Inc. (www.synopsys.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/pci.h>
-- 
2.13.0
