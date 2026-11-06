Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972734;
	b=GzQbp/gX8hULMMqAZWIDVHrYgiGbKNi15eABE2kGWYx411pZEwFYWJmjoWSxD5Ceu5xn
	 WUY4uno7hNoQwRcSXBctZGDEBDZBeUoXwYqXX4FvCJvqadMtd0g6nSXCADN097WL0yujE
	 CO/oNVDShToKkyLbklzqaE3vi/6yXCJoxOPfHcElL8rR/dO7PoxYwFlLy8Y3NvVoHAnZF
	 tnSvWCO7ozibXIjWQB08INQBE3hHMq9ebiNu4tW7abETMOWwDyCkunKPSlB5o6qXgGOlO
	 gzSebjA7nDwWxwMXgNwLXrskgVllbox3XaaKqCwQaANkIRWnxbI+lnGSOthtbA7CiJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972734;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=UFwXQwxVpHxsg2Cs/qfLUW4k+9FSMUZHDI/9ORiqiYQ=;
	b=IK/Rf6ZlbJuAj/BABMXteVVEZVEfuLH0RT2k0nLjbxdWQ/Y/CXIkcjZaDGdcVcyicYcJ
	 Z/Lo2gIm6WYcLLVEBWhKrrzZPcvkZf+8zet5G5m0HhP7howlSOOL6E+2y7cnNUc9HJy4T
	 sVuEAN7TtorCievzS7fZjgcs1mb6r1w8jkfeFaUA2zSOKFjMgZezRzlpTpiK/DzsVUxxe
	 4We+iX10+CZhUecN4VstM5GEn0Y0zSVFKqbjM9Skop1IXqwpb35XWPVQ7Rhm397v3tD3A
	 ASupjr2SNlykm1AymD5tUe6kc3dolqqS6KDMnPAZ8uBUzs0vzL288Er7ZXI+dGjVhkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R3Vl0eoS;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B683606EEB5;
	Fri,  6 Nov 2026 13:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B683606EEB5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R3Vl0eoS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972734; x=1825508734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3O5ekmB1dHv+tm3BCy6+VTlJkA1PwoegDkJR0441j9A=;
  b=R3Vl0eoSqYhvCQSHnBiYQUzo2dK+eMu54HczeRBgViaFopXNR6Fpab5N
   /y7+O17x/Du7/ts4C28KoK9Qy0j+EZXacyxUwHz0iayIVWMdOAA7aK/Kz
   SuNGVYSifGvhiFTf0z+f6/ITPZUU0ZgoIDuao3JKEjvbyKhkQEvRvH7mi
   EA0mBEl4b4G8V3drVC4v9KUBvmuT7UVlRxeV3nEYUnw98b8y+1CdhEXiS
   8LtCFo3GV1bSgwTanXSEYsgy1J0RkmplbW7kkveU1ZsRnE8KpG3DRHGbc
   cr2hQjKYlHAsnns2zgQelOuFO426G86V3KF/aUZsEQGLD+S8ztF+6hERA
   g==;
X-CSE-ConnectionGUID: KDn424GwTxij1uBhaSkIQQ==
X-CSE-MsgGUID: 4zGSTjFOSd28LkslVzpJ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2662098"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2662098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:45:33 -0800
X-CSE-ConnectionGUID: fPT31InaRi6PkCcfkz3Xhg==
X-CSE-MsgGUID: 8dwdWGURRqOBEEXAFsgeVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7843846"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:45:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>
Subject: [PATCH v5 09/14] PCI: Place resources to either edge of the window
Date: Fri,  6 Nov 2026 15:43:30 +0200
Message-ID: <20261106134341.39493-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
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

PCI resource assignment phase is based on a greedy algorithm. The
resources are assigned in descending order of required alignment.
Because the PCI BARs are power-of-two sized resources, it mostly works
(bridge windows and VF BARs are composite resources that might not
necessarily have power-of-two size but internally they are still
composed of BARs).

