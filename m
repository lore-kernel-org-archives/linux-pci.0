Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601894;
	b=ie5mPUwol81HLmmJJhtq7+VbGQKPgMn4iH7b5g13usRlW2j5pJUnOTMoOjQkOFLKmeQp
	 YzT81KGDadg5v9n82CbHRZcUT54HrZkefwl+YelYM3F+N3TmThGOMeokrDzOnR10SrkKB
	 UcBR9p2hQRl85tL3M+PWhqWpbtxyWFUVLNTp6ZM++7F4vvOp4U5++pOgAGCyDYFU/jpL7
	 acizAs+wxzDfxg1SVvTqoghfrFK8a0e5EXkwX5mxEC/v1SvIhE81XuJx8Afv9CIY2MOk5
	 v5J89matTp2RLt1IjXffWXfrnSmyN6TGbMIAlzS0Ci6Owt1fbIdug5jGIyDW4luNIFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601894;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LICvFzVOGOGmNjipLyltEiVsGlWlsIewU35KFPGz8nA=;
	b=Ppscp0UVv4hhdo0+7KMS7MiIEEs8T0huv0cB708iWghr163y3KLDsenLzveEtkxADNUh
	 /h+gRgsFv6O6/w5c21IVoYy0q+y6N0O7c3VgvCxckysV/A0iK2iDkcQ6sBFfjv3ond4tS
	 N8Akd49Dkdt3SkLQVGmZQrKXtaPdmqcacPaA4iKyxG4RLAC3OhAFocGFe+XO80PjqDVKI
	 qA4cRtPc2CN03FqXMDmEWcY+zwQ8vgAuBO+LiXPTL5JlnvPh97Y+fy1TCAFVes3y3lW2p
	 Hi3Qlztt+PyWfXkOlw5NQCk+YKiCPdOWJbWr1qttM8h6JLZGruLJo7m+dCgHuPYlugA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CL6vuYWM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406A606A323;
	Wed, 25 Nov 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CL6vuYWM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795601893;
	b=127oBQeBrUt21o9p+LuRL58EPS5+ydCL0PiiQcRW58HXX45Ye7xWlq0x40y8sTvdDCg4
	 0Ur9TvcJwNRMtJ1aAbG07i2Zwxez0fCvHTgLITiVRl8NHZPEP1KSToxG+oZm5sRXVR0rc
	 4iqSR50T6b2ikWaw/NqMbgG1TmRcfYtm8euvIunVmoOofZhSG1odEksKGLowRa/Zsjcek
	 pXiJKsd/e9Gcturrcy8+zLEtVF4GHtFDuFDjG1b3s4YZ6ydkqFrcuq6HB6rLfBJUgOazN
	 vl6fDYzT/Vur1doSr0TM2dD9odJQkyubJNf6zb+0aeT1QrXnX4K/E8iswJWwAfyNRrg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795601893;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LICvFzVOGOGmNjipLyltEiVsGlWlsIewU35KFPGz8nA=;
	b=vBGCmM3vvEbAPbgz3aROekPzWWUj3M4uB5G08oChAtAwCBDsx88SEYC1EWHZjQZLWqSX
	 iqVQGBMKhKoEN42ASXswswRq+yjFU6q5hmpNT5JPFEYqjcitBzgnvM3bBJdsUZZPw7Du2
	 6APp1o+RisEC2SvSFPd3KwGW7KZMCryzH3FB5GadxaPCnbFlbYfq1heLtQ2piLEKxq/oT
	 PCWKk0utBBx0799uM3wEgFiE9gYL5vvps2LCCTHstkTnkNM103GHf7GV/+zm6JzpxJJtL
	 0qc2+Ls2uE9Ko7Q26E2UKvdr2ngTxOHFtUcYjH6xYA+f+PsB3NLydGsk1nfjQGyCBGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4B4251F000D8;
	Wed, 25 Nov 2026 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601893;
	bh=LICvFzVOGOGmNjipLyltEiVsGlWlsIewU35KFPGz8nA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CL6vuYWMQyMkhv92CwToIetFEDtp9QGaKXZBr3qId1Ixr5vRDGbGrOBsKJ3Xcc1LH
	 apSF5zS5xWsI+4VOIxlBNlLjkdEjMHFakk33GcyUkPo2T+svqk9dPbyeIoys5+n9Zu
	 wUK9YVqLx2aZjSCuyqw9qq294p7SmIBofDcpu/jZWO+7GTbYBSgLQTlFCM17m4oqmZ
	 cgHsf/bYMQnCnb4RmR8riFLg5WED/v4fw0CHpgqoflWEthdziRp2d3Aw7nJp7QqhAB
	 XlooVpGtSlqhn1smh0RID/sAdy/dgF8Fe8QD2olOBljND5GJHfFd9ePIYrzH0JtxBA
	 Sey5QzOS5Zt6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D02C74CE43;
	Wed, 25 Nov 2026 10:17:52 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 25 Nov 2026 11:17:44 +0100
