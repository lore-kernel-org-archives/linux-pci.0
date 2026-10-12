Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DE393DF1;
	Mon, 12 Oct 2026 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786439; cv=none; b=GmyxvWZg4Sj5qRN2L7gRw+4rSRPveeNlPbD+hqZU5SkJSzMNYe+2yJNKYAKz71+9tZ9SCJvz4Yi7IOZ/H5++Y2WVfh8kr3k1a2ow2arSFH0OpHeE7Mt0dv4/g0mc/5EkdVdBYv4bS6eosZfCiCXzeZbzE7y02+TkcuNGxzlMRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786439; c=relaxed/simple;
	bh=yWb5bwltfss4zISB8mgE9EbcfqTnGziOD4w5WerLJi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwOCshda8UQ+TupuYMm2E2Qd9fI8reuOYUOWTmtaeRLk5G/P4AH9CTo6Jb85b8CNRQr3S4NVjVALO1+n8Nyk4lAQfA9BCC4SZMIQrZoyhZ6mc0QOdw4WpynMxsl8qZugZvdXpLXgvq4h1k3fNKP7rjdupZkk62oTvUEXGChIQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIsYZJYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIsYZJYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509791F0089B;
	Mon, 12 Oct 2026 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791786438;
	bh=3CseviqKwc3wAzIvwt9NHYniqDq3QffXVJkcA0Kx9js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JIsYZJYDCoFa3Pon8+Oc1DTFqd09qDtMwHcMf/lV4SARJXBu2x5tNlQmbxr8lqnwF
	 nLnbZPBn9oeKRTreqP74ML7MemI/rTwrQRnagjtkhiZVw1ugPeNb6SQKgpgLYMiJHp
	 sPSgtAdu6NymWXLHJ38MHt3Avxfm6A9Gd3NHsgIbgURJY7UFxQD2TKXIA46P1QRutL
	 t+CcwG6rOX/1ojcKfvGmgmTVx+Qpq8k0BCt1gurJO/Sd7jBssGjMekZIGmPZQgeS8L
	 0I3Bs8jjFwy21xDzbQLGM+WUS7YLDuq5fCJxKsmRe+iYSd6BCRhB59PE/TU3bEM98m
	 dspDIcYK5+axw==
Date: Mon, 12 Oct 2026 09:27:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 3/9] dma-buf: Provide dma_buf_set_name()
Message-ID: <20261012062713.GE27033@unreal>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-4-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006193643.76330-4-matt@ozlabs.org>

On Tue, Oct 06, 2026 at 08:36:31PM +0100, Matt Evans wrote:
> Allow exporters to set the name of buffers, during export or for
> subsequent updates.  This is useful to express buffer-specific debug
> information, indicate state particular to the exporter's usage, etc.
> Only exporters and userspace are expected to set names; it isn't
> sensible for importers to do it.
> 
> Originally, the static dma_buf_set_name() was used for
> DMA_BUF_SET_NAME ioctls, taking a __user string parameter.  Export
> this function as a generic set-name helper, taking a kernel-allocated
> string.  The SET_NAME ioctls now locally duplicate the __user string,
> and use the new function to set the name.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/dma-buf/dma-buf.c | 84 +++++++++++++++++++++++++--------------
>  include/linux/dma-buf.h   | 16 +++++---
>  2 files changed, 64 insertions(+), 36 deletions(-)

<...>

> @@ -577,8 +549,19 @@ static long dma_buf_ioctl(struct file *file,
>  		return ret;
>  
>  	case DMA_BUF_SET_NAME_A:
> -	case DMA_BUF_SET_NAME_B:
> -		return dma_buf_set_name(dmabuf, (const char __user *)arg);
> +	case DMA_BUF_SET_NAME_B: {
> +		char *name = strndup_user((const char __user *)arg,
> +					  DMA_BUF_NAME_LEN);
> +
> +		if (IS_ERR(name))
> +			return PTR_ERR(name);
> +
> +		ret = dma_buf_set_name(dmabuf, name);
> +		if (ret)
> +			kfree(name);

<...>

> +int dma_buf_set_name(struct dma_buf *dmabuf, char *name)
> +{
> +	if (!name)
> +		return -EINVAL;
> +
> +	/* dmabuffs_dname() won't use the string if the length
> +	 * (including terminator) exceeds DMA_BUF_NAME_LEN:
> +	 */
> +	if (strlen(name) >= DMA_BUF_NAME_LEN)
> +		return -E2BIG;

BTW, in-kernel APIs generally avoid defensive programming, since it adds
overhead for checks that callers are expected to perform. The caller is
responsible for ensuring that the name is valid.

Unless you're writing code specifically for out-of-tree use, which is
also contrary to kernel rules.

Thanks

> +
> +	spin_lock(&dmabuf->name_lock);
> +	kfree(dmabuf->name);
> +	dmabuf->name = name;
> +	spin_unlock(&dmabuf->name_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_set_name, "DMA_BUF");
