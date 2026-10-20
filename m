Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520373;
	b=Ku9idlZ5BwEBWTqJsZPswaTQ3fHZoJYuKnMcdcDzWv0NeSYIZbY4tlrGcAbkPLxBu6Cr
	 DF/jT7/zCA3yPYArkuZk3R3fHlPSMCWbDUh+T77VgwVbqjHwDYcMRvHhaCI+kUXCCqijl
	 aK818/mibm2+/+p/gErdytIxNKRC0V/1xpcYIIMNlGJv6sF20Y6loGv1Wk4j2qFBf5kj2
	 hGCky15GCk87Ik8s9wX6S5AVS/2hK9KT/cPW1rofWXiX+b+3Lw7s2IFPSqd4gQBSCyUNi
	 bGMaCbekCli1CVBSQM5tFxOR77JqwM4/b0OzPqxkxE3glDWGHIa5wzWKPo4lvKegsKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520373;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7cXcXagyDTRYiWsmw0C+I6wer3QJwg2iX14YlwEpp4Q=;
	b=a80KMYDYdkB7bxT7quD1H2RmeBXsIE9Hg3wRDegOyo4GrviuP+3AVxi3ZTKUJiiKB6Hv
	 VpWWAQ081qY53x2eWmZskPJ79TH8KSdCLyLTTnBo6uZfmVi2ZF5S/K3bC0de2Dj5s+nLI
	 SoH7JnfuT2lsLVqckvG9XRi25hJI32SE8FmkJE43b7UilCmYHUzHFzeKtZE3p8ZiKMD+W
	 BZxGSgdVJV7+9CT7mT6tZCq6syehHtfYzM/gJPO4Nj4bXLG5eaX2u2chEPLt0nhC+9G0f
	 SeHFBIZ2G896ItnTyYWRC4lwwRnQGHBs/UH3IyunI4fiuhQ5zC3BlbBPFxY22ft/k8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KtMAQ7t7;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24C60A381A;
	Tue, 20 Oct 2026 18:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D24C60A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KtMAQ7t7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792520373; x=1824056373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ZQ90ownXOSqYvb8K2HE1uQ5sEoGc2uCAIUHSUy5p/o=;
  b=KtMAQ7t785iWeEzcmKoVcLrnSqGZn3hqk2ZiiYr+MtiJNBGJT85cekUF
   ruHUUFCXJY1b+l1q/zdugYV75fWQ6cWZzzZO06ezwCi3AVnamlai0UQNq
   cvdzgmaLlpA3pQvbPTpoNEIJErbNCB57A2wFgT9rhyBN9dgvlt5R+tGLd
   kJ/aRvts9pqUNd514T7klpQzCXynrueMnARyr6ZysElT/KP3zei6ppXmt
   jmOy7aAs/WIYl8CGl8Ts1o0dJlMv4G8eJ2yZbsfDStDaRoreTrW7fBIxI
   7r8fP97yLLxVMy0uPzXtQvJ/6RNleCiDJUhWrIM9BsC27MUfVFLbKc5OH
   w==;
X-CSE-ConnectionGUID: aw7JGWXPQ5uOaYFLHDN7Cg==
X-CSE-MsgGUID: hfSILMyZR+6+Q+1ip9yhnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1119692"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1119692"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:19:30 -0700
X-CSE-ConnectionGUID: gMG2ZwmuQA6PISUj02a5ZA==
X-CSE-MsgGUID: OewZLiDLTIK8mZAkeTTzkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3283610"
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
Subject: [PATCH v2 6/6] PCI/portdrv: Bind DPC service based on host_bridge->native_dpc
Date: Tue, 20 Oct 2026 11:19:23 -0700
Message-ID: <20261020181924.3003553-7-sathyanarayanan.kuppuswamy@linux.intel.com>
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
---
 drivers/acpi/pci_root.c    | 16 ++++++++++++++++
 drivers/pci/pcie/portdrv.c |  6 +-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 5c674d5b6bb8..b380b6d8874d 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1056,6 +1056,22 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	ctrl = root->osc_control_set;
 	ext_ctrl = root->osc_ext_control_set;
 
+	/*
+	 * PCI Firmware r3.3, sec 4.5.2.4, requires platforms to retain AER
+	 * if they retain DPC.  Put the other way, firmware that grants AER
+	 * does not keep DPC.  PCIe r7.0 sec 6.2.11 recommends that the OS
+	 * link control of DPC to control of AER.  Firmware that predates
+	 * the _OSC DPC control bit grants AER without DPC, so assume control
+	 * of DPC whenever we control AER.
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

