Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05C3E557D;
	Tue, 13 Oct 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897052; cv=none; b=f7cnw720ISuJJDyFaRlCSivJbrM4KfAH3z0GaIitmjm1a1ls/sYLxzeNSsi7OCv3bcrNDbvNMOzxYuNr/agPYtF3PrGTEUOfCJerpj7Y3vrOmIMXxQa+xxNk03ERW1m2aHHsvpKltd8HoiSomzQiu1xmAyReOvnLXYwzwVbtrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897052; c=relaxed/simple;
	bh=aHO/wtsdKgMmgb1QKzP2MniCa5nDtyZQbmVvebQgn1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSDQwWpfYdsRWTwdKmj+yPvcVUNXim+/xI+BWd6s6emYzBZ9dk0zoJsJWb0SG5DUju78QVSFqCj6A9x0z3x5yJT4+bGbbAujJ9Wjty2HIV9Vn4P7nT3iPyVnCoJBRmWI9b37i1skLppwWA8wS1+kPaMqILE3CDnUrhICHROB3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDICR6sS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDICR6sS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897051; x=1823433051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aHO/wtsdKgMmgb1QKzP2MniCa5nDtyZQbmVvebQgn1k=;
  b=LDICR6sStyb502VmeX9Iq5SJUUMCvZE7VYi5H78Xp3vKk/LrDR0xpG9L
   S4aVta+rQoFPsvqdCi7Z7wr5FLjWCxkzhX1Fs9Msf+TvM5U0FoGFnVFHB
   mRtJcKBmVaLoOXUaJiZDwLyShB7Hd0C+qMQzXt0TlKcEYt5teeGPmg7yG
   Rqv2i1gX2ML73gfVs0iVNxTpashiI5e7AtscIyqwHJXJrEynX08uIRyGH
   L1DYRlIx54birGdFQ48QEJyufooQudaAjVDRxxkqikxrqKljvBexONKf1
   xBMxRS7rEIs59xBjKjKZedvb8zxELs4nsqTJZzg5WWiZKKK6N8Z+UrPd4
   w==;
X-CSE-ConnectionGUID: ArJPqKUSTeSjoHH87m77Qw==
X-CSE-MsgGUID: 6APHGKdzTxyu4s4NO8N1xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="630370"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="630370"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:51 -0700
X-CSE-ConnectionGUID: 5shIhWNqTFy+3gu//+Q9RA==
X-CSE-MsgGUID: HPgkYAD9QXGTAC8Wtf0hWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1085006"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:46 -0700
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
Subject: [PATCH v3 4/8] PCI: Fix nesting windows with remainder at the left edge
Date: Tue, 13 Oct 2026 16:09:38 +0300
Message-ID: <20261013130948.6231-5-ilpo.jarvinen@linux.intel.com>
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
index ea7d75871269..d7b431c1ac0d 100644
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

