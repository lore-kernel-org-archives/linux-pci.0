Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FC3EC82B
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613789; cv=pass; b=tTkI1SybcssJmwCBVt3SLEka4a1mZM3ZaksitaudDkAdjA1cC34gepecSakCyPSbtN7+6+aFNPIpmFdRmE5G59c0yO015tbhtXHQhpBbR1E9ESvPKVgDpwm2SGjVL1ZwVf8geQMJ84sT8wwC8n7u5SOtHHaT8vfF8cU3CDccaik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613789; c=relaxed/simple;
	bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFjv1pRoTB0OxhdUkiG5mie3o2gGNdXQgnxd7KMDH56J/8fYQJMwqzENpuEWMFeT+cTz+3O1J7DEv9EoIyQBo4X+Mng1dVlZrbljVdTRRd1bG8WF9Vn76NHwkck23tfCRt6+kF+yamwSRwuNSJFMrNG40BrQNlDeNZD2xmHJ5Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLY20tq3; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLY20tq3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d01548ac96so3669725ad.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 02:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786613775; cv=none;
        d=google.com; s=arc-20260327;
        b=aK38GA7XjS6hP1OX+7Y7LS8jutmts+6nuKE0W4m56ZQZ+NQatTLjPKwXc6XYnBFf9E
         rEFDbv25K4rwayl5U7WwN0GduDiiQ+bWBPFTuViiDs6R5SgvekTfv5cnyyKZNePtMf9z
         dtp5SEPyd7WKVLN8JNx3TIoyMW1i1CtO0jTXhwGkp/EB03VtneFO1ULjnlceA/FoOZ6e
         o7QNNMJIJUzI3h37GSSpmSIQY9in/wzVKtAsf/TWkXuwVMlFZMh0s3SDfGbxK2MmBWV/
         2s52T36aIQOxpwXCu0OmEVHm4GRnVSvj4DR4E48d3fSHdS+qrpckViWJfW8L4zHz1gA/
         pc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        fh=lbQkhi7jCFgnKjUUneXHSBUjROP6eQyIVFWPzMvRQF8=;
        b=DK6RP1PAPBNMH1gsFz4pAkUhrZ5kXPmupqEHPw6DGS+r1uiJEiOKkpdvvMNSFGrG/H
         G5ZXET2KYd6Xp7wsHYvUX0wkqt+o9YiNGENuNuog60Ckss9ERLU1xe80UTpm7zI9Uids
         eVgpie7GkGIC7qwpPUgN1DFyedUQaOc7T420e9lDtB0H2kxmEncPMPAe9W5f5rzhdXAA
         aiRlLxOUs/hlIOsOzPPuqia3dNl8FXqF57g3i7NoexsvzrTP376kOlkJ6520R0zihwDx
         TGUyHNT+Ub9lkhvSsm0RB+i2sVF2NkSEQ8kexTbOcgUPWgCygCrKpmXQkwAN3WR9nXsk
         unsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613775; x=1787218575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        b=hLY20tq3DTzgOPpU2TWFvqupEvw6BZf9j3keoSE+Gba2EpwLBOoPs3SQcPLdhbHOQd
         av4LzjQ9lYk8iOzG7fbP90+/67JTKwJKjagYjTnyBsp7LINLmDMXAMkvWpmAAwVUvpVB
         WOEJ5hPHiPAW5JflzYC087QtbgUj9OaqQKBUyQviZTqRro+AWpjLp6W2TORQUC3zlftH
         x00J3FqT8MvEhq5XipmwYmYthJ2Z4yrlDkTn3YRtrL9UiuQjU016jZXv5tQqSGMfeB1W
         CUN6JmXZU6P23klRsBB+8cEq/q+V2fmSeWpK4LPNLpfnOwggw5yl0cHmhsqlOKZT9DAk
         1v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613775; x=1787218575;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        b=N2iWveQX0znDy7D5VwQCY96YWR2Rsmfm5n7meditQCibo8x5iD5Vj28OPYPr7PnsZN
         m8alEw8z9MDYqvnw0JC6nBIihsei0oJFuhVkdBiAtuxE6nvYBKlFUwCww4sv9/LBLt0R
         ZNXkLFotqenEjmZVnM8fefswJ3iBGi+cOkYNTrDPMe8IysQOsBxLahPiPWDY8uoOffSn
         QVKykq2EDVHq4atuUp9YyZpEV0qOqV67QDyEpiOGNDYJR+ruCbAVxSa4Vj6dp6KD93x2
         zSien/gf94isVsAgwYs5639GgL+nOW3BUNwROf3YMCCElOLHMKX3AVVhpuwJpDjMMXOq
         Csxw==
X-Forwarded-Encrypted: i=1; AHgh+RqcfmiPePSgbX/Td9/t/upG5/HKxpTv4oaQO7yOilbxxlgWWvpJEaUhUBGKBPBQMs/8x1rBnbRrZoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMy3q2x3L7s/sOcRZSkglk1rkl1AXrdTQkU322T0NzUzz/EGb9
	nw8ju8g3PPNRTc1zo0/Yrg3T5JrfWUP3sMkZmQWu+3rXs9yUmwi5UT3YBgsKtyo5pV1XqqqdqWV
	WUYpdnOckI5NltjZaO4Qq4b2vxVx8e6Q=
X-Gm-Gg: AR+sD10Q5nAaQPI8XubgF5F5g6V4OuMrMkekIGbH1ZT16MTwiDBHiy1gum8jccxgfA/
	CtiIKt2K1L0yaKEyTKGVQMIVW3rYky9RoqrGHj6XweJSlkYYAxKJ6UpWir/aLiH6885WeCaJCmS
	a76bJpr6Gd1rRZ/1A96pwP07CnAgey3ADgeIfGz1uvbLdhjtnu/aoPqqVz9oZgk5aDhKGDAilAR
	czI54k+zCYI9Dxvl5P2vfMVd7NTG8kwA25JqugNXkqVIdKAExJRy0do5VhyGDzOj5tgGlHUT/hy
	EywtNHzvXjAwL0BqnhuLcnQwRjQ9QIYmnSEjByu6pf03aFg8CV+bn0tFbcoxav7sAbl/bgdDEwd
	rYagXcFGPKs1A1B1BAFbpC4sdoeqYQWrPxe/iENQc5ujL1km+8NkF/27ttYHvvnSvongDgRg=
X-Received: by 2002:a17:902:ea0b:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2d389b9107fmr28401875ad.3.1786613775343; Thu, 13 Aug 2026
 02:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com> <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
In-Reply-To: <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 11:36:01 +0200
X-Gm-Features: AUfX_mydrO4nx0TADc_1KF-ELy8K1d4zi4yvOYINpS4bHvyjdnsvoZ1CepMueE4
Message-ID: <CANiq72nR3K9d0Y--FyUm1yAkww2LaAuYQZ3yHXjYxxfztgMMYw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Wed, Aug 12, 2026 at 11:53=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> This series has a semantic conflict with both the driver-core and the drm=
-rust
> tree:
>
> @Mark: When you merge driver-core-next after rust-next (which I think is =
the
> case) then you need to include the diff in [1] into the merge.

Mark: in case it helps to make it clearer and so you don't have to
read much, that [1] diff still needs to be included (i.e. the rest of
the discussion and the commit I added is independent).

Thanks!

Cheers,
Miguel