The resource assignment prior to the commit 9036bd0efcb6 ("PCI: Align
head space better") placed resources towards the left edge of the
window. Tha commit altered assignment for resources whose size is not a
perfect multiple of the required alignment by moving the remainder
before the left edge of the window if possible.

The behavior after the commit 9036bd0efcb6 ("PCI: Align head space
better") may result in problems when a bridge window consists of one
large alignment resource and a composite one with a smaller alignment
(this is a typical setup for GPU's PF BAR and VF BARs). The resource
with the largest alignment is assigned first and placed such that the
remainder space is left of the assigned resource, which effectively
splits the remaining space into two. While the VF BAR could fit to the
remaining space, it requires contiguous free space that is no longer
there because the large resource is now in the middle.

In this log excerpt, BAR 2 is placed in the middle of the window blocking
the larger VF BAR 2 from fitting anywhere:

pci 0000:03:01.0: bridge window [mem 0xa9f8000000-0xbfffffffff 64bit pref]: assigned
pci 0000:04:00.0: BAR 2 [mem 0xb000000000-0xb7ffffffff 64bit pref]: assigned
pci 0000:04:00.0: VF BAR 2 [mem size 0xe00000000 64bit pref]: can't assign; no space
pci 0000:04:00.0: VF BAR 2 [mem size 0xe00000000 64bit pref]: failed to assign

The old behavior, despite being greedy, naturally consumed space from
the left edge leaving the remainder space adjacent to the other free
space. When remainder space is at the left edge of the window, the
greedy algorithm should instead assign to the right edge of the window.
(If both ends do align, either end works equally.)

While defining window edge aware resource assignment algorithm, one
additional thing is useful to note. In DT setups the bridge
windows/root bus resources are often very precisely sized, with right
edge of the window having much smaller alignment than the left edge.
They also often come with a small BAR that should be placed to the
right edge to not block bridge window placed to the left edge of the
window. The bridge window may be entirely optional at this point
because of hotplug. The resource assignment fallback phase assigns
mandatory resources first and in such a case, small BAR gets assigned
first.

One example where mandatory BAR 0 blocks bridge windows from fitting
(both bridge windows wouldn't fit because of qemu not providing enough
space for both bridge windows but one should fit like it was originally
set up by the platform):

pci_bus 0000:0a: root bus resource [mem 0x10a00000-0x10c00fff window]
pci 0000:0a:00.0: [1b36:000c] type 01 class 0x060400 PCIe Root Port
pci 0000:0a:00.0: BAR 0 [mem 0x10c00000-0x10c00fff]
pci 0000:0a:00.0: PCI bridge to [bus 0b-0d]
pci 0000:0a:00.0:   bridge window [mem 0x10a00000-0x10bfffff]
pci 0000:0a:00.0: enabling Extended Tags
pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 200000 add_align 100000
pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0b-0d] add_size 200000 add_align 100000
pci 0000:0a:00.0: bridge window [mem 0x10a00000-0x10bfffff]: assigned
pci 0000:0a:00.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
pci 0000:0a:00.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
pci 0000:0a:00.0: BAR 0 [mem 0x10c00000-0x10c00fff]: assigned
pci 0000:0a:00.0: bridge window [mem 0x10a00000-0x10bfffff]: releasing
pci 0000:0a:00.0: BAR 0 [mem 0x10c00000-0x10c00fff]: releasing
pci 0000:0a:00.0: BAR 0 [mem 0x10a00000-0x10a00fff]: assigned
pci 0000:0a:00.0: bridge window [mem size 0x00200000]: can't assign; no space
pci 0000:0a:00.0: bridge window [mem size 0x00200000]: failed to assign
pci 0000:0a:00.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
pci 0000:0a:00.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
pci_bus 0000:0a: Some PCI device resources are unassigned, try booting with pci=realloc

To achieve best generalization of the approach, the selection algorithm
avoids consuming space from the window edge that can fit largest
aligning resources in the future, whenever possible. This approach has
certain level of preference towards the right edge to keep the largest
alignment available (which is usually at the left edge), which
unfortunately may uncover platform issues.

The candidate selection compares the properties of the remaining free
space using cmp_free_candidate() that compares (in decreasing order of
priority):

 1. the largest contiguous free space,
 2. the largest naturally aligning power-of-two-sized address range
    within,
 3. the largest alignment of the start address for the naturally
    aligning free space range (from check 2).
 4. the largest alignment of the start address of the free space.

This precedence is a balancing act. In cases where not all resources
fit, having check 2 before 1 could be helpful for getting optional
resources assigned (when retrying assignments with mandatory resources
first and then assigning optional resources on best-effort basis). It
may be useful to revisit the order or add logic to pick the precedence
on a case-by-case basis once we get large scale experience and problem
reports.

Fixes: 9036bd0efcb6 ("PCI: Align head space better")
Reported-by: Alexey Fomenko <alexey.fomenko@intel.com>
Tested-by: Alexey Fomenko <alexey.fomenko@intel.com>
Reported-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Both reports are private discussions (Eric's report started as public
and produced another fix but further problem was only visible in the
privately sent logs after that). Thus no links.
---
 drivers/pci/pci.h       |   4 +
 drivers/pci/setup-bus.c |   4 -
 drivers/pci/setup-res.c | 219 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 204 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e6e2afcceb33..31ffae9ce557 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -115,6 +115,10 @@ struct pcie_tlp_log;
 #define PCI_BUS_BRIDGE_MEM_WINDOW	1
 #define PCI_BUS_BRIDGE_PREF_MEM_WINDOW	2
 
+#define PCI_RES_TYPE_MASK \
+	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
+	 IORESOURCE_MEM_64)
+
 #define PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c3c229ed320a..5f8320cac504 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -32,10 +32,6 @@
 #include <linux/acpi.h>
 #include "pci.h"
 
-#define PCI_RES_TYPE_MASK \
-	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
-	 IORESOURCE_MEM_64)
-
 unsigned int pci_flags;
 EXPORT_SYMBOL_GPL(pci_flags);
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 9c55b9f9462c..ea256eb806a5 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -13,8 +13,12 @@
  *	     Resource sorting
  */
 
