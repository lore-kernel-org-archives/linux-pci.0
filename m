Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73195357D1A;
	Fri, 15 May 2026 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852101; cv=none; b=K7fd655GP7bqi6WyTmvCqyYh3ULYeGgiuB7wBzsOXQrkudp9S09k9psqs2XDB6DudP+yKDmd3WHsKcZFku4U+qoEs/nvlSIMyuqqUUYoCaG3a7GA2d1krz4jVoHyOXeMi7pz0tfg0umAuvBmfDTUxEI5QZLXCJ1Pdy+XroEOLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852101; c=relaxed/simple;
	bh=NCET79qZworMeGxlUtbnqOq50zq63+sJvrMAPaiTqmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9CPVksvQrO3dx4CavoXGlaJi1OhsuSxYum/qMc1BFiY2Hd+GrN0qLAfQD+MH9a512AQb2sgNDkRwJISj8ziHUBA2HzimkaYSQs+YdSeQuatoNf4ADV9t1MZdpj8AYZS3LwOKa/bah9o1GSnNEo+U4zAChOMHkdj+JMUrfzJ6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=bknCUXBu; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="bknCUXBu"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A16943E2A72;
	Fri, 15 May 2026 15:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1778852095; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=A5zmeGSN+y1eB9ovPme0Em/fslZDHREQBQZ+/qd911k=;
	b=bknCUXBuLti5q0f9ZMuKNon9Wcm1gf0EoenQcEslk0B5FVXdV+2X2kW0LD9tnYtzibTkzY
	2xmgv3xDCCMYbiFyncIidH+FzGnveyQ9thlEN4oCeSsG6VqhyR1KtZIx11kh0cNP2LEPQ5
	ZrBt3OCBMS5GNfu/aU8QHq4BGZC3eX1fLnVITWfH+yo1U74DVfsD5s7umqPfxFYVVXlfru
	bqAsoz5pCG1meAVhV9rC21jzByOt2z3ZBSf5V5wT9nDvLgEWeJ309jwCRQ7xBVOroKXlTU
	DqNxRDOZsXpIxE49PP514pWOB41vutfRJt4cAOe7a0+yAPL+kNrQPBns2CsEKA==
Message-ID: <22d7274b-640a-470e-86b0-997a4b6e102d@cjdns.fr>
Date: Fri, 15 May 2026 15:34:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 2/2] PCI: mediatek: Add support for EcoNet EN7528 SoC
To: sashiko-reviews@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
References: <20260514151318.3444959-3-cjd@cjdns.fr>
 <20260514210141.2DEF2C2BCB3@smtp.kernel.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20260514210141.2DEF2C2BCB3@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Regarding this, I could use some advice. Bjorn I tagged you in because 
you're probably best to have an opinion here.


