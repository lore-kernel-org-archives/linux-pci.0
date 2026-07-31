Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C207346E47
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480383; cv=pass; b=V3uPWxoKkWdW3fhvkF1J1DP8z1p1V5xYoL9NH3bT+aRvMkLe5Fpj5klwlv3+r9sFfqpd2vKKSHZxhCqMmdDmgvPGAtBoa/VqpVByaHaFGBTBOzJsiBgsjYS+loo+O4PlHz2IzQ3Q06AnFNb0jvCv6jC9dtDLnX7XQSOUM1m7dYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480383; c=relaxed/simple;
	bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbERnLClxch1xZQTvW90dSX/wjL1buglF35wn7xuj5XDx8sgwP6O/5IhnE9MxQj6uAFPvK3Ng1pYNz8x2fMqmS59Pn2XWBcten8ZQtovmGtnOLvJaXfD+ye51v1amvvS0LPZD/s5ooXYgVlVzo1W/oy/NV34w1bs4j+XiUrvDTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHnR1d8I; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHnR1d8I"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf110997efso1055475ad.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 23:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785480380; cv=none;
        d=google.com; s=arc-20260327;
        b=YQleLiN/YcysH0HZ3VM9Y/wbPfHIMF/L7OHXt5/ps+il/1BF57MwMiH1c/iAuw4lEI
         JQk0bDzbC562krFZjbfdeld4ROn+9z/LzZR58AXgLoN1aMTUnOtBoljZ4xvGvituG2sb
         jAK91gH+wbZIIc8NI1K1PAhDpebAKmBIAHF30U575uQCOmoo+WmsxSeaIt47v9lvx/pE
         PgaSoqs1IrbDl6YELKZd6h5sgNFjXJqQqyuMR8hUCD/s4vjuF+iB97JYYgSEw1H5b02o
         IjIrx4Bhd1w/RCXeplxYYmdTRsqtveWiSt6SmgZuiIpQoMKRWs8F8HdqcJIaPwdRTWGd
         JSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        fh=7qdSmsErui9+tQg6FQN95+ttJ3/t/OaCGc7LE3LT5pg=;
        b=Fi/dpxZeYpmtADD09JO4k11K/JTRqrOlY5RlAFwNeLWToBUOfTllygpIm2bT7QZndw
         wtGa5pPg9jZfc/19RkmViinjObMAGNDEOw+JKGg9lnFjs6eKVEQZhtL34lp96wvA/JRr
         EsQT7uHuHsidbZQeHkdSZrlhmJ82wCC4c8JlRAM/JUWV2qesqTwOJ3N0KwIjtag9Tdcg
         ednShvKS+T5GSZrTz0j1K5lpR3ZLaxxDUFD6RQmh+SaW+iSpZDgAq93k406pwECl+P6u
         h4f2+mZDz6wQHq6DWcxdL4ZUEDSAekpvEV56K+w16V0e3Wms6gZV7/AcQguW2sJpH/j/
         CU7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785480380; x=1786085180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        b=QHnR1d8I/TMMKJbGJJ3aw8izZ7RG5URa+aA4KhAZbDqkJRLAM5u4XN+gTfEheCPRqB
         2KMZipuxAp4b/k4FTiHsqZKYgtPVQyY5mBzOSij4/2JFMQyMisjb8doiJWaGsIkBKgOu
         svJaHDM83vcM4tByZM0OZxbgwcmf1awtATooPE03M8/RPgJGUd4Lj2eT14WW2vHwl8uJ
         54X3B3SOEB9R7nncrk8sPxZC9BeDLB4h2nFts0jSJTlrjZa3D+Deu3V+97jE4J1CfZ/K
         YZFqt1ZbXILwW6MbA2Z2rvJxKWwpkWpyYduUHgls1FbIhiNDInIIo0WBGPyiY8nRozVO
         4VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785480380; x=1786085180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        b=KXwhPFnryPNShbQtFPo7a+HUqbevo7/PkpEnDy66882GLt/zyfEjq9Ih7iob1hgcaZ
         76ODc7jX1nDB2G9ALe+/NSm9k31VYdHuLm3VnShiEGXxupAf4wNqTeLgK3R9nzFBf2yE
         d2B+mw8sS/7chj8AM3631FLN3iXdc+a4WXDvL88S3y0WbK4IPqNBCJ2aXch+JlLn9jK4
         wt9uKY2OMfABT7q4kbBYtM/hlFngIwQ42mY8K2MxuewbBAoRaV3bD/e09rHcrgkBhY+Y
         TD9GYZTrMpLsjY89wYOXHtMnMp0oEIAtbE3xdufMTQtqaBb6Of1oCmbsdpfkH+YOO/BO
         GFLQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmO1u0DM1eRWjin8svZwvsAYeArT4nuke0UvrYSV7scDNUB+DKbXZWTlCD9DUEVbteQb3B2+6yCnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6bOrjZcuH8/Fza9E7Tw53zpG1r3tfA1xqJbksOTEP1/4JcgSa
	8rfSxfHHhA/gdVN1ZCFFSr6RsL8MtyGqsZed3xEtHamOnHuYRuORWuJN8C+UzygK2wl3twNhy5u
	3f0mp1nEso4Nq9iJ8vHmkJLCI/oeAG2w=
