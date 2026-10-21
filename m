Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587105;
	b=46xw3Xb0qlErxaWLCkegXnP5Ey3ZigoBuF2f8JMjnMl07IWg14ijOQI7ChoPghy461z3
	 nH8vq/Pz56HM5ZwKaQYzjKOLlj2uHL9rCLLrpn/PjlS5I/8hptfP1DmqP+P3z3qEtKkDp
	 /S/X7Fqi2XC4IUMwpoOSpaK/YeVeM2mhPzzPK8vHsBd98EmSU+2E5JWg9dkxuWqMxRHSj
	 9hYsCzFXb6oyBS8MrSUs1ighZq1fuDElBvtC0jE1TNQFV8U9C1tWQ0nzpxUddqkF6QglS
	 vGG5Hgq/E7xWjHtM/PgR0QEYi/09GTrHSUcpM2ZXlSLBDctTpyI1HvHFnwnE1X6ctFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587105;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nTACmC2zvEZmDZwuiJOWih6JraGJbBCkoflRslUyg/0=;
	b=41XExl9AvnMIXpneWkd2R4hc9tIk9P8damqk1kORjz6RRB6T35RBifdJbedu/+nhamNt
	 OwpY8EXAT5M598WIm3DNahmF56Axvwu/zCZd/OYfepxtMLhwIYYjmBmNdzZX1a4odZHYl
	 j4z31/6YUdKHNoKTRNqC4fGB43WDvXiS7hPH9VNwijMuBOMg/q45icYVBOOiLh3icFwWv
	 pg0iQ2d3G3Q/PqWRhCQlk6fGkoSQJwQccZwM/IKBM7glKNiSVoT7VGGFWcHJ5fx/kmpK0
	 x/5aHiVMV5DPlhK/laqFxH0rB24RAiwexyC1/v83yquKUXfgpXZpuhm42hKB0sExYMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="j50/C93y";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E7606A31D;
	Wed, 21 Oct 2026 12:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 810E7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j50/C93y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792587106; x=1824123106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1HXJDgQRHqibBiKPSwVGUh4hSAocx7qJsryn8NTUcU=;
  b=j50/C93yl+t/RTg0SXnF3pb85wNJLKWDWW0zWcj+yOQqg34gZLBvWUWs
   AI9nL1oKtekIChIBC/jD5eVpj2kY4XPrdLR1OhEbv0cNoAjyRk3WDWqJr
   YueeqU49zmxQ2XDfG6guBr5y7S59Tkx/sjlOoxzX/jUx5Rq6SSfmnHk8T
   pouzn3YS+1v+uqYl2pcT2yvUqDydXrhAA32mDHIiwZV6aN3/nFQDU/p90
   FKb06XLdBd2Yq7NGo6CYMzH14yZ3CCcbDBcmlMUugWGwbdOux4vhrGzCM
   wEEOJvCdua14W86B4PONxGJ9uzrf+9NaxyQAnz9GPsMmGjbwqonq9+cOG
   Q==;
X-CSE-ConnectionGUID: mlXC/ZWFSgePC2FmbFLljg==
X-CSE-MsgGUID: zrqrrwvlRFSGcbss4TZThw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1319953"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1319953"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:51:45 -0700
X-CSE-ConnectionGUID: fqWTILxFSFemIpCM69Ymig==
X-CSE-MsgGUID: OlLzXMrfSd22zd9NARe4sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3137858"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:51:40 -0700
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
Subject: [PATCH v4 7/7] PCI: Fix composite resource sizing
Date: Wed, 21 Oct 2026 15:49:52 +0300
Message-ID: <20261021124956.4250-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
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

