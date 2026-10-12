Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C64322F1
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797951; cv=pass; b=j3+cSI98CVGX6pyZirw+B25bWXi8p+7I/65nDSotPrK8MkykEUix3tyFpvLWbmZbHUWx1ZktMHxo39vb0r9qQIa4hRYIt2QVmyVrjGrdM+09UxmFQEMyS7UuRpkt5JPte3lBcq0xrXeRSYDm121Lfx5npmVKhrK2lrW90gtkNW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797951; c=relaxed/simple;
	bh=p4eOAQSRydUrFhv9tfWYY8SfGm5O1qYqWKsd24mVNSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoUgTokRiKh8pYO1HLAyuzn3KGF7xnyxoS4IyK9JvGw3LWAsxSX+guNEPf0YwskepUx197/kgVRjOy98AV7ee/UqGhbINUkcGm4x2IZFiKoqaE79ZEUYA2k7IAoAB8zqWhpOuc/5k0/oG2L8y8JaYHVNHQi5TOIsGCfJ0+YOFzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDIELTuC; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDIELTuC"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-85377c8bc96so622476b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 02:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791797950; cv=none;
        d=google.com; s=arc-20260327;
        b=QVluesgelTRU5s6tfW/6IX07ZAM6PNNvxTXqjg9rnrbMw6bTXSIgYKm8LZHaFj6v8K
         UF0gVqgi+fttf1ZmA+3f8WLRI/vN1ploWnHzcsIwUvCjyCibia+HgRD0nigRX06RyV9M
         JLBChvjOuRQMlUVZEx3vywEfEcQd8ksjuB7izqi39UPlhvxvgrdXxqVvQzqB1wKbHLrZ
         JBJwRR9BvmxS+ASoraxovrEWzQaBYkeY1+9NHZP/dbZHSCYUGRG9eAjUnkdBwYcXXpKD
         UWFmF+05WCNGvig3IfHnis4pmzU5Rlxj+EyW58rNXRTR79zFEYW+sQQxgsp2n+WxX5H6
         1Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p4eOAQSRydUrFhv9tfWYY8SfGm5O1qYqWKsd24mVNSU=;
        fh=fifV8evSxvWeLgqiziglnegrzSdYKtpXppwNHm9M/+A=;
        b=rd1QwxDt5S+GSLz4GjWtYsQzUCnp3+3rhtlbwrt17oq6tyavNPyAHu7IXGHWZp0kGo
         wG4c82/ukuNHzt/9r70sTWQlfTRTSxdlafEU4sV9nH+dNaSi3OGyQdeyOs0ZiEdqhxHL
         nT9L6n9Z2ORpKRKED/7KyJWtUehTHEid2FHltCFHewdhubeAwQimoqBoL0BlXI/vY4Op
         66aIenP9h+opsOGDq9DBOblsBM+9tdb+AOZcqW615gc/JKuPYyPGMGJGybLBT7tneTlf
         Cp+VDZSaOpQ/jIrQkdmTEZ9n65h2CuvT2keQcSjK8FkGMsavYBQQBq5VlIEl10875eG8
         17Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791797950; x=1792402750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p4eOAQSRydUrFhv9tfWYY8SfGm5O1qYqWKsd24mVNSU=;
        b=QDIELTuC5xO9kvbzF8LipXyAjMFAA/thp46hctNbpAoIVySoJL1TautjHxBObhj9ZO
         dPl+oI3ABiYOTSeTtnC/JdPJWxY4QdUWSxGhj3WEuQxW+/84NFUr1AA1UuUuAAjFnSmC
         M/iH/Dg5eaaMBnsDQraXKFeJsRKokIi2QXFKgjtlqgnrHqG0945ijTqx0vK5twWN6Uu9
         Nk4107QhwT9SC1oi8/l924nXEZRm/Eewq3X7DHZ/c0r6oZWc+TEpffbUailJbmuwYwaU
         cOTD/h3RaujQSO6lcMp+G9QfyyGs9IHye0xDpMSY9amNNp+mzzaaSDhmpi90xtn/Apbu
         NCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791797950; x=1792402750;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p4eOAQSRydUrFhv9tfWYY8SfGm5O1qYqWKsd24mVNSU=;
        b=eKUeDqvYzBGGwUBN4CYErr/XweJ6YX2s0w4cdVKI3vwyV3VapT40wI4esGUSPizRE3
         GfJG6GBybAYhf0KcsIEwmmQwJ01mKKCsmWSS4sY/JvGMAzdsH27dq43XSdac+UAkyV0e
         oc1WzF3QWKQRyVLAN7lHEYUpsfRP8yMoYHF9Pws74cwTW+oARMt8IS/Ta+QmHQ11B3nQ
         X9uvl5cR+X2EbqTCMaZ+9UylZpF8Jdb7Jtbpo1AmzoULqGHS3qnrlyeLgrV+TKyuwUM9
         Qda5NnLPVq0WHPj2raW4zRI0SuGnc6ccI9t8j5m0/8q/O5hoiLWt5YaeXbNr3uryyP5T
         pEYA==
