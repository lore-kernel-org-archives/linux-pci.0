Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106C5304C6;
	Wed, 23 Sep 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169539; cv=none; b=tkqu9DOvROVUkCScHvcuV4gsX81z4QBrl3YQwIBVTzegMMzvuIb07DEDyA4jZSIry2prWH6jJLzAcNZE+wjkhoyIIc1hMndt5SptN+K5BMRocw2YfN9mZPDvejE0qRlHYa4b+VdON5vmKlDNKLG1ximraR6QnfmS5AOd8sLlcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169539; c=relaxed/simple;
	bh=wWH4fKsWOyheCbNebbp+8OlkINLgIfqoiOwkTCoUDzk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hg2T0MwZW/skWUWJsJF527jPqdVwVFtPSdGcTvEYOceljQ1u0yYmLxtCIfJNz9Zx9gsTImSSKm0f4yUxg7K8LbPiYYhtBFKbrDf9+HIrAgvkSx/HZfEGaH/3z8+grCtvA0l3DVH5yR7qz7l7tjW9YYEyfZz0HT2OnWBf2a4kaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drlErN7P; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drlErN7P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790169533; x=1821705533;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=wWH4fKsWOyheCbNebbp+8OlkINLgIfqoiOwkTCoUDzk=;
  b=drlErN7PnqYwFdp6GVqE6RjnTmiqxSCrdWG+fTFPTDmkzEndWcndn8qr
   xMbX+KbMgG1/6Trc5Bo3vN+SA2ESQ3xCcN77n4i5mFr3axGolwg+iCpfV
   hMxtHtnCPVSUHjzMNgfBT3Jm02s9o0bgBK/t2ARmsPw+SwR7VbmWvh0dp
   0GT6TY9HG4PJkLmAQ8D9HP4IdZ7AZRm3hFZiG6ouzkzx/eTdPWMETcNgJ
   2wjAvM7TwAU+bLir0UepqTrBwCorJ6AVQxFd9gfutbW6en8dhZeojCQQR
   uEe+UlPVPgJzxrmJsbvj8HS0rE+Oo7m0QOuO36G82G8JA/2FfXvqJbCFG
   A==;
X-CSE-ConnectionGUID: DR6XR7OqRMauL2cLN5aVug==
X-CSE-MsgGUID: e4SP+jSZRoy/0fwIUcxbMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="94683858"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="94683858"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 06:18:49 -0700
X-CSE-ConnectionGUID: h3cBXUa/SOaGK6vZZ/aHxQ==
X-CSE-MsgGUID: bW+g54EqSaCvFWzquOR33Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="301535283"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 06:18:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] PCI: Fix composite resource sizing
Date: Wed, 23 Sep 2026 16:17:54 +0300
Message-ID: <20260923131757.7792-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com>
References: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com>
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
Link: https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@exabit.io/
Reported-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 79 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7ca0e9f4ffb6..9d828a59bd00 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1164,6 +1164,76 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
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
+					      bool optional)
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
@@ -1281,6 +1351,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	int order, max_order;
 	resource_size_t children_add_size = 0;
 	resource_size_t add_align = 0;
+	resource_size_t gap_size;
 
 	if (!b_res)
 		return;
@@ -1345,7 +1416,8 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	win_align = pci_min_window_alignment(bus, b_res->flags);
 	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
-	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
+	gap_size = calculate_win_gap_size(bus, b_res, min_align, false);
+	size0 = calculate_memsize(size + gap_size, realloc_head ? 0 : add_size,
 				  0, win_align);
 
 	if (size0) {
@@ -1355,8 +1427,9 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 
 	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
 		add_align = max(min_align, add_align);
-		size1 = calculate_memsize(size, add_size, children_add_size,
-					  win_align);
+		gap_size = calculate_win_gap_size(bus, b_res, add_align, true);
+		size1 = calculate_memsize(size + gap_size, add_size,
+					  children_add_size, win_align);
 	}
 
 	if (!size0 && !size1) {
-- 
2.47.3

