Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025842;
	b=gkmLaMg4HmeL25ZeztfaQJbobj28EJF42vVDLP9ObRXCVOadRcH2xFlpA1npftiBwB+p
	 psQmd5ZXlPvl+thuvm9LWdHhSEqmylQrUgApa0NPt9cS3YnA0utQOHH9QZ9OWPaVIJnHe
	 qLacVrrbG6gb5qQsyXNMX87hpoFZrtRoD1FvlIl0jHrDJxscQrKTr1iUl/+R4QsRmpP/z
	 sBpAUjbS/bnoD/+UFDorHAT0K+NbiQvLdyhjcpEbOXgDwxhk5HvEPQbcMVf+0qSSxqdt9
	 3u79+0/bCxgSnhwFRPWqSKIh+SioeqLzk6PKD+8ZBNSxXyTX7T6L13lHg7sg9MagS8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025842;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PbFLxNHjDnaUS0KL3r5kObCQqqZERx9HU4X7ztNYR6Q=;
	b=uSawyjp17zm1YjaNM9e2x5fcZgJ46CdjOxH0uaLJYjXZwtbiFM+WaCkrarY0o4nx1vjN
	 kWeB/usN94C60OG3YCO4CHfPxFtpPtIDN9/1lv9bhSptWhgZKyqXRUNrFJXuvMBoztYRq
	 T7Gn7fHV1a1XE+zGYY37meodLIQWsUw70O3pB8rgdP+t2ypARIX5AFzx+wTAWmuqomXXQ
	 yLxdOn/yNBr8bxU7d8fzV8BqnuvHPveI1eFX3sxxtXtk8UATtmN9SXuGHLH8LdBfcPoIK
	 gISv+lVE0+lT0wISISYR5cWuxZfSOqaRvdu/D4OSkGNK21xdJ9Z33mM7UCy38GBR+uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T2EoKEqZ;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88596606A32F;
	Wed, 18 Nov 2026 18:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88596606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T2EoKEqZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795025842; x=1826561842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BB8Sidxy7tdBD0g99PmK8mzdJjQX6+rwLLTFK6AaG0g=;
  b=T2EoKEqZToejj99u+lHAAhkAJWzybts/kdEs49zI6165O1uaMLrwpVXZ
   VOSPSl+Ri9vcMILUmHSBHV7MRa9YN1cTixTFvru/MphW+Z5NYLkt1HPrY
   Klk+wJhYbM65+eFMPiDDuj9K7XO0A+YpsT3yQiR0R0WQ9ncEW8Vqb7cU6
   /9CKe2dphPe3T9bkzDoogsqXc2zTjxTod+GU92hzscxHmCwZ+yK2pIiyI
   PifT/cEmGbgprnujXmXqiV6V3A8IcSBl1yWgWWwHvpd5gXsVQCCLF0frE
   Q/Rml2+roB+K3D/FVd/nxAHpp9wTXEqMQxbt1v18OaWfildQZ+AC1ikkJ
   w==;
X-CSE-ConnectionGUID: ptnbU6oJTz+iNgICsrO+dQ==
X-CSE-MsgGUID: TUKBn/DBSy2sj8V2EQFBzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3744933"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3744933"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:20 -0800
X-CSE-ConnectionGUID: 6AOb6tGyTwWZiinje3dcVw==
X-CSE-MsgGUID: JTzWZnuFSnCifa+0vr3zbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10087018"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:20 -0800
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
Subject: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with host_bridge->native_dpc
Date: Wed, 18 Nov 2026 10:17:12 -0800
Message-ID: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

This series makes host_bridge->native_dpc the single decider for whether
Linux uses DPC, as Bjorn asked during the review of "Simplify PCIe native
ownership".

  https://lore.kernel.org/r/20261001221408.GA2731929@bhelgaas

Today the DPC service binds on host_bridge->native_aer, AER availability
and "pcie_ports=dpc-native".  host_bridge->native_dpc is only consulted
by pci_dpc_recovered().  After this series, native_dpc is the end result
of everything that decides DPC ownership, and portdrv binds the DPC
service on it.

Patches 1-2 are the two DPC patches from v2 of Lukas's "Error reporting
for AER-incapable devices", which are included here directly.

  https://lore.kernel.org/r/34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de
  https://lore.kernel.org/r/58d8a99cc6c2ecba6dadc450ecb4501d47816732.1794997749.git.lukas@wunner.de

Patch 1 keeps the DPC driver from accessing a non-existent AER
capability.

Patch 2 drops the AER ownership check from dpc_probe(), so DPC also
works on ports without an AER capability.

Patch 3 builds EDR whenever DPC is enabled on ACPI, so CONFIG_PCIE_EDR
is no longer a separate knob in deciding whether to request DPC control.

Patch 4 stops requiring pci_aer_available() to bind the DPC service,
since the DPC driver does not depend on MSI or on the AER driver.

Patch 5 requests DPC control only together with AER control, as PCI
Firmware r3.3, sec 4.5.2.4, requires.

Patch 6 binds the DPC service on host_bridge->native_dpc and logs a
message when the OS assumes DPC control that _OSC did not grant.

Changes since v2:

  - Pick up v2 of Lukas's two DPC patches.  Patch 1 now uses the AER
    capability to find the error severity when the port has one.

  - Keep CONFIG_PCIE_EDR as a hidden option instead of removing it, and
    remove the pci_dpc_recovered() check that becomes dead (Yazen).

  - Fold the PCI Firmware spec reference into the existing comment in
    calculate_control() (Yazen).

  - Shorten the comment in acpi_pci_root_create() (Yazen).

  - Rebase on v7.4-rc1 and add Reviewed-by and Acked-by tags.

v2: https://lore.kernel.org/r/20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com
v1: https://lore.kernel.org/r/20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com

Kuppuswamy Sathyanarayanan (4):
  PCI/EDR: Build EDR whenever DPC is enabled on ACPI
  PCI/portdrv: Don't require AER to bind DPC service
  PCI/ACPI: Request DPC control only together with AER control
  PCI/portdrv: Bind DPC service based on host_bridge->native_dpc

Lukas Wunner (2):
  PCI/DPC: Avoid access to non-existent AER capability
  PCI/DPC: Reinstate support for AER-incapable ports

 drivers/acpi/pci_root.c    | 19 +++++++++++--
 drivers/pci/pcie/Kconfig   |  8 +-----
 drivers/pci/pcie/dpc.c     | 58 +++++++++++++++++++++-----------------
 drivers/pci/pcie/portdrv.c |  7 +----
 4 files changed, 51 insertions(+), 41 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