+#include <linux/align.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/limits.h>
+#include <linux/log2.h>
+#include <linux/minmax.h>
 #include <linux/pci.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
@@ -274,10 +278,112 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
 	return resource_alignment(res);
 }
 
+static resource_size_t pci_max_natural_size(const struct resource *res,
+					    resource_size_t *max_align)
+{
+	resource_size_t powof2, natural_start, natural_end;
+	resource_size_t size = resource_size(res);
+
+	*max_align = 1;
+	if (!size)
+		return 0;
+
+	powof2 = rounddown_pow_of_two_u64(size);
+	natural_start = ALIGN(res->start, powof2);
+	/* end = ~0 first overflows, then -1 brings it back */
+	if (natural_start >= ALIGN_DOWN(res->end + 1, powof2) - 1) {
+		powof2 = max(powof2 / 2, 1U);
+		/*
+		 * Corner case: with start at an odd alignment multiple, there
+		 * are two powof2 sized blocks.
+		 */
+		natural_start = ALIGN(res->start, powof2);
+		natural_end = ALIGN_DOWN(res->end + 1 - powof2, powof2);
+		*max_align <<= max(natural_start ? __ffs64(natural_start) : 0,
+				   natural_end ? __ffs64(natural_end) : 0);
+
+	} else if (natural_start) {
+		*max_align <<= __ffs64(natural_start);
+	}
+
+	/* Normal PCI resources cannot have align 1. */
+	if (*max_align == 1) {
+		/*
+		 * Zero address has infinite alignment, return the largest
+		 * representable number even if it's not a power of two.
+		 */
+		*max_align = RESOURCE_SIZE_MAX;
+	}
+
+	return powof2;
+}
+
+struct free_candidate_info {
+	resource_size_t size;
+	resource_size_t natural_size;
+	resource_size_t max_align;
+	resource_size_t left_align;
+};
+
 /*
- * For mem bridge windows, try to relocate tail remainder space to space
- * before res->start if there's enough free space there. This enables
- * tighter packing for resources.
+ * Select resource placement based on the remaining free space. Pick the
+ * candidate with which the remaining free space has (in decreasing order of
+ * priority):
+ *
+ *   1. the largest contiguous free space,
+ *   2. the largest naturally aligning power-of-two-sized address range within,
+ *   3. the largest alignment of the start address for the naturally aligning
+ *      free space range (from check 2),
+ *   4. the largest alignment of the start address of the free space.
+ */
+static int cmp_free_candidate(const struct free_candidate_info *a,
+			      const struct free_candidate_info *b)
+{
+	if (a->size != b->size)
+		return a->size < b->size ? -1 : 1;
+	if (a->natural_size != b->natural_size)
+		return a->natural_size < b->natural_size ? -1 : 1;
+	if (a->max_align != b->max_align)
+		return a->max_align < b->max_align ? -1 : 1;
+	if (a->left_align != b->left_align)
+		return a->left_align < b->left_align ? -1 : 1;
+
+	return 0;
+}
+
+/**
+ * pci_align_resource - Places resource into empty space range
+ * @rr: PCI resource request data
+ * @res: Candidate range calculated by caller (not among @rr->dev's resources!)
+ * @empty_res: Full free space range
+ * @size: Required size for the resource
+ * @align: Required alignment (see below for details)
+ *
+ * Places resource inside @empty_res honoring @size and @align.
+ *
+ * Returns: start address for the resource.
+ */
+/*
+ * Following candidate logic only applies to mem resources currently. For
+ * composite resources not divisible by @align, @align does not apply to
+ * non-aligning remainder part giving some leeway for its placement. There
+ * are 4 candidate positions:
+ *
+ *           W0WWW0WWW0WWW
+ * 0.         AAAAr
+ * 1.        rAAAA
+ * 2.             AAAAr
+ * 3.                rAAAA
+ *
+ * W = bridge window
+ * 0 = bridge window offset matching align
+ * A = aligning part of size (size rounded down by align)
+ * r = non-aligning remainder
+ *
+ * Candidates 0 & 2 and 1 & 3 may degenerate to the same address range.
+ *
+ * Select resource placement based on the remaining free space. Candidates 0
+ * & 1 check only right edge free space and 2 & 3 the left edge.
  */
 resource_size_t pci_align_resource(struct pci_resreq_data *rr,
 				   const struct resource *res,
@@ -286,31 +392,106 @@ resource_size_t pci_align_resource(struct pci_resreq_data *rr,
 				   resource_size_t align)
 {
 	struct pci_dev *dev = rr->dev;
-	resource_size_t remainder, start_addr;
+	unsigned long type = res->flags & PCI_RES_TYPE_MASK;
+	struct free_candidate_info best_info = {};
+	resource_size_t aligning, remainder;
+	struct resource candidate[4];
+	unsigned int i;
+	int best = -1;
 
 	if (!(res->flags & IORESOURCE_MEM))
 		return res->start;
 
-	if (rr->min_align)
-		return res->start;
-
-	if (IS_ALIGNED(size, align))
+	/*
+	 * Not using large enough align when minimum alignment is in use is
+	 * a caller-side problem which likely caused also mis-sizing the
+	 * corresponding window so do not attempt to solve it here (nor
+	 * possibly make the problem worse by applying remainder relocation
+	 * below).
+	 *
+	 * Practical impact of this is expected to be around zero (or the
+	 * callers would have been already fixed).
+	 *
+	 * TODO: Fix all callers and remove this.
+	 */
+	if (rr->min_align > align) {
+		pci_dbg(dev, "%pR: minimum alignment exceeds align (%llx > %llx)\n",
+			res,
+			(unsigned long long)rr->min_align,
+			(unsigned long long)align);
 		return res->start;
+	}
 
 	remainder = size - ALIGN_DOWN(size, align);
-	/* Don't mess with size that doesn't align with window size granularity */
-	if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, res->flags)))
-		return res->start;
-	/* Try to place remainder that doesn't fill align before */
-	if (res->start < remainder)
-		return res->start;
-	start_addr = res->start - remainder;
-	if (empty_res->start > start_addr)
+	aligning = size - remainder;
+	if (!aligning)
 		return res->start;
 
