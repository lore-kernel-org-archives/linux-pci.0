Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] Revert: "PCI: Add ACS quirk for all Cavium devices"
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Tirumalesh Chalamarla <tchalamarla@cavium.com>,
        linux-kernel@vger.kernel.org,
        Manish Jaggi <mjaggi@caviumnetworks.com>
Date: Tue, 14 Feb 2017 09:18:18 -0700
Message-ID: <20170214161711.21753.16746.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This reverts commit b404bcfbf035413dcce539c8ba2c9986d220d8ed.

The reverted commit makes no attempt to selectively consider devices,
current or future.  Instead, it whitelists the entire PCI vendor ID.
This is a reckless approach as we clearly cannot know whether future
device IDs within this vendor ID are susceptible to peer-to-peer.
Additionally, the comment suggests this quirk is only relevant to
ThunderX, which raises further doubt whether it is appropriate to
apply to the entire vendor ID.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Manish Jaggi <mjaggi@caviumnetworks.com>
Cc: Tirumalesh Chalamarla <tchalamarla@cavium.com>
---

Please submit a new quirk targeting specific devices

 drivers/pci/quirks.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1800befa8b8b..449eabb438e2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4060,19 +4060,6 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 #endif
 }
 
-static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
-{
-	/*
-	 * Cavium devices matching this quirk do not perform peer-to-peer
-	 * with other functions, allowing masking out these bits as if they
-	 * were unimplemented in the ACS capability.
-	 */
-	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
-		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
-
-	return acs_flags ? 0 : 1;
-}
-
 /*
  * Many Intel PCH root ports do provide ACS-like features to disable peer
  * transactions and validate bus numbers in requests, but do not provide an
@@ -4276,8 +4263,6 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_spt_pch_acs },
 	{ 0x19a2, 0x710, pci_quirk_mf_endpoint_acs }, /* Emulex BE3-R */
 	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
-	/* Cavium ThunderX */
-	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
 	{ 0 }
 };
 
