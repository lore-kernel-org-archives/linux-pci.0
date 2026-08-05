Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992F44AB61;
	Wed,  5 Aug 2026 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931079; cv=none; b=pXTg+VJqKjijFf92MFaSTVa3CeotU5zT/CQaegXENI58r7kMrOVQm67p5QDTK2alaiUToj9/EMjbeIKkpkiAvVOPF6cVcZDxq1Y5N+nh0RcR13Z8M03dZMOho1C62lWtxCqwQsSDvdz2rj7HSfle6QWd/WppE360FYmtDwG8cQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931079; c=relaxed/simple;
	bh=UHU4IviKKpWFYokKdMsjAmQiv5mGCO+4+nEUbGr3LWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dyA7hp7s7K/yckfsxQ48O5idBdokA14BvDWaboKh0Zx5EmToOQrYEAbkJSTM4G858yXuJlL0Sl+kYlqeS0YvM/2QyXlLB1jHsZfl9nhZKC+LNDx79MfrZI1z7dXrHX3zbVoQxIsqTe/GgXugiCuIMiTaDo8POEulFsjychmcpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCNoC0aB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCNoC0aB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17631F00A3A;
	Wed,  5 Aug 2026 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931073;
	bh=LzKqxd0i6BEVMJwOWsnwGsBW9qgV25TXeNg/x8DnPDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NCNoC0aBwKQQ4vN1jcy8CSJYbeF5emUvI7D7KMQODwsxdznFfW2sNRbs56EC08hRA
	 0FrqVT/7JDrgUSqborixN+8H1wy3+LcOwziJJ8pWngUqyYsZkzD9qKJH6vWskesSgw
	 0VCT3xGB56JW8dLjCgGEjiV3x6iqm7U/zlLUQ/WE0LB/TVULuotrypFLTPK1HZO1BG
	 wNHhhJRb6bYTDiNpa1OP30WYyrDh3ee3zHz/BxYYfheJ4+d1UDrUewDWT7+xAbLTjv
	 UsITCXheGiBpecEsbr9z9ttbsv+Efp9KfePQVvTlsADvm+a4LkLPehilXx1syOM3gH
	 1OHHRimHBnGMw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 05 Aug 2026 13:57:24 +0200
Subject: [PATCH v9 5/5] arm64: tegra: Add PCIe root ports on Tegra264
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tegra264-pcie-v9-5-fa2ed7350ae1@nvidia.com>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
In-Reply-To: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4514; i=treding@nvidia.com;
 h=from:subject:message-id; bh=CsDyWrPyNdz/9ucBVAUZst7qSxttLozNfWGdkMV1Nvk=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqcyUx/fOa7PuCvc4YnEtGLgFX8D2EDNtACsG62
 7YwhBRcZS+JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanMlMQAKCRDdI6zXfz6z
 oci7D/97rMzKXZpPGsIfO9xGVdFYBFFpZTHF4fJ2l6bgLRc0RBnj5YtxHpBQIsVjfL3FXAf90YA
 nrMDe1FS/Zee1qi9jA4OCvZ9/WEhA0OA52abu2Acs0FKGauSPn4PI3vKOkhkaOr9DjqTjTSdOFE
 XJLK2w4L6mitimmM/dIobY6EUelz7ZPWF0/WD1953mDOG9NMdkT8fo4pudFu5hZKgaRrfRjcssw
 QIBttqZhPBsagLmcvPYJeU9xGN9YvYJvFwLL0rLNtQ5SwffcGtnXp8GUSLeKo6gcDys5ul9hPR1
 00lhKsgnl/+B/7AUs6ciQ3LpiQ9oMmOViddKZNCLaedfYYUtr2m4s8MBOd9dww7yZVs05mcmkIN
 VMu9oBmB5R0nuR1Wbl3iQF+pXIVdHkXk90m6UJY1IU4lW/YbuQcdhkSGO23PzKylimG3DoSqMRR
 8MZ2iST0uM22HjuloglDSin3HBM/4rbKv+PNk7NON6VJwQDNP1XSNMZhefGiyA+/3U/mgJao2jv
 c+EEm9gJITHVZKrFps/XPRnSdW9WlPp4b3noAMdWojqn8Zl+6XknTlVTNaFClZMNdyrugnfynfM
 RtkgtjSBRiUKiyHNcvIAlp2lPOyLTeVXjze7Y23HINAMwsmzuWZrYfUhathqD3cHbh8d0Lyo64X
 1ZVeuabydndalzw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

The bindings have been updated to use the PCIe root port bindings, so
the nodes for the root ports must be added.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 66 +++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index cf9760c681b1..31bd29df8e46 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3562,10 +3562,19 @@ pci@c000000 {
 			ranges = <0x81000000 0x00 0x84000000 0xd0 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x20000000 0x00 0x20000000 0x00 0x08000000>, /* non-prefetchable memory (128 MiB) */
 				 <0xc3000000 0xd0 0xc0000000 0xd0 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x0 0xff>;
 
 			nvidia,bpmp = <&bpmp 0>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pinmux_main: pinmux@c281000 {
@@ -4015,10 +4024,19 @@ pci@8400000 {
 			ranges = <0x81000000 0x00 0x84000000 0xa8 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x28000000 0x00 0x28000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xa8 0xc0000000 0xa8 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 1>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pci@8420000 {
@@ -4047,10 +4065,19 @@ pci@8420000 {
 			ranges = <0x81000000 0x00 0x84000000 0xb0 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x30000000 0x00 0x30000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xb0 0xc0000000 0xb0 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 2>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pci@8440000 {
@@ -4079,10 +4106,19 @@ pci@8440000 {
 			ranges = <0x81000000 0x00 0x84000000 0xb8 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x38000000 0x00 0x38000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xb8 0xc0000000 0xb8 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 3>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pci@8460000 {
@@ -4111,10 +4147,19 @@ pci@8460000 {
 			ranges = <0x81000000 0x00 0x84000000 0xc0 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x40000000 0x00 0x40000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xc0 0xc0000000 0xc0 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 4>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pci@8480000 {
@@ -4143,10 +4188,19 @@ pci@8480000 {
 			ranges = <0x81000000 0x00 0x84000000 0xc8 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x48000000 0x00 0x48000000 0x00 0x08000000>, /* non-prefetchable memory */
 				 <0xc3000000 0xc8 0xc0000000 0xc8 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
-			bus-range = <0x00 0xff>;
 
 			nvidia,bpmp = <&bpmp 5>;
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 	};
 

-- 
2.54.0