Subject: [PATCH 4/4] arm64: dts: qcom: glymur: Describe the PCIe thermal
 inputs
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
Message-Id: <20261125-glymur-thermal-fix-v1-4-b93a9feae156@oss.qualcomm.com>
References: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
In-Reply-To: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZJdaduTk3N5k77RqvSkUVPMcjS8LQRuYo7/mT0mao2c=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBrXO5rubwpqmuuItaW3qXKpFo5HiwqgL6+ptk
 IkZdZLlTqGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawa1zgAKCRBVnxHm/pHO
 9eSWB/4mX+m4XO+3doi+juA7wBm7jYpXi/ZFjYA2dwhmvZp68hEvoKfRr+VYh1vx49Z4PILNRGJ
 sk6yrl0ZMS2HTAkHTk50HdDfgv4VBlP8fkW/RL6UZ7+RQEDdPVyZVRX1+8Nfcx0w7adPvWUPkMF
 q+boqD0phfuaQ6batSIHc5kbfZWDk35IXbazb7X9pod9NMJlEXkjpoOceop6tBilpIx+4vU6YPR
 MOHW+UMsyGohCMztc9KneVI8fdJ7MWsvSLFrCOOdeOEVMSz3UnXha7VicKmRefqTm4H5DM49ujn
 bloHGZFB7j0c3h/OynCKzFGcgeM2EikuPBoCgEr/j4lQT90H
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
Content-Transfer-Encoding: 7bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Some PCIe PHY instances on Glymur benefit from periodic recalibration to
compensate for temperature-related drift and maintain stable link
operation. The controller driver triggers the recalibration with a link
speed switch once the temperature change on a polled sensor exceeds the
defined threshold, but for that it needs to know which sensors track the
PHY temperature and the drift temperature.

So add a property to identify the relevant temperature sensors,
'qcom,pcie-recalibration-thermal-zones', to PCIe domain 5 pointing at the
aoss-6 zone and to PCIe domain 7 pointing at the nsphmx-0 zone, as those
are the zones whose sensors track the respective PHY temperature. Both
zones are allowed a drift temperature of 25 degC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 65a398c0a992..6fb254abf81a 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3127,6 +3127,8 @@ pcie5: pcie@1b40000 {
 
 			operating-points-v2 = <&pcie5_opp_table>;
 
+			qcom,pcie-recalibration-thermal-zones = <&thermal_aoss_6 25000>;
+
 			msi-map = <0x0 &gic_its 0xd0000 0x10000>;
 			iommu-map = <0x0 &pcie_smmu 0x50000 0x10000>;
 
@@ -3615,6 +3617,8 @@ pcie3b: pcie@1b80000 {
 
 			operating-points-v2 = <&pcie3b_opp_table>;
 
+			qcom,pcie-recalibration-thermal-zones = <&thermal_nsphmx_0 25000>;
+
 			msi-map = <0x0 &gic_its 0xf0000 0x10000>;
 			iommu-map = <0x0 &pcie_smmu 0x70000 0x10000>;
 

-- 
2.43.0


