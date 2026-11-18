Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999082;
	b=pEyWHp2kVQvBxYtwkmoMPJoqTBA80w5lJpWPV2YQw6PCm4tzJ2KMkwBG77Lw78vTMjXw
	 e+y1oOEVjDHH4LQo4LcOCJDF3VhIBo4p8Ezc+amkc1e9WuC1A24QyoovP/JeUC84rB4YO
	 Zm8UHkTQUinuPgDUD7AUIgjM5ET+xxoL94Pu/pj3QEXK6Yo3qDCW3cf5qlQx/I0c9cgbv
	 uaShFazldxYckvoz002WLf2O3S2aZ0Qd25DNQ1/ZZwJfVi9tLaYzPKmOnngLRYsaUWIQa
	 dsmhB8XAzEqrBI581glgxO+ItboN5S+Zci9ZmfbKHO6HkojvmJvLp1TiQ4rbV8p4zNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999082;
	h=DMARC-Filter:Received:Received:Message-ID:In-Reply-To:References:
	 From:Date:Subject:To:Cc;
	bh=pbcgXBgPca1t8250FLukur4Z8to4BVGD6thMY1PQV8Q=;
	b=hjB+AMTPrtWr7CDEb4Yi7xDTCQ//bq3+4EjYIsvaA6DUxh4aoPKwUviyDkRZpPTeedTD
	 coz4EePZ/8xMvXNVPfO9Cp0RpuGlzdmxwBAnoYpRaCFr5MJE3BY1LfSzYMuY/eHXvbakd
	 XRzdY+7P0LiW/hwP3bWRdjaCBmD7WXZuB5Q0N0iOOEV8A6Tie2GvRGRyv1cnRaTeOCFit
	 uoXjaf5b7E8FcpGV/TKfaogGtwWZvHtUq2Ilt8oLh5Rt7kHNRwt+bbZeYe1KJQ2HmflDg
	 75OkiUtSp8e6rp6bvIIHB7zGaWdzk08fwuHvPTq49k6uMJLUul/nsFx8VUerPn3Nv2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F6606A336
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 10:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 605F6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 85CD81231;
	Wed, 18 Nov 2026 11:51:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 69DF06000333; Wed, 18 Nov 2026 11:51:20 +0100 (CET)
Message-ID: <2d0191cb7b92da82302f9d37b859e28ee6c9c85e.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:04 +0100
Subject: [PATCH v2 4/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
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

From: Yury Murashka <yurypm@arista.com>

pcie_do_recovery() only clears the error status bits of an error-reporting
device if recovery succeeds, but not if it fails.  (E.g. because reset
failed, drivers are missing pci_error_handlers or those handlers failed.)

One undesirable consequence is that the AER driver may subsequently
identify a wrong device when searching for error-reporting devices in
is_error_source(), due to stale bits on an unaffected device.

Avoid by clearing error status bits on recovery failure.

If recovery succeeds, Fatal Errors are generally cleared by a call to
pci_restore_state() from drivers' ->slot_reset() callbacks.  If recovery
fails, those callbacks may not have been invoked or they may not be
implemented.  Hence clear Fatal Errors as well on recovery failure.

Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com/
Signed-off-by: Yury Murashka <yurypm@arista.com>
[lukas: drop cmdline param, rewrite commit msg, clear fatal errors]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:
  * Clear Fatal Errors as well on recovery failure (Sathya, sashiko).
 
 drivers/pci/pcie/err.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 24a8a8263c2e..a450146fb285 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -289,6 +289,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	return status;
 
 failed:
+	if (host->native_aer) {
+		pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
+					   PCI_EXP_DEVSTA_UNC_MASK);
+		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_clear_fatal_status(dev);
+	}
+
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
 
 	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
-- 
2.53.0

