Received: from microway.com (mail.microway.com [50.217.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED78384CDF;
	Tue,  4 Aug 2026 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.217.201.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876539; cv=none; b=Co0JgXRqIxEoBxUBYLKrF1BkZM0r3WaATbkUUCGjEENDnl3by7d6/foDZ316QkYywj/UVo42OmUUVr8zEwcA34Onued98rVRl98fGbfKbSx42H8ht/Q/MMiUxw+B6PKCyy4kWSftph0mPe5ZlFTlyCDBMruKbNijx2SylOzdrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876539; c=relaxed/simple;
	bh=3CZU9YGQBE1cT7UpGgX9bQSGoRgummebLIMPdk7GMp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwtkNRsiLqXHJrq4fTREfZlFJpBIHvDoQUqMx9HQC+/ZfepdxCKjmLVSoYtv67b1alTNgMV69vCZKaJ3uv+eFrkO5HEAIGnTBqnznuy2bhOxY2BPp7dN9ugVUzkmvCiO7sS+bP3+I6ArFSi0Og7U3AZrVS+lqz+4hwlQhWsNrOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=microway.com; spf=pass smtp.mailfrom=microway.com; dkim=pass (2048-bit key) header.d=microway.com header.i=@microway.com header.b=Pus5hBWz; arc=none smtp.client-ip=50.217.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=microway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microway.com header.i=@microway.com header.b="Pus5hBWz"
Received: from dragon.microway.com (unknown [10.200.120.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by microway.com (Postfix) with ESMTPSA id 748D28FD0;
	Tue,  4 Aug 2026 16:48:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 microway.com 748D28FD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microway.com;
	s=byedon; t=1785876536;
	bh=2T+pOxr+2nPV2Oh/iOvNu51V2gphKRShvM+YUj0d0Eg=;
	h=From:To:Cc:Subject:Date:From;
	b=Pus5hBWz/8MVDtU71G1Qz/v+VbAYm0xM6bGK60CIFwiKtbgwa3Q2l3mstKNsxDbE7
	 sDwWFkLiQIVa3xCixKRcDb8NJOxnT4x+wG6880gIIL/I1v09iqKk556IE9TEqYuiky
	 SJpr1XvYB0hzfTwwyrSnGVokslout7St1Yoawy+fTxtTaOhRE5Loi7E39XceqssOCx
	 xL50o767duLLLwLTOhFA7rLZKzesPvwqw9un9ZfK1R5EdUfRipskqViMjEhtOaEeNI
	 hepIoiVU3sY713sxf53s9IWICjtrxItU/vLW1z+KvRxSV35JFEQSERwtTETlqmqwTi
	 F2hChYKxKZ0OA==
From: Rick Warner <rick@microway.com>
To: helgaas@kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rhoughton@microway.com,
	ssingh@microway.com,
	rick@microway.com,
	lukas@wunner.de
Subject: [PATCH v2] PCI: Fix Intel Xeon 6 x2 quirk collateral damage on adjacent x4 endpoints
Date: Tue,  4 Aug 2026 16:48:45 -0400
Message-ID: <20260804204845.171483-1-rick@microway.com>
X-Mailer: git-send-email 2.52.0
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
downstream-isolated. Remove the broad host bridge no_ext_tags and
enable_device = limit_mrrs_to_128 assignments, instead setting only
no_inc_mrrs = 1 to prevent increases from vfio, VM, etc usage.

DECLARE_PCI_FIXUP_HEADER then registers pci_xeon6_x2_local_endpoint_fixup
to check every pci device as it initializes to see if it is downstream of
an affected x2 port, and if so, the device has extended tags disabled and
mrrs set to 128. This enforces Intel's stability parameters locally on the
bottlenecked lane branches while fully protecting the parallel x4 channels.

Fixes: a22250fe933d ("PCI: Add Extended Tag + MRRS quirk for Xeon 6")
Signed-off-by: Rick Warner <rick@microway.com>
---
v2
Original submission did a single pci bus walk and didn't handle hot
plugged devices.  This has been rewritten to handle the quirk per
device during initialization by checking if it's a descendant of a x2 port.

This was tested successfully on a Gigabyte MS74-HB0 motherboard with a
Seagate ZP4000GM30063 M.2 drive in the 2nd slot. With the stock 7.0 kernel,
the drive fails to initialize and is unavailable once booted. Testing showed
that extended tags (vs mrrs) are the key to getting this drive working.

Concerns were raised about vfio/VM usage being able to re-enable extended 
tags if bridge->no_ext_tags is not set.  I'm not sure how to best address 
that if it's needed. The best option I've come up with is adding
DECLARE_PCI_FIXUP_FINAL calls for 0x0db0-0xdb9 that set no_ext_tags after
the initial pci bus walk is done. That would enable the already 
initialized devices to maintain their configured extended tag support 
but would block all newly hotplugged devices on that bridge from using
extended tags, even if they weren't downstream of a x2 port. That might be
good enough, as it would at least solve this issue for NVME drives not
initializing. Otherwise I think bigger changes might be required to 
handle it more cleanly.

 arch/x86/pci/fixup.c | 58 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df75..0ab92a5cc0d1 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -301,15 +301,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_r
  *
  * https://cdrdv2.intel.com/v1/dl/getContent/837176
  */
-static int limit_mrrs_to_128(struct pci_host_bridge *b, struct pci_dev *pdev)
-{
-	int readrq = pcie_get_readrq(pdev);
-
-	if (readrq > 128)
-		pcie_set_readrq(pdev, 128);
-
-	return 0;
-}
 
 static void pci_xeon_x2_bifurc_quirk(struct pci_dev *pdev)
 {
@@ -320,9 +311,8 @@ static void pci_xeon_x2_bifurc_quirk(struct pci_dev *pdev)
 	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
 		return;
 
-	bridge->no_ext_tags = 1;
-	bridge->enable_device = limit_mrrs_to_128;
-	pci_info(pdev, "Disabling Extended Tags and limiting MRRS to 128B (performance reasons due to x2 PCIe link)\n");
+	bridge->no_inc_mrrs = 1;
+	pci_info(pdev, "Blocking devices on this bridge from increasing MRRS for performance reasons due to x2 PCIe link)\n");
 }
 
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db0, pci_xeon_x2_bifurc_quirk);
@@ -334,6 +324,50 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db7, pci_xeon_x2_bifurc_quirk);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db8, pci_xeon_x2_bifurc_quirk);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db9, pci_xeon_x2_bifurc_quirk);
 