X-Gm-Gg: AR+sD12fPdCDPfhKRWe9nVBiwK3V6w+wVE9CH2D4Vlw01t7hwB5DftOOFiQxE2ISsZY
	AWugAsiiCVratzIZ+N27LVsddaYoPWdjZOWQQmXu2kb/YomPeobXC2lo0MDbUkXzbjCtapGJtsW
	9BR+o3ac3IcooExCJrlfHWf4dT6NpiT+glbw/Vg7cLZv0HpgveAau9Kdz4awdWEN8kuxasOYUeK
	hycp6R3NL4Bi2DMjnV6Wmh0Og+p6f6q4dh0qtXsL5jDq3H8Bp0pK4GszIivXm3M67hF0CetAXk/
	2irdP4QnKALxP+5wBz693KwBfYmvqoIE4InqOeFY7WAYanexIXfU7XcQNLH46nnQus6oW+pL+j+
	pA3kfooJCNUF/ikBhvTYG1kPIUAo+Kpv7c+0p3UJakEhM4e208QiOyCUjVKLR
X-Received: by 2002:a17:902:ce08:b0:2c9:b96a:2855 with SMTP id
 d9443c01a7336-2d046b459b3mr15748155ad.0.1785480380480; Thu, 30 Jul 2026
 23:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
In-Reply-To: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:46:07 +0200
X-Gm-Features: AUfX_my5gmBTyBxP6uEcBbaVDtTCrtAGlQbEryzjfR6FoeX2UBUc_vHFPgNtGlo
Message-ID: <CANiq72m59O-ruHUvUcZC7yCvu0KV0w_m5vMO4e0rxyHdRmihJw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:11=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> base-commit: b7e5ac83cb16f7ffd11dc23736f84276602100ed

Was this old tag used for some reason?

> prerequisite-change-id: 20260519-miscdev-use-format-9ab7e83b1c11:v3
> prerequisite-patch-id: 405b334ff0d48ad350014f05a2321bdbaa025400
> prerequisite-patch-id: 604b631c81d5423f4ebb2e12ba2d22e9ce371bfc
> prerequisite-patch-id: cb550d94cefe01920e0d3ced2b2bcbecd76f3907
> prerequisite-patch-id: 3bc830839742591460cb86d9472c04f4686dc600
> prerequisite-patch-id: 571058244bc8c7088638d2e3225713011246c7e9
> prerequisite-patch-id: 347c5a3c6dbef9832bfce8419fc23e6e08ba477f
> prerequisite-patch-id: 3e202d988b56b88446f7535e90d3f00cf5f15701

Are all these actually needed? Some seem unrelated (some were already
applied too). The only one that seems needed has Andreas' Acked-by, so
I guess it is fine.

(By the way, I will use this second message to take this chance to
move the modules maintainers in the To: in case it helps, since I
didn't do it in my previous message)

Thanks!

Cheers,
Miguel
