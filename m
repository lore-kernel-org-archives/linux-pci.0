Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E984D0CF8;
	Wed,  7 Oct 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392334; cv=none; b=rAn7q6Yy9dWjpnh3WVF9Y4oFnrVVH/3CXWpKQOzy4x6LveZV+VEMJueaQFQ1yH5ckNvVPVmuJEH55jZvtRWywoapBSg/XEUvQpwTPeus1tlCp+t69FUvUgcLeRUKCkrKXM5/CQQ2aUzr1tZAKWd2nqUxJaY+FCW1EjNVzV0OEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392334; c=relaxed/simple;
	bh=mzJi3orogIGD7T3yXH92+hYqZf+52aZSC5oykeP8yRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVj9Y2fHLfEAJutbaApbbhG1+W9qAqxvW8eMPMla16cH7bkqwu5+0nXPKpxCDZHzLYh491ikOJrr1Ry3+SKgZbrNJEkiwcrYKYwsaS7VJgPQb8z6KtQ6BplWQxTW/JTym4gV8vPa4H5n3Mgp0LTUpoLgEiaAr9HsFztzd5T1r18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mx05ItYW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mx05ItYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791392333; x=1822928333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mzJi3orogIGD7T3yXH92+hYqZf+52aZSC5oykeP8yRc=;
  b=Mx05ItYWLT9W3i1XYuLW2grOtZAXfnjP8w3QNa/H3FOG0hx/NfRDmczY
   61XmI2dN3MBhb4j03k2WKb43ESBIboWqTy5hV7lJ4QBq9pOJauEMImDDM
   x3o0wyNJBHQrXvELGxAL6z6L2pnTkIKPZOBAXArSuPnmxJ/rgv5a6upye
   LwzTVbyfGPGTo7tvJ+foRpgRHXzTUaCl756bs4KsSRr7oydEYBb3TNpWi
   2bzd2yNFIPLCwF8z8A1veBaARXwmoZtmIGfpFzROaStKBNKBBfbzGTGTQ
   KLc1pGMerPjseRDu6XGaicUuZpvwX65C+DBDQOg9lrLma3y3NMQGms+lX
   Q==;
X-CSE-ConnectionGUID: HIG6zL/2RNqS5eHA30EZnA==
X-CSE-MsgGUID: wbU0z2zPQUiQc/EhU5Dwig==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="263233"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="263233"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 09:58:47 -0700
X-CSE-ConnectionGUID: DlAqlhDeR56R+f6FsVlhxw==
X-CSE-MsgGUID: vzQLT4BBTgCUoNehECu+8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="306958468"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 09:58:47 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] PCI/portdrv: Bind DPC service based on host_bridge->native_dpc
Date: Wed,  7 Oct 2026 09:58:40 -0700
Message-ID: <20261007165840.1604136-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
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
this.  The OS now uses DPC there because firmware granted it.  With
Lukas's series, the DPC driver no longer depends on the AER driver.

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

