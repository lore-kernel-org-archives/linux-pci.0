Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28182367B5
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214696; cv=none; b=pIU+DGETogzS4rEGYPKHylF3z9uTEx9NAH5d4pkYyv6sU4QUSAUlCo0A+bG98u2MP0ESLxM8umqedvHiBCTJVM/Z/pHMitMAPa6AAdkRHe+XKgs4wxLdvt3Sv9D1tEIzWDNPm5TlQia1BysTfHU577BwAI7wmqIqzdjd6cnpto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214696; c=relaxed/simple;
	bh=YFRykaqgq0p0tx19utSc/mGsGV5tKxzrwjPAi8InNRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqvHKPFTYtpiJnb3jJA3SQr1YvBFVn3IKeHCZvk0+jhgF7uJNrxwgym2iSbZdtNCjeoSPl6U1/4o7JQJufHxGcueIY2kIM3XiKo6//NmTHU9/WEWFivK1XTjllOqlGXuwintEYPNVpGNNV7/mJbgnnSK54Dje2hKCsYuvYG1Ia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lquLDqNr; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lquLDqNr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=zOjzfqdILjuppl54PXVImfO724apQlMc35Rh9swFQtI=;
	b=lquLDqNrxjs/oh67RR47nwkcUk+2lC26bv6HU961SpNC0WcZe78XyIgchg3JLP
	m1/3KSAOpapWUgRDj1ruCk0b7FuLyAFUfBE1cZKUqn/2KbJshJaTYZ5ztnacGdKE
	mmgsBua5CNJFwk/tRUgMDqQpHjnjsj4nsuQZdSayah+vE=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3mmoQZ_1pWkbJCw--.142S2;
	Fri, 08 May 2026 12:31:14 +0800 (CST)
Message-ID: <10503cf8-2f2c-4a8d-8c24-f1056859edd8@163.com>
Date: Fri, 8 May 2026 12:31:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: sashiko@lists.linux.dev, Manikandan K Pillai <mpillai@cadence.com>
Cc: linux-pci@vger.kernel.org
References: <20260508034101.1910036-3-18255117159@163.com>
 <20260508041956.C8F10C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260508041956.C8F10C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgC3mmoQZ_1pWkbJCw--.142S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrWkKF18Kw1xGry5XF1xGrg_yoWxur4xpa
	9rGFyfCF4xXFWYv3Z2v3WUXF1fJF93Aa47Gw4vkw17uFnxuryUuFnrKFW5GrW3WrWqqr12
	v3Z8tasrWF43AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYNtsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBK3W2n9ZxK4ZAAA3H



On 5/8/26 12:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] PCIE_CADENCE_DEBUGFS tristate configuration causes build failure and module linkage issues.
> - [High] Race condition in debugfs deinitialization leads to unprotected hardware access.
> - [High] Missing Runtime PM reference in debugfs read handler causes system crash.
> - [Medium] Missing link teardown in `cdns_pcie_hpa_host_disable`.
> - [Medium] Incorrect bitmask `CDNS_PCIE_LGA_LTSSM_STATUS_MASK` truncates LTSSM states.
> --
> 
> commit b032928b3c42715d7bb97e0bd26a99d252cd98d9
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: cadence: Add debugfs property to provide LTSSM status of the PCIe link
> 
> Add the debugfs property to provide a view of the current link's LTSSM
> status from the Root Port device.
> 
>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
>> index 9e651d5459735..cb010bc97aad3 100644
>> --- a/drivers/pci/controller/cadence/Kconfig
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>>   config PCIE_CADENCE
>>   	tristate
>>   
>> +config PCIE_CADENCE_DEBUGFS
>> +	tristate "Cadence PCIe debugfs entries"
> 
> Could this Kconfig option be changed to a bool?

This is the reminder from Mani that I made the necessary modifications 
for, because the Cadence PCIe driver is a support module.

