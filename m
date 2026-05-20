Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6E3EF0DC;
	Wed, 20 May 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288919; cv=none; b=fwoST5BZHznKx3xoIGyRa3tGn6kEiyHt8qrEtOebJllTqNoLB0XklTyTgQ0CEJzrrxNTooD7vi7Mjmio8k3DI0R9S26tK/oRoEdz04sryHqHYPw7qlHCWWdNypteQSt+6cUWV88fpij720sxyuOnXXOVwf6u1OneHFzXSGyZloY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288919; c=relaxed/simple;
	bh=mPhlcHFvCpO2AzTCdnxpHt5Nq5zeL9SwOfrxApzRgnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFbPlx9GS4iLCvMaGAQlPhKKmOZ7kWEzZmeYJvCysjV0QUlDvhvKBsGeHXSzEPscQ6oUF610ZjXle5gNDgieb4rJASE6boYnXo2dB6G0GH4NKdxcAQEqyGOWjgbkEw3//95mabmwgvaACQ/KfeTsuP8q+0f3Qn8LAMaIrt3ulhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U+EHOHiR; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U+EHOHiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Ta7ysL3hvmydWrMVmPTW46rDbrX7lZIBRkcPb5zNuao=;
	b=U+EHOHiRhpU6zwBNeo1EtPdCQqMYW8F9RerrKKInWUSUgZ3mku+aNs3FlIJ8y6
	sY7J8Ran5wjdZuCAjpLd3uJSmqHj4WID8qdUkSb8tp4Aq5uCk5t0mtrBFhtxCDnk
	ebFGk8otf/BZt8Ogiqxxjpw23l6DXrKxpO/vlne1x1rHQ=
Received: from [IPV6:240e:b8f:91b3:d000:e944:1037:cb1d:708] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXDGAWyw1qlEHkCQ--.3498S2;
	Wed, 20 May 2026 22:54:14 +0800 (CST)
Message-ID: <5a771c43-bbba-49ce-9df8-fdd618289334@163.com>
Date: Wed, 20 May 2026 22:54:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM status
To: Aksh Garg <a-garg7@ti.com>, bhelgaas@google.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org
Cc: robh@kernel.org, mpillai@cadence.com, s-vadapalli@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519123609.1595280-1-18255117159@163.com>
 <20260519123609.1595280-3-18255117159@163.com>
 <d9d4aa30-8d30-4025-abde-0325e102fd8d@ti.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <d9d4aa30-8d30-4025-abde-0325e102fd8d@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXDGAWyw1qlEHkCQ--.3498S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF15urWDtw45KryxCr43trb_yoW7XrWDpa
	yDGF4fCa1xXay3Za93A3WUXF13tFn3Aa4UG3929347XFnxur1DJFnrKFW5KFZxGr4vgryx
	Zas8tasrGr4ayrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR58nrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xbVeWoNyxY7QgAA3S



On 5/20/26 15:26, Aksh Garg wrote:
> 
> 
> On 19/05/26 18:06, Hans Zhang wrote:
>> Add debugfs support for HPA-based Cadence PCIe controllers. A new file
>> 'ltssm_status' is created under debugfs, allowing users to read the
>> current LTSSM state as a string and raw value.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>>   drivers/pci/controller/cadence/Kconfig        |   9 +
>>   drivers/pci/controller/cadence/Makefile       |   1 +
>>   drivers/pci/controller/cadence/pci-sky1.c     |   4 +
>>   .../controller/cadence/pcie-cadence-debugfs.c | 208 ++++++++++++++++++
>>   .../cadence/pcie-cadence-host-hpa.c           |  19 +-
>>   drivers/pci/controller/cadence/pcie-cadence.h | 153 +++++++++++++
>>   7 files changed, 398 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence- 
>> debugfs.c
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/ 
>> Documentation/ABI/testing/debugfs-cdns-pcie
>> new file mode 100644
>> index 000000000000..c1104e28e4ee
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
>> @@ -0,0 +1,5 @@
>> +What:        /sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
>> +Date:        March 2026
>> +Contact:    Hans Zhang <18255117159@163.com>
>> +Description:    (RO) Read will return the current PCIe LTSSM state in 
>> both
>> +        string and raw value.
>> \ No newline at end of file
>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/ 
>> controller/cadence/Kconfig
>> index 9e651d545973..cb010bc97aad 100644
>> --- a/drivers/pci/controller/cadence/Kconfig
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>>   config PCIE_CADENCE
>>       tristate
>> +config PCIE_CADENCE_DEBUGFS
>> +    tristate "Cadence PCIe debugfs entries"
>> +    depends on DEBUG_FS
>> +    depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
>> +    help
>> +      Say Y here to enable debugfs entries for the PCIe controller. 
>> These
>> +      entries provide various debug features related to the 
>> controller and
>> +      the LTSSM status of link can be displayed.
>> +
>>   config PCIE_CADENCE_HOST
>>       tristate
>>       depends on OF
> 
> Sashiko pointed the compilation issues when this is build as a module.
> The linkage issue needs to be resolved if we want this as a module.
> Also, if we build it as m, it would requires MODULE_LICENSE() and 
> MODULE_DESCRIPTION().

Hi Aksh,

Will add.


> 
>> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/ 
>> controller/cadence/Makefile
>> index b8ec1cecfaa8..2cdc4617e0c2 100644
>> --- a/drivers/pci/controller/cadence/Makefile
>> +++ b/drivers/pci/controller/cadence/Makefile
>> @@ -4,6 +4,7 @@ pcie-cadence-host-mod-y := pcie-cadence-host-common.o 
>> pcie-cadence-host.o pcie-c
>>   pcie-cadence-ep-mod-y := pcie-cadence-ep.o
>>   obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
>> +obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
>>   obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
>>   obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>>   obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/ 
>> controller/cadence/pci-sky1.c
>> index e1f4a98e2ab6..b8632f1d3156 100644
>> --- a/drivers/pci/controller/cadence/pci-sky1.c
>> +++ b/drivers/pci/controller/cadence/pci-sky1.c
>> @@ -221,6 +221,10 @@ MODULE_DEVICE_TABLE(of, of_sky1_pcie_match);
> 
> [ ... ]
> 
>>   /**
>> @@ -447,6 +583,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc);
>>   void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>>                      int where);
>>   int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc);
>> +void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc);
>>   #else
>>   static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>>   {
>> @@ -472,6 +609,10 @@ static inline void cdns_pcie_host_disable(struct 
>> cdns_pcie_rc *rc)
>>   {
>>   }
>> +static inline void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
>> +{
>> +}
>> +
>>   static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, 
>> unsigned int devfn,
>>                            int where)
>>   {
>> @@ -535,4 +676,16 @@ bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie);
>>   extern const struct dev_pm_ops cdns_pcie_pm_ops;
>> +#ifdef CONFIG_PCIE_CADENCE_DEBUGFS
> 
> Use "#if IS_ENABLED(CONFIG_PCIE_CADENCE_DEBUGFS)" to resolve the 
> compilation error when building as a module.
> 

Will change.

Best regards,
Hans

>> +void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci);
>> +void cdns_pcie_debugfs_init(struct cdns_pcie *pci);
>> +#else
>> +static inline void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
>> +{
>> +}
>> +static inline void cdns_pcie_debugfs_init(struct cdns_pcie *pci)
>> +{
>> +}
>> +#endif
>> +
>>   #endif /* _PCIE_CADENCE_H */

