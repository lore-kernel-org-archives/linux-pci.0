Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DF12FF164
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619462; cv=none; b=JcP6zLTASwEHq1TAA/hYM1knU/4xwFxCkaIsSTl9HW+FQ+moW2MopEtnZe/UF/xfWpyuqSY6RV8Zz4Na5sBVgU4n5DONSfGsz/d0t5fDC6IYfcpcrBFaSw7/CPbYYv6BJ8xmCVkdNFgEdhmYNpJ2TjDHUu3zku+QBJlixBooZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619462; c=relaxed/simple;
	bh=4K4OLHaqM/t/HXgyCFJoyTmAZzqjtCmqUqovtxJuMsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5XWKZqDPvq5q+rJ+Adq9dLyRDlp5rvcQ+HB1z6zsva2Dqb6ViQjSGnaQLImSakQRtsMZPkwQf0asdUOAyKLft6p7WTqEK60ukvmUYlJ6BEytkg8fYesZB0sWYIcMp24/JR5JqxTo/rHRzd0C8RWWzvT5zRSh68IFxIamrEh0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NSvCk+PI; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NSvCk+PI"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-502f101d1cfso69152761cf.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769619460; x=1770224260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x5PPbKkTts0Y3gVIJ6pivviiM6v1XzmJpI/qsHikqnY=;
        b=NSvCk+PIgibHYCb0s3AdIGmdLI4QoBnFvDwKJuBP5DmiVW4yY79sJBf8qYBpOmDO5W
         s8uZeICawl1lVSPl0j34z6nCA3cC8ov0GbfWxFDPCYv1SaI3ci/SCe5k3h8tsfigeUsY
         RvLaI+VQqmAxSVnTJk47FWIRbTEfLfdLiT4oJ7Pa5gNT9oLy5IOaTMH34pLKFzUbPqvy
         KbQGVbRBLnVQ9UsP21MMKtDg6LPsUeLR9BRcU593Nmdr9qhbLnsy5O5phNWpSAojHfip
         oxPPubyWn1/0lV1ho0SvwtUhVoXMzhD3/k7PzFHAWVXpEi1TqTuv/tXK54d994vX3vkm
         9MPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619460; x=1770224260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5PPbKkTts0Y3gVIJ6pivviiM6v1XzmJpI/qsHikqnY=;
        b=oy1R61fhW9hK+fdjaVATw58y63OenDWlwTYNXYInNlYzqTGhfhG8CImCQKHaStNpZY
         ykC+ilPKyvTUoYBhDToukgR5f67wk27VLtb6bAr2LCbzQ6GIV11r7phA2whWDFF0QWJC
         CtuK6dGtLKGr/yDYovP8uL5lTE6jw4ATPTLPAk22D/eBBgw1Ja0R+TbrC5OPRqP26McB
         Ztc+Fz0Cp5ca3QYxHC5XZhxM3ji6DhFZutUgWG7pcPO3i1RMLZgQ3QI7RNPrhHHhjx+S
         5bfdbU4shDLbE4g5EpGSI5K7Qao5JRBqrJQQye9Dg7/9/25IGo8sp9Pyq8jpyoTT+ywN
         Znxg==
X-Forwarded-Encrypted: i=1; AJvYcCVK0h+Ex2Vanc+ChFfRfqU9IG4eWI29s+3s1cmSi/7BF42jL35wFOylc8ntQTep0slJhbDZ7IMdCEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCictpZqRfDdj9uHor+3UHxzFtxcsMP1rchNLdQt3jBdCx7zW
	gR9aRlE8RKjsHAGgOMU69A3NyjWz8PURNZO99Nk3aWAurHw9mJP0qyynuIGBtu9OdQM=
X-Gm-Gg: AZuq6aIgwSv/9Csssk68iyLLQ4ofRRsahjcUV54I54Xz1cq1DL6Nez0/TnkhdyN+vuA
	DoXmKWOUlgWbZ8gRg3hBqIYx2Yzh1Ox4TE0SVmn7Y3NoNx+K8xrEMtiA6fcRVUD3St9bo+IE+uq
	9/DCdqHS59gaF8w5Cc/apwl98UOFVXUNtRtMBfvB5W+QM6dk/TSjzs6ZL3q42OrTCxKFb7HB2qL
	oCkV7E/MCjmZg1mAB23BKNP7+V4v4ePa9sF/KGqTBPdiuFKQMNw+qhX/Al5Edm6vDyI9wlZwNtK
	z/05TCsjqpHcywNQoEvDxO8SMVpmIJykdJwW0AvReI0nPQgYE4CtM/LDwkcFVnqa/5MZjDbq0TN
	PWhd8YFj5PSLvkU91XlF9vxlKo4ZD3hRHpws/QfnuJEp7AAlCdJuc/JXP26QafvMtwJ+n+oEwRS
	Q17rfZODp99Rhoy6aoMow0ujPg6FByiHzngaZ9V9o5+nwENufWcetYKqloNXeSdP9K0z0=
X-Received: by 2002:a05:622a:592:b0:4e8:a6f8:e3c1 with SMTP id d75a77b69052e-5032f886480mr76621061cf.18.1769619460454;
        Wed, 28 Jan 2026 08:57:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c85b9sm20499826d6.24.2026.01.28.08.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:57:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl8rL-00000009KeE-1DOy;
	Wed, 28 Jan 2026 12:57:39 -0400
Date: Wed, 28 Jan 2026 12:57:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20260128165739.GQ1641016@ziepe.ca>
References: <20260113164923.GQ745888@ziepe.ca>
 <20260124011436.172058-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260124011436.172058-1-zhipingz@meta.com>

On Fri, Jan 23, 2026 at 05:13:19PM -0800, Zhiping Zhang wrote:
> On Tue, 13 Jan 2026 12:49:23 -0400, Jason Gunthorpe wrote:
> 
> > On Mon, Jan 12, 2026 at 11:43:13PM -0800, Zhiping Zhang wrote:
> > > Got it, thanks for pointing out the security concern! To address this, I
> > > propose that we still pass the TPH value when allocating the dmah, but we add
> > > a verification callback in the reg_mr_dmabuf flow to the dmabuf exporter. This
> > > callback will ensure that the TPH value is correctly linked to the exporting
> > > device’s MMIO, and only the exporter can authorize the TPH/tag association.
> 
> > That still sounds messy because we have to protect CPU memory.
> 
> > I think you should not use dmah possibly and make it so the dmabuf
> entirely supplies the TPH value.
> 
> > Jason
> 
> Thanks Jason.
> 
> We already have an end-to-end workflow around dmah (perftest → rdma-core → kernel)
> to carry the TPH hint, across multiple patch sets. References:
>   https://github.com/linux-rdma/perftest/commit/98bfb3679a1e71ec96df6a6d6c8124ac66ebce25
>   https://github.com/linux-rdma/rdma-core/pull/1623/commits
>   https://lore.kernel.org/all/cover.1752752567.git.leon@kernel.org/
> 
> Given that, I’d like to minimize churn and use the existing dmah-based flow, while
> addressing the CPU-memory protection concern you raised. Would you be open to
> reconsidering this approach?

You would need to initialize the dmah from the dmabuf and then lock it
to only be usable with that dmabuf. It doesn't avoid any dmabuf work,
it just makes the whole flow more convoluted.

Jason
