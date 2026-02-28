Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8E2E7635
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772280123; cv=none; b=oFLUvPTMkmHPGDqAYrhrH+miZN0JIoZpk29TRYsVEPEfqCjw2Hv5UL3gRP2woSuzWkzcmZVcHUZBFy8Z9YjNZ1Ga4sFedGsSLbSVfyc6BcClC9GmT56XX++oI+WTJpsk0LfVmVgyDNMTZy+bOfH2i2b6vWB7xvPhdX67+VutQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772280123; c=relaxed/simple;
	bh=eUVz3PgJDXvp1i5/BJZIdoCSpMiznh7UkFcMaV00+go=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WFOz1+n/jfUA+O6dYLWRDyY7ZNbIWyOOwwZDAbb61XlYAchA3z/wsXGyIBUgDTNsEDC0rPtrS5PG0Hj++Pr5mUjtSLYHhsYqsnPvQoz2t3tlpSTIJGCYXl73zlOWbfzgh95yypmuBrpPef9vPKEUqjKkTsrbGj3B8XZabNT66bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aITySljN; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aITySljN"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qQuva9xjbkRnpPjhvFT+NYgCpaVLo48Kb9DlWjn4P54=;
	b=aITySljNja19XaRqFt3gHqUNj8o43uUWyUnWQuCXFU/P1TOuq29CuUEq206f/0Rfb3h9T+6xK
	cM9p78NteonEZNZvBfE3qbSJrBe0pDkKXUoidRF2EUh8neOzE0uL33R9sKDl3ZoREHRfugjo+EI
	bkRYUbkKZmSyjIelESLwhyM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fNNw26bF5zcZxt;
	Sat, 28 Feb 2026 19:56:50 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 631D540567;
	Sat, 28 Feb 2026 20:01:57 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Feb 2026 20:01:57 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Feb 2026 20:01:56 +0800
Message-ID: <46194828-2ea0-49e1-8812-07581cc04e8a@huawei.com>
Date: Sat, 28 Feb 2026 20:01:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ERR: Clear fatal status of the reporting device
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <jonathan.cameron@huawei.com>,
	<shiju.jose@huawei.com>, <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <shenyang39@huawei.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
References: <20260227102505.3966864-1-liusizhe5@huawei.com>
 <20260227163118.GA3897131@bhelgaas> <aaIJa_2XiQht4swq@wunner.de>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <aaIJa_2XiQht4swq@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn200012.china.huawei.com (7.202.194.135)

On 2026/2/28 5:15, Lukas Wunner wrote:

> On Fri, Feb 27, 2026 at 06:25:05PM +0800, Sizhe Liu wrote:
>> During PCIe native AER error recovery, ERR_FATAL status bits are not cleared
>> after fatal error handling. This causes stale ERR_FATAL bits to be reported
>> in subsequent AER events, even after reporting "device recovery successful".
> Wrong.	The bits are cleared by:
>
> report_slot_reset()
>    err_handler->slot_reset()
>      pci_restore_state()
>        pci_aer_clear_status()
>        	pci_aer_raw_clear_status()
>
> Is this an LLM-generated submission?  The confidently worded but incorrect
> commit message seems to suggest that it is.  If so, please follow the
> guidelines in Documentation/process/generated-content.rst and be
> transparent about the tools you used to come up with the patch.
Hi Lukas,

Thank you for your feedback and the detailed call trace. I had some
misunderstanding about this issue.

I was not aware that we clear all AER status registers in 
pci_restore_state(),
which led me to incorrectly assume fatal error status was not cleared in 
Native AER.

This issue was discovered during native AER injection testing on the RP 
side of
the Kunpeng CPU platform. The relevant test process and kernel logs are 
shown below:

[root@localhost ~]# busybox devmem aer_nce_inject_addr 32 0x10
pcieport 0000:20:10.0: AER: Uncorrected (Fatal) error message received 
from 0000:20:10.0
pcieport 0000:20:10.0: PCIe Bus Error: severity=Uncorrected (Fatal), 
type=Data Link Layer, (Receiver ID)
pcieport 0000:20:10.0:   device [19e5:a120] error 
status/mask=00000010/04580000
pcieport 0000:20:10.0:    [ 4] DLP
pcieport 0000:20:10.0: AER: Root Port link has been reset (0)
pcieport 0000:20:10.0: AER: device recovery successful
[root@localhost ~]# busybox devmem aer_nce_inject_addr 32 0x1000
pcieport 0000:20:10.0: AER: Uncorrected (Non-Fatal) error message 
received from 0000:20:10.0
pcieport 0000:20:10.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), 
type=Data Link Layer, (Receiver ID)
pcieport 0000:20:10.0:   device [19e5:a120] error 
status/mask=00001010/04580000
pcieport 0000:20:10.0:    [ 4] DLP
pcieport 0000:20:10.0:    [12] TLP                    (First)
pcieport 0000:20:10.0: AER:   TLP Header: 00000000 00000000 00000000 
00000000
pcieport 0000:20:10.0: AER: device recovery successful

The root cause of the problem may not be here. I will
perform further analysis.

Thanks,
Sizhe
>
> Thanks,
>
> Lukas
>
