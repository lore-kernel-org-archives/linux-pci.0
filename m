Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34133DB310;
	Wed, 20 May 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282907; cv=none; b=XdAQ0tB6tmeBa2jlxfecNTN9HXiY/4p+yiCYmqWrwjuU2b6vwiwBS60ZTf7Y5LnJnWn2GZLiqW8vHIGODvmbK0cSBWS/CkTR8GzHkkHN2Klr6xLLL/G/FnqwnTolmA/wHIID6czS3JX1i4igmNa4tZxwV3U903bcnyc3n/GNAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282907; c=relaxed/simple;
	bh=p6JhUk/QCPu3Ceszn4wC1ZtmRnN1mBXz+DFHYbZKdoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxn2lZ4hXGyDp440GyfkoA+8ti+OSO7H9WU6dkFcISJ6Pm/j6pJ+oHeCaukQQJ8IJkzlk+DO0Aa7KvM2/z6jPcLZS3EfZCjNH8IpT7XWLfrxoHGqkQjWulGUSnz2nixNMTDPy6cQFZffJZuZeCDyBXLnCuvti+8pWzlYM0HP9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=bRj/oVxq; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="bRj/oVxq"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14BC2434F14;
	Wed, 20 May 2026 15:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1779282896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0FsuxVeXijvwiF0XWTrA9FENYRux1wdKVJSgIRmPFrQ=;
	b=bRj/oVxqmBfStdkPBII2DqzZWMMwBdHXJBsKJBpZHI4Cr+ZCWQPQRKsSG/Lbdfne4CZ66u
	8bFUa9Ojes7u3fbANA2n5VzEh8AHwT5uSWBt82cgntl3VDJYITjSGUlySqvT5VvyA4koaf
	ZfCwMP6glic0yjCWEXF2FWBfSm/sUK4DYtMDBM+agwZvFD07LhqnYveGcbKbFSI2zRz3kP
	wrUoJG1DoK+/0NxrLqCp7Tc2fuswf6kMBAF/l06IHLZJ2IWKKgwwxV3izbJKgVXGtnXKu1
	MdOY16xl1YeDiAiWK1GSSu3Ubd0YABTw7AuGuvanqB9/4kC4JFtVCPi1h6rRaA==
Message-ID: <1552f47b-7542-414e-ab6a-a07efc8e81e5@cjdns.fr>
Date: Wed, 20 May 2026 15:14:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 2/2] PCI: mediatek: Add support for EcoNet EN7528 SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
 robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
References: <20260514151318.3444959-3-cjd@cjdns.fr>
 <20260514210141.2DEF2C2BCB3@smtp.kernel.org>
 <22d7274b-640a-470e-86b0-997a4b6e102d@cjdns.fr>
 <ihqxutsgrcrbusbtblxmaq3swcp3xtiq6ycnpi7nl45fup36ym@6kvdzwu4zivy>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <ihqxutsgrcrbusbtblxmaq3swcp3xtiq6ycnpi7nl45fup36ym@6kvdzwu4zivy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Thanks for weighing in


