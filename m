Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520371;
	b=GegRt04TzckO0pvKLXC5kkme+n/rH/YOoLN8dJOhzvNf0KFmBIIp1qRh40q9/U0A5zBX
	 7X4yVLyUQdv+YbLtSk7K0MhEyraW5zisJaZnaPIu271HId1i2bj2NBURxITyakxVZrrTq
	 J9r4sj3SwHxrkK2xpGj6cCsAWVsaDepIbReAIzP4oxc3IADx1hxt/4+w+/zs296T1vrOx
	 J+UpNdY65irOdLyRR8XnuPAGJBTQL/Sjt+JYBhUQosppeMbW0h0FWvTcjtSCnS32dMjYs
	 bm4CyRcUlBQWVW60m69/8brVYH0P1w0CKo+gy4BEDzi0RgwIk0fYTpfxjPL5tuMWTkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520371;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dztyNBiVe6WSpgntF1jk94NTTytwU/+7n8pZQtEt9Sg=;
	b=hRD/+fb97KoIBh7yKiX7lu9e/qAAmWJwxULeNJ3sGoIk+rgeHhrr2lmTOuBKPB4itJGy
	 uPCIpDPZl21OstabWAJ965NmxJyw11I+/NKLEeBr1fK0Pl/7pkxtqOxgl2YQWycB1jfLk
	 vcWsCbOcmLA8MwFZF7MU6KcUIg5YibIDTkKkQKd2flLVK9TQFtaVpDLNbDLUAZtE63E3h
	 CP9Bzo/a+QHqBv4/PVTdUFUV0H+/PcC/3p2J9+MguLwPrLWf1mavNOn5Rxjg0utelgwRC
	 gvSFwTB30nC5Rd/Zd34Iz5lwmWC0duNOm0OXKt9f9fVm/mGwRzOip5hMwRVTEez6DtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="RzB6fK/m";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E760A261A;
	Tue, 20 Oct 2026 18:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A5E760A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RzB6fK/m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792520372; x=1824056372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a88SugCeVVbVwykMFqo12/x/dfhJHo9rj1DdiNnS6FI=;
  b=RzB6fK/mvCZS+h60ENPZJ9EMp6WW+M84MNdLHxIuJdXhdQzigIdWjhok
   6qpzLfP+me0CEL22/o210zhNLXHKuA0JzDkZOPU6OAvpWWEpwbICCFGVo
   a1z5lcAqoS7LL4o+alm3zc/SjLBYYKEv6uziWEGtVZur8UScndjKftmC4
   i78e6FEo5xHAIa/V6Hbi+L6rO/YJsbLEhz8ezT1JgCvsjDcY9AxAhtZyz
   r4cKCNdqZGOBsqL6w7otI7Xd4/JNujXph2GFJoSrJBkkMhdA7qzAh7dKv
   goyLp2NCC/7fNudV/MAEL/Mp2yf+s8zqBVpXTfNvyZswdHO0cUyRZCf4t
   Q==;
X-CSE-ConnectionGUID: z+eP0c2QQAiuLxFBr6p/ZQ==
X-CSE-MsgGUID: 6vGc99kTT22kMvb1CDZxAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1119668"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1119668"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:19:30 -0700
X-CSE-ConnectionGUID: 2gKozIi3T4+dy2MPF7E8ug==
X-CSE-MsgGUID: DPpwOPuGQJmL4zfAD+rubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3283605"
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
Subject: [PATCH v2 2/6] PCI/DPC: Reinstate support for AER-incapable ports
Date: Tue, 20 Oct 2026 11:19:19 -0700
Message-ID: <20261020181924.3003553-3-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Cc: stable@vger.kernel.org # v5.8+
---
 drivers/pci/pcie/dpc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 793a799053f1..104ff2b91f1f 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -474,9 +474,6 @@ static int dpc_probe(struct pcie_device *dev)
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

