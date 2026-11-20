Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182584;
	b=mFhmU3D7bpHzf9QHYZLsD3Jl/APQaRjJ/2Cr4rRD/8lzfoqTv/tSlpiRs44c4tR01Ux8
	 0BL4qGkEqi0WvMFKD2X7FKsQ3VkxoFE7y4fl6AAhQUCQB+z7rNVIS+FEH3lQoZCOwDU3G
	 JtptCjYIAdDAbth4qpUdbIOgKUPX2ctTYCM0WaH4txXlhLKUKYiIUmOMA/9D7RXZuBTDK
	 S2KIzXXgkKiCovO6B6AlFK4SaV4BLIt0GxILiYStw0XOrT7pVY3MZPffMTtu/MzThI/In
	 vpHAOkF+B4NNAwAchL7op4n7zS1Gygcp40nqHw5VXe3BbSRzbxtjW+CrDAx+fNRo/GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182584;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=J65sboDxGHB+ZFpro2zBW6UtybYQ6p08zkXhKEDH0Uo=;
	b=igGBMuSUttA23iTN8DjXeSB/WUrMq8xSKIBTc2Q7b5XUjGD9dwYuflWz2cbwj5BRppEb
	 lUoU5xZk5V5SLpnGxmj8Th31iy1q0nOr8OVxn26Dy40IzQ89ebMt/bh0CqiEKolEjqHz9
	 H+dyAZUTVhGqEDn6s2kWBMSLSffvxec321bgerfdxI1iuD7tdfOdBa72Dsl1u6BNtJRnR
	 acgHZlJj6GzIFBKUD3dVZx1+bMRAIpXgc9Tnnuf9BbsRSrEYxnGyGfU1vQMneuz3otURJ
	 GEXTe25l3cI5uMts9jJK7VKZZPikyalvhCyA7xn0IXLIiZA4djFJOTp+TBBYzMzWNcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lr2UNs0J;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663B606A333;
	Fri, 20 Nov 2026 13:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C663B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lr2UNs0J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182584; x=1826718584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t9G1Z10mmZe4W5gDXqqRwVxtfEFNyswpPldl+jV5IYI=;
  b=lr2UNs0JlOn9vrJzHCADOKs7s6prOByaROfsAusDfwZ9O9XO3Qvxo3fV
   7XREa/AsBoK7d0zTygwcUHWtztsoZBHnQXl1+7wvWGIR8YSka0r/BoDzA
   vuHWWyb+SE/8LPxX0ltolHY7BqtLbPAjjJn6WiveZT3PqTJDMnIGwvq1c
   oSeLHGtIQhnbTxV6TN3o4ByYAzwLf0P0vVZZrftLaTGLzOqKAMGQ5hHar
   FeEc683Mx7KIRRgWNlUCP/nnGB95gt3QI4b8rqa6T8XPvscxIUgwaADex
   HJWYQ3gp5mKpVmRP4HuOwscp4IC0CP9fU82GNQUN11sRSv0zc91U0OlBu
   A==;
X-CSE-ConnectionGUID: Sh74gdEcQ2OV0kgmu5eQXg==
X-CSE-MsgGUID: ObauvOZMRE6cgt9X1ln8kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3955265"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3955265"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:44 -0800
X-CSE-ConnectionGUID: TrOSf16cRWG81fgfdhb18w==
X-CSE-MsgGUID: R0AovMn3RXilmIPIZeoQPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10971558"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 14/16] PCI: ftpci100: Convert to pci_assign_unassigned_bus_resources()
Date: Fri, 20 Nov 2026 15:47:09 +0200
Message-ID: <20261120134716.3027-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ftpci100 driver attempts to assign bus resources using
pci_bus_assign_resources(). That function makes bridge window sizing
disjoint from the assignment phase and is going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources(). If no other bridges are involved,
the extra sizing should be a no-op.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-ftpci100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 28e43831c0f1..96b3deb70f57 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -509,7 +509,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	p->bus->max_bus_speed = max_bus_speed;
 	p->bus->cur_bus_speed = cur_bus_speed;
 
-	pci_bus_assign_resources(p->bus);
+	pci_assign_unassigned_bus_resources(p->bus);
 	pci_bus_add_devices(p->bus);
 
 	return 0;
-- 
2.47.3

