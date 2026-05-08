Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F633985
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778206531; cv=none; b=flo9eyd9RKHXETehoBI4WD9Vr3nPL3KcSyViaXCwTfIr261WZov+LdCvAYcLmEQdUyCQwbhqnygyGr2sRHBFf6XhEpYOSAbhxZKMCROm3eLf/XLOdOzH5xhJYRct+BOXpBst56IY/1pHyB/bhlO3G0DsskH2Iar0ZQR3Xbc+pTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778206531; c=relaxed/simple;
	bh=pi/8l4elz07UIxfTXrFRxZpLe27XTs6NHSQOWSxu+1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQcXg9z/6Nb+M43zfL6FgGqEy1fpIrJH+jeNiscOrM/hirHaqmY0r2eJjfFZXYjpw2kQa7PrwFLj/amdjUm7eY/47ZwjUqHEoLsV1g8Ns6G5y2f64sZzNqCPavxk+df9x8KcZcK2fM8+5zo1LEGsYHmsFQi/SnwrJOIXFadTyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L+2WhAK4; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L+2WhAK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=BKNcxBNF4k4qY7sWRJhXpvWPI7DG+pSATa9C23PkKHg=;
	b=L+2WhAK45tZdGxK4g2XqC0neJfZj29yi/6AvEqv/nIb6osnOt3ogQ9tR75fvoC
	n63xJnVvFnouGu0G68W1cXfg8qkYKWbM8nvrnQe0MVHig545/+p/d5Sq57vEKQr6
	xUDSMX4/W+eG16w3+Yk2439rkt59mibE24mOB4Uq09YUQ=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBHl1UNR_1pTo67Cw--.165S2;
	Fri, 08 May 2026 10:14:39 +0800 (CST)
Message-ID: <938ad958-f057-4909-8547-80b95f224864@163.com>
Date: Fri, 8 May 2026 10:14:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 phy-next 09/31] PCI: Remove device links to PHY
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manikandan K Pillai <mpillai@cadence.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Hans Zhang <hans.zhang@cixtech.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
 wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
References: <20260507154744.GA971447@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260507154744.GA971447@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBHl1UNR_1pTo67Cw--.165S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFyktF4xJw1UZF18GFWxJFb_yoW7KF45pF
	WDXas2kF48WF4jv3Z293WUZFyftF9ay347Jwnak3WS9r1Y9r98JFy7JFyF93ZakrWkZw12
	vw15twnrZFsYvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxkuxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCww+uUmn9Rw-J3QAA34



On 5/7/26 23:47, Bjorn Helgaas wrote:
> [+to Manikandan, Siddharth, Vignesh, Hans]
> 
> On Thu, May 07, 2026 at 07:59:58AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> - [Critical] Critical memory corruption in cdns_plat_pcie_shutdown() due to incorrect pointer cast.
>> - [High] Asynchronous pm_runtime_put() is called immediately before pm_runtime_disable(), cancelling suspend transitions.
>> - [High] Shared IRQ handlers access hardware registers without checking PM runtime state, causing spurious interrupts or bus errors.
> 
> Please take a look at these potential issues and see whether changes
> are needed.
> 
> pcie-cadence-plat.c and pci-keystone.c are orphaned since
> 
>    0ee2030af4e3 ("MAINTAINERS: Orphan Cadence PCIe IP")
>    57e1d8206e48 ("MAINTAINERS: move Murali Karicheri to credits")
> 
> Would anybody like to step up and take care of them?

Hi Bjorn,


I have sent a separate email to Manikandan to inquire if he has the time 
to maintain the driver related to Cadence PCIe IP. If Manikandan replies 
to the email, I will then reply to you.

Because Manikandan has a better understanding of Cadence IP's registers 
than our clients do, we have also previously collaborated on the 
upstream work of the HPA driver. Additionally, I also asked Siddharth 
and Vignesh directly if they had the time. My idea is that we all work 
together to maintain these drives.


The email address hans.zhang@cixtech.com is no longer valid. Please use 
Hans Zhang <18255117159@163.com> instead.

