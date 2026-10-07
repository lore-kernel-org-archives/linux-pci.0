Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1234CDA2A;
	Wed,  7 Oct 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392332; cv=none; b=tFkb8QxSnuyJLj10nP3xjj6qHsBrfRgzwsKLlA/W4/2c/4qhCyonJuQXXR/dPlX5m3RaUmLT0qVLofw9IPuthzBMX6WudrwWlhSzGylioEnarPnDsQf4kGePx5MfbdMaJzgWz5rf8eHhMwML4WdwGbj7MwAL2nhGLFp1F5wrhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392332; c=relaxed/simple;
	bh=wrdZYqgyZr10bvKBuIHWekho32wvbhmlfaidg0mzcew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZa9Rp27kg/bp5HYvO0EJR/mYHLoEYeQRDDzuadb9y1q/7lydUAwI6mYhoXsDkSAngC4mXrXGepdX4NeRRW48ooDtZlXkVx+T7/usXOzbIq+fT2wJxsUTmuAJOPPm7I0o9FjU+1f7qf61vkO2ATsonl8aYl2A27yns+hVwb5hK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdJT8jqq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdJT8jqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791392331; x=1822928331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wrdZYqgyZr10bvKBuIHWekho32wvbhmlfaidg0mzcew=;
  b=cdJT8jqqZ6RzAYyMgH+gYVxnQffqad0hWvBWpakaEfAVd6uK+5vOFLbg
   jcgPLmiC9IdNwJLcRixRyz/MUtxFgUJbakq59U0c3fvV+Kouqu5YWPpMG
   YWOALvhF30TBdjSldlhfaPNrfzfCa0MRux3Pqfpg9DJys8KXTeFt7pSG3
   NQeg/2NqGou/mPR104qU8enmIMPtjB0cBWHTZ3FguJGrvZ6sj+PAx9F7J
   YKvI1bxuZTqhUdx7XWhy+/jkxJ/UDOBvaGoS705cDotAs/hY9LG7cSyCU
   sIiMwf3NB79Hs8Ke8tWMj9OPRrGYLX/hbJOru7mz198FRsXaltgn8vwGh
   Q==;
X-CSE-ConnectionGUID: 5uKU0ELMR5SGkdrdYdbLwQ==
X-CSE-MsgGUID: BXJ6UIV7S6OKhcjf6hVynQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="263219"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="263219"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 09:58:47 -0700
X-CSE-ConnectionGUID: AuvJG/pjTmOGkRexM+AZOQ==
X-CSE-MsgGUID: pLAnrOBhSrS94HcNiX8LEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="306958466"
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
Subject: [PATCH 2/4] PCI/portdrv: Don't require AER to bind DPC service
Date: Wed,  7 Oct 2026 09:58:38 -0700
Message-ID: <20261007165840.1604136-3-sathyanarayanan.kuppuswamy@linux.intel.com>
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

