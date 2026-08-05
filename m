Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592E448D06;
	Wed,  5 Aug 2026 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931071; cv=none; b=VpdEVAaHJW/sv8H2ORpLXe+fzYASTnq7pn+DkxAAFOROVCPzS43KI2bUY1BZ4arHE7bvdVZJnYAT0K00mOoxquNis9E+T0Fa+Br7ZJkSAoMWq0PuVenktIuu1gDspoDXlGYiihYPil7eD93Xg3E0rWWY1s9KuMCiK5JEBAAXkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931071; c=relaxed/simple;
	bh=DVutwC6C/ncMKycy7D2Fow5joLx3P4jt1fjf+HcpZb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxdjwwY3QNaDIY/D9StmGLxv3jWJzQkhDOKzqeLic2bMMQpv+X81iBH8yMAXauiErWVbxvANVzWd+T8TCbpmq26oZN/agdIqdQO8Pfn3sWfodffDHS47Qu7GXXsvQsEOdsOlb575q2kfpgWSwO621pEQejqjh+uzVQto+um0K9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNmJptSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNmJptSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102011F00A3E;
	Wed,  5 Aug 2026 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931070;
	bh=9HbBCvGF79k7uC5t+4n6mW9FgmyvzM4mLI4yAT7dDqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MNmJptSI4hzfp9YOcX1bqkhSl+Voj+kWiTlsU+vqEdpE0Ex5+FyjW5/QcJTco9OIq
	 33esuwCA5IJe5LMMNoK6YOJ3m6iohj1UJxtY5SDVGdXedxQvlw2t4f9aQUaIYRleMM
	 GSnPT1M+SV+dJ6xLgOKvPVRkYNl9HUSIhUQcUJD64elf7D3PR6gxCIaWyUYdpDuQB6
	 iY1GB9S2GKFeBM0JJIAGkQMRtj/KIQkaorycjhrtKG/IB74wsaa71HqoezQEH7r53o
	 9esxCg13RJGIXHNiqKAn6hg8sX24SxAqhLwNhEKBRX/53nqrjZNFOlmBxFEzcQy7y2
	 vLP2de6iEP4rA==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 05 Aug 2026 13:57:23 +0200
Subject: [PATCH v9 4/5] arm64: tegra: Reorder reg and reg-names to match
 bindings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tegra264-pcie-v9-4-fa2ed7350ae1@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4866; i=treding@nvidia.com;
 h=from:subject:message-id; bh=OrgGTXlOuoQVPim35wrIFPmVCqFnYG2TBo2ZemOVWPs=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqcyUx5L5WWwyhv+hKsn8HRF3TbkAcELnjKXNr8
 WUnRWw66IOJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanMlMQAKCRDdI6zXfz6z
 ocdVD/42+qR+EZlcE/i7iygqCuaIcL8IkFPNsi5otcQ3w7bROiPpIRoXZSNBysxVr1NnsbVbrhA
 fkKpqejaOTXFysszCPZCzuPCUERyqVUbo12JTUkMmQDSiCAIDlZGH0GeruR2INL5L6/JC5f/00b
 LRCVuTVP8UTW6gPE7Tb3aEOpjAuZesg7m2ouny6AoPiPUkLO4WL2VRB36vwyAw1suCMniwJmi7w
 38Ket3U+2lxSjFKCPfcCslT9KpaEV3+Dxws/69xoJMBE8au/moD9+SIeqzN1UBbCZN+ZCvtTaAx
 Qtsn6xOrvUpTaMSMdeWd049ysVgAJZEHX6gohRxCKxxp9TB3fOyi98gA2H3Go4nn3rNtgq+1k/z
 dWVHo6fpPzcpvGtMWI4AL4NwVxzEnL5PD/p8oPgbvQ4gvbRLAMMMON+ySBxYkw9BB8XvT2Q7Lg+
 DspkHoHo2WxMmmdmKsyimQu3zzZvtmGQ1Jf6W7Ky7Oa4dhzoR/Pe6WttovYPEP4NSjvJ0zK0Ozm
 mnUl5PqV1z9nPmloZpXuVVp1DoQeJsiIU2uvFVPxmE2QnNemvZaiCkVs9Ck5wHC9gzgPo6k28VN
 2bJrcys76okexfQl/o+PU/rjAqFMU47Y0IVu3RFJoMr1Spaad0QWEAEA39CGFz6Q2+cxtxMIMRJ
 HJYY2Y6BKibuHxg==
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
index a1a86022d638..cf9760c681b1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3538,11 +3538,11 @@ cmdqv4: cmdqv@b200000 {
 
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
@@ -3991,12 +3991,12 @@ gpio_uphy: gpio@8300000 {
 
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
@@ -4023,12 +4023,12 @@ pci@8400000 {
 
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
@@ -4055,12 +4055,12 @@ pci@8420000 {
 
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
@@ -4087,12 +4087,12 @@ pci@8440000 {
 
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
@@ -4119,12 +4119,12 @@ pci@8460000 {
 
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

