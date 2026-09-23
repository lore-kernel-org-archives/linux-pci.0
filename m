Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE45218AF;
	Wed, 23 Sep 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169517; cv=none; b=Glrx+YI8MUf94RY/Y4J5Km/lQJLllckT2tNe18swTHSu8DTvb5+Nb0+iSMGGOTM3i1vJrNsaeDEwfOLe9fyZ/AErWmexC+GAk4nFPtdkoUvMT9ivK+Cq+VnoPtGGQtzjKAlE3phoxHVzD4C1XsNPSxHP1cPLdsOj4I8rwNtdR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169517; c=relaxed/simple;
	bh=0dWCjrgLSm8/r6A8g9qrCMimfAoYRcYaBYZ8vU5IJ1w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ikd8NGhyj+0Himiaxzu76o403Egu/m3TRGCrCYnYhHJwhTq8UDm+WLoKQ4WMeScXtigCfdWphDmNcz/NuTfq/X5g9sUaSOnzWx6khbKaEBzRQP4cX3Mfn0S1lZ21wJH0SjpXZJ/YK3wwWG+DJYJ8c1d2rpmMNvNmY6bJaM7K9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnPlg1cG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnPlg1cG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790169512; x=1821705512;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0dWCjrgLSm8/r6A8g9qrCMimfAoYRcYaBYZ8vU5IJ1w=;
  b=EnPlg1cGpvZ3DhtKskn00H38YlRyNIr9djDUyNOs4uyKuGBnA9EfVO7D
   8MnVTtdAT2rl0c9SJ2Rnw4U19uzRLsEHs6U6lo4it6lmnLCno4ICDV2BS
   KXh+nTcTJ7+StKe5BKWfwKkf/5zzeiOOkzItBME1BR++oW0YEectiGX7w
   93elfz058udliFp0NjYw9HBz+sd+uB3vBH3/+Pwg3EhxglDSTxFecvBfX
   gCgQpspGguG69w4zPwFIQqFI2rJlszSAW+d49Aq7f77c6afmfOAxELWb3
   JhAa2bJCm+TXJQ0YlKMybXjfNz06m9YnNXjLwn/IwZHCY3g1YTazK3mfG
   Q==;
X-CSE-ConnectionGUID: pGJf+7jHRbK576aOsNu+gA==
X-CSE-MsgGUID: 9lVAJtxkQpavbq4UwPBibA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90979685"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="90979685"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 06:18:29 -0700
X-CSE-ConnectionGUID: bO/vsl57Q+6+EpjCHIMxjw==
X-CSE-MsgGUID: hLB89dyqReaPpy4+siDkVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="272784505"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 06:18:24 -0700
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
Subject: [PATCH 2/5] PCI: Fix nesting windows with remainder at the left edge
Date: Wed, 23 Sep 2026 16:17:52 +0300
Message-ID: <20260923131757.7792-3-ilpo.jarvinen@linux.intel.com>
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
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I've not seen a report about this problem (thus no log quotes) but with
nested thunderbolt topologies it seems well within realms of possibility
of occurring.
---
 drivers/pci/setup-res.c | 64 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 376f09630a4a..eacce9e2486b 100644
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
@@ -276,10 +284,17 @@ resource_size_t pci_align_resource(struct pci_dev *dev,
 	if (!(res->flags & IORESOURCE_MEM))
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
@@ -311,15 +326,54 @@ resource_size_t __weak pcibios_align_resource(void *data,
 	return pci_align_resource(dev, res, empty_res, size, align);
 }
 
+struct pci_resreq_data {
+	struct pci_dev *dev;
+	resource_size_t real_align;
+};
+
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
+	start = pcibios_align_resource(rr->dev, &tmp, empty_res, size, align);
+	WARN_ON_ONCE(!IS_ALIGNED(start, min_align));
+
+	return start;
+}
+
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		int resno, resource_size_t size, resource_size_t align)
 {
+	struct pci_resreq_data rr = { .dev = dev, .real_align = align };
 	struct resource *res = pci_resource_n(dev, resno);
 	resource_size_t min;
 	int ret;
 
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
+	if ((res->flags & IORESOURCE_MEM) && pci_resreq_remainder(size, align)) {
+		align = min;
+		if (pci_resource_is_bridge_win(resno))
+			align = pci_min_window_alignment(bus, res->flags);
+	}
+
 	/*
 	 * First, try exact prefetching match.  Even if a 64-bit
 	 * prefetchable bridge window is below 4GB, we can't put a 32-bit
@@ -329,7 +383,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
-				     pcibios_align_resource, dev);
+				     pci_resreq_check, &rr);
 	if (ret == 0)
 		return 0;
 
@@ -341,7 +395,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
 		ret = pci_bus_alloc_resource(bus, res, size, align, min,
 					     IORESOURCE_PREFETCH,
-					     pcibios_align_resource, dev);
+					     pci_resreq_check, &rr);
 		if (ret == 0)
 			return 0;
 	}
@@ -354,7 +408,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
-					     pcibios_align_resource, dev);
+					     pci_resreq_check, &rr);
 
 	return ret;
 }
-- 
2.47.3

