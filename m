Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DC3E073D;
	Tue,  2 Jun 2026 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400045; cv=none; b=coYC/QBKKs9EdLk38KINBMPwDX7QnoUZ+9jY3A4GBbSKrQnhgrIQK3q7E/ejzTHR+Rwpy/H9KLf9tKRKJRg8u6R1bzl2a5NE1YIsVajrvxF4tBsDVvSJgkDI/8IzTZxBWuFcxnvCJ8aQqtSUKCFDEDwATkV1RN65uPc5giUqSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400045; c=relaxed/simple;
	bh=trggnQpagTpo0390QW2tgPU0KSvTD5Yf1/Ga/nCYYK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RSfaoaCJzUTw6kq2P2j2XYLzVV3DbZBzTy5+F0LEg1pxlZz0ArJAIfAmbIZ7DromLiJISf9PYUtwp4INQWyIjH7bgrrJ+lXuDqaMkun0IH9ZgtKBiL1G2GzGCJrwM7hAScnVW3NTPN7mxnrkHNR6uWCgCz4ISlZm9YGYKF6JfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXUkBGFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXUkBGFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998471F0089C;
	Tue,  2 Jun 2026 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780400040;
	bh=QXP0Lk4WLSqnO/9+5RQSK4FKezw1pmUzuzZnns5PaSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kXUkBGFgEYCGm65KPGOwDPkT+ANqUDTB2zw5BuKwVRr0ygfYc+IxoHiIzKslPp1qa
	 z/5+VRZOh5WkBVdOnvjmEWqPurtuhqi2TS/BrtHiVPHQspFwlJ873UxEESmOv2vSMt
	 YJH0CCLqtI/EJvDwo+OTdNhU/CYugOVkWL+UAZ/VtXz7OOtUaUVYNP7Z84ugFzBJQs
	 5U4umGtWo8kNgGmBAf1ObNRO5Blk2mM8lBsGT+xr6JlrYDEPvwqSaeJq5+fuFj93sj
	 QapMBTARlf6ejTy+17H1g4Yo2p4F3+yYtoJYqAEEHaNvD2bm3BUVDi0Zb+0q9M+wFu
	 d+nhy/bwt4gyQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Tue, 02 Jun 2026 13:33:26 +0200
Subject: [PATCH v6 4/4] arm64: tegra: Reorder reg and reg-names to match
 bindings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tegra264-pcie-v6-4-edbcfa7a78fe@nvidia.com>
References: <20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com>
In-Reply-To: <20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com>
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
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4765; i=treding@nvidia.com;
 h=from:subject:message-id; bh=ltYlWZgcjQpPPeqy9wq2FjpCCCUz1OFaSP+BBIfGYIY=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqHr+awhbiDapJGroKc+2dEx6tR0EbTMkD529dn
 jNuPptxT0eJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCah6/mgAKCRDdI6zXfz6z
 oQEtD/wKjnM5GtMKPiiJMJDbSU6UwWzY/nLlloOWknhhyZ3fZaX0B320BMQRqD/67BrTjoVpfoo
 hK41DXfQIHbDCDgseP6U5AUdZPOQaxqd9mGW6M2kJ/0xz57MT492HCjq329sHumCkcU4BEYvczv
 sfADULCpQjO4CsNkuc3kDOB8bfvNjfNFOWZSXQr1YB2a18k82vFKJw4wgZDj6AMsqJZAfzmuOAx
 r3ekRibC6/zR/wEAayi2YckTMSbZsx3vjv3fpibYuohp0bEIWCV2O47SisIeYrhS+ePdUM9u/G0
 clfQLcKiU1skYyRE6ppeNVrQqydol3tD2oO0VV7eNT27ko5orHzCk5h8gblWCGelg9r9zOa+rp8
 UWqBSUua4N3zo9vcwxmHSIybqSr1YIzzJ2BQJQYVu+xokd+lBRKRWN3Z9mmPFNDbadZh4CXIXna
 3WVqdb6hCzKCU1QYk8RIV0hWo2fSXNqvyDykVwn/Gk6PiMvW4R7cl+Wb/LUGkw2Dyrdect7b2YQ
 lXO0gMgR3fpUk07GTdxk79zJ1q50Md2cwVDOtUBc0UueSaM6tfHms7n41eUcU1VZvTdDmdBNMyv
 4l8yBKp8OIyI/bnHHLEYErcYG0YiPVa8XoiDdrTYWIKBVJRLOrle9ofczbdno7lwo5rbAALNnwx
 ITyjwSwTYqBkODQ==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

The ECAM region cannot be the first entry in the "reg" property, because
in that case the unit-address wouldn't match the first entry. The order
of the nodes can also not be changed to match the ECAM entry because the
ECAM region is global and outside of any of the control busses.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
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
index 8f4350c7793b..4c701abd25a8 100644
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
2.52.0