-	pci_dbg(dev, "%pR: moving candidate start address below align to %llx\n",
-		res, (unsigned long long)start_addr);
-	return start_addr;
+	candidate[0] = DEFINE_RES(ALIGN(empty_res->start, align), size, type);
+	candidate[1] = DEFINE_RES(ALIGN(empty_res->start, align) - remainder,
+				  size, type);
+	candidate[2] = DEFINE_RES(ALIGN_DOWN(empty_res->end + 1 - remainder, align) -
+				  aligning, size, type);
+	candidate[3] = DEFINE_RES(ALIGN_DOWN(empty_res->end + 1, align) - size,
+				  size, type);
+
+	for (i = 0; i < ARRAY_SIZE(candidate); i++) {
+		struct free_candidate_info info;
+		struct resource remaining;
+
+		if ((candidate[i].start > candidate[i].end) ||
+		    !__resource_contains_unbound(empty_res, &candidate[i])) {
+			pci_dbg(dev, "%pR: candidate %u not within free space %pR\n",
+				&candidate[i], i, empty_res);
+			continue;
+		}
+
+		if (rr->min_align &&
+		    !IS_ALIGNED(candidate[i].start, rr->min_align)) {
+			pci_dbg(dev, "%pR: candidate %u skipped due to alignment lower bound %llx\n",
+				&candidate[i], i,
+				(unsigned long long)rr->min_align);
+			continue;
+		}
+
+		remaining.flags = type;
+		if (i <= 1) {
+			remaining.start = candidate[i].end + 1;
+			remaining.end = empty_res->end;
+		} else {
+			remaining.start = empty_res->start;
+			remaining.end = candidate[i].start - 1;
+		}
+
+		info.size = resource_size(&remaining);
+		info.natural_size = pci_max_natural_size(&remaining,
+							 &info.max_align);
+		info.left_align = remaining.start ?
+				  (1ULL << __ffs64(remaining.start)) :
+				  RESOURCE_SIZE_MAX;
+		pci_dbg(dev, "%pR: candidate %u free space size=%llx natural_size=%llx max_align=%llx left_align=%llx\n",
+			&candidate[i], i,
+			(unsigned long long)info.size,
+			(unsigned long long)info.natural_size,
+			(unsigned long long)info.max_align,
+			(unsigned long long)info.left_align);
+		if ((best < 0) || cmp_free_candidate(&info, &best_info) > 0) {
+			best = i;
+			best_info = info;
+		}
+	}
+
+	/* None fits? Return address where size definitely won't fit. */
+	if (best < 0)
+		return empty_res->end;
+
+	pci_dbg(dev, "%pR: candidate %u selected (free space %pR), size: %llx + %llx, align: %llx\n",
+		&candidate[best], best, empty_res,
+		(unsigned long long)aligning,
+		(unsigned long long)remainder,
+		(unsigned long long)align);
+
+	return candidate[best].start;
 }
 
 /*
-- 
2.47.3

