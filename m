Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DFA2F8BD0;
	Fri, 30 Jan 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759604; cv=none; b=c7KUQ2SgJ0WNNykds9RVWek1Tnx1fT4prIivX1f0KDC4aG+vSGz5wvMPGKjAOxZjJxdytFUQAyPaYQm2OqyZr/hge2g1f72v+XWobT2CGUHq+6NBOyRmKI9ElVVtfnROZZF6y50IOv5aXeIsHZtIU7dCLRl3s7HiwtUAJEKrRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759604; c=relaxed/simple;
	bh=QLlfPp6Okm7YZjrXvDWS1ElGzKgXnTRB03ThB48qMxM=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=sdjoy0zyU/WV4uxIXV5pJVgnyhA2URh7YTXQCQm5BgiG0ED8yz6qNfhnUuOSyifundVl+aWw/aD4mfcUkEaamv2xvEaE9r2lRqUfwipqYf0SRcg36YSVr9H4nE77xS8BBi2szXWGzg3xWz/2v2KjppmYF6P1jLWUOJhcJAzIqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=P94fkLGy; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="P94fkLGy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/cg8FzMhmw2bodPzf12bqJQFvnRROJhCGaf11tij8Z4=;
	b=P94fkLGyNMaoVkC/jh5yAnOcvhp/sFu1JFfENfH9DNktq7kpG86S7acfQBdM4cPpQjeIpd7R0
	nEuvygIMhTHFyVjQSImoQwSDGpy04lpobc+OIi9RtzgvLA5D3ZS7mRjyXfyzrYnxdOFLQCNSSke
	flpylWIDGeszUmBvZDhuYmA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f2Snf2DCLzpStZ;
	Fri, 30 Jan 2026 15:49:10 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id F122540363;
	Fri, 30 Jan 2026 15:53:11 +0800 (CST)
Received: from [100.103.109.121] (100.103.109.121) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 15:53:11 +0800
Message-ID: <728a9d24-b2cc-43f3-a1c3-12695155bf2f@huawei.com>
Date: Fri, 30 Jan 2026 15:53:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <duziming2@huawei.com>
CC: <alex@shazbot.org>, <bhelgaas@google.com>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <liuyongqiang13@huawei.com>,
	<duziming2@huawei.com>
References: <20260116081723.1603603-1-duziming2@huawei.com>
Subject: Re: [PATCH v4 0/4] Miscellaneous fixes for pci subsystem
From: duziming <duziming2@huawei.com>
In-Reply-To: <20260116081723.1603603-1-duziming2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500012.china.huawei.com (7.202.195.23)

Hi all,

Gentle ping on this patchset. Any feedback would be greatly appreciated.

On 2026/1/15 15:52, Ziming Du wrote:

> Miscellaneous fixes for pci subsystem
>
> Changes in v4:
> - Remove the architecture-specific #ifdef to apply the alignment
>    check for all platforms (including x86), as device registers are
>    naturally aligned anyway.
> - Fix a potential issue in proc_bus_pci_read() to make it consistent
>    with proc_bus_pci_write(), as suggested by Ilpo Järvinen.
> - Link to v3:https://lore.kernel.org/linux-pci/20260108015944.3520719-1-duziming2@huawei.com/
>
> Changes in v3:
> - Check *ppos before assign it to pos.
> - Link to v2:https://lore.kernel.org/linux-pci/20251224092721.2034529-1-duziming2@huawei.com/
>
> Changes in v2:
> - Correct grammer and indentation.
> - Remove unrelated stack traces from the commit message.
> - Modify the handling of pos by adding a non-negative check to ensure
>    that the input value is valid.
> - Use the existing IS_ALIGNED macro and ensure that after modification,
>    other cases still retuen -EINVAL as before.
> - Link to v1:https://lore.kernel.org/linux-pci/20251216083912.758219-1-duziming2@huawei.com/
>
> Yongqiang Liu (2):
>    PCI: Prevent overflow in proc_bus_pci_write()
>    PCI/sysfs: Prohibit unaligned access to I/O port
> Ziming Du (2):
>    PCI/sysfs: Fix null pointer dereference during hotplug
>    PCI: Prevent overflow in proc_bus_pci_read()
>
>   drivers/pci/pci-sysfs.c |  7 +++++++
>   drivers/pci/proc.c      | 11 +++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)

Thanx du!

