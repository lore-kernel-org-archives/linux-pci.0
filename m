Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E1514770;
	Tue, 29 Sep 2026 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682239; cv=none; b=JrMDovPQloWkGEs1eNjzM012kt676l9luOHRruCKEihs52KwWmzufFNoDf5c+K1K5ESjC2X91oaW9xHII311DUMXK3F8t7GTOvNaKZU9t+ZdnEeqliwK5OCykEsjJGqvC33pRU+T4TtB1hOFARNS03Dp21h70l+x5BkW0VZ6g2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682239; c=relaxed/simple;
	bh=KbI05H8257pbTzuYfeN0E7QF6PPoH8UPLCkl8YK1WlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwTc6Syw5YVwa6UOwQOA5mwTLRO8FNqsoPCtp+d09vexynYQB8xsJ9JpCjNlovR2KIw1a1eaINu9ImRAKJQV3Jib9+uhrw0Uvjoqz65dOy8ihwBa3J2LYI2E05JAcYWwDLMhw9HJywKbNG8k7oLDUHnvaXYrnFSBddwITrQ3rZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=y72ExFnk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="y72ExFnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790682200;
	bh=odX8h+v3SuO3LBAU4tzqREo252vsuXpN4nbA3pZgk4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=y72ExFnkOblYlkejvfz50psNdKfcbaTHptBCwG5Fs0LSKDtLdjoPF1A/pnJOgMB/R
	 vJl0KHdDt6OAxcRDdxMX1hmmIVBsKAd4EyeBjaC84sNrPxQrmOoWRA5g2rlAOSiAmO
	 IVvfN94A4Jf+aK0UZgxDy4bwu36RRmrgW+A0/BzMrju9b7Krr1ns3Rf285FSCi3J7/
	 RLwxRxZg6UnUsTKvGVwkd426DmWDJuDiORwQqlndhUjncGsGZP5c+X3OjN51rVCD10
	 K10j+YGrS+CJG8YDDDy3ZsJfuryhnGzBffduAaow9tb3p38Hgryzgt2qGrJRPiPk92
	 bl4Jv/7LhEk6w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hvGWz0nfcz4wDx;
	Tue, 29 Sep 2026 21:43:10 +1000 (AEST)
Message-ID: <ed9a25ad-9a10-407d-b910-1b5cbdff88b4@ozlabs.org>
Date: Tue, 29 Sep 2026 12:43:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] dma-buf: Provide dma_buf_set_name()
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-4-matt@ozlabs.org>
 <654a5994-97e4-4a0d-aba9-24090b495da5@amd.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <654a5994-97e4-4a0d-aba9-24090b495da5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/09/2026 09:39, Christian König wrote:
