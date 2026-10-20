Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520372;
	b=yDySMQeThYEEXvNHzSAK2JOAQl7p7geYMkYBJUcz2yibZGHzlYytL9KJAYvURcMXEvIU
	 OBpSSKwSyafDq7BmRqEqbOE0tbu/uDOaJPM1MAr8oiNbItFFWVh9JHeHunF97shwUfJ1z
	 Tu4UfYkefQh9QC0OI3MVooMxD+eMr7D6EVyoEznnv2k/Gdsz8ahzK5d8VLoAGuu2gIJ28
	 P+7cY/sL0hnvUp+/80Xr4loqGPv0zj/kkeuKtlvNgeHFGS7a8zmc/9tO4JNufnekuejCg
	 f7+gfOxZUY3JYvqbYzSpwm9g+v70aNtLdQXzjhLIAvE361/8axwm76o1zUTXupr6HMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520372;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KfUqdA6x+a+aeW1vcE32ccAPw3wvWBZd45BG+NNu4gY=;
	b=TWduAoiptLLD5GZIxVWGIZ2bv7u6DOj1TVLsfBqWilTntzEFUOgv2jqkSmQKXwXMRXpu
	 KzdzCdU54XOXZ9KrtEpNg2uiJgGlGyjdefQIWIfeEuLFbZHnLViAhW65onuJ98GXoDL6z
	 6ulfmXTjL7IH1DxpxVm+/6OdpzqSfqiar9qbMvBTSnvG/6vmlzIDCYAJER9wx/BOGAjz5
	 MghLsxBs0JLdp/2zkbsAEmeoVtRVzXQA4QBIIQZ8ReftW2Q1MAnKwK9dg9D75WRnt6zYM
	 shZ5vrvL5yibyPyn81NMd5CYYO2h67QBp00xFnx+bvSmFyZLp0WY1TU2yA2zYInptrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GYJXxHys;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DF60A3810;
	Tue, 20 Oct 2026 18:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C01DF60A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GYJXxHys
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792520372; x=1824056372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xrmY3On3SUaPiTmjJm8no6amlLfZLQFd7Jplxq/8MMw=;
  b=GYJXxHysrPygG0n/cCRPU+ijJYobG0vMhxY1/CABQexd6udUpJ+Dwl0y
   1Pcu+z3xmJMcB9kGw+Ht5lJXjUtIrY4jckauuk6fTV/uO8PHLE8AZJQax
   yWbsfjp4qTqKkorPiNK9IPGA+doWN7NC9KIiAE5DfjSn9mZpjfZlg81zq
   oPGz5dLs60KMlvNJNxwuldVb0fdpR1VyEtBkERNeuwbYkDi2lGm+zU5I2
   9+fXwS4IfUdXzz549OdsvhagH8owxmxcg7uAZKIy8LFe/kLMOoHF0S+ba
   zG2l03msdNaccDEIeHdr6091xl/HYuGmiz6/t4LarQLN5E0ac7FweXJ/W
   A==;
X-CSE-ConnectionGUID: X9MtjV6aTtaTdB+cXkWyiQ==
X-CSE-MsgGUID: pV+ERTaIQp2EYfDC/RxnEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1119653"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1119653"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:19:29 -0700
X-CSE-ConnectionGUID: fqHd6TO7RUuZcWQGHI0Yhg==
X-CSE-MsgGUID: t0d71XRFTNWO1N+gFB/dGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3283603"
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
Subject: [PATCH v2 0/6] PCI/DPC: Decide DPC ownership with host_bridge->native_dpc
Date: Tue, 20 Oct 2026 11:19:17 -0700
Message-ID: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

The series depends on:

  - Three patches from v15 of "Simplify PCIe native ownership", merged
    into pci/portdrv.  They fold "pcie_ports=native" and
    "pcie_ports=dpc-native" into the _OSC control mask, so native_dpc
    already reflects the command line.

    https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=portdrv

  - Two DPC patches from Lukas's "Error reporting for AER-incapable
    devices", which are included here directly as patches 1-2.

    https://lore.kernel.org/r/ae05fe2df3a3182594c4a9638daba1c72cf40358.1790531238.git.lukas@wunner.de
    https://lore.kernel.org/r/2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de

Patch 1 keeps the DPC driver from accessing a non-existent AER
capability.

Patch 2 drops the AER ownership check from dpc_probe(), so DPC also
works on ports without an AER capability.

Patch 3 removes CONFIG_PCIE_EDR, which was another knob in deciding
whether to request DPC control in _OSC.

Patch 4 stops requiring pci_aer_available() to bind the DPC service,
since the DPC driver does not depend on MSI or on the AER driver.

Patch 5 requests DPC control only together with AER control, as PCI
Firmware r3.3, sec 4.5.2.4, requires.

Patch 6 binds the DPC service on host_bridge->native_dpc and logs a
message when the OS assumes DPC control that _OSC did not grant.

Changes since v1:

  - Include Lukas's two DPC patches instead of depending on his series
    (Bjorn).

  - Add Rafael's Acked-by to "Request DPC control only together with AER
    control".

  - Refer to "PCI/DPC: Reinstate support for AER-incapable ports" instead
    of Lukas's series in the native_dpc binding patch.

v1: https://lore.kernel.org/r/20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com

Kuppuswamy Sathyanarayanan (4):
  PCI/EDR: Remove CONFIG_PCIE_EDR
  PCI/portdrv: Don't require AER to bind DPC service
  PCI/ACPI: Request DPC control only together with AER control
  PCI/portdrv: Bind DPC service based on host_bridge->native_dpc

Lukas Wunner (2):
  PCI/DPC: Avoid access to non-existent AER capability
  PCI/DPC: Reinstate support for AER-incapable ports

 drivers/acpi/pci_root.c    | 26 +++++++++++++++++++++++---
 drivers/pci/pcie/Kconfig   |  9 ---------
 drivers/pci/pcie/Makefile  |  5 ++++-
 drivers/pci/pcie/dpc.c     | 31 +++++++++++++------------------
 drivers/pci/pcie/portdrv.c |  7 +------
 include/linux/pci-acpi.h   |  4 ++--
 6 files changed, 43 insertions(+), 39 deletions(-)


base-commit: 4fe37866b0d92cdc45b62954a76489a9d9f8bd73
-- 
2.43.0

