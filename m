Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025844;
	b=h7x+0ROHorP+g3Oz1yvpWaRHGOud8NrsstpNmrtVR+dYQZ8tRPrv0XtyEkIOVjOk7nDR
	 uCO4UpMENa8vOeZYXMz3THRvo1H0+yEgopvxO+po8Enm0IXs3o03srnZ0sFEknbQt1puQ
	 JrMtCLEpxosgTS0LSTgD/Lymmc1GPGaPAiRwTJQCPGKi6qvlRCdUlzzdl/qb3Uw1ffZL3
	 KV/ExJrVzFNqIWVhDutfmFOLbrHe9QcGiGxUoukvNgNJHcmoVl4QHUqH4o9gU8SIlhyoo
	 ZcJo66sTKXb4FnyE/xjRwfl6g3u2aIGqQL/zcLeUFjbQ9B3Ajbkuv2lNc3ETPRudjSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025844;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MMsfqPvR12WGxbAM1+zQ9ISGHmPP0STkOaLawvhk5lQ=;
	b=OKAgbh1frtxCO2BX8Lpf2MicL29DeNnVPEqJnvehXLyCf4sSJsNiFlJ81r2rGI+m5t68
	 vCLh5E2TPLN2+j1uJCAktfKNkXurZ05w21jyDXGTN8WhcutaMQmpn1lfoo56jOTFcS0+0
	 1OYbmhN96PevBPHrwKfRG2mH848mzyd188tMgKVbwTOy51WKswciwis43PiPh0878rCz6
	 ME17+EPebmBDQIcmQJVCmjOkReWe9sqAaAjSixXpJwm1w+7Qv2gO6cSdHIXNinkWEBUOg
	 1h1InnxHYhGvJrJxlEzP+r0oKeyDxwasQtmTNDE2uGYHGlSAieMFXecJQg+/3wcvyNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iDNgHf7T;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F760A2629;
	Wed, 18 Nov 2026 18:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6F760A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iDNgHf7T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795025844; x=1826561844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0sXMZf8592dgzoRi6xFTyvu6e00/fbNrHp8rT2TzRbo=;
  b=iDNgHf7TfKXMLLQgOQBEdIKnm4fa+42C3DbgI54XP9KaY6fmUG07NRY6
   qqNQ2bgp+2C+9+lN320cn+uD1ZtrFFIeRHop39Myz0TnESu3vJMrsRQWX
   WoQ8q5LhrFWkAAlDmqz5k+JOvXFbE8kLBcssmhCbG9u+5gCMxFZvXVQJa
   jwMFFBkr/DCybgzZELBCP8B/w+NGMBiysUJDsJb/cs0bZI3Nqpv1KzFOL
   dFY8yMwPvVcDBaqhz/Hi8qppEGBuEC56J7c8mdtMRYL3NIfxmz2UwAT6G
   f3w4SlZ4ORfCj6b8z8YXFTD4k+4MlpvUwjn0aRgjxIhYYpva8ld+yksuG
   A==;
X-CSE-ConnectionGUID: qMkWJgD5TJyMUsTmjrPB2g==
X-CSE-MsgGUID: DORfKbP5QZiB3lsNmXSn8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3744979"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3744979"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:21 -0800
X-CSE-ConnectionGUID: rV5X5IGKT/SGzjRcJjBn+w==
X-CSE-MsgGUID: mWq38FVVQlmQ0H0I5PCJbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10087029"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:21 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] PCI/portdrv: Bind DPC service based on host_bridge->native_dpc
Date: Wed, 18 Nov 2026 10:17:18 -0800
Message-ID: <20261118181718.3907441-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

get_port_device_capability() binds the DPC service if the port has a DPC
capability and either "pcie_ports=dpc-native" was given or the OS
controls AER.  This repeats decisions that are already made elsewhere.
It also ignores host_bridge->native_dpc, which is meant to say whether
the OS owns DPC.

Make host_bridge->native_dpc the single decider:

  - In acpi_pci_root_create(), assume DPC control whenever _OSC grants
    AER control.  PCI Firmware r3.3, sec 4.5.2.4, requires platforms to
    retain AER if they retain DPC.  Put the other way, firmware that
    grants AER does not keep DPC.  PCIe r7.0 sec 6.2.11 recommends that
    the OS link control of DPC to control of AER.  Commit 97ca178c899d
    ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
    relied on this link.  Keeping it means DPC still works with firmware
    that predates the _OSC DPC control bit.  Such firmware grants AER but
    masks DPC.  The OS cannot tell such firmware from firmware that
    retains DPC on purpose, so log a message when it assumes DPC control
    that _OSC did not grant.  Only do this if the OS requested DPC
    control, i.e., if CONFIG_PCIE_DPC is enabled.

  - "pcie_ports=native" and "pcie_ports=dpc-native" are already folded
    into the _OSC control mask, so they are reflected in native_dpc.

Then bind the DPC service if the port has a DPC capability and
host_bridge->native_dpc is set.

The only change in behavior is for firmware that grants DPC control but
retains AER control.  PCI Firmware r3.3, sec 4.5.2.4, does not forbid
this.  The OS now uses DPC there because firmware granted it.  Since
"PCI/DPC: Reinstate support for AER-incapable ports", dpc_probe() no
longer requires AER control.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes since v2:
 - Shorten the comment in acpi_pci_root_create() (Yazen)
 - Add Reviewed-by from Yazen

 drivers/acpi/pci_root.c    | 13 +++++++++++++
 drivers/pci/pcie/portdrv.c |  6 +-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 510943649b41..b08261b6372f 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1054,6 +1054,19 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	ctrl = root->osc_control_set;
 	ext_ctrl = root->osc_ext_control_set;
 
+	/*
+	 * Firmware that predates the _OSC DPC control bit grants AER but
+	 * masks DPC.  Link DPC control to AER control, as PCIe r7.0 sec
+	 * 6.2.11 recommends.
+	 */
+	if (IS_ENABLED(CONFIG_PCIE_DPC) &&
+	    (ctrl & OSC_PCI_EXPRESS_AER_CONTROL) &&
+	    !(ctrl & OSC_PCI_EXPRESS_DPC_CONTROL)) {
+		decode_osc_control(root, "OS assuming control (AER granted) of",
+				   OSC_PCI_EXPRESS_DPC_CONTROL);
+		ctrl |= OSC_PCI_EXPRESS_DPC_CONTROL;
+	}
+
 	/*
 	 * If the user specified "pcie_ports=native", use the PCIe port
 	 * services regardless of what _OSC says, i.e., proceed as though the
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index b77680fd3b75..f1beb440a3dc 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -258,12 +258,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 		pcie_pme_interrupt_enable(dev, false);
 	}
 
-	/*
-	 * With dpc-native, allow Linux to use DPC even if it doesn't have
-	 * permission to use AER.
-	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    (pcie_ports_dpc_native || host->native_aer))
+	    host->native_dpc)
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	/* Enable bandwidth control if more than one speed is supported. */
-- 
2.43.0

