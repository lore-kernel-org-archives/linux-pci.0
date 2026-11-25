Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599303;
	b=k9pE1JnP3NjyEDLdQFbvsNCestUYYKpEbnJdUvs+jnyLcwnWYgIn8ToamZMB1YZcPB50
	 XvFnFEUSEo7uaOHwkaWLgDmAZ4SlhcRK548//8x1ehy6pmQXlgkQopsDlAmhjR31cnq7I
	 FTWvFjlgMxqy75EcSEqvXJw0BzoEnUt6njgPUIsOWP3XSvh+YaSESwzdId1XvO+LS1svn
	 lQtURXEq8Y8gPQ6YFIIr0VlhIHWGo6wjvd7v8Qp5+lbfsaRzUPuRfpt3s0xJX6lawoqt8
	 GMxIUWc7W8dJpDFkRCkL4mGpLicTvUbrB2EcLZSF1tnLSKezxtyxvr49tBJ1NdnePVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599303;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kSlbM9hsfG7J4LPZAfgyWbr+SMYm5xmP8NU7l4J/3PU=;
	b=jN8xvOw5vN9a95lMU0exQTCv1rrlWNbeu8IjdBwWmDHrf2ou2tTeIowws3YVs7RpzZak
	 oeDYv9c5o2/hL3FU3DN8rhns/a6QI8tM7gAy+xhAFQI2GbCdUy43quNd+2FUx4aGKCg8Y
	 q7dCzhNZz6HKF9toANXm5uV9OvoJ+vd0fBG/e195cL89qIWAg7Ahk8hdlcPCaF+moT+y+
	 B94OG7R9Xo4Ub+1hQmvFNohaST9KiLGuN8JUUw5iF4R7JfuLigZL9+r9O2V9WGagj/jhr
	 ZokWGPBYqzlXRi9/Hesodz1BJEIwIA52z57pGMMZ9utsEtftfP7MLNRpBQvqyhk7F7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDJbb02j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2AC60A6F44;
	Wed, 25 Nov 2026 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDJbb02j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795599303;
	b=wdG1gNVF4jUfprOl6H9FWDPxexjU4eoBKPWq0H61WFDImmxQzl4xOu2PhesKKdpJX1hp
	 xRraoS+zSZyQdP2+iped7ooXX+KgUVO2k8hGKBZRTeA2cZDSiRhTk+69QTXAMQB97fSED
	 zPvfHZZ4+S2B6XGfMMOvkDLPEpTgU944zzD0MYZh7sXQnlLUki9LqhEtaI/FRIjbwRuGN
	 rNO2kFcUyIQ9l2YGTfDzyAK0WctH4Cr14YCPHFQcA3j7K3uSSDC/KF547Wh7J7pZLGK7/
	 FYPqAW12DZyFSq3Mb1+AX4EZ1GiWpWOaGKM3Kzy6WMWhRGW5z9eTTIU4ce+Gn5tCMXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795599303;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kSlbM9hsfG7J4LPZAfgyWbr+SMYm5xmP8NU7l4J/3PU=;
	b=YnTTzJrYJBHg37HAg5PjQS5VqeUMcuOOzXh8W5DvuV+KfROvCwwJNQKuLx7QXQnQfpxa
	 LNFAdm1RgcuujH5CD5Ve+nUTSuvBh141D/ltqgY0WYgIGTjzErlyCenKLTj07L2fYFVZb
	 cr4acztojjZUvbgfw0JmP9GJxf3JvXDhTRJEOV3Nubh9pnaV4U1YkdFnYzdPw/JK83/ds
	 inaqTnQbE1N0Hrnt/2XA4FVN1yRMvGDQFPXB4uA4taAJxIe/RH/tbvm7BpJvc49wnKRVV
	 eey04UlzXXAeQHn//5F7WphuwDj8VEl/v/BVs6ewLXSb9TQEHIX1ZjEP2WeMAY/TMVA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2C9241F01564;
	Wed, 25 Nov 2026 09:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599303;
	bh=kSlbM9hsfG7J4LPZAfgyWbr+SMYm5xmP8NU7l4J/3PU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XDJbb02jxOyaNYEKawP2/xDpSGGnuZPbH4LcTRPNOpcWPdeJEW1hbVAOVMQdikBoR
	 gDQRc6rG192S14LEBbukhOdZGF0HUqkUjUDPvj6CBDaCquvi2ehxcac+AKZcr+JiZI
	 Lq17AytwVQxZCFk776NGz+euL5b4S5ZejR3eEwturwCJaNBxvVRzYelWleEkHr8DSp
	 Zs5wnfYp0vRsVxJqul3vpXfU49pFfWTfAoZX3ChOCTyaKtNUPIQhBQC8SXOTcW9PgO
	 6QXXhkA4e5s/ZtJEggI8/QnGuZOQhS1rLA3M/ePrlcRWPEXcScOYNUDEE/UpXgYOlG
	 KJVQ50g9meIyQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0EC584CE26;
	Wed, 25 Nov 2026 09:34:38 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 25 Nov 2026 10:33:56 +0100
