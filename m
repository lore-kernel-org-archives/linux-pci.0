Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36081 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157AbbFDVtw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 17:49:52 -0400
Received: by oihb142 with SMTP id b142so40741816oih.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 14:49:52 -0700 (PDT)
Subject: [PATCH 4/7] PCI: Include <linux/pci.h>, not <asm/pci.h>
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 04 Jun 2015 16:49:50 -0500
Message-ID: <20150604214950.2399.16890.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We already include <asm/pci.h> from <linux/pci.h>, so just include
<linux/pci.h> directly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-s390@vger.kernel.org
---
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |    2 +-
 arch/s390/kernel/suspend.c                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index e2d401a..6eb3b2a 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -12,7 +12,7 @@
 
 #undef DEBUG
 
-#include <asm/pci.h>
+#include <linux/pci.h>
 #include <asm/mpc52xx.h>
 #include <asm/delay.h>
 #include <asm/machdep.h>
diff --git a/arch/s390/kernel/suspend.c b/arch/s390/kernel/suspend.c
index d3236c9..39e2f41 100644
--- a/arch/s390/kernel/suspend.c
+++ b/arch/s390/kernel/suspend.c
@@ -9,10 +9,10 @@
 #include <linux/pfn.h>
 #include <linux/suspend.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 #include <asm/ctl_reg.h>
 #include <asm/ipl.h>
 #include <asm/cio.h>
-#include <asm/pci.h>
 #include <asm/sections.h>
 #include "entry.h"
 

