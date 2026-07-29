Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83C2D0C9D;
	Wed, 29 Jul 2026 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290061; cv=none; b=taR6z5eCOHpQXBTSU6qDGnRfw/Kv12l8yPDxAjOi9dZdEnxXySbRIYQTH8nTUTIf3p0Srbh+sTU8SzOkXKV1uAsemhDDvttnMvW5gnMx7LdaJi3x5hMB5zKj3T83uTNDg5kJOpgyeyL8X6tv6rJ/zkRMMdkhmPIQL5hbgwfOXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290061; c=relaxed/simple;
	bh=eol2A7XitvMAqIjeZCdcIufLRc7o5CcCyY8MkGxZmG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=khMjznd9x3eK5lgAIOLRap4Gp5BkxjCQ5E2AdVA6I3VEZcUBLprS+6GSr6PDRIp3OyG4pJJzbTTs85DkZK3IND8AEWuovehe4GHcWGMj9ovLFrD88ercrIzQsXmuFCGV6vSw/0sXVXS9rlFCjmh1ZxI4CpzgCDyc714WIWDLPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MD8i7Zm2; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MD8i7Zm2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=z7JRPn3ff2+NcN4kwnBUhoNlxhcRpO6tXbrUvD3nslk=;
	b=MD8i7Zm2E4F5km9olEOV1kfTaHXjb7XoL+uw+o2hnMrQGRPanOa+kfgWGeB+UQokFr1n0fmmG
	CHvd3KL2TjDdp5leEjPSefD2a6F6Klmz0LkhmzkDDN9dHM7c9LqmZ4pW+7lYjTOBjJz/8FRBmfe
	ImG0tuG86zowikDQlQxuEtU=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h8wB36CwVz1T4Fq;
	Wed, 29 Jul 2026 09:44:43 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id E6E1F4057D;
	Wed, 29 Jul 2026 09:54:13 +0800 (CST)
Received: from [100.103.110.67] (100.103.110.67) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Jul 2026 09:54:13 +0800
Message-ID: <2dc8c18e-6875-41c5-8e8f-a661e67d04c2@huawei.com>
Date: Wed, 29 Jul 2026 09:53:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] PCI: Fix procfs PCI config access issues
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>
References: <20260414024544.2975605-1-duziming2@huawei.com>
 <20260728231714.GA2293930@rocinante>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20260728231714.GA2293930@rocinante>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/7/29 7:19, Krzysztof Wilczyński 写道:
> Hello,
>
>> As suggested by Bjorn, this series aligns the implementation of procfs with
>> the sysfs counterpart and fixes procfs PCI configuration access issues.
>>
>> The first two patches refactor proc_bus_pci_{write,read}() to align
>> with pci_write_config() and pci_read_config() respectively:
>>    - Rename variables (pos->off, cnt->count/size) for consistency
>>    - Remove rebundant bounds check
>>
>> The last two patches fix potential overflow issues:
>>    - Prevent overflow when offset exceeds reasonable range
>>    - Fix implicit 64-bit to 32-bit truncation in read path
>>
>> Link: https://lore.kernel.org/all/20260303193253.GA3817951@bhelgaas/
>>
>> Ziming Du (4):
>>    PCI: Align proc_bus_pci_write() with pci_write_config()
>>    PCI: Align proc_bus_pci_read() with pci_read_config()
>>    PCI: Prevent overflow in proc_bus_pci_write()
>>    PCI: Prevent overflow in proc_bus_pci_read()
>>
>>   drivers/pci/proc.c | 115 ++++++++++++++++++++++-----------------------
>>   1 file changed, 57 insertions(+), 58 deletions(-)
> These changes here are worth doing, so I wonder if you have some time to
> pick this up?  If not, then I am happy to pick this up and send a v2?
>
> Thank you!
>
> 	Krzysztof

Hi Krzysztof,

Thanks for taking a look!

I have time to take care of this and will address the feedback and send 
out v2 soon.

Best regards,

Ziming

