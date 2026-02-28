Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADE2101AE
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772244389; cv=none; b=UiNwmF0brnzS6Gdjo/29j/bqu9NfcPkYEzyb2I+AKX7HGmUJpF3M1FQk+0buDGFyxdxys1j6kzIEz9KVaFK4g1m+n7OJoj1bKhorhHEKS2PlVdZMgmrKOzer91jED3zWefUOfs0IeNRs/VZ5rP2k7+Q+T1mIdfcurcr0/zGvPqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772244389; c=relaxed/simple;
	bh=yeaYAcJjEhTFZ6TXM9wzDcpe+MEwVmEb2ZWHSPEv7Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpvJuyL64m5oGAovs+3mh/1H4fO6QkXf4aiOl8hvviaDr3OUh6T/9PhpM3oTkTSWMyObWy1yTxPg/wTDwKJkh9LBsyVno/24lj33pIJadue9Rg6d8pjiR9bLbQVkS8OS7SF5yUQYTxHMzfU1Hn6Jq6MLUpZc9Vd0QGeU86W4itI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iXg4Lx45; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iXg4Lx45"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772244379; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Y2nl/rJw+P8gqkZQUFuUs1QlxDNO/Ghr3MvRkh84rD8=;
	b=iXg4Lx45oBazOpdSmP44Jnt5ghLpIm8TmTsleGdVmcFGck5XSSiWRqQUYAXVTLCzvMArM4zPv3UVMbEn0xbTJ/+g9INSB/SSPwrRiIJOxG1k4wp1WAPUNTL0RiW8p3Iqr0Fkz19V6SR9ftzGGJw/FG6A2UzvTmPwMtPGPIpNP7k=
Received: from 30.246.163.43(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wzvkjxi_1772244377 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 28 Feb 2026 10:06:18 +0800
Message-ID: <5ca94a2c-91b4-4325-afc8-fcd2b7cf882c@linux.alibaba.com>
Date: Sat, 28 Feb 2026 10:06:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ERR: Clear fatal status of the reporting device
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Sizhe Liu <liusizhe5@huawei.com>, bhelgaas@google.com,
 jonathan.cameron@huawei.com, shiju.jose@huawei.com, keith.busch@intel.com,
 linux-pci@vger.kernel.org, linuxarm@huawei.com, prime.zeng@hisilicon.com,
 fanghao11@huawei.com, shenyang39@huawei.com,
 Terry Bowman <terry.bowman@amd.com>
References: <20260227102505.3966864-1-liusizhe5@huawei.com>
 <20260227163118.GA3897131@bhelgaas> <aaIJa_2XiQht4swq@wunner.de>
 <0fdec25a-1ea5-4526-8809-eff71553067c@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <0fdec25a-1ea5-4526-8809-eff71553067c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/26 6:47 AM, Kuppuswamy Sathyanarayanan wrote:
> Hi Lukas,
> 
> On 2/27/2026 1:15 PM, Lukas Wunner wrote:
>> On Fri, Feb 27, 2026 at 06:25:05PM +0800, Sizhe Liu wrote:
>>> During PCIe native AER error recovery, ERR_FATAL status bits are not cleared
>>> after fatal error handling. This causes stale ERR_FATAL bits to be reported
>>> in subsequent AER events, even after reporting "device recovery successful".
>>
>> Wrong.	The bits are cleared by:
>>
>> report_slot_reset()
>>    err_handler->slot_reset()
>>      pci_restore_state()
>>        pci_aer_clear_status()
>>        	pci_aer_raw_clear_status()
> 
> Thanks for the correction and for sharing the call flow. I was not aware
> that the fatal status bits are already cleared via pci_restore_state().

Hi,

I also have a patch which trys to handle the same problem. Please also see,

https://lore.kernel.org/all/de195f39-8197-494e-8451-2cf8fde064ea@linux.alibaba.com/


> 
> That raises a question. If pci_restore_state() already clears all AER
> status bits through pci_aer_raw_clear_status(), do we still need the
> explicit pci_aer_clear_nonfatal_status() call in pcie_do_recovery()?
> Similarly, could pcie_clear_device_status() also be moved there?
> I see pcie_clear_device_status() call is sprinkled across all error
> handling paths (EDR, DPC & AER).
> 
> Also, since pci_aer_raw_clear_status() clears all error status registers,
> is there a risk of silently losing newly detected errors that arrive while
> recovery is still in progress?

since ->slot_reset() is driver-defined and not all drivers invoke
pci_restore_state(), there could be cases where fatal AER status bits
remain set after the frozen recovery completes.

Lukas is working on moving pci_aer_clear_status() out of
pci_restore_state() into the callers that actually need it.
After that, IMHO, we should claer AER status conditional on the 'state' parameter,

Thanks.
Shuai
