Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972743;
	b=d0/aOgmC/DmABoG0TxV4rS7L6C2Y/rUfzQDhbw4psoTJOHs/7N8VnQ00Y+t4eaYLaAbP
	 T/bSUB3Km6QyNQiYJoudVyXnAzDyobnpc4HzIPX6KzFQvwYu030FcEa/FpjaVl/BPGvI0
	 JUBB0Zj6/Iup0/ow5sA+2VKiMgAIaJdxYXJ5TwcmOM+LidpLqn8izn/kQAEcf1gNKWnzW
	 25Qx1h21zDT9cpVla9xZmEkPnWULWTer4Qi9ecknuyAthBTPQj3QtQNOwphhLSqcoyOpM
	 G2Wy8C/aZBWISbkOyQXJaVbegscFUgSGwiHFDtelTUNnIJuTSWDk6m+2etyfyvKOmDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972743;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=PYwU7JT1a7zGIf1+x+JW1SLVmmAUGN/Ox2y8UamiZO8=;
	b=ILgfiG5IIsZSpjnW1MNJS+tkIWiyX+Wt0RyUCJICOOejbwgiV98WCQ8rz4vdam0ihr1g
	 E4azEl6IrtrU7olw8pZdHzZKU7adVzptr3QWhb+qgdaOxxcE+II9QmA1HhAo3nUEu2yBr
	 ClavzcAELbsBHgPrM3l6BOXpciMdPz5hdGHmITsU0fM7YA5kdwrAz28/fy+PfuPr8d2zm
	 dl6Ssg5cicLPcpNFnaXbm3Be1AZAs8/gNB9KCF5Zcx2ndwC8v0Nt8wWXHmvy/uncGfLMy
	 kEOLSiR6ERbaJuCljE2GPtmd3bPM843EsIGdPsGJJc/7masdkmqsxgtuojJTS/2xT/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mpDngz9s;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3A606EEBE;
	Fri,  6 Nov 2026 13:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DE3A606EEBE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mpDngz9s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972743; x=1825508743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cLchl3/QTanFiWHBby8t+BIh2uJPxN1kaFx1f7SvwWk=;
  b=mpDngz9sSCMlHiAU0i/kqipTcQCl6Dk974VinSLoERckjNcVJaIW2Gvq
   8aH9cNCZSPzdPZezFTJPikHKf/gMoWG8z337pD14BLp6FzTRqn9KfoBRd
   XKrJDSzALf1LIi805m2Gd3xKdUO8xflJT2H1rfGxtOIw0BZHw3eUy1MLe
   7j/YmkHkxRaax2sa9/dbcN6vUt9G5KXhDjvpenmNmArxksru+cysyJWFi
   djshZwO/qK2qL/phudoNGSIIM8VzMVovxyqBk/ZQWYOF1zeRAsORNPEtp
   77tnBgC9RNfTTKL0ESPtoDglTGnmjk41+ElbCq/LJei74DghWVlhL3gEl
   g==;
X-CSE-ConnectionGUID: oPOeRm4MTw+EqXRliQTPHg==
X-CSE-MsgGUID: f/n/OXyiR36sF5PbecTzkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2662121"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2662121"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:45:42 -0800
X-CSE-ConnectionGUID: uQ1/K2sQSaq4VbL+sTPh6w==
X-CSE-MsgGUID: FUrPpPwNT5CFrOl6G9b7RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7843870"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:45:39 -0800
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
Subject: [PATCH v5 10/14] PCI: Separate align/raw size calculation from pbus_size_mem()
Date: Fri,  6 Nov 2026 15:43:31 +0200
Message-ID: <20261106134341.39493-11-ilpo.jarvinen@linux.intel.com>
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

pbus_size_mem() contains many steps, the first one being calculation
of required size and alignment. Refactor it into a separate function
to be able to reuse the calculation.

Rename size to winsize to better differentiate from r_size (resource
size).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 94 +++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5f8320cac504..a8915b2354ea 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1257,51 +1257,27 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
 #define PCI_RES_MAX_ALIGN	SZ_128T
 #define PCI_RES_ALIGN_RANGE	(ilog2(PCI_RES_MAX_ALIGN) - ilog2(SZ_1M) + 1)
 
