Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F62AD10;
	Mon, 27 Jul 2026 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112815; cv=none; b=ODt0MF6t2YkPBSTUc1zMu5eHmd30SXSENYyqe8JU2OudPZ0lzwHq9KsuyMnK/LN8GHNqzvjSztB6oT1S5ThmD3WvuRl8wIR2LPmdWAcTmHbefRXOnF1sYx130h9/R9Mh1LICCAO49MaDFe4cowP4a/7NmqfT3r74lEBcwuWx0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112815; c=relaxed/simple;
	bh=xiPgo/OGp2NiHHcjABIMk8ATWVJRBd0eeBPp4OsGN1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pbDVC9BASXGPs0AhcnaeKTGNLnjp5v5QbzPH3iAAv5FcLnCqXL1YKmXOb5G7pWKMLXgNXNWnVBhFxb5tZ8b/kYVRauLmmQ1PY3z/dCkZ3m9VU/DokPJeeRjUuzUg2udmsVznxK5Y878CWpY6TYP4GSyaUETTmq+sNRwoA7akB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WohlgxIa; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WohlgxIa"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HmKI9a06sITFJxB3CeWypBAfi6n3eyx6gb5h75hVZ8s=;
	b=WohlgxIa4MofI/u056+FUQS0zCz9EnAEhnFt+/+u0XiZ/1f7yf4kwToT04aNQ7IMDV0mf6nWv
	IN8wyO3J2VuYQ4EFSyUETsT1Bjuf6kozHf66pb7W1pEqvJIuSocYDrqQG0o+gb9HrFN1YRVZr5m
	qWWHsHhaPLyXUMO6HXogbwk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h7fdV2Pzbz1cyPB;
	Mon, 27 Jul 2026 08:30:38 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D76440572;
	Mon, 27 Jul 2026 08:40:02 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 27 Jul 2026 08:40:01 +0800
Message-ID: <f7b6c7a7-1185-4002-b41c-7d21df5b11a9@huawei.com>
Date: Mon, 27 Jul 2026 08:40:01 +0800
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

Hi Alex,

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

Thanks for the feedback. The dmabuf ST lifecycle gap you pointed out
is indeed a valid blocker.

I propose splitting the series for incremental merging:
- Base series: host memory focused core VFIO TPH support, including
  TPH uAPI, config virtualization, ST table programming, reset state
  sync and debugfs. This part is fully self-contained.
- Follow-up series: P2P dmabuf TPH extension with complete lifecycle
  invalidation handling as required.

We will reserve corresponding uAPI feature IDs and data structures
for the follow-up dmabuf extension to avoid incompatible changes later.

Does this split sound acceptable? If so I will submit a v21 base
series with only core TPH functionalities.

Thanks

