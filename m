Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF511372EF5;
	Tue, 14 Jul 2026 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026017; cv=none; b=gzpLJA+UkC6yp+JH5JzjOXt4BsdoKaR0oJZw4diraENXQGIoG9pdRUZwxmQGauiBXvplpYqzoFu1QKljFPzPwifBNcfOtqB4C0R6spzRciEUAGGY2NVHrxijt+OVR5+t2GuyluretV+v/nQJS/671Ky8HJBU7PoeXBhL+nRHARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026017; c=relaxed/simple;
	bh=TSNtqqT4JCWwZcHTBsf+r9HR3sTRkBLTyVtFrHybw6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ifsgK2xJWeP8eyakLx8n7aaAYmUFooE9Ie8aS1RYHAgzqeM7QZc//DzncPEQGqUVgcUbrjU0Ja6GNGOE6eZNJMPfFVmY9kVNFgh3WAAyfyGL2ApB4eQuYpr0WSKfH+OXtDDj/iKjxk1fEmd3dWF5+nEokvdlZIQ3Bxtk8VHDOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fEA1miYH; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fEA1miYH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+QF7hLk7DP6Hy5cJYYIWwFzMhn4vHAGwM1AzCisx5jw=;
	b=fEA1miYHH1xTG1HjTEQQ/R6Qf83YT6e31Osp79B/tnsTv/JLNCatChC2EmAS04L1AK5dU+W0L
	YMpDwpibrpNx2lxB8c9I4YEMZo/BuOawKttZxA7ave61k3qz0lOXlFmOzmyrDhJcwh9lA7rkODI
	OxEItA2mg2eDrvb1WZp4X8E=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gzwjp4Y6wzmV7C;
	Tue, 14 Jul 2026 18:37:34 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9141840563;
	Tue, 14 Jul 2026 18:46:52 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:46:51 +0800
Message-ID: <0768658f-de72-4ddb-a44b-e91a7e294b20@huawei.com>
Date: Tue, 14 Jul 2026 18:46:51 +0800
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
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260709125012.21784d0a@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/10/2026 2:50 AM, Alex Williamson wrote:
> On Thu, 9 Jul 2026 19:49:24 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
> 
>> Hi Alex,
>>
>> On 7/9/2026 7:31 AM, Alex Williamson wrote:
>>> On Thu, 2 Jul 2026 20:42:18 +0800
>>> Chengwen Feng <fengchengwen@huawei.com> wrote:
>>>>
>>>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>>>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>>>> ---
>>>>  drivers/vfio/pci/vfio_pci_dmabuf.c | 49 +++++++++++++++++++++++++++++-
>>>>  drivers/vfio/pci/vfio_pci_priv.h   |  6 ++++
>>>>  2 files changed, 54 insertions(+), 1 deletion(-)  
>>>
>>> Please don't send competing patches, just indicate the series is based
>>> on Zhiping's series v#.  This makes all the naming changes that Zhiping
>>> declined yet you still included their sign-off.  Thanks,  
>>
>> Thanks for the feedback on overlapping dmabuf TPH patches with Zhiping’s series.
>> There are code conflicts between the two series on PCI TPH and VFIO dmabuf logic,
>> and I also have concerns that Sashiko may not properly parse and track cross-series
>> Depends-on tags for reliable automated review.
>>
>> My current design idea is to retain this foundational metadata patch in my
>> series. This patch only implements basic storage and query helpers for TPH tags
>> on dma_buf objects, providing the underlying infrastructure. Zhiping can then
>> build the corresponding VFIO device feature ioctl layer on top of these commits
>> in his follow-up series. I will fully sync all his latest code revisions into
>> this patch to align implementation details and minimize future merge conflicts
> 
> If your concern is sashiko being able to apply and review your series
> on top of another, then I would suggest leading the series with the
> unmodified patches clearly noted in the cover letter and commit logs.
> 
> As provided here, this patch initially appears as excerpts of Zhiping
> series, again including sign-off without permission, but it introduces
> this massive gap that was previously overlooked as a result:
> 
>>>>  
>>>> +int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u8 *ph)
>>>> +{
>>>> +	struct dma_buf *dmabuf;
>>>> +	int ret = 0;
>>>> +
>>>> +	dmabuf = dma_buf_get(fd);
>>>> +	if (IS_ERR(dmabuf))
>>>> +		return PTR_ERR(dmabuf);
>>>> +
>>>> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
>>>> +		ret = -EINVAL;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	ret = vfio_pci_dma_buf_get_pci_tph(dmabuf, extended, tag, ph);
>>>> +out:
>>>> +	dma_buf_put(dmabuf);
>>>> +	return ret;
>>>> +}
> 
> .get_pci_tph() is proposed as a generic feature of dmabufs.  We cannot
> require that only vfio-pci provided dmabufs are supported, nor can we
> bypass the default interfaces and lifecycles.  This needs to use
> dma_buf_get_pci_tph(), rather than punch through to the vfio-pci
> implementation of .get_pci_tph(), and it needs to honor the calling
> conventions of that interface.  That's what makes this series dependent
> on Zhiping's implementation of TPH as a vfio-pci completer feature.
> 
> Already, within this patch, the caller violates the lockdep assertion
> that the dma reservation lock is held.

V20 has sent with above bugfix and based on Zhiping's v11 patchset

> 
> Additionally, dma_buf_get_pci_tph() defines that the provided values
> are only valid until invalidate_mappings, but this series has no
> plumbing to honor that requirement.
> 
> This needs significant work if we need to track the lifecycle of every
> dmabuf related TPH value.  Thanks,

Is it possible to use this as a risk warning? After all, even if the
invalid mapping is performed, the ST only causes performance loss to
the system, and there will be no function problems.

Thanks

> 
> Alex

