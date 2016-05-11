Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40062 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbcEKKwR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 May 2016 06:52:17 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] x86/PCI: Disable IO/MEM decoding for ROM BARs for devices with non-compliant BARs
Date: Wed, 11 May 2016 06:52:10 -0400
Message-Id: <1462963930-18506-3-git-send-email-prarit@redhat.com>
In-Reply-To: <1462963930-18506-1-git-send-email-prarit@redhat.com>
References: <1462963930-18506-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After executing quirk patches for the Broadwell-EP Home Agents,
the following errors are in the boot log:

pci 0000:ff:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:ff:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:ff:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:7f:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:7f:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:7f:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]

For the PCI ROM device's memory resource (BAR 6), pci_read_bases()
initializes the value of res->flags.  Later in the boot,
pcibios_assign_resources() attempts to assign uninitialized resources, and
calls pcibios_allocate_dev_rom_resource().  That function uses the
res->flags field to determine if the rom resource has been initialized.
The code then attempts to assign a resource to the rom BAR and the "failed
to assign" messages are output to the log.

This patch moves the non_compliant_bars check to pci_read_bases() so it
covers all the BARs of a non-compliant device.

Fixes: b84106b4e229 ("PCI: Disable IO/MEM decoding for devices with non-compliant BARs")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>

---
 drivers/pci/probe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8004f67c57ec..bf8405fb4ace 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -179,9 +179,6 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	u16 orig_cmd;
 	struct pci_bus_region region, inverted_region;
 
-	if (dev->non_compliant_bars)
-		return 0;
-
 	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
 
 	/* No printks while decoding is disabled! */
@@ -322,6 +319,9 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg;
 
+	if (dev->non_compliant_bars)
+		return;
+
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
-- 
1.7.9.3

