Received: from microway.com (mail.microway.com [50.217.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2433E7633;
	Wed, 29 Jul 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.217.201.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336702; cv=none; b=KTevkOAg9Sl4b33xKAkQL9GaFH/mSlZN7IoDYHpm4Ba2ZB0XwPvPXAsmoHoQYYBttzqXRulnnoBHF36KVRP7UG9+KCnmHUvw3Qyi/UBHLe4lIZMIp03D6fh5GVOt9YwpA1fkSCA6H8+ldtCPcuGTQQ0GGgxmZvN17mwi8A44zAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336702; c=relaxed/simple;
	bh=6ctvuaFhbv1h55zGf/zLHbDo+eru6frP4lQsqclWRSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhBHvWhLnHUPMK7PN4RVs9WeMqJDFPP+Ud1hE1S+yIyY5FqxX1LKyfgHUbo8OUqMPq41pHLddlHQob9P0vF3Q4wRRfYUxuPLDirFOegTp9+kb6HlW44XOY+4lKKHw6E0hLwe/VB+7qKkwrGh+nSCNFySKxhGKt0IInjdc1aaalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=microway.com; spf=pass smtp.mailfrom=microway.com; dkim=pass (2048-bit key) header.d=microway.com header.i=@microway.com header.b=JHUlXW3G; arc=none smtp.client-ip=50.217.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=microway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microway.com header.i=@microway.com header.b="JHUlXW3G"
Received: from ubuntu24.microway.com (dhcp216.microway.com [10.100.100.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by microway.com (Postfix) with ESMTPSA id 77FAA14474;
	Wed, 29 Jul 2026 10:45:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 microway.com 77FAA14474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microway.com;
	s=byedon; t=1785336353;
	bh=KAoc8cy6QTkxpO1Td9YSLHwIlh/9evEz5ZhsvDf+aZI=;
	h=From:To:Cc:Subject:Date:From;
	b=JHUlXW3GLsTA3/636eU3dTPnyfVCtZ/EXKMss4q3fYXeD6RhpUQrp8SyLID34F+LN
	 KFKQ5NNDJi7OzoEOZ5wP68WZ/tJOKb644PABgOICOImVSW/7ryNpqUkbiWPFo2Njtj
	 W+0CEWf2hrFzLBcCliFtET9ziht0kcvxT39YE5xEgDzmzN3/1UEKH0D/un6lX7bNal
	 KIbBNl+fkP0CYToQyqW60u1nSIPFPdBkiWkN6hzhlCE/nTw6EUC7iapEILFDnU7Lgz
	 ELIk3NWFj3z1k12zgrzM8QbUEiDHY1hBShGKYCnoKowUShVb6ooG9FXNuTtP+IAvZF
	 i6fRlN8PjYlmQ==
From: Rick Warner <rick@microway.com>
To: bhelgaas@google.com
Cc: ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rhoughton@microway.com,
	ssingh@microway.com,
	Rick Warner <rick@microway.com>
Subject: [PATCH] PCI: Fix Intel Xeon 6 x2 quirk collateral damage on adjacent x4 endpoints
Date: Wed, 29 Jul 2026 10:45:08 -0400
Message-ID: <20260729144508.12337-1-rick@microway.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a22250fe933d ("PCI: Add Extended Tag + MRRS quirk for Xeon 6")
introduced a traffic mitigation quirk for Intel Xeon 6 root ports that
negotiate down to an x2 lane width. However, that patch manipulated host
bridge properties globally via 'bridge->no_ext_tags = 1' and by hooking
'bridge->enable_device'.

Because multiple unrelated root ports can reside under the exact same
global pci_host_bridge domain structure, this overly aggressive mitigation
causes severe collateral damage. When a low-speed or bifurcated secondary
device (such as an onboard ASMedia SATA controller or BMC graphics link)
matches the x2 condition, the kernel strips away Extended Tags and forces
a 128B MRRS restriction across that ENTIRE host bridge. This instantly
breaks or starves adjacent high-performance, unrelated x4 endpoints
(such as NVMe drives), resulting in controller timeouts, initialization
failures, and missing drives at boot.

Fix this by refactoring the quirk logic to be completely per-device and
downstream-isolated. Remove the broad host bridge structure assignments
entirely. Instead, convert the hook to an explicit
'DECLARE_PCI_FIXUP_FINAL' sweep. When an x2 bifurcated root port is
discovered, leverage 'pci_walk_bus()' to step down only that specific root
port's subordinate tree, manually clearing 'PCI_EXP_DEVCTL_EXT_TAG' and
'PCI_EXP_DEVCTL_READRQ' directly in the endpoint Device Control
configuration registers. This enforces Intel's stability parameters
locally on the bottlenecked lane branches while fully protecting the
parallel x4 highway channels.

Fixes: a22250fe933d ("PCI: Add Extended Tag + MRRS quirk for Xeon 6")
Signed-off-by: Rick Warner <rick@microway.com>
---
 arch/x86/pci/fixup.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df75..c2bdf580692a 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -301,38 +301,43 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_r
  *
  * https://cdrdv2.intel.com/v1/dl/getContent/837176
  */
-static int limit_mrrs_to_128(struct pci_host_bridge *b, struct pci_dev *pdev)
+static int pci_xeon_x2_bifurc_quirk_perdev(struct pci_dev *pdev, void *data)
 {
-	int readrq = pcie_get_readrq(pdev);
-
-	if (readrq > 128)
-		pcie_set_readrq(pdev, 128);
-
+	/* Only clamp actual endpoints, skip downstream switches/bridges */
+	if (!pci_is_bridge(pdev)) {
+		pci_info(pdev, "Disabling Extended Tags and Clamping MRRS to 128B due to upstream Xeon 6 x2 bifurcation\n");
+		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG);
+		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_READRQ);
+	}
 	return 0;
 }
 
 static void pci_xeon_x2_bifurc_quirk(struct pci_dev *pdev)
 {
-	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
 	u32 linkcap;
 
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
 	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
 		return;
 
-	bridge->no_ext_tags = 1;
-	bridge->enable_device = limit_mrrs_to_128;
-	pci_info(pdev, "Disabling Extended Tags and limiting MRRS to 128B (performance reasons due to x2 PCIe link)\n");
+	pci_info(pdev, "Xeon 6 x2 lane bifurcation detected; restricting subordinate devices\n");
+
+	/*
+	 * Walk down only this specific root port's downstream bus tree
+	 * and clear extended tags specifically for devices on this branch.
+	 */
+	if (pdev->subordinate)
+		pci_walk_bus(pdev->subordinate, pci_xeon_x2_bifurc_quirk_perdev, NULL);
 }
 
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db0, pci_xeon_x2_bifurc_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db1, pci_xeon_x2_bifurc_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db2, pci_xeon_x2_bifurc_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db3, pci_xeon_x2_bifurc_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db6, pci_xeon_x2_bifurc_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db7, pci_xeon_x2_bifurc_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db8, pci_xeon_x2_bifurc_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db9, pci_xeon_x2_bifurc_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0db0, pci_xeon_x2_bifurc_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0db1, pci_xeon_x2_bifurc_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0db2, pci_xeon_x2_bifurc_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0db3, pci_xeon_x2_bifurc_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0db6, pci_xeon_x2_bifurc_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0db7, pci_xeon_x2_bifurc_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0db8, pci_xeon_x2_bifurc_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0db9, pci_xeon_x2_bifurc_quirk);
 
 /*
  * Fixup to mark boot BIOS video selected by BIOS before it changes
-- 
2.43.0

