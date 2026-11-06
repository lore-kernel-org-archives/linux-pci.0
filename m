Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972752;
	b=frE2d1MHhDmmDlhUsIW2InKougGuS/cl0oaEgiESeSKSzZ9yh9C2606Z67DhrV0dfbti
	 8hjaXnVFbbUFom1EZldKeObCXOZLXszbCAJuDxzJ9yxhJ8PsUKDLmV7OqUOfZFFstw+ap
	 13iEFzKs6z9X7PYLE8m8N8bvAnkxJYmWCLu7HLC5U7osGgEarzQeqAmKec7lu4j8ctLbA
	 WdpwW6mVDcRlqhUrdhcZuvF/3MRHqH0PI+xgZp/UwOeXSPLSIHIQqfiFONAq5GUiv8gBN
	 ayl7OvS5aouRzWLgBdPKskIOi/mDolagh/CGHHrL88axt+IvMHnSvQRHtlKqY2hklhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972752;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=J8CwT5SOWNrIVCwdPidblXi1xNpSFsqY/SAVoY2uFao=;
	b=ddG/EgAJFZAdarXLBn6w+UzAwiLO44lMZIi5n9JSdTHiSbc+3J/ExcvlEt8AX21nBd2a
	 gohf1HuCw4LYUAit8OxRftaEUkapbo1G8dFKEB48VqCauwm+Q8Rz5XsVE7a7+IjtEjSyE
	 9FBUaqW7eODSpvE1YJOWoFxVaksmnDKqLlWxS/2c8Al85xNVPp4zsKKF4omWKnqQKKGc0
	 DgV54N6V3pB+w4masRnFs2DUq9lERyRNZX97mylcbEKV1rFKM37QZOu6HtUTf5HLwEzs8
	 wbq96vr1Pufx/WQCHZZGA5nAbRbLG8NPXGAgARM+Py8kcG6Gbp5s8eWycVjuo+QTymA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kgz1p1yK;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD7606D803;
	Fri,  6 Nov 2026 13:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28BD7606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kgz1p1yK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972752; x=1825508752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cwBTS5lAYMCrOKgjenKYmTSbcFTmUwJu1I3yfS++KvE=;
  b=kgz1p1yKBSwfXcDpkbaVJ+XWeufhK5LKwl3X8oHr8cfpk4e8ZvxZ4ca2
   m6SNN121+IqTeE2Dm4FH0rUANpxhwWTvyGflsyrPRJhjBaNX+pxZvXqe4
   fu/ceZep15KG33nLRJcXUDp2SXK1Srf/nf3WlhEwfE9t5U6JclupJ84rF
   ctf8kq/vB0xSpa9sFu8zYuw4GKEYYvk2il0qIFjKNxMVlgEaQYW85He9S
   ovXBQuq9YKh8PC5VZUeXs941RO4amB5uhvOUmTPQsWrmEMB8W/gidLW5m
   VIbzI/ehxbeqRJtpLJVb23XtlmbdFqHsvkb5JVXsYYKQvHiKpB8fjQTaB
   Q==;
X-CSE-ConnectionGUID: HFZSEM1OQ9qhVsTZk0ibpA==
X-CSE-MsgGUID: eWNF3jcvQyat1zjdwoP1lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2685706"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2685706"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:45:51 -0800
X-CSE-ConnectionGUID: puENLmEvS3aU03NNMB5b6w==
X-CSE-MsgGUID: cEBGfJK7QxqTf/T1/kbRSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7143270"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:45:47 -0800
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
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 11/14] PCI: Calculate bridge window with optional sizes from scratch
Date: Fri,  6 Nov 2026 15:43:32 +0200
Message-ID: <20261106134341.39493-12-ilpo.jarvinen@linux.intel.com>
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

pbus_size_mem() calls __pbus_size_mem() to calculate minimum head
alignment and size the bridge window. A single pass in
__pbus_size_mem() attempts to calculate both size with only mandatory
resources and also with optional size using add_align and
children_add_size.

The discovered resource sizes are passed to calculate_head_align() but
that only makes one calculation with mandatory resources in mind. That
means the alignment requirement for the case with optional resources is
determined from the maximum alignment, not from the required minimum
alignment.

To make the calculation more consistent, remove add_align and
children_add_size parameters, and make the caller decide if optional
resources should be included or not. Then, pbus_size_mem() can just
make a second call to __pbus_size_mem() to recalculate the alignment
and size with optional sizes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 76 ++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a8915b2354ea..6623adfdde85 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1013,10 +1013,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
 
 static resource_size_t calculate_memsize(resource_size_t size,
 					 resource_size_t min_size,
-					 resource_size_t children_add_size,
 					 resource_size_t align)
 {
-	size = max(size + children_add_size, min_size);
+	size = max(size, min_size);
 	return ALIGN(size, align);
 }
 
@@ -1208,19 +1207,21 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
  * Account an optional resource or the optional part of the resource in bridge
  * window size.
  *
