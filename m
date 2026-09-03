Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3C44BCBE;
	Thu,  3 Sep 2026 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468764; cv=none; b=XbN3uxnV7H+oiUnWYCOGJU6dVaNBLb3VIOmXczLaXIsLiRLSBnSY2BWIKfRPa5W+VVQ+YytxSODPU0SVMOuLu0Z539Eel/tzz6csyZ9R4mSJlTn5GIkOc2t3uC2ZaHD2slsPYXf8BXib1MXnOU4u3v88wID8Bolfy+HIScv6CdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468764; c=relaxed/simple;
	bh=uFJ3vSuhkD3rQrLCp9V/U6WMJkqtQaGZhVRsA+9NDaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2Io26VQUcV8EnncBKafLeeV/rxa+FMiQlP4zBQlPFRRvubJXozzIFlQQ17Qw9IwjjOdi2WmG/zrMLPF+7hiXHXL/WjroDrsvnvulC6ewxwo60qgaUjoUP/UQV73uQ/rr/tT/y7wR/1Y7e9oFqoXFHt5livA4vAKOsXysD8xX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=B1pGDqSG; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Tf/mhqz2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B1pGDqSG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Tf/mhqz2"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hbWxt2kcjzMlD5;
	Thu, 03 Sep 2026 22:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5ch7Wr3RuiEVXuL1nJzqa26vVBvjOkSRdK1vQB12vI=;
	b=B1pGDqSGax6/rlcgKQaXIUxR5SeaAau5FxYtkeHI+IE8+WMzCeXR9WuXAxfDIGXfeq8GgP
	oKekNcneO141SVx0aYEgMwQPiePCGwAd/bfY/xa51DHQBeuaZv61DUwFv/uLEzmWBvBrcD
	zTxl+CtTHb/pSyHKF3FekLuk9NNs75+/HBqGLwpt7XH2D18nXQirDSCRs7rz3Zrx5yTr45
	x4JAJ/BSEuJBc8DvEnASLv6mkWD+IdDNAAS/FWiVWwo6t/60uwicozkeuL0KHGlZkNAuVE
	ejGgsczkniWPVOL1Ne/0LlOl67+HCkw+c3EfmgMQL8UDGZ02PnhYciP2IJkpcw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5ch7Wr3RuiEVXuL1nJzqa26vVBvjOkSRdK1vQB12vI=;
	b=Tf/mhqz2WU9Lzj2DjT3X3NbWbZmmfDdsJmxyM7R/4WC1jsa9E78G3M5mIK4m+WcvvZwbTd
	wssheN9fFiEwUWYo6houcEbC8imNwfcftxfvAXeIQb/9eOyMXfS668Pg7Dj22F4j9navvP
	cwN2k9hfa16bdxLx8QSuqGOEIkS4We+9eAwzseZn9O8An5BtWL/CAkEyuqByv57geLKXA4
	pViNcvwMAWzf9Okm1sBBYDCmSAdtfZLcuXw+zsMr+h5JSJ/KSt2y8VwSyQLIRZluW28szn
	Dn4aAECjR42b0/FzZ/DOJwTwxVvHNd8N5wW+lSbANCJD8Ao9dIssDfRfV+gUzA==
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
Subject: [PATCH 4/6] arm64: dts: renesas: r8a779f0: Add PCIe Application/Local register reset
Date: Thu,  3 Sep 2026 22:50:55 +0200
Message-ID: <20260903205153.283553-4-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: wi4bt1f8ebuzha1db3dqc9hcy4bcekyu
X-MBO-RS-ID: d62eb3bef107bfa0fa5

Renesas R-Car S4 documentation R19UH0161EJ0140 Rev.1.40 , Jul. 31, 2026
chapter 9A.1.1.12 Software Reset Control Register 11 (SRCR11) bits 22
and 21 describe PCIEC ch1/ch0 Application/Local register reset. Add the
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
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 69c247b7f0e28..878b1d53fa371 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -790,8 +790,8 @@ pciec0: pcie@e65d0000 {
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-			resets = <&cpg 624>;
-			reset-names = "pwr";
+			resets = <&cpg 624>, <&cpg 1121>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			num-lanes = <2>;
 			#address-cells = <3>;
@@ -827,8 +827,8 @@ pciec1: pcie@e65d8000 {
 			clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-			resets = <&cpg 625>;
-			reset-names = "pwr";
+			resets = <&cpg 625>, <&cpg 1122>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			num-lanes = <2>;
 			#address-cells = <3>;
@@ -863,8 +863,8 @@ pciec0_ep: pcie-ep@e65d0000 {
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-			resets = <&cpg 624>;
-			reset-names = "pwr";
+			resets = <&cpg 624>, <&cpg 1121>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			num-lanes = <2>;
 			max-functions = /bits/ 8 <2>;
@@ -886,8 +886,8 @@ pciec1_ep: pcie-ep@e65d8000 {
 			clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-			resets = <&cpg 625>;
-			reset-names = "pwr";
+			resets = <&cpg 625>, <&cpg 1122>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			num-lanes = <2>;
 			max-functions = /bits/ 8 <2>;
-- 
2.53.0

