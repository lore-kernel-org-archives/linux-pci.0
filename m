Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924D3AFCF8;
	Tue, 28 Jul 2026 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278032; cv=none; b=Tn9akGjhCxeX9jdyjIbO+Q3ecKqdbE1S0ZMPpBG/LbZIRY3AP/3xG8OBLVO+PNI93TfVyE+L6X4j0JIajdFNfYenamGp3561TldKcbshZuHMxK8RRK834ucdOzpOfy5E7K0O9NS4C1Sw1fdUUxOUUs/DwG8ow4iqYphEfNWZrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278032; c=relaxed/simple;
	bh=CmzNnY87lYitz23fXDxTdawhW4+BsXLE0Xn3eBowabM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVdp9K5y+mamiJ5x+veg492P3j3ThCUZq2Pf3Aw1E3voF+ny1jVaej50c5NYNxTuWrKzAEzc7Qg7Yhd7Abjmcx1+xy36mbw07znS8lLHDtFoDR5PDlmzqtAtr9GeurwCsWVQvoLGrB3Gz5wz3yBe5CAPokbhGaAiIulDpOXZa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RrGRPZNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HW2ClQnn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RrGRPZNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HW2ClQnn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85A7C7A0433;
	Tue, 28 Jul 2026 18:33:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 18:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785278027;
	 x=1785364427; bh=RDaRKUND8/3gk25/lHTP0OYZkkdZ5mqeTDNtxKRT2fM=; b=
	RrGRPZNEic/aojp6xKpKAAjAGcmmu90vMIKI1+cOD+WRWbAStdT982ugouDIHgXR
	WesIaQ/RKqOZvmMkY/K1Q4qBnOUNlYFXSHPbkr72Ex5u4jM0i9u1u1/5H+6ojSsS
	FA21HDR/oH6zIG+MRIXK5QUCI+BqO1+ctwj4/m4xDXX6tglCkjb0j+kGt9XQBpZS
	IPzgc4jYSIm2NjAReoJl/Pvgtod+qbSEm/gcYHXViiOcT8ynmjLUzymsZYXQ29do
	Sz/DXhJwwMmV5Mj7DznRwxxCqRLymepo0LcSD/mAGNOAl44+jEwrKHKIVT7ufyDP
	zUe7uSX/PCq1p+wVlAhW8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785278027; x=
	1785364427; bh=RDaRKUND8/3gk25/lHTP0OYZkkdZ5mqeTDNtxKRT2fM=; b=H
	W2ClQnnixgRUv1/Oz5YOKnsYuR63DU9JhFCASo1mMC6bSNVlo+t/vt1qRk1blhFK
	7KM1TiolrKQ5hHS0ufd9Xh03sDww1xJ0fHNQZ2x/J/wBcOFHVooEwfjyJolZGfhX
	uL5AfNpAeSFYB7LJ/FTHbmUnJHgG+iCDjn6HFZgxHXGVAao9aorGgJDi7u2WCc+M
	gFZJI6tt8u3vMN9n74tMsao0MnAU/505MP2ltjZptIxH8EfJpROX49+IjFbxuLhq
	HnCLYdHBVjhi8feAsKN7SPz5ZEqmvg8kZLsyKbvneNIW3l6yejQeNB8rlVFSyjSg
	uw2DIiUrpCOBnq3Uo7krA==
X-ME-Sender: <xms:Si5paj-WwcqYbBTuMG9kU4pzxgg4yJVGrBReABFpHqBnyyZj2xaBig>
    <xme:Si5parKkxmQ_xbaVEyK-YtluhC0XrgywDuLwH5AwtMXXYXN6D8wx2Z3cNIuG5R7Wi
    primTl8_boupaeMbNPFj7sjLfu8i4HuG8DHYFrQ1zSwVqS4kkeFBA>
X-ME-Received: <xmr:Si5pavsxleCc8PAzfQ-RyC0cnj2X2PzHoAXwLCl9rm_J3mdB3dlPBOKQdmeJew>
X-ME-Proxy-Cause: dmFkZTE60u0wQVNp+1V1P8Y+ugG4Mm06p+BCTZSg5m2nLQpQOas6Eit8OllMj3iEIZ2ABj
    BngHGmQ/gxbFAMxadefXCJSTqZoKDPYmBc0OSqCf8hc9bmxpfIUdPZLRGy5yN+orhBfBG8
    upvAh0qUf5Es3W8zNg3VX0NHl8usvyXS9yEAJyCWngbDDymLn/P/QUzGkGBufy15NhJmZI
    FmxhUWO3IprDNaG2PtQtZaB5wV2ZjiDAnrzr0T8E++k0jJiZZkrOGHw8hCYG2jwTjHfMoe
    B/wM+qNsuCOhBC0/DZyuLGLJOcil9CmdmhATovhEbXU4Cp7Bfcjk+pLLvfElUjFKwaoUa6
    eIWB89NS++2O3GxK7k2WT+qklu6X7IhmjZsvr6gflrFh2uvd0jYoiBPdJ535J9hTca/iyx
    yx5/6kyW4iwU+p/JW7SafK0ofi8GxZrSkBGsiv9NoA+YW6HakRDKseDRN/w7T6azIHkhzQ
    KlyssLfu15iSAjMZgB6iD1IGmjOKycByclIFRfa5/Dk4nJpxmcRVwtBY0IFJVlXW5eZqZn
    RvpOkzxJBv9nGUgZIgJzfh7KZZkm+0jpeuSZVsV+Mu7xqQr9atfq8Wjaety2BNmnJ5qJ7l
    MF+7Ke6UADF8EjFZt1pjpa5pZmy/6vGP2lx7mO998R1D4/Y22Dnro8ft1F6w
