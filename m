Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4803B0ADE
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532882; cv=none; b=tDjsFmOi3InDK049Yi3yTtO3MsB78hHqhg26PzxHbUVO9mE5FE8DALKD1RX+mYFbkXN6Go3GYrUDNLN8yxw9LT+jfIBt0xC06/Y5QM4Ii9gmP1Is1kZRQu2uvgE5jEX/+Iqd0+DvGfpXzE+j20YHbgx6OS3YBOK2OzY3tfkAU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532882; c=relaxed/simple;
	bh=UXhof8xCwO7B1GIUfFsP6sgYMDGExztTa7q9nTAGx6o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=jiolA8tNf3uACO1dGM5J1ug5OaaMrRXUpCVP8B9cMXUFX+kFfEcQGdeIvU9OzUm9RFhjoU6hfWBrS+LynsRPRwdbS8xvlqKhTfV1Q6QmB4X2FGgNmRTFtnX68rtWUOKx8TrB3XsyOPQ7J9YWFjeQ4XT8yGKJZ03LXU88pSL/e/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id BABB910DE0;
	Sun, 27 Sep 2026 20:14:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A6D43625294D; Sun, 27 Sep 2026 20:14:38 +0200 (CEST)
Message-ID: <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:04 +0200
Subject: [PATCH 4/7] PCI/AER: Drop AER native check from handles_cxl_errors()
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

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
---
 drivers/pci/pcie/aer_cxl_rch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index e471eefec9c4..9cc2d5749b9d 100644
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