On 20/05/2026 10:34, Manivannan Sadhasivam wrote:
> On Fri, May 15, 2026 at 03:34:53PM +0200, Caleb James DeLisle wrote:
>> Regarding this, I could use some advice. Bjorn I tagged you in because
>> you're probably best to have an opinion here.
>>
>>
>> On 14/05/2026 23:01, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>>> - [High] mtk_pcie_retrain() iterates the PCI bus without locks and holds an unreferenced device pointer, leading to a Use-After-Free.
>>> - [High] mtk_pcie_retrain() only retrains the first root port, silently ignoring any other ports on the same host.
>>> - [High] Link retraining occurs after downstream endpoint drivers are probed, causing a race condition that can lead to system crashes.
>>> - [High] Calling virt_to_phys() on an __iomem pointer causes undefined behavior and potential memory corruption.
>>> - [Medium] The IS_BUILTIN() workaround silently degrades hardware capabilities when the driver is compiled as a module.
>>> --
>>>
>>> commit 08338fe344200ef55148194108ab3b65616af7c7
>>> Author: Caleb James DeLisle <cjd@cjdns.fr>
>>> Subject: PCI: mediatek: Add support for EcoNet EN7528 SoC
>>>
>>> This commit adds support for the PCIe controller found on EcoNet EN7528 SoCs.
>>> It introduces a hardware quirk to retrain the link after startup, as some
>>> ports capable of Gen2 operation will initially start at Gen1 speeds.
>>>
>>>> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
>>>> --- a/drivers/pci/controller/pcie-mediatek.c
>>>> +++ b/drivers/pci/controller/pcie-mediatek.c
>>> [ ... ]
>>>> @@ -753,6 +764,135 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>>> [ ... ]
>>>> +	/* Activate INTx interrupts */
>>>> +	val = readl(port->base + PCIE_INT_MASK);
>>>> +	val &= ~INTX_MASK;
>>>> +	writel(val, port->base + PCIE_INT_MASK);
>>>> +
>>>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>>>> +		mtk_pcie_enable_msi(port);
>>> Is it safe to call mtk_pcie_enable_msi() here? Looking at
>>> mtk_pcie_enable_msi(), it calculates the message address using:
>>>
>>>       virt_to_phys(port->base + PCIE_MSI_VECTOR)
>>>
>>> Since port->base is an ioremapped __iomem pointer, passing it to
>>> virt_to_phys() produces undefined behavior and could return a garbage
>>> physical address. If this address overlaps with valid physical RAM mapped
>>> for DMA, could memory writes from the PCIe endpoint corrupt random system
>>> memory?
>> Learned a few things from that note. Seems ioremap is just giving us a KSEG1
>> address and virt_to_phys() is getting the real address back. In any case I'm
>> just doing what the driver already does.
> This looks definitely wrong because virt_to_phys() is supposed to be used for
> virtual address, not the ioremapped address. virt_to_phys() will calculate the
> physical address using the page offset, which doesn't apply to ioremapped
> address.
>
> Correct way would be to store the physical address while doing the ioremap:
>
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 75722524fe74..c503fbd774d0 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -175,6 +175,7 @@ struct mtk_pcie_soc {
>   /**
>    * struct mtk_pcie_port - PCIe port information
>    * @base: IO mapped register base
> + * @phys_base: Physical address of the I/O register base region
>    * @list: port list
>    * @pcie: pointer to PCIe host info
>    * @reset: pointer to port reset control
> @@ -196,6 +197,7 @@ struct mtk_pcie_soc {
>    */
>   struct mtk_pcie_port {
>          void __iomem *base;
> +       phys_addr_t phys_base;
>          struct list_head list;
>          struct mtk_pcie *pcie;
>          struct reset_control *reset;
> @@ -405,7 +407,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>          phys_addr_t addr;
>   
>          /* MT2712/MT7622 only support 32-bit MSI addresses */
> -       addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> +       addr = port->phys_base + PCIE_MSI_VECTOR;
>          msg->address_hi = 0;
>          msg->address_lo = lower_32_bits(addr);
>   
> @@ -520,7 +522,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
>          u32 val;
>          phys_addr_t msg_addr;
>   
> -       msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> +       msg_addr = port->phys_base + PCIE_MSI_VECTOR;
>          val = lower_32_bits(msg_addr);
>          writel(val, port->base + PCIE_IMSI_ADDR);
>   
> @@ -953,6 +955,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
>          struct mtk_pcie_port *port;
>          struct device *dev = pcie->dev;
>          struct platform_device *pdev = to_platform_device(dev);
> +       struct resource *res;
>          char name[20];
>          int err;
>   
> @@ -961,7 +964,14 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
>                  return -ENOMEM;
>   
>          snprintf(name, sizeof(name), "port%d", slot);
> -       port->base = devm_platform_ioremap_resource_byname(pdev, name);
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> +       if (!res) {
> +               dev_err(dev, "failed to get port%d base\n", slot);
> +               return -EINVAL;
> +       }
> +
> +       port->phys_base = res->start;
> +       port->base = devm_ioremap_resource(&pdev->dev, res);
>          if (IS_ERR(port->base)) {
>                  dev_err(dev, "failed to map port%d base\n", slot);
>                  return PTR_ERR(port->base);
>
> I see a couple of other drivers also doing something similar. So I'll try to
> send fixes for all of them separately.
If you want me to integrate this fix in my patchset to avoid merge 
conflicts, just let me know.
>>>> +
>>>> +	/* Set AHB to PCIe translation windows */
>>> [ ... ]
>>>> +static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *host)
>>>> +{
>>>> +	struct pci_dev *rp;
>>>> +	int ret = -ENOENT;
>>>> +	u16 lnksta = 0;
>>>> +	u32 speed;
>>>> +
>>>> +	/* Should already have been warned about during startup_port */
>>>> +	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK))
>>>> +		return 0;
>>>> +
>>>> +	for_each_pci_bridge(rp, host->bus) {
>>>> +		if (pci_pcie_type(rp) == PCI_EXP_TYPE_ROOT_PORT)
>>>> +			goto found_port;
>>>> +	}
>>>> +
>>>> +	/* Should not happen */
>>>> +	return dev_err_probe(dev, ret, "root port not found\n");
>>>> +
>>>> +found_port:
>>> The commit message mentions that it is most convenient to retrain every port
>>> after startup. Does the goto found_port here unintentionally skip all
>>> subsequent root ports by breaking out of the loop after the first match?
>> There aren't any.
> That's today, not tomorrow. You should do retrain for each of the Root Port
> detected, and not the first one. Also, the driver is structured to handle
> multiple Root Ports. So bailing out during first Root Port is not correct.
Okay I'll change that.
>
>>> Also, is it safe to traverse host->bus->devices via for_each_pci_bridge()
>>> without holding the pci_bus_sem read lock? If a device is concurrently added
>>> or removed, this might lead to list corruption.
>>>
>>> Finally, pcie_retrain_link() is a sleepable function. Because the code does
>>> not acquire a reference to the root port via pci_dev_get() before sleeping,
>>> could a concurrent removal event free the pci_dev structure and result in a
>>> use-after-free?
> This is concern is not valid. mtk_pcie_retrain() is getting called during
> controller driver probe(), so there is almost no chance that the Root Port will
> get removed during pcie_retrain_link().

Okay thanks for the guidance here, I couldn't really quantify the risk 
but the complexity of trying to eliminate it was becoming a concern.


I'll be back soon with v8


Thanks,

Caleb

>
> - Mani
>
