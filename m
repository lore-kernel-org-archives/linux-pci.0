Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5722415F18
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656268; cv=pass; b=ajLcylgY0U58nkU8Uf0fQA5GNEtKWBFfNospGOudT/FDtrc5FdojHFaN8Uct5ZoMAo7+eYxM6tLxD0spfmsDGR6Ihsa1S1TRzbf22GU8uC88bozR4/YQSbHuoVU/KuC6X7KcgJdkfbds9Irt9e22ACoA9UriUhmP/ltSSpCBcsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656268; c=relaxed/simple;
	bh=fk82OUiWTbfj+Bj8rJw44IZWjsVv95l8951dHoMMtw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU8HGdxbHFipaR7DSz4+0I1OHl+LLL9h+b6crfLUsgb83iFMQDndu47RDUw1lEiZPSiDpIbCjbLiBORYD6OZx0t5MNANkPw1Yy9tUypKvNKUncO4GNS8zvh6+Y05zQlXmgGuY3ZM2YhHc7lTm5dg1wGKMYaWe1z2YIoujXCvZMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=B2YpB9l1; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="B2YpB9l1"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383cb94f742so10816222a91.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 10:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784656266; cv=none;
        d=google.com; s=arc-20260327;
        b=i0gMRYyR58idSG26N2exQ/ij48EmD9eCo8Qdl2mv1BQXzq5/ReRJI3Q1aCmXdyPZ9A
         5KEzosGxPvR20lyNnZD9QlMu8cXDOxIALs9ozLGcguPAsEjburmcfj5pVx2lG89qCVjK
         oCONjHTW3FrTUYzpLgd9YDxed7p6XZFkPHStNrNAwEYP4B3B0bhsjfEf2yyH7xRJivp0
         sW9blmnkbiAjd00gHnHD8Uas6iInhlp0LUOvttewwhP5auMdvdzKPXvEMclu7wB64OVW
         2DhVhM3p0VLYBJgtGDCd82KIC98fFcr8xuCRZjhTDQP60oLQDd20L/MF8Rv1KkMGoRpw
         IbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=;
        fh=PNWen3d79/dOBApq+My+K8LxlsoT7gOqDj4WLIAZRLY=;
        b=JPZWtqWAA8h9ssCJSbQosCDHTOKaDKXgQXTQzyYM905AD+dDSvrkZ7Fu5ZTyCROJsX
         Hme7nmNfqQ3/CYSFySbCoXLTyHlld8q+anVZtv7XO4Ce5Bz5X5qglg0rLvwhGHpIzwZi
         UfU/LOpAKhE0QKlJSOsnOIWy5ERTqeUuyFtSyC3IKzXYEUD8G9vF0DEvhA8NNTkogBDC
         O0rmImhabrhDpp4h1PMQQ9MLXmbggMw459x5bLBXWWHZxbjJJRTsxSQfCurE1hQqvteF
         9sdU27xbDcnGsvveMX8BZpcjBQx8zJqVrLfrEJDc2iPINMa40hzAjPSSTXz6ViyU9ThD
         +E0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784656266; x=1785261066; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=;
        b=B2YpB9l1/TObhAYO5TnNeLkPfQxNXrt4FLbJyfF4b6YsB+3mtpbrLC451fbUEPr63Q
         NGNBLAOy40rqXGxxjmU5vU/QmC+jmwpBDFL6ttXHav+6+8uSI1bxu2+SDcUQKocYcmeU
         76hn3dxT5HBpSSNFeebJZejdZ4Of6NVZvekz3E/0JEmzyUg1uVZOoqWE3ozRZIz7Yw/g
         aV4g00IZWHMy1bMsdWmPSGpXeuw4SbTJR+fwdbgnVoKtSm6mjyNQNMkQF2BdW73TrjIE
         HHlteqCJSX2KsaZYaghGCnm4F7hyNlV4rp1cwqBvLgVdBAGiQxXY+zV1e3E7rOuSt15t
         wBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656266; x=1785261066;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=;
        b=sasDcl3M0t1U+2bUWLLGe2hmbqZQi/lBjFNAR5gkkbaczW2yQTyFxxM0nulpgCXEUP
         ly1M/woz9mfUqv+m7Zsr71DCFqeNMvrj2nm3roDIYnL5l3q+KcNeIuBl8m7A9T2a4XyV
         D8tvrAyjs0Ghe5u1K+X5OaJuPLa1xLpLZH4cWz+QOjAJ+zGyKmUiweunGDMV+3wFb2hN
         RO/oE/I9tiQJ/FPMk7by8r2/J3m0kfyBq5kYHssXXuhC4wg+jrtgGBNbW6oJ2L7LFJ5I
         IHxF0TgvtYQQoFLHdUn6c/Nc899ORwpgDiLodUsPPb8iA6WpzU6zxgwuVanj2NjR6O9k
         qvNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqb65Z1tkA3aWFEkPWyAfB0rCrpEvSuiCHkkH2XUFpHORgR69IJ8FGPp1223saxK8a0lc+EAwUi9Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzylRsgs9Hp6nrHqmZEZrXyUJyalgFcQxi5V1X0wBSlfQsUNlq1
	CBDoHDV15XPivKB5BJwKtX0aYGHqMHXWa/bJAVixfJ50qQGv3g4Tv6JT1T+cRHemACoWq5Hw5ci
	1E0nUaBlrMbamFURyj+xqde05mSYPM85iHl7u4U06
