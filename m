Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25123A7F4C;
	Tue, 25 Aug 2026 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636631; cv=none; b=dLJ+eVYN75TIyGJtrW54k6oDkPnXm2URO/xWsj2Thq5/5w3xSzXo75lVDeo1dBJHUNuhJ+BxbspSgB+LO6GAS+bC6+baBdNR9g1pQ/w454gnB9YYvNG4FtF8hZfd5NK5z75YVV6xpKsPdkPdN+u7jeF6vrNnZhaouqjPQPog7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636631; c=relaxed/simple;
	bh=f/16kBJ47bSVdkU7GRfgVdz91xbpoWU30jxgMcY/usA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cStUJ/9AAize2DibHud0L4J8i1PBBmXg00rvZBbnlLutl+zq6sFMxbGOXCOkWu2JmfGent4nlIpYDTkSkq4dOULg8YGu39lukwzVHZ7mt9ZGqoKjuttFY0s5dXmHhm9P34W6TtjNiwSld6tWerde9Vi/8Pk5KUe7adgveEsT8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwRHN5fy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwRHN5fy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787636629; x=1819172629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f/16kBJ47bSVdkU7GRfgVdz91xbpoWU30jxgMcY/usA=;
  b=DwRHN5fyPDYpxEIpCJZbsrp5xcqFHL3l9+JG9CztIGYm96GdOEp95iGQ
   /VtXJdnhUAFD+Te3tTxc7HzNPUaNNKdH3L0Ulq3xpTPoJjpS+iwUUt/XO
   KA028KSNj953Fc8lozYVNdH0zPHOEcEgZkn5YmWQfKDtdeLnh6Ty5Czu6
   jYulobkP2aUy4KLMMZrc3a8ut/ujKP0eRKIDcl87jYgVC6izUrasGw2Sw
   0XDn+wnI7jIwG8fPwggsybdTZqACxA0BIRma7CAtGMNtjQ1DMtZgrMSCT
   JXogORnRpyyQg+nfx93Rtef/qs6GsjWLh3CejCSCKgZc8xSsvP+0czG4R
   g==;
X-CSE-ConnectionGUID: rOwDtRdsQvSryC6UFqUtOg==
X-CSE-MsgGUID: lbzn3+/ES06TgNtwm4l7Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88152512"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88152512"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 22:43:49 -0700
X-CSE-ConnectionGUID: qFNzBAs7R8GtfBuV4GtguQ==
X-CSE-MsgGUID: vCV7bPe+SQOcWsPhZwoCSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="272418216"
Received: from unknown (HELO jraag-Z790M-ITX-WiFi.iind.intel.com) ([10.190.239.23])
  by fmviesa005.fm.intel.com with ESMTP; 24 Aug 2026 22:43:45 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	bhelgaas@google.com,
	rodrigo.vivi@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	lukas@wunner.de,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/2] PCI/AER: Export pcie_aer_is_native() to AER namespace
Date: Tue, 25 Aug 2026 11:12:50 +0530
Message-ID: <20260825054312.1319951-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825054312.1319951-1-raag.jadav@intel.com>
References: <20260825054312.1319951-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcie_aer_is_native() was originally exported to CXL namespace in commit
49f776724e64 ("PCI/AER: Export pcie_aer_is_native()"). This is a bit
misleading as the symbol or its underlying implementation does not reflect
any distinguishable CXL functionality.

Change this and export pcie_aer_is_native() to AER namespace, which is
cleaner and more suitable for its implementation.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/cxl/port.c     | 1 +
 drivers/pci/pcie/aer.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 99cf77b6b699..00f675163b3d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -340,5 +340,6 @@ module_exit(cxl_port_exit);
 
 MODULE_DESCRIPTION("CXL: Port enumeration and services");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("AER");
 MODULE_IMPORT_NS("CXL");
 MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a54..8660b18bac8b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -248,7 +248,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
 
 	return pcie_ports_native || host->native_aer;
 }
-EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
+EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "AER");
 
 static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
-- 
2.43.0