X-Forwarded-Encrypted: i=1; AKwUvBw0j72F39ljktq6bN5Bj8JfZa7JF/T8pcxYYRJS9ogfB5xAhiZhhEc08o5tHnJNDcszD5P65Ymu4Zo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpac0VewWzKmylZneZ1dQa/37Is1PRMmXjhhpoojFC2ra0gw82
	HmKxGXCJsVkH+P38CabS4dklxdZIAgSEp2BM1aIbuKtFmQb2SucUifKt2dhB9Gue+DlCimgHM/R
	f/NR5TdrJyyJVXjOtGWLrAwrV9TEeV7I=
X-Gm-Gg: AYBFou3dfgBbHBoW0Zb2+arai8iBxHvOAen1d+E6H5EDxqSzRvUIL3XRJgND/eXPIxj
	0mkehN5SkbvBM5Q0QVhDfNhwiamAwohAWVaZ6Iu0r+xNdM7OKVcgrcQGwrUJh7UuNwvs9VvrSiE
	bbve56rNwp4yfyf2tDePnLYjyyId9r9vwR3DXRuR1GGfeNSw5Y5BR9KsCo35dnomLTQ3s34S66S
	BHf2drLWnlg9a27ISJT+hQcD2FyL3LRFtrSBfkbYIPbhWhBgW4NYewbwx8dEk9MQOZt+ioK/EHK
	WATTgvaicsSoA1TdfdXUSdgAo8Ykm/7fQfQCgzytighwihbJPqA5s0Q1pjnivHPY8fXyitjcN2C
	dUKBDm2vZOsGYPq/36IXElzGnRMpnOiJqfZxWdJAE3YqklJdD7lHQ9eixRdCwHHEhn/M1+SR3W6
	x5CQ==
X-Received: by 2002:a05:6a00:1f06:b0:888:85a:6201 with SMTP id
 d2e1a72fcca58-897c653b01amr8233897b3a.13.1791797949637; Mon, 12 Oct 2026
 02:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007104847.507776-1-phucduc.bui@gmail.com>
 <20261007204638.GA785135@bhelgaas> <CAABR9nGNoaO-CmTcRvXuMMmGbVSWybKZVBRRZmzQCab_N1EzZA@mail.gmail.com>
 <126200fa-49e0-449a-afac-cc08f4a9ecf3@nvidia.com>
In-Reply-To: <126200fa-49e0-449a-afac-cc08f4a9ecf3@nvidia.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 12 Oct 2026 16:38:57 +0700
X-Gm-Features: AclHuK83I9LwnM2vO4kCLQ6Jq_5C8DsyXc8yQBXyQkkqIo_gLuZ6KKPGtYL1lwQ
Message-ID: <CAABR9nG0rXrtyMuuWOhK-zA0XNsMENuy73fXiq1RhH=GBapFkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: tegra194: use dev_err_probe() for PERST GPIO
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Manikanta,

> With the subject line capitalization and "PERST#" style fixes,
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>

Thanks for the review. I'll send v2 shortly.

Best regards,
Phuc
