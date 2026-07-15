Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437902E8897;
	Wed, 15 Jul 2026 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079454; cv=none; b=Sgvq81WWiYAzz+iiPAFY7lphnJDfLu10JkjCH4XFVz/FBp5MKZlu6UAkzXdSb3Obe1ztlauOBNkg5Hk7K80oqVyWu2FDCoGhPzRzewvFdxD9yMObe8JFVQQ/8XDIBLzAKjGPYTXp64LUNwIbkAIuJ3pKSmOw8x6Cdhn7pxM9s2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079454; c=relaxed/simple;
	bh=k+Wp+DsUR0IbYDoweuQ3iiAvwpfn+mzdsaqbOUPhUEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HtR2EMjgJCP/iyXq7RgFYvuKn795MkfZpAgTJfgoEq07NoS9joWe/btYC2nMqJ8dLw+IviMU0mTd8EuA4qGDtLRAXFNG7/+UIhh2B8KeUO1aKJOlVwBCZ+uTF8xrjrUv0s+uCUxB/IZ3dnpMYLqengI18I0TWSmUMlxZc5pPvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1fzVik5i; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1fzVik5i"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=egjsnN/zFtVv4maZH5rF6t+ojEEbcEZuzOTemXzrlM0=;
	b=1fzVik5iAleGA7hkybxtLGl7/fXwCxEQvJp/bgIT0EiJRH2HbY7WRvii5izZIryW8dVHBpVhy
	4cTt43K8c43d91NcWkM4VyFTmDG9vcM86x59Iw41KPNiInu1DKMsn1xG/zACW+eScgDl21q6Wm4
	LmnsvzKZjNRy1wILYM01bKg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h0JTQ2WdSz1K96b;
	Wed, 15 Jul 2026 09:28:10 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 4415240586;
	Wed, 15 Jul 2026 09:37:27 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 15 Jul 2026 09:37:26 +0800
Message-ID: <d7458563-0439-498c-af0f-edb8ca2aff46@huawei.com>
Date: Wed, 15 Jul 2026 09:37:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 12/18] vfio/pci: Add dmabuf TPH metadata storage and
 fd query helper
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-13-fengchengwen@huawei.com>
 <20260708173117.3e399c4b@shazbot.org>
 <bb0e583e-501f-4356-b554-784482b35331@huawei.com>
 <20260709125012.21784d0a@shazbot.org>
 <0768658f-de72-4ddb-a44b-e91a7e294b20@huawei.com>
 <20260714075753.20052573@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260714075753.20052573@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/14/2026 9:57 PM, Alex Williamson wrote:
> On Tue, 14 Jul 2026 18:46:51 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
>> On 7/10/2026 2:50 AM, Alex Williamson wrote:
>>>
>>> Additionally, dma_buf_get_pci_tph() defines that the provided values
>>> are only valid until invalidate_mappings, but this series has no
>>> plumbing to honor that requirement.
>>>
>>> This needs significant work if we need to track the lifecycle of every
>>> dmabuf related TPH value.  Thanks,  
>>
>> Is it possible to use this as a risk warning? After all, even if the
>> invalid mapping is performed, the ST only causes performance loss to
>> the system, and there will be no function problems.
> 
> Seems like the sort of thing that should have been resolved BEFORE
> sending out v20.  By the same argument, maybe it's sufficient to zero
> invalidated STs automatically, but we can only do that for IV mode
> in-kernel and rely on userspace to perform the same for DS mode, but
> regardless, no mechanism is proposed to perform such invalidation.
> 
> IMO, this brings into question the supportability of STs provided
> through dmabufs.  It would seem vfio-pci needs to become an importer of
> the dmabuf, rather than simply scraping TPH data from it, but maybe it
> can only be supported in IV mode.  We don't have a means to represent
> that.

There might be another issue regarding P2P TPH stash access, which requires
restricting two devices under the same root port; otherwise, traffic will
first pass through the root port (at which point the ST value would be
incorrectly parsed as stash to host).

Thanks

> 
> Alex

