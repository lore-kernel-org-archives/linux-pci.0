Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22A3C1F26;
	Sun, 27 Sep 2026 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541814; cv=none; b=I1TdCN3osotm1LBauzbsMjOAFGiPJ3Hs8WjZR4KyjPNy2pew1nMuQDFwjLWtZlkfxpkzndKY87bHDpx9p4BGbXs7x96rV+AD7ELCZuh//2WIavPHxOHjDiFP6YuLpsKMbXhKPb8Z2RoCZzVApCObCAkrAoASOEJ6GVhQJBJmoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541814; c=relaxed/simple;
	bh=9bgdlnSaamC/eFsrabIbD1GD59yd6zdbuE85m+b0K3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dq/WxsFhiU2hxwMrMeOVrHeTQqaT3lLY9xFfJFzkUZ7XCW9rlgHnf42XPAS8fOt/sgZMw/+c6zV5k5UJNTfEe+vZZ5VKaWhB8UFueKTx/mAu36Gxq9VieCHCSUSANxMNTch9e6AuaubXzE4C7scOJySho19RBGBZTfhS7wQJwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xOU9TuzV; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xOU9TuzV"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4htGcD2VBWzKnyV;
	Sun, 27 Sep 2026 22:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790541804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgP2hH4FH45gCFDYZrV9ICqUEu5AepbG2+NwURF5zYk=;
	b=xOU9TuzVCcx62FO4BBbsB6PwL8wr4CmYW8Xebnk66tMcN7fMhhpX6jsTltx2AfKHNOdcsm
	grODoe+hh2m6nBtbRW0nhzl1Ia1V9agTsvHYsE9sHuT7u2PM1aCLLiyeZKthMcjY/1+FKD
	z9s9DWeWEQaVlfH0I2DD08Ie4It3Y9XkL5awecGeZevdIWtlobuQgA5jvH4JHTaMfkA304
	LLwYvG7upKutDsaGlwBA4oDVguys6oaBheaBEzdHrw0Vo4yvnl5QermkWObfjFqeLKLAzB
	5P8/T4VTMKl0AZtPxsB3bjNesMq6U2JXgsDCIHepz1iSRscP/YZBn/2JeHhKpw==
Message-ID: <2c140ff6-52ee-4c47-8f31-f3173b086095@mailbox.org>
Date: Sun, 27 Sep 2026 22:43:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 05/11] PCI: rcar-gen4: Split reusable hardware
 initialization
To: Koichiro Den <den@valinux.co.jp>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-6-den@valinux.co.jp>
 <e99b8b02-861e-4980-b7a0-f0075640589d@mailbox.org>
 <76sb4yufhu7erlpt5ndlas4aegasxeqpiz6l7vvdwxyjzbgb2m@rgabcdixifw4>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <76sb4yufhu7erlpt5ndlas4aegasxeqpiz6l7vvdwxyjzbgb2m@rgabcdixifw4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: u5hxbbm1f5j6mq1ryc7rzgoj7oyuhxsd
X-MBO-RS-ID: 38f0909ae112767b9c8

On 9/23/26 5:24 PM, Koichiro Den wrote:
> On Tue, Sep 22, 2026 at 11:15:48PM +0200, Marek Vasut wrote:
>> On 9/18/26 5:20 AM, Koichiro Den wrote:
>>
>> [...]
>>
>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>> @@ -178,23 +178,18 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>>>    	u32 val;
>>>    	int ret;
>>> -	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
>>> -	if (ret) {
>>> -		dev_err(dw->dev, "Enabling core clocks failed\n");
>>> +	ret = reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>>> +	if (ret)
>>>    		return ret;
>>> -	}
>>> -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
>>> -		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>>> -		/*
>>> -		 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
>>> -		 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
>>> -		 * indicates that for peripherals in HSC domain, after
>>> -		 * reset has been asserted by writing a matching reset bit
>>> -		 * into register SRCR, it is mandatory to wait 1ms.
>>> -		 */
>>> -		fsleep(1000);
>>> -	}
>>> +	/*
>>> +	 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
>>> +	 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
>>> +	 * indicates that for peripherals in HSC domain, after
>>> +	 * reset has been asserted by writing a matching reset bit
>>> +	 * into register SRCR, it is mandatory to wait 1ms.
>>> +	 */
>>> +	fsleep(1000);
>>
>> This fsleep here should only happen if the reset wasn't asserted before.
>> Is removal of reset_control_status() correct ?
> 
> You're right. Looking at the code again, adding the recovery path doesn't at all
> justify removing the reset_control_status() check. I'll fix it and restore that
> condition.

Thank you !

-- 
Best regards,
Marek Vasut
