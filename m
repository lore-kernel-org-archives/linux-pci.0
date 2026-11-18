Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998529;
	b=E9wyVXecwqmdDtCZ7m4V1Nn7802kT0rg7v1D7BbxHHxx2vCxCgA7vrM2jPu0SpFhYJTZ
	 3qNgJhSqgqpMRVKk12BhZFWij/9wQrLh8HCsBDRqoX5Xpsn0vAonOS/oRFvGWpx0R8Z0F
	 v67NmMrg0ZMnR2VAunbWujllPdeszHXZOjd7NGQf2VpxrTilXrPUZxaUznlGBzVEpIVWP
	 em7xZNoCvgEllS50X7HH+laqcWct2v/1HOrSDelb2i40u5NsmzLwUx4IA0b13Z2TIPNAX
	 XDE9cayH0sOtrCdhrSBmeCxgX8A3lbfro7TVj1pVCUbW98ly0YA2uYg7YimRhUANTIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998529;
	h=DMARC-Filter:Received:Received:Message-ID:In-Reply-To:References:
	 From:Date:Subject:To:Cc;
	bh=7ULs6kFe6nCSS6/2neQFMZlz5nGwnDgQN00Y1eoPHhQ=;
	b=rmitPQabgm+SDww4nj2v7BHHFfpXI5vUYow5XOWJrl1jJy0jRwjB/AB3ZYq5S43ChAjB
	 TuwKNTLfolhiE36bisgpQ+SrXXGi/VLUtBDZAFwh5uvLsyxG28RAa0N+DujU68DhiefYX
	 FmCPBKOyHCGGiWSwO8U4mZqy5xGkC+dQo8FpZvcBPeBZaWY9eXlTcRfrlyKEuAOHe6t9S
	 flzYHmd5vfVzNqr0dSaBUGyZCA6J4FcsNUXO5/RwtUpYFkKPaqoxluFn0XSlr+2ifXmsk
	 FDfbBz41La1NhHaMxunpJpMe0L1usFKSGepmVEf/jGn8O9uEsGykHFI2LumdF+pOmVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94485606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 10:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94485606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 745661C64;
	Wed, 18 Nov 2026 11:42:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3A5C06000333; Wed, 18 Nov 2026 11:42:00 +0100 (CET)
Message-ID: <34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:01 +0100
Subject: [PATCH v2 1/7] PCI/DPC: Avoid access to non-existent AER capability
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Darshit Shah <darnshah@amazon.de>, Jason Perlow <jperlow@gmail.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Downstream Port Containment does not mandate presence of an Advanced Error
Reporting capability, so a Downstream Port may support DPC, but not AER
(PCIe r7.1 sec 6.2.11.2).

In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
DPC event handling") amended the DPC driver to access the AER capability
without checking for its presence.

This did not cause actual problems because in March 2018, commit
4e5fad429bd1 ("PCI/DPC: Do not enable DPC if AER control is not allowed by
the BIOS") had seemingly inadvertently prevented instantiation of a DPC
port service on AER-incapable ports.

However in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
"pcie_ports=dpc-native" to allow DPC without AER control") made it
possible to override this:  The DPC driver may access a non-existent AER
capability if "pcie_ports=dpc-native" is passed on the command line.

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
Changes v1 -> v2:
  * On AER-capable devices, infer severity from AER Extended Capability
    instead of Device Status register because the latter also logs masked
    errors (Sathya).
  * Fix storytelling in commit message because 4e5fad429bd1 changed
    behavior, not 708b20003624 (Sathya).
 
 drivers/pci/pcie/dpc.c | 45 ++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..d02cbbbe3143 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -238,19 +238,35 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 {
 	int pos = dev->aer_cap;
 	u32 status, mask, sev;
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
-		info->severity = AER_FATAL;
-	else
-		info->severity = AER_NONFATAL;
+	/*
+	 * Infer severity from AER Extended Capability if present, else from
+	 * Device Status register.  The latter cannot be used on AER-capable
+	 * ports because it also logs masked errors (PCIe r7.1 sec 7.5.3.5).
+	 */
+	if (pos) {
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
+		status &= ~mask;
+		if (!status)
+			return 0;
+
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
+		status &= sev;
+		if (status)
+			info->severity = AER_FATAL;
+		else
+			info->severity = AER_NONFATAL;
+	} else {
+		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
+		if (devsta & PCI_EXP_DEVSTA_FED)
+			info->severity = AER_FATAL;
+		else if (devsta & PCI_EXP_DEVSTA_NFED)
+			info->severity = AER_NONFATAL;
+		else
+			return 0;
+	}
 
 	info->level = KERN_ERR;
 
@@ -275,7 +291,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		    aer_get_device_error_info(&info, 0)) {
+		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
 			aer_print_error(&info, 0);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
@@ -353,6 +369,9 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
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

