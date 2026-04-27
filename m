Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32445319859;
	Mon, 27 Apr 2026 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256580; cv=none; b=SPZy+0lJogLgDJyyeA50wZn6wALZHWc2u8VDfQiVVn0zBQJnjANE8np2rrvGMYee0QsUp8jslQqF2AQBG3SOXxGoko9YEje/IeRoDFESyNn/iOkpfb8EfzsAPA9TCeHAGUqjr08FixmpvobOhqSD0Ne0DyKqDa/O6lyNEQN/8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256580; c=relaxed/simple;
	bh=PCFcYuGWtcaNwH4l92PVbLGYsGHL/cwfY9QZWk3DeKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dqzfb9EwGcpYXTzQSCmBYf1kqJixEmSjTYTICT5uW8QKGnTqYV69wBBZ2nhBJWUnuSbMeQxx/J8vIuIexoATqcW/QmL027CudV42ldZ3yx+AQyoZ5aNL/NXITxkodX1JOpmTI1kfetMZJH4bzixMwyARHC4Yz/ZSPRHZnbipazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HSWk8d7O; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HSWk8d7O"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oDBkpQtwT93yz/AyhaTpXiMYhq6amdrlRIfJoJ/CHIU=;
	b=HSWk8d7OqvAWaMsyvzN7Lio/Y5OG69NgaCn7ZnespPTLMba6+PBGnZK420TY2QcBiXXeaEnFX
	8NC8tnIG7+qdx39K1xXLHJ4MylUOa0S+Hl9AFeWAQpxPz9FH+PdH0zGrJpRIoNFX3NlK4YJ0ZA5
	8geNu49/Lq36cUH2tQHf22g=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4g3nHM72vbzpStt;
	Mon, 27 Apr 2026 10:16:15 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id D637040538;
	Mon, 27 Apr 2026 10:22:48 +0800 (CST)
Received: from [100.103.109.222] (100.103.109.222) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 10:22:48 +0800
Message-ID: <ad681f33-39a7-4e6e-9ce0-b537615bdd0e@huawei.com>
Date: Mon, 27 Apr 2026 10:22:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PING] PCI: Fix procfs PCI config access issues
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
References: <20260414024544.2975605-1-duziming2@huawei.com>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20260414024544.2975605-1-duziming2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/4/14 10:45, Ziming Du 写道:
> Hi,
>
> As suggested by Bjorn, this series aligns the implementation of procfs with
> the sysfs counterpart and fixes procfs PCI configuration access issues.
>
> The first two patches refactor proc_bus_pci_{write,read}() to align
> with pci_write_config() and pci_read_config() respectively:
>    - Rename variables (pos->off, cnt->count/size) for consistency
>    - Remove rebundant bounds check
>
> The last two patches fix potential overflow issues:
>    - Prevent overflow when offset exceeds reasonable range
>    - Fix implicit 64-bit to 32-bit truncation in read path
>
> Link: https://lore.kernel.org/all/20260303193253.GA3817951@bhelgaas/
>
> Ziming Du (4):
>    PCI: Align proc_bus_pci_write() with pci_write_config()
>    PCI: Align proc_bus_pci_read() with pci_read_config()
>    PCI: Prevent overflow in proc_bus_pci_write()
>    PCI: Prevent overflow in proc_bus_pci_read()
>
>   drivers/pci/proc.c | 115 ++++++++++++++++++++++-----------------------
>   1 file changed, 57 insertions(+), 58 deletions(-)
Gentle ping on this