+/* Helper to check if a device descends from an affected Xeon 6 x2 Root Port */
+static bool is_descendant_of_xeon6_x2_rp(struct pci_dev *pdev)
+{
+	u32 linkcap;
+	struct pci_dev *upstream = pci_upstream_bridge(pdev);
+
+	while (upstream) {
+		if (upstream->vendor == PCI_VENDOR_ID_INTEL &&
+		    upstream->device >= 0x0db0 &&
+		    upstream->device <= 0x0db9) {
+			pcie_capability_read_dword(upstream, PCI_EXP_LNKCAP, &linkcap);
+			if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
+				return false;
+			else
+				return true;
+		}
+		upstream = pci_upstream_bridge(upstream);
+	}
+	return false;
+}
+
+static void pci_xeon6_x2_local_endpoint_fixup(struct pci_dev *pdev)
+{
+	/* Skip bridges/switches; only target actual endpoints */
+	if (pci_is_bridge(pdev))
+		return;
+
+	/* Only apply to devices under the x2 branch; leaves x4 branches completely untouched */
+	if (!is_descendant_of_xeon6_x2_rp(pdev))
+		return;
+
+	pci_info(pdev, "Applying local Xeon 6 x2 quirk: Disabling Extended Tags and locking MRRS to 128B\n");
+
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG);
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_READRQ);
+}
+
+/*
+ * HEADER fixups run for EVERY endpoint during its initial discovery phase.
+ * This natively catches boot devices, hotplugged devices, and SR-IOV VFs.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_xeon6_x2_local_endpoint_fixup);
+
+
 /*
  * Fixup to mark boot BIOS video selected by BIOS before it changes
  *
-- 
2.52.0

