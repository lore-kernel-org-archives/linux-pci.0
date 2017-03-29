Return-Path: <SRS0=zNZg=3G=semihalf.com=tn@kernel.org>
Return-Path: <SRS0=zNZg=3G=semihalf.com=tn@kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	Lorenzo.Pieralisi@arm.com,
	robert.richter@caviumnetworks.com,
	ddaney@caviumnetworks.com,
	Vadim.Lomovtsev@caviumnetworks.com,
	rafael@kernel.org
Cc: Sunil.Goutham@cavium.com,
	geethasowjanya.akula@gmail.com,
	linu.cherian@cavium.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH 1/1] PCI: Add MCFG quirk for 2nd node of Cavium ThunderX pass2.x host controller
Date: Wed, 29 Mar 2017 14:16:13 +0200
Message-Id: <1490789773-21506-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Currently SoCs pass2.x do not emulate EA headers for ACPI boot method at all.
However, for pass2.x some devices (like EDAC) advertise incorrect base addresses
in their BARs which results in driver probe failure during resource request.
Since all problematic blocks are on 2nd NUMA node under domain 10 add necessary
quirk entry to obtain BAR addresses correction using EA header emulation.

Fixes: 44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller")
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
CC: stable@vger.kernel.org	# v4.10+
---
 drivers/acpi/pci_mcfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index a6a4cea..a0a391e 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -90,13 +90,14 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x894057000000UL, node) },  \
 	{ "CAVIUM", "THUNDERX", rev, 9 + (10 * (node)), MCFG_BUS_ANY,	    \
 	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89808f000000UL, node) }
+#define THUNDER_ECAM_QUIRK(rev, seg)					\
+	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,			\
+	&pci_thunder_ecam_ops }
 	/* SoC pass2.x */
 	THUNDER_PEM_QUIRK(1, 0),
 	THUNDER_PEM_QUIRK(1, 1),
+	THUNDER_ECAM_QUIRK(1, 10),
 
-#define THUNDER_ECAM_QUIRK(rev, seg)					\
-	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,			\
-	&pci_thunder_ecam_ops }
 	/* SoC pass1.x */
 	THUNDER_PEM_QUIRK(2, 0),	/* off-chip devices */
 	THUNDER_PEM_QUIRK(2, 1),	/* off-chip devices */
-- 
2.7.4
