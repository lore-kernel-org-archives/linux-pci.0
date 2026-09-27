Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCFC41D11A
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532539; cv=none; b=FSyfqGEu2EeUSc1wkyig1snfpKFTB1mvz4wCUANEXeyQKS+t3DPyZ2o47OqAk32RvvH1B8J6qdb/FYMORNLkb2J9gRedGyBmC9BM0Ky1pKkCNg3503BhDroqIWawd5i+VuIO0LqAdQxEl44FauvC6xHB4n28ksl3XsEG2ZB4G44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532539; c=relaxed/simple;
	bh=6BBiEGEL7CXO9NAcz4OmHxB7wmiGgTimtGMpHJmyLkc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=KN7YcASSRyMToX4x2TKqxDkm9Pf8SpNVvc1zhdUYMpF1dubbWEiZLb5fgDnXLeow2EqPDpGTip65x2PpDMx+5uhY/PS2aIgUoksY9DsQ1fd3HplBeaD5j9x7LOswwbXWknOpTesgiaNAoRLXIKDORiLHv3sX1UuE9mLVjlNg218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 1B9045D3;
	Sun, 27 Sep 2026 20:08:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 55F68625294D; Sun, 27 Sep 2026 20:08:52 +0200 (CEST)
Message-ID: <2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:02 +0200
Subject: [PATCH 2/7] PCI/DPC: Reinstate support for AER-incapable ports
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

Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
ownership") seemingly inadvertently constrained DPC to AER-supporting
Downstream Ports by inserting a call to pcie_aer_is_native() in
dpc_probe(), which implicitly checks for presence of an AER capability.

Drop the call.  It is superfluous because it duplicates the conditions
applied by the PCIe port service driver when it decides whether to
instantiate a DPC port service (see get_port_device_capability()).
If the conditions are not met, no port service is instantiated and
dpc_probe() isn't executed.

The only difference between the conditions in dpc_probe() and the ones in
get_port_device_capability() is the check for the AER capability, so by
removing the checks from dpc_probe(), DPC is supported on AER-incapable
Downstream Ports again.

Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.8+
---
 drivers/pci/pcie/dpc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 793a799053f1..104ff2b91f1f 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -474,9 +474,6 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 cap;
 
-	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
-		return -ENOTSUPP;
-
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
-- 
2.53.0

