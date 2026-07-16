Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA00437861;
	Thu, 16 Jul 2026 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221670; cv=none; b=H6aoeqiHKeB2UHEl1PP1DyFk1fSgaw5WI9hoTQ1pdK2cMPUh0/YjmIwMQ2z+Q8XNTP1Zdfl3Y0zNkLwd1pMma5E1rB+rvl1Zo4x8EfJnwxqSIAZhBjG+TzJJx75WsGOIMLTe4f9GUGtm5lEzdio7/lEnKyevSsoiOkHYAUDerao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221670; c=relaxed/simple;
	bh=Etc/Q5FFDhPKeo8T9hlMEKC7INZS82xraLHpCSRQl1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwDdipeeE92a7qJkLZMVliPn8QgMR4MakaCHR4kzlkDmr/ImXtXsZCqQKQ8q/Gj9AdaNs6hbBOH9WEKc8CVxJaoHXKoDRYvZTt4j5Y+/TJxk7RdKYldrwEt3N1MfRLBKSVmZyl+Kx4J7DlGPyKB3tY02P/CHdlQ0aLn5AwkJFJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGAlz76G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGAlz76G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510C41F000E9;
	Thu, 16 Jul 2026 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221664;
	bh=2sJItfhz2fY82OyDjUnJkwOlwZxL21vIdwWZEFJp/TY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HGAlz76G9wVfm/J1RumyFAQmos/EuXn/yNBuP18hJz7W+0gmYQYYWeJQjFMrUSYyy
	 w8Idn49zE/WKXyLpyOIMTCOCrDDoobdTFUD2vrgij1ridYdiN2NXsj28iRC2bUiRi9
	 IiwS/3NnDiO/EBNf1Us3Ff/Xt5ogcZkGMWscPdC1vsC20P9V98HxtJ+Jw/7pp+ei2X
	 E4oe4kDTOdE5u52g4PN1xNut+GRi/kt5CWFmtMTJfU+G/nTj5BpKYXkyTjQo4/xMv0
	 0VyrL3JtOSBwz4iTKUhkK2PqO+7EQS6hswn6J3EDPH7se6axV2SEI6kMcgSdsbzK4r
	 2B2AB04x/1vBw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Thu, 16 Jul 2026 19:07:16 +0200
Subject: [PATCH v8 5/6] arm64: tegra: Reorder reg and reg-names to match
 bindings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-tegra264-pcie-v8-5-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
In-Reply-To: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4866; i=treding@nvidia.com;
 h=from:subject:message-id; bh=+dOAy4Ib0wPH1a0XTDI32lASF/gsknRwplOa2YizqG4=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqWQ/QD0ePWIjHsxbtyOKQd0Lyrv0x6sh90BmYH
 1B4pUlJ2y+JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCalkP0AAKCRDdI6zXfz6z
 oTm3EACpFzinhKccv+XphFBZS+INHAgOVog0+4mEvSP9PtWdTb+bcD+Q5x9iosFb0MrsJDPPXzn
 RqJAsx+lVgcGJuFfmZVg9R5cVSrkTuw5aiGkhTAEuK3+1MkG0Pgl8n/MyCiK7sRxq4Z2+fHBEcT
 kKzlt67Qddqc6rssDiJbDHFoLY66tYh5dh0UUdstM0u8mf71z/+Y9ZNLI77ek12fzvEfHUGoeGl
 tqChuU2dSDWiZeVXQb1QrAej0xt/IT0dXV0brdWcxCo5gbd/ALsBVM76uOjHWNQ/T8JfRJssDwI
 XpKNIYElD5BuxLm/uShywQJdrswsm1V02LpoXj1Q0Ch9zkFywKGiuAJNuMelnQbUU9p4XzL3Lqs
 kFEcAQkSDa84CKIhj+np5OLDvrRKL5RmNbbcqJiFn16N2DvjJ+UYh2d7AoqoIXaJCo3U3rpS3os
 kGlcQfoFrk2DEBTdd/JZp1ind69BSksZPjosFoO/Ozn9Brklr0LULbhkLG/ivkCJaDzt6qyUMup
 vuxtKW3LwGbTZH7+niskKLeyEFWTrwls4gWuE15e/Cikbg0QEgRvZnDXxLxgwqoy9+dNqc3sKwy
 u96BtBiPSxzHOIjKEOxRcoatIWNLmKNrFcBTTVvD8YT5AYmc41seQKFV4tBdmoEYcoFG8TYnP9F
 enupcIJnPxX6Lkg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

The ECAM region cannot be the first entry in the "reg" property, because
in that case the unit-address wouldn't match the first entry. The order
of the nodes can also not be changed to match the ECAM entry because the
ECAM region is global and outside of any of the control busses.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v8:
- add Acked-by from Manivannan

