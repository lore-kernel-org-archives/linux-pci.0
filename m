Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB74C48AE10;
	Fri,  2 Oct 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940890; cv=none; b=IBrfmwft/L/4EDqnYyDzlIeY/fNxUJAx9NE2bIUMsTrFJq88pHaUjAAROR8pejQyn8KfjWvA2Zb7rZ5ekM7ivJcemJipbAOddnCgHaJDUl+XgdoRNOx+ulM+Jim6gSlQ7svlosZyr3IhtIYCqe3pv7he8iu98067hd0p4K+A/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940890; c=relaxed/simple;
	bh=mVg0dFajhfPdQSRMnAG4sTlZJBNdH7vXdDOsm/cXoDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4IgwTEd/C2RPktm2lo8b0i8SZzMiw9xxEMhWMlYd78RRQ5EDYbdfbDHya1pwQ+QQYylji/ySZwMZWnfV5rY9A5mPmi9mZleAcovHf7JrHQGoVFzvuX7z1c7BRV8kVJNGU+ATlYvn1B0c7QUi3o+mgcr5GG/9NP0RDLjiWvr37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLTtzAlI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLTtzAlI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790940886; x=1822476886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mVg0dFajhfPdQSRMnAG4sTlZJBNdH7vXdDOsm/cXoDQ=;
  b=fLTtzAlIHrzXxBSrjx7BS/H9EGOVzLzdt/DeHtMVrX/Fi5CbK8SXZfRN
   OFYRiM9gQfwQGp++fPF7s9TboJvvq139FCt3MKlun1aSnrQmXkEKmEfUd
   61pjwH3lqs/VJ/ZR6KZ59T+PquEhv2kV/L3BuMq4keCip8xgn2ARa9tD6
   iZPhdfSqdcgPwe/mYl/nxUQ32jH8amCybBux6Zy1LTk85KVNfGE0gniYw
   qilv+SwHMIjioiPtGWozVr8/mRvwL0xq7LeEwDDg8C87LIyxveoRGUsfY
   nFRlWk/ElERNCUFaxe/YTXxFSoWY8r5RKk8eqtFXXy+IcuPYXzN46g9w+
   Q==;
X-CSE-ConnectionGUID: SQAqkn1tS2SCkp7dq0dyog==
X-CSE-MsgGUID: kzCXXYhoQJ+1GIUquVHoWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90659855"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90659855"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:34:43 -0700
X-CSE-ConnectionGUID: SQ/RCPJGTTiWN+U+NpZMXw==
X-CSE-MsgGUID: UgQ+rygGSHCI3ba002HWYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274040273"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.243])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:34:38 -0700
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
Cc: Bradley Morgan <brads@mainlining.org>,
	Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 5/7] PCI: Place resources to either edge of the window
Date: Fri,  2 Oct 2026 14:33:13 +0300
Message-ID: <20261002113319.6652-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI resource assignment phase based on a greedy algorithm. The
resources are assigned in descending order of required alignment.
Because the PCI BARs are power-of-two sized resources, it mostly works
(bridge windows and VF BARs are composite resources that might not
necessarily have power-of-two size but internally they are still
composed of BARs).

