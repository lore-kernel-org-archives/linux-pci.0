Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.32.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241628;
	b=UVVpIrwsoqhO0CoF6YYRpxqS+pSScovRRvwV3ZJVn7lt3vQ5OIghtCpp/xZNzAApaXYD
	 fSAxPAj2f719YR3Ss+DP4iECsveKd7o2Zyuu0MMZSQfeXj02dMsaKmeeADSF1jODhA+gf
	 Bjg34aqntYhRfbt3jWi8H21bskNp6A1n/dE1c9IsDOsoII1VrFwFrJ2bwGuNR5q0GdFZl
	 hqsCaYY3utvROd39yvKv/94RmhpK/1ZRGQjzaGgZ1FdDJRakLGMnERlwjCIKPWLlYxqND
	 MKVCt7JD7GxCVYhH+ibAlwX7K/PcEc4GaQjF8nO4jf4hOJ23adE2lOMNt4ax+F9RMVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241628;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=MCjNgmAq76o2XeQztjjTI8OadexVraYkSegELcY3anA=;
	b=3ujSwTItqMcEUSDZ1QJMFUjfEImt745kEZ4biQDPPjxwhcU95OURlxAWRzyoHjm819BB
	 nW4MwtSDd6VMX7p09D7ACG3DkOi49rpqFJci5vjHlN9KmLN9sUzhZDIwzPDOJEBDvddQb
	 9DIaTS8JWZpBz4PA4Y/53F7OK5+5Pgu/1+49ZCQHCsjWvcj4Pt4gp7F1S8wC2pAdFg66p
	 scDGin5+4aq63II5qsB5ObA4pxMderkNjaXsQP6l9xyurOLu+OXL0IFllEqWO5qx1h4Fg
	 mpULb+0pIA859AMWbuZx6YG+JUa2cU658EVX7etGk8vpDZIL4Cy3mPJAl0cS5e34BZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=X4fYAN0M;
	arc=none smtp.remote-ip=220.197.32.115
Received: from mail-m32115.qiye.163.com (mail-m32115.qiye.163.com [220.197.32.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4F606A31D
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 02:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF4F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=X4fYAN0M
Received: from localhost.localdomain (unknown [61.154.14.87])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52bb25142;
	Thu, 29 Oct 2026 10:40:18 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: rk3588-evb1: describe the PCIe3x4 slot supply
Date: Thu, 29 Oct 2026 10:40:06 +0800
Message-Id: <20261029024006.3483210-3-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261029024006.3483210-1-shawn.lin@rock-chips.com>
References: <20261029024006.3483210-1-shawn.lin@rock-chips.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa18587985003a4kunmf51ad3a01124de
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHR1CVhgeGh9OTE4ZTkNOSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ0xZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=X4fYAN0MfGVi0/FzQghxedTVqYK+a/wV78WMSFo0G+JjmdtGvbAuTCyNyBck1GAB+YyOGDOU2Tf9tRPW+7UKce5pBzW1wLvqVST3CdPy7RhiN2fn8i4MaHzgaIL0ov6U8nc8OCpdUz4EuIdOmEVlWUp7QSIXPFS1myq1QWVl90g=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=MCjNgmAq76o2XeQztjjTI8OadexVraYkSegELcY3anA=;
	h=date:mime-version:subject:message-id:from;

Move the vpcie3v3 supply of the PCIe3x4 controller into a child node
describing the slot, so that the PCI pwrctrl framework manages it.

The child node is modelled as a PCI bridge, which is what dtc expects
for a node below a PCI host bridge, and carries the regulator that
powers the devices in the slot.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index 8969b56f3063..80eb36e783e0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -569,8 +569,20 @@ &pcie3x4 {
 	pinctrl-0 = <&pcie3_reset>, <&pcie30x4m1_clkreqn>;
 	supports-clkreq;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
+
+	pcie@0 {
+		device_type = "pci";
+		compatible = "pciclass,0604";
+		reg = <0x000000 0x0 0x0 0x0 0x0>;
+		bus-range = <0x00 0x0f>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		vpcie3v3-supply = <&vcc3v3_pcie30>;
+	};
 };
 
 &pd_gpu {
-- 
2.25.1

