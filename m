Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972770;
	b=mGciJ159wNh6o26AnTT9w8lrzNM7u0fZlxIht2+Hj3j8vIBH9ZHC25Qf9gKV5rvcMf0N
	 XMKpnXHC9VmkvWrDouo56yY1MSvBkHm40kPQr+VxP05XTBc7yXKJlPmP4JN72M7I3YLtr
	 gwZgcGKc5d5eLlRLRTmUUvVQSqwLM0O0Okbt/b9QLweD7lCY83sJgPUs/1RogBjN2tqwh
	 UK8U93vHH/nlHcnRA9bAZwyak2ElC6qFGCvthqpteZZzdcxEmHwfXhE53PlFgnIFIokih
	 9klMYN23+W7Y0imlbTr0p7/6aYs0+wV4dVVj6e94LRqioxvsLaUvnKWV7e3jSiaWJEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972770;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=jaUjSosOX3KWgy6VwC3Y3wCWLoCwlGzsdn3+V/DY16c=;
	b=It6BBEGSIl+RFkHGOY5lAYGleHE228RFF26GYaHRKwF3wCB+f7bNLWXMUnVSbhoiZyZX
	 I53zP9i8qAF10MJhLoW2AoLXoDZZTL5cMpp2XmSkJW9BL9EC8KFNv3O34nVxHbcHsJ9jt
	 H6E6V0CZInVmnsHMD6+Eau3UjkPh9s+60sUuChz7mrHQXEexGDI0W5oF39QK93P9s0w2k
	 +RJXZRgUhN/WWc7E8j7Kr5TlVGcx8EQA9Jt1YOWKFF2Jc+6BZKX8XXZgzs1PBx+THTfOg
	 WNsW5rCRAHWiLePQhvvV8Ibah/t+pSbd1sYCcpkuB+IfTm75EAJh5YUVWLKWf+25NyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="m/JDtxaR";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDD606A326;
	Fri,  6 Nov 2026 13:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCDD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m/JDtxaR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972770; x=1825508770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FSA17Pngfe5Sc7NbhbkbYqHWWBK00TrAI6aPIzhOd8U=;
  b=m/JDtxaR7PUd20iuBRUuCGYknJhgRkhxaTnuUHE6t4xKHbn2Q/XjqqcQ
   U593Ek4s92nAcWghRo4tek2pCmnyruU6hckbFg6k7HOxWuR+Ju1jYs78i
   FG/aDoyE7XdsZAiOEGS9g8rHeMIZZ3m3O3OVknTCU0eFFcQyl6Zq+h4cY
   3lcwX+wXOnSIJ6SQ6zmzPh0SOsCZDxPf5oCVmeAKOm6nrF4SzaOPu0st0
   V0DCYJzyt2IGP/p7hCglO4oOQFTzZG1XH9AIELx4bU33h2hQWJM0Aw6pL
   FjBE0DRofjOjV2Pj8c6GZmZGQu65Rx1aaX/WbAYp4sD7sk15do8KRjrxs
   Q==;
X-CSE-ConnectionGUID: f0+MWIc3QqqWxDCIzKm2Rg==
X-CSE-MsgGUID: xx+eZOSMROyPLGhufnsCHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2672704"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2672704"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:46:09 -0800
X-CSE-ConnectionGUID: ResAsLoUTT+n9XbTmrG27Q==
X-CSE-MsgGUID: 9eVuT9e7TaqOjaQWngI5Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7271403"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:46:05 -0800
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
Cc: Nikolas Joshua Britton <nbritton@exabit.io>
Subject: [PATCH v5 13/14] PCI: Fix composite resource sizing
Date: Fri,  6 Nov 2026 15:43:34 +0200
Message-ID: <20261106134341.39493-14-ilpo.jarvinen@linux.intel.com>
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

The bridge window sizing algorithm aims to pack child resources back to
back. With composite child resources whose sizes are not a power of two,
back-to-back placement may not be possible. The non-aligning remainder
placement is limited because it must be adjacent to the rest of the
composite resource.

Add bridge window gap size calculation.

When there are only two resources and at least one of them is
composite, the gap end address aligns to meet the smaller of the two
alignment requirements. If there is only one composite resource, the
smaller alignment may be that of the composite resource.

