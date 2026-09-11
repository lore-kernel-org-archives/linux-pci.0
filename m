Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61547DFB0
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134532; cv=none; b=T6mI1pELiB6YjqmlORZOiE4PpvUvNxPGnsgGPXQxRfLILopQx2ZpfY4Pp3gLq1YrUlibDK9kAVQlXWfjQ+N9MpQasGB4eTyrXinn0JLa4CttNrZJKW+zTxpR9LsWtq4iaPOcWTa0jgX3ldNJFCcP0CxZLDfgrrviyr6HzV9sVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134532; c=relaxed/simple;
	bh=9apFp5UnuDXB3ohJr9fcXLx8hbtak23J3iGAHP8ZFeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChsD9nLgTRsxWntSy/QJ+wKKrJpIMSYmUfpqiAt/JAlZ88RUOwWIiNksBJbq79umeebXNae7tsRhhol7ZzB+PzIesBsvDORR/qedCZ0Z5OSa02MfU/fEmqMfQhjTYlMFqw3rafhmnp08mHmq0ln+SfryI8oX9V1Hv7wDP/A5zFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FUfCq0Cu; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FUfCq0Cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=zsdqYu79SdDj0gicUYOLPKVlZ/Oun8ugKeMddZdiBng=;
	b=FUfCq0Cu2gKEeCD74R2bFW4nf+9fGbuprY3qvjN3rwdMfw9qCojAJGIy8Vfanv
	DjHLlXjMQvUo+rSyVm2qxYu52Aw/u1JXhannF5Ep0vzhMcCkOE8ngDjErkFgrRY3
	vO3pbsmRE5qsAAHrjzvquSO7LKVeLROExuYtdMbFhTCVE=
Received: from [IPV6:240e:b8f:91b3:d000:8f8f:b76e:3756:1454] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3J+WQBqRqWFdKAA--.50611S2;
	Fri, 11 Sep 2026 21:48:01 +0800 (CST)
Message-ID: <e6600201-9743-44a4-aa1c-f03fc11c09de@163.com>
Date: Fri, 11 Sep 2026 21:48:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] PCI: dwc: Remove redundant MPS configuration
To: sashiko-reviews@lists.linux.dev
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 linux-pci@vger.kernel.org
References: <20260911132145.211380-1-18255117159@163.com>
 <20260911132145.211380-3-18255117159@163.com>
 <20260911133411.3B4521F00893@smtp.kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260911133411.3B4521F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3J+WQBqRqWFdKAA--.50611S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurWUWw4fuw43Zry5Kw1Dtrb_yoWrCw4DpF
	W5XF45CF45Jr45Wr1qkan5CFWxta93CF13JFnxG3ySvasIyFnrXa42yay5CayxXr4DK3Wv
	vrWDKryFv3WYyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziWlkfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xFpDWqkBpH40wAA3s



On 9/11/26 21:34, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Low] Unused macros PCIE_CAP_MAX_PAYLOAD_SIZE and MAX_PAYLOAD_SIZE left behind after removing the MPS configuration function.
> - [Low] Misleading function name and warning message for MRRS calculation after removing MPS configuration.
> 
> Pre-existing issues:
> - [High] 32-bit read-modify-write of PCI_EXP_DEVCTL inadvertently clears W1C error bits in PCI_EXP_DEVSTA.
> --
> 
> commit 3ff79063d97cb0f265efaab65bab69ff2c512a3d
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: dwc: Remove redundant MPS configuration
> 
> The Meson PCIe controller driver manually configures maximum payload
> size (MPS) through meson_set_max_payload, duplicating functionality now
> centralized in the PCI core.  Deprecating redundant code simplifies the
> driver and aligns it with the consolidated MPS management strategy,
> improving long-term maintainability.
> 
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>> index 8559d132dcde8..8c176f78953e9 100644
>> --- a/drivers/pci/controller/dwc/pci-meson.c
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -273,22 +273,6 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
>>   	return fls(size) - 8;
>>   }
> 
> [Severity: Low]
> With the removal of the payload configuration function, this helper is now
> exclusively called by meson_set_max_rd_req_size() to calculate the Max Read
> Request Size (MRRS).

Hi,

Will add 0003 patch to rename function name.
s/meson_size_to_payload/meson_size_to_mrrs/

> 
> Does this function name and its internal log message:
> 
> 	dev_warn(dev, "payload size %d, set to default 256\n", size);
> 
> need to be updated to reflect that it is calculating MRRS? Leaving it as-is
> might cause confusion for future maintainers.
> 
>>   
>> -static void meson_set_max_payload(struct meson_pcie *mp, int size)
>> -{
>> -	struct dw_pcie *pci = &mp->pci;
>> -	u32 val;
>> -	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> -	int max_payload_size = meson_size_to_payload(mp, size);
>> -
>> -	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
>> -	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
>> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
>> -
>> -	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
>> -	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
> 
> [Severity: Low]
> Should the definition of PCIE_CAP_MAX_PAYLOAD_SIZE be removed as well? Since
> it is no longer used after removing this function, it appears to be dead
> code now.

The next version will remove:

#define PCIE_CAP_MAX_PAYLOAD_SIZE(x)	((x) << 5)
#define MAX_PAYLOAD_SIZE		256


Best regards,
Hans

> 
>> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
>> -}
>> -
>>   static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
>>   {
>>   	struct dw_pcie *pci = &mp->pci;
> 
> [Severity: High]
> This is a pre-existing issue, but does meson_set_max_rd_req_size()
> inadvertently clear W1C error bits in PCI_EXP_DEVSTA?
> 
> This function performs a 32-bit read-modify-write on PCI_EXP_DEVCTL:
> 
> 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> 	val &= ~PCI_EXP_DEVCTL_READRQ;
> 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> 
> Because this 32-bit access covers both the 16-bit PCI_EXP_DEVCTL and the
> adjacent 16-bit PCI_EXP_DEVSTA, it fetches both. PCI_EXP_DEVSTA contains
> multiple Write-1-to-Clear (W1C) error flags. Writing the entire 32-bit value
> back means any W1C bit in DEVSTA read as '1' is written as '1', inadvertently
> clearing the error status and masking hardware faults.
> 
> Should this be updated to use dw_pcie_readw_dbi() and dw_pcie_writew_dbi()
> instead?
> 
> [ ... ]
> 
>> @@ -363,7 +347,6 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
>>   
>>   	pp->bridge->ops = &meson_pci_ops;
>>   
>> -	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
> 
> [Severity: Low]
> Should the MAX_PAYLOAD_SIZE macro be removed as well? Since its usage is
> removed here, leaving the macro behind leaves dead code.
> 
>>   	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
>>   
>>   	return 0;
> 

