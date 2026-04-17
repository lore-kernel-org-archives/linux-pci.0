Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0F336ED1;
	Fri, 17 Apr 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394230; cv=none; b=X/KlFdIQY0bzFuimlt8Vf4GJOT/h/1cIH9DH2QnXI40uo3jgDFG4NtACrc7FlBlDLgNO/MkyMOziaNsU9QdBC9i5c1lVXvhHRvwKrQe/ivLgqTClpdT5gSHNZweblXunjUeVJCMyP6EPDWzzR9Q89I49Ov6/CY8FVWdYIpBWRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394230; c=relaxed/simple;
	bh=5p3Sm2amLE1ygQB0o6GVHtSC1KVohOP+qhV3gkwXeq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O3WQ6SGJTXtI5sxxyVGBdAD49Kec0nwyk/6cQoi0/EPVsgL4TZD8Q+2yjvnBSuvmK8pXhB1AmZGF1y6s6hLd+IOchqcafuyOA7deDUz7Rx5+WetyqbgwSEtva1fzZ9+1lTS0xa9SRBAUiT9o3DxYhuDcK++RlufjjlKyJ4Y6kbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vek29DvQ; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vek29DvQ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hg2qRKt05LW4zcRl9d9aEU93GPuGcduNp2wgx4z7rps=;
	b=Vek29DvQ5Xp9tY9XF88rRzWcTLyHzi8hLkrwpqgt3dSNCFzRkFh1QoTcAbqaocq48wLWUTypp
	xycFloana/ixnMu4SdIZAPO6RBpS6PuHYy5sOpWTesPmp8ouLudiviOn3yhPdGTJevysQO8b8ay
	H28+KPMXI8QlPk8sPp8xZGI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fxfN613fzz12LDP;
	Fri, 17 Apr 2026 10:44:06 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E8FE40538;
	Fri, 17 Apr 2026 10:50:23 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 10:50:22 +0800
Message-ID: <4b1aa148-e0f5-4599-9fbf-70a61b42e4ce@huawei.com>
Date: Fri, 17 Apr 2026 10:50:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND 1/5] pci/tph: Export pcie_tph_get_st_modes() for
 external use
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260416204948.GA35511@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260416204948.GA35511@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 4/17/2026 4:49 AM, Bjorn Helgaas wrote:
> On Thu, Apr 16, 2026 at 05:30:37PM +0800, Chengwen Feng wrote:
>> Export the helper to retrieve supported PCIe TPH steering tag modes so
>> that drivers like VFIO can query and expose device capabilities to
>> userspace.
>>
>> And also add pcie_tph_get_st_table_size() and
>> pcie_tph_get_st_table_loc() stub implementation in the !CONFIG_PCI_TPH
>> case.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Update subject to "PCI/TPH: Export ..." to match history.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I notice commit logs of other patches could be rewrapped to fill 75
> columns.

Hi Bjorn,

Thank you for the review and the Ack!

I'll fix the subject to "PCI/TPH: Export ..." and rewrap the commit
messages to 75 columns in the next revision.

Thanks