Subject: [PATCH RFC v4 14/15] arm64: dts: s32g: Add PCIe controller nodes
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-s32g_serdes-v4-14-3bfe0589be8d@oss.nxp.com>
References: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
In-Reply-To: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bogdan Hamciuc <bogdan.hamciuc@nxp.com>, 
 Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795599274; l=8174;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=4hEy+CFkkzDf8s4SiBEzs7e2GrzS7v0Nc6GdSnPh+L8=;
 b=V4wC68x4C2n9U3RVLjh/krysblPQcprKZ81C/Qc6SVpZM33LH67QzUIGKMqL5qrY/TWFx+pRQ
 Zos3EQ5XTpmC9/QJhcLHWGwI8ulnX4yumEIrU7CsFWjzwGXGTIkHE2O
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
Content-Transfer-Encoding: 7bit

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Add the two PCIe controllers of S32G2 and S32G3, disabled. PCIe_0 pairs
with SerDes_0 and PCIe_1 with SerDes_1. A board device tree enables a
controller and references the lanes of the matching SerDes from its
root port, one phys entry per lane. The nodes of both SoCs differ only
in the compatible.

The configuration space (0x5f_ffffe000 and 0x4f_ffffe000) lies above
the 32-bit window mapped by soc@0, so the controllers sit at the device
tree root.

The root ports are labelled (pcie0_rp, pcie1_rp), so that boards and
overlays can extend them by label.

Add '#address-cells = <0>' to the GIC nodes: the PCIe interrupt-map
entries name the GIC as their interrupt parent, and dtc warns without
it.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 81 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 81 ++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 0b070f7b5f22..1b6affb15d03 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -916,7 +916,88 @@ gic: interrupt-controller@50800000 {
 			      <0x50420000 0x2000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 		};
 	};
