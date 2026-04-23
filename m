Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE12D23A6
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984389; cv=none; b=uqkvGpIy1NSByD2ytFHP0+FUvce52A7b9vxqwFmyQqN2gis+n8s59EeYkZ4ahWc79WszYCgcB0Vj9+hsc/3w5v5yjgFTZSCGVZsvvPGmqXrNuJCzHTBwuIsRYV8MWS999/l9Z2eYzg0EyAT52TqzwKUCbSNUdjy5zz9Jj73A04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984389; c=relaxed/simple;
	bh=l9uHSdgj37MlVqmUNMTjAdytE8mxXV9iMRTSDZHL+Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrwCZSuegSKNjWpH3LU72R9HyFGawMwMkDsnGn+JFh6oWOT/SgCwTO0hF9PoKU4uyg+YxX+NfuOgebP3OWjWXv/KUcR6SQhiiTbCB8mns1MQobNiiG4rSEdO+MWSBh1lkUk0pKlf4uxRcAqEdjZkxoSJFBBGytghipRYQCT0jD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gHsocES4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gHsocES4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb20bcff5aso672493585a.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776984387; x=1777589187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOyCcpWY9ETk6/DQ/Zzf9IsC2/j7viPfylDYdsbXpuw=;
        b=gHsocES4rM2iEUWKqG8kp+69ntn5/8KkwOOSvqiYUtEDR23ce6l56FUnFcdYvMklOU
         d4iVS5lIb3Y+GL0Pnq9sDAjar03xr2XnLZije5OdOOdjBatHPNLRzHwLUkXjsDLM25G1
         HPol8Kez21ljDOoCS1nRmB9Bl2hxNYShOzDakJLxpTpzUDnbLkKpVZZe9Hf8si1UWDLl
         /Cj/tkVtPO0B6oC/FFGdIQihVUQjyOgTJxjcv9iAiTPKYvDblGzxvu9aLUQxbRuQ4I6I
         q9T4Qp3qASJDwtuUTFCpGZq4yXMEbbQ+J5KEDDPrrylcADSqCh6vlyled3ozriSBybLE
         EDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984387; x=1777589187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOyCcpWY9ETk6/DQ/Zzf9IsC2/j7viPfylDYdsbXpuw=;
        b=ncPjXhQbvDCNcgf5WJdIvwF6OPS7JgkxxR6LBjrS2Zk24iiuPkUrkLf9mtxt9+fFyV
         BmP/M4A3CNL6n999AckrsbzkOvh+sqN/Gv5Noek4+8DBZP/pnbVlgsxgqG9TqqoVHD6c
         tZhIaunUoAA2de43KcNYNovdHs3X5YnemZrYFY1KQ0iajfLdOq7DLQcFojcE2Ov+Q993
         a1AmMPH5w+JcLi1+rcbCawNWPUCmUl3gaYFYjfkSACVRUjXsYgQMyR7gdIysgalYpwr6
         fxXFQOLLF/fztAaIVTB6zEse7q7f6i6KuBwFKtrhZ7k+vGHphGbhv+a+8NiSS55wTGzN
         EP5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+2ihRsQY2G6c+OCcyflb6rzaWsrT7DJPdaQMl/PqBMnOpkh/pRNm31/J7QmdDgh5O7FvIZi+Aws4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwCzmm5vyZ1uwEiN6/LnL32Bag0/dQrjMapCaQIPpeR42giMkd
	cNv+iJ5KEV+Ygd1DPLBVCRCfy9eHsE7elOnRQVhxwetO58V2BE0CAyp8MQVB1lsUh2w=
X-Gm-Gg: AeBDiesi2FlNDhFavst+QZznLa9pJ6q1JXV4ExJ/nQkl2HWAkWZdIt/bs64ayksJCW+
	hfLolDplrlg1wHdyJ7q5Y1jWfWU/JpXWobrmXw+ul9nTU+iN7K5wDdMgFmLpb2+i+RM9x6AjFxM
	1U3mr5Fi/3De1ZjgWJAMta/Z7WyPRzkqJNVEBQcThq0hNom+TgKVfp7Lv7Q0MkJ5eEgUf8X+5yl
	AZndcqF4+qbNgZC/AQeYEtC+gJzZBq3NJntwsvr45tO1qPU9ffFsx10IJUDfNTi7NrZ9rN+XKXC
	kZC+/BzdziegU7mXWwfuz8H2u6RUmWLpPeVynK7VZn7G95rX0dz6mxHWIc4D+8LUj1evdHVTcgv
	ot/aVJcv4eXghE2NXRVGmMI6+bU1OEYywgmZ9/bTL9hBS+DjW8CnQDDtqcnwWyMVw7LhJs3YEZ7
	vugdBA4DX4zmi42FaVJzHcYXRI2zDU8KbfpsT+ifZ+QF7etrvSoNFNNRR+rjvIRZrpKICx3crav
	WHm26ypH8NnCSb3L/ZQUokUTfI=
X-Received: by 2002:a05:620a:440d:b0:8ef:74c9:daa7 with SMTP id af79cd13be357-8ef74c9e32fmr1451093685a.8.1776984387201;
        Thu, 23 Apr 2026 15:46:27 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d98c15a9sm1970538185a.43.2026.04.23.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:46:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wG2oU-0000000GMBz-0jKo;
	Thu, 23 Apr 2026 19:46:26 -0300
Date: Thu, 23 Apr 2026 19:46:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
	Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260423224626.GV3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org>
 <20260423142828.GQ3611611@ziepe.ca>
 <20260423132016.4a25e074@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423132016.4a25e074@shazbot.org>

On Thu, Apr 23, 2026 at 01:20:16PM -0600, Alex Williamson wrote:

> My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
> unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
> the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
> processing hint.  It would fdget() the dmabuf fd, validate it's a
> dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
> find the matching vfio_pci_dma_buf via priv under memory_lock, and
> stuff the provided TPH values into the object.  It would be left to the
> user to sequence setting the TPH values on the dmabuf before the dmabuf
> is consumed by the importer.
> 
> Is that a more reasonable uAPI?  Thanks,

Off hand I think it can work, with the proviso that if userspace uses
the dmabuf before setting the tph the importer may ignore it. I don't
think that is a problem in practice.

Jason
