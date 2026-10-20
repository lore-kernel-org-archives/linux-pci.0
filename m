Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520377;
	b=dslC2tRU9B3LZ8gtBk+04nFzHj030NHojdRavxgbXhHpd7xe25vkf0sa4KyRUDq+wOJf
	 58YMoSeRonkA8X/kLVaIP0fJmzxKU8IFlNrMkgC2Chu1BkVox4qswP3URHYAu5OfETRHs
	 yuaeAGE0rLn2rlAGyx7eiElj/W9y19vDB8CW8/HjzkGGq3uRa1Cyb4YZv6zDcWGnlxtkY
	 Fp1OGRLIYqb57iCBfXLK5xKd5xA+GhEfl2PEpcj+lC1NWHiRK1YVw0aEXukh2vvFCxS5b
	 R8gtp90HNYR+LwYnESRILLhHTuU7KH+IHYJJ+W7uecI3b2lMJxGzot54Eu42/qPPrHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520377;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2w5USolQI1OxcXxkFQr+PuqzB7QJ1VSZ3KqdxbbCMEA=;
	b=v3/p9EbShbTbBxvfCTDaeN4cKsYYmqc41az5csZPDV7XzDMGiCtMn7dne6aMXc4mvbrq
	 jdqG/UNo+gnZT3qH0xLrVpaJq4PpUvkPgunji0N9U6VYwe4JpqR2H2LZ/I6XkLTcxC45l
	 1ZQCH8hU+p1RXQ4nKR+Was83vwcxrJiCcjhWq0b33qzHA9j7DDjO0jqNj3cqATsfg6nny
	 FCl1ETQ8zQiZdqk5C0GW+vATRk1FxCbYmQSbmxV7v1LOBMSeWCqTC7nHQZF6GEDEQAYLj
	 6rGfEXELF/0bctkPZT+GpgVtvL8l0yC/GAB3YRwnMPalHnkLLJx8N9tdQN1NXKVmxLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a7W9nQ5u;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBEF60A3804;
	Tue, 20 Oct 2026 18:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DBEF60A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a7W9nQ5u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792520372; x=1824056372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wrdZYqgyZr10bvKBuIHWekho32wvbhmlfaidg0mzcew=;
  b=a7W9nQ5ucgg7/eQAqxZSNuY/zkvy6nuqZpoMEAo6C1yM19ukyucrktKh
   TzL8QNhcVPaPX0EQFmOsqrqBg0rjGCyhLz3jmERwBtnrjreBtstldqnWg
   rF9RgCbMvCaPDeoxHMSdDSbG2DwLCsSowecKvTg80MSD5SdFuoFgxOHsy
   aK/0t2693w2p90M+MOgX3eH9ZNoAwGLSK9IbYqt1DVXDpGDKDCxdwcTkb
   5QcpZcnh9JkaqsjmbokC2o3U77RtmBPYfEEU10sqWFmy4u6cw2F/HI0p8
   cbPBKeU2Gflod5DF5UOK133gb4i+BG4vu0iYW5gfWeMSiDEoRHIforHwD
   Q==;
X-CSE-ConnectionGUID: P7rt+bFISrW3zb/WZJTLNg==
X-CSE-MsgGUID: mWnmJSNlQl2LNumOeTszkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1119685"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1119685"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:19:30 -0700
X-CSE-ConnectionGUID: RphP8SMGTsyg9siSPOxh9Q==
X-CSE-MsgGUID: VT2tWqFESiq8DRcp6GX7cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3283608"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:19:29 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] PCI/portdrv: Don't require AER to bind DPC service
Date: Tue, 20 Oct 2026 11:19:21 -0700
Message-ID: <20261020181924.3003553-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_port_device_capability() binds the DPC service only if
pci_aer_available() is true.  pci_aer_available() is false with
"pci=noaer" or when MSI is disabled.

The DPC driver does not need either of these.  pci_aer_available()
depends on MSI only because the AER driver does not work with INTx
(commit 3e77a3f7895e ("PCI: Disable AER with pci=nomsi")).  The DPC
driver does not depend on MSI or on the AER driver, and it works on
ports without an AER capability.

PCIe r7.0 sec 6.2.11 recommends that the OS link control of DPC to
control of AER.  PCI Firmware r3.3, sec 4.5.2.4, requires the same for
_OSC.  Both are about ownership, not about using the AER driver.
host->native_aer and the _OSC negotiation already cover ownership.

Drop the pci_aer_available() check.

The changes in behavior are:

  - ACPI systems booted with "pci=noaer" or with MSI disabled, and with
    "pcie_ports=native" or "pcie_ports=dpc-native".  The OS now uses DPC
    there, which is what those options ask for.  Without them nothing
    changes, because the OS does not request AER control in _OSC, so
    host->native_aer is not set.

  - Non-ACPI systems booted with "pci=noaer" or with MSI disabled.
    host->native_aer is set there, so the OS now uses DPC.  An
    uncorrectable error that used to be ignored with "pci=noaer" now
    triggers DPC, which takes the link down and resets the devices below
    the port.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/portdrv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 32fc623dd410..b77680fd3b75 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -263,7 +263,6 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * permission to use AER.
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() &&
 	    (pcie_ports_dpc_native || host->native_aer))
 		services |= PCIE_PORT_SERVICE_DPC;
 
-- 
2.43.0

