Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025843;
	b=f7bTP6hsgvaoG+r2z+9WLAhkzYhX0Moz37whHaCwuQfaPqKGtzW7RKCCt9/uqbq2qnG0
	 s13lo/NC+c7agCZYekEwUnRdkCwlYdb4C0Pridoo3eyWw/6pNVLOlSHyNpHX1n3VC79BW
	 y0V+z+dpZKUoUwpLI3HokSJzFfMylf9somUIH8lIz6qnsTRAGzQ0swk0e9v6FFhf0K/hD
	 BKW2tUzALNQ7V2wNg29duqK+4naVHXJOre2A0r1aU9OISYNtMNLZTitvUIlJRingF6YBt
	 +xl51u5pfwebV9qrQa5JiWFXHoYMbMnn/ZzZzMGyNUcCSZChCHLSVqiJvg4V4hwCR1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025843;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4TIKFyZrBk5Fg2rwW1XyXa8zJlkaBGn9TOvzGCXUZ4o=;
	b=kc+dbCh4BxTAAsbEVrgmpT6xkxSm9sWjta85vk28cAUOzMWqculG5bECoggV2NcR1D6G
	 qbx6TF0x4VdpCO3nI4y3FXqDMa5m4m0yAm1UaBIUriuB0WcFS7EESzxPcXJ3MXtVFrIEH
	 bviY1SkktZx7h2OCdp+VWCjmS11EwOV+b5+g5L2B/x2DAwGr0BbzFhu+bNrG/Fh0NdPUg
	 amPPijurp/k+ptiRH/PEX1zIeHJnd8mrCNWlmO7pTDXCvTuejiaEbC86G5uU2IBoCRNYp
	 tksDJ8ZSeNHXPlCp3e37SM3xphVXXzUewHs3NHEXxQLO3+XSGc5r6N40paWldbiq8bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZPYPOIzM;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7173606A337;
	Wed, 18 Nov 2026 18:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7173606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZPYPOIzM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795025843; x=1826561843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/At/vTlJzS9qc5MVfgnA791SryHvsleCsGVR9/WeQ4=;
  b=ZPYPOIzMxmXVgRlzcDqif0HAh1fqBr0wIXVrdVQ8CZWv9feBq+kp2NPn
   88AeNis5YcvVmrwwMklxk42k0MBm6v8dc3rWGaFMKW3JsiwWpdG+LKO6Y
   wUfarH9G2PK66kltaqE7yzalDh5sULO2AKVqBg6WesB5gk1lsrdXW5me+
   jKGTTywL1dC8xYZmRm4l/xMysXRi3GrSE6yFFlvbU0vwrA7NQEtFXnJ9t
   6HSBTToBn+f616zyLa0TXacKhbMUVOmVlh17XvOq7Mhw5NBqePQLU5cen
   HCqdkMAqS7rIraByxOgrlELME5Zmb1ksMdwb5pH+/NyoJGVW747xmTweT
   g==;
X-CSE-ConnectionGUID: 208yAoYLTfKXeD/OUgN9Tw==
X-CSE-MsgGUID: Q0SfT/90Sly2dpjrWwzIGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3744948"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3744948"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:20 -0800
X-CSE-ConnectionGUID: Mjlef2OwRFqmJ/qOP3Ah+g==
X-CSE-MsgGUID: DD8JsaCdSb6GJ2C8/DyudQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10087023"
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
Subject: [PATCH v3 2/6] PCI/DPC: Reinstate support for AER-incapable ports
Date: Wed, 18 Nov 2026 10:17:14 -0800
Message-ID: <20261118181718.3907441-3-sathyanarayanan.kuppuswamy@linux.intel.com>
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

From: Lukas Wunner <lukas@wunner.de>

Downstream Port Containment does not mandate presence of an Advanced Error
Reporting capability, so a Downstream Port may support DPC, but not AER
(PCIe r7.1 sec 6.2.11.2).

Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
ownership") seemingly inadvertently constrained DPC to AER-supporting
Downstream Ports by inserting a call to pcie_aer_is_native() in
dpc_probe(), which implicitly checks for presence of an AER capability.

Drop the call.  It is superfluous because it duplicates the conditions
applied by the PCIe port service driver when it decides whether to
instantiate a DPC port service (see get_port_device_capability()).
If the conditions are not met, no port service is instantiated and
dpc_probe() isn't executed.

The only difference between the conditions in dpc_probe() and the ones in
get_port_device_capability() is the check for the AER capability, so by
removing the checks from dpc_probe(), DPC is supported on AER-incapable
Downstream Ports again.

Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org # v5.8+
---
 drivers/pci/pcie/dpc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index d02cbbbe3143..a0880e3cd68c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -496,9 +496,6 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 cap;
 
-	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
-		return -ENOTSUPP;
-
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
-- 
2.43.0

