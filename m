Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51D3A3E67;
	Thu,  9 Jul 2026 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589423; cv=none; b=A+jRkuJh2KJ/UcKpybOGSlr2wSmuzhm7Q2DMIdXIndaOAlw5uHh56SXOOkmOQSDpm2z7+PqlA1xjIQE1z5HOIzg0UeAaIKZJBMaviRuDIxLCb+Cq2m9rImroNop+o0BQcRsgaW1mHcOmPgxDZgAyC1hP1NgRXY5fmNbgEBzDAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589423; c=relaxed/simple;
	bh=oJBbJT+aTCM3rgsyYxi4GEhwmjR7M9BZmvWNT3v//vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C0Mk0TRPjSlCYtJJd5Kue2IGY0o7NBBJstRK5VrPECGY+xZEWuWFple/aBURlFd1hGwHnQzx+typV8sn4utbnYMjCOG1krur0qq5BLhBlfYjvXeRtyFlY0x9eDfy46jrFKzh1coQGUyR/rZNJPnLFk6LSZmqLRhHPVkbtGL0apk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Bim5XDca; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Bim5XDca"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9tQIWoo8Q796KjYQ7NSvfAQQHMHDgaB267iun+Y/jEg=;
	b=Bim5XDcaznfLyjvavRefwRLrqfQNWT5vaTLxYwUZwS7VReJ4z6zfheDtZgkGs7tQnjMGxSBu+
	JpKoul/IWgz9tGgQHL6891GsLBEi0nOjuRI55ZKo6H7s6bNrWQYIVbJxYegl/V0NoyeB69gKrsi
	YmsDZFVzqA607G8o8CdZlgU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gwqFk2wGRz1K9XX;
	Thu,  9 Jul 2026 17:20:58 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id CD97F40563;
	Thu,  9 Jul 2026 17:30:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 17:30:11 +0800
Message-ID: <f94cd5b0-0560-48ac-a9b9-1b084a54ffa0@huawei.com>
Date: Thu, 9 Jul 2026 17:30:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 06/18] PCI/TPH: Expose the enabled TPH requester type
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-7-fengchengwen@huawei.com>
 <20260708173315.1d89a131@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708173315.1d89a131@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/9/2026 7:33 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:12 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> From: Zhiping Zhang <zhipingz@meta.com>
>>
>> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
>> requester mode without reaching into pci_dev internals.
> 
> This has no callers in your series, why did you include it?  Just for
> the context diff?  Don't do that.

Thanks for pointing out this unused helper patch. I'll explain its background
and remove it from v20 series as requested.

Originally, before refactoring pcie_tph_set_st_entry() to internally check
TPH enable state, the VFIO TPH_ST logic required manually reading tph_req_type
to skip hardware writes when TPH was disabled. That's why this wrapper was
introduced.

In current v19, because pcie_tph_set_st_entry() already embeds the internal check
for valid tph_req_type, so there are no callers of pcie_tph_enabled_req_type()
within my patch set anymore.

Thanks

> 
> It seems dubious even in Zhiping's series, I don't know why we need a
> wrapper to abstract this struct field.  Thanks,
> 
> Alex
> 
>>
>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/pci/tph.c       | 12 ++++++++++++
>>  include/linux/pci-tph.h |  3 +++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index 70273c44e8fd..ea777cc33ae6 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
>> @@ -479,6 +479,18 @@ int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended)
>>  }
>>  EXPORT_SYMBOL(pcie_enable_tph_explicit);
>>  
>> +/**
>> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester type
>> + * @pdev: PCI device to query
>> + *
>> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_TPH.
>> + */
>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
>> +{
>> +	return pdev->tph_req_type;
>> +}
>> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
>> +
>>  void pci_restore_tph_state(struct pci_dev *pdev)
>>  {
>>  	struct pci_cap_saved_state *save_state;
>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>> index 1a508b3d511f..e4f7045fc152 100644
>> --- a/include/linux/pci-tph.h
>> +++ b/include/linux/pci-tph.h
>> @@ -33,6 +33,7 @@ int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
>>  void pcie_disable_tph(struct pci_dev *pdev);
>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>>  int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>>  #else
>> @@ -47,6 +48,8 @@ static inline int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
>>  				enum tph_mem_type mem_type,
>>  				bool extended, unsigned int cpu, u16 *tag)
>>  { return -EINVAL; }
>> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
>> +{ return PCI_TPH_REQ_DISABLE; }
>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>>  { return -EINVAL; }
> 

