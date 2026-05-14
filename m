Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE12D061D;
	Thu, 14 May 2026 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761938; cv=none; b=TyNcqlFAEJFISKBAXknvQpGS+68mDbc0nz8uwhRq+fxzx/HMAd3layujhGC8lN5dN6HXITAMoIHDxQeWlSOvDFqumvr8tEEwcrCrWABa8rPr4+8UCd821ODIHSWhmGAXyToWftiJ/LOvpTPs0KYHx5I03o+oONITlpzhALaQ6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761938; c=relaxed/simple;
	bh=dFTN/Ilmg7CNQWeV5jCNzcmA/sJ26w19Z6kHX59BuZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhhbhZN4GRj9B7HPK+dsvYF2ZHoUR25mWRAon2Fyihl9dzlI5e/Ouzd3EHTaBkHaaoz/jel6xbRQOEcmAishCmXuViBtfg0XvwGTA0rtr2TIPjq01taQ2UN7wzTItC5EgkJtHiE364TzOafd007TnDrEMaKvNTnhgwiswWB21cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=B+lQ81Hm; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="B+lQ81Hm"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A75263DAA82;
	Thu, 14 May 2026 14:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1778761934; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=q7MlT/vWbB9Fm8WlPe33XoQuzMQEOwGUJZoEX6GydF8=;
	b=B+lQ81Hm4VTmOnEPOjxxlxoNH4h6C+D4VGWRsIl+cgwYXlj7Wa5SrUW6tHHl5QMF9zXRTG
	AZBAVGpCHNBKRljM42Cpz3fvPCUm27ZUoVTh5oDLcT4MUkSLSw1bun5r2icWF5jITkNNYD
	X/Vxie5vZiy39Z+aTbavyYRucbsrvV8+2HMGvxowgyEwNVv0dD0dqWOh07/MW3GJdj1i6u
	AnmJCdKNKC1QJogqYRG/2L6jK+L8++WJ/PVku61aPc0xTXEXmWfFE1SYGU3VL2d55Bbcis
	kdAHL5aoVKnJKD/cjPTyFy0cqYuvX07ICN0lsnkwBnrL9Tf6i7TqkalW+1joSg==
Message-ID: <e09cabda-93eb-4cbc-b962-c6a55bc8f628@cjdns.fr>
Date: Thu, 14 May 2026 14:32:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6 2/2] PCI: mediatek: Add support for EcoNet EN7528 SoC
To: sashiko-reviews@lists.linux.dev
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
References: <20260513191652.3200607-3-cjd@cjdns.fr>
 <20260514113514.15297C2BCB3@smtp.kernel.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20260514113514.15297C2BCB3@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 14/05/2026 13:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] Use-after-free on probe error path due to missing pci_remove_root_bus().
