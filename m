Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376E30ACF0;
	Tue,  6 Oct 2026 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265715; cv=none; b=hrgIfWth0eSyWsEnTXAslPSqOllxSghj4zEfdI53WaOmutXezuI8GnMo13YPWiolvW9xnFz4MCM7JiHw9gx0W0GZP8+oV4HP/bePzNxOZxRIBAX3FsC2Km5IB0Pt1rR69hUXyp76NB1BVFE6P7EUfaioLDVs1HQUxC7bZzeDG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265715; c=relaxed/simple;
	bh=bWFHcT3cQnXUfVn+E4GPd6ugdQHGNoy+3sAGbounbAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVuzFFGBOzSYM+h5K6saAT46LvWORakGsAp9GCQOvI42ZMfACT7yYjwDTunwNcyeHDBk3HPAm9q8+7hwDfUovcsCfvG9Esw7j1MkkIwqAWK1vbkPvo0N2dFlgWlfA+Eq5xz5cUp/KEFjBsF6uYi1RjvuqPOGBqoHXtqe4mNOvr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tzbPh0+T; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tzbPh0+T"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hzQKM56kzz8twZ;
	Tue, 06 Oct 2026 07:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791265703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/f9oCJzacuOtCMgIQ2RlyGSpR3oGeLxyRwyU9u3vJo=;
	b=tzbPh0+TlNHJvmbQrUpGcz8Skkdq2EJqWqcDif/G3wj3HvVi5QLw6BNFgM+cfj1OCbZXfO
	4v3U6JUw+86VZ7E7t2w2ErJVNrVnWvEGlwvEbH1wIU94vhQwKxi3wrV6F6dD/kx6qm6Wr5
	sTbWz2W1mfprRrlf8A8IQ5uhuM+ll4ZPqT5Eu8Wzru2ckQA96Wnm2ayiOxbaQmuw+Cq8xK
	nl/c8fDozTdRQjFNyAmBNCBdKizc8PwI2IK2AKnfX9cE7a75DNQ/0InH3JyAniZNkoO2VH
	itbWCNXfibhPE2e8xwKPrbM4JS7vLofePYnAPL2h8WmIikMFo9maiqIjhjZlkw==
Message-ID: <f4ca9c43-aaf8-4c15-9b29-363414779e41@mailbox.org>
Date: Tue, 6 Oct 2026 07:20:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] arm64: dts: renesas: r8a779f0: Describe the PCIe
 AER interrupts
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-16-den@valinux.co.jp>
 <d9ffb9f3-ad89-4912-b863-637c838196cb@mailbox.org>
 <mtczl7e3tlwt26gj56wmvfeotuvd63dfpsmazo3yg4sqstyuhn@omeidmdgauzz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <mtczl7e3tlwt26gj56wmvfeotuvd63dfpsmazo3yg4sqstyuhn@omeidmdgauzz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: f7xtbstsca31pjg4c6b7uatdib6i1qhp
X-MBO-RS-ID: da55d30359b515db82d

On 10/5/26 7:11 PM, Koichiro Den wrote:
> On Sat, Oct 03, 2026 at 10:00:13PM +0200, Marek Vasut wrote:
>> On 9/28/26 6:52 PM, Koichiro Den wrote:
>>> The PCIe controllers report Root Port AER notifications through
>>> intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
>>> respectively, separately from the integrated MSI receiver interrupts.
>>> Describe these interrupts with the "aer" name so the controller driver
>>> can use them for Root Port error reporting.
>>>
>>> Append the new interrupts to preserve the existing interrupt indices.
>>>
>>> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> Hi Marek,
> 
>> Please also feel free to add this patch for R-Car V4H (performed cover
>> letter tests 2 and 3 on Retronix Sparrow Hawk)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
>> b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
>> index 5284923b6cef7..8342d3c6f9881 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
>> @@ -801,8 +801,9 @@ pciec0: pcie@e65d0000 {
>>                          interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
>>                                       <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
>>                                       <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
>> -                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>;
>> -                       interrupt-names = "msi", "dma", "sft_ce", "app";
>> +                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "msi", "dma", "sft_ce", "app",
>> "aer";
>>                          clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
>>                          clock-names = "core", "ref";
>>                          power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
>> @@ -850,8 +851,9 @@ pciec1: pcie@e65d8000 {
>>                          interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
>>                                       <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
>>                                       <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
>> -                                    <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>;
>> -                       interrupt-names = "msi", "dma", "sft_ce", "app";
>> +                                    <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "msi", "dma", "sft_ce", "app",
>> "aer";
>>                          clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
>>                          clock-names = "core", "ref";
>>                          power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
>>
>> And a matching patch for R-Car V4M (boot tested, but the board has no PCIe
>> device plugged into the slot)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
>> b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
>> index 5f9223a0f4468..a377aab3c8be0 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
>> @@ -683,8 +683,9 @@ pciec0: pcie@e65d0000 {
>>                          interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
>>                                       <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
>>                                       <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
>> -                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>;
>> -                       interrupt-names = "msi", "dma", "sft_ce", "app";
>> +                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "msi", "dma", "sft_ce", "app",
>> "aer";
>>                          clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
>>                          clock-names = "core", "ref";
>>                          power-domains = <&sysc R8A779H0_PD_A2PCIPHY>;
> 
> Thanks! I'll add them as two separate patches in v3, with your Suggested-by.
Thank you !
