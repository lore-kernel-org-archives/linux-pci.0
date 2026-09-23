Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7732B133;
	Wed, 23 Sep 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169548; cv=none; b=kJZbzdatOCs4+SOfNyWa4V9NZ9JD7y18NjlfM6HnNFjPadtHFUtoMc8WoCZoHbiwvLiIMk7eC/jDgUEKqc5d7cXxZnC7TbFdK8qMe3OqAwncd9qxNNA7U27/VUHuJKgkUa3wLZepBZv/NU6QStreTyd5+ONoV7rLMeartmBvBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169548; c=relaxed/simple;
	bh=shV/jHwiOOO+2nu26tUkKGDmxnj6c238IyYyiu83uR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmLzBb6fHPyi/Bcj2x1NA4la1othJQybyiIVjvxskk7dM3eHwBilKD1ls+HxXTZbgqwNNSOsRVm3LNZASGHZYqQTleJiU91b5CjmbSZYtoZoeAgxMQQ+5d0MiJVew96MTkorLzHYIFVCM0/mcjhTKp7HlteVfdRXJT6IsnWZjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpuKPlhl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpuKPlhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790169544; x=1821705544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shV/jHwiOOO+2nu26tUkKGDmxnj6c238IyYyiu83uR0=;
  b=lpuKPlhl90tQSgplZBFn8FoFK2qOMgsow9yX61jjFfoqlOOVnhCujwrc
   /DiRUn4te6iLFa8JWI9liVcNyd6EoXBngF//e081tYP9XSKVUADb9t8Pn
   ZzQUsRcDqbv1ZZ+9fg2Vbi6YvXlbLdbv7o95TJeDEZn/ARhF2ynonqPIy
   WTz2WnmtSiCjHO9xraYJ4xiu9pZqHAJ54IBp3CzcxsppAjWM8wE7hfaKb
   M9DNxlz3TVIgfBRdjgqluEkSTA6GpAzeMPGkkO6YCF28TRiFMdrT1Blzf
   xERrxR0M7OFCw0GNo4i2VTQf2lPxq3oacPUb8z9a7vbuOh+E4qAIv52zA
   Q==;
X-CSE-ConnectionGUID: DmYBjP/iR/Oba//jQ2vWHg==
X-CSE-MsgGUID: HlzectgsTXaSLaKlvu7Smg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90886641"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="90886641"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 06:18:57 -0700
X-CSE-ConnectionGUID: m6WdkbLYTZGqzoTJLaYxXQ==
X-CSE-MsgGUID: s7hw7WjkQQyUFIaw1/+0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="273080862"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 06:18:51 -0700
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
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/5] PCI/quirks: Avoid certain BAR 0 address with igb
Date: Wed, 23 Sep 2026 16:17:55 +0300
Message-ID: <20260923131757.7792-6-ilpo.jarvinen@linux.intel.com>
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

While testing the resource placement changes, my tests hit a case where
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

Apparently, the igb driver bails out, after its initial sanity check
detects an unexpected ~0 read. Hacking around the sanity check just
results in more failures down the road so the sanity check itself is not
the cause for the failure.

The resource placement looks valid so the actual placement patches seem
to work normally.

All other possible 1M address I could test (with a hack patch) did work.

Add quirk to reshuffle igb resources, use BAR 3 to block the problematic
address.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I know this is ugly and I don't like it either but do not know better
way to avoid the regression.

I've tried with iommu=off and that did not resolve the issue.

I also managed to prove igb works with the same resource layout in
another system. So identifying the case should probably be tightened
by matching with more devices than the one used by igb. This is open
to discussion.

---
 drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..e6f3e2ab1fd4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6288,6 +6288,62 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
 
+/*
+ * The igb driver probe (due to reads returning ~0 unexpected) when BAR 0
+ * appears at 0x9c000000. The cause is unknown.
+ *
+ * Use BAR 3 to block 0x9c000000 address.
+ */
+static void bar0_address_breakage(struct pci_dev *dev)
+{
+	struct resource *bar0 = pci_resource_n(dev, 0);
+	struct resource *bar3 = pci_resource_n(dev, 3);
+	resource_size_t broken_addr = 0x9c000000;
+	struct resource *res;
+	int i, ret;
+
+	if (bar0->start != broken_addr)
+		return;
+
+	/*
+	 * HW BAR sizes seems to vary. Exclude non-1M BAR 0 case and
+	 * sanity check BAR 0 & 3 before attempting this quirk.
+	 */
+	if (resource_type(bar0) != IORESOURCE_MEM ||
+	    resource_size(bar0) != SZ_1M ||
+	    resource_type(bar3) != IORESOURCE_MEM)
+		return;
+
+	pci_info(dev, "%pR: relocating BAR\n", bar0);
+
+	pci_dev_for_each_resource(dev, res, i) {
+		if (!resource_assigned(res) ||
+		    resource_type(res) != IORESOURCE_MEM)
+			continue;
+
+		pci_release_resource(dev, i);
+	}
+
+	resource_set_range(bar3, broken_addr, resource_size(bar3));
+	bar3->flags &= ~IORESOURCE_UNSET;
+	pci_claim_resource(dev, 3);
+	if (!resource_assigned(bar3)) {
+		bar3->flags |= IORESOURCE_UNSET;
+		pci_warn(dev, "resource relocation failed\n");
+	}
+
+	pci_dev_for_each_resource(dev, res, i) {
+		if (resource_assigned(res) ||
+		    resource_type(res) != IORESOURCE_MEM)
+			continue;
+
+		ret = pci_assign_resource(dev, i);
+		if (ret)
+			pci_warn(dev, "resource relocation failed\n");
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1533, bar0_address_breakage);
+
 #ifdef CONFIG_PCIEASPM
 /*
  * Several Intel DG2 graphics devices advertise that they can only tolerate
-- 
2.47.3