> - [High] Hardware is exposed to endpoint drivers before link retraining completes, causing MMIO failures.
> - [High] mtk_pcie_retrain() only retrains the first root port, ignoring others.
> - [Medium] Data race and potential use-after-free due to unprotected iteration of the PCI bus list.
> - [Medium] Truncation of 64-bit resource_size_t in fls() causes incorrect AXI window size calculation.
> - [Medium] Silent feature degradation when the driver is compiled as a loadable module.
> --
>
> commit 940197600e9e8eb5cb8f108830edfaee6eeb6d16
> Author: Caleb James DeLisle <cjd@cjdns.fr>
>
> PCI: mediatek: Add support for EcoNet EN7528 SoC
>
> This commit adds support for the PCIe controller on the EcoNet EN7528 and
> EN751221 SoCs. It includes logic to re-train Gen2 capable ports that
> initially start at Gen1 speeds.
>
>> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
>> --- a/drivers/pci/controller/pcie-mediatek.c
>> +++ b/drivers/pci/controller/pcie-mediatek.c
> [ ... ]
>> @@ -753,6 +764,132 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>>   	return 0;
>>   }
>>   
>> +static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
>> +{
> [ ... ]
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		mtk_pcie_enable_msi(port);
>> +
>> +	/* Set AHB to PCIe translation windows */
>> +	val = lower_32_bits(mem->start) |
>> +	      AHB2PCIE_SIZE(fls(resource_size(mem)));
> Does passing resource_size(mem) to fls() risk truncating 64-bit values?
> Since resource_size_t can be a 64-bit integer and fls() expects a 32-bit
> unsigned int, an exact 4GB window (0x100000000) or larger could truncate
> to 0, leading to an incorrect translation window size. Should this use
> fls64() instead?
32 bit machine so I don't think that's worth worrying about.
>
>> +	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> [ ... ]
>> +static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *host)
>> +{
>> +	struct pci_dev *rp;
>> +	int ret = -ENOENT;
>> +	u16 lnksta = 0;
>> +	u32 speed;
>> +
>> +	for_each_pci_bridge(rp, host->bus) {
>> +		if (pci_pcie_type(rp) == PCI_EXP_TYPE_ROOT_PORT)
>> +			goto found_port;
>> +	}
> By jumping to found_port immediately upon finding the first root port, does
> this skip retraining for any subsequent ports (like RC1 on the EN7528)? The
> commit message mentions it is most convenient to re-train every port after
> startup.
Only one root port per host bridge.
>
> Also, is it safe to iterate host->bus->devices via for_each_pci_bridge()
> and use the rp device pointer without holding down_read(&pci_bus_sem) or
> taking a reference via pci_dev_get()? Since this function runs after
> pci_host_probe() finishes, could the device list change concurrently?
That I don't know, but I tend to think it's okay because mtk_pcie_probe 
has not finished.
>
>> +
>> +	/* Should not happen */
>> +	return dev_err_probe(dev, ret, "root bridge not found\n");
>> +
>> +found_port:
>> +	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK)) {
>> +		/* Let it go because the device will work as Gen1 */
>> +		dev_warn(dev, "module must be built-in to retrain to Gen2\n");
>> +		return 0;
>> +	}
>> +
>> +#if IS_BUILTIN(CONFIG_PCIE_MEDIATEK)
>> +	ret = pcie_retrain_link(rp, true);
>> +#endif
> If the driver is built as a loadable module, this skips link retraining and
> silently leaves the hardware operating at Gen1 speeds. Is there a way to
> achieve consistent hardware capabilities regardless of the build
> configuration without relying on IS_BUILTIN checks?
If statement a few lines above.
>
>> +
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to retrain port\n");
> [ ... ]
>> @@ -1149,6 +1286,11 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>>   	err = pci_host_probe(host);
>>   	if (err)
>>   		goto put_resources;
>>   
>> +	if (pcie->soc->quirks & MTK_PCIE_RETRAIN)
>> +		err = mtk_pcie_retrain(dev, host);
>> +	if (err)
>> +		goto put_resources;
>> +
>>   	return 0;
>>   
>>   put_resources:
> Since mtk_pcie_retrain() is called after pci_host_probe() returns, are the
> devices exposed to endpoint drivers before the link retraining completes?
Practically speaking, no. Theoretically speaking I'm not sure.
> If endpoint drivers are actively probing and communicating with the hardware
> via MMIO while the link is forced into the Recovery state, could this cause
> transactions to fail or timeout?
>
> Additionally, if mtk_pcie_retrain() fails, the code jumps to put_resources
> and returns an error. This causes devres to free the host bridge memory.
> However, since pci_host_probe() already fully registered the PCI root bus
> and its child devices, does this error path leave dangling references in the
> PCI subsystem by failing to call pci_stop_root_bus() and
> pci_remove_root_bus() before freeing resources?

That's a bug, I think the best thing to do is continue because it's 
possible that the port will work anyway as Gen1. I'll update accordingly.


Thanks,

Caleb

