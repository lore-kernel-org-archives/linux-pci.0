Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124E2EDD52;
	Thu, 19 Feb 2026 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771540652; cv=none; b=ucSulL16LsNrE8DyI063hTN1bKbFdvdbHguGIhIxcDAcrY6m1cPGxVwH19tXxiqD9K50LCpL9xGeFVNIp5i2zBkum58lX1Kjbcmh4MqyZzg2ZtbbPlRAKnQOqsVC1wUostO/Je7xHWqSuTDVlLoubCnTQaj43nWow/29rZ5xkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771540652; c=relaxed/simple;
	bh=YmB3KUCkmYEgWGjj3AuUVLiDrC5gUY+ABV4u/XlVBnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6aSG/COIwuYC2oSPg/qLZiJwHPD01SlvvXfndD8Q9ifq9VuyixvOyro1FibLluCqbll3xro1W/8A7RxmNvYaTVOAh4KXHSkQeRdKymzcBhPGK6pqt2Mkycun8D9thCsGYls76yR3rLox0BgBTsnAg0FD5ie10yjhG9+Iv2qcAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 03LQHHlmSja39yaMEznjww==
X-CSE-MsgGUID: JaeTf47aQGSv/X1V/13l0g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Feb 2026 07:37:30 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.22])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E400B4006196;
	Fri, 20 Feb 2026 07:37:24 +0900 (JST)
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
Subject: [PATCH v6 15/16] arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
Date: Thu, 19 Feb 2026 23:35:41 +0100
Message-ID: <20260219223542.6364-16-john.madieu.xa@bp.renesas.com>
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

The RZ/G3E SMARC SoM has a fixed 100 MHz reference clock generator
for PCIe. Model it as a fixed-clock and assign it to the PCIe port.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v6: No changes
v5: No changes
v4: No changes
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

