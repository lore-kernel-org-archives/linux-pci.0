Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972761;
	b=S7uv2OePoAd52kHo0XC/ipveN6hgp0Nz2h+OnSwMWSlobF3Xcyhp4YB6HmJ7DQpPSX6r
	 nhWnJrKfGxZikvblXdrgxP+wwOJDEVsk57Da//HxzimK+332GsRWQx8ZiHT56OfFIbkGq
	 1LdPUG2dUyarpPmh3A7RVTe0wFHmGciW212Xp68pxsN43rrxxCqfBB6+LCuY9Vy+ysQ/G
	 qMu5hrPrX4aVhViQINb/GeAN3dPDrWEvb/lNHsV7Jy9py2TDE8GuLXrYgYD5xYCbAfXmt
	 LEKqaTELOJGRV1kwsBtbKADUWlAnppdkXHY0UgJ7TLG9HZpK/s/hSoxGkzsaGFut8AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972761;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qWWWqhCeqRT7MxafD9GTzBIkhy13cbocU6cy1qApdDE=;
	b=Hb5LxXjvqpjlVxdK7RWt5NQoUGUtz8nX+n9stRaCydnrdgiwBbynmGaPQhJSE3c/bNAB
	 Z3X3gKHF7Jd22pmENCFXu2KHIq0TrQqmHKKFvzDwtJsx9U6NdPtVN55wDG+zhlGj3uKLi
	 BXIBsHxjeC9HeCuoyXQZf9sHEBGRdU2oqeIh3gLPX3+5BkYXjUAdVR1t4Jtt62OqbmRaP
	 UpMmMTJsCZJeHlKuPokaoqtBGrLrWqe13s+Bi+GjZJnmJ5jVfr8i6gdhY/0yHec7XJZum
	 61hZUpwKqxncCeoftboHSZvpD0k1esqd9fGQm23A6dill0t1KghkeAdVryS9Ti3qjXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Jz/LNLKX";
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB752606EE8A;
	Fri,  6 Nov 2026 13:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB752606EE8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jz/LNLKX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972761; x=1825508761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ouoQAS9F4QPOQPXybyGTXi3W63/TZR+9tUFcoEDGVMk=;
  b=Jz/LNLKXNOuKtRMa81vJRTg1zIBrp/HJotkxt87cBBFCTLpY1RCs4o3P
   dAEOC53sZURkzZrJYWILIevTMZffCMwgFYWMQxKkag+JhanI0JRXCp3lu
   R1KnwoT5i3BXIHCD4/s/HkV2wT4kXtEtV6S+7DQYV1AS1QFgY6ZtbJcwx
   Q2pCllUsOk2qmkTj/Ft7r2pzqZ0Qf1CYXhmYN7H2ZMi+TIPJyA2CPIWkZ
   2Z2svE39duEA72emju9RUi5GvAnsfZZ7mWkYa12/b4HteUJya3Z+peVc6
   SkDrez//reWqrFRYcJYK6j1VliahJIv/8SmBcqhe467J7o9Fnn5g1LMtc
   Q==;
X-CSE-ConnectionGUID: xRXM3ik0R7GfoaAFDhpT6Q==
X-CSE-MsgGUID: s7uF5wE6QmmiLjUNSs74Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2685727"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2685727"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:46:00 -0800
X-CSE-ConnectionGUID: IgFrD/E5R7GPzRnGkFBQ0Q==
X-CSE-MsgGUID: 4FAWedRLQxal/0a065vXbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7143290"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:45:56 -0800
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
Subject: [PATCH v5 12/14] PCI: Move size/align calculation fully into __pbus_size_mem()
Date: Fri,  6 Nov 2026 15:43:33 +0200
Message-ID: <20261106134341.39493-13-ilpo.jarvinen@linux.intel.com>
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

Move entire size and alignment calculation into __pbus_size_mem()
further simplifying the caller side code.

Also fold calculate_memsize() into __pbus_size_mem() as it has become
too simple to justify a separate function.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6623adfdde85..b6be6cd16006 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1011,14 +1011,6 @@ static resource_size_t calculate_iosize(resource_size_t size,
 	return ALIGN(max(size, old_size), align);
 }
 
-static resource_size_t calculate_memsize(resource_size_t size,
-					 resource_size_t min_size,
-					 resource_size_t align)
-{
-	size = max(size, min_size);
-	return ALIGN(size, align);
-}
-
 resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
 						unsigned long type)
 {
@@ -1269,6 +1261,7 @@ static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 				       struct resource *b_res,
 				       resource_size_t *head_align,
 				       bool add_optional,
+				       resource_size_t min_size,
 				       struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
@@ -1333,7 +1326,7 @@ static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 	*head_align = calculate_head_align(aligns, max_order);
 	*head_align = max(*head_align, win_align);
 
-	return winsize;
+	return ALIGN(max(winsize, min_size), win_align);
 }
 
 /**
@@ -1357,8 +1350,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 			  resource_size_t add_size,
 			  struct list_head *realloc_head)
 {
-	resource_size_t min_align, win_align, size, size0, size1 = 0;
-	resource_size_t add_align = 0;
+	resource_size_t min_align, size0, size1 = 0, add_align = 0;
 
 	if (!b_res)
 		return;
@@ -1367,20 +1359,17 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	if (resource_assigned(b_res))
 		return;
 
-	win_align = pci_min_window_alignment(bus, b_res->flags);
-	size = __pbus_size_mem(bus, b_res, &min_align, !realloc_head,
-			       realloc_head);
-	size0 = calculate_memsize(size, realloc_head ? 0 : add_size, win_align);
-
+	size0 = __pbus_size_mem(bus, b_res, &min_align, !realloc_head,
+				realloc_head ? 0 : add_size, realloc_head);
 	if (size0) {
 		resource_set_range(b_res, min_align, size0);
 		b_res->flags &= ~IORESOURCE_DISABLED;
 	}
 
 	if (realloc_head) {
-		size = __pbus_size_mem(bus, b_res, &add_align, true, realloc_head);
+		size1 = __pbus_size_mem(bus, b_res, &add_align, true,
+					add_size, realloc_head);
 		add_align = max(min_align, add_align);
-		size1 = calculate_memsize(size, add_size, win_align);
 	}
 
 	if (!size0 && !size1) {
-- 
2.47.3

