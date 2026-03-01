Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3933506D
	for <linux-pci@vger.kernel.org>; Sun,  1 Mar 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387755; cv=none; b=F1hqLw5XmhRtSinIuZpxrG6YbwT8KbyYqyleRHFF007jpKE44Ea5ZzE1vjCH+Grl86WPmleNfDOzVNtxu62ZpiyaI42TPr/9zHvDquuVk2HxoVxy0y4wcnx0nkvi6yYhIVhH47pcCKwh0rAw51xdVKVMrgSwcwV3tkUpr7mUUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387755; c=relaxed/simple;
	bh=yhgi5eMSXsQDCYKm+CXjR4bsxzX9U+ECNX3EnREIBps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh8s2AbQM+yZLZKEVNgwAqWyJtgWQzusydPkrfMPDgeCXGxD4G5ikxvUn+iM0yIWN6vMpo+/0ARFXJovCD7HEyRuJ2Ko/0M0Qa2uvnV6sf2tTlJ4s6llOnqMyLW2HN+zpUX9f6jahOAccxXiwsFIfl+FJfla5h0rnbwFzodOXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dIrerKPj; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dIrerKPj"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb5c9ba82bso662578185a.2
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772387753; x=1772992553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCd8bTN0yDfsSyi6ZA8FG9Faz13YGXHzhnf02MTH1b8=;
        b=dIrerKPjtw6iWP+dBwRH0Ci9RBi4QAE8rVnJeoI2Fg76E9IxhSGUNGqi7RaYvdv+BF
         cZ702ssNmV2/pOwLexFowpgH6EL4LUzOHaC2R6E8TzPUi9QeXSoD6n6qBMcuL9b5BtY/
         EqtmxRRyZgK7KcguiqjyPckkhPiR7qmPGHkDJY/PfLmhsdxIgoRE+5ESWp6Ub4opPveW
         CzSnh2rO8m8xGo4U1XzDl+YjYutgBUPTCKBDw61xlT2gVgnUYu9iSJXQj+7BpRya9cHB
         1nzkKljJH+32/UTRhGKxtMmAVXIhiIM5KGt7w5niHzF1uhkiZkN3rkRqdZDkkgbLQH4m
         ykgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772387753; x=1772992553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCd8bTN0yDfsSyi6ZA8FG9Faz13YGXHzhnf02MTH1b8=;
        b=A6hDinknHcdT1hwkWse17KpGtH/X66foJyVDG1tjMD+ZxDRV8lujNTU/BL/jKXGjOL
         81e/h+7X4pFhjoLwwZB0/ozrptibkwvf3jD5NwFFos+KX9Ifp+8By/fQoPx9iNjWqqDr
         4RIs7KB207GUPtUU3J7YyhBhqqU+uvWHvqUaAnfjXS5yXapf4Y5wGsfTN359sHV73Abx
         5v8idl1/BRn2d3m7plBKXLjWUljCLsThOlrbr5ynODSWucETk/L9BL8mIgPkjnruJGfh
         /YJH4GeTJPQH6g0N0KwVienDKvHRidcZVYcr5Frov3enAA+65ItG7TFNHhg8uFkf/HOJ
         7TUA==
X-Forwarded-Encrypted: i=1; AJvYcCU/SLehBrir6V0ueZ69+B4JdfSEOofLC3RsGeroxxz2SJdkTenVpd0IsvR7ovaPtli6VwNXZmANnRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSTg08GU0g1j3y6QAdiYC2qi5OwhdtNG4IP1MXsiexHw6f8cK
	Y2P8s1d7w41gO5976Pm+1On0SmKAPNboBo9yGQwx1vJNleQxTA+hgdxhzgSha5bsp60=
X-Gm-Gg: ATEYQzxIvsrKPi3Rz0TGWF86JNWQ8+99r3PJBTAPFAZJU0URAskUzhmQ+Tn0nvIshgD
	RQqZ0IpdvL57h23cRTwcJd7ddc/iF9mAAgIsq/UubMxW0ye/LTxVQZYL05aspkZei7RRx346ru5
	LU7ANsXNUbcoK1G8OBLRF1oz3pEc10kgWyOG2GzRuZP9QdopLownQlKrd9HChSjru8NFAPEexy6
	CU3FFecxhISztZ4mEKvmGwovm8KbtLqecwEG3dxtQgrYoCx7pDd+RcaoKG2mkZmtaEsxpub3BMt
	Wl1b8R98KviL0rHhXiBXD8pMoD0cymIdfhxln88+KC3w3bVUv+LMXXnPuxOWPZSwO8RVj7LzdQE
	97gXLBnxk3k5qQRnpehQ2NAO6yYfAQZ5p8hhkkJtPNCitZoMP6sbfPOQzEk3KVF8MSw9Y5wMDsr
	Ja0voBxH7rSN0jgV/GLlcTpXPhOYB+saCaacyJ5qi0lpEifPHWYKezWLuB744TEQoX5A9F6CHtZ
	SnXuDohauHvHLgvH1A=
X-Received: by 2002:a05:620a:2802:b0:8c7:155a:6d04 with SMTP id af79cd13be357-8cbc8e6817cmr1277844485a.54.1772387752963;
        Sun, 01 Mar 2026 09:55:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f873dsm1033539385a.25.2026.03.01.09.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 09:55:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vwl1D-00000002dJu-0Hxd;
	Sun, 01 Mar 2026 13:55:51 -0400
Date: Sun, 1 Mar 2026 13:55:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 2/2] RMDA MLX5: get tph for p2p access when registering
 dmabuf mr
Message-ID: <20260301175551.GT44359@ziepe.ca>
References: <20260210194014.2147481-1-zhipingz@meta.com>
 <20260210194014.2147481-3-zhipingz@meta.com>
 <aaDxmGoqpjnvmVs9@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaDxmGoqpjnvmVs9@kbusch-mbp>

On Thu, Feb 26, 2026 at 06:21:28PM -0700, Keith Busch wrote:
> On Tue, Feb 10, 2026 at 11:39:55AM -0800, Zhiping Zhang wrote:
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st_index,
> > +							  u8 *ph)
> > +{
> > +	int ret;
> > +	struct dma_buf *dmabuf;
> > +
> > +	dmabuf = dma_buf_get(fd);
> > +	if (IS_ERR(dmabuf))
> > +		return;
> > +
> > +	if (!dif there's any implication mabuf->ops->get_tph)
> > +		goto end_dbuf_put;
> > +
> > +	ret = dmabuf->ops->get_tph(dmabuf, st_index, ph);
> 
> You defined the "get_tph" function to take a pointer to a raw steering
> tag value, but you're passing in the steering index to it's table.

Yeah that's weird, there should be one TPH for a DMABUF, not many.

> But in general, since you're letting the user put whatever they want in
> the vfio private area, should there be some validation that it's in the
> valid range? I'm also not quite sure how user space comes to know what
> steering tag to use, or what harm might happen if the wrong one is used.

If the device is VFIO compatible then it needs to ensure that whatever
it does with its steering tags fit the security model of VFIO. You
can't harm the device - you can't reach outside the VFIO sandbox (eg
into another VF or something) and so on.

Under these conditions the kernel doesn't care what TPH is used, just
let userspace specify the raw bits on the wire.

Jason
