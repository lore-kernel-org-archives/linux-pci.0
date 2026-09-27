Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DE270575
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532354; cv=none; b=ZtcfUnZ4pSDwnUcvDdZVwfSlPYGMKcSdKrvzlE04FjrjHasbAXdabRGRq6RHuWEH41feRwldqWD+yy7ttlNTpqWkMyZmlw38SoNyC8sG6MaFvorywVtaqjG76owaOYXzCO0Lhl6nqnn+5i9Q2yQAvHynJYdejEFXcnxCGZ8C8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532354; c=relaxed/simple;
	bh=hStU9kZY4pF614Y8KSVlBb6w5PDaS3+dakPGyn3O3t8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=M4nu5kkxLknV8rmzGWllk6x+ryT7+XIn4NJlUD8MpPLaKiiFVo7KsYItsJ9zZS7y2LcSSYM875qlpCH0uZanz62voHTJSF4zTA0n7iae5LQFLdf4aczOqLAu82twoAuOLeevHqH7pn9TFspxdzEmjuZjZ0t9P88r8OpisLy415g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 3417D1D05;
	Sun, 27 Sep 2026 20:05:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DD4DA6078B58; Sun, 27 Sep 2026 20:05:48 +0200 (CEST)
Message-ID: <ae05fe2df3a3182594c4a9638daba1c72cf40358.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:01 +0200
Subject: [PATCH 1/7] PCI/DPC: Avoid access to non-existent AER capability
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Downstream Port Containment does not mandate presence of an Advanced Error
Reporting capability, so a Downstream Port may support DPC, but not AER
(PCIe r7.1 sec 6.2.11.2).

In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
DPC event handling") amended the DPC driver to access the AER capability
without checking for its presence.

In May 2020, commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
parsing for AER ownership") fixed it by inserting a call to
pcie_aer_is_native() in dpc_probe(), which implicitly checks for presence
of an AER capability.

However already in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
"pcie_ports=dpc-native" to allow DPC without AER control") made it
possible to override the check:  The DPC driver may access a non-existent
AER capability if "pcie_ports=dpc-native" is passed on the command line.

Fix it by making the DPC driver cope with AER-unsupporting Downstream
Ports.

There are two places where the AER capability is accessed:

- dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
  Non-Fatal Error triggered DPC.  Access the Device Status Register
  instead, in accordance with PCIe r7.1 sec 6.2.5.

- dpc_is_surprise_removal() uses it to detect whether a Surprise Down
  Error triggered DPC.  Return false on AER-unsupporting devices.  The
  function works around an AMD-specific quirk and it seems reasonable to
  assume that all affected products are AER-supporting.  In any case the
  detection is not possible without AER capability.

Insert a temporary check for an AER capability after the call to
aer_get_device_error_info() because the function currently returns false
for AER-unsupporting devices.  The check will become obsolete and will be
removed with the imminent baseline capability error reporting.

Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.5+
---
 drivers/pci/pcie/dpc.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..793a799053f1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -236,21 +236,15 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 					  struct aer_err_info *info)
 {
-	int pos = dev->aer_cap;
-	u32 status, mask, sev;
+	u16 devsta;
 
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
-	status &= ~mask;
-	if (!status)
-		return 0;
-
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
-	status &= sev;
-	if (status)
+	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
+	if (devsta & PCI_EXP_DEVSTA_FED)
 		info->severity = AER_FATAL;
-	else
+	else if (devsta & PCI_EXP_DEVSTA_NFED)
 		info->severity = AER_NONFATAL;
+	else
+		return 0;
 
 	info->level = KERN_ERR;
 
@@ -275,7 +269,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		    aer_get_device_error_info(&info, 0)) {
+		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
 			aer_print_error(&info, 0);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
@@ -353,6 +347,9 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
 	if (!pdev->is_hotplug_bridge)
 		return false;
 
+	if (!pdev->aer_cap)
+		return false;
+
 	if (pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
 				 &status))
 		return false;
-- 
2.53.0

