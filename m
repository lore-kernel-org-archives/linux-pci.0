Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025844;
	b=dkAa5aIP57txaX9vrdNJNNGnzDnDU37yRlVFOdqZeAEKfX25si+bnsafiolUMzZVP9CB
	 F9CpyB4Dk4g5jUcqSeGzPVoS69Y4m7gGBI5ASQ421m2UeoVMJbD3j27nshPyLwtLPQB1x
	 4oJRAYueWZuYJIYZFLYKQRKl7uE1KIxbt3I5guxCPCoStaGsf1YTwE5iKtwP7qgnRkcxZ
	 7j7boaQjVjZZ6BV9o4rKIkmLjbfh3WMEjTftgpimj36UApLt42X1T6mvD13B39D2x++uu
	 EdRTNw2aFevaXrG8rKfw9rV2YfuiLuYJ21IVzeo8H7C6SJmjCcV9ZJk5JwjWm0iEa3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025844;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CAJHnZz8kdb3FQSnfzf7qsriL7II6F/IEUv4jMm3iQ8=;
	b=2Nuxea3rDbA++7FUekBXI4AfJP1RSMhWjt+wqp/plJZqXPLRAACduuWYMHFg/xcxgv1f
	 MumHjmNCkOwCuMZmtS5ajH/nIzY2ddnTxU0GODVuQ6Z1g29QIIFDf9nMgz7NXELbq8Gzc
	 pM8F4JC27Lb6ywjmP8CbxnIr3J5DaXzHztt/b543JhFyHCrUVlC8bcIynTHecYbZj9mEe
	 IGvTbRGVY+QWyoGJOJSm0tNu446eij2W2/32phIqVE1nbNw1EaOM8IM0Jep8T6mlpxXRT
	 PWw3rrTJWi75CuERnxkuS2Krn20E6LCilL8+R3YNp/7OYl2/XQfPNl3QdSDw0sfyCRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YcSDufuf;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8D60A2609;
	Wed, 18 Nov 2026 18:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E8D60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YcSDufuf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795025844; x=1826561844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lryHKCrwcyLuKb+d1wrkUxuhWHmFj7BB0mgOMG0W0GQ=;
  b=YcSDufufDjki7WwT7fgU5/JapBcuVRSLNj5nrWS0/qqd/MudW7LaMpFt
   WvgaU9thqJNQ21BO59QzMXX3kfBdwUKR3KpK7wUGEtz/hthgbEOVBZkH/
   w8+4Pm2jscgqiATFfgwIPh4tBDwcYhX89uxTsIWOMrVI80HXpczeIFvIB
   PslV/qRLQLRfS6T4hWRUaWtlkJGhZU3eRY7E8QAmyh7N3oApmb2+Gb3Ni
   8yjWGPzyBYxzUIgkpBaqnLENfKr5SY8HIGLJcMVzgnM/rKxi+g15wRnae
   A5XHG28cmlKSfNNsrEzXutS4SP3jIi9NxtUMnof7hR6ZQsQgM7MCVhPby
   A==;
X-CSE-ConnectionGUID: oiRvxdUlQP6pxgU+dEUNdw==
X-CSE-MsgGUID: 9LHHMqhbSVyCYmRU0IV0Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3744967"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3744967"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:21 -0800
X-CSE-ConnectionGUID: xNmsrO6YRhSawcUnuWsrMg==
X-CSE-MsgGUID: CkF4heJOTv2zMAWZ7zjvgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10087026"
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
Subject: [PATCH v3 4/6] PCI/portdrv: Don't require AER to bind DPC service
Date: Wed, 18 Nov 2026 10:17:16 -0800
Message-ID: <20261118181718.3907441-5-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes since v2:
 - Add Reviewed-by from Yazen

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

