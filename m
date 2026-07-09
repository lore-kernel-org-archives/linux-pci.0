Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF95402420;
	Thu,  9 Jul 2026 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588981; cv=none; b=HNCIj3Cy9ycwKOjUfQYidgNsKN4giXGPcmcTNq0479wFiivE6D3ADoB1si9H5p7HtI5VjPRNOkpksFhQIaT7VYYjeqTavt6z00kJtBdhr+0UXYD2F+dRc5Flcy8EvHlDzXv6KfQhVjeso+PGmMLdFOyPG53x2T7u9osn0kn6t0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588981; c=relaxed/simple;
	bh=4BKrVlttkq1sYXzKjTk+n29ZBCRS3n+YZE8Vx2GbDUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dp2SPIWL2TWr83IqbSMVQMDuuy8qg77FeclME1gu9mmHqRM8KNQn1aPrTvjaD9PkP47IYQ1fgOMy6r7gVNzb6zmXc3e5FnS1x/GXVu63ZOJ24HIEiCwKPglrOL10AUTE6GhMPJJNRV3XDnJj8rI0/OpUXNnggCqNu1DY6l3Z/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mmQ4Gsu2; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mmQ4Gsu2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hW76NcHfCAc863bHQPVN6YnN2F7Apy3l1MFHbVdl0bg=;
	b=mmQ4Gsu28+zFLngOBndMOzb5XtGkHOp39lyyUUZA5B0DUmwI4DGSRiZheUgdokQMbnTLG2KzY
	39OWkWbu+vqjpohBHcjscv6dbPYncugU/zLUSbbjiGWt+JCRB8ZtlwGjEoNL/uaT1DSzw+jX58B
	z4dwNKgHU5IIf0fnLC7nsrg=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gwq571LDkz1prjr;
	Thu,  9 Jul 2026 17:13:31 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id CC9364057D;
	Thu,  9 Jul 2026 17:22:47 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 17:22:47 +0800
Message-ID: <7993c211-7af2-492d-adaf-cc6ec3afc67d@huawei.com>
Date: Thu, 9 Jul 2026 17:22:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 04/18] PCI/TPH: Refactor pcie_enable_tph & add
 explicit requester variant
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-5-fengchengwen@huawei.com>
 <20260708173325.599bc892@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708173325.599bc892@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/9/2026 7:33 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:10 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Refactor pcie_enable_tph implementation: extract core logic into static
>> internal enable_tph() helper accepting explicit requester type.
>>
>> - Preserve original pcie_enable_tph() unchanged as auto wrapper; it
>>   auto-selects EXT/standard TPH requester per device capability, existing
>>   bnxt/mlx5 callers require zero modification.
>> - Add exported pcie_enable_tph_explicit() with bool 'extended' parameter
>>   for explicit STD/EXT selection, used by upcoming VFIO TPH support.
>>
>> Input validation for EXT_TPH availability is retained inside helper to
>> reject invalid explicit EXT request if hardware does not support extended
>> requester.
> 
> I'll leave final judgment on the APi to Bjorn, but I'd tend towards
> defining tph_mode and tph_req_type as enums, store the max available
> tph_req_type on the pci_dev.tph_max_type, and have the base function
> take exactly those enums as args, get rid of the bool wrapper.  Then the
> existing function just becomes:
> 
> int pcie_enable_tph(struct pci_dev *pdev, int mode)
> {
> 	return pcie_enable_tph_type(pdev, (enum tph_mode)mode,
> 				    pdev->tph_max_type);
> }
> 
> (Given the 2 existing callers, this could also be easily changed to
> take enum tph_mode as the arg as well)
> 
> This might also disambiguate how this series conflates tph_cap to mean
> TPH capability is not present or not available to instead retain
> tph_cap as simply the offset of the capability and (tph_max_type ==
> PCI_TPH_REQ_DISABLE) means it's not available.
> 
> Validation in the base function is also simplified:
> 
> 	if (tph_req_type == PCI_TPH_REQ_DISABLE ||
> 	    tph_req_type > pdev->tph_max_type)
> 		return -EINVAL;
> 
> Same comment for patch 5, expose the base function as "_type" with the
> enum tph_req_type (the precedent is already there for enum
> tph_mem_type).  The wrapper for the existing interface is the same as
> you have, the base function adds the same test as above, modulo
> s/tph_max_type/tph_req_type/.  Thanks,

Thanks for your suggestion on typed enum refactoring for the TPH enable API.
After checking headers, two groups of symbols already exist in pci_regs.h:
- PCI_TPH_ST_NS_MODE, PCI_TPH_ST_IV_MODE, PCI_TPH_ST_DS_MODE
- PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY, PCI_TPH_REQ_EXT_TPH

To avoid duplicate local enum definitions and align with PCI register headers,
I will skip adding custom enums and use u8 for mode/req_type parameters.
Comments will restrict valid inputs to the standard PCI macros.

I will adjust the TPH enable APIs for v20 with these changes:
1. Change original pcie_enable_tph() from int mode to u8 mode;
2. Add unified base entry pcie_enable_tph_type(pdev, u8 mode, u8 req_type);
3. Rework explicit entry to pass u8 req_type, drop ambiguous bool extended;
4. Add tph_max_type to struct pci_dev for negotiated max requester type;
5. Unify validation check as you proposed:
   if (req_type == PCI_TPH_REQ_DISABLE || req_type > pdev->tph_max_type)
       return -EINVAL;
