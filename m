Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBBB4F4028;
	Tue, 13 Oct 2026 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897085; cv=none; b=Q9KmTgZYOI+oKIGCGoqhodvxzcDN/sLk3/sOHKktc+TU47UjMEilJA/mxdodzzDYOrA7uz0jDt9FQfWs4ewuL5aw4o87H7Kk0vDSAw3d15rPm3rnsJm5JuFlDoai0x/nABp7GQPdISeBNKpC/vLEYymbNIiiNI7ZLjna1nj4IIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897085; c=relaxed/simple;
	bh=p1HXJDgQRHqibBiKPSwVGUh4hSAocx7qJsryn8NTUcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyJlxUHt+o/zVs2b9QPgdu56e+aCNw3QWiWB8QoIOl6ifiUb4uhyKZ0ybquxOA/D/zgs5Ef5ukwBd0N1uh1O8kjkxV++MZ466NqHF10c6U2b+PHvlWmcWkFvI50WRUUb9JxRykEmmbKtcnShjaTYdXYloM8NxbJ7NmsQ0MDkUzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw6Bd8+1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw6Bd8+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897084; x=1823433084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1HXJDgQRHqibBiKPSwVGUh4hSAocx7qJsryn8NTUcU=;
  b=Tw6Bd8+1euGqySE/cJeZo/PWaBiGSElNQXRTNYrEHiFk8u9mTK3IN4Nt
   mcXWaJbTo+UxAzgiOU2d5dt2DoTScKX58c9T6eyoektLJiGZDnQYE4mag
   vSkbq9QdrdRxHXTSbVsKBoJsIWlzv1GAWAcbfmVhhyMVutZIg2L4svQ1Q
   lXfHAEM2zz4wMgdefMqAbyFuk5Xd4fEqRovVh1cOPqrU7svKp0quF8qrQ
   ZQSCZrO9oOlA+rs1ad81apaCXIFAWARTK6fwKxLSfORAW8LmsLU8YtZ8T
   GpEPjQs24drIAkUvk/CQzc+abKVyG3P6ws6Ixg46+l8Ll5zPW4VCZ7LTj
   Q==;
X-CSE-ConnectionGUID: xqi2ETP5R0O2AoNsYiQz3A==
X-CSE-MsgGUID: uUzGHbPFTqmNCMmWDPWNfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="499487"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="499487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:11:24 -0700
X-CSE-ConnectionGUID: VJIOZxiyTjGPWARG45JHbA==
X-CSE-MsgGUID: pizr/UxlRbitzw+kI6OGZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1485224"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:11:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 7/8] PCI: Fix composite resource sizing
Date: Tue, 13 Oct 2026 16:09:41 +0300
Message-ID: <20261013130948.6231-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The bridge window sizing algorithm aims to pack child resources back to
back. With multiple composite child resources whose sizes do not align
to the calculated minimal alignment for the bridge window, back-to-back
placement may not be possible. The non-aligning remainder placement is
limited because it must be adjacent to the rest of the composite
resource.

Effectively, two remainder parts may be placed into the same align
sized block, but sum of their size might not match align. In such case,
a gap is required to meet the alignment requirement of both resources.

Add bridge window gap size calculator. Basic rules:

1) Gaps are only necessary if there is more than one non-aligning
   composite resource within a single bridge window.

2) If there are only two remainder parts that amount to less than align
   together, the required gap is the difference of align and the sum of
   remainder sizes.

3) On other cases, round each remainder part to align to get the gap
   size. Sometimes, smaller size may be possible but due to how sizing
   and assignment are made in different phases, it is not always
   possible to predict where each resource is assigned. Thus, the
   sizing has to play safe.

The gap is calculated based on the minimal alignment for the bridge
window, which may be different for the case with only required
resources and the case with optional resources.

Fixes: 9036bd0efcb6 ("PCI: Align head space better")
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Bjorn Helgaas <bhelgaas@google.com>
Reported-by: Nikolas Joshua Britton <nbritton@exabit.io>
Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
Link: https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@exabit.io/
Reported-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 84 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7ca0e9f4ffb6..2980b499ef75 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1164,6 +1164,79 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
 	return min_align;
 }
 
+/*
+ * Bridge window gap size calculator.
+ *
+ * Calculates gap (empty space) necessary because of non-aligning composite
+ * resources (VF BARs, bridge windows).
+ *
+ * Rules:
+ *
+ * 1) Gaps are only necessary if there is more than one non-aligning
+ *    composite resource within a single bridge window.
+ *
+ * 2) If there are only two remainder parts that amount to less than win_align
+ *    together, the required gap is the difference of win_align and the sum of
+ *    remainder sizes.
+ *
+ * 3) On other cases, round each remainder part to win_align to get the gap
+ *    size. Sometimes, tighter packing might be possible but due to how
+ *    sizing and assignment are made in different phases, it is not always
+ *    possible to predict where each resource is assigned. Thus, the sizing
+ *    has to play safe even if it may overestimate in some cases.
+ */
+static resource_size_t calculate_win_gap_size(struct pci_bus *bus,
+					      struct resource *b_res,
+					      resource_size_t win_align,
+					      bool optional,
+					      struct list_head *realloc_head)
+{
+	resource_size_t safe_gap = 0, remainders = 0;
+	unsigned int nonaligning = 0;
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
+		int i;
+
+		pci_dev_for_each_resource(dev, r, i) {
+			resource_size_t r_size, remainder, aligning;
+
+			if (!pdev_resources_assignable(dev) ||
+			    !pdev_resource_should_fit(dev, r))
+				continue;
+			if (b_res != pbus_select_window(bus, r))
+				continue;
+
+			if (!optional && pci_resource_is_optional(dev, i))
+				continue;
+
+			r_size = resource_size(r);
+			if (realloc_head && optional)
+				r_size += get_res_add_size(realloc_head, r);
+			if (r_size <= win_align)
+				continue;
+
+			aligning = ALIGN_DOWN(r_size, win_align);
+			remainder = r_size - aligning;
+			if (!remainder)
+				continue;
+
+			nonaligning++;
+			remainders += remainder;
+			safe_gap += win_align - remainder;
+		}
+	}
+
+	if (nonaligning == 2 && (remainders <= win_align))
+		return win_align - remainders;
+
+	if (nonaligning >= 2)
+		return safe_gap;
+
+	return 0;
+}
+
 /*
  * Calculate bridge window head alignment that leaves no gaps in between
  * resources.
@@ -1281,6 +1354,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	int order, max_order;
 	resource_size_t children_add_size = 0;
 	resource_size_t add_align = 0;
+	resource_size_t gap_size;
 
 	if (!b_res)
 		return;
@@ -1345,7 +1419,9 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	win_align = pci_min_window_alignment(bus, b_res->flags);
 	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
-	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
+	gap_size = calculate_win_gap_size(bus, b_res, min_align, !realloc_head,
+					  realloc_head);
+	size0 = calculate_memsize(size + gap_size, realloc_head ? 0 : add_size,
 				  0, win_align);
 
 	if (size0) {
@@ -1355,8 +1431,10 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 
 	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
 		add_align = max(min_align, add_align);
-		size1 = calculate_memsize(size, add_size, children_add_size,
-					  win_align);
+		gap_size = calculate_win_gap_size(bus, b_res, add_align, true,
+						  realloc_head);
+		size1 = calculate_memsize(size + gap_size, add_size,
+					  children_add_size, win_align);
 	}
 
 	if (!size0 && !size1) {
-- 
2.47.3