> 
> 
> On 9/24/26 17:21, Matt Evans wrote:
>> Allow exporters to set the name of buffers, during export or for
>> subsequent updates.  This is useful to express buffer-specific debug
>> information, indicate state particular to the exporter's usage, etc.
>> Only exporters and userspace are expected to set names; it isn't
>> sensible for importers to do it.
>>
>> Originally, the static dma_buf_set_name() was used for
>> DMA_BUF_SET_NAME ioctls, taking a __user string parameter.  Export
>> this function as a generic set-name helper, taking a kernel-allocated
>> string.  The SET_NAME ioctls now locally duplicate the __user string,
>> and use the new function to set the name.
>>
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>> ---
>>   drivers/dma-buf/dma-buf.c | 78 ++++++++++++++++++++++++---------------
>>   include/linux/dma-buf.h   |  2 +
>>   2 files changed, 50 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index 4c9add51f9ef..e4ec504e9288 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -404,34 +404,6 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>>   	return events;
>>   }
>>   
>> -/**
>> - * dma_buf_set_name - Set a name to a specific dma_buf to track the usage.
>> - * It could support changing the name of the dma-buf if the same
>> - * piece of memory is used for multiple purpose between different devices.
>> - *
>> - * @dmabuf: [in]     dmabuf buffer that will be renamed.
>> - * @buf:    [in]     A piece of userspace memory that contains the name of
>> - *                   the dma-buf.
>> - *
>> - * Returns 0 on success. If the dma-buf buffer is already attached to
>> - * devices, return -EBUSY.
>> - *
>> - */
>> -static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
>> -{
>> -	char *name = strndup_user(buf, DMA_BUF_NAME_LEN);
>> -
>> -	if (IS_ERR(name))
>> -		return PTR_ERR(name);
>> -
>> -	spin_lock(&dmabuf->name_lock);
>> -	kfree(dmabuf->name);
>> -	dmabuf->name = name;
>> -	spin_unlock(&dmabuf->name_lock);
>> -
>> -	return 0;
>> -}
>> -
>>   #if IS_ENABLED(CONFIG_SYNC_FILE)
>>   static long dma_buf_export_sync_file(struct dma_buf *dmabuf,
>>   				     void __user *user_data)
>> @@ -577,8 +549,19 @@ static long dma_buf_ioctl(struct file *file,
>>   		return ret;
>>   
>>   	case DMA_BUF_SET_NAME_A:
>> -	case DMA_BUF_SET_NAME_B:
>> -		return dma_buf_set_name(dmabuf, (const char __user *)arg);
>> +	case DMA_BUF_SET_NAME_B: {
>> +		char *name = strndup_user((const char __user *)arg,
>> +					  DMA_BUF_NAME_LEN);
>> +
>> +		if (IS_ERR(name))
>> +			return PTR_ERR(name);
>> +
>> +		ret = dma_buf_set_name(dmabuf, name);
>> +		if (ret)
>> +			kfree(name);
>> +
>> +		return ret;
>> +	}
>>   
>>   #if IS_ENABLED(CONFIG_SYNC_FILE)
>>   	case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
>> @@ -874,6 +857,41 @@ void dma_buf_put(struct dma_buf *dmabuf)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
>>   
>> +/**
>> + * dma_buf_set_name - Set a dmabuf's name
>> + * Intended to be used by the exporter to set a name for debug
>> + * purposes.  This can also change an existing name if the same piece
>> + * of memory is used for multiple purposes over time.
> 
> Add something like "Importers should *NOT* use this function to overwrite the name." here and add some note under "DOC: locking convention" how this function is supposed to be called.
> 
> Apart from that looks good to me,

Thanks, Christian.  Good point, done.

Re the locking convention, it appears dma_buf_set_name() is agnostic to 
whether resv is held or not.  However, rather than adding that as a new 
category to the 'DOC: locking convention', I've put this function in the 
existing "don't hold resv" section.

Whilst conservative, this matches existing (and this series's) usage, 
and can then be relaxed in future.  If you think a new "resv is 
permitted but not required to be held" category of API doc is better, do 
say.

Thanks,


Matt


> Christian.
> 
>> + *
>> + * @dmabuf: [in]     dmabuf buffer that will be renamed.
>> + * @name:   [in]     The name of the dma-buf, allocated with kmalloc() or
>> + *                   similar.  This takes ownership of the allocation
>> + *                   on success, which will be kfree()d when the
>> + *                   dmabuf is released or a new name assigned.
>> + *
>> + * Returns 0 on success, -EINVAL if the name is NULL, or -E2BIG if the
>> + * name (including terminator) exceeds DMA_BUF_NAME_LEN.
>> + */
>> +int dma_buf_set_name(struct dma_buf *dmabuf, char *name)
>> +{
>> +	if (!name)
>> +		return -EINVAL;
>> +
>> +	/* dmabuffs_dname() won't use the string if the length
>> +	 * (including terminator) exceeds DMA_BUF_NAME_LEN:
>> +	 */
>> +	if (strlen(name) >= DMA_BUF_NAME_LEN)
>> +		return -E2BIG;
>> +
>> +	spin_lock(&dmabuf->name_lock);
>> +	kfree(dmabuf->name);
>> +	dmabuf->name = name;
>> +	spin_unlock(&dmabuf->name_lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(dma_buf_set_name, "DMA_BUF");
>> +
>>   static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
>>   {
>>   	struct scatterlist *to_sg, *from_sg;
>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>> index d15b2b31d3c9..952a2c196ad4 100644
>> --- a/include/linux/dma-buf.h
>> +++ b/include/linux/dma-buf.h
>> @@ -571,6 +571,8 @@ void dma_buf_fd_install(struct dma_buf *dmabuf, int fd);
>>   struct dma_buf *dma_buf_get(int fd);
>>   void dma_buf_put(struct dma_buf *dmabuf);
>>   
>> +int dma_buf_set_name(struct dma_buf *dmabuf, char *name);
>> +
>>   struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
>>   					enum dma_data_direction);
>>   void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
> 

