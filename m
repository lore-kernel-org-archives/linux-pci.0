Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C22E401;
	Fri,  3 Jul 2026 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040037; cv=none; b=ojssN/l5xrl6B/aFaSCGP7wAfIdClgxefsUHLKHAXjykbla7Pn3imeQE/PsAnt3piZFL+tyfIl8iKWI07AN4Cak3TU6f15Cn7mkT1KEWvDjxy12q8ImWRjRXIW4ysZb6N1r+UrcnAVzw2+Aeoqp5aniTTudAi9zo/0j6PjJlntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040037; c=relaxed/simple;
	bh=CV1gLAYBNBzBLs2L72gHiUYm8mjGxsQOAE78gpgb5WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rnzdg/2HRPfKuMsBvAHMCD3vaWKKYNTGkgAyMXLFRXO1pN1P9M/avsD82Z/0X/XdE1oC1MVC8KP0n/ArAKEbuJw75MJp6wbiXY92N5V9kcAQzxCZOQCJ9kP8NS6KnzzxfvhO5lzq6qNyTTwaDNV9sc8IbOFVu+s2NButldyufMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ByrrhH3Q; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ByrrhH3Q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m836WmrKiQKs0vNEmqPYa54rrmhh5tA0xhJ+9udN6+w=;
	b=ByrrhH3QnYmzyaxeOnq1p1WFM+1SUHSsYguzfffjASSsWnfrtJO6LmHl52tf14L4cjGJUwXOw
	A5TIEK0+sQkjHeYom4q4NSJcyoMYXG6w0UbVQt3udbKCjRVuIT8a34Eka1bE6W+fCzvpDhXBR7Y
	wLQ28wlDWQbojc4hIYu5Jgw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4grw5Z2lfmzpSx6;
	Fri,  3 Jul 2026 08:45:22 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 237604058F;
	Fri,  3 Jul 2026 08:53:53 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 08:53:52 +0800
Message-ID: <ece15c18-0bc4-462c-ba8e-8b5cbbc10a22@huawei.com>
Date: Fri, 3 Jul 2026 08:53:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 12/18] vfio/pci: Add dmabuf TPH metadata storage and
 fd query helper
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-13-fengchengwen@huawei.com>
 <20260702125624.1AB531F000E9@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260702125624.1AB531F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/2/2026 8:56 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] vfio_pci_dma_buf_get_tph_by_fd() fails to acquire the dma_resv lock before calling vfio_pci_dma_buf_get_pci_tph(), leading to a guaranteed lockdep splat and a potential data race.

Thanks for catching this critical lock omission, this is a real bug I missed.
Will fix in v20

> --
> 
> commit cb20e399309e26c4cb897d3a87f672443b48caa4
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Add dmabuf TPH metadata storage and fd query helper
> 
> This commit adds TPH metadata fields to vfio_pci_dma_buf to store
> PH and ST information along with their validity flags. It also implements
> helpers to fetch this metadata from a dmabuf, providing the foundation
> for upcoming TPH resolution features.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index c16f460c01d68..d9c5e434e586f 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> [ ... ]
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
> [ ... ]
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
> 
> [Severity: High]
> Is it necessary to acquire the dmabuf->resv lock before making this call?
> 
> Since vfio_pci_dma_buf_get_pci_tph() asserts the lock is held, it seems
> invoking it directly from here will guarantee a lockdep splat.
> 
> It also appears this could leave the read of the TPH metadata bitfields
> unprotected against concurrent updates, resulting in a data race.
> 
>> +out:
>> +	dma_buf_put(dmabuf);
>> +	return ret;
>> +}
> 

