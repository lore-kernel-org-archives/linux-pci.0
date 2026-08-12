Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EFC390CB5
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552425; cv=pass; b=e4Enh7UzHIDWhsNUkt717sw03lG5d1NneMobfJQHNMW16hNg7jdNwVZ7rsAkeh3R69fA+PG+0EbtNymPMZhlTpff4d1WFKMvGSFYaxCagiIiqOuMWA5tAowcEICv11EfCVymh0exsyHAWArYweid5LpXNBOLcsW/ZcMVcoMfnGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552425; c=relaxed/simple;
	bh=gOIsyGGYeGZsd7+1t35VENt6hUZ6tCz5k0UwrPgrJB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVvvWg/retkM3IxYkuAO9E2shsz8keQn9rD8V2x1H6Dm8ztmWcqqcSxT30JfLJ07K3h86abyTBmWogCdPFqkFU5qupqPH/Bo1fW6+qSVU6NTjytC9ah+6ukIMwQ4zXCxHGQK0XUjp0Rsu6INwZADMtbMUwJcRbpFKx2eMzKRamU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al5TqyfU; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al5TqyfU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccae46de39so2130075ad.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 09:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786552423; cv=none;
        d=google.com; s=arc-20260327;
        b=CxuFjVlkHsLWRmso6iMTX+RNBmxm3F+xglB2MjS3SFc8bIh245w2lGrFzX1x5wPJP3
         hx/UmmZyXrq4+nA1qSP5Z2NS0bAYl8GNlK2JVsaEjTCko9wFBy2ejrC3Z68+ddJMwHSL
         X2I1Xkcq/QVxMmVEJz12+1cI4hiLlPBcXQOQM4yD4NDGBzao9/HEcIclKsUXZLSpaZJL
         nOTMBgpD4louxa7ePCik+Y/keElmvHwo74f0g6agmShkF3USobh2riyVhEPo9c7p5iyL
         ZRLxxb2D8nhi6gieEtUAUarRs0c3vYzvQlX6SG52gxUWmw3uawIjyswfYfDcMogFkxS2
         vP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        fh=qPdSKV0lF8SAeWT33xM5/YfGiMTZGdJ8inQw0Lf82mE=;
        b=E10RA5DS/6QSz2Ig7HFq1DYuoTyhmdd0/1Gu5jxVlQpQBzoBhOj1I2eBJ9AMb1LdFH
         pF5yAZkSr/zME26W3ui9Wyf30TA4OfWnxuvaIiicmd3aZSUa5avXQKl+ZW5VlJw2yFv9
         fZlDqklY9ZYPPT+dMB+bgRcRRuZ5X2UJSx7bZi21ujeF7A/gJv9EE6IJBcfslVUgYjCJ
         LK9mjCCUr05qVNmw46y4oG8M6ofPb6RQNXpYq5hRRZLXI7TXCjQts7zTuKtP7oSjoe1r
         zKESXytnDyEEsnq0nENpcTSPxKki3y/cp/XUC6wxNb4yb1FaeTWZsyWWAeWEmqqToOJY
         pvFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786552423; x=1787157223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        b=Al5TqyfUu+23OQeZiYehEwCKw9h7n1GWuwvFfs5W/FN6ixV7O12veg3o/+6+ecIG5q
         gi77Jv50TJJVfBr5tK78wp8gBVgj+5Y7A46NSJQiMg9vf/b+171Ld/CV/ytLNCLuYUX5
         JGnwl6csWpus6UXO9bC2cOxNn79Q6o54bdsEtVRm7+6yYsLP6x21sneKJH7rILfD6V6Q
         tMWciyTleAT2pJLtlHf4Ke1yqhLx3FZDQ5GOYVRZdJPiPy5U/KlYo5NBcXMa/AeygtYc
         /sE48ZwkvJJt8DLXaboqm3a/tld2DEUcqAqzzQ8WWBf/PsfhZ7ZNON80nFOWRsL+Ksc3
         WL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552423; x=1787157223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        b=jcnJkMEFMTaujHPkjO/gUs9to0okOkAGi8zqUn+Aum96hUGXoBmWBhuJCL+HE+Qx12
         85x7Pn7OrCVQRdQldHTTpzOv+lEee/1KKB4wQAnvZ/svwhbG9wjRdoHiOrtHB6rU/CCk
         uJhPLZp4kEYT0YlxgFKfmLjoPY9iMvnB5IQDxFlNc2WhW2jG4isVko9VcIybD4vTmcQ3
         lApapMC0BWaRagyFD6+Q+y2LR1fKhEafnpcECagTM61orm1mBEdRDhUDpK/tSimK6AAX
         xYSm+dEaxqcDWmE6mIpoIDWb5ugmnYth9z/LZviG1NuljA3F3CuOFo7PWuZmXlRxBg1W
         Ch/w==
