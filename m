Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999179;
	b=fM/ma/kgcuT2A9H6z15lgvHExh4ZUsRSJ79DiT/+W5M6Y3zAZZsJ+mWzqU2VhpShdLWK
	 Z53hI28Epd8x9N9aTHF59wW/NOzGzFd1QOOsyAcVgQE933iWXkJqhvg3sfgHW4/hWzg0/
	 RAjZensN0YWjf0GhSzDyQb+OMngtiuGKO/L64cCiZbCtL8Opgv7OjqIyVaiIv9gnWv3Oc
	 JT162AitwxMWJCDIQ9S6+eiO4L7VGD8K8d68TMAs5dBF8F6dEJAKu/J8vUgjAdiiy6OvB
	 In3aX17XkpeEN0rTDgkZTQLbDD62BnsGSSHcHeyao57R1muyQZRFkqcPfxHdJqFAvcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999179;
	h=DMARC-Filter:Received:Received:Message-ID:In-Reply-To:References:
	 From:Date:Subject:To:Cc;
	bh=xFd4QcaJAILIr1wan3gcR+j7Yhd7/dWnbfc57Nzs0UQ=;
	b=N2FZArSvA3JmBZ/g7dey6maNqtgS+boEHXdj9QC9NlRC7CeXTcSnkQF+G7zjYeWahtvM
	 vuevQ5qkh73kpmiyemnO3N/FDVYAu44Zm7yhE5rDUu+7Wyauo2tfNGS6NSRoSszDCX8Gl
	 n6vfLHJdClbX0XJFX0djd44zBKHzbr4WXKVx46mhiGmT3Mp8Mwh8XBfVPe+WBbsGHRtuj
	 rKwJGvlRXTbLLrAA+friztKgKjNLu8spygwjhtuJDkDXEO2dSEe1xpqRbP2eWWQ4nfSRa
	 9smp8AZssd6+QrSG1OJXHW2T+7qMgviT+N0p+VuQ+oze0VVEuHPEXahDh6tR2szLcUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DA606A32A
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 10:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 793DA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 3F15235CF;
	Wed, 18 Nov 2026 11:52:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3B4C06000333; Wed, 18 Nov 2026 11:52:57 +0100 (CET)
Message-ID: <c16f4a8b76745b03f3e90d6056c5ba6d092c947d.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:05 +0100
Subject: [PATCH v2 5/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
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

Drop a superfluous call to pcie_aer_is_native() from handles_cxl_errors().

The call is superfluous because the function is only called from:

  aer_probe()
    cxl_rch_enable_rcec()
      handles_cxl_errors()

...and aer_probe() is only invoked if an AER port service was instantiated
in get_port_device_capability(), which is conditional on:

  (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
  pci_aer_available() &&
  dev->aer_cap && (pcie_ports_native || host->native_aer))

...and the last line of those conditions is equivalent to
pcie_aer_is_native().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer_cxl_rch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index b480dad8bbf4..dfcedb7d277d 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -87,8 +87,7 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
 
 	return handles_cxl;
-- 
2.53.0

