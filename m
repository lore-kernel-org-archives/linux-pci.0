Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094DD387569
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749830; cv=pass; b=BibekHGUgUqJE7DCi3hoxgOTlEZfP/hpqS3DUNTluAJ0CYVKTCRiOwo7Udns8hphTApdTu7gW+zRk+MP4iQyo6OiOkusmlvPo04Ry+vCt37wMSQhcOkWXZhfqFNlmqprF59bAd+e6rIHARjjqQGSWVew3qJ/Ux87n6gdTpIUz6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749830; c=relaxed/simple;
	bh=oCdr0VyYuWFniik+cq5m2m8gRYzMe6MoyKAYOFWNB4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVVGE/UKWS4MOToztEigEOKshp/fpA4FgP9i8akspJLauJFDFxsYE9Fy8/ELxkSGWRupcJxk1Q1aR+unnLuvu9eJgoG6N79IqXSDkJ485m3fb1AhQxpxdHpu1VT7PShXpUZM5pABNgjX0Zkoa+hHD6LvNBdScCgbAvaxGklSbGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=YeIXLrM4; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="YeIXLrM4"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so12087523a91.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 12:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784749827; cv=none;
        d=google.com; s=arc-20260327;
        b=CHbPE5WTERjojBofYWpuFLBhyXdVb13MxJH0KCOC5LLJqdoOC8W+5/RMYy1IEir3G3
         S+n7gxD90SdMWpdPu/KvRoTouZEkJjRswa9orvKDg536Hi+X4BmERfOJQgy4C24QRavB
         Lc8enIaug6ZjFv7A2QyIN7Pi3PW3jCcSZ5QPRkUpgXOE2IVFG9iUQeXKk2U7shUKr8Bq
         rRa2e3ZheAN2mShi2hyC8zTASopk/9MNcuSPSJ83vEyImqyM6lzMLRRETmVfx70GKR/O
         9dwPOFnQYSLtz/W8WQEa1lMKEE5qfbw2guqOkPUftFCuCs1JYHQNi8mLfSz5BSqDCF0m
         H9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=;
        fh=1KAIjoZffviRhpWztzuCN5PbSHAwcvHIpBaANFvmABE=;
        b=rI+uOr8KxR8lSwzuNyRK4UtheYCUaX3eOnhZhBMC3pNChDgFNVXYPoKc7OkQHNJ5mf
         zVyBjjt6QXkrw5I69Nxko3oQPw8lOeS7FKQZm2JQC5O4UQAyHWbN0oPgjp6bFytF0OY2
         TKSy1ABH0Ih4M0iomrhJcPUoJHJVCmWQDTh6T7OVSEumQzUm49M4ud/APuTeWiDbr00J
         0Yt+8CgytRSxArH11LjarX0nIH4e3hdvAezE/3kXl/pXRBz4aEpVDSuEqp2LN+xiGUj4
         KrZG0BlPaWyc1qmGpSB7fruUn68lzIpYyoTeC8bXbBBa4gFDdlcl0Pn0Dj9PbO6Zym1v
         oc5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784749827; x=1785354627; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=;
        b=YeIXLrM4K4HgxBCvURWc8JwUoFLnuTm31u0ZBw1QqoSyqXcCXd1B/ilcUDzWDg5437
         qjmIgvAvp9KTAatdM4wTzp53MVqpI6Iptu2xH2fvHG1DdIej/dRvcM/RCnWLDC/9KOuM
         1jqvVvWr0EcNNv9ol/xRweVpHmQO38bdcXge+wQDEYGrAqDjX6goVP/IyBdSht0NdeTt
         p8wiKX5yH4XTkKkZ96PP/zLgXuGb6N2J2Jrg2rMJxbfZY5RyQOwvpINnQIn9D8DGaDMf
         DK8TgMX1Av8WtyC7nH+87La9CI4wxSGfOh1IkBiAlrrbmA6kCXVtqYIREDD8aUaDidPs
         diqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749827; x=1785354627;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L59f6N/a3yWmzrdAG6ejPSTgLStmVPx9Cs1jpRvp2rY=;
        b=aF9jZD7ErTlLo9O9DqpBOvfRqiIvbDy+MuUVc8EKZmkRg5BDBfQbIWyn0DNSRRS6S2
         U00ONuNEDlomw3xERbmOAqegyVk+w2DoflnZJ/IuSQthy40uH8FjrqfA6YfjAKX3rv3h
         n/P5gh65A3BW0oNck/3rbkL2ySKxR1PrKrCyRLrvGqrzdahpj/fnVUfaDHE4KU/xA0qU
         Rd5GOrMJfjgupOJ8b1U95ZGkkJiYxTOoeUOeAGy3H/lAl907D1/KuSd0A4ipXC8RD5KG
         +9qFvos/exy97isPL8O+USoOC4JprY5GZUX8Stqf/VX3jtiQltSlRwn6hLfFJNaz6FyJ
         nMKw==