- * Return: %true if the resource is entirely optional.
+ * Return: %true if the resource is skipped due to optionality.
  */
 static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
-				   resource_size_t align,
-				   struct list_head *realloc_head,
-				   resource_size_t *add_align,
-				   resource_size_t *children_add_size)
+				   resource_size_t *size,
+				   resource_size_t *align,
+				   bool add_optional,
+				   struct list_head *realloc_head)
 {
 	struct resource *res = pci_resource_n(dev, resno);
 	bool optional = pci_resource_is_optional(dev, resno);
-	resource_size_t r_size = resource_size(res);
 	struct pci_dev_resource *dev_res = NULL;
 
+	if (!add_optional)
+		return optional;
+
 	if (!realloc_head)
 		return false;
 
@@ -1232,8 +1233,8 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
 	if (pci_resource_is_bridge_win(resno)) {
 		dev_res = res_to_dev_res(realloc_head, res);
 		if (dev_res) {
-			*children_add_size += dev_res->add_size;
-			*add_align = max(*add_align, dev_res->min_align);
+			*size += dev_res->add_size;
+			*align = max(*align, dev_res->min_align);
 		}
 	}
 
@@ -1246,22 +1247,28 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
 	 * on the list.
 	 */
 	if (!dev_res)
-		pci_dev_res_add_to_list(realloc_head, dev, res, 0, align);
-	*children_add_size += r_size;
-	*add_align = max(align, *add_align);
+		pci_dev_res_add_to_list(realloc_head, dev, res, 0, *align);
 
-	return true;
+	return false;
 }
 
 /* Alignments from 1MB to 128TB */
 #define PCI_RES_MAX_ALIGN	SZ_128T
 #define PCI_RES_ALIGN_RANGE	(ilog2(PCI_RES_MAX_ALIGN) - ilog2(SZ_1M) + 1)
 
+/*
+ * Since bridge memory windows are always at least 1MB aligned, keep order
+ * from being negative for smaller resources.
+ */
+static int pci_align_to_order(resource_size_t align)
+{
+	return max_t(int, __ffs64(align) - __ffs(SZ_1M), 0);
+}
+
 static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 				       struct resource *b_res,
 				       resource_size_t *head_align,
-				       resource_size_t *add_align,
-				       resource_size_t *children_add_size,
+				       bool add_optional,
 				       struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
@@ -1288,13 +1295,7 @@ static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 			align = pci_resource_alignment(dev, r);
 			if (!align)
 				goto bad_alignment;
-			/*
-			 * aligns[0] is for 1MB (since bridge memory
-			 * windows are always at least 1MB aligned), so
-			 * keep "order" from being negative for smaller
-			 * resources.
-			 */
-			order = max_t(int, __ffs64(align) - __ffs(SZ_1M), 0);
+			order = pci_align_to_order(align);
 			if (order >= ARRAY_SIZE(aligns)) {
 bad_alignment:
 				pci_warn(dev, "%s %pR: disabling; bad alignment %#llx\n",
@@ -1303,12 +1304,17 @@ static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 				continue;
 			}
 
-			if (pbus_size_mem_optional(dev, i, align,
-						   realloc_head, add_align,
-						   children_add_size))
-				continue;
-
 			r_size = resource_size(r);
+			/*
+			 * This has side-effects on size so it should not be
+			 * called while the resource can still be rejected
+			 * (such as the order check above). As align could
+			 * have changed, the order has to be recalculated.
+			 */
+			if (pbus_size_mem_optional(dev, i, &r_size, &align,
+						   add_optional, realloc_head))
+				continue;
+			order = pci_align_to_order(align);
 			winsize += max(r_size, align);
 
 			/*
@@ -1352,7 +1358,6 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 			  struct list_head *realloc_head)
 {
 	resource_size_t min_align, win_align, size, size0, size1 = 0;
-	resource_size_t children_add_size = 0;
 	resource_size_t add_align = 0;
 
 	if (!b_res)
@@ -1363,20 +1368,19 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 		return;
 
 	win_align = pci_min_window_alignment(bus, b_res->flags);
-	size = __pbus_size_mem(bus, b_res, &min_align, &add_align,
-			       &children_add_size, realloc_head);
-	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
-				  0, win_align);
+	size = __pbus_size_mem(bus, b_res, &min_align, !realloc_head,
+			       realloc_head);
+	size0 = calculate_memsize(size, realloc_head ? 0 : add_size, win_align);
 
 	if (size0) {
 		resource_set_range(b_res, min_align, size0);
 		b_res->flags &= ~IORESOURCE_DISABLED;
 	}
 
-	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
+	if (realloc_head) {
+		size = __pbus_size_mem(bus, b_res, &add_align, true, realloc_head);
 		add_align = max(min_align, add_align);
-		size1 = calculate_memsize(size, add_size, children_add_size,
-					  win_align);
+		size1 = calculate_memsize(size, add_size, win_align);
 	}
 
 	if (!size0 && !size1) {
-- 
2.47.3

