Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2C81724
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532716; cv=none; b=HVwz2l+q65gsIruE0AhjJtipq9iwriek0UYoEyyUUuUU//sKuw1fgCOIv+oakW3jBsqcoT8nWP5+5e2qqWHVTStOdssHmIhARqhfTkEDBUnbUYuscbf6wbZ6YOXecHsvhUKfaanGsNwyPZPOAyfAJ4ZFN6+dafK7H6ch4JtMzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532716; c=relaxed/simple;
	bh=brlG8DUoHYqfs/MPnGQVuoYdzVP2tfYdlUMfLUr86Xo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=X7jVIZlucSZDMj/+/wr8X46Z4XzSVaE7tUOQy/wBzhwXXvYQshypjljZyJ9Ctd5UagESzNFnEMNWENoh0DJ9gCV8oL6VjKi4AaLg/kk/fvZoPkyRZsRUqPiAkScc7PYqeTCI83PVUpw2YJw7faraiod+Vf41Gf8KMBDRp8GmH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 1095670A0;
	Sun, 27 Sep 2026 20:11:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F0AA9625294D; Sun, 27 Sep 2026 20:11:45 +0200 (CEST)
Message-ID: <c7048e7dafe470f1f85709169c31b5aafe7ad59f.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:03 +0200
Subject: [PATCH 3/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Yury Murashka <yurypm@arista.com>

pcie_do_recovery() only clears the error status bits of an error-reporting
device if recovery succeeds, but not if it fails.  (E.g. because reset
failed, drivers are missing pci_error_handlers or those handlers failed.)

One undesirable consequence is that the AER driver may subsequently
identify a wrong device when searching for error-reporting devices in
is_error_source(), due to stale bits on an unaffected device.

Avoid by clearing error status bits on recovery failure.

Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com/
Signed-off-by: Yury Murashka <yurypm@arista.com>
[lukas: drop cmdline param, rewrite commit msg, tag for stable]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/pcie/err.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index d77403d8855b..cfcfc7e4f10d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -284,6 +284,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	return status;
 
 failed:
+	if (host->native_aer || pcie_ports_native) {
+		pcie_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
+	}
+
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
 
 	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
-- 
2.53.0