+
+	/*
+	 * The PCIe config space (0x5f_ffffe000 / 0x4f_ffffe000) lies above the
+	 * 32-bit window mapped by soc@0, so the controllers are not under it.
+	 */
+	pcie0: pcie@40400000 {
+		compatible = "nxp,s32g2-pcie";
+		reg = <0x00 0x40400000 0x0 0x00001000>,	/* dbi */
+		      <0x00 0x40420000 0x0 0x00001000>,	/* dbi2 */
+		      <0x00 0x40460000 0x0 0x00001000>,	/* atu */
+		      <0x00 0x40470000 0x0 0x00001000>,	/* dma */
+		      <0x00 0x40481000 0x0 0x000000f8>,	/* ctrl */
+		      <0x5f 0xffffe000 0x0 0x00002000>;	/* config */
+		reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
+		dma-coherent;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x01000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
+			 <0x02000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
+			 <0x43000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;
+		bus-range = <0x0 0xff>;
+		linux,pci-domain = <0>;
+		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi", "dma";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &gic GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &gic GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &gic GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		pcie0_rp: pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+			device_type = "pci";
+		};
+	};
+
+	pcie1: pcie@44100000 {
+		compatible = "nxp,s32g2-pcie";
+		reg = <0x00 0x44100000 0x0 0x00001000>,	/* dbi */
+		      <0x00 0x44120000 0x0 0x00001000>,	/* dbi2 */
+		      <0x00 0x44160000 0x0 0x00001000>,	/* atu */
+		      <0x00 0x44170000 0x0 0x00001000>,	/* dma */
+		      <0x00 0x44181000 0x0 0x000000f8>,	/* ctrl */
+		      <0x4f 0xffffe000 0x0 0x00002000>;	/* config */
+		reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
+		dma-coherent;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x01000000 0x0 0x00000000 0x4f 0xfffe0000 0x0 0x00010000>,
+			 <0x02000000 0x0 0x00000000 0x48 0x00000000 0x0 0x80000000>,
+			 <0x43000000 0x1 0x00000000 0x49 0x00000000 0x6 0xfffe0000>;
+		bus-range = <0x0 0xff>;
+		linux,pci-domain = <1>;
+		interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi", "dma";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &gic GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &gic GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &gic GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &gic GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		pcie1_rp: pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+			device_type = "pci";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 0d03daa881bf..9eed2428732a 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -1056,6 +1056,7 @@ serdes1: serdes@44180000 {
 
 		gic: interrupt-controller@50800000 {
 			compatible = "arm,gic-v3";
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg = <0x50800000 0x10000>,
@@ -1067,6 +1068,86 @@ gic: interrupt-controller@50800000 {
 		};
 	};
 
+	/*
+	 * The PCIe config space (0x5f_ffffe000 / 0x4f_ffffe000) lies above the
+	 * 32-bit window mapped by soc@0, so the controllers are not under it.
+	 */
+	pcie0: pcie@40400000 {
+		compatible = "nxp,s32g3-pcie", "nxp,s32g2-pcie";
+		reg = <0x00 0x40400000 0x0 0x00001000>,	/* dbi */
+		      <0x00 0x40420000 0x0 0x00001000>,	/* dbi2 */
+		      <0x00 0x40460000 0x0 0x00001000>,	/* atu */
+		      <0x00 0x40470000 0x0 0x00001000>,	/* dma */
+		      <0x00 0x40481000 0x0 0x000000f8>,	/* ctrl */
+		      <0x5f 0xffffe000 0x0 0x00002000>;	/* config */
+		reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
+		dma-coherent;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x01000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
+			 <0x02000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
+			 <0x43000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;
+		bus-range = <0x0 0xff>;
+		linux,pci-domain = <0>;
+		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi", "dma";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &gic GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &gic GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &gic GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		pcie0_rp: pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+			device_type = "pci";
+		};
+	};
+
+	pcie1: pcie@44100000 {
+		compatible = "nxp,s32g3-pcie", "nxp,s32g2-pcie";
+		reg = <0x00 0x44100000 0x0 0x00001000>,	/* dbi */
+		      <0x00 0x44120000 0x0 0x00001000>,	/* dbi2 */
+		      <0x00 0x44160000 0x0 0x00001000>,	/* atu */
+		      <0x00 0x44170000 0x0 0x00001000>,	/* dma */
+		      <0x00 0x44181000 0x0 0x000000f8>,	/* ctrl */
+		      <0x4f 0xffffe000 0x0 0x00002000>;	/* config */
+		reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
+		dma-coherent;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x01000000 0x0 0x00000000 0x4f 0xfffe0000 0x0 0x00010000>,
+			 <0x02000000 0x0 0x00000000 0x48 0x00000000 0x0 0x80000000>,
+			 <0x43000000 0x1 0x00000000 0x49 0x00000000 0x6 0xfffe0000>;
+		bus-range = <0x0 0xff>;
+		linux,pci-domain = <1>;
+		interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi", "dma";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &gic GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &gic GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &gic GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &gic GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		pcie1_rp: pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+			device_type = "pci";
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;

-- 
2.55.0


