Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7D3BC69E;
	Fri, 16 Oct 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150057; cv=none; b=s9kCRyzM/hUf3bUNNqEY2SIggGEm0PH85rmsirx48RaDNhfCsuFvNg8ENVAPdj+kytVaL32+uJFa5+2hU/tawrFHgey7nIQ8vtgpQ6Nc6cTUQm+/eSgPcv42kEhnU4EVdc6W0XO5Orq0N936Ak9G7hDNzmuJWkoCBYO1CD+xT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150057; c=relaxed/simple;
	bh=GhyQN17VWd7SoAjtlip9xuFKJIo9rp2AytN0LvK4U9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXbwMfLXO7wzWoAwX+gzrRQrkUYrgu58FLMe8huVnrc5LK1909ccsZaAIDYId7OIVsp9W+qMaSG/BrlshrN25jPuCVO9szy6xDmwJ7FfX8LS+pdTG2maomQrusHCU0s0u2Io9pgMtnS2v2dF4eOBWJPw4CbcEisRqZPAP54AWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ru6SnttG; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ru6SnttG"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j5jMz0Gj6z8tyR;
	Fri, 16 Oct 2026 13:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792150047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmG3vMARJIZwqxyiykSt3n/8NHm7T43hsxGEbT9x4MM=;
	b=ru6SnttGuBZforc1QjhHsCRqyZt3SATyEzV2jvy4Li3rBk/ou4I3Z4E3CON2jGH7ZbALOA
	12K/tY51uQvp0ENPgY18LI31RgLcS/VxEguWlQmUq1s6yHjS/0yILRe5NmNPv43wSGXTmJ
	TpJq6DjV/prHE7MLV0torsxtrahYXjfVm4cIKSYUCuUKnumVnIkoznqMGfrrP1TXd2waon
	Mg6yWk/Fzlhjr1tgUMQjps6jSfavieBw+IXgOeL2ANs7K8c6cu5J0N2U+Ok+VEMFvTRbjw
	yowif3EjUbmWQWf7uJ1v1dFzaZfIf+hmIiZ52N+2S3KNnTAA4VGC3hpcHJs3MQ==
Message-ID: <a5cbdf4e-ad1d-4e54-84b7-15f7841c414c@mailbox.org>
Date: Fri, 16 Oct 2026 12:54:55 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI: rcar-gen4: Add missing PM ops
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 sashiko-reviews@lists.linux.dev
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
References: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org>
 <20261004013131.0C7D81F0089B@smtp.kernel.org>
 <179214090624.63727.1877053108500595755.b4-reply@b4>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <179214090624.63727.1877053108500595755.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: sjspt4g83kpztx5uz3hy416u9cgcio6w
X-MBO-RS-ID: 8acdd262cc24994b0e6

On 10/16/26 10:55 AM, Manivannan Sadhasivam wrote:
> On 2026-10-04 01:31 +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] pcie: deadlocks due to ioremap and request_firmware in NOIRQ PM phase
>> --
>>
>> commit e6c055f1eedf6bd5c13e231da24f0c6a76a24ba2
>> Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> PCI: rcar-gen4: Add missing PM ops
>>
>> The R-Car Gen4 PCIe controller needs to gracefully suspend and resume its
>> link across system suspend/resume cycles to support power domains shutting
>> down. This patch adds suspend_noirq and resume_noirq PM operations to tear
>> down the link on suspend and restart it on resume.
>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>> index 2e7a8d85c0060..fceecbd16355c 100644
>>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>
>> [ ... ]
>>
>>> @@ -1062,6 +1064,26 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
>>>   	return 0;
>>>   }
>>>   
>>> +static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
>>> +{
>>> +	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
>>> +
>>> +	if (rcar->drvdata->mode != DW_PCIE_RC_TYPE)
>>> +		return 0;
>>> +
>>> +	return dw_pcie_suspend_noirq(&rcar->dw);
>>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> [Severity: High]
>> Does this code trigger a deadlock or kernel panic during the NOIRQ PM phase?
>>
>> Setting pp->use_atu_msg to true causes dw_pcie_suspend_noirq() to eventually
>> call ioremap():
>>
>> dw_pcie_suspend_noirq()
>>    dw_pcie_pme_turn_off()
>>      ioremap()
>>
>> Since this runs during the suspend_noirq phase with local interrupts disabled
>> and the system frozen, ioremap() allocates memory with GFP_KERNEL and may
>> sleep, which is strictly prohibited in NOIRQ context.
>>
> 
> What? Local CPU interrupts won't be disbled in the noirq phase, only the device
> interrupts will be. So this concern is utterly baseless.
Do you think we could get this patch into 7.4 since this is a bugfix ?

Thank you !
