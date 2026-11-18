Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999295;
	b=gCllNZhrA6jVrQ0AkEND5gxwfRVP0jTi9MAECrFK+4tbk1MjoZ23LGzdpr0OylCQEWbc
	 N8hXL2ozhjB89Si+m75bq8XVsAunoBiqGhsjPSPmyC4f6ryz4aRIYbpbeXmOX8fpFWMAj
	 hHaPspZSTvVI3EsP/ttDkkA3bv4HhXC/D0vIhqygHM6bPW6GWwvIbZz8ES4wkBqWPxJ7I
	 WSWgwGywNaxqGIIFZDpMInqf8SNqsDHr8I+g1jUT5AhkVssGPKmxgW54ukchaCs9wb4xO
	 u6Vd+0Fc8WTb++DV/ynWuXmCzBEl2xbI7yON0A6FgWX8FunQwl4ms6iGN3tlVo/PdPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999295;
	h=DMARC-Filter:Received:Received:Message-ID:In-Reply-To:References:
	 From:Date:Subject:To:Cc;
	bh=MU5tVZLUEvK9QUdrpLV2yQsfNmaL2MNnbAVNzb9N48o=;
	b=VC63DW0ibPKlm+14jaSwSr7MW7Pbm1Dja6+4a+yptAP1zBdTT9BdXkK/y8jkFoaSNfdh
	 4JyfRwJVAJmKxk5NzcgtyGIgM6aIujT4X0Tj6nPhk078+eOsgWRJeDncOHxrQktFedsqX
	 DDs2jBKVxnQc1kChy7vlezxIKMDJN3yWeGOREYL1p8h971TEdI+6ivguH4zU3m7b8LJx2
	 XGDwfDdNkhA231SpApwflL68Gs/hKEetAZLI+mUNlVy4Re+2a8LxA/N/ay3f0S4ASmdOt
	 WHHNI58i51N2r0jOpkwZTBbO9MUjgFJoMO3v/ifNynBPCxtHbN2wTbQjzktI3QzVVSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0D606A330
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 10:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E0D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 38C124154;
	Wed, 18 Nov 2026 11:54:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 138026000333; Wed, 18 Nov 2026 11:54:53 +0100 (CET)
Message-ID: <df17268a88d7099c34098e5c3670a493801e9c59.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:06 +0100
Subject: [PATCH v2 6/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
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
Changes v1 -> v2:
  * Amend kernel-doc of pci_aer_unmask_internal_errors() (Sathya).
 
 drivers/pci/pcie/aer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 51cf2ff8c85a..9bb8e2127849 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -263,9 +263,6 @@ int pcie_aer_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
-	if (!dev->aer_cap)
-		return 0;
-
 	return host->native_aer;
 }
 EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
@@ -286,7 +283,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
-	if (!pcie_aer_is_native(dev))
+	if (!aer || !pcie_aer_is_native(dev))
 		return -EIO;
 
 	/* Clear status bits for ERR_NONFATAL errors only */
@@ -305,7 +302,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
-	if (!pcie_aer_is_native(dev))
+	if (!aer || !pcie_aer_is_native(dev))
 		return;
 
 	/* Clear status bits for ERR_FATAL errors only */
@@ -1288,7 +1285,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Mask registers.
  *
  * Note: AER must be enabled and supported by the device which must be
- * checked in advance, e.g. with pcie_aer_is_native().
+ * checked in advance, e.g. with dev->aer_cap && pcie_aer_is_native(dev).
  */
 void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
-- 
2.53.0

