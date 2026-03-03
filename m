Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5B1DE8BB
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544865; cv=none; b=CWpcx7m7EBzbWzMN6Phm5iHh7uNY3gm4GOSm6odYwQqljlVpMKfA4t4viGYxlcKFQnP8CVLUcApoRwpwig5Y4lXErM48b/7wcycx6RGoCJ0p1ojl55upmxVCVt6DXeGLl5M4fta1I3xucu+ITYGSgkHPWHRz/zNHZRzRJPHwmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544865; c=relaxed/simple;
	bh=zCTBE4J/RygIW6mUFKJAAdaYwMDmMDgEp+/ohOwFaA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=soSF7A64ptJM9qf4FDv7DiZK0Z3D7hpqBcASgOJ02XnmKuthW6LpQYV9CGJBYr/dh19kFWFxpzU6gqvpMw3wXigSjY90crdA9tHmrtx/nyK5N1U0Hs8iI/4seKBAeFwbtPk0+zPhUX2ikg8nHUi1uUk+moRigfVS17yAbYaAlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yoLO9Hbj; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yoLO9Hbj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=peS5YN0Lmtn0KIEY9486+AkVzHHM8mPoSkD7LNIfG4M=;
	b=yoLO9HbjnN+YcCLEVoTxInKE+WCt9QP18E+M4e47sSfdDY+L9m3ohMGhBBoyiJis4OXgwwPfx
	Zc2Jd0Ux2GA364gOzOtwi2orcTtI7WXKNHtb0uzNOS3mxMpgFQql40Yvl5qTvkjHrh+V8+mz5Ow
	jDUfZnOrwyvHteZB3cjJS6Q=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fQGqg36SyznTVF;
	Tue,  3 Mar 2026 21:29:35 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 9047540539;
	Tue,  3 Mar 2026 21:34:12 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 21:34:12 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 21:34:11 +0800
Message-ID: <9a93f175-f2eb-4d2f-b0c9-1593e47d7d40@huawei.com>
Date: Tue, 3 Mar 2026 21:34:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ERR: Clear fatal status of the reporting device
To: Shuai Xue <xueshuai@linux.alibaba.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <jonathan.cameron@huawei.com>,
	<shiju.jose@huawei.com>, <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <shenyang39@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>
References: <20260227102505.3966864-1-liusizhe5@huawei.com>
 <20260227163118.GA3897131@bhelgaas> <aaIJa_2XiQht4swq@wunner.de>
 <0fdec25a-1ea5-4526-8809-eff71553067c@linux.intel.com>
 <5ca94a2c-91b4-4325-afc8-fcd2b7cf882c@linux.alibaba.com>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <5ca94a2c-91b4-4325-afc8-fcd2b7cf882c@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn200012.china.huawei.com (7.202.194.135)

On 2026/2/28 10:06, Shuai Xue wrote:
> On 2/28/26 6:47 AM, Kuppuswamy Sathyanarayanan wrote:
>> Hi Lukas,
>>
>> On 2/27/2026 1:15 PM, Lukas Wunner wrote:
>>> On Fri, Feb 27, 2026 at 06:25:05PM +0800, Sizhe Liu wrote:
>>>> During PCIe native AER error recovery, ERR_FATAL status bits are 
>>>> not cleared
>>>> after fatal error handling. This causes stale ERR_FATAL bits to be 
>>>> reported
>>>> in subsequent AER events, even after reporting "device recovery 
>>>> successful". 
>>>
>>> Wrong.    The bits are cleared by:
>>>
>>> report_slot_reset()
>>>    err_handler->slot_reset()
>>>      pci_restore_state()
>>>        pci_aer_clear_status()
>>>            pci_aer_raw_clear_status()
>>
>> Thanks for the correction and for sharing the call flow. I was not aware
>> that the fatal status bits are already cleared via pci_restore_state().
>
> Hi,
>
> I also have a patch which trys to handle the same problem. Please also 
> see,
>
> https://lore.kernel.org/all/de195f39-8197-494e-8451-2cf8fde064ea@linux.alibaba.com/ 
>
>
>
Hi Shuai,

Thanks for your feedback, sorry I missed your patch.
To keep things focused, I think we can do the discussion further in your 
patch series.
>>
>> That raises a question. If pci_restore_state() already clears all AER
>> status bits through pci_aer_raw_clear_status(), do we still need the
>> explicit pci_aer_clear_nonfatal_status() call in pcie_do_recovery()?
>> Similarly, could pcie_clear_device_status() also be moved there?
>> I see pcie_clear_device_status() call is sprinkled across all error
>> handling paths (EDR, DPC & AER).
>>
>> Also, since pci_aer_raw_clear_status() clears all error status 
>> registers,
>> is there a risk of silently losing newly detected errors that arrive 
>> while
>> recovery is still in progress?
>
> since ->slot_reset() is driver-defined and not all drivers invoke
> pci_restore_state(), there could be cases where fatal AER status bits
> remain set after the frozen recovery completes.
>
I agree with you.

In addition, in pcie_do_recovery(), we use pci_walk_bridge()
to walk bridges that are potentially AER-affected.
For a device that has a subordinate bus, we only walk its subordinate buses,
including any bridged devices under this bus, i.e., if the fatal error
source is a Root Port(RP), the RP driver's callbacks will not be invoked.

I'm not sure whether we need to call report_slot_reset() for the RP.
IMHO, at least clear device status bits and error status bits.

Results of my AER injection test on the RP:
https://lore.kernel.org/linux-pci/46194828-2ea0-49e1-8812-07581cc04e8a@huawei.com/ 

> Lukas is working on moving pci_aer_clear_status() out of
> pci_restore_state() into the callers that actually need it.
> After that, IMHO, we should claer AER status conditional on the 
> 'state' parameter,
Sounds interesting. I appreciate Lukas's efforts and the information
you have shared.

Regards,
Sizhe
>
> Thanks.
> Shuai
