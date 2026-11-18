Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025844;
	b=vpcBwRy5ay/3jiJLO8fnvnQmjY6cJoLX2tR0H650V/nB3fITQIHJF6RuwA8GigN2+jU5
	 DUWguqzCUKwftfnSpWfx03HXNxE6WhAIKPZg7MeLfSC6HxuyrnZxYPjMrdLcmV1aQ1/qa
	 dgiGqpX2VI66fd3J1Bsd2Xq6hovLe3RS6qPLYqnW4fBn1aY3++X/yzRCUPeOs9Jw5XxYm
	 9Dp+27PHR1KJpUQKoLmHu2583nZ5ALHtw4p2oLmaK/S5f5sec8attAGOKhE6ayEkoGAjN
	 wHCPa0hjd+TKkEcPro8/Gs3F+x3oKyHQxMLaVzY4k2SrbmwS8FC48wLBRIRTwhSyVDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025844;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h0FTycmoQBXg9PUTfy+cMSfPB2wGt6S9/lRS0MtnbV4=;
	b=BkRn3gchkv1hBVJCPWuIPLt2VN3D0E1vpJHzXGvNmdSqi8TPi48gDLxQL9J8XV9rFxuk
	 6QpTIk/mgvTbZco3+NRTbdgJq8qGCWU8Stp4rt96eRd8719S6OF3owsD9x2aulIUkXzZy
	 oIQ1UuSK6E11zAnbc/oW5N3SEvwruS7VRyt2jYRIwlUNNUg2x/4MHF9AK2h//xq7oNEIo
	 ox5IEXS3CSLuEtj/ekwS/EJVqfWRO9EA6szX/Cy7CaxOFqgPAgfLwxYqBp4NOKEu56/ZO
	 JL5U3tcIELGt2phaOt3SdjLxE6ujcjhqIYqKsJ7tuPjTxdKN5ayPH1ALga51xmDsZ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QhuajvBX;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363160A2618;
	Wed, 18 Nov 2026 18:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E363160A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QhuajvBX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795025844; x=1826561844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O+qI/NV/7oOd/Ic+OxdFgWLWi9BtIzaFtWHTqUmvQBE=;
  b=QhuajvBX5CVjFqDQF3HcXXrwlUfzce07OuRTuofTyvhSKxzitbCmd+ZT
   5KHmZviou/+e6dKz065Tp8RfmWyczOWpaD7oLH+CL7ZF9Bdwn84JlGduy
   3ykes17Rowm+G30anHWgaP04FicQeGjK25KaaWa5HL30yXEGm888SF7zw
   x7NsqAFWw3Zi1kQucC3J28sq6MfmIZB96k3lvlSNDFr8VkrX9l3WIny8u
   Zv+JTaA0pIwPjNwNgELwEFx7qj3RhpmVdDwlT/m3KvSXyc5G7Pa0LqH/g
   HJXNLa2F9rPZbK5YGiaGPlHmJaKrmjvX6Y/u0u6+g+hq/hzmApz7roTBG
   w==;
X-CSE-ConnectionGUID: NcS12nwgTxWzBe21D7X1Ow==
X-CSE-MsgGUID: /46WLx+STkGcwIvM8i4ljg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3744976"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3744976"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:17:21 -0800
X-CSE-ConnectionGUID: YFxdEbCuTw+ll02i5GndUw==
X-CSE-MsgGUID: SOt2z6uzSaiDixtnQ8kcAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10087028"
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
Subject: [PATCH v3 5/6] PCI/ACPI: Request DPC control only together with AER control
Date: Wed, 18 Nov 2026 10:17:17 -0800
Message-ID: <20261118181718.3907441-6-sathyanarayanan.kuppuswamy@linux.intel.com>
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

PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER control
when it requests DPC control.  calculate_control() requests DPC control
whenever CONFIG_PCIE_DPC and CONFIG_PCIE_EDR are enabled, even if it
does not request AER control, e.g., with "pci=noaer" or when MSI is
disabled.

Request DPC control only if AER control is also requested.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes since v2:
 - Fold the PCI Firmware spec reference into the existing comment (Yazen)
 - Keep the CONFIG_PCIE_EDR test and mention it in the commit log
 - Add Reviewed-by from Yazen

 drivers/acpi/pci_root.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index a1a9c06012f8..510943649b41 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -515,9 +515,11 @@ static u32 calculate_control(void)
 	 * Per the Downstream Port Containment Related Enhancements ECN to
 	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
 	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
-	 * and EDR.
+	 * and EDR.  PCI Firmware r3.3, sec 4.5.2.4, also requires the OS to
+	 * request AER control along with DPC control.
 	 */
-	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
+	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR) &&
+	    (control & OSC_PCI_EXPRESS_AER_CONTROL))
 		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
 
 	return control;
-- 
2.43.0

