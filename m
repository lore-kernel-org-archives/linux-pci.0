Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A6415F13
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750575; cv=pass; b=ut8hw18Z1O05PQ0TYBSxiNWxYHw+IyLTVY83h/qnYpn1SDgZW0WJ2FXSVjO4UEHvc808EsG76NvKyMWj39rR/clf6FN0+VU6p/PgrbBPHzi12Wl6hnHpALZe2I4cDVsxt8TqteR/MPyBps5WdcW4nMeAcMlHQXYq3O1SAmmcsis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750575; c=relaxed/simple;
	bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koKnGsqR+S2uf0d4UwGXZfUsbGkTYR/7j8t+2LFaPo9FgxucSj6+GKaiDJJv3BuxPIAftT2ehLAVQjCAQfJQ/y1xcs4Eh+oCuP16qJFIrUH6p/BAFDC9xXvPIW/AYBGY2tckt+uV8LSAGHHUir7jTiP7FpSDSu8jDykfXG4CpSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=fVqSFWa8; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="fVqSFWa8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383cb94f742so12194777a91.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784750574; cv=none;
        d=google.com; s=arc-20260327;
        b=JkLJsL3TlLibpUZDdKaP8q67PVfbpbyAvvIXgwdOaCBmPeiEo8v8Tv23Py1mncHJqw
         Q2rENxLCJOgEC3Ll9a3lcSO9Fq4lrulAu85kqfgcGWkR9m+aQoS4uiHa4b8ZL+zSFsv2
         BKCCGbp+gUyYZHqzWIUyNXk5+Ppf7i70CR7BQSesvy+gPV08JhWZf4M03wa9alIjsexu
         uAQiKo91uPkm0R6GrNmvwIpj2tLDGDOTdhy7B7W69KG48+yHrBWkQy7Yl8c0klarVUyv
         zXq+bjBTN/RciWFPbQHS1ngjkZcqr+Dt6GanW1RnSKzncl9ACLnHQCArV1SVHBGOjXWZ
         MEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
        fh=ruq23KFOTQljaiA2d06mAn2WQuV6RRxMSIUHBdhRNXY=;
        b=VvksNzo5pTqCr9l3zPTUb5qgDyu3faCWAUXtQJUE466zrCPWTKKGqDEWmExj3UVMvo
         60sbmzkCCfM/mMFjekHKQVwyx3Wj7vZad1gnM+nyyXHKduYc0MUslVnE26L9VnMJ9Htk
         +JvX3xtKfLI5WkoiOiFuhA2C+eNZumUp8Dsht4TAOIZivWwTHF/+wVpWcs/Fkg7kECLR
         tUMlv9bZAs9ZMHyjT+Gcj1gNu5tl1+e7rx7pURPN7LoG/7HABptd+Gs9bP9ZQlIQEfIs
         TWFmO4tCyvppBkDMwGRKdBctR261JCBTpd4jcuh6OloasCzj5EV+ZcpM+r39YmbbhoBE
         J/yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784750574; x=1785355374; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
        b=fVqSFWa8CR4WGP03THynVHBaqIQzRh1S9Vl7PP6rUAN/da1I02prdrIB2JF1bbV1L1
         jHKk3cp7aLmOGxcp8y0PLLD7sZMFWl7a3pBjaCJUK3J71I5PCfocLuZiopCUpIXu+sxc
         BqX6U5InP7Xn9YJ65cTQQJTHDnd3tuWpL3HpGZCceJkKdASxEA+FTIYKo03SN1HBJfms
         CP8NrqIzfmwRbKqLu0AvRKYacacnwzJh1HiFGTm2kgQbtz7nNj1TKnS4wmGAaHF+t0tR
         7Y4IFgR2kWg/Ef3Ej0Tcvd5EeTM+FiGokqFpY+964NguHyTc9n5FCXVcfXaAzqJ1xbnf
         pRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750574; x=1785355374;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
        b=tHWXq040Crr55+kezZQDHEI3J4PXiLglb+yM5kidrwGzY0ovF0HBreZc4RGbgC7l+8
         dE6RK1e5K48EiUJPxNKqFtuY+/EENLRm33yBD2OPdxmxSTMfPR8QbmJyyTGNWiDUyrLP
         cRwt5mMvvTa/6DOZykFN4VxaSMCRgrQeV+hwNNKV1wTmY/y4JDOZKvWWi6kVj/U5LsIN
         M3haq17tPfn2+j9JzfofgK3sMRnLI+6xQWGWyaTxkNSvsEnZU93VotqrrbfkPvTVWUSo
         pvFcdingCohv1GXlw1/J8ie0FOzYfk+5Q0m+G1NtA5gZpCSLFuAJN0b7dFewySabALmR
         tI1w==
X-Forwarded-Encrypted: i=1; AHgh+RrRI3+F9qkuVKdb2KSo9NOzjCvs2c4ic31Xpfg24dQjEG6a8Q+5E8oadNh/T9gDSmicMqu7MxZIBCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKIOqjlWS3JXEuYrpqgAdQIYeOCORXgEn2z7KljvjJfzBbKjI
	UKs0hJqfoYWUJcddraj1SIArAI2tlntJUGJZtvXAXEGJ5lVDb7NJO9qlemRIiFLrEklm/1qFVzD
	cWFzNwiqiFVwSid8uAuNBGugPyOPxsnfxTrK25xAI
X-Gm-Gg: AR+sD12+uOaCbAMUtFJVc+oTlBGRaYG3F6JLSJH7mt9zBfjleIFfZcjeAAQnHHZL9o5
	SnGq9MyppQEdRquv/+QXA+mxE+Z44fq2OBHOETOGSxfrTHSDAzb2Eq7kmb7xan+EoqV1xnKRpVg
	n7InEwTwfSkVWpBlU5ta8d0xjxqUk+1iSfSAztcGdmoMG4a7rw2Afvisdw0i7C4Q2I4k2/+yREF
	7YoIbPYr4CzpPoA8T9/brXpxb1WfnuimsUGHyd5e5dNNitokrWXr+MgGRYfmTOmK7q+5iByDQ79
	D2j31bUFHJ8gXkmqkzd69TZ4VwWb1oXzKZybypK9wM5BZsXG9vdpxVnPuuntEQJ7DWu0w5rDULl
	9J9rjs/Yxd3qA7y1xSGVGzSbeXtEVUq/WgPO4leY=
X-Received: by 2002:a17:90b:2d10:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-38ec698af76mr113249a91.15.1784750573899; Wed, 22 Jul 2026
 13:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722185841.449934-1-mykola@meshstor.io> <20260722185841.449934-9-mykola@meshstor.io>
 <536428fd-9c23-45c3-be0a-5eaaf8f3939a@deltatee.com>
In-Reply-To: <536428fd-9c23-45c3-be0a-5eaaf8f3939a@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 22:02:41 +0200
X-Gm-Features: AUfX_my0hGYZfb89FIks6uN6jtY1SapXkJQfTk3Dh1NK0AxygDAcUpRTP3iNF6Y
Message-ID: <CAPzsNDscnb+fH0XZF3qBDgxkREmgh6F=rp0GO18Wy7gLc=4Ldw@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
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

> I think it would be better to
> move the code more towards similarity with raid1 instead of diverging it
> further.

I'll move bio = r10_bio->devs[slot].bio; up into the declaration so
raid10 matches raid1 in v5.

Thank you!
