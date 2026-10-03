Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB5495049;
	Sat,  3 Oct 2026 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057624; cv=none; b=lR4j2i1/vM9kt4O5jcZsSuPnNOiVv51nveBNLE4wy3XfRJBxsl+s6sccAsTM+q4CbiyX/mP7KucMLpQzIKpNhPVTJgYFMTgsqIyb/UcPgc5xDZVXY87p75/53abd4Nd4w/Hd1wcQnFW0Csrkb8N+Xlqf3kz/FpdmAP6YkQ6fVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057624; c=relaxed/simple;
	bh=wt4fijNLNy3Aioc6Hwwh+0qwkeuZyGboHRfs5T8eNEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXNhFCluizSJZAHcaKQbUWH7SHADvPnwewXVSZeZqbd4FUjGheUkF6EVwVKGttGVXdzLOv3DJT6w+b3JnSEKH60Pe1kdHF9TALXt4Mg3QkhgF4lehPIxSQ85X8cDfEN6/88wxlYOUKBV7srGhZ5NyDMzKPi4XVxkXYAh18SiwxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LX+0sLFw; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LX+0sLFw"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hxxMk3hGQzMlLn;
	Sat, 03 Oct 2026 22:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791057618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQEDlVwoaNn3lvGUdFeZJt4kmspOc3Gt/gvWhPl/auE=;
	b=LX+0sLFwg45/cpGOqsS/aeVmL/ckSFPxFwWWq8iJmBa5JlVbmBiEUB2y00Fx0l+g//shJY
	OMLUL8P2w9+bblYQM3U8W8QMSg651rkbqjAafmZY6hK8NMjBkK1x56oBqP2amHxccd9QnW
	eBeStr07qzYNZYtUzzgW1uGdZYOyTKFWEoOKRUEI1km0wWf6BrkLAvLneV/PAgfcao9fZo
	T8k3u9l5sYHmpMOovP48dy2b9boWyu7/EKiQFpNQyo9I2EpXl1cc9OkWk2Wpw5gEXvSrw5
	hEh8dM/oU5ZrHCURN1+ejfyF4l8UoAczuEQENrUqXbmdul7yeuosyw9ZpddPOQ==
Message-ID: <d9ffb9f3-ad89-4912-b863-637c838196cb@mailbox.org>
Date: Sat, 3 Oct 2026 22:00:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] arm64: dts: renesas: r8a779f0: Describe the PCIe
 AER interrupts
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-16-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-16-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5c3a95b595878ea46c4
X-MBO-RS-META: jqc8mug5qs1oxfr13rq3hmhqq7yibzzf

On 9/28/26 6:52 PM, Koichiro Den wrote:
> The PCIe controllers report Root Port AER notifications through
> intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
> respectively, separately from the integrated MSI receiver interrupts.
> Describe these interrupts with the "aer" name so the controller driver
> can use them for Root Port error reporting.
> 
> Append the new interrupts to preserve the existing interrupt indices.
> 
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Please also feel free to add this patch for R-Car V4H (performed cover 
letter tests 2 and 3 on Retronix Sparrow Hawk)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi 
b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 5284923b6cef7..8342d3c6f9881 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -801,8 +801,9 @@ pciec0: pcie@e65d0000 {
                         interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
                                      <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
                                      <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
-                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>;
-                       interrupt-names = "msi", "dma", "sft_ce", "app";
+                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+                                    <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+                       interrupt-names = "msi", "dma", "sft_ce", "app", 
"aer";
                         clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
                         clock-names = "core", "ref";
                         power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
@@ -850,8 +851,9 @@ pciec1: pcie@e65d8000 {
                         interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
                                      <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
                                      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
-                                    <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>;
-                       interrupt-names = "msi", "dma", "sft_ce", "app";
+                                    <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+                                    <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
+                       interrupt-names = "msi", "dma", "sft_ce", "app", 
"aer";
                         clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
                         clock-names = "core", "ref";
                         power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;

And a matching patch for R-Car V4M (boot tested, but the board has no 
PCIe device plugged into the slot)

diff --git a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi 
b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
index 5f9223a0f4468..a377aab3c8be0 100644
--- a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
@@ -683,8 +683,9 @@ pciec0: pcie@e65d0000 {
                         interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
                                      <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
                                      <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
-                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>;
-                       interrupt-names = "msi", "dma", "sft_ce", "app";
+                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+                                    <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+                       interrupt-names = "msi", "dma", "sft_ce", "app", 
"aer";
                         clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
                         clock-names = "core", "ref";
                         power-domains = <&sysc R8A779H0_PD_A2PCIPHY>;
