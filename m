Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D33783B5
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533035; cv=none; b=AvWVAzebprEayUl+Lo4aIpbce+B1zpU0etxJ9v7Tp8gTuexMeJkfeweEpfpRrbhFrvgjPKSkoe4qXsudXAXmVdDQY/PM7lhLUe1x78Sec6+uh0byKrZnDcTP61PqEVrnczn1TaiG2wnCILxwbOcxWnFTo4cFEzIAdB4Bo9Wn2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533035; c=relaxed/simple;
	bh=gSt4lfLy1l8BFj2i25GSWn1wtZuzSDHYV5N5PD/G0NY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=r1PjAZkl9s/yb3chgVllDN6Qtd8UmoKfcRm13RdpcFGKWsmXFud3bIOuQ2MB3tDJDNJRGmyX5GNdVh0PUP7XtIDQtbzT62RvFZRtG3Mj7SaJCijjtFpmdazA9jnPn3xRlKpi2QJP1P472xSpFhSB5+xasCMbqo4VOqe0X34cBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 03E09709F;
	Sun, 27 Sep 2026 20:17:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DE15F625294D; Sun, 27 Sep 2026 20:17:10 +0200 (CEST)
Message-ID: <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:05 +0200
Subject: [PATCH 5/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When firmware grants control of Advanced Error Reporting to the operating
system, that not only encompasses the AER capability, but also error
enable/status bits in the Device Control and Device Status registers
(PCI Firmware r3.3 table 4-6 bit 3).

PCIe devices without AER capability still support baseline capability
error reporting through these enable/status bits (PCIe r7.1 sec 6.2.1),
but the bits must not be modified unless AER control was granted.

pcie_aer_is_native() is unsuitable to check for control of AER-incapable
devices because it implicitly checks for presence of an AER capability.

Move that check to its callers (where needed) to allow using the function
for the imminent baseline capability error reporting.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..34a8eddc427a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -257,9 +257,6 @@ int pcie_aer_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
-	if (!dev->aer_cap)
-		return 0;
-
 	return pcie_ports_native || host->native_aer;
 }
 EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
@@ -280,7 +277,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
-	if (!pcie_aer_is_native(dev))
+	if (!aer || !pcie_aer_is_native(dev))
 		return -EIO;
 
 	/* Clear status bits for ERR_NONFATAL errors only */
@@ -299,7 +296,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
-	if (!pcie_aer_is_native(dev))
+	if (!aer || !pcie_aer_is_native(dev))
 		return;
 
 	/* Clear status bits for ERR_FATAL errors only */
-- 
2.53.0

