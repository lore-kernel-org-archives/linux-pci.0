Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998443;
	b=jO6yf3CfGzIiMstqtugeNe9KJNEEebArYqPEtc54I1Irs7WdvvK8pjS+4k/nYkNfn3Uj
	 aJdMdY2KRMSnc+cvi6T7X/N4cQOHggWJeMi42XS2tQ71QlaYg4KoIJwyxMVLed1eehL5N
	 1oUUCNPnAZ6S+RgWRSfwsW89HXk9cxR3mb2/oHGGIUJ7mdwRxJl1szJatBs1Szv2tm4/Y
	 ZQV5i1C1vamnqhKkbCeIVAyIFkdbs0mU+SPmfcpsfr45DAGrPtjLbE9GcscHh737fW7Kc
	 ac6LVXEGVTIRdrQ5GAuCCc6W6f7no+peppuS9tK14hsdwABeDSQPbX4B6U39qPfQ0Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998443;
	h=DMARC-Filter:Received:Received:Message-ID:From:Date:Subject:To:Cc;
	bh=lJRXZTaLABiQOC03YvgzkJOyiEumqmL4Ha8lE9HKd2U=;
	b=BBm8vV83OnRHtotvPo1Y4JbU6BAYgI06oip2IHIP7CcVAzSu13nZzJUw+sHBH7KlK3HF
	 08jItR342JNfitZ2ub9SWBUytTBmm5t3yAm5DDS1l2sjR3wEBO8TPtcn4lYC61tZ2QG4d
	 /ND6Lj0HaAwjqaONEKnUxLCBDKV0CF28xiMURULwZYkdY8p182HKjl4dgRC4eTsbxIVQz
	 Mhih8a0cbO2e4xlcGbZ6XDX+VcpJkKgXy/89GbjPAFSRAxlqhvN2TeDKCMXt/K+IAXCKm
	 nNOWGLX6TLKfvBtKpVmevl1A89Tioj3U4s2rOMCws0wBnDKgqawUwgquLknXTzkSBFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70D606A320
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 10:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A70D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 3C4CD3438;
	Wed, 18 Nov 2026 11:40:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 361D4600034D; Wed, 18 Nov 2026 11:40:39 +0100 (CET)
Message-ID: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:00 +0100
Subject: [PATCH v2 0/7] Error reporting for AER-incapable devices
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
The kernel used to support this until 2018.  It is hereby fixed because
it eases introduction of baseline capability error reporting in the
subsequent patches.


Changes v1 -> v2:

* Patch [1/7]:
  * On AER-capable devices, infer severity from AER Extended Capability
    instead of Device Status register because the latter also logs masked
    errors (Sathya).
  * Fix storytelling in commit message because 4e5fad429bd1 changed
    behavior, not 708b20003624 (Sathya).

* Patch [3/7]:
  * New patch to clear error status bits more selectively (sashiko).

* Patch [4/7]:
  * Clear Fatal Errors as well on recovery failure (Sathya, sashiko).

* Patch [6/7]:
  * Amend kernel-doc of pci_aer_unmask_internal_errors() (Sathya).

* Patch [7/7]:
  * Convert AER severity to Device Status bit with new severity2devsta[]
    array, instead of renumbering AER severity (sashiko).
  * On entry of aer_get_device_error_info(), clear info->mask and
    info->first_error (Sathya, sashiko).
  * Emit "(no details available)" message for AER-incapable devices
    as well as for devices whose AER registers are deliberately not
    read on Fatal Errors (Sathya).
  * Amend commit message to inform that System Errors may be raised
    by AER-incapable devices if they have no AER- or DPC-capable
    port in their ancestry (Sathya).

Link to v1:

https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de/


Lukas Wunner (6):
  PCI/DPC: Avoid access to non-existent AER capability
  PCI/DPC: Reinstate support for AER-incapable ports
  PCI/ERR: Clear error status bits more selectively
  PCI/AER: Drop AER native check from handles_cxl_errors()
  PCI/AER: Move AER capability check out of pcie_aer_is_native()
  PCI/AER: Enable baseline capability error reporting

Yury Murashka (1):
  PCI/ERR: Avoid stale error status bits on recovery failure

 .../ABI/testing/sysfs-bus-pci-devices-aer     | 26 +++++--
 Documentation/PCI/pcieaer-howto.rst           |  9 +--
 drivers/pci/pcie/aer.c                        | 76 +++++++++++++------
 drivers/pci/pcie/aer_cxl_rch.c                |  3 +-
 drivers/pci/pcie/dpc.c                        | 46 +++++++----
 drivers/pci/pcie/err.c                        | 14 +++-
 6 files changed, 120 insertions(+), 54 deletions(-)


base-commit: 6d69eeae8966bc3bea0facbd550f45ef9de41cc4
-- 
2.53.0

