Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB654F4028;
	Tue, 13 Oct 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897096; cv=none; b=bsbGfMuhGbdzK6KpkpoxG5q9QC7I1wqcEMSDRx0yEyAI5b0Wn7nmnS1RNS3jczGH5zoy4s5GkQci8+TuIn+WzJbNGylr0pA34Ev7bMnZ7msCQBsbUaOocdcJWY675XIQaEHPkTrlzW8sofcrTDN8BLDywi4wQshQXoMyT7AJgEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897096; c=relaxed/simple;
	bh=ZZITAiBaaQqy3ghN86ef/wybnGbKCy2GxZY4/xKbIo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxE955xWCZyFaFANalOCwsPzrj+VJZ3eG0pZx6Xk7iJ79NQpi9lw2gW1RmItqfLprbyDqAiCj/Y4LUoDZfdEsy4R/JhXGku07mGy39KWn7SRPpBSBZaur++nVJZcMbJTOxkIGSUS3GrmUcDF7FoIZnpVNZ6gSLXIl1eGSZTFORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbyxAM0+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbyxAM0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897094; x=1823433094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZITAiBaaQqy3ghN86ef/wybnGbKCy2GxZY4/xKbIo4=;
  b=DbyxAM0+Q5Y6oEvPdFxkTDtpBD6kzXZp3NMPYsHdWaWPPILcHS/Le0/4
   hw0n7j4vBFL2b0rTmD6TuRJbPadw3DL4H/Ob9I2K+CUMmji4iKEHbUeTE
   qlelWNyP6ZaxERg3EjyhFQvKGH4pU1go91wgDi6pj9+6cGzqUwY5neki1
   Ou0p5OdHKftDgpNOczg4tabSAbijLdbmqXulh+HKZtuuw6HfzSR0irzR+
   vR9tb+HBNQF38zT66OY6z4+OH40pvYWGrUsKHam3PEzjJtUFjCyZqfKE8
   Gwel5biMG/JXvPxaJ23KErWwhapzafFc8J9h/mv1K2hLAm5cqnBi4FP74
   g==;
X-CSE-ConnectionGUID: BKGLhaRMRNKTWU+DeuRLhg==
X-CSE-MsgGUID: Y5TEelHSS5mUMvyEOztU1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="614479"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="614479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:11:34 -0700
X-CSE-ConnectionGUID: 6VBpCap3SwSq17gCFNNCQw==
X-CSE-MsgGUID: 2wV9QJoWTFKJVAw9y1h1Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1248129"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:11:28 -0700
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
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Date: Tue, 13 Oct 2026 16:09:42 +0300
Message-ID: <20261013130948.6231-9-ilpo.jarvinen@linux.intel.com>
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
Cc: Borislav Petkov <bp@alien8.de>

As an alternative to this, I've also tested reverting the commit
07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") and
that also resolves the issue by retaining "9c000000-9cffffff : Reserved"
entry in the resource tree.

---
 arch/x86/pci/fixup.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df75..cc463bf492b6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
 
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
+static struct resource genoa_black_hole = DEFINE_RES_MEM_NAMED(0x9c000000,
+							       SZ_64K,
+							       "reserved");
+
+static void genoa_iomem_black_hole(struct pci_dev *dev)
+{
+	struct resource *r;
+
+	pci_bus_for_each_resource(dev->bus, r) {
+		if (!r || !r->flags || !resource_assigned(r))
+			continue;
+
+		if (!__resource_contains_unbound(r, &genoa_black_hole))
+			continue;
+
+		if (resource_assigned(&genoa_black_hole))
+			pci_dbg(dev, "iomem black hole workaround already applied\n");
+		else if (!insert_resource(r, &genoa_black_hole))
+			pci_info(dev, "iomem black hole workaround enabled\n");
+		else
+			pci_dbg(dev, "iomem black hole workaround add failed\n");
+		return;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab, genoa_iomem_black_hole);
+
 #define RS690_LOWER_TOP_OF_DRAM2	0x30
 #define RS690_LOWER_TOP_OF_DRAM2_VALID	0x1
 #define RS690_UPPER_TOP_OF_DRAM2	0x31
-- 
2.47.3