6. Retain original pcie_enable_tph() as thin compat wrapper filling tph_max_type,
   so existing bnxt/mlx5 callers need zero source code modification.

Capability tracking will also be disambiguated per your feedback:
tph_cap stores only TPH config space offset, tph_max_type == DISABLE means
TPH is unavailable after endpoint and root port topology negotiation.

Thanks

> 
> Alex
>  
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/pci/tph.c       | 68 +++++++++++++++++++++++++++++------------
>>  include/linux/pci-tph.h |  4 +++
>>  2 files changed, 52 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index 4097787ea98a..c22eb7f4b0bd 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
>> @@ -363,23 +363,7 @@ void pcie_disable_tph(struct pci_dev *pdev)
>>  }
>>  EXPORT_SYMBOL(pcie_disable_tph);
>>  
>> -/**
>> - * pcie_enable_tph - Enable TPH support for device using a specific ST mode
>> - * @pdev: PCI device
>> - * @mode: ST mode to enable. Current supported modes include:
>> - *
>> - *   - PCI_TPH_ST_NS_MODE: NO ST Mode
>> - *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
>> - *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
>> - *
>> - * Check whether the mode is actually supported by the device before enabling
>> - * and return an error if not. Additionally determine what types of requests,
>> - * TPH or extended TPH, can be issued by the device based on its TPH requester
>> - * capability and the Root Port's completer capability.
>> - *
>> - * Return: 0 on success, otherwise negative value (-errno)
>> - */
>> -int pcie_enable_tph(struct pci_dev *pdev, int mode)
>> +static int enable_tph(struct pci_dev *pdev, int mode, u8 req_type)
>>  {
>>  	u32 reg;
>>  	u8 dev_modes;
>> @@ -400,10 +384,11 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>>  	if (!((1 << mode) & dev_modes))
>>  		return -EINVAL;
>>  
>> -	pdev->tph_mode = mode;
>> +	if (req_type == PCI_TPH_REQ_EXT_TPH && !pdev->tph_ext_support)
>> +		return -EINVAL;
>>  
>> -	pdev->tph_req_type = pdev->tph_ext_support ? PCI_TPH_REQ_EXT_TPH :
>> -						     PCI_TPH_REQ_TPH_ONLY;
>> +	pdev->tph_mode = mode;
>> +	pdev->tph_req_type = req_type;
>>  
>>  	/* Write them into TPH control register */
>>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
>> @@ -417,8 +402,51 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>>  
>>  	return 0;
>>  }
>> +
>> +/**
>> + * pcie_enable_tph - Enable TPH support for device using a specific ST mode
>> + * @pdev: PCI device
>> + * @mode: ST mode to enable. Current supported modes include:
>> + *
>> + *   - PCI_TPH_ST_NS_MODE: NO ST Mode
>> + *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
>> + *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
>> + *
>> + * Check whether the mode is actually supported by the device before enabling
>> + * and return an error if not. Additionally determine what types of requests,
>> + * TPH or extended TPH, can be issued by the device based on its TPH requester
>> + * capability and the Root Port's completer capability.
>> + *
>> + * Return: 0 on success, otherwise negative value (-errno)
>> + */
>> +int pcie_enable_tph(struct pci_dev *pdev, int mode)
>> +{
>> +	u8 req_type = pdev->tph_ext_support ? PCI_TPH_REQ_EXT_TPH :
>> +					      PCI_TPH_REQ_TPH_ONLY;
>> +	return enable_tph(pdev, mode, req_type);
>> +}
>>  EXPORT_SYMBOL(pcie_enable_tph);
>>  
>> +/**
>> + * pcie_enable_tph_explicit - Enable TPH with explicit requester selection
>> + * @pdev: PCI device to operate
>> + * @mode: ST table operating mode (NS/IV/DS)
>> + * @extended: true = EXT_TPH, false = standard TPH only
>> + *
>> + * Unlike auto-detecting pcie_enable_tph(), caller selects requester type
>> + * manually instead of hardware auto-selection. Rejects EXT_TPH request
>> + * if device lacks extended requester capability.
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + */
>> +int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended)
>> +{
>> +	u8 req_type = extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
>> +
>> +	return enable_tph(pdev, mode, req_type);
>> +}
>> +EXPORT_SYMBOL(pcie_enable_tph_explicit);
>> +
>>  void pci_restore_tph_state(struct pci_dev *pdev)
>>  {
>>  	struct pci_cap_saved_state *save_state;
>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>> index 6f02b020d7d7..ca0faa98afac 100644
>> --- a/include/linux/pci-tph.h
>> +++ b/include/linux/pci-tph.h
>> @@ -29,6 +29,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>  			unsigned int cpu, u16 *tag);
>>  void pcie_disable_tph(struct pci_dev *pdev);
>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>> +int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>>  #else
>> @@ -42,6 +43,9 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>>  { return -EINVAL; }
>> +static inline int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode,
>> +					   bool extended)
>> +{ return -EINVAL; }
>>  static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>>  { return 0; }
>>  static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> 

