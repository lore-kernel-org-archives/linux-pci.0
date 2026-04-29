Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2739C632;
	Wed, 29 Apr 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465707; cv=none; b=t/v5zPR0iYkFPd9+orccDVesZPpRLKIYVuQPlZohEi6azu9CMTKzzbzEb9wn+oyrV8hrgCGVx9YKaPWa3iOyJWAfXL/rhO9FWV/lkL2p3xpx/tYdrpWHFqoqQBnoYHfGlQitZJf0XJHXM642zD2MNd1+MkyCBq3uDwOy6LMHOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465707; c=relaxed/simple;
	bh=fqkZl+gRhl4cKQbh+rABk9mPSNA9e1YAdoDCW18qzQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPBYJS+CjzRI3dA1jfwMHryhICKxxjaFUoJnPsJEBjKnkmlV05oviQzR3ftHwmAeKp5mavl1TBdHbWuvYnHjpuyxO5ZWcnVuxzBg8NBj7KpnrYVm2zOvf2z28XlsvqdkHCnahx9Z/89La3QvGFfgMU2h3UEFQTXhMRO8pNG9q94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPZWZ8YJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPZWZ8YJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465706; x=1809001706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fqkZl+gRhl4cKQbh+rABk9mPSNA9e1YAdoDCW18qzQY=;
  b=OPZWZ8YJx7wtU7cHmJovX0wIj6YjIBbetkqGnVwiRJBorcYwCUZ5yHh8
   EwhIaaLhTGS8EtrA2egRhRjW4CEVJXzT43SZ2AChr/Zj1SjuUNFTKXG4s
   ZB9PaqijoY/6vxL2znraiNCMnhuSteZDwdHdlV709esAu4uBrsMrmk5py
   YmOaC5s/MXSzrFGXG4amCjQe2qJGK98iabNvqfxlJa5zqjzuezCDdYsoK
   jiRfCsi6uedVk4JRVDNS6Vr8LJ0BJHysBIHotcRHtDy4tKElcrywwbry4
   GsqWk5LmT4PBl/uivhp7perzrd+NOyhpHwAxXPG3C+bCrrZznHlVEr20S
   A==;
X-CSE-ConnectionGUID: +1dfq9gWQfe61S64OG1OmA==
X-CSE-MsgGUID: ti1ND9IVTnOsuHrkEDVNPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89853538"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89853538"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:25 -0700
X-CSE-ConnectionGUID: 0b2tYkpVQgm1CLfL2p4dAw==
X-CSE-MsgGUID: uI4xITOIRG2N/6phtyIxUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="264639555"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/11] PCI: Lower bound bridge window alignment
Date: Wed, 29 Apr 2026 15:26:16 +0300
Message-Id: <20260429122617.7324-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_resource_alignment() does not consider bridge windows special,
yet their alignment is subject to different requirements from BAR
alignment.

Add lower bound to bridge window alignment to help callers out to
always have large enough alignment.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 18e8775ea848..c15bce20815d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -19,7 +19,10 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/cache.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
+#include <linux/types.h>
+
 #include "pci.h"
 
 static void pci_std_update_resource(struct pci_dev *dev, int resno)
@@ -250,12 +253,19 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
 				       const struct resource *res)
 {
 	int resno = pci_resource_num(dev, res);
+	resource_size_t min_align = 0;
 
 	if (pci_resource_is_iov(resno))
 		return pci_sriov_resource_alignment(dev, resno);
+
 	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
 		return pci_cardbus_resource_alignment(res);
-	return resource_alignment(res);
+
+	if (pci_resource_is_bridge_win(resno) &&
+	    (res->flags & (IORESOURCE_IO|IORESOURCE_MEM)))
+		min_align = pci_min_window_alignment(dev->bus, res->flags);
+
+	return max(resource_alignment(res), min_align);
 }
 
 /*
-- 
2.39.5