X-Gm-Gg: AR+sD11Fy3iWvMyndlPfoj6OOFcCzvF890J0vKNuvfcwkd6RuKetzPHSrKrN0Ej6LiP
	1TqLPq1bRBPIAcxedLrNhvk+uhO0uroxiq7BaMcCc7InUIFa8Dw/F4JrM/JHl6OeyTDdJ1CBDze
	tcLHrmES3h/kVpkVlvU3XHh3Ycu12gvy3b9rCxpZ8Yo4MPOytjveQhNsMLBg/+GtgsB89AOr3af
	u6bTrZFYx/uUzalZNU2rNIjD03ab0RDZbbl4ZvNQlNmBIwH2Uwy70t24NXsk8TATa/0sKiy7sHN
	7jSPbZAsA3eN7lnA+hQjuj/SGpCzN2J+aqC4ShTUB28=
X-Received: by 2002:a17:90b:2e90:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-38e4b43c408mr19724564a91.8.1784656266239; Tue, 21 Jul 2026
 10:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
In-Reply-To: <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Tue, 21 Jul 2026 19:50:54 +0200
X-Gm-Features: AUfX_mys0lIoq4Q-xmicA-5OIV7AmcAZv6tYBswRu-bPoovrkHLh5N1N3P5Onu0
Message-ID: <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks you!

On 2026-07-20 10:49, Logan Gunthorpe wrote:
> My eyes glazed over a bit. But one point is that maybe this could be
> split into multiple patches: one patch introduces R1BIO_P2PDMA, one
> patch for raid1 and another patch for raid10? That might make it a bit
> more manageable.

I have split it in v3 into a raid1 patch and a raid10 patch.
I am not sure about separate "introduce the bit" patches.
R1BIO_P2PDMA and R10BIO_P2PDMA are entries in the two personalities'
with own r*bio state enums.
The commit messages are shorter now.

> Also, I'm not sure if it's possible without digging deeper but, instead
> of adding a !p2pdma_unmappable check to every if() statement in the
> raid*_end_write_request() functions, might it be possible to factor out
> a helper function and return early from it?

An early return doesn't work here: on a mapping failure the
function must still fall through to set R1BIO_WriteError, so the
completion path runs the (single, whole-range) retry and records
the bad range -- only WantReplacement and the FailFast md_error()
are skipped.  v3 folds the two tests into one branch now,
which reads better and keeps the fall-through. Please check v3.

> Maybe the helper could be
> shared between raid10 and raid1 as they look very similar. The
> differences between the two are minimal -- there might be a bug fix that
> was applied to one that should be applied to both?

I compared the two sides after splitting: the P2PDMA handling is
symmetric, and the remaining differences are pre-existing
personality differences rather than missed fixes.
A shared helper would be heavier than the two open-coded branches,
so I kept it per-personality.

Mykola