X-Forwarded-Encrypted: i=1; AHgh+Rp9qpXKt6RFhHWWotKdL6LCOEBMZj+gzxD7FYQGepES/gkN00X/kT93QkpOP+3/McpzLvOf9RoudvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzbXbjLIbrNAIvu0ieiOXfaxl7cwwXf9IuxPFgm9KnnRWMtlCV
	F6pHHlShYRJkbVVBvQWI0wyLqOcy7AC91qqv9w5qwvdnjsTJxrG+sfBco8+WtJqmVhhXYTsUMUU
	bw1kxxG23CGdpGvfnM13l4TGoPtdI5lg=
X-Gm-Gg: AR+sD13AIxxfBtezCymDj2rKpD7I6sPVQQX+lJn21R7NX8dUenrmYi9G8Jwjuxrvd4k
	TPWYHIdRLlFXx5eVxc5suQiTVJjXJ0x1Zduj3rsvUSwk4WKpXzixLBg9L+YqeWDc0Ls+xiJReAH
	BDz0YH1rJH/vTAQo1AXCYtBIOAAnQOuTgv513m6+ghcKVT5OtaViB2xahGMQkU+Ime3BGX+KI4m
	1plinpl4FKCs4DjArxZ2sr5d0OU9ktdirFgCuqWWX5GuhAU3YH0BhXNKx5YdjKdCYw7zAOeoTOU
	p7JnVw7nTPkzRwpHx+mhR0yW5weWpUOgWcy4kLZib78khFUyzfzMGkDVmpZHX6lutilRkkA8X74
	4FfsbHYGqWYvLh0FMGxb2Obzt8PxspGZKjhiORD2HYnnxeNoz9o7Qg4AQx+9n
X-Received: by 2002:a17:902:d552:b0:2cf:9e90:8be with SMTP id
 d9443c01a7336-2d3456e7622mr58880125ad.4.1786552423044; Wed, 12 Aug 2026
 09:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
In-Reply-To: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Aug 2026 18:33:27 +0200
X-Gm-Features: AUfX_mzHM3XF1m8TGRbbbrVs79_o_CCgi7jI9gpogE6umN7ICq8ixcdhm-skrqA
Message-ID: <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
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

On Tue, Aug 11, 2026 at 8:41=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, thre=
ads it
> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates co=
nfigfs
> and rnull to use `this_module::<LocalModule>()`.

Applied to `rust-next` -- thanks everyone!

    [ Fixed `clippy::undocumented_unsafe_blocks` lint by wrapping with
      a block. Added interim `#[allow(dead_code)]`. - Miguel ]

    [ Fixed `rusttest` by adding a dummy `LocalModule`. Removed interim
      `#[allow(dead_code)]`. - Miguel ]

    [ Rebased to avoid the imports cleanup patch. - Miguel ]

    [ Removed Acked-by and Cc. - Miguel ]

By the way, I removed the Acked-by in that last patch since I think it
came from an older version as a series-tag that didn't have the patch.
Please let me know if I should re-add it.

And since I was editing that commit for that reason, I took the chance
to remove the Cc because Petr already gave the Acked-by which you
collected, so normally you don't need to keep both in that case.

I hope that clarifies! :)

Cheers,
Miguel
