Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BD18C332;
	Fri,  3 Jul 2026 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040259; cv=none; b=uo596LltdDN3Yn0lrzSYlQYL8nfpnwEf6MjWVR0wiFEWopXgn2E7KL9IM/2OS+eeUHfOAXaevTVjhHCrvff7vGSTB87GW27IC6MaMIcInvI2V3b4enktAeGlb7BHb2Hs68upQFtmPuBXUK4XrDtOSX4FCQUc4qPvapudREz+LNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040259; c=relaxed/simple;
	bh=anU9WmesAjIzYDWQI/g0TkBlK6PdSibUj/gMkfpR5xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ox0LDmYEprtWR0CrrgnEqWwk0mKueljjxCwonj2voEtOkm454o1AW1mMb8vpj+wzf/HbsgGwHSN0xMXvvg4Y9L2gqa5Srmgn5PEn9EplN5Xp2ANiqPHbIaHt3CodebQY8GqkEZ1g7rwj220Frg9YKVqwR2dPkaCKJNVIILK3jC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HelpvoeQ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HelpvoeQ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=noup+BhUAR2f+XZSC9JjTol15GqNOByRfbTgvglc/6k=;
	b=HelpvoeQS/i5BoYavPBpIfgj24R0rlY8nqQsC6Ty/iC01BD8VWTiq4NSfBPSGsdH0+jVKYyNj
	uEUhTiPFgqt5Dw5iAjOtn5PX/BM9CJ5aSlLOAy8+Eslg5T0FcOijOU6YK47iRf3CarzcV+hCs46
	+9JVc/Mt/GgGaURkqLDR/tI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4grvn53WnYz1T4vD;
	Fri,  3 Jul 2026 08:31:05 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E2064058E;
	Fri,  3 Jul 2026 08:39:58 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 08:39:58 +0800
Message-ID: <40007c54-e9b1-4ce6-b8ce-39b8ed78d644@huawei.com>
Date: Fri, 3 Jul 2026 08:39:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 07/18] PCI/TPH: Add pcie_tph_supported() helper to
 check TPH capability attributes
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-8-fengchengwen@huawei.com>
 <20260702125357.63EEB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260702125357.63EEB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/2/2026 8:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] pcie_tph_supported() does not check the system-wide pci_tph_disabled flag, leading to falsely reporting TPH support when it has been explicitly disabled by the administrator.

Thanks for the review note. I'd prefer not to add pci_tph_disabled inside
pcie_tph_supported() for the following reasons:

- The helper's sole purpose is to report hardware/topology TPH capability,
  while pci_tph_disabled is an administrative gate only applied at TPH activation
  entry points (pcie_enable_tph / pcie_enable_tph_explicit). All attempts to
  turn on TPH are already blocked when notph is set, so there is no bypass risk.
- Adding the global flag here would require replicating the check across all
  TPH query helpers for consistency, which adds redundant overhead.
- Distinguishing hardware presence vs admin disable state is useful visibility
  for userspace; hiding the capability entirely removes this distinction.

All TPH activation paths already enforce the global disable, so the reporting
mismatch does not create functional or security issues. Let me know if others
disagree with this separation of semantics.

Thanks

> --
> 
> commit 089d399dcdf1ae5d6be4d557f772bf15c0d7d461
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> PCI/TPH: Add pcie_tph_supported() helper to check TPH capability attributes
> 
> Add new helper pcie_tph_supported() to check if a device has a valid TPH
> capability or hardware Extended TPH support. This helper is intended for
> follow-up VFIO TPH virtualization patches to uniformly query basic TPH
> existence and Extended TPH capability.
> 
>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index ea777cc33ae61..c080cf5401a31 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
> 
> [ ... ]
> 
>> @@ -596,3 +596,22 @@ void pci_tph_init(struct pci_dev *pdev)
>>  	save_size = sizeof(u32) + num_entries * sizeof(u16);
>>  	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
>>  }
>> +
>> +/**
>> + * pcie_tph_supported - Check TPH capability attribute
>> + * @pdev: PCI device to query
>> + * @want_ext: false - check TPH cap exists; true - check EXT_TPH support
>> + *
>> + * Return: true on matched condition, false otherwise
>> + */
>> +bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
>> +{
>> +	if (!pdev->tph_cap)
>> +		return false;
> 
> [Severity: Medium]
> Does this introduce a regression by failing to check the system-wide
> pci_tph_disabled flag?
> 
> Since pci_tph_disabled is static to drivers/pci/tph.c, external callers like
> VFIO have no other way to know if TPH has been administratively disabled. If
> the host is booted with the 'notph' kernel parameter, this will still return
> true.
> 
> If this incorrectly advertises the TPH capability to a guest VM via VFIO,
> could it lead to an inconsistent state when the guest attempts to configure it,
> since other functions honor the pci_tph_disabled flag?
> 
>> +
>> +	if (!want_ext)
>> +		return true;
>> +
>> +	return pdev->tph_ext_support;
>> +}
>> +EXPORT_SYMBOL(pcie_tph_supported);
> 

