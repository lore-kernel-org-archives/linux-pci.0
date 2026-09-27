Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C72D0620
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532134; cv=none; b=KM6pQC1LgGXM2LIKaUseK+FssLVuL2BM9KKWcVV0cEmsF67Yczz3OUj9qNJ+BFYV/yG1BhNEssD+2/oVUhn2JUbr1nNaWY8nR0Y50Rf/USmQygkn27rmMYiPIp3ISSW4G6kyMOLNk3l8pIKE6Xqg0SwjoXR/Sh5vKTcneNRUzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532134; c=relaxed/simple;
	bh=cmcGevHOktaCpS0lp7cgN1F5aS+q31ecM0D6e9OxgqA=;
	h=Message-ID:From:Date:Subject:To:Cc; b=ttazn3AMuBa9bjk7XnSkU0Q5rRjLuQQqvLVPjmCZJDBNSAqjYLB5gddiYS8EdeKZ/eiX3q5o6rasqt7rbJdrB0GnRVWG/NqQ7b4VXVfSXNNAfU07y/V2htlJrwex4Wi2ZYgZqxa/1xMM5N8v8VJb8JRPRl1wCGyfOmQ+J6YV5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id E64391D03;
	Sun, 27 Sep 2026 20:02:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A341D6078B58; Sun, 27 Sep 2026 20:02:02 +0200 (CEST)
Message-ID: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:00 +0200
Subject: [PATCH 0/7] Error reporting for AER-incapable devices
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Bjorn suggests "the PCI core should do pci_enable_pcie_error_reporting()
independent of whether the device has an AER Capability":

https://lore.kernel.org/r/20260826212619.GA1566339@bhelgaas/

This is done in patch [7/7].  The preceding patches contain prep work.

For context, PCIe r7.1 sec 6.2.1 defines two error reporting paradigms:
AER and baseline capability.  The latter relies (solely) on the error
enable/status bits in the Device Control and Device Status registers,
which exist on every PCIe device.  The kernel has supported the AER
paradigm for 20 years.  With the present series, it gains support for
the baseline capability paradigm.

Patches [1/7] and [2/7] reinstate DPC on AER-incapable Downstream Ports.
The kernel used to support this until 2020.  It is hereby fixed because
it eases introduction of baseline capability error reporting in the
subsequent patches.

Lukas Wunner (6):
  PCI/DPC: Avoid access to non-existent AER capability
  PCI/DPC: Reinstate support for AER-incapable ports
  PCI/AER: Drop AER native check from handles_cxl_errors()
  PCI/AER: Move AER capability check out of pcie_aer_is_native()
  PCI/AER: Renumber severity constants
  PCI/AER: Enable baseline capability error reporting

Yury Murashka (1):
  PCI/ERR: Avoid stale error status bits on recovery failure

 .../ABI/testing/sysfs-bus-pci-devices-aer     | 26 +++++++---
 Documentation/PCI/pcieaer-howto.rst           |  9 ++--
 drivers/pci/pcie/aer.c                        | 51 +++++++++++--------
 drivers/pci/pcie/aer_cxl_rch.c                |  3 +-
 drivers/pci/pcie/dpc.c                        | 24 ++++-----
 drivers/pci/pcie/err.c                        |  5 ++
 include/linux/aer.h                           |  8 +--
 include/ras/ras_event.h                       |  2 +-
 8 files changed, 72 insertions(+), 56 deletions(-)

-- 
2.53.0