> 
> When configured as a module (=m), Kbuild defines
> CONFIG_PCIE_CADENCE_DEBUGFS_MODULE, not CONFIG_PCIE_CADENCE_DEBUGFS. As a
> result, the preprocessor check in pcie-cadence.h evaluates to false, causing
> the header to declare empty static inline stubs. When pcie-cadence-debugfs.c
> defines the non-static versions, the build fails with a function redefinition
> error.
> 
> Furthermore, changing the check to IS_ENABLED(CONFIG_PCIE_CADENCE_DEBUGFS)
> would cause linkage errors if the core drivers are built-in while the debugfs
> feature is a module, since built-in code cannot call module functions.
> 
> [ ... ]
> 
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> new file mode 100644
>> index 0000000000000..a4f0c4f6f98f4
>> --- /dev/null
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> @@ -0,0 +1,208 @@
> [ ... ]
>> +#define CDNS_PCIE_LGA_LTSSM_STATUS_MASK	GENMASK(29, 24)
> 
> Does this mask need to be extended to cover all possible states?
> 
> This mask covers only 6 bits, allowing it to extract values up to 63.
> However, the cdns_pcie_ltssm enum defines states up to 127. If the
> hardware enters a state 64 or higher, FIELD_GET will silently truncate
> the value, making state 65 appear as state 1.

Hi Manikandan,

I have already confirmed this with Manikandan. You can ask Manikandan to 
confirm it again.


> 
> [ ... ]
>> +static int ltssm_status_show(struct seq_file *s, void *v)
>> +{
>> +	struct cdns_pcie *pci = s->private;
>> +	enum cdns_pcie_ltssm ltssm;
>> +	u32 reg;
>> +
>> +	if (pci->is_hpa) {
>> +		reg = cdns_pcie_hpa_readl(pci, REG_BANK_IP_REG,
>> +					CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
>> +		ltssm = FIELD_GET(CDNS_PCIE_HPA_LTSSM_STATUS_MASK, reg);
>> +	} else {
>> +		reg = cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
>> +		ltssm = FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, reg);
>> +	}
> 
> Is a runtime PM reference required here before accessing the hardware?
> 
> Since the driver supports power management, the controller might be in a
> low-power, clock-gated state when this debugfs file is read. Reading the
> registers without calling pm_runtime_get_sync() first could cause a bus fault
> and crash the system.
> 
> [ ... ]
> 
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> index c0e1194a936b3..38a0157b60dc7 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -659,6 +659,7 @@ void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
>>   	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
>>   			      SZ_128K);
>>   	pci_epc_mem_exit(epc);
>> +	cdns_pcie_debugfs_deinit(&ep->pcie);
>>   }
> 
> Should cdns_pcie_debugfs_deinit() be called earlier in the teardown process?

Will change.

> 
> If a userspace process is currently reading the debugfs file while the module
> is being removed, ltssm_status_show() could attempt to read registers after
> the hardware has been deactivated, potentially resulting in a bus fault.
> Removing the debugfs entries first ensures no new reads can begin while the
> hardware is shut down.
> 
> [ ... ]
> 
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> index 0f540bed58e88..8bf7cc106413b 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> @@ -309,6 +309,18 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
>>   }
>>   EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);
>>   
>> +void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
>> +{
>> +	struct pci_host_bridge *bridge;
>> +
>> +	bridge = pci_host_bridge_from_priv(rc);
>> +	pci_stop_root_bus(bridge->bus);
>> +	pci_remove_root_bus(bridge->bus);
>> +
> 
> Is it necessary to stop the PCIe link here?
The HPA driver does not yet provide the "stop the PCIe link" function. 
More will be added later.

> 
> The setup path explicitly starts the link with cdns_pcie_start_link(),
> but this teardown function omits stopping it or disabling PTM responses.
> Leaving the link active after the bus is unregistered could lead to
> spurious interrupts or unhandled DMA requests.
> 
>> +	cdns_pcie_debugfs_deinit(&rc->pcie);
> 
> Similar to the endpoint path, should debugfs teardown happen before
> the hardware is disabled to avoid concurrent access faults?

Will change.

> 
>> +}
> 
> [ ... ]
> 
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 0bc9e6e90e0e0..873d496c440f0 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -370,6 +370,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
>>   
>>   	cdns_pcie_host_deinit(rc);
>>   	cdns_pcie_host_link_disable(rc);
>> +	cdns_pcie_debugfs_deinit(&rc->pcie);
>>   }
> 
> Should this debugfs teardown be moved to the beginning of the function
> for the same reason mentioned above?


Will change.


Best regards,
Hans
> 

