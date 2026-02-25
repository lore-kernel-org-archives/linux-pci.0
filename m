Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B451325708;
	Wed, 25 Feb 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009818; cv=none; b=f/C1XGTJ1ekp+i6JRweKknDGtI1yuY+p/zzYH5CYM0/mSilGFn8loU413OHj4jr2UcBVcudIen30blbFhzDS9ZHanRoR7NI8MFXPLomeDynnOXfGfpxhxxusHnx6hTATAVuCEGfe5+vLInwB0/d7muyrVKthYKdB5Rtp/TurfQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009818; c=relaxed/simple;
	bh=yhGs3eKg5h2wSBv4DZuGKN4+n0eP4/2qxR0ajVtwHRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnFVEkUYX1aCVqEezBSCdp9MTxt4zG/aAdX0DOeNeIvAf7e2wGNPMEhXWZDgzR3WDr8sd+l9GPXn20lxxHBUKiGAXNBtt1ItQZnMtzvqItl5id5v4XWn9nyMG0DugaFp0I1X55A6/aMohZH/WJ1LpVoMFyIw31Rk1ZfcaXpqeNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTP id 61P8tBd6077809;
	Wed, 25 Feb 2026 16:55:12 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Feb
 2026 16:55:11 +0800
From: Randolph <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>,
        <christian.bruel@foss.st.com>, <Ghennadi.Procopciuc@nxp.com>,
        <quic_wenbyao@quicinc.com>, <qiang.yu@oss.qualcomm.com>,
        <vincent.guittot@linaro.org>, <vidyas@nvidia.com>,
        <elder@riscstar.com>, <s-vadapalli@ti.com>,
        <ciprianmarian.costea@nxp.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v11 2/4] riscv: dts: qilai: Add PCIe node into the QiLai SoC
Date: Wed, 25 Feb 2026 16:55:02 +0800
Message-ID: <20260225085504.3757601-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225085504.3757601-1-randolph@andestech.com>
References: <20260225085504.3757601-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 61P8tBd6077809

From: Randolph Lin <randolph@andestech.com>

Add the Andes QiLai PCIe node, which includes 3 Root Complexes.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 arch/riscv/boot/dts/andes/qilai.dtsi | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/riscv/boot/dts/andes/qilai.dtsi b/arch/riscv/boot/dts/andes/qilai.dtsi
index de3de32f8c39..731ba12ccc95 100644
--- a/arch/riscv/boot/dts/andes/qilai.dtsi
+++ b/arch/riscv/boot/dts/andes/qilai.dtsi
@@ -123,6 +123,7 @@ cpu3_intc: interrupt-controller {
 	soc {
 		compatible = "simple-bus";
 		ranges;
+		dma-ranges;
 		interrupt-parent = <&plic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -182,5 +183,113 @@ uart0: serial@30300000 {
 			reg-io-width = <4>;
 			no-loopback-test;
 		};
+
+		bus@80000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+			ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x20000000>,
+				 <0x00 0x04000000 0x00 0x04000000 0x00 0x00001000>,
+				 <0x00 0x00000000 0x20 0x00000000 0x20 0x00000000>;
+
+			pcie@80000000 {
+				compatible = "andestech,qilai-pcie";
+				device_type = "pci";
+				reg = <0x00 0x80000000 0x00 0x20000000>, /* DBI registers */
+				      <0x00 0x04000000 0x00 0x00001000>, /* APB registers */
+				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
+				reg-names = "dbi", "apb", "config";
+				dma-coherent;
+
+				linux,pci-domain = <0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x00 0xf0000000>,
+					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x02 0x00000000>;
+
+				#interrupt-cells = <1>;
+				interrupts = <0xf 0x4>;
+				interrupt-names = "msi";
+				interrupt-parent = <&plic>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 1 &plic 0xf 0x4>,
+						<0 0 0 2 &plic 0xf 0x4>,
+						<0 0 0 3 &plic 0xf 0x4>,
+						<0 0 0 4 &plic 0xf 0x4>;
+			};
+		};
+
+		bus@a0000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+			ranges = <0x00 0xa0000000 0x00 0xa0000000 0x00 0x20000000>,
+				 <0x00 0x04001000 0x00 0x04001000 0x00 0x00001000>,
+				 <0x00 0x00000000 0x10 0x00000000 0x08 0x00000000>;
+
+			pcie@a0000000 {
+				compatible = "andestech,qilai-pcie";
+				device_type = "pci";
+				reg = <0x00 0xa0000000 0x00 0x20000000>, /* DBI registers */
+				      <0x00 0x04001000 0x00 0x00001000>, /* APB registers */
+				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
+				reg-names = "dbi", "apb", "config";
+				dma-coherent;
+
+				linux,pci-domain = <1>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x00 0xf0000000>,
+					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x02 0x00000000>;
+
+				#interrupt-cells = <1>;
+				interrupts = <0xe 0x4>;
+				interrupt-names = "msi";
+				interrupt-parent = <&plic>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 1 &plic 0xe 0x4>,
+						<0 0 0 2 &plic 0xe 0x4>,
+						<0 0 0 3 &plic 0xe 0x4>,
+						<0 0 0 4 &plic 0xe 0x4>;
+			};
+		};
+
+		bus@c0000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+			ranges = <0x00 0xc0000000 0x00 0xc0000000 0x00 0x20000000>,
+				 <0x00 0x04002000 0x00 0x04002000 0x00 0x00001000>,
+				 <0x00 0x00000000 0x18 0x00000000 0x08 0x00000000>;
+
+			pcie@c0000000 {
+				compatible = "andestech,qilai-pcie";
+				device_type = "pci";
+				reg = <0x00 0xc0000000 0x00 0x20000000>, /* DBI registers */
+				      <0x00 0x04002000 0x00 0x00001000>, /* APB registers */
+				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
+				reg-names = "dbi", "apb", "config";
+				dma-coherent;
+
+				linux,pci-domain = <2>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x00 0xf0000000>,
+					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x02 0x00000000>;
+
+				#interrupt-cells = <1>;
+				interrupts = <0xd 0x4>;
+				interrupt-names = "msi";
+				interrupt-parent = <&plic>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 1 &plic 0xd 0x4>,
+						<0 0 0 2 &plic 0xd 0x4>,
+						<0 0 0 3 &plic 0xd 0x4>,
+						<0 0 0 4 &plic 0xd 0x4>;
+			};
+		};
 	};
 };
-- 
2.34.1

