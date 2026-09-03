Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDFA3C3F4E;
	Thu,  3 Sep 2026 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468766; cv=none; b=b/x0pi5JrPCUpbHzdO+LD+nur07l4Pn4rzwkJ7QvWsBohi676WCS8inv67ueM2HmnECJOkNFvy4acKTOBnmmji4Cpgg6Zqb4ksxYHwN1LswbE0B6q1CTT+z+lvkNk0d956wVp2hu4OBY/9FYY3WX7xvPeGDnYBUgZM+nGzH1VjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468766; c=relaxed/simple;
	bh=W5yIQ+hkKycFmgYYSWx7awMGHuuAwey1ilwGlwrrWeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BntVqXj2+oxnECi3Dg1OmFHQ/y4ba6QFC8Tb99bUAzz3VAf75ANAcg9H7+LjxnKbdW8G5qxbzzK6IrQsFABS50AhsSiGMbVCsU3S8oHuVqKiGoWwLAeE7kwqdm8JI4oH/G2KZo6fdX3t8gYhjwsiTOLZYrMbhRdE22dzFtRQcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=l5EDb55m; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=u1gn9QJN; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l5EDb55m";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u1gn9QJN"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbWxx6qG8zMlNJ;
	Thu, 03 Sep 2026 22:52:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyy/Oz2FDWJ9P3hqGh5X8XJpBjmRIaj0EKxvlcGM+ZA=;
	b=l5EDb55mlSE3kYkUuw+eFeiz/fJNNE44H7Mh0SnJU5iNTNCDsKJrttHn++tA7mDNpnm001
	YjvShj9VKXaZHryyxzYpAIhALjhwhPdUdt7KKsDyqS3hvvCXz31En3sHiy91mqsSjUN3dd
	Nz5O6cVNMYlbMsqe0QXOYipobsp4wfIcGFfZs7KPhvDWEjNwqnYF0jPrN4LeMdbMTzVlsB
	gD6zb3bsX4qre5GFcgtrPIXDBTmFh3cl5L0O737Vni70ucFX3/eWtpgxBFHlpqNwrUGY5o
	mbEK7ebeoPATkFGc+JvfBzzewS9laGydhxmYNeAJVlUicMhBqlwDGadN2j6zxA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyy/Oz2FDWJ9P3hqGh5X8XJpBjmRIaj0EKxvlcGM+ZA=;
	b=u1gn9QJNdJZq1YTHUIGiFTXPUVKrSYAaLAcQE0fY/b5kK7JeU5G7oJEsI/bMV9xXDVSOnC
	6qr3dbjqJVGjikNnpc2/3lR2+s9y8/Cmat+Cy09dF60q889hqsGHpdyih0+Zp0Xrldt+pY
	U7zD7iS1d0xCn8ED6x2wKLhki5H/To+1SQaZ1uBG1bJXD7z6oL5Rd89p1xwoQlWc+2AmGK
	6ZtL6l8phLZIvC9dPgFC25G0BdGT+w0sQ/lSmInV46GB2T/8txYnrsS2ttvJfHNrHAtzi3
	Sstl2oF9AapqbS3nE+jm0D7rm/6ZtLDDM4MtXP/KkzHqPDM1iSmKT+v7UwZLng==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: renesas: r8a779g0: Add PCIe Application/Local register reset
Date: Thu,  3 Sep 2026 22:50:56 +0200
Message-ID: <20260903205153.283553-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ff49f49f520a39863f9
X-MBO-RS-META: h7nnjc6ioe6mq9rstue7gpj58fc4r6bm

Renesas R-Car V4H documentation R19UH0186EJ0140 Rev.1.40 , Aug. 7, 2026
attachment R-CarV4H_UM_009_SRCRn_FSRCHKRAn_FSRCHKRBn_r1p40.xlsx rows 410
and 411 describe PCIEC ch1/ch0 Application/Local register reset. Add the
matching reset into both RC and EP DT nodes of both PCIe controllers.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index ea6495261c2bb..fbcd9d37eb8a2 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -806,8 +806,8 @@ pciec0: pcie@e65d0000 {
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
-			resets = <&cpg 624>;
-			reset-names = "pwr";
+			resets = <&cpg 624>, <&cpg 1121>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			msi-parent = <&its>;
 			num-lanes = <2>;
@@ -854,8 +854,8 @@ pciec1: pcie@e65d8000 {
 			clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
-			resets = <&cpg 625>;
-			reset-names = "pwr";
+			resets = <&cpg 625>, <&cpg 1122>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			msi-parent = <&its>;
 			num-lanes = <2>;
@@ -901,8 +901,8 @@ pciec0_ep: pcie-ep@e65d0000 {
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
-			resets = <&cpg 624>;
-			reset-names = "pwr";
+			resets = <&cpg 624>, <&cpg 1121>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			num-lanes = <2>;
 			max-functions = /bits/ 8 <2>;
@@ -924,8 +924,8 @@ pciec1_ep: pcie-ep@e65d8000 {
 			clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
-			resets = <&cpg 625>;
-			reset-names = "pwr";
+			resets = <&cpg 625>, <&cpg 1122>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			num-lanes = <2>;
 			max-functions = /bits/ 8 <2>;
-- 
2.53.0