The maintainer of the file drivers/pci/controller/cadence/pci-sky1.c: I 
will update my email address.

Best regards,
Hans

> 
>> commit abda94a24ef1bb0817706ae87aa20f04251c14ad
>> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
>>
>> PCI: Remove device links to PHY
>>
>> This commit removes device links between the PCIe controllers and PHY
>> providers in the Cadence, DRA7xx, and Keystone drivers. The device links
>> are now redundant since the PHY core automatically adds device links to
>> order suspend/resume operations.
>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
>>> index 8b12a46b56019..6fd16e09e2444 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
>>> @@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>>>   	struct pci_host_bridge *bridge;
>>>   	struct cdns_pcie_ep *ep;
>>>   	struct cdns_pcie_rc *rc;
>>> -	int phy_count;
>>>   	bool is_rc;
>>>   	int ret;
>>
>> In cdns_plat_pcie_probe(), the driver data is initialized to point to a
>> struct cdns_plat_pcie object:
>>
>> 	cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
>> 	...
>> 	platform_set_drvdata(pdev, cdns_plat_pcie);
>>
>> However, in cdns_plat_pcie_shutdown(), the pointer is extracted and cast
>> directly to struct cdns_pcie *:
>>
>> static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
>> {
>> 	struct device *dev = &pdev->dev;
>> 	struct cdns_pcie *pcie = dev_get_drvdata(dev);
>> 	...
>> 	cdns_pcie_disable_phy(pcie);
>> }
>>
>> Since struct cdns_plat_pcie is only 8 bytes large, but the phy_count field
>> is at an offset of roughly 36 bytes in struct cdns_pcie, does this lead to
>> an out-of-bounds read and memory corruption when cdns_pcie_disable_phy()
>> attempts to iterate over the PHYs?
>>
>> [ ... ]
>>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>>> index fe4836925c4e3..cab9fad212add 100644
>>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> [ ... ]
>>> @@ -1337,25 +1321,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
>>>   	pm_runtime_disable(dev);
>>>   	ks_pcie_disable_phy(ks_pcie);
>>>   
>>> -err_link:
>>> -	while (--i >= 0 && link[i])
>>> -		device_link_del(link[i]);
>>> -
>>> +err:
>>>   	return ret;
>>>   }
>>>   
>>>   static void ks_pcie_remove(struct platform_device *pdev)
>>>   {
>>>   	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
>>> -	struct device_link **link = ks_pcie->link;
>>> -	int num_lanes = ks_pcie->num_lanes;
>>>   	struct device *dev = &pdev->dev;
>>>   
>>>   	pm_runtime_put(dev);
>>>   	pm_runtime_disable(dev);
>>
>> Does calling pm_runtime_put() immediately before pm_runtime_disable() cancel
>> the suspend transition?
>>
>> pm_runtime_put() queues an asynchronous idle or suspend work item, but
>> calling pm_runtime_disable() immediately afterward cancels this pending
>> transition via __pm_runtime_barrier().
>>
>> Could this leave the hardware in an active or incorrect power state from
>> the controller's perspective? Would it be safer to use synchronous
>> pm_runtime_put_sync() instead?
>>
>> This asynchronous put pattern also appears in the error paths of
>> dra7xx_pcie_probe() and ks_pcie_probe().
>>
>> While reviewing the power management handling in these drivers, I also
>> noticed that the shared interrupt handlers read hardware registers directly
>> without verifying if the device is active:
>>
>> drivers/pci/controller/dwc/pci-dra7xx.c:dra7xx_pcie_irq_handler() {
>> 	...
>> 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
>>
>> If another device sharing the same IRQ line triggers an interrupt while the
>> PCIe controller is runtime suspended, will these handlers attempt to read
>> powered-down hardware?
>>
>> Should the handlers check the PM runtime state using
>> pm_runtime_get_if_active() to prevent spurious interrupts or bus errors?
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260505100523.1922388-1-vladimir.oltean@nxp.com?part=9
> 

