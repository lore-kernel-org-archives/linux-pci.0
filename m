Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972778;
	b=DuEnVSGpxXF4UjCBbD3Nv+iXSHcNfOJMhPFDiwgOhQjEoIbISRGQhZkS66j2sfACmR68
	 vndAkeVYpAoLKBBVC0zh3yRn0NKFHvCbDsmRDydN2l4na2+Sz6LJvZLg1B7CKT4tOL1wK
	 I6S9X7MuP02wtXITud96GthljLJ3jtfhBv7MQVCzyth8LjxogWdNw5lipnsL3yXGm2mfZ
	 mBRi0+P71QJUtbZwT0PEDPanffV5nvuJgYH1fxX+r438M0w+7eX8MlvaJzGwjDxNPK/Ni
	 h4H/jS3wrPRJkS7mOIbvPdvj40DZHeGNuNtEs/0DFot4aRImKgEoH4NhYgImnR/nWKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972778;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3UpHoGVFaxBU8Zr3Ydkphw2SbHlUyep3ui1rx2LUD8c=;
	b=DKUFeUsfHO5cfCNvZc27PQtQJOb5wkG3y4pmYnZW9iu1ss2w+gMt67vjRypYB39Z3+kH
	 Rwh/BkfdBWCkaPADh2Ttauv5QKh1ZWXAMNXGyK6n1VQdPDOlXF1ONlEC8jlD75KE499H0
	 SBm2inXYZtxCsKqxzoDDKOnhfNa9vlpDseLwvJ3HY2o1LFN+49RCrTHhOnUAC5twb244k
	 kt+AZPwprxkkGb0FoXHM/5Le/zwy8tA7yMLo8LobdPsyf4StzX+pfceQu3mceK5bB/J4C
	 lkguWcYWa75S1SwkxlyYB/CeFKXYa7p05NN/aJ3aR2exZcov9k6WFpsNohEgzWQK6Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H0vwCw5o;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C0606EEA3;
	Fri,  6 Nov 2026 13:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86C0606EEA3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H0vwCw5o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972778; x=1825508778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SixzZejWP3/MIPZ6dsP1Dj+mtcCMzHPIHSfjMfby3nk=;
  b=H0vwCw5oKi3bh0zKuYPkL3lvFpnwTYeQJrfedJod0bQo+dc/7JpcZS1U
   QnmIDAFCETuDHgwtJu5zjBdhvdTA6kzJ48GB66LaI8FLBTzEHYYu4ZknJ
   egN3HOK6eK7R+FkUsNovBRA2uyfMoLDrSis19WhrNpdBo9Rsuplr4hs4d
   nUbQ8zWxVVcbxhoH+J+WFMEIG6avf4qASdjkGWziANi9FqU9EBxiWC0II
   UfVGlRR3EwYKF23924AL8AwGgs28pvCHNtLlUzAzhIkMU7xkZdiVLBXUJ
   PHucJl+v7dfMUiPxwblIDcnUfJTN83ZaDiwKKmrQqdCiX2Vws7T1wMrDU
   g==;
X-CSE-ConnectionGUID: gm6UqfSYQHCubvx2VEJM+g==
X-CSE-MsgGUID: x9s1vbYzTjWp5g7NK2i8sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2672720"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2672720"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:46:17 -0800
X-CSE-ConnectionGUID: lijwk9xmTxShsiV8zwxZ/w==
X-CSE-MsgGUID: eQ+uWD2HTM+Euwz6weyyIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7271457"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:46:14 -0800
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
Subject: [PATCH v5 14/14] PCI: Add debug printing to window sizing
Date: Fri,  6 Nov 2026 15:43:35 +0200
Message-ID: <20261106134341.39493-15-ilpo.jarvinen@linux.intel.com>
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

Bridge window sizing prints nothing about its decisions. Some values
used for the calculations are not easy to derive from other log lines
that are already available.

Add window sizing debug print to make troubleshooting easier.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 86c9557bc2fb..22da18347488 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1265,7 +1265,7 @@ static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 				       struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	resource_size_t winsize = 0, win_align;
+	resource_size_t winsize = 0, win_align, final_winsize;
 	resource_size_t aligns[PCI_RES_ALIGN_RANGE] = {};
 	resource_size_t partial_blocks = 0, max_partial = 0;
 	unsigned int nonaligning = 0, rescount = 0;
@@ -1379,7 +1379,28 @@ static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 	*head_align = calculate_head_align(aligns, max_order);
 	*head_align = max(*head_align, win_align);
 
-	return ALIGN(max(winsize + gap, min_size), win_align);
+	final_winsize = ALIGN(max(winsize + gap, min_size), win_align);
+
+	if (bus->self) {
+		int idx = pci_resource_num(bus->self, b_res);
+		const char *r_name = pci_resource_name(bus->self, idx);
+		struct resource print_res = *b_res; /* b_res update is delayed */
+
+		resource_set_range(&print_res, *head_align, final_winsize);
+		if (final_winsize) {
+			print_res.flags &= ~(IORESOURCE_UNSET |
+					     IORESOURCE_DISABLED);
+		} else {
+			print_res.flags |= IORESOURCE_DISABLED;
+		}
+
+		pci_dbg(bus->self, "%s %pR: non-aligning %u/%u gap %llx partials %llx\n",
+			r_name, &print_res, nonaligning, rescount,
+			(unsigned long long)gap,
+			(unsigned long long)partial_blocks);
+	}
+
+	return final_winsize;
 }
 
 /**
-- 
2.47.3