X-Forwarded-Encrypted: i=1; AHgh+RpSg64ysz7MHf5ymYJiJ1yqFsUth+BNtCJtymm03oan6uawaDgXaFIHuJXB/8U+HrTR2SCVbS4gfHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxp3ufxqlWUt/G0QBNXeB4ihuc+5n0QQXfak0sILCFya7j8tnC
	OHvFoTY/Yzp7d5DTdJYXB9wQMkz5j4bzIQ5akvLKONvPj/+XE76+Cz0hqbsyO4GT7hGK2Iw/OjM
	NifFzyqtjOdXc+HOS1yPvSyAAoJoPPlCEZ/ghOJUa
X-Gm-Gg: AR+sD13esIA6PF7NoYp5ufj9o7pZbyo1HhuYh+cPizmdPhq+df51Z5XWAHC7fcJIqQa
	zMoppqXhswq9azWEeMysIgLyS/K91asnCnDLTCxP3K+zr4QBpIA/uXYgGuVzyny1nXvaLRlBSZ6
	cmYZH51XM389yJM8Geoc9qxQ0+ngKFyHANGv2y84sG9OG6dQTWaTSeakD48gz6y80klsdd7Zim2
	ATahtvKpZC4UIVI2IcAYS7OnhScBJbj67Pst11AQPXkUc1GjyleOXz64E4uwpZt0xpDWkpYBQ40
	ROfLBQgMBvoa/M1x/e+qKM2Sfr3kUK79xVElx81xbsEdV6oKXg4lhUryyu0QGbLomgF4IDuFb1f
	PbmBBVKrpIUae1RyOt+VZGf/pDrj3
X-Received: by 2002:a17:90b:518c:b0:38e:b3fd:d582 with SMTP id
 98e67ed59e1d1-38ec6657a87mr93881a91.39.1784749827092; Wed, 22 Jul 2026
 12:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722185841.449934-1-mykola@meshstor.io> <20260722185841.449934-8-mykola@meshstor.io>
 <38c44536-51c0-43a1-b83c-b94915890aa2@deltatee.com>
In-Reply-To: <38c44536-51c0-43a1-b83c-b94915890aa2@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 21:50:14 +0200
X-Gm-Features: AUfX_mxD5xjrC5SGVG19NWXUUrwiVViRlgsz7kddupZQwNnofwkXgV0KRRHwCnM
Message-ID: <CAPzsNDtmEFf2uyJr+gSs4iw_E+LYiH5+3uojxhGMYKYku+fw+Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] md/raid1,raid10: skip futile retries on P2PDMA
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

> Maybe drop my authorship from this patch.

I will do in v5. Any other changes needed?

> I'm not sure I follow the point of this new comment here.

I will drop the comment; it means the failure covers the whole bio and
won't change on retry, so we record  whole range rather than per block.
