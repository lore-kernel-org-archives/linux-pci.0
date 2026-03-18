Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E53491F1;
	Wed, 18 Mar 2026 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823913; cv=none; b=BRoAai9WNRAu/HqFopCJCvxY4iikCF3Cg7wsy75daHUQnB8epZWHVa3QmDZY7AVhHqENRcqRQZhgLFfYRrF9cZarnd+wm4R6ZBCOKb3eXuYh1ZweYwKYBO48i+qukIz1IDk71Th2+LpllUpNoTyBF5ldMAVHhpq7dv5SGYZXy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823913; c=relaxed/simple;
	bh=LnxxybIPHOpY4RX0KqGlXyijwhLZmWbUwp2cGXSnD44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwOuM0LZQQhYi7yNS+HXGLK3HvmWSzjUGU/T6qDuOf4MoPNo5Wwms1g9jLHx0ojtGDtkToVIEQy0Iivi80lWuTX4rncW0LVpqFMXwE/KbRrfCuqwI4iWKpGjyJ24ota7VGHvekRZzC/sf/b/+6TMtvuTEAVqMYmO2ZRh0MNe7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: nxtNVFLjSFuPoHpZ/C0AJQ==
X-CSE-MsgGUID: ZWTLqkLLS527mSv0fT1+Ew==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Mar 2026 17:51:50 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F2E62400F93B;
	Wed, 18 Mar 2026 17:51:45 +0900 (JST)
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
Subject: [PATCH v9 4/4] arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
Date: Wed, 18 Mar 2026 09:51:19 +0100
Message-ID: <20260318085119.44717-5-john.madieu.xa@bp.renesas.com>
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

The RZ Smarc Crarrier-II board has PCIe slots mounted on it.
Enable PCIe support.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v9:
 - Renamed gpio-hog node from 'pcie-clkreq-n' to 'pcie-clkreq-n-hog'
   to satisfy DT schema naming constraint (reported by Biju)
 - Updated line-name with proper signal name on the board
 - Fixed node sort order within &pinctrl (reported by Geert)

v8: No changes
v7: No changes
v6: No changes
v5: No changes
v4: No changes

v3:
 - Splitted enablement into common carrier dtsi and board dts

v2:
 - Removed board-specific dma-ranges.
 - Merged enablement and pinmux assignment in same file

 .../boot/dts/renesas/r9a09g047e57-smarc.dts      | 16 ++++++++++++++++
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi  |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 696903dc7a63..3e24e916874f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -122,6 +122,11 @@ key-sleep {
 #endif
 };
 
+&pcie {
+	pinctrl-0 = <&pcie_pins>;
+	pinctrl-names = "default";
+};
+
 &pinctrl {
 	canfd_pins: canfd {
 		can1_pins: can1 {
@@ -145,6 +150,17 @@ nmi_pins: nmi {
 		input-schmitt-enable;
 	};
 
+	pcie-clkreq-n-hog {
+		gpio-hog;
+		gpios = <RZG3E_GPIO(4, 5) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "PCIE_M2B_CKREQ";
+	};
+
+	pcie_pins: pcie {
+		pinmux = <RZG3E_PORT_PINMUX(G, 7, 1)>; /* PCIE_RST_OUT# */
+	};
+
 	rsci2_pins: rsci2 {
 		pinmux = <RZG3E_PORT_PINMUX(1, 0, 1)>, /* RXD2 */
 			 <RZG3E_PORT_PINMUX(1, 1, 1)>, /* TXD2 */
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index b607b5d6c259..e2a34577a1a1 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -96,6 +96,10 @@ &i2c0 {
 	clock-frequency = <400000>;
 };
 
+&pcie {
+	status = "okay";
+};
+
 &scif0 {
 	status = "okay";
 };
-- 
2.25.1

