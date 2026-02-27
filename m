Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF4438FF3;
	Fri, 27 Feb 2026 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206473; cv=none; b=GHkqcSlSMiqGysYjSLbTHJnNMfJDslm0ugd9+lRl094/vRrzXD6+h++SvJrYRev8/sjaHgUCc9xt42K1a81qbd6VLNR39v2XA+a8V1XS9guea6rMjBywdnsaijD2haYxAbIKbylS6fixTEmoQDBGPJDa8Br7dKkx19ftVEpIMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206473; c=relaxed/simple;
	bh=L9i9HiXEcDHYRluJUkiYGhM9m0RvD9PN4A6a41MX0DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7Kw1D+VDbXGu6CK+MEX1HUwRf6YROsWgnFSEYa1HWCiikAOeIYHp1XdxGLwLmKrwJU8gTFo9O1LkqlcwOh68TBOjUo8rHnvXKLP1/pbnFVtdeBgKbloHa/ow3/8wFLJk1hGZZ3F/L8WCsOoJElKMbnJgKDkhlrmrTp5IELEt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: HKU9ubRHSwenvfXS60GHig==
X-CSE-MsgGUID: tslFeavgT4yZHODidJfO8g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2026 00:34:30 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.57])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 451804007131;
	Sat, 28 Feb 2026 00:34:25 +0900 (JST)
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
Subject: [PATCH v7 14/15] arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
Date: Fri, 27 Feb 2026 16:32:34 +0100
Message-ID: <20260227153236.55988-15-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227153236.55988-1-john.madieu.xa@bp.renesas.com>
References: <20260227153236.55988-1-john.madieu.xa@bp.renesas.com>
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

v7: No changes
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

