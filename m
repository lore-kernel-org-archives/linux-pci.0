Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972700;
	b=FsFi6hAL3dg5K7wTgQdAJdmxw7cAFAweKbgTEYnCQ3vWhR1m9cteR/om0YhYgMeKtsqv
	 85wACT9/hKiBaZNPvRsQz2slmHNUB8c2/3VCqx5ev4C3HIwPmzeiMLVJnNp1cgLFgB6mY
	 krW04qg9GcRFcs47mJAyOErBHpJmWz5qvdyxQ3Nxg+VQQJkKcQjXfMKJOY82PkzoqXn5T
	 KBZySxMEH1JfOxGAl+o1wmT8YrCdmoLA3V4McoKBYpq1wDI3EtzZBCCtD3k+Yv43MXcxS
	 RD8GqUrAo+eTDEt45c1ra3kng4c86UdplLVgVys1fkhopazlALq18RRTyrGWU9bA8FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972700;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=fJ5rNgYp5u2IpUAbqPazFEAoXTLNVgTE1Lwbk+mDzDA=;
	b=UVzU/o0k+SIBmJEByFszJmtPIZacP/1qXA+E6oNlGGVxYBhFlsVN5DhkLSCTZbf4X5Ze
	 UPjZYZ/7+QL4y1GUsKKOL9XpUHSg0ARe3294gkGfwiamVR2MWOKl17KGKJS9NIrOSepvt
	 cUZ+K56OoKRlTOW0uTiVdQ+QixQyB0dZNQSX61uLsTKe1otAukS34cmWyUuRvJiZnT8lB
	 jB+QtkBULB3l8yIplfZSSUMRFt5V3PFSk3cXxYc2yH1A9hrGU6726ElkQnFXIA8295Mxz
	 wF4Oqa883DwZFNfZ1yLp6JypdUtv6v4HpG0GgIjwQeJI2uhOjTrpJq1SJiXveePnEDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="WtQ/5sRH";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7E3606A334;
	Fri,  6 Nov 2026 13:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7E3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WtQ/5sRH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972700; x=1825508700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4z68YVtApwpRdUlFCH0BJdlpWxp9YqMgFATx0P5heuY=;
  b=WtQ/5sRHU2PMEZEfMA1RzHaDRV+87v3CO+GhDMDdxRpScCr/aBVLG7vq
   X89LvCo74hQw64f5vXe68WLlJiTblI12TnRHOJ52L5U6BsOo4eZJidYe0
   WGNpkPSpgeLbLtVPQ/OvrpmdQnihhNEfwh1ldDQIKY1rJjgLIuzPSxJwD
   I2KBc5epKVoy30AMJICjDdkPxq/OKJra52PyL2c/QmffilVE9i+fn9BAA
   hjXoptD7Zx/0MFnhuHH4r7jQmDK/7HIs7Z004NtOzeJSjlh0AgSZS6cVR
   stmV2uzyk76DV4AYaID+SrBug3dt763IWbX6LvRkev1nIQiH7eFAbugt2
   Q==;
X-CSE-ConnectionGUID: jCOa2gmbT0u7nYSORsW8HQ==
X-CSE-MsgGUID: ZbalYGrZSvilJlRarEXhjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2686120"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2686120"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:59 -0800
X-CSE-ConnectionGUID: qyyjcCELRLCdEwmjXa6vmA==
X-CSE-MsgGUID: BOElTS6uS82uL35G4a9BHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7327680"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:56 -0800
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
Subject: [PATCH v5 07/14] PCI: Derive aligns[] array size in a define
Date: Fri,  6 Nov 2026 15:43:28 +0200
Message-ID: <20261106134341.39493-8-ilpo.jarvinen@linux.intel.com>
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

The aligns[] array in pbus_size_mem() is sized with a literal with a
comment explaining the number. Add a define PCI_RES_ALIGN_RANGE that
derives the value from those sizes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9d167e7773a1..c3c229ed320a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -19,6 +19,7 @@
 #include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -1256,6 +1257,10 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
 	return true;
 }
 
+/* Alignments from 1MB to 128TB */
+#define PCI_RES_MAX_ALIGN	SZ_128T
+#define PCI_RES_ALIGN_RANGE	(ilog2(PCI_RES_MAX_ALIGN) - ilog2(SZ_1M) + 1)
+
 /**
  * pbus_size_mem() - Size the memory window of a given bus
  *
@@ -1279,7 +1284,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, win_align, align, size, size0, size1 = 0;
-	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
+	resource_size_t aligns[PCI_RES_ALIGN_RANGE] = {};
 	int order, max_order;
 	resource_size_t children_add_size = 0;
 	resource_size_t add_align = 0;
-- 
2.47.3

