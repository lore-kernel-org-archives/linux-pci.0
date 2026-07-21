Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0E415F32
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656328; cv=pass; b=T1N9ZgzwUkeF5qILi3c+ogseiUPb5uk/fmj2qdb8TTbEjgKMZl65ufH/X6RanPhaVsYf79B72rFijNmWEnMTxxo7/vxyRXsm85VArGC2+wfKA435zOV2qVkXuDDAa60KjA1lAFinLBZ/peeeI0kQZztZQIb21CkESNqlx0lUez4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656328; c=relaxed/simple;
	bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ+psMrEzXAmK2PE+Ieh6g8JwuggY6ChyF5JHjrff6h3Kx2XdbyJBOFVPeHhY8DDeRCM1MplzoUm2N6wIeTW65Bns9/Q9xLk0ZDiVpJJ1xZdkii006KUDUNyYh69WccoiPNFN+GHHJQQZWz+NvMTe8ZNHA2oPn/2wAbROPsKBhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=ciM98YPw; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="ciM98YPw"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so9965063a91.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 10:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784656326; cv=none;
        d=google.com; s=arc-20260327;
        b=c3QpmlxkCjB1l9TAITB9bs9dqu3kvitsvhpzf/zUv+z8CAGIFzqGmPMWU0ChiGolNo
         5sYPTXhz3zRbyCajhsE7/uuTCzL/GqT9ewnvk+YNzI8x92BrtXavqoM+NhMpUmpteh/w
         Ite9Axp3cmL/dJVu+6/xNA7U6YQfKPyasOty5fUcd22rpUPY1nrKIq4Wjp3gTsn7s3PK
         FQWnSMBpHjcN/Iv94goV1qIZQIiPLdRfcLEfiZP8hfivyTsm+Y01R1jyc39MYv3UMmVx
         cFrZhY9KXbDeF6jDZ8Dzeg6emXfZQ4NqTirsr5cs/Eks3PLH1RirfYD+AFm/hKOK/wnw
         ql2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
        fh=2TZMSRHB2ARMNriTLL1oztS2DwqJpmmKXOzW+eVWG3Q=;
        b=h/h9oWqskfFEqu90ZYZmu10Z8DVrpCtSam/4b+dx550BO9GYK4Au82oVAuKahSmMuv
         Gaxfa2JPctGcluiAv7W9lKFHjkNDzKv+i0vMDsvgK8RN9MfBZoYf4rOM52djZDxfiCyM
         iXY4isN6Jo1OXpnV2hTLSRFQn3DDTC8u649Xm0K37QH0oyizjZMu4KHerHu+eYIBa3qH
         9gkpIFbGnNuiIB0mEUc8t2SmBu4+jKOVfVWgSttmMlmEBCaGcjeggyKy2nUWg1+V+Pev
         RQk3RP93l+rhLloNVWFB4AkTvR0LHPicTL2gJ4N2QTkebqH+zzLNKeK8s9pP0yWr1ANf
         Bo3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784656326; x=1785261126; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
        b=ciM98YPwwqhVDh39wBw+AH4bzjh7xU/N/H9aik3M5yBvwF1UCf4YAQy5msJ+4GYErU
         GuzrwUMPXRtMbduUVSvtYyerXesojT+AKo6LuobEd3zGS3krQ0v3K3CiO0MoGDlvRR2d
         YwQWsf92fTVscp0PI6EsFqtvArWWi6JlPi+0lXIbcva2+LjMWSheh2y+qebh1iwX6nlv
         /zue2udrnV4TyGi1x/P02OjHk7AWixl7D0avY02fPtazPCrtdPjGHrczQoJgYws2T32j
         ci6WxZ4oInTDjyHSWWDQIN0Y9wR5ZuXOLLouoEKSkL29s6p+QTsUV+pD5bCx2RTmybWX
         MQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656326; x=1785261126;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
        b=NFX4/ENx4PTgECHs8yNF1HlmkbdL1Ivf2HrP1D/R8JLFinske2iTmG20EWX9WfJNud
         aD1IJv4iDLRHNDssN8EocOCVKx8J++m8AeXtf5Tlqweuq/zNeqFh1DKR9fNMHsAF/niR
         hLstdpmeluAT1HpIxJsnw770woFQQKRcS9cU2zRT6lslFcprFxVp9d3OwQK19Hwswic/
         arEe3Q1fFFecnnnz7NrCwsbA8p1c6+qFWDUZCmuknGudemktAcntUoEaCQCYOKfwQ+wU
         tNtKPMMvUD/dItbZ05wsBfTghaumKsji4XWrVVTdULHcohiU0vWKcKQ+wIybYD2XGhYR
         Yxvw==
X-Forwarded-Encrypted: i=1; AHgh+Rom6NO1nDjjWX/EKTsapMPavfEdVLson4o1T3ZyUIWcKQsrg5KKfHNkmOfjMsojDVHfxPfUBRXMJ98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL74f4Wt91Oopnm0wGS+p5aKlAAOb4EX+X4TO0Ym/hDHxatX8G
	0pUmQVO1cOjr4UGiQZt56v7thWPI9uuOfHADTIs0w/uyOWRHeQvElDjDW7ila5QzkhGb4DKVjBz
	N591I0wenJSj7w4VPpUZD3TI9c3w7lRDrzEIw1rmQ
X-Gm-Gg: AR+sD13Xwtnom4R0BSxsuEtmyLaL7Nppf4kxVD0+DQ5EPc283bMUh+HdwMpc9zPxWrx
	CmeCBOPPI7anp4UMceWA1lAsMgKuOhPCAc4jbkfFUxftSH8+0YjIdN3xCusjD6//mR4Q6Ppd5pK
	wJs09vu3AiFnm24Gqfk0mx6CKSTXh7oCSOhKoen7sD7HH6wXMLMadb4ozJXzeaW1ufuE34tyvey
	i0BUUnImn5b6KTkJnbIuhyVm+Jp8yw9CiUAvThexSoAi5BcANGHGoFPSpd4rjaonqU43Gja/mv6
	jQnFsbaEdpibKFct6kKXVtezJ5Oq2dlHJLMuGrQKbxw=
X-Received: by 2002:a17:90a:d2cb:b0:37f:ad36:8fc5 with SMTP id
 98e67ed59e1d1-38e4b515bfamr20269142a91.23.1784656326031; Tue, 21 Jul 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718162547.448892-1-mykola@meshstor.io> <20260720124304.GE110966@unreal>
 <al5IJb-L0FpztnYz@kbusch-mbp> <20260721124944.GL110966@unreal>
In-Reply-To: <20260721124944.GL110966@unreal>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Tue, 21 Jul 2026 19:51:53 +0200
X-Gm-Features: AUfX_mzytkhLoaPSiTn9RmB0hwu7xEFpMpTLbojjFKRzqIcqMRM-jx5SaIRHGbs
Message-ID: <CAPzsNDuY9OB8FWb8aPTpxpVYC0u1ewCmFnvQXfSKQO6xqEJhBA@mail.gmail.com>
Subject: Re: [PATCH 0/6] block,md,nvme: correct handling of unsupported P2PDMA transfers
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Henrique Carvalho <henrique.carvalho@suse.com>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 21, 2026 at 03:49:44PM +0300, Leon Romanovsky wrote:
> Yeah, too verbose and conveys almost no useful information.
>
> Lately, I've started ignoring such submissions to prioritize commits
> from people who put real effort into explaining what they are doing.

Point taken, thank you. Please check v3, I reworked descriptions.

In any case, the problem is real, Leon, I would really appreciate if
you could review the RDMA changes.

Mykola
