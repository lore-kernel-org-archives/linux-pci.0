Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D53E49D2;
	Fri,  2 Oct 2026 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940876; cv=none; b=En3xns5HepvZyNRbY+tkJZpOEEz1HX9OB+xSd3DuIz6Tihld1ZXtCnPMXWttjC4X7kdsdteidxCS/0dUjncixs8XE6/pIrm98gDFdxgc18ajrNM9WIzBywXy21QQfbW3HIH1iyBNPmSPyNackb7Fbr3YOkyLI7jT/CCvsMXjBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940876; c=relaxed/simple;
	bh=nwVSH88CwzBW9nbNuSExvK6OpmR56t/Hn1V1ubOUbLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORwstNv1OCp2aY9PbpMInKjMk4q886cTCDS5zEiSBN6ZTVzRHiu5pkr73Ta9ovLQ7Lh4RfnbX7g5I/C/1SLcZuHb3y242G/sq0Afi98Oo8PvvFNPp3CoExySy2bRsgZgLGEpGzD5Ixwdspuww33OdI6alP47IgVhDcEVyrOpoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcqPEiAb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcqPEiAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790940874; x=1822476874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nwVSH88CwzBW9nbNuSExvK6OpmR56t/Hn1V1ubOUbLQ=;
  b=NcqPEiAbZEocrin4okkRfYDVgOlwiKKwAisOxh4Be1YQdXOtRP6uYdKY
   eX9dliIJwKYgvjGn2AIJu36MSUg6umZtlQ2CJ7/K+q8/UqgeGyuXgUq4a
   7c9M36Lm+aUDAGBO8HYm+64wFEWWF9w++7BdWA0xyKi8JLn25zeljLVGT
   lGqIikK0R1srh4GH4rsialc6Y20U42Zc5W9e0DhAdjF44IP1fcVnibrKc
   GdCoJhVXyV0pgrPEsIY15lZyKgtixmsbVncUkzPBPgSU7cNAP4cHfDKg/
   zGrZVGNBA6iPCPyda4yKHiIg06kyhpcPn1INWUZ0s/LhTKpXF9iknKWyL
   g==;
X-CSE-ConnectionGUID: 4XyI2nQWQTi1d2djz8jXnQ==
X-CSE-MsgGUID: qUdX+h6DRIONFCvY6kbNUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90659817"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90659817"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:34:32 -0700
X-CSE-ConnectionGUID: Zc5BrUmKSqGzP6gZ/ccPhw==
X-CSE-MsgGUID: kBhR36ZvSEuOFhttBNUx7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274040269"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.243])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:34:27 -0700
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
Subject: [PATCH v2 4/7] PCI: Fix nesting windows with remainder at the left edge
Date: Fri,  2 Oct 2026 14:33:12 +0300
Message-ID: <20261002113319.6652-5-ilpo.jarvinen@linux.intel.com>
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

If a bridge window has its non-aligning remainder at the left edge of
the window, assigning a nested bridge window of same size will fail
because resource side code will only allow starting a candicate range
from an aligning address. In such case, aligned address is somewhere in
the middle, not at the left edge of the window. Since the entire
available space is required for full-sized nested bridge window,
resource side code rejects the free space.

To solve this problem, PCI side code has to bypass the resource side
alignment code by giving a smaller alignment and must check the
aligment requirement itself. This allows resource side code to consider
the entire available space as candidate to fit the required size.

Wrap pcibios_align_resource() with PCI core function that performs the
alignment checks and left edge recalculation if needed. As the
alignment given for the resource side code is artificially small, the
real alignment has to be passed through alignf_data.

Fixes: 9036bd0efcb6 ("PCI: Align head space better")
Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I've not seen a report about this problem (thus no log quotes) but with
nested thunderbolt topologies it seems well within realms of possibility
of occurring.
---
 drivers/pci/setup-res.c | 60 +++++++++++++++++++++++++++++++++++++----
 include/linux/pci.h     |  1 +
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 441a62807719..2ca3784aa323 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -13,6 +13,8 @@
  *	     Resource sorting
  */
 