The resource assignment prior to the commit 9036bd0efcb6 ("PCI: Align
head space better") placed resource to/towards the left edge of the
window. The commit 9036bd0efcb6 ("PCI: Align head space better")
altered assignment for resources whose size is not a perfect multiple
of the required alignment by moving the remainder before the left edge
of the window if possible.

The behavior after the commit 9036bd0efcb6 ("PCI: Align head space
better") may result in problems when a bridge window consists of one
large alignment resource and a composite one with a smaller alignment
(this is a typical setup for GPUs PF BAR and VF BARs). The resource
with largest alignment is assigned first and placed such that the
remainder space is left of the assigned resource, which effectively
splits the remaining space into two. While the VF BAR could fit to the
remaining space, it requires continuous free space that is no longer
there because the large resource is now in the middle.

In this log exceprt, BAR 2 is placed in the middle of the window blocking
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
edge of the window having much smaller alignment that the left edge.
They also often come with a small BAR that should be placed to the
right edge to not block bridge window placed to the left edge of the
window. The bridge window may be entirely optional at this point
because of hotplug. The resource assignment fallback phase assigns
mandatory resources first and in such a case, small BAR gets assigned
first.

One example where mandatory BAR 0 blocks bridge windows from fitting
(both bridge windows wouldn't fit because of qemu not providing enough
space for both bridge windows but one should fit like it was originally
setup by the platform):

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

To achieve best generalization of the approach, the solution should
also avoid consuming space from the window edge that can fit largest
aligning resources in the future, whenever possible.

Fixes: 9036bd0efcb6 ("PCI: Align head space better")
Reported-by: Alexey Fomenko <alexey.fomenko@intel.com>
Tested-by: Alexey Fomenko <alexey.fomenko@intel.com>
Reported-by: Eric Auger <eauger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Both reports are private discussions (Eric's report started as public
and produced another fix but further problem was only visible in the
privately send logs after that). Thus no links.
---
 drivers/pci/pci.h       |   4 +
 drivers/pci/setup-bus.c |   4 -
 drivers/pci/setup-res.c | 174 ++++++++++++++++++++++++++++++++++------
 3 files changed, 152 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..82a5fd267f5b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -106,6 +106,10 @@ struct pcie_tlp_log;
 #define PCI_BUS_BRIDGE_MEM_WINDOW	1
 #define PCI_BUS_BRIDGE_PREF_MEM_WINDOW	2
 
+#define PCI_RES_TYPE_MASK \
+	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
+	 IORESOURCE_MEM_64)
+
 #define PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e8c94aa1d3c1..7ca0e9f4ffb6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -31,10 +31,6 @@
 #include <linux/acpi.h>
 #include "pci.h"
 
-#define PCI_RES_TYPE_MASK \
-	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
-	 IORESOURCE_MEM_64)
-
 unsigned int pci_flags;
 EXPORT_SYMBOL_GPL(pci_flags);
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 2ca3784aa323..4c73bf6e0f70 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -17,6 +17,9 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/limits.h>
+#include <linux/log2.h>
+#include <linux/minmax.h>
 #include <linux/pci.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
@@ -262,16 +265,89 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
 	return resource_alignment(res);
 }
 