X-ME-Proxy: <xmx:Si5pasn4c8CjgFVz2cqecN6Z04ZQnaBj0mzjN60GC002Sd2lqaSjeA>
    <xmx:Si5paunPe_JfaumlO8NwR6gZ6ueKy2RUw4wyy3pZeE10RvAbnHZMwA>
    <xmx:Si5panh3q8cYYyozTc2Xk_rq_-BpS8okiCyNGIxuJ7BQh7AiZqTsfA>
    <xmx:Si5pagFf9kC_SZjX4tn-wkb_e6Z3587H0P7L8ID02l2uk2-fNxHqQg>
    <xmx:Sy5pauuCSlAZM2GjEPapQUpAv9nraqlOi7BfM96zoKuh0DvwLwPorw4Y>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 18:33:44 -0400 (EDT)
Date: Tue, 28 Jul 2026 16:33:43 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Kevin Tian
 <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, Longfang
 Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>, David
 Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal
 <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Message-ID: <20260728163343.2a39a8d1@shazbot.org>
In-Reply-To: <20260715174737.15287-2-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
	<20260715174737.15287-2-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Leon,

Please see below...

On Wed, 15 Jul 2026 18:47:24 +0100
Matt Evans <matt@ozlabs.org> wrote:

> Preparing for a refactor in a subsequent patch, split the pool-related
> release code into a new pci_p2pdma_release_pool() function.
> 
> This allows future compile-time selection of a null implementation for
> pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
> P2P-related files.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b2d5266f8653..498bca257419 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -226,6 +226,17 @@ static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
>  	.folio_free = p2pdma_folio_free,
>  };
>  
> +static void pci_p2pdma_release_pool(struct pci_dev *pdev,
> +				    struct pci_p2pdma *p2pdma)
> +{
> +	if (!p2pdma->pool)
> +		return;
> +
> +	synchronize_rcu();

Sashiko notes[1] a high, preexisting issue here that looks like it was
introduced via 372d6d1b8ae3 ("PCI/P2PDMA: Refactor to separate core P2P
functionality from memory allocation").  That commit creates a two-tier
scheme where the optional memory allocation capabilities, such as the
pool, live above a core layer.  Prior to that commit, this synchronize
RCU call was unconditional.  Making it conditional on the pool suggests
it was only considered relevant to the optional layer.

However, map_types, which remains in the core layer, is RCU referenced.
Was the synchronize_rcu() call here miscategorized into the optional
tier?  Should it instead have remained unconditional?

We might need a precursor Fixes: patch to this series that makes it
unconditional in pci_p2pdma_release(), so that it remains there with
this refactor rather than becoming part of this new pool release
function.  Thanks,

Alex

[1]https://lore.kernel.org/all/20260715180521.3CDD61F00A3A@smtp.kernel.org/

> +	gen_pool_destroy(p2pdma->pool);
> +	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
> +}
> +
>  static void pci_p2pdma_release(void *data)
>  {
>  	struct pci_dev *pdev = data;
> @@ -237,15 +248,8 @@ static void pci_p2pdma_release(void *data)
>  
>  	/* Flush and disable pci_alloc_p2p_mem() */
>  	pdev->p2pdma = NULL;
> -	if (p2pdma->pool)
> -		synchronize_rcu();
> +	pci_p2pdma_release_pool(pdev, p2pdma);
>  	xa_destroy(&p2pdma->map_types);
> -
> -	if (!p2pdma->pool)
> -		return;
> -
> -	gen_pool_destroy(p2pdma->pool);
> -	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
>  }
>  
>  /**
> @@ -946,8 +950,8 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
>  	struct pci_p2pdma *p2pdma;
>  
>  	/*
> -	 * Pairs with synchronize_rcu() in pci_p2pdma_release() to
> -	 * ensure pdev->p2pdma is non-NULL for the duration of the
> +	 * Pairs with synchronize_rcu() in pci_p2pdma_release_pool()
> +	 * to ensure pdev->p2pdma is non-NULL for the duration of the
>  	 * read-lock.
>  	 */
>  	rcu_read_lock();

