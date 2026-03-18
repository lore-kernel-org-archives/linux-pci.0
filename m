Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF736BCDC;
	Wed, 18 Mar 2026 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823907; cv=none; b=fvfFTsrO5pQKvSFqkd08uWKoRqI8IZMAAjhY0qYQk2VstJbfXPUamsFyEqM4oZPBb6xg4J4YCArXz7M59cOiXuEXz6CXCwk6oSV498g6H2ETrhAuJPYHAg53JdcHdZQdcwJDBkpMnaz2j7IVrMTqGrOdH3Y807H5bGQPIPkuYTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823907; c=relaxed/simple;
	bh=zexrboqHSr0BacjYL6ioKwUvCrBSWh26gIT2xxEP3cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KictA8FxWVnWFP2yuq3qCNtjOelpEQNurOADcOK2W897LBeRGhxYWjjjsMp07IlcTPuWB2yFeGxEXn1mIMX2OkA2a8cyulv8qhVA4WmT7iVDjncwnvDFMrdSjA7eDStOjscNdyByh5nWkGufddHTFBIyPeVUpKBanaCiRAcOzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: OVfhYCr6QGqz79BpbX7LAg==
X-CSE-MsgGUID: tIFl4+VWT+me+y5m+oK33w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Mar 2026 17:51:45 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B824040103B0;
	Wed, 18 Mar 2026 17:51:40 +0900 (JST)
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
Subject: [PATCH v9 3/4] arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
Date: Wed, 18 Mar 2026 09:51:18 +0100
Message-ID: <20260318085119.44717-4-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318085119.44717-1-john.madieu.xa@bp.renesas.com>
References: <20260318085119.44717-1-john.madieu.xa@bp.renesas.com>
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

v9: No changes
v8: No changes
v7: No changes
v6: No changes
v5: No changes
v4: No changes
v3: No changes
v2: No changes

 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
index 3b571c096752..fcf01fcfb6f3 100644
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
@@ -176,6 +182,11 @@ phy1: ethernet-phy@7 {
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

