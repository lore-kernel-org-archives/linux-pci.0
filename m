Return-Path: <SRS0=eoip=LT=redhat.com=ptalbert@kernel.org>
Return-Path: <SRS0=eoip=LT=redhat.com=ptalbert@kernel.org>
From: Patrick Talbert <ptalbert@redhat.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@kernel.org
Subject: [[v1]] PCI/ASPM: Do not initialize link state when aspm_disabled is set
Date: Wed,  5 Sep 2018 09:12:53 +0200
Message-Id: <1536131573-15087-1-git-send-email-ptalbert@redhat.com>
List-ID: <linux-pci.vger.kernel.org>

Now that ASPM is configured for *all* PCIE devices at boot, a problem is seen
with systems that set the FADT NO_ASPM bit. This bit indicates that the OS
should not alter the ASPM state, but when pcie_aspm_init_link_state() runs it
only checks for !aspm_support_enabled. This misses the ACPI_FADT_NO_ASPM case
because that is setting aspm_disabled.

The result is systems may hang at boot after 1302fcf; avoidable if they boot
with pcie_aspm=off (sets !aspm_support_enabled).

Fix this by having aspm_init_link_state() check for either !aspm_support_enabled
or acpm_disabled.

Fixes: 1302fcf ("PCI: Configure *all* devices, not just hot-added ones")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201001
Signed-off-by: Patrick Talbert <ptalbert@redhat.com>
---
 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 53269167..4feb8ba 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -895,7 +895,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	struct pcie_link_state *link;
 	int blacklist = !!pcie_aspm_sanity_check(pdev);
 
-	if (!aspm_support_enabled)
+	if (!aspm_support_enabled || aspm_disabled)
 		return;
 
 	if (pdev->link_state)
-- 
1.8.3.1
