Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63437 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129Ab2BOCfY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Feb 2012 21:35:24 -0500
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH] ARM/PCI: Remove ARM's duplicate definition of
	'pcibios_max_latency'
To: jbarnes@virtuousgeek.org
Cc: linux-pci@vger.kernel.org, linux@arm.linux.org.uk
Date: Tue, 14 Feb 2012 19:35:15 -0700
Message-ID: <20120215023515.22807.66164.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Myron Stowe <mstowe@redhat.com>

The patch series to re-factor PCI's 'latency timer' setup (re:
http://marc.info/?l=linux-kernel&m=131983853831049&w=2) forgot to
remove the ARM specific definition of 'pcibios_max_latency' once such
had been moved into the pci core resulting in ARM related compile
errors -
  drivers/built-in.o:(.data+0x230): multiple definition of
  `pcibios_max_latency'
  arch/arm/common/built-in.o:(.data+0x40c): first defined here
  make[1]: *** [vmlinux.o] Error 1

In the series, patch 2/16 (commit 168c8619fd8) converted the ARM
specific version of 'pcibios_set_master()' to a non-inlined version.
This was done in preperation for hosting it up into PCI's core, which
was done in patch 10/16 (commit 96c5590058d) of the series (and
where the removal of ARM's 'pcibios_max_latency' was overlooked).

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 arch/arm/common/it8152.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index d1bcd7b..fb1f1cf 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -320,13 +320,6 @@ err0:
 	return -EBUSY;
 }
 
-/*
- * If we set up a device for bus mastering, we need to check the latency
- * timer as we don't have even crappy BIOSes to set it properly.
- * The implementation is from arch/i386/pci/i386.c
- */
-unsigned int pcibios_max_latency = 255;
-
 /* ITE bridge requires setting latency timer to avoid early bus access
    termination by PCI bus master devices
 */