+static resource_size_t pci_max_natural_size(const struct resource *res,
+					    resource_size_t *max_align)
+{
+	resource_size_t size = resource_size(res);
+	resource_size_t powof2, natural_start;
+
+	*max_align = 1;
+	if (!size)
+		return 0;
+
+	powof2 = rounddown_pow_of_two(size);
+	natural_start = ALIGN(res->start, powof2);
+	/* end = ~0 first overflows, then -1 brings it back */
+	if (natural_start >= ALIGN_DOWN(res->end + 1, powof2) - 1) {
+		powof2 = max(powof2 / 2, 1U);
+		natural_start = ALIGN(res->start, powof2);
+	}
+
+	if (natural_start) {
+		*max_align <<= __ffs(natural_start);
+	} else {
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
 static resource_size_t pci_resreq_remainder(resource_size_t size,
 					    resource_size_t align)
 {
 	return size - ALIGN_DOWN(size, align);
 }
 
+/**
+ * pci_align_resource - Places resource into empty space range
+ * @rr: PCI resource request data
+ * @res: Candidate range calculated by caller (not among @dev's resources!)
+ * @empty_res: Full free space range
+ * @size: Required size for the resource
+ * @align: Required alignment (see below for details)
+ *
+ * Places resource inside @empty_res honoring @size and @align.
+ *
+ * Returns: start address for the resource.
+ */
 /*
- * For mem bridge windows, try to relocate tail remainder space to space
- * before res->start if there's enough free space there. This enables
- * tighter packing for resources.
+ * Following candidate logic only applies to mem resources currently. For
+ * composite resources not divisable by @align, @align does not apply to
+ * non-aligning remainder part giving some leeway for its placement. There
+ * are 4 candidate positions:
+ *
+ *           W0WWW0WWW0WWW
+ * 1.         AAAAr
+ * 2.        rAAAA
+ * 3.             AAAAr
+ * 4.                rAAAA
+ *
+ * W = bridge window
+ * 0 = bridge window offset matching align
+ * A = aligning part of size (size rounded down by align)
+ * r = non-aligning remainder
+ *
+ * Cases 1 & 3 and 2 & 4 may degenerate to the same candidate.
+ *
+ * Select resource placement based on the remaining free space. Pick the
+ * candidate with which the remaining free space has (in decreasing order of
+ * priority):
+ *
+ *   1. the largest naturally aligning power-of-two-sized address range within,
+ *   2. the largest continous free space,
+ *   3. the largest alignment of the start address for the naturally aligning
+ *      free space range (from check 1).
+ *
+ * Cases 1 & 2 check only right edge free space and 3 & 4 the left edge.
+ *
+ * When user has requested specific alignmnet, only candidates 1 & 3 can
+ * qualify. TODO: If the resulting alignment with the remainder at the
+ * left edge is enough to satisfy user's request, all candidates could be
+ * allowed.
  */
 resource_size_t pci_align_resource(struct pci_resreq_data *rr,
 				   const struct resource *res,
@@ -280,38 +356,84 @@ resource_size_t pci_align_resource(struct pci_resreq_data *rr,
 				   resource_size_t align)
 {
 	struct pci_dev *dev = rr->dev;
-	resource_size_t remainder, start_addr;
+	unsigned long type = res->flags & PCI_RES_TYPE_MASK;
+	resource_size_t best_natural_size = 0, best_size = 0, best_maxalign = 0;
+	resource_size_t aligning, remainder;
+	struct resource candidate[4];
+	unsigned int i;
+	int best = -1;
 
 	if (!(res->flags & IORESOURCE_MEM))
 		return res->start;
 
-	if (rr->user_align)
-		return res->start;
-
 	remainder = pci_resreq_remainder(size, align);
-	if (!remainder)
-		return res->start;
+	aligning = size - remainder;
+
+	candidate[0] = DEFINE_RES(ALIGN(empty_res->start, align), size, type);
+	candidate[1] = DEFINE_RES(ALIGN(empty_res->start, align) - remainder,
+				  size, type);
+	candidate[2] = DEFINE_RES(ALIGN_DOWN(empty_res->end + 1 - remainder, align) -
+				  aligning, size, type);
+	candidate[3] = DEFINE_RES(ALIGN_DOWN(empty_res->end + 1, align) - size,
+				  size, type);
+
+	for (i = 0; i < ARRAY_SIZE(candidate); i++) {
+		struct resource remaining;
+		resource_size_t natural_size, size, maxalign;
+
+		if ((candidate[i].start > candidate[i].end) ||
+		    !__resource_contains_unbound(empty_res, &candidate[i])) {
+			pci_dbg(dev, "%pR: candidate %u not within free space %pR\n",
+				&candidate[i], i, empty_res);
+			continue;
+		}
 
-	/*
-	 * Size constraints forced an early start move in
-	 * pci_check_and_align_resource()?
-	 */
-	if (!IS_ALIGNED(res->start, align))
-		return res->start;
+		if (rr->user_align && (i == 1 || i == 3)) {
+			pci_dbg(dev, "%pR: candidate %u skipped due to resource_alignment=%llx\n",
+				&candidate[i], i,
+				(unsigned long long)rr->user_align);
+			continue;
+		}
 
-	/* Don't mess with size that doesn't align with window size granularity */
-	if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, res->flags)))
-		return res->start;
-	/* Try to place remainder that doesn't fill align before */
-	if (res->start < remainder)
-		return res->start;
-	start_addr = res->start - remainder;
-	if (empty_res->start > start_addr)
+		remaining.flags = type;
+		if (i <= 1) {
+			remaining.start = candidate[i].end + 1;
+			remaining.end = empty_res->end;
+		} else {
+			remaining.start = empty_res->start;
+			remaining.end = candidate[i].start - 1;
+		}
+
+		natural_size = pci_max_natural_size(&remaining, &maxalign);
+		size = resource_size(&remaining);
+		pci_dbg(dev, "%pR: candidate %u free space naturalsize=%llx size=%llx maxalign=%llx\n",
+			&candidate[i], i,
+			(unsigned long long)natural_size,
+			(unsigned long long)size,
+			(unsigned long long)maxalign);
+		if ((best < 0) ||
+		    (natural_size > best_natural_size) ||
+		    (natural_size == best_natural_size && size > best_size) ||
+		    (natural_size == best_natural_size && size == best_size &&
+		     maxalign > best_maxalign)) {
+			best = i;
+			best_natural_size = natural_size;
+			best_size = size;
+			best_maxalign = maxalign;
+		}
+	}
+
+	/* None fits? Return some address and let the caller deal with it. */
+	if (best == -1)
 		return res->start;
 
-	pci_dbg(dev, "%pR: moving candidate start address below align to %llx\n",
-		res, (unsigned long long)start_addr);
-	return start_addr;
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

