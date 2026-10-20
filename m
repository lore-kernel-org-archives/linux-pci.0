Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520373;
	b=kgD65lR64zyj60eSPgD9obKebq09l6W2zqXZomGnLJ28IY6P2ms/s7Mzql4uELufQ+sE
	 Kp2bVbNxsqzg17kDPdUjpf9qmp4wX566zWO8oR/Ouffy7XTI3mHqPgXMU59oBp64ye0kp
	 RbVXKUCoN5jW2vdJwsHJiXKK8A9F5aaohnx/Qy7MnEi5SljFvkvs+Qm0jfqj/frv2Tbuy
	 blj8gBDh1TFgxoS4EgVhw3iolb1+P38HmjmOirDqDSJ496Q+AebTIRZBc2BOuwcGdxuuk
	 Nk/SQpRBzkz4aBNenbxCG+PYhayGAZCUn9zbRVVOmcGQYbUoRVVHSwyAepf27oY6vcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520373;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iDaZvPUF59dHAv0/fBcmD4f5Pd65omqSvPX2+O9nBmg=;
	b=vsLGqtTSmtkPCV6ZP6hg2IVT8WI25g+ZUSYF1UVfgCTpwuFfcThoVxtTJJcckYI7iMu+
	 oiwhA43aWlvp+P4QRyhib2do4dSm8lhpH5czzuz42Tr0SuPU1EI3PHcNuvCwjXkgvGzS5
	 ohOj0rauvgcN+J5+3rKwrG+uXmhuPKg/Odrv4gfLCXHMtLZAptM7j+cCtl2M/0/DmvBsY
	 Srq42wnyW83rRstn19HxuRoER5Eqy1+1SN7Zgwg3t4pyVjoo4ck5JOva8Eh/Xx9dMj/WB
	 7ZLVkpxdg7zqlElgnnyo5jgjQbg7iXXETFJTH/DxPcu6XyPb28oOHDQ2xOVJkEa8SpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XF7tKiF0;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72E60A381D;
	Tue, 20 Oct 2026 18:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D72E60A381D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XF7tKiF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792520373; x=1824056373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cGVtvUCU3zkoS8gEijQLS6ojBaUonCOzmIkVSU2963E=;
  b=XF7tKiF0w2nAppQzSD6ueSZCdSanCSYieinWCmtyGsWfA44bqj3rB8Wq
   Dmo3BQzTMCqc2lgpdyKAAx8mgeiU1Df7QNdw9spJD/CO05zeQAvALJd4q
   PkyP6ZnINMW0peqIwxN6ShiKaa6RRK/U3q/juDcMcwCgtIXruWIuqsgOe
   uYeTHCBar3wAuRDevvA0B+3ffLlIcYGqxHjM1N0Gg1KTOaxHZYweU+3Vj
   rVpb62mn54xQcBQ3zZc+alA/HzqQ3tr0eeWEYYA6ToonJkkVs0EkHMFWQ
   c//imUqsRGvbM7oWUx3uAFw767RbkZbNX138+J7eFFuIu2LkQwK3r8RfQ
   g==;
X-CSE-ConnectionGUID: AU5KZ0qjSoGUAR99YAQ0nw==
X-CSE-MsgGUID: sksCZ8HaScWasYamx9b4KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1119691"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1119691"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:19:30 -0700
X-CSE-ConnectionGUID: cxO40nR/TXuYerS3ppeCuA==
X-CSE-MsgGUID: wdsMghfnS7OGjSo/vUoSEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3283609"
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
Subject: [PATCH v2 5/6] PCI/ACPI: Request DPC control only together with AER control
Date: Tue, 20 Oct 2026 11:19:22 -0700
Message-ID: <20261020181924.3003553-6-sathyanarayanan.kuppuswamy@linux.intel.com>
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

PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER control
when it requests DPC control.  calculate_control() requests DPC control
whenever CONFIG_PCIE_DPC is enabled, even if it does not request AER
control, e.g., with "pci=noaer" or when MSI is disabled.

Request DPC control only if AER control is also requested.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
---
 drivers/acpi/pci_root.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b0e0b33e3254..5c674d5b6bb8 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -516,8 +516,12 @@ static u32 calculate_control(void)
 	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
 	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
 	 * and EDR.  EDR is always built with DPC on ACPI systems.
+	 *
+	 * PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER
+	 * control while requesting DPC control.
 	 */
-	if (IS_ENABLED(CONFIG_PCIE_DPC))
+	if (IS_ENABLED(CONFIG_PCIE_DPC) &&
+	    (control & OSC_PCI_EXPRESS_AER_CONTROL))
 		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
 
 	return control;
-- 
2.43.0