Other combinations fall back to filling each resource's align sized
blocks fully. Sometimes, smaller size may be possible but due to how
sizing and assignment are made in different phases, it is not always
possible to predict where each resource is assigned. Thus, the sizing
has to play it safe.

Fixes: 9036bd0efcb6 ("PCI: Align head space better")
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Reported-by: Nikolas Joshua Britton <nbritton@exabit.io>
Link: https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@exabit.io/
Reported-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I removed Bjorn's Tested-by tag as this patch has been through a major
rework.

There is one known failure mode (pointed out by AI review) with >= 3
resources, each with a different alignment requirement following a
certain pattern and the smallest align one must also be a composite
resource. Additional requirement is that the window must have an
odd-multiple start address.

While that corner case could be addressed by always forcing larger gaps
(at the cost of everyone paying the extra gap "tax"), I see no reason
to overengineer this for corner cases that might not occur in real
systems. If issues are reported, this can be revisited and perhaps more
complex fallback logic added (to avoid incurring the gap "tax"
unilaterally).

Adding the gap logic fixes known regressions seen in real systems, so
it is an important improvement even as is.
---
 drivers/pci/setup-bus.c | 57 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b6be6cd16006..86c9557bc2fb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1267,6 +1267,9 @@ static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 	struct pci_dev *dev;
 	resource_size_t winsize = 0, win_align;
 	resource_size_t aligns[PCI_RES_ALIGN_RANGE] = {};
+	resource_size_t partial_blocks = 0, max_partial = 0;
+	unsigned int nonaligning = 0, rescount = 0;
+	resource_size_t remainders = 0, gap = 0;
 	int max_order = 0;
 
 	win_align = pci_min_window_alignment(bus, b_res->flags);
@@ -1277,7 +1280,7 @@ static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 
 		pci_dev_for_each_resource(dev, r, i) {
 			const char *r_name = pci_resource_name(dev, i);
-			resource_size_t r_size, align;
+			resource_size_t r_size, align, remainder;
 
 			if (!pdev_resources_assignable(dev) ||
 			    !pdev_resource_should_fit(r))
@@ -1320,13 +1323,63 @@ static resource_size_t __pbus_size_mem(struct pci_bus *bus,
 				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
+
+			rescount++;
+
+			if (r_size <= align)
+				continue;
+			remainder = r_size - ALIGN_DOWN(r_size, align);
+			if (!remainder)
+				continue;
+
+			nonaligning++;
+			remainders += remainder;
+			partial_blocks += align;
+			max_partial = max(max_partial, align);
 		}
 	}
 
+	if (nonaligning && rescount == 2) {
+		resource_size_t second_align = max_partial;
+
+		/*
+		 * With two resources having differing alignment
+		 * requirements, the gap size can be optimized by aligning it
+		 * only up to the smaller of the alignment requirements.
+		 *
+		 * This also allows two composite remainders to share the
+		 * same block when the resources have the same alignment
+		 * requirement which is common with multi-GPU setups where
+		 * each bridge window contains a small BAR and a large BAR.
+		 * The small BARs can share the same align block.
+		 *
+		 * As this sizing phase cannot influence resource assignment
+		 * order and placement, this is only guaranteed to work with
+		 * two non-aligning resources.
+		 */
+		if (nonaligning == 2) {
+			second_align = partial_blocks - max_partial;
+		} else {
+			for (unsigned int i = 0; i < max_order; i++) {
+				if (!aligns[i])
+					continue;
+
+				second_align = min(second_align,
+						   1ULL << (i + __ffs(SZ_1M)));
+				break;
+			}
+		}
+
+		gap = ALIGN(remainders, second_align) - remainders;
+	} else if (nonaligning >= 2 ||
+		   (nonaligning && rescount > nonaligning)) {
+		gap = partial_blocks - remainders;
+	}
+
 	*head_align = calculate_head_align(aligns, max_order);
 	*head_align = max(*head_align, win_align);
 
-	return ALIGN(max(winsize, min_size), win_align);
+	return ALIGN(max(winsize + gap, min_size), win_align);
 }
 
 /**
-- 
2.47.3

