Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB4750C2BC;
	Thu,  3 Sep 2026 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468772; cv=none; b=LIJg56NAmMIaAaczgo/NIuFtUwbgMj5Cf4AJgn6qTOJDIspqN3Pp1iI4qr1euJv7q2HSi7mJs+j3mmeDk68VVnXILOHaalS0QjixGqS/USZdeMMQ7evD4uArR69KGeqmjKmVMJsLr26bKbLss6lgZws3ziq9Uh86Nv/FvgO3V4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468772; c=relaxed/simple;
	bh=uxr3C6JMOBtCtwIv6cZSVyPr2qFeyR6ccbQLqw7bCeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ct6Dx4AAHO+wUkCVNzqhrQr81EeYriN9U3gPeJXrqTqqNBAvTc63A5sQdroMKGztufaUVlm7j9N1xiw286ITztq1PzNBffX5uaXJWJdxtpw1SbdspYvuGNd+STsgyEojc0f+Fo5Wf/Se2BMM5JyKp/yQqlwC8pUxIiJ7GOIo4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iHZpUPL7; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YAId4US0; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iHZpUPL7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YAId4US0"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbWy22bXCzMlG4;
	Thu, 03 Sep 2026 22:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEmfksLg4qJHlSCTmLWtP9kHWyMf/tAclg9vFAXBoXI=;
	b=iHZpUPL7yeaDC2P010g46TI0t9imbYGbaTtbc3uSd0cMQ6uBwToXYlSzUAnWNUY6w2+06a
	Y80rtJPclfkRT8zMHfvujA2epT2jjb/KwyZQKx3KeZ5vSE+BvCun0eMsEZaroqyGYq1OU3
	stUp4W1ZjKYNI/BPb7XpvUqNV3MXP6yjtsUCfvnhpiHK31yZ4AkhAqkGFWT3YOHVvUY5le
	mMLroU22HZGOmof4lPdUYT/351cu5G9Gzl9evirljVA3kN5DnPFt3Nusy1w/9ohS+anbIS
	CMUkuK8pTYSs2I7bFwOkZ5DAuXr+s3Ad20W8EyXNsweokmiT1gpgdRtzePQrWw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=YAId4US0;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEmfksLg4qJHlSCTmLWtP9kHWyMf/tAclg9vFAXBoXI=;
	b=YAId4US0O22k7f323jQO/sOtMTPBVUOSk91IGDSpu1ZLb8HmrhU4RhfeH974kDybOSufbU
	9kfAe193PRIA5oJnaO/lZk2p3MWWMUHoi02nXICGoXkpNItJTcNcC+0RJER9q+G/zcfyzb
	7tRAmgmLklWxbofzYqKwi4MlE+HacYBbivOBEgANfUxhzIIrGZdVSzVyTM7JK9L9T8cjO3
	LDL7UDORXFclkbfS+YlglXULW0sJ/XYKNqHox1NLd3MjyMy49pCmWB7lz5Wk18WI0VHrUZ
	ySXUVhy/gQukElF5LiI2BDyVVBeGhYNEauwuxiTs142WDUB5vAnT0KRbjyouWA==
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
Subject: [PATCH 6/6] arm64: dts: renesas: r8a779h0: Add PCIe Application/Local register reset
Date: Thu,  3 Sep 2026 22:50:57 +0200
Message-ID: <20260903205153.283553-6-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: gu1dkp5cbhpqcb571ayordeesxnptdpx
X-MBO-RS-ID: 9ab699da2505a2ba699
X-Rspamd-Queue-Id: 4hbWy22bXCzMlG4

Renesas R-Car V4M documentation R19UH0217EJ0110 Rev.1.10 , Jun. 30, 2026
attachment R-CarV4M_UM_009_SRCRn_FSRCHKRAn_FSRCHKRBn_r1p10.xlsx row 411
describes PCIEC ch0 Application/Local register reset. Add the reset into
both RC and EP DT nodes of PCIe controller.

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
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
index aca6ffc68c30a..c66fb22d72aa8 100644
--- a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
@@ -688,8 +688,8 @@ pciec0: pcie@e65d0000 {
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779H0_PD_A2PCIPHY>;
-			resets = <&cpg 624>;
-			reset-names = "pwr";
+			resets = <&cpg 624>, <&cpg 1121>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			num-lanes = <2>;
 			#address-cells = <3>;
@@ -724,8 +724,8 @@ pciec0_ep: pcie-ep@e65d0000 {
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779H0_PD_A2PCIPHY>;
-			resets = <&cpg 624>;
-			reset-names = "pwr";
+			resets = <&cpg 624>, <&cpg 1121>;
+			reset-names = "pwr", "core";
 			max-link-speed = <4>;
 			num-lanes = <2>;
 			max-functions = /bits/ 8 <2>;
-- 
2.53.0

