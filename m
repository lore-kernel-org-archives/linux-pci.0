Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4718C332;
	Fri,  3 Jul 2026 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040256; cv=none; b=Dn3dOzcbtQ8GlbD9eNaECajpvisyn7CC5B+T5bmqYnu2sZwr5pOrlNa+Kl0WBU/SgjBbiEgTGLduQKmUQzzK0w7AKrntvWMo87pETpJ/0O5c6ctLmsYys52ZREEGNt+pS/+bt8uIOrtqPYnGjLVhkZjpJweLlqY0K22CvTjAVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040256; c=relaxed/simple;
	bh=oDN0EpHYYPGgv0TR0EmvwjSrWIfNsWVPrvHQojtoDRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PTNJ1EIPHWBj51o3AmOao40GIvnRIag42Yo2zYel3HwA/Jcle1RdlZx6Oh/AQopw0X3nD3rUOACamt0oEXftKbtj504vRL/mguiLr+SxqcgBHAhdvlFDTmglyib3e9cjJSoxdCshA3NuOhMiDkRAjBr3TtNGOHTNEyk1XmI4u24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=e/0vgByI; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="e/0vgByI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=S0WcXr39frQKEACGrOxmO6pcYo/2MisePzd+AmZgwZI=;
	b=e/0vgByIn+EvOB1MdUbGugRkYeDpED8M8aVBjm8x65UHV92VBGksMLf5r9xgoU7jA4hfYXr7g
	pDK8JHUHROnYCvGI4s1NaKjuwJnmeZy79Y5ZFBX2x7qQTdrnQxSeoo9p30Y7hWPLvS7uTyogPuw
	UA+rKNrtToPDHYpGPzwqsPs=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4grw9G6GMFzcb1N;
	Fri,  3 Jul 2026 08:48:34 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 4262F40580;
	Fri,  3 Jul 2026 08:57:28 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 08:57:27 +0800
Message-ID: <b7ab293a-bd94-4723-87be-87f1cf525685@huawei.com>
Date: Fri, 3 Jul 2026 08:57:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/18] vfio/pci: Introduce VFIO_DEVICE_FEATURE_TPH
 family uapi for PCI TPH control
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-14-fengchengwen@huawei.com>
 <20260702130112.D53211F000E9@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260702130112.D53211F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/2/2026 9:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing dma_resv lock around `vfio_pci_dma_buf_get_pci_tph` in `vfio_pci_dma_buf_get_tph_by_fd`.

This is a Sashiko matching error. This patch only modifies uapi vfio.h and
contains no dmabuf code. The missing dma_resv lock issue is in patch 12/18,
which I will fix separately in next version.

> --
> 
> commit dbd8da4bdde63982d3f30b59ace151720f7b743f
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Introduce VFIO_DEVICE_FEATURE_TPH family uapi for PCI TPH control
> 
> Add user API definitions for PCI TPH device feature set, including three
> feature IDs for global enable, resolving PH/ST, and batch programming.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index c16f460c01d68..d9c5e434e586f 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -81,6 +88,26 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
>>  	kref_put(&priv->kref, vfio_pci_dma_buf_done);
>>  }
>>  
>> +static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
>> +					u16 *tag, u8 *ph)
>> +{
>> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
>> +
>> +	dma_resv_assert_held(priv->dmabuf->resv);
>> +
>> +	if (extended) {
> 
> [ ... ]
> 
>> @@ -106,6 +133,26 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>>  	.release = vfio_pci_dma_buf_release,
>>  };
>>  
>> +int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u8 *ph)
>> +{
>> +	struct dma_buf *dmabuf;
>> +	int ret = 0;
>> +
>> +	dmabuf = dma_buf_get(fd);
>> +	if (IS_ERR(dmabuf))
>> +		return PTR_ERR(dmabuf);
>> +
>> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret = vfio_pci_dma_buf_get_pci_tph(dmabuf, extended, tag, ph);
>               ^^^^
> 
> [Severity: High]
> Is it necessary to acquire the dmabuf->resv lock before calling
> vfio_pci_dma_buf_get_pci_tph()?
> 
> Since vfio_pci_dma_buf_get_pci_tph() has an explicit dma_resv_assert_held(),
> calling it here without the lock could trigger a lockdep assertion failure
> and cause data races when reading the priv fields.
> 
> Should this code take the dma_resv_lock(dmabuf->resv, NULL) before calling
> the inner getter to satisfy the assertion and prevent races?
> 
>> +out:
>> +	dma_buf_put(dmabuf);
>> +	return ret;
>> +}
> 

