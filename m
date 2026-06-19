Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A733BBAF;
	Fri, 19 Jun 2026 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882470; cv=none; b=VM6UhQ2Jby1o/mLQZ7xHaUM1+2GY4WRs+qzlchSKf+Mg/yP7XbvIDnK4MbaBatrgSY6dvD1wm+GcnJwniGCXvojAKwuw4z/G8eFIb38UuT0f6cNpjeNw5nOjnsxD1VzkP8bBZcRFV2GCv4M8UQz6M+34hbpjhW4jQ06Tl+/fnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882470; c=relaxed/simple;
	bh=D5EYChBLMOJ7WsQ858hZGJy5pb8WLM8kyf/D65oqdXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGHLm/ElrZ4Rz56G0/3h0/0Idl/gTRDf5Fm+guI2EpYPkW+1bUzM1QfpjcaZ/JX1mwKHBNxbbBxllFRnLHuQ8JXefr+hHPVe8mnMSOb1EvE4gvjaxsjKGEeIbnxCyGiFeElKhgz0YqXrxyoNV2XRQHYHOVM8jbKlh/0NjmvD9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LbJm8EVc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LbJm8EVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=d57g989chT6menWbADLc7r3x8ntkXVSkAIe3o/9ATfc=;
	b=LbJm8EVcsG02m/XFaSIRw35iAC/AdWraLcii8VSaf/uSYq/5wuNJ6pM5KqfULj
	8YDxb6EymqEQj+X4TrNwIK1msGOh65RLisj0k49PhXFBjGgeYLcljmLuvvZk5P7i
	P2cG3L/I4uspsq8pS3aPGn0peL98wXJWqoDPD2K/xLu1c=
Received: from [IPV6:240e:b8f:91b3:d000:a264:4237:512f:7b1] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHn4g_XjVqm+LYEQ--.60791S2;
	Fri, 19 Jun 2026 23:20:32 +0800 (CST)
Message-ID: <f6a9a0f9-b331-48d8-be86-64471b9ea4fb@163.com>
Date: Fri, 19 Jun 2026 23:20:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] PCI: controller: Add missing rescan lock around root
 bus removal
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, a-garg7@ti.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260618165914.GA394420@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260618165914.GA394420@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDHn4g_XjVqm+LYEQ--.60791S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr15urWDXr4xtrWDZr45Awb_yoWrZw1rpF
	ZIga1SkF4kJr4Y9a92va18Aw1YgwnxJ3y5J3s7Ww13uFnxuFy7XFya9FyrWas8CFZFyF4U
	ZF4Dt3W3J3Z8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uoa0dUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wGPM2o1XkEaaAAA3k



On 6/19/26 00:59, Bjorn Helgaas wrote:
> On Fri, May 22, 2026 at 12:18:13AM +0800, Hans Zhang wrote:
>> Several PCIe host controller drivers call pci_stop_root_bus() and
>> pci_remove_root_bus() without holding the global PCI rescan lock
>> (pci_rescan_remove_global_lock). This can cause race conditions with
>> concurrent PCI rescan or hotplug operations triggered via sysfs,
>> potentially leading to use-after-free or system crashes.
>>
>> This series adds the missing lock pairs to all drivers currently
>> exhibiting this pattern. No functional change other than proper
>> synchronization.
>>
>> Each patch is independent and targets a specific controller driver.
>> Please review and apply.
> 
> Thanks for this work.  I amended the commit logs of the eight applied
> patches so they're all the same (since all the patches do exactly the
> same thing) and so they all mention the reason for the change.
> 
> There are only four callers of pci_stop_root_bus() and
> pci_remove_root_bus() that would not be able to use a trivial helper
> function that does the lock/stop/remove/unlock internally:
> 
>    zpci_bus_release
>    acpi_pci_root_remove
>    hv_pci_remove
>    vmd_remove
> 
> It would be nice to analyze those to see if they could use the same
> pattern, which could be done inside a helper function that would avoid
> the possibility of adding the same bug elsewhere.
> 

Hi Bjorn,

Thank you for reviewing the series and for the constructive suggestion
regarding the common helper function.

I fully agree that introducing a helper (e.g., pci_remove_root_bus_safe())
to encapsulate the lock/unlock logic is a cleaner and more maintainable
approach, and it would help prevent similar issues in the future.

Since we are now in the merge window, I would prefer to hold off on this
further refactoring until the next cycle to avoid introducing any
unnecessary risks or conflicts at this late stage.

Best regards,
Hans

>> ---
>> The following are the comments from the sashiko-bot@kernel.org review.
>>
>> https://lore.kernel.org/linux-pci/20260519132017.63E1BC2BCB3@smtp.kernel.org/
>> """
>>> +void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
>>> +{
>>> +	struct pci_host_bridge *bridge;
>>> +
>>> +	cdns_pcie_debugfs_deinit(&rc->pcie);
>>> +	bridge = pci_host_bridge_from_priv(rc);
>>> +	pci_stop_root_bus(bridge->bus);
>>> +	pci_remove_root_bus(bridge->bus);
>>> +}
>>
>> Could this lead to a race condition during root bus teardown?
>>
>> Calling pci_stop_root_bus() and pci_remove_root_bus() without holding the
>> PCI rescan lock allows race conditions with concurrent PCI rescan or hotplug
>> operations triggered via sysfs.
>>
>> While this pattern might have been copied from a pre-existing function like
>> cdns_pcie_host_disable(), does it need to be fixed here to prevent
>> use-after-free or system crashes?
>>
>> Should these operations be protected by acquiring the lock using
>> pci_lock_rescan_remove() and pci_unlock_rescan_remove()?
>> """
>>
>>
>> The function cdns_pcie_hpa_host_disable() mentioned in the bot's comment is from
>> a separate patch series and will be fixed independently. This series focuses only
>> on existing controller drivers in the mainline kernel.
>> ---
>>
>> Hans Zhang (9):
>>    PCI: cadence: Protect root bus removal with rescan lock
>>    PCI: dwc: Protect root bus removal with rescan lock
>>    PCI: altera: Protect root bus removal with rescan lock
>>    PCI: brcmstb: Protect root bus removal with rescan lock
>>    PCI: iproc: Protect root bus removal with rescan lock
>>    PCI: mediatek: Protect root bus removal with rescan lock
>>    PCI: rockchip: Protect root bus removal with rescan lock
>>    PCI: vmd: Protect root bus removal with rescan lock
>>    PCI: plda: Protect root bus removal with rescan lock
>>
>>   drivers/pci/controller/cadence/pcie-cadence-host.c | 2 ++
>>   drivers/pci/controller/dwc/pcie-designware-host.c  | 2 ++
>>   drivers/pci/controller/pcie-altera.c               | 2 ++
>>   drivers/pci/controller/pcie-brcmstb.c              | 2 ++
>>   drivers/pci/controller/pcie-iproc.c                | 2 ++
>>   drivers/pci/controller/pcie-mediatek.c             | 2 ++
>>   drivers/pci/controller/pcie-rockchip-host.c        | 2 ++
>>   drivers/pci/controller/plda/pcie-plda-host.c       | 2 ++
>>   drivers/pci/controller/vmd.c                       | 2 ++
>>   9 files changed, 18 insertions(+)
>>
>>
>> base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
>> -- 
>> 2.34.1
>>

