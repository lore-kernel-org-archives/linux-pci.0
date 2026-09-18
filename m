Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A33BBA1D;
	Fri, 18 Sep 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752837; cv=none; b=dh5cXLORav1eyFI9gybxaEhfU9gzyvWz4w+0XXZ8XUpWTNrEKz1SyuKrbquPjtv5g87v9N4oZkS5vJo8bPnBNVynr1iZtn/ZVCA0Vnw7AIHxxV33hallp6BWHP7AGb13SzLPli/nzy5oLROWjqjwQGzMUqZeuAwehDFrXhpKFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752837; c=relaxed/simple;
	bh=EUR2ay/SbxhbSJ0HqiTFUw47TzdfexHnjBrabD1F80A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nFDREa41OpdoMjTyGd+4E1jbyRF1krt1n9+Oswp2ooTwu/U3zKLC7U1VCelu/QzAqQRCD4O5u9S2Wb1WRqrKK/jIgIZl3JoeLRO8KFjXWKHkuBsiaNiBSTOsWNe3L8t/y50u6vEgtZ7t9UuvMvHVGChK7VfQRNO4CZm3fETCqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYNJ4qw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYNJ4qw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F62A1F000FF;
	Fri, 18 Sep 2026 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752834;
	bh=jPqCA0PRvRC0+/zfORLzf4AIAvw/MERjhvtEVcQRMNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=bYNJ4qw6qHAdpuueqh/HVTAucQAhHjkArtxIZVmLiUVvCjAL1zXrgWsfVvMTiumIM
	 Ceq+OY4XnA8TCqr6Ing2MCnWyWAq+K/BtfpdjuCiI01oVcBgB2ZftuCLUdB3Fq+ckO
	 haSd093YIN6Y97cTHGbflZLSWMroARlkerJGQdTXHpqzoFWfzQyHRsTZRQ2rQkxiWG
	 0CIUr2/EgR41Q4tu/3mI59k6/BR7+ehvCetT8Jk0rCmhG3YUNzOqzVykLCTglBPULZ
	 eKx4OyanSbT61vhhzeA2Bk2HZGvnEzvl5nlyaN/S/KTgOFrvXNyXJ3k+4XX4854B+W
	 TlZ56kckXvdhw==
Date: Fri, 18 Sep 2026 12:33:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Stephen Bates <sbates@raithlin.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Alibaba T-HEAD Yitian 710 to whitelist
Message-ID: <20260918173353.GA1167671@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918082412.15967-1-feng.tang@linux.alibaba.com>

On Fri, Sep 18, 2026 at 04:24:12PM +0800, Feng Tang wrote:
> Alibaba T-HEAD Yitian 710 surports PCI peer-to-peer transactions. Add it
> to the P2P whitelist.
> 
> 2 NVME cards with CMB (Command  Memory Buffer) have run p2pmem-test [1]
> fine, under same root complex and different root complexes.
> 
> [1]. https://github.com/sbates130272/p2pmem-test
> 
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Applied to pci/p2pdma for v7.4, thank you!

> ---
>  drivers/pci/p2pdma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index c8c414af7078..beb1fe20c9de 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -576,6 +576,8 @@ static const struct pci_p2pdma_whitelist_entry {
>  	{PCI_VENDOR_ID_ZHAOXIN, 0x1006, REQ_SAME_HOST_BRIDGE},
>  	{PCI_VENDOR_ID_ZHAOXIN, 0x1007, REQ_SAME_HOST_BRIDGE},
>  	{PCI_VENDOR_ID_ZHAOXIN, 0x1008, 0},
> +	/* Alibaba T-HEAD Yitian 710 CPU */
> +	{PCI_VENDOR_ID_ALIBABA, 0x8000, 0},
>  	{}
>  };
>  
> 
> base-commit: 2ce4ced05cd7b16f3d3430eac021d6184752175f
> -- 
> 2.43.5
> 
