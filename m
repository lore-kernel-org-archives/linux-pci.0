Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH] PCI: Add Wellsburg (X99) to Intel PCH root port ACS quirk
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, donald.d.dugger@intel.com,
	linux-kernel@vger.kernel.org
Date: Thu, 22 Jan 2015 11:15:43 -0700
Message-ID: <20150122181524.1586.14496.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel has confirmed that the Wellsburg chipset, while not reporting
ACS, does provide the proper isolation through the RCBA/BSPR
registers, so the same quirk works for this set of device IDs.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Don Dugger <donald.d.dugger@intel.com>
---

 drivers/pci/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ed6f89b..2cdb789 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3630,6 +3630,9 @@ static const u16 pci_quirk_intel_pch_acs_ids[] = {
 	0x9c98, 0x9c99, 0x9c9a, 0x9c9b,
 	/* Patsburg (X79) PCH */
 	0x1d10, 0x1d12, 0x1d14, 0x1d16, 0x1d18, 0x1d1a, 0x1d1c, 0x1d1e,
+	/* Wellsburg (X99) PCH */
+	0x8d10, 0x8d11, 0x8d12, 0x8d13, 0x8d14, 0x8d15, 0x8d16, 0x8d17,
+	0x8d18, 0x8d19, 0x8d1a, 0x8d1b, 0x8d1c, 0x8d1d, 0x8d1e,
 };
 
 static bool pci_quirk_intel_pch_acs_match(struct pci_dev *dev)

