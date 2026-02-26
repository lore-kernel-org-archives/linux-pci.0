Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2454A33;
	Thu, 26 Feb 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096869; cv=none; b=FyASP3qciVfjOj3+43w5VBIhs/gEyXTG7qj478HlcIRSHWBbyFJEHMeIDdJPRuBLM4Zix0G1Bi69HhtP7yyHYoBcPzLhmczN4kl5osEMJMfRmNjv9S8Us9JrQBy9fjZ+EZivxSvFNJGGjJyzpW0FDL0NTao9oKu8SBKZtkkjIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096869; c=relaxed/simple;
	bh=N6DmY/Auqmm31rRqJXdX1mJqdtSrqWGfjdGUvxs5C80=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CLfTrQzTHlIyd5S+kwIe9v+VFNDn7HTS22w5Z6rkNkqhI0Hk/KHt+iu8ODSb6Sv63MRTTfouvQcIRB+HY0zvpoisUoJ+3NLI2Xe+qq5QmZoWWKjsWJyt2HRJ8Bisnm3sBo3yeh7ZAqotZ+qDnWl746J81xYZ+HzkRmRSdqZ/yXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=N5F2cFT2; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="N5F2cFT2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=msFOCavQxADz3tmmF8NqTgdYIhYjr0sDnPVbw3lFN9E=;
	b=N5F2cFT29uso15Nno/oymItctoIJ1ypjRn5rTr19Ts0LcHgiQDdwNMzkA6P0pjb879mdEz/+U
	JH3bRKGKngzBmpjscwDUB5Co46dh9rBVyFe3ObjyxTXIwppID4CYpPCVGdkcakPFMfHwFRga2dg
	GW7n0Ttl245S7Is/SXCbeW4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fM58J0Hs5zLlZc;
	Thu, 26 Feb 2026 17:02:56 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B12740565;
	Thu, 26 Feb 2026 17:07:43 +0800 (CST)
Received: from [100.103.109.121] (100.103.109.121) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 17:07:42 +0800
Message-ID: <1f4d4b42-701a-4c92-b243-66127529a8dc@huawei.com>
Date: Thu, 26 Feb 2026 17:07:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Miscellaneous fixes for pci subsystem
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <alex@shazbot.org>, <bhelgaas@google.com>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <liuyongqiang13@huawei.com>
References: <20260206222923.GA98884@bhelgaas>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20260206222923.GA98884@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/2/7 6:29, Bjorn Helgaas 写道:
> On Fri, Jan 30, 2026 at 03:53:10PM +0800, duziming wrote:
>> Hi all,
>>
>> Gentle ping on this patchset. Any feedback would be greatly appreciated.
> Sorry I didn't get to this.  Poke again after v6.20-rc1.
ping？
>> On 2026/1/15 15:52, Ziming Du wrote:
>>
>>> Miscellaneous fixes for pci subsystem
>>>
>>> Changes in v4:
>>> - Remove the architecture-specific #ifdef to apply the alignment
>>>     check for all platforms (including x86), as device registers are
>>>     naturally aligned anyway.
>>> - Fix a potential issue in proc_bus_pci_read() to make it consistent
>>>     with proc_bus_pci_write(), as suggested by Ilpo Järvinen.
>>> - Link to v3:https://lore.kernel.org/linux-pci/20260108015944.3520719-1-duziming2@huawei.com/
>>>
>>> Changes in v3:
>>> - Check *ppos before assign it to pos.
>>> - Link to v2:https://lore.kernel.org/linux-pci/20251224092721.2034529-1-duziming2@huawei.com/
>>>
>>> Changes in v2:
>>> - Correct grammer and indentation.
>>> - Remove unrelated stack traces from the commit message.
>>> - Modify the handling of pos by adding a non-negative check to ensure
>>>     that the input value is valid.
>>> - Use the existing IS_ALIGNED macro and ensure that after modification,
>>>     other cases still retuen -EINVAL as before.
>>> - Link to v1:https://lore.kernel.org/linux-pci/20251216083912.758219-1-duziming2@huawei.com/
>>>
>>> Yongqiang Liu (2):
>>>     PCI: Prevent overflow in proc_bus_pci_write()
>>>     PCI/sysfs: Prohibit unaligned access to I/O port
>>> Ziming Du (2):
>>>     PCI/sysfs: Fix null pointer dereference during hotplug
>>>     PCI: Prevent overflow in proc_bus_pci_read()
>>>
>>>    drivers/pci/pci-sysfs.c |  7 +++++++
>>>    drivers/pci/proc.c      | 11 +++++++++--
>>>    2 files changed, 16 insertions(+), 2 deletions(-)
>> Thanx du!
>>
