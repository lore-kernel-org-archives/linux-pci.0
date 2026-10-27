Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.210.164.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087750;
	b=4rFWStBc5p6ylVjoKiNkXGj10DDZHGEA6FS0g9TO0tVPTxT+aVuf5Hr9tmhQH2U9Duc2
	 2FK5lTjs63fMiep+tTxbf743zfqzRjX3K7uaSOV9TYg5E8LZpY2p4HomJzTfVu7bTAgqE
	 BQU+uIjvrqisSzupQZM4SCxwa8BpQW40L3AhjcRLgcKRZ3gWzo4t5iP+dxTNeo3EN2UVq
	 oggbfzcJtr8evffLXYPvYP4MuSUwZKxmeQ/eYAYW/IXNiUp1P1SRdGK4mL/EYO1P2/Xb/
	 NfBmiB93XjQhfiJOIQ/Lv0k6csXzlOWdXIsjzae+wOW6VQhDGANbwf90i0JzDrcjsdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087750;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=avlwFO4YaJ2loUf0K54UCcW3Kq7MdUM5DozbyuqnBWw=;
	b=f0+b4O7tqukRMPwMVq3/6xqlcSefPOsZsRGclcNoG6u+7BmgnkWloPhIxASbfLnSdhfF
	 FeMg4zWNTyiC9jHRl6sr7KCHRY3oqx/ZfPVsheNsotz40AWx4qRzO7oO2GZepmLKG2Dt3
	 lwLbM/x2JzazIAJPQYgbxqZ4f3lt0p8Z7hJWxWFbD1ubdVcA8REnhwp97AV3TwMW+EKSl
	 lwiAat/20qoTA9VfH7tPQ/9s7Wa++cILVTAjmnC7VH/t3qERuDmfQSww8dLmOLVOPZkqL
	 151StrpfJX7nWT9AqWyt3w34uNvpA8LnIReqKKbiwHM4x01NcAWhtHkdol9M8H2VY1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=EAxR36c5;
	arc=none smtp.remote-ip=205.210.164.56
Received: from mail-m20521016456.xmail.ntesmail.com (mail-m20521016456.xmail.ntesmail.com [205.210.164.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEE606A326
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 07:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EACEE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=EAxR36c5
Received: from localhost.localdomain (unknown [61.154.14.87])
	by smtp.qiye.163.com (Hmail) with ESMTP id 527d681f0;
	Tue, 27 Oct 2026 15:55:37 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: rk3588-evb1: describe the PCIe3x4 slot supply
Date: Tue, 27 Oct 2026 15:55:20 +0800
Message-Id: <20261027075520.3591049-3-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261027075520.3591049-1-shawn.lin@rock-chips.com>
References: <20261027075520.3591049-1-shawn.lin@rock-chips.com>
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
X-HM-Tid: 0aa17c5b901e03a4kunmefbf004c4b82ad
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSU5IVkpMTB9CSBoaHk0fH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ0xZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EAxR36c5LAmfymK1ywbtUfK1OHTeAsTDPHPYqMT4A71pUsB3A2RIUKd3OvrgamWC8eOL+RXpvhNhc3agSwZQyHZa/4rS1xvkyex+Y/lcxUZHIEfL8aNcwZN1QVo1Eo8Y/lXedkdoJN6oFw8gON8izygKyg4mQFuhwKHOWLHv7Ko=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=avlwFO4YaJ2loUf0K54UCcW3Kq7MdUM5DozbyuqnBWw=;
	h=date:mime-version:subject:message-id:from;

Move the vpcie3v3 supply of the PCIe3x4 controller into a child node
describing the slot, so that the PCI pwrctrl framework manages it.

The child node is modelled as a PCI bridge, which is what dtc expects
for a node below a PCI host bridge, and carries the regulator that
powers the devices in the slot.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

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

