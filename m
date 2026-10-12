Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E713A258;
	Mon, 12 Oct 2026 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791772085; cv=none; b=l87u6w40Weywi1MSXe1ELnTmaZ8SbWFIhstYlrIsc2IxLtxWHlliEqWvJdLq2P6qAgC02jOCQdLTC/AgKGer6DQz0jehgdhTvtrwuO5Wh1Ks3f5lRlIGYsALTanfkhCiOtN/PIy6WbJq9Dr7TkT4Y9/d+bwHLy2tLd5dXQzkrWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791772085; c=relaxed/simple;
	bh=Oqwdrll2litYTk46snNda/ip8sTW7IigWnTE28krcMc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=kEFgvszjYEr3MC+/85JtxgtzuBRs2frNFPakfSSYvgDjOYGp/wCX5v4uHlB1PXxctP3HsjsnyB0tDrO2lWnZ8iCFpQl1hkAp8UDPnSURXmQRYZ99yOCHgn4fl1+riGkqNLS0gzDatPUCyfhtBnrldY1SHYfgNjRdiwAAXK9ThBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Tl5PVJf9; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Tl5PVJf9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2Mc6VbMHK2g87/p5M/nYNGzz6kQ/wmXjSxwi+N0uiwc=;
	b=Tl5PVJf9DImk2Ad3jqzV7/AmYEwvMO6x5wie5P8Hqa84S00PbhwIy/xtzHfW7bX0f7W+n3kvX
	ZbUnJ5LQYJl5yQpd2V/mfB6bi9F7O65yWc2KmTw/n5YKoBeuEWrtWy9/kLgHHdnTXm6PgU7AW8Z
	boFqfGuAP7HuSedptCr3U58=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4j31Jl3gr7zpStW;
	Mon, 12 Oct 2026 10:15:19 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id AB7D340579;
	Mon, 12 Oct 2026 10:27:50 +0800 (CST)
Received: from [100.103.109.54] (100.103.109.54) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 12 Oct 2026 10:27:49 +0800
Message-ID: <19776b93-8c12-4c08-8237-a9c08385b511@huawei.com>
Date: Mon, 12 Oct 2026 10:27:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING] PCI: Fix procfs PCI config access issues
From: duziming <duziming2@huawei.com>
To: <bhelgaas@google.com>, <kwilczynski@kernel.org>
CC: <rientjes@google.com>, <gregkh@suse.de>, <iweiny@kernel.org>,
	<djbw@kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
 <14cd77b6-5541-4134-af52-62fb1d3664a0@huawei.com>
In-Reply-To: <14cd77b6-5541-4134-af52-62fb1d3664a0@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/8/17 14:22, duziming 写道:
>
> 在 2026/7/30 11:24, Ziming Du 写道:
>> Hi,
>>
>> As suggested by Bjorn and Krzysztof, this series aligns the procfs PCI
>> configuration access implementation with its sysfs counterpart and fixes
>> issues found while reviewing the two paths.
>>
>> The first four patches fix the offset truncation, inode size update 
>> race,
>> missing driver-exclusive resource warning, and unnecessary runtime PM
>> operations at the end of sysfs configuration space. The final two
>> patches align the procfs read and write implementations with their sysfs
>> counterparts.
>>
>> Changes from v1:
>>    - Merge the read and write offset fixes and move them before the
>>      refactoring to avoid an intermediate signed/unsigned regression.
>>    - Serialize i_size_write() with the inode lock.
>>    - Add the driver-exclusive resource warning to procfs writes.
>>    - Avoid unnecessary runtime PM get/put when sysfs config access 
>> starts at EOF.
>>
>> Link: https://lore.kernel.org/all/20260303193253.GA3817951@bhelgaas/
>> Link: 
>> https://lore.kernel.org/linux-pci/20260414024544.2975605-1-duziming2@huawei.com/
>> Link: 
>> https://sashiko.dev/#/patchset/20260414024544.2975605-1-duziming2%40huawei.com
>>
>>
>> Ziming Du (6):
>>    PCI: Prevent overflow in proc_bus_pci_{read,write}()
>>    PCI/proc: Serialize config inode size updates
>>    PCI/proc: Warn on writes to driver-exclusive config regions
>>    PCI/sysfs: Avoid runtime PM at config-space EOF
>>    PCI: Align proc_bus_pci_write() with pci_write_config()
>>    PCI: Align proc_bus_pci_read() with pci_read_config()
>>
>>   drivers/pci/pci-sysfs.c |   4 +-
>>   drivers/pci/proc.c      | 124 +++++++++++++++++++++-------------------
>>   2 files changed, 68 insertions(+), 60 deletions(-)
>
> Hi,
>
> Gentle ping on this patch.
>
> Thanks
>
> Ziming

Hi all,

Just gently bumping this patch to the top of your inbox.

I would really appreciate any feedback, review, or thoughts when you 
have some spare cycles.

Thanks, Ziming

