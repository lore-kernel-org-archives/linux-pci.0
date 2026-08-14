Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252C47CA91;
	Fri, 14 Aug 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721958; cv=none; b=TWo/cEGbt8HPVPjxk3sG9X6aNfvJqfXSv6QDKJxwhPLipTLNJ3I1rdPnj5I+zg7FsJoK2tnw99rzAZt4vC0KpUkM2GAUeiohZC9PWQveK0TPBCORym97jtG9ZlM4IfD+8I5qftDhVoGSYr9KenynTg68f5VYBGmllcV81hD8g4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721958; c=relaxed/simple;
	bh=vHDQYHWcZpXzc2MpcUKqVRSgovG9GqUSE1dYXXsfkd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GD8rGtINN44iKJtrKVjSIpjRNBDmpydS6RJdUIZcP0pkwEoWuwjidKpn/kufWu+4q7yN/d3LtQgLLYAzftxX3lRFBqFl5xFyOnqOsw3d/N12oSalc+Ka9Fvj5TNNd18W/JgdJClhxOJvMYJPoy9cn73GQl6PJW6vxLUV+D6AmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0St+jbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0St+jbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEE21F00A3D;
	Fri, 14 Aug 2026 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721956;
	bh=9VGq6rdCNxgCfxXDEz0J90bfJLSsfsFdCtf54uc9TfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D0St+jbfHvysXJBZXp713sWK0S6DSlYeqLS/tbl4AsHFxNNMsgodGaZDMQYV1kggi
	 hgbAUmTQIknKBJjEZNT2JSjejbf+eObhkRtA3rKf0B4xFhXi8bkTumJiiVHyeQoDPo
	 VlQI+JApk0rO59+BEbnsr5hoN6bia2WZdURExe6YZyfYf1fb91biMfB/r6ezW+jhpX
	 bOmlLPtXsPPPimC8Ex8cndKmkD0yqGFYK1/7ADnNj9xPzsmB9UJt5FJDwWBC51BF9Y
	 SHyRv/9MWkExnhJR2qWuTC/PHsR68cunyZgBKUCQQXGjPiEjzNiTgVY4XVkM0hxc7X
	 PEpGdXRP6WGxQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:38:58 +0200
Subject: [PATCH v10 4/5] arm64: tegra: Reorder reg and reg-names to match
 bindings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra264-pcie-v10-4-05d08c592b05@nvidia.com>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
In-Reply-To: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
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
 h=from:subject:message-id; bh=7CI81HCMNfvKezvmtxPTjIu4kaNogcb6dnP3NUgeanQ=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzaWzPES9W6Y+7NkdqVB54sIeERlXj5u8eChk
 5LE7wN8kbyJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan82lgAKCRDdI6zXfz6z
 odU3EAC8qdbSeUoS1pWRDbpK6XUMeqoyajUT+8f9uG5Cc9bL9u5zodozuAVUFdBDmc0ZNmeGIxj
 gYnzBGRbNKQMylEFi2byjgzno4MO8PDhXAn1Yw+ncdf9U3rXgm0B1dN9loAa3r+uCB3qORc6kH7
 pktSIu4kHtkQSbBcw75aLLjNj3+5lSnDYY0zY7+9bD+Z1yujoR+oWP6U2TDe0Elu4yPTA5e1oel
 Bu1sc8PuueVg1dyxb6/NoT1IJE2EAmYz8oqwXds0c5F+xfzmCXdA79ULFsnSem0jtk2yfMUgiWo
 5HdM85wCl3w5GoxYkwyihmIfmDSeqJ6E5/WQVfTSsvyAkpFZuuqIRFXkM9ARM9eS4fcpWt4DEGN
 1DR7KZUKsvifsNWn3j9NKMoutHATsBaufu4ZM3gDqRWRoqhReVWrW5O83qv+bVsfkRGkFQyTHOf
 9K/VWooqpSs8TwwQHdShOnaHGINdTn3POgYCUad6rF0RlxaPoJ6LYyumLLLoEUfjPR6iIbi8s59
 jzU4s3LmSfXcWnr4n2FZ65EuVAQXANL2/wtp/P3MsCqZSaTS44JkNhG62o0ZISHBgpClMQeMBw+
 NDsORpX1oQMM1bzvgaltnuvOMPxgyvjd+Md8/aU7WaBACx/YB4ba46Z8UIt6CiVSZRkjm7YcNrT
 j2E/PEFxc4UP7Lw==
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
2.55.0

