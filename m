Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195BB352C37;
	Wed, 28 Jan 2026 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606320; cv=none; b=bTOW4EiVje8RI1hTQfG0TkSrPgagNYrfvmm7z1Am2qi2IpvRzv5ar6bPVE1Se7njAEevnR3iDqOvijBlMYhZgz163hdY2S36F7yV/xrvqA1Ze3ALOPEa7LHRRkuqhqvFwS0B23ijdHamMqqfVdvU3LXr7UacrOs9Y4eeBtLV4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606320; c=relaxed/simple;
	bh=3fInH03L2swBATsC1GERhSeiOb2Pk+r374dFG/7n5TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3uJdf+0o43wI7vz3Iwe8nkl26rAp0aatxN2ajI+MjeHgsguGz9Prw5+FeGh98XsYQ9K+APDnNhRJB8lIEe/KGNIBIaC7AiCKoEbx6ErCuimsamF9e9yoURM2fOg4q8+9BUahnlHSf7EXcsif0PhxzglHfAZNYb/2aJyB1VnzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: PdhGHBXfS0qqrqHJqr2BRA==
X-CSE-MsgGUID: 0Hzrz1G+RaKeC/7o22ZqHQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jan 2026 22:18:37 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.11])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BDC3B41665EF;
	Wed, 28 Jan 2026 22:18:32 +0900 (JST)
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
Subject: [PATCH v3 14/15] arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
Date: Wed, 28 Jan 2026 14:16:45 +0100
Message-ID: <20260128131647.120511-15-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128131647.120511-1-john.madieu.xa@bp.renesas.com>
References: <20260128131647.120511-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RZ/G3E SMARC SoM has a fixed 100 MHz reference clock generator
for PCIe. Model it as a fixed-clock and assign it to the PCIe port.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v3: No changes
v2: No changes

 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
index eb0de21d6716..7e2345bb9918 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -43,6 +43,12 @@ memory@48000000 {
 		reg = <0x0 0x48000000 0x0 0xf8000000>;
 	};
 
+	pcie_refclk: clock-pcie-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
@@ -168,6 +174,11 @@ phy1: ethernet-phy@7 {
 	};
 };
 
+&pcie_port0 {
+	clocks = <&pcie_refclk>;
+	clock-names = "ref";
+};
+
 &pinctrl {
 	eth0_pins: eth0 {
 		clk {
-- 
2.25.1

