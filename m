Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0066232D0FE;
	Thu, 19 Feb 2026 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771540884; cv=none; b=t0FtXM5hi8EYIqFlfQnp6YLEuQFL52UyJISJ2PuBS9X971ocBAu/RcBUbWUAmIFL45FxmuK4NhFJcJib2HsrREof2DYkN+lJTlc7e0YF2n5JOTVZGX8oq8O0rW06zWATNp3shmZS00oW9VxAomlO6G2xA0VhoNVxCwN8fCSDhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771540884; c=relaxed/simple;
	bh=EIiAFLCrjiZpH3SBI5Gg+wwoMUF9Kw69mNXGGGlaCzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cudV+JzF3i0Y+hWdBlQiibuPHhklFRfConvAlDRUQPw5avlu/eXV9Atg7qhmeBlPV9jKal9OaKnazZ/NBw2T3vs7yqoA1bZlXOxnUxQ3vQ/mVISURtUXdkStM4gnFnw/cRaraIDHm9Odpe/A2obgUI5r/D1PNeUrvthGU6bfph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: a/xfYw+JQPK7MF5w2E1FHw==
X-CSE-MsgGUID: vPn6dvijR4eJI2jWjYSkNg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Feb 2026 07:36:18 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.22])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3FAF64010DC2;
	Fri, 20 Feb 2026 07:36:12 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v6 03/16] PCI: renesas: rzg3s: Rework inbound window algorithm for multi-SoC support
Date: Thu, 19 Feb 2026 23:35:29 +0100
Message-ID: <20260219223542.6364-4-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
References: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing inbound window configuration algorithm has two issues that
prevent proper operation on RZ/G3E:

1. Over-mapping: Using roundup_pow_of_two() on the remaining region size
   can result in windows that extend beyond the intended memory region.

2. Alignment violation: Addresses are only aligned to 4K regardless of
   the actual window size. According to the RZ/G3S HW manual (Rev.1.10,
   section 34.6.6.7) and RZ/G3E HW manual (Rev.1.15, section 6.6.7.6),
   bit carry must not occur when adding AXI Window Base and AXI Window
   Mask registers. This effectively requires the base address to be
   aligned to the window size.

RZ/G3E strictly enforces these constraints and requires precise window
boundaries with properly aligned addresses.

Rework the algorithm to properly handle arbitrary region sizes and
alignment constraints by splitting non-power-of-2 regions into multiple
windows. The new approach iteratively selects the largest power-of-2
size that:
 - Fits within the remaining region (__fls of remaining size)
 - Does not exceed the natural alignment of the CPU address (__ffs)
 - Does not exceed the natural alignment of the PCI address (__ffs)

This ensures windows never over-map beyond the intended region and
satisfies the hardware requirement that base address + mask must not
cause bit carry, while maintaining the 4K * 2^N byte window size
constraint.

The reworked algorithm is required for RZ/G3E support and remains
fully compatible with RZ/G3S.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v6: No changes

v5:
 - Updated HW manual section specification
 - Collected Rb tag

v4: No changes
v3: No changes
v2: New patch

 drivers/pci/controller/pcie-rzg3s-host.c | 53 +++++++++++++-----------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 222891324374..7f5ffc5c218a 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1270,50 +1270,55 @@ static int rzg3s_pcie_set_inbound_windows(struct rzg3s_pcie_host *host,
 	u64 pci_addr = entry->res->start - entry->offset;
 	u64 cpu_addr = entry->res->start;
 	u64 cpu_end = entry->res->end;
-	u64 size_id = 0;
 	int id = *index;
 	u64 size;
 
-	while (cpu_addr < cpu_end) {
+	/*
+	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.6.6.7) and
+	 * RZ/G3E HW manual (Rev.1.15, section 6.6.7.6):
+	 * - Each window must be a single memory size of power of two
+	 * - Mask registers must be set to (2^N - 1)
+	 * - Bit carry must not occur when adding base and mask registers,
+	 *   meaning the base address must be aligned to the window size
+	 *
+	 * Split non-power-of-2 regions into multiple windows to satisfy
+	 * these constraints without over-mapping.
+	 */
+	while (cpu_addr <= cpu_end) {
+		u64 remaining_size = cpu_end - cpu_addr + 1;
+		u64 align_limit;
+
 		if (id >= RZG3S_MAX_WINDOWS)
 			return dev_err_probe(host->dev, -ENOSPC,
 					     "Failed to map inbound window for resource (%s)\n",
 					     entry->res->name);
 
-		size = resource_size(entry->res) - size_id;
+		/* Start with largest power-of-two that fits in remaining size */
+		size = 1ULL << __fls(remaining_size);
 
 		/*
-		 * According to the RZ/G3S HW manual (Rev.1.10,
-		 * section 34.3.1.71 AXI Window Mask (Lower) Registers) the min
-		 * size is 4K.
+		 * The "no bit carry" rule requires base addresses to be
+		 * aligned to the window size. Find the maximum window size
+		 * that both addresses can support based on their natural
+		 * alignment (lowest set bit).
 		 */
-		size = max(size, SZ_4K);
+		align_limit = min(cpu_addr ? (1ULL << __ffs(cpu_addr)) : ~0ULL,
+				  pci_addr ? (1ULL << __ffs(pci_addr)) : ~0ULL);
 
-		/*
-		 * According the RZ/G3S HW manual (Rev.1.10, sections:
-		 * - 34.3.1.69 AXI Window Base (Lower) Registers
-		 * - 34.3.1.71 AXI Window Mask (Lower) Registers
-		 * - 34.3.1.73 AXI Destination (Lower) Registers)
-		 * the CPU addr, PCIe addr, size should be 4K aligned and be a
-		 * power of 2.
-		 */
-		size = ALIGN(size, SZ_4K);
-		size = roundup_pow_of_two(size);
-
-		cpu_addr = ALIGN(cpu_addr, SZ_4K);
-		pci_addr = ALIGN(pci_addr, SZ_4K);
+		size = min(size, align_limit);
 
 		/*
-		 * According to the RZ/G3S HW manual (Rev.1.10, section
-		 * 34.3.1.71 AXI Window Mask (Lower) Registers) HW expects first
-		 * 12 LSB bits to be 0xfff. Subtract 1 from size for this.
+		 * Minimum window size is 4KB.
+		 * See RZ/G3S HW manual (Rev.1.10, section 34.3.1.71) and
+		 * RZ/G3E HW manual (Rev.1.15, section 6.6.4.1.3.(74)).
 		 */
+		size = max(size, SZ_4K);
+
 		rzg3s_pcie_set_inbound_window(host, cpu_addr, pci_addr,
 					      size - 1, id);
 
 		pci_addr += size;
 		cpu_addr += size;
-		size_id = size;
 		id++;
 	}
 	*index = id;
-- 
2.25.1