+#include <linux/align.h>
+#include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
@@ -260,6 +262,12 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
 	return resource_alignment(res);
 }
 
+static resource_size_t pci_resreq_remainder(resource_size_t size,
+					    resource_size_t align)
+{
+	return size - ALIGN_DOWN(size, align);
+}
+
 /*
  * For mem bridge windows, try to relocate tail remainder space to space
  * before res->start if there's enough free space there. This enables
@@ -280,10 +288,17 @@ resource_size_t pci_align_resource(struct pci_resreq_data *rr,
 	if (rr->user_align)
 		return res->start;
 
-	if (IS_ALIGNED(size, align))
+	remainder = pci_resreq_remainder(size, align);
+	if (!remainder)
+		return res->start;
+
+	/*
+	 * Size constraints forced an early start move in
+	 * pci_check_and_align_resource()?
+	 */
+	if (!IS_ALIGNED(res->start, align))
 		return res->start;
 
-	remainder = size - ALIGN_DOWN(size, align);
 	/* Don't mess with size that doesn't align with window size granularity */
 	if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, res->flags)))
 		return res->start;
@@ -315,6 +330,33 @@ resource_size_t __weak pcibios_align_resource(void *data,
 	return pci_align_resource(rr, res, empty_res, size, align);
 }
 
+static resource_size_t pci_resreq_check(void *data,
+					const struct resource *res,
+					const struct resource *empty_res,
+					resource_size_t size,
+					resource_size_t min_align)
+{
+	struct pci_resreq_data *rr = data;
+	resource_size_t align = rr->real_align;
+	resource_size_t remainder, start;
+	struct resource tmp = *res;
+
+	if (res->flags & IORESOURCE_MEM && !IS_ALIGNED(res->start, align)) {
+		resource_set_range(&tmp, ALIGN(res->start, align), size);
+		if (!__resource_contains_unbound(empty_res, &tmp)) {
+			remainder = pci_resreq_remainder(size, align);
+			resource_set_range(&tmp, tmp.start - remainder, size);
+			if (!__resource_contains_unbound(empty_res, &tmp))
+				return tmp.start;	/* caller skips range */
+		}
+	}
+
+	start = pcibios_align_resource(rr, &tmp, empty_res, size, align);
+	WARN_ON_ONCE(!IS_ALIGNED(start, min_align));
+
+	return start;
+}
+
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		int resno, resource_size_t size, resource_size_t align)
 {
@@ -324,9 +366,17 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	int ret;
 
 	pci_init_pci_resreq_data(&rr, dev);
+	rr.real_align = align;
 
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
+	if (!rr.user_align &&
+	    (res->flags & IORESOURCE_MEM) && pci_resreq_remainder(size, align)) {
+		align = 1U;
+		if (pci_resource_is_bridge_win(resno))
+			align = pci_min_window_alignment(bus, res->flags);
+	}
+
 	/*
 	 * First, try exact prefetching match.  Even if a 64-bit
 	 * prefetchable bridge window is below 4GB, we can't put a 32-bit
@@ -336,7 +386,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
-				     pcibios_align_resource, &rr);
+				     pci_resreq_check, &rr);
 	if (ret == 0)
 		return 0;
 
@@ -348,7 +398,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
 		ret = pci_bus_alloc_resource(bus, res, size, align, min,
 					     IORESOURCE_PREFETCH,
-					     pcibios_align_resource, &rr);
+					     pci_resreq_check, &rr);
 		if (ret == 0)
 			return 0;
 	}
@@ -361,7 +411,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
-					     pcibios_align_resource, &rr);
+					     pci_resreq_check, &rr);
 
 	return ret;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fe0233f0d9e6..3594223233ac 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1226,6 +1226,7 @@ char *pcibios_setup(char *str);
 struct pci_resreq_data {
 	struct pci_dev *dev;
 	resource_size_t user_align;
+	resource_size_t real_align;
 };
 
 resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
-- 
2.47.3

