Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76D270ED7
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692956; cv=none; b=GhFoonZUStSHhwLNQzHZikBsuw+VW3c4cD0Ig7tKDFPkaAMo0zxiSVWhqlVe9n/eSz5Fk/s5UeneGoNaECLd2LFkBtzEG9sLMjpIZ0pLkWMr0VJgmJGpwJBNzISGPTd12mkBDbprjWVW6qIuO8yInkp9FiowCRcKu4/01evb02s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692956; c=relaxed/simple;
	bh=pNsFCS5Y+Fn5QcFVBD5lz4CZIRqwkiltXbjbwu0M+BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mB1cwkdpMn6ZQl8NrhzS8stNrKqDrLIQZamJNt5Bt1LQZ6aKcG89FiG9O42c6+/sFOkplFJKubqjcaqA/QkQZcGteMXDqh1SJi4uDuu4MebUidFks6jbLUtyz6uP5G+t89HMFj2M6hJ5gbLcWgNSR8s0I3TVyCntIc3P4TxkRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ICTOWDkI; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ICTOWDkI; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ICTOWDkI";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ICTOWDkI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jJ/GHZK6vraFCT6uya61WmAJwMMD51G+IWmSguBkN6c=;
	b=ICTOWDkIn1H0Hdrdjp0mtj7kkYPmIL1H5X7JAfaMa0aAaGEGulnJeacbAOj4syKUgnsN9ZEkH
	FXsxtZbFH4bl0ckvOiYD5pUnv8hy72rYMZM17dVj3etkFANhce0o3hmpMkgurXqLVqnk+i6hR1A
	smRhgYC4ry6nf5mvKCt2wfA=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4f20D30tP5z1BFnf
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:21:55 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jJ/GHZK6vraFCT6uya61WmAJwMMD51G+IWmSguBkN6c=;
	b=ICTOWDkIn1H0Hdrdjp0mtj7kkYPmIL1H5X7JAfaMa0aAaGEGulnJeacbAOj4syKUgnsN9ZEkH
	FXsxtZbFH4bl0ckvOiYD5pUnv8hy72rYMZM17dVj3etkFANhce0o3hmpMkgurXqLVqnk+i6hR1A
	smRhgYC4ry6nf5mvKCt2wfA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f207j5pt6z1T4Gx
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:18:09 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 007892012A
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:22:24 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 21:22:23 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 21:22:23 +0800
Message-ID: <328d0076-00ab-4de8-9c7a-4288309ff993@huawei.com>
Date: Thu, 29 Jan 2026 21:22:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Fix AER log missing in DPC case
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <bhelgaas@google.com>, <shiju.jose@huawei.com>, <pandoh@google.com>,
	<linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <shenyang39@huawei.com>
References: <20260127035405.712271-1-liusizhe5@huawei.com>
 <20260127155652.00006bc1@huawei.com>
From: Sizhe LIU <liusizhe5@huawei.com>
In-Reply-To: <20260127155652.00006bc1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn200012.china.huawei.com (7.202.194.135)


On 2026/1/27 23:56, Jonathan Cameron wrote:
> On Tue, 27 Jan 2026 11:54:05 +0800
> Sizhe Liu <liusizhe5@huawei.com> wrote:
>
>> In the current DPC error reporting case, some AER log information
>> is missing.
> Wrap commit messages up to 75 chars, this is about 65.
> Only do that for stuff where the formatting isn't fixed for other
> reasons, such as the log below.
Got it, I will align the format.
>> -- Error log abnormal (line breaks adjusted)
>> [  976.604003] pcieport 0000:20:00.0: DPC: containment event, status:
>> 0x1f11: unmasked uncorrectable error detected
>> (------ AER error log supposed to be printed here, but missing ------)
>> [  976.604030] nvme nvme0: frozen state error detected, reset controller
>> [  977.812932] {4}[Hardware Error]: Hardware error from APEI
>> Generic Hardware Error Source: 0
>>
> This, but do remove timestamps as those don't matter to anyone.
> Not wrapping helps if anyone is searching for this later.
>
> Abnormal error log
>
>    pcieport 0000:20:00.0: DPC: containment event, status: 0x1f11: unmasked uncorrectable error detected
> (------ AER error log supposed to be printed here, but missing ------)
>    nvme nvme0: frozen state error detected, reset controller
> {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
>
I will remove the timestamps and adjust the log accordingly.
>> Cause:
>> In aer_print_error(), PCIe AER errors is reported, and is rate-limited
>> by info->ratelimit_print[i]. There are two entry points for
>> aer_print_error().
>>
>> 1) Native AER
>> aer_isr_one_error_type() -> aer_process_err_devices() ->
>> aer_print_error()
>> 2) DPC
>> dpc_process_error() -> aer_print_error()
>>
>> The value of info->ratelimit_print[i] is initialized correctly in
>> the native AER case:
>> aer_isr_one_error_type() -> find_source_device() ->
>> find_device_iter() -> add_error_device()
>>
>> In the DPC case, info->ratelimit_print[i] is not initialized and
>> alloc by 0 , so in aer_print_error(), it will directly return at line
>> if (!info->ratelimit_print[i])
>> This will result in lossing the AER log messages in the DPC case.
> losing
Oops, good catch! Thanks :)
>> Solution:
>> 1. Move the initialization of info->ratelimit_print[i] to
>> aer_ratelimit_print_init().
>> 2. Add aer_ratelimit_print_init() in dpc_process_error().
>> 3. Replace the initialization by aer_ratelimit_print_init()in
>> Native AER case.
>>
>> Test with AER inject:
>> Set the DPC reporting priority in the BIOS and send
>> MalfTLP(AER FATAL ERROR) to device.
>>
>> -- Error log normal (line breaks adjusted)
>> [ 5366.943807] pcieport 0000:20:00.0: DPC: containment event,
>> status:0x1f11: unmasked uncorrectable error detected
>> [ 5366.943826] pcieport 0000:20:00.0: PCIe Bus Error:
>> severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>> [root@localhost ~]# [ 5366.943830] pcieport 0000:20:00.0:
>> device [19e5:a120] error status/mask=00040000/04580000
>> [ 5366.943833] pcieport 0000:20:00.0:    [18] MalfTLP   (First)
>> [ 5366.943836] pcieport 0000:20:00.0: AER:   TLP Header:
>> 0x00000000 0x00000000 0x00000000 0x00000000
>> [ 5366.943843] nvme nvme0: frozen state error detected, reset controller
>> [ 5368.156778] {2}[Hardware Error]: Hardware error from APEI Generic
>> Hardware Error Source: 0
> Reformat this and drop timestamps as well:
>
> Normal error log
>
>    pcieport 0000:20:00.0: DPC: containment event, status:0x1f11: unmasked uncorrectable error detected
>    pcieport 0000:20:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>    pcieport 0000:20:00.0: device [19e5:a120] error status/mask=00040000/04580000
>    pcieport 0000:20:00.0:    [18] MalfTLP   (First)
>    pcieport 0000:20:00.0: AER:   TLP Header: 0x00000000 0x00000000 0x00000000 0x00000000
>    nvme nvme0: frozen state error detected, reset controller
>    {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
I will reformat the AER log as above.
>> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
>> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
> Otherwise looks good to me.
>
> Thanks,
>
> Jonathan
>
A v2 patch will be sent for adjusting the commit log.


Kind regards,

Sizhe

