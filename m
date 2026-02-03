Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8745262BD
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078127; cv=none; b=teZODDGIa3/vc/H7l55OZhqkRwAg+V4M6U9Z4CaDqaTdsbrd28Fm8PzVK3eqNWhlviktAxmzlKIwwCnxuPDuD6qNjJ4+VQphbcoYaY43YFvoLT2R2LE6NACj5cyhbhkNsNvm+lekhnjvv4KghX+AkeGYb/G24oLzWPUUq2UCsxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078127; c=relaxed/simple;
	bh=HzuTMG6951tSYJCEaxJHqJek8qQ28BkOhuT5tQd7CoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnSWHY9mxr8J3LHaQS3cf0yc0fRL5PoGm31d5EidzlEE2f+XJAXZOAhzub24LmXICUMYdIgRz0ZTTrh5KH/W6zR245+o576JZu/kL8/KsJN4tHsDnJ9T2DxjHeBxvYLLUzixgXLoYhm3HzcQDfPfVZVuncozgva5yt/wxhi1Vi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BKB6Y3pI; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BKB6Y3pI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770078123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEDks71jPWIaYxTqElZUBzlKtd2fk7erRCnRdd5d4ug=;
	b=BKB6Y3pIE2fBGnuvhOOin7POuW77yEcRZpaJCYRLs0TbIu8wNx6XztyKKtkdrc7HGFjgqw
	FQiYsBC8g/AhJRteLaH5mEl7Kto4SI97SbUbkdjAmq/c9Y5vjww2OojVXZuelmsk0pEGsJ
	d7fOcDAsv8dE2AB1yRMZ10Vdb/9iyR8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 8/8] arm64: zynqmp: Add PCIe resets
Date: Mon,  2 Feb 2026 19:21:28 -0500
Message-Id: <20260203002128.935842-9-sean.anderson@linux.dev>
In-Reply-To: <20260203002128.935842-1-sean.anderson@linux.dev>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add PCIe reset bindings for the ZynqMP.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 938b014ca923..178b4c3a7ba4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -969,6 +969,10 @@ pcie: pcie@fd0e0000 {
 					<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
 			/* iommus = <&smmu 0x4d0>; */
 			power-domains = <&zynqmp_firmware PD_PCIE>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_PCIE_CFG>,
+				 <&zynqmp_reset ZYNQMP_RESET_PCIE_BRIDGE>,
+				 <&zynqmp_reset ZYNQMP_RESET_PCIE_CTRL>;
+			reset-names = "cfg", "bridge", "ctrl";
 			pcie_intc: legacy-interrupt-controller {
 				interrupt-controller;
 				#address-cells = <0>;
-- 
2.35.1.1320.gc452695387.dirty

