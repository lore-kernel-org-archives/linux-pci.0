Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE453BED01;
	Wed, 29 Apr 2026 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465717; cv=none; b=A/N/sq5xZ7AEME/V1lD0JQD9uUoSvBtngD7kq7u2T+QW07u9zhKR1J8aeV8PDdTg3IaoLhgLn3sxb+W9tw3Cmkvu+SP1UKf1FCqwU265lFAqqZ78+XMjRy9+9FYQWMOqVdHxtd/SEtZT22Ea+8mVar139qj8wWgijqeM3O0xE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465717; c=relaxed/simple;
	bh=GKXpXP0HLpIzXt9FVzTWoltHAc5rYgaa1I20ERAvp2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlsKtLAHMYs+IYrvCpeXr7JvGF5YUt9BPj9FJRnEKQdEsIm/I2wFpyCcRopwfZw/rwlVBOtNZyD4HSv1V5wMqsnvI5ipT0WaM6VwdlfEglXj790bGU3kLOE+Wg0DJUtWC52rw3Gx7xEW4UYlCICmKOqG1X8jycJUCyP6WB/zKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQwnT1Ii; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQwnT1Ii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465716; x=1809001716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKXpXP0HLpIzXt9FVzTWoltHAc5rYgaa1I20ERAvp2k=;
  b=RQwnT1IiuxjXRVa0LpywopLXr7yCJ13GRzCCn4qK0VZjXqKoQxsLEU6y
   YHaXf8ifk4LQ/eiHdExerva5y3LRMgGTg+EvAxoMVo/HjrFpjiz1hDUJZ
   tYEiotvcCQ5CaJ5funWzO5ysV3TmTZlUtNUQN6FjY01pvu3lIhwHuQrcX
   OdO4uiNnu53bVPqyZK1rDvtrsAvOPQuUjXqkI+lv60VIOrPcVJwQrTAhV
   S63JNkD7iKS05zizvd73Po0iHHsW3zon1Uq/TgH/oF8PNsRI7CFRnHaYy
   zsPzHmPtubd0SMsaathTmF0alGELtsVqaG/D02YADn0Z4cer8GQe2DwXI
   A==;
X-CSE-ConnectionGUID: zlIUYeOETpKXizbNKS+LYQ==
X-CSE-MsgGUID: R/l30yNDSfaBB/5q4eR3qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89853556"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89853556"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:36 -0700
X-CSE-ConnectionGUID: wGp35jvkToyaC0AQ8zhvVw==
X-CSE-MsgGUID: vJjmMR20RrCYutR71IFsrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="264639579"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:33 -0700
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
Subject: [PATCH 11/11] PCI: Return valid alignment for assigned resources
Date: Wed, 29 Apr 2026 15:26:17 +0300
Message-Id: <20260429122617.7324-12-ilpo.jarvinen@linux.intel.com>
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

When a resource is assigned, IORESOURCE_STARTALIGN flag is cleared,
resulting in pci_resource_alignment() returning 0 in some situations
(at least for bridge windows).

Add heuristic to pci_resource_alignment() which mimics start and size
alignment by taking minimum of those for an assigned resource. It may
overestimate alignment when start has large alignment but the exact
alignment information is not available and regenerating it by sizing
the bridge again is costly.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c15bce20815d..03098f159ec9 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -13,6 +13,7 @@
  *	     Resource sorting
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
@@ -265,6 +266,18 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
 	    (res->flags & (IORESOURCE_IO|IORESOURCE_MEM)))
 		min_align = pci_min_window_alignment(dev->bus, res->flags);
 
+	if (resource_assigned(res)) {
+		resource_size_t start_align = 1, size_align;
+
+		size_align = roundup_pow_of_two(resource_size(res));
+		if (res->start)
+			start_align <<= __ffs(res->start);
+		else
+			start_align = size_align;
+
+		return max(min(start_align, size_align), min_align);
+	}
+
 	return max(resource_alignment(res), min_align);
 }
 
-- 
2.39.5