On 14/05/2026 23:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] mtk_pcie_retrain() iterates the PCI bus without locks and holds an unreferenced device pointer, leading to a Use-After-Free.
> - [High] mtk_pcie_retrain() only retrains the first root port, silently ignoring any other ports on the same host.
> - [High] Link retraining occurs after downstream endpoint drivers are probed, causing a race condition that can lead to system crashes.
> - [High] Calling virt_to_phys() on an __iomem pointer causes undefined behavior and potential memory corruption.
> - [Medium] The IS_BUILTIN() workaround silently degrades hardware capabilities when the driver is compiled as a module.
> --
>
> commit 08338fe344200ef55148194108ab3b65616af7c7
> Author: Caleb James DeLisle <cjd@cjdns.fr>
> Subject: PCI: mediatek: Add support for EcoNet EN7528 SoC
>
> This commit adds support for the PCIe controller found on EcoNet EN7528 SoCs.
> It introduces a hardware quirk to retrain the link after startup, as some
> ports capable of Gen2 operation will initially start at Gen1 speeds.
>
>> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
>> --- a/drivers/pci/controller/pcie-mediatek.c
>> +++ b/drivers/pci/controller/pcie-mediatek.c
> [ ... ]
>> @@ -753,6 +764,135 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> [ ... ]
>> +	/* Activate INTx interrupts */
>> +	val = readl(port->base + PCIE_INT_MASK);
>> +	val &= ~INTX_MASK;
>> +	writel(val, port->base + PCIE_INT_MASK);
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		mtk_pcie_enable_msi(port);
> Is it safe to call mtk_pcie_enable_msi() here? Looking at
> mtk_pcie_enable_msi(), it calculates the message address using:
>
>      virt_to_phys(port->base + PCIE_MSI_VECTOR)
>
> Since port->base is an ioremapped __iomem pointer, passing it to
> virt_to_phys() produces undefined behavior and could return a garbage
> physical address. If this address overlaps with valid physical RAM mapped
> for DMA, could memory writes from the PCIe endpoint corrupt random system
> memory?
Learned a few things from that note. Seems ioremap is just giving us a 
KSEG1 address and virt_to_phys() is getting the real address back. In 
any case I'm just doing what the driver already does.
>
>> +
>> +	/* Set AHB to PCIe translation windows */
> [ ... ]
>> +static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *host)
>> +{
>> +	struct pci_dev *rp;
>> +	int ret = -ENOENT;
>> +	u16 lnksta = 0;
>> +	u32 speed;
>> +
>> +	/* Should already have been warned about during startup_port */
>> +	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK))
>> +		return 0;
>> +
>> +	for_each_pci_bridge(rp, host->bus) {
>> +		if (pci_pcie_type(rp) == PCI_EXP_TYPE_ROOT_PORT)
>> +			goto found_port;
>> +	}
>> +
>> +	/* Should not happen */
>> +	return dev_err_probe(dev, ret, "root port not found\n");
>> +
>> +found_port:
> The commit message mentions that it is most convenient to retrain every port
> after startup. Does the goto found_port here unintentionally skip all
> subsequent root ports by breaking out of the loop after the first match?
There aren't any.
>
> Also, is it safe to traverse host->bus->devices via for_each_pci_bridge()
> without holding the pci_bus_sem read lock? If a device is concurrently added
> or removed, this might lead to list corruption.
>
> Finally, pcie_retrain_link() is a sleepable function. Because the code does
> not acquire a reference to the root port via pci_dev_get() before sleeping,
> could a concurrent removal event free the pci_dev structure and result in a
> use-after-free?


Okay here's the one I have a question about:

There's a bunch of related issues here, and I don't see any way to 
perfectly resolve all of them without moving retrain up before 
pci_host_probe(), but as noted previously without a mapped bus I can't 
just call pcie_retrain_link() and I have to - at worst - manually find 
the registers which is an annoying amount of additional code.

 From the vendor code, it looks like it should be about 50-70 lines of 
code to do this manually. The question is, is this race adding more 
complexity than that code?

I think wrapping the mtk_pcie_retrain() call in a 
pci_lock_rescan_remove() lock should stop any downstream probing while 
pcie_retrain_link() sleeps, but if it happens that a downstream device 
ends up probing on a different CPU, in the moment 
between pci_host_probe() and pci_lock_rescan_remove(), we still have the 
problem of retraining while the device is setting up. Though this is 
admittedly a pretty tiny race window.

So I think the options are:

1. Do nothing

2. Add pci_lock_rescan_remove() - I'm not informed enough to know if 
this can introduce other issues...

3. Give up on using pcie_retrain_link() and do it manually before 
pci_host_probe()


I'm leaning toward #2 but I also don't know what I don't know, so I 
could use a little advice.



>
>> +
>> +#if IS_BUILTIN(CONFIG_PCIE_MEDIATEK)
>> +	ret = pcie_retrain_link(rp, true);
>> +#endif
> Does this silently degrade hardware capabilities when the driver is compiled
> as a loadable module? The Kconfig definition allows CONFIG_PCIE_MEDIATEK to
> be a tristate module, so users compiling it as a module might find their PCIe
> devices permanently stuck at Gen1 speeds.
Handled in the if statement above, noted in previous version of the patch.
>
>> +
>> +	if (ret)
> [ ... ]
>> @@ -1149,6 +1289,13 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>>   	if (err)
>>   		goto put_resources;
>>   
>> +	/*
>> +	 * Ignore error because pci_host_probe() was already called, and in any
>> +	 * case it is possible that the port will still work as Gen1.
>> +	 */
>> +	if (pcie->soc->quirks & MTK_PCIE_RETRAIN)
>> +		mtk_pcie_retrain(dev, host);
>> +
>>   	return 0;
> Does retraining the link at this stage introduce a race condition with
> downstream endpoints?
>
> By the time pci_host_probe() completes successfully, the PCIe bus is fully
> enumerated and downstream endpoint drivers (such as NVMe or WiFi) have been
> probed. If those drivers are actively issuing MMIO or DMA requests, forcing
> the physical link into the Recovery state could cause PCIe completion timeouts
> and potentially lead to fatal kernel crashes.

Issue noted above.


Thanks,

Caleb


