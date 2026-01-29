Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812A02EB5A6;
	Thu, 29 Jan 2026 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722926; cv=none; b=P3szJdPmNGUWcqva+FfMYDbTlb9je1yGPlZxtTJYOcXV1Fy3ANENcxmyZ3iXRm5f05xfrqonxuSXjrA57VwfpUIArqtKwp5IVIideO754/3N0SMeQLuhS/IAfCTxUjd434Ds1Ej1Br7dlw5PL+ABZ1hU03JPo8HEHO2YsCimsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722926; c=relaxed/simple;
	bh=N4DinjPv1RntLkFwtr3UPGDJtSNdOcgdxTAFMnbQrAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=By4nV+nhi5KjXS9hDE4+WMjY32YGB8oD82vKtnIE+kXKxMvRkjX/xIxFeaeukXLEgPGgWDV4VJh1G6pWTmnKyJidplVsw1qNmvJS4jIknZBhLwOPK+fxo7YTdg4b8YpCwLDZSR4J73Ka3R41FffVsAXo17JpgzgshPf4WDdzZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: gOX9L7pbTMqBumd/jltjvg==
X-CSE-MsgGUID: +4oDu4dCTTqgHvqwJ6ZXNg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jan 2026 06:42:02 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.73])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4535A410CB72;
	Fri, 30 Jan 2026 06:41:57 +0900 (JST)
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
Subject: [PATCH v4 00/15] PCI: renesas: Add RZ/G3E PCIe controller support
Date: Thu, 29 Jan 2026 22:41:14 +0100
Message-ID: <20260129214130.16067-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/G3E SoC features a PCIe controller that shares similarities with
the existing RZ/G3S PCIe controller, but with several key differences.
This series adds support for the RZ/G3E PCIe controller by extending the existing
RZ/G3S driver and device tree bindings.

Key differences between RZ/G3E and RZ/G3S PCIe controllers:

Link Speed Support:
 - RZ/G3E: Supports PCIe Gen3 (8.0 GT/s) alongside Gen2 (5.0 GT/s)
 - RZ/G3S: Supports PCIe Gen2 (5.0 GT/s) only

Reset Control:
 - RZ/G3E: Uses register-based reset control mechanism
 - RZ/G3S: Uses exclusively external reset control signals

Inbound Window Configuration:
 - RZ/G3E: Requires precise power-of-2 window coverage with strict address
   alignment constraints. Non-power-of-2 memory regions must be split into
   multiple windows to avoid over-mapping, ensuring proper hardware address
   decoding for DMA operations.
 - RZ/G3S: Uses a simpler approach that rounds up to the next power-of-2,
   creating single larger windows. The hardware tolerates over-mapped regions.

Class/Revision IDs:
 - RZ/G3E: Requires explicit setting of class/revision values
 - RZ/G3S: Has default values in hardware

Clock Naming:
 - RZ/G3E: Uses "clkpmu" clock for power management
 - RZ/G3S: Uses "clkl1pm" PM control clock while CLKREQ_B is deasserting

Phy Settings:
 - RZ/G3E: Does not need PHY settings as it works with default hw values
 - RZ/G3S: Requires explicit PHY settings

This series extends the existing driver to detect the SoC type from the device
tree compatible string and configure the controller appropriately. The updates
are minimal and focused on the hardware-specific differences while keeping the
common code paths unified.

Changes:

v4:
 - Collected Ab tag
 - Fixed binding clock name constraint

v3:
 - Removed extra MaxItems in binding causing warnings
 - Fix potential crash for non-initialized rcdev in CPG driver
 - Fix binding contraints replacing 'description' with 'const' as per
   Geert and Rob's comment

v2:
 - Address Bjorn typo comments
 - Address Claidiu's comment on stylish
 - Use single inbound-window-configuration function for both G3E/G3S
 - Refactor goto laballing as per Claudiu's comments
 - Update bindings and reused G3S's interrupt ordering
   * This involves reordering interrupts in dt
 - Remove Board-specific PCIe dma-range.

John Madieu (15):
  PCI: rzg3s-host: Fix reset handling in probe error path
  PCI: renesas: rzg3s: Rework inbound window algorithm for multi-SoC
    support
  clk: renesas: rzv2h-cpg: Add support for init_{off|asserted}
    clocks/resets
  clk: renesas: r9a09g047: Add PCIe clocks and reset
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
  PCI: rzg3s-host: Make SYSC register offsets SoC-specific
  PCI: rzg3s-host: Make configuration reset lines optional
  PCI: rzg3s-host: Add SoC-specific configuration and initialization
    callbacks
  PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
  PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
  PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
  arm64: dts: renesas: r9a09g047: Add PCIe node
  arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 121 ++++--
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  69 ++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  16 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   4 +
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  11 +
 drivers/clk/renesas/r9a09g047-cpg.c           |   5 +
 drivers/clk/renesas/rzv2h-cpg.c               |  24 +-
 drivers/clk/renesas/rzv2h-cpg.h               |  34 +-
 drivers/pci/controller/pcie-rzg3s-host.c      | 387 ++++++++++++++----
 9 files changed, 549 insertions(+), 122 deletions(-)

-- 
2.25.1