Changes in v5:
- rebase onto v7.1-rc1

Changes in v4:
- revert ECAM "reg" entry order

Changes in v2:
- order ECAM "reg" entry before others
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 48 ++++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 133d1156ee81..5008bf05d268 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3513,11 +3513,11 @@ cmdqv4: cmdqv@b200000 {
 
 		pci@c000000 {
 			compatible = "nvidia,tegra264-pcie";
-			reg = <0xd0 0xb0000000 0x0 0x10000000>,
-			      <0x00 0x0c000000 0x0 0x00004000>,
+			reg = <0x00 0x0c000000 0x0 0x00004000>,
 			      <0x00 0x0c004000 0x0 0x00001000>,
-			      <0x00 0x0c005000 0x0 0x00001000>;
-			reg-names = "ecam", "xal", "xtl", "xtl-pri";
+			      <0x00 0x0c005000 0x0 0x00001000>,
+			      <0xd0 0xb0000000 0x0 0x10000000>;
+			reg-names = "xal", "xtl", "xtl-pri", "ecam";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -3893,12 +3893,12 @@ gpio_uphy: gpio@8300000 {
 
 		pci@8400000 {
 			compatible = "nvidia,tegra264-pcie";
-			reg = <0xa8 0xb0000000 0x0 0x10000000>,
-			      <0x00 0x08400000 0x0 0x00004000>,
+			reg = <0x00 0x08400000 0x0 0x00004000>,
 			      <0x00 0x08404000 0x0 0x00001000>,
 			      <0x00 0x08405000 0x0 0x00001000>,
-			      <0x00 0x08410000 0x0 0x00010000>;
-			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
+			      <0x00 0x08410000 0x0 0x00010000>,
+			      <0xa8 0xb0000000 0x0 0x10000000>;
+			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -3925,12 +3925,12 @@ pci@8400000 {
 
 		pci@8420000 {
 			compatible = "nvidia,tegra264-pcie";
-			reg = <0xb0 0xb0000000 0x0 0x10000000>,
-			      <0x00 0x08420000 0x0 0x00004000>,
+			reg = <0x00 0x08420000 0x0 0x00004000>,
 			      <0x00 0x08424000 0x0 0x00001000>,
 			      <0x00 0x08425000 0x0 0x00001000>,
-			      <0x00 0x08430000 0x0 0x00010000>;
-			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
+			      <0x00 0x08430000 0x0 0x00010000>,
+			      <0xb0 0xb0000000 0x0 0x10000000>;
+			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -3957,12 +3957,12 @@ pci@8420000 {
 
 		pci@8440000 {
 			compatible = "nvidia,tegra264-pcie";
-			reg = <0xb8 0xb0000000 0x0 0x10000000>,
-			      <0x00 0x08440000 0x0 0x00004000>,
+			reg = <0x00 0x08440000 0x0 0x00004000>,
 			      <0x00 0x08444000 0x0 0x00001000>,
 			      <0x00 0x08445000 0x0 0x00001000>,
-			      <0x00 0x08450000 0x0 0x00010000>;
-			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
+			      <0x00 0x08450000 0x0 0x00010000>,
+			      <0xb8 0xb0000000 0x0 0x10000000>;
+			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -3989,12 +3989,12 @@ pci@8440000 {
 
 		pci@8460000 {
 			compatible = "nvidia,tegra264-pcie";
-			reg = <0xc0 0xb0000000 0x0 0x10000000>,
-			      <0x00 0x08460000 0x0 0x00004000>,
+			reg = <0x00 0x08460000 0x0 0x00004000>,
 			      <0x00 0x08464000 0x0 0x00001000>,
 			      <0x00 0x08465000 0x0 0x00001000>,
-			      <0x00 0x08470000 0x0 0x00010000>;
-			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
+			      <0x00 0x08470000 0x0 0x00010000>,
+			      <0xc0 0xb0000000 0x0 0x10000000>;
+			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -4021,12 +4021,12 @@ pci@8460000 {
 
 		pci@8480000 {
 			compatible = "nvidia,tegra264-pcie";
-			reg = <0xc8 0xb0000000 0x0 0x10000000>,
-			      <0x00 0x08480000 0x0 0x00004000>,
+			reg = <0x00 0x08480000 0x0 0x00004000>,
 			      <0x00 0x08484000 0x0 0x00001000>,
 			      <0x00 0x08485000 0x0 0x00001000>,
-			      <0x00 0x08490000 0x0 0x00010000>;
-			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
+			      <0x00 0x08490000 0x0 0x00010000>,
+			      <0xc8 0xb0000000 0x0 0x10000000>;
+			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";

-- 
2.54.0

