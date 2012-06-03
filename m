Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:47041 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754019Ab2FCT0l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2012 15:26:41 -0400
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-pci@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Marek <mmarek@suse.cz>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 9/9] sh: move PCI fixup hooks from __init to __devinit
Date: Sun,  3 Jun 2012 20:48:25 +0200
Message-Id: <1338749305-22558-10-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The fixups are executed once the pci-device is found which is during
boot process so __init seems fine as long as the platform does not
support hotplug.
However it is possible to remove the PCI bus at run time and have it
rediscovered again via "echo 1 > /sys/bus/pci/rescan" and this will call
the fixups again.

Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/sh/drivers/pci/fixups-dreamcast.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
index edeea89..a5fe1b5 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -28,7 +28,7 @@
 #include <asm/irq.h>
 #include <mach/pci.h>
 
-static void __init gapspci_fixup_resources(struct pci_dev *dev)
+static void __devinit gapspci_fixup_resources(struct pci_dev *dev)
 {
 	struct pci_channel *p = dev->sysdata;
 
-- 
1.7.10

