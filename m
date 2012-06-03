Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:47052 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754360Ab2FCT04 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2012 15:26:56 -0400
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-pci@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Marek <mmarek@suse.cz>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 6/9] frv: move PCI fixup hooks from __init to __devinit
Date: Sun,  3 Jun 2012 20:48:22 +0200
Message-Id: <1338749305-22558-7-git-send-email-sebastian@breakpoint.cc>
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

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/frv/mb93090-mb00/pci-vdk.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index 6b0b82f..d04ed14 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -268,7 +268,7 @@ static void __init pci_fixup_umc_ide(struct pci_dev *d)
 		d->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
 }
 
-static void __init pci_fixup_ide_bases(struct pci_dev *d)
+static void __devinit pci_fixup_ide_bases(struct pci_dev *d)
 {
 	int i;
 
@@ -287,7 +287,7 @@ static void __init pci_fixup_ide_bases(struct pci_dev *d)
 	}
 }
 
-static void __init pci_fixup_ide_trash(struct pci_dev *d)
+static void __devinit pci_fixup_ide_trash(struct pci_dev *d)
 {
 	int i;
 
-- 
1.7.10

