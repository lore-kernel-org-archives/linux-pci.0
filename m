Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:47047 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754217Ab2FCT0s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2012 15:26:48 -0400
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-pci@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Marek <mmarek@suse.cz>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	x86@kernel.org
Subject: [PATCH 2/9] x86/quirks: move PCI fixup hooks from __init to __devinit
Date: Sun,  3 Jun 2012 20:48:18 +0200
Message-Id: <1338749305-22558-3-git-send-email-sebastian@breakpoint.cc>
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

Cc: x86@kernel.org
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/x86/kernel/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 03920a1..1b27de5 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -512,7 +512,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS,
 
 #if defined(CONFIG_PCI) && defined(CONFIG_NUMA)
 /* Set correct numa_node information for AMD NB functions */
-static void __init quirk_amd_nb_node(struct pci_dev *dev)
+static void __devinit quirk_amd_nb_node(struct pci_dev *dev)
 {
 	struct pci_dev *nb_ht;
 	unsigned int devfn;
-- 
1.7.10