-/**
- * pbus_size_mem() - Size the memory window of a given bus
- *
- * @bus:		The bus
- * @b_res:		The bridge window resource
- * @add_size:		Additional memory window
- * @realloc_head:	Track the additional memory window on this list
- *
- * Calculate the size of the bridge window @b_res and minimal alignment
- * which guarantees that all child resources fit in this size.
- *
- * Set the bus resource start/end to indicate the required size if there an
- * available unassigned bus resource of the desired @type.
- *
- * Add optional resource requests to the @realloc_head list if it is
- * supplied.
- */
-static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
-			  resource_size_t add_size,
-			  struct list_head *realloc_head)
+static resource_size_t __pbus_size_mem(struct pci_bus *bus,
+				       struct resource *b_res,
+				       resource_size_t *head_align,
+				       resource_size_t *add_align,
+				       resource_size_t *children_add_size,
+				       struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	resource_size_t min_align, win_align, align, size, size0, size1 = 0;
+	resource_size_t winsize = 0, win_align;
 	resource_size_t aligns[PCI_RES_ALIGN_RANGE] = {};
-	int order, max_order;
-	resource_size_t children_add_size = 0;
-	resource_size_t add_align = 0;
-
-	if (!b_res)
-		return;
-
-	/* If resource is already assigned, nothing more to do */
-	if (resource_assigned(b_res))
-		return;
+	int max_order = 0;
 
-	max_order = 0;
-	size = 0;
+	win_align = pci_min_window_alignment(bus, b_res->flags);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct resource *r;
-		int i;
+		int order, i;
 
 		pci_dev_for_each_resource(dev, r, i) {
 			const char *r_name = pci_resource_name(dev, i);
-			resource_size_t r_size;
+			resource_size_t r_size, align;
 
 			if (!pdev_resources_assignable(dev) ||
 			    !pdev_resource_should_fit(r))
@@ -1328,12 +1304,12 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 			}
 
 			if (pbus_size_mem_optional(dev, i, align,
-						   realloc_head, &add_align,
-						   &children_add_size))
+						   realloc_head, add_align,
+						   children_add_size))
 				continue;
 
 			r_size = resource_size(r);
-			size += max(r_size, align);
+			winsize += max(r_size, align);
 
 			/*
 			 * If resource's size is larger than its alignment,
@@ -1348,9 +1324,47 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 		}
 	}
 
+	*head_align = calculate_head_align(aligns, max_order);
+	*head_align = max(*head_align, win_align);
+
+	return winsize;
+}
+
+/**
+ * pbus_size_mem() - Size the memory window of a given bus
+ *
+ * @bus:		The bus
+ * @b_res:		The bridge window resource
+ * @add_size:		Additional memory window
+ * @realloc_head:	Track the additional memory window on this list
+ *
+ * Calculate the size of the bridge window @b_res and minimal alignment
+ * which guarantees that all child resources fit in this size.
+ *
+ * Set the bus resource start/end to indicate the required size if there an
+ * available unassigned bus resource of the desired @type.
+ *
+ * Add optional resource requests to the @realloc_head list if it is
+ * supplied.
+ */
+static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
+			  resource_size_t add_size,
+			  struct list_head *realloc_head)
+{
+	resource_size_t min_align, win_align, size, size0, size1 = 0;
+	resource_size_t children_add_size = 0;
+	resource_size_t add_align = 0;
+
+	if (!b_res)
+		return;
+
+	/* If resource is already assigned, nothing more to do */
+	if (resource_assigned(b_res))
+		return;
+
 	win_align = pci_min_window_alignment(bus, b_res->flags);
-	min_align = calculate_head_align(aligns, max_order);
-	min_align = max(min_align, win_align);
+	size = __pbus_size_mem(bus, b_res, &min_align, &add_align,
+			       &children_add_size, realloc_head);
 	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
 				  0, win_align);
 
-- 
2.47.3

