Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] PCI: ACS quirks for Intel 9-series PCH root ports
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	donald.d.dugger@intel.com
Date: Fri, 01 May 2015 13:20:13 -0600
Message-ID: <20150501191925.1863.71223.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel confirms that 9-series chipset root ports provide ACS-equivalent
isolation when configured via the existing Intel PCH ACS quirk setup.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Don Dugger <donald.d.dugger@intel.com>
---
 drivers/pci/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c6dc1df..f126bd6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3740,6 +3740,8 @@ static const u16 pci_quirk_intel_pch_acs_ids[] = {
 	/* Wellsburg (X99) PCH */
 	0x8d10, 0x8d11, 0x8d12, 0x8d13, 0x8d14, 0x8d15, 0x8d16, 0x8d17,
 	0x8d18, 0x8d19, 0x8d1a, 0x8d1b, 0x8d1c, 0x8d1d, 0x8d1e,
+	/* Lynx Point (9 series) PCH */
+	0x8c90, 0x8c92, 0x8c94, 0x8c96, 0x8c98, 0x8c9a, 0x8c9c, 0x8c9e,
 };
 
 static bool pci_quirk_intel_pch_acs_match(struct pci_dev *dev)

