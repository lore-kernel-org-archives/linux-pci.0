Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4A2FABFB;
	Fri,  2 Oct 2026 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940903; cv=none; b=dUhhO580Sq8Vzayrfp1CWoGrKsZ5GEr2UpLEqzx1s5NOuonFZFgQZJk3KN2ira+fFVSIDim03GqgL06xdLxVvyQVuroWh+qD7LjUBHPlORBA3rSur4/Ioj4ZvxP6/wsB9cb+LE8qCYUhghmJ+6ulCgzmDKJW9Shwg9ljlnLA0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940903; c=relaxed/simple;
	bh=0yF8LeXOFnQQdYqJwpLNn8HmkuwRRt+e6g1wiNcG3No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdDK7t6WPykswPWI0fae4p5hWe3VIK1LE9GtxyC5fN9lLAALLmdjpVTZEuOc9vKeX3c2nHu831hp428s0BIxj9zr0ltePLyXZGu+ISYelgp+fqpxDRdqe2Ohl+wVGmaIpkyZzHKcbVxZcVDjodZ9JQkBY+HZ/woCZBhfJW5la3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwWkhLRQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwWkhLRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790940902; x=1822476902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0yF8LeXOFnQQdYqJwpLNn8HmkuwRRt+e6g1wiNcG3No=;
  b=lwWkhLRQ62wPkjV0cjoVhWbhxdfJ/aVqXC+f4qC+D3gX3B24wTzZXzc9
   QEyEK1pN/SfoSYLlxFV3Bj3TAOX4cbuqo3c/Xv3T7bKQCXrrpsmjVCBLg
   zACfnZu3dphEq+Er9IpaPv8ewphP7ysBUQqFzvN2rd3noc/lJICJ1H6R7
   aIirk4rC6oXy2/Q1bmUWlFTc/00zma4htatSdrZPp+hX2Oi7l9yLHunVm
   HfRUtnbeZcJ3YlrgGREEZ0Nu+9oEIAlgHS/MxeQWhIJVUf8G5EE150OX1
   F8ndx6wvt0SO5pTWvg7l6BvSZqrazw1pOqM57IEj2idAY9oEIwC2aX12I
   g==;
X-CSE-ConnectionGUID: KR7r25nGQlWIBqUGtffzdA==
X-CSE-MsgGUID: 3AsqV8hzQ+21Jd51qVHCfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="113489065"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="113489065"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:35:01 -0700
X-CSE-ConnectionGUID: zlwv7Kq7RaOwfgpbgfOEUg==
X-CSE-MsgGUID: R17wOajNR1Gd7cArl8CefQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275767303"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.243])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:34:57 -0700
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
	linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 7/7] PCI/quirks: Avoid certain address on Genoa systems
Date: Fri,  2 Oct 2026 14:33:15 +0300
Message-ID: <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com>
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

While testing the resource placement changes, tests hit a case where
igb fails to probe when BAR 0 is placed at 0x9c000000:

   90000000-9cffffff : PCI Bus 0000:a0
  -  90000000-902fffff : PCI Bus 0000:a1
  -    90000000-900fffff : 0000:a1:00.0
  -      90000000-900fffff : igb
  -    90100000-901fffff : 0000:a1:00.0
  -    90200000-90203fff : 0000:a1:00.0
  -      90200000-90203fff : igb
  +  9be00000-9c0fffff : PCI Bus 0000:a1
  +    9be00000-9befffff : 0000:a1:00.0
  +    9bf00000-9bf03fff : 0000:a1:00.0
  +    9c000000-9c0fffff : 0000:a1:00.0
     9c100000-9c17ffff : amd_iommu
     9c180000-9c1803ff : IOAPIC 8

  -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=1M]
  -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) [size=16K]
  -       Expansion ROM at 90100000 [disabled] [size=1M]
  +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) [size=1M]
  +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) [size=16K]
  +       Expansion ROM at 9be00000 [disabled] [size=1M]

igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
------------[ cut here ]------------
igb: Failed to read reg 0x18!
WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
...
 igb_get_invariants_82575+0xff/0xf00 [igb]
 igb_probe+0x3c8/0x1190 [igb]
 local_pci_probe+0x3b/0x80

It turns out there is a 64kB iomem black hole at 9c000000 that returns
~0 and this is where igb's BAR 0 resides. If another BAR of the same
card is placed into that address, it is similarly black holed.

Mark the problematic 64kB range reserved using a quirk bound to the
bridge found in the problematic system.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222074
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Mario suggested the quirk to be based on the bridge instead of the 
endpoint device which certainly looks better and cleaner than the
approach used in v1.

The current plan is to try a different card in the same slot but it is
a bit hard for me to predictable on what timescale that can be done.

---
 drivers/pci/quirks.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..5483b47d8d54 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6288,6 +6288,41 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
 
+/*
+ * TODO: Remove when/if root cause is found.
+ *
+ * Genoa appears to have a 64kB iomem black hole starting at 0x9c000000
+ * address for which all reads return ~0 blocking an overlapping BAR from
+ * working.
+ *
+ * Work around the problem by reserving the space prior to making any iomem
+ * allocations that could overlap with the black hole.
+ */
+static struct resource black_hole_res = DEFINE_RES_MEM_NAMED(0x9c000000, SZ_64K,
+							     "reserved");
+
+static void genoa_iomem_black_hole(struct pci_dev *dev)
+{
+	struct resource *r;
+
+	pci_bus_for_each_resource(dev->bus, r) {
+		if (!r || !r->flags || !resource_assigned(r))
+			continue;
+
+		if (!__resource_contains_unbound(r, &black_hole_res))
+			continue;
+
+		if (resource_assigned(&black_hole_res))
+			pci_dbg(dev, "iomem black hole workaround already applied\n");
+		else if (!insert_resource(r, &black_hole_res))
+			pci_info(dev, "iomem black hole workaround enabled\n");
+		else
+			pci_dbg(dev, "iomem black hole workaround add failed\n");
+		return;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab, genoa_iomem_black_hole);
+
 #ifdef CONFIG_PCIEASPM
 /*
  * Several Intel DG2 graphics devices advertise that they can only tolerate
-- 
2.47.3

