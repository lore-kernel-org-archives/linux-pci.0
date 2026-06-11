Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D70309F1B
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154596; cv=pass; b=NMVzU5H+UZ4XZT7u6XqAsiMOmx3LTmW4ncBpbc+dMFK29LTknnYQ+x50YricCUInrjpqRNTj0scgeCKyyBnCD1RJi5vhR8A0Dpa+cBDULejMA8SFb6FjPXVy8yN6TEzR5D1BkKJLf7k3N9p1TYzHuoKYJWZ0/wQlyo9jHRxPfkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154596; c=relaxed/simple;
	bh=8CQLlPE10gtfc+80LGNUmW64kb5+lwCt/hJuXkDKz8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVHQiDdId+7GNujAveoxUQ7LXOrWkW4h+ew+n8YjzD14mPEQiDkdKFpCPuY4D7q3Jn6naltukXH83ApAwoscK4jmcXRxUAulUgHIKRCCK5XLkyr7OdCcZEP3g1p6S9IrSpP6QOoeH/CJkUtiR1GQYXJfqP/m68mTRip/xHQCcPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtQLiKW4; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtQLiKW4"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1365eb2a773so367821c88.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 22:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781154589; cv=none;
        d=google.com; s=arc-20240605;
        b=GQrvWSrdJD1pUlPlhisYwfLH3n8PGjTg7HX7yNsjE/taGAXG2UUya5Tx0oV+wuI/SO
         VZ9ds8rtx1iQldUyCWQrRErNbwj9r8suNgq4jY5QqOXK3aTZMhAg3vWGf9MtSiO7NxRs
         /72hGzRZarh2Up45nEX4BW+PgaXoUrDDYKfeBJxvZ0FnzcrMQRqcPzyGX1T/eNlFq8RU
         34QC2CwnhhGhtUvpLkhTb/5HOmPPMu2SpNtnkc7tR3X7qAMQKhZ3tftEqX01YA+XaImW
         gKrJEhiRRggx3u2gu3EvonPXhPa4g734VMbNdwoZNqP8/ncV5pFwc1HDf8Baxfhaq+ur
         jLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lyFerlgaYrMaDYJQQ4DjXG7o7AcnUs9BuBitZg+XRxc=;
        fh=ifRwFzYF+9oyjAkxN0avFagWlD5eJ8x7oOamVpTAVwA=;
        b=QN+4VYq336mQA7Y/DyIHoiPJvTkToIk6NmSSvcWrUaa0nUBWRVsyL47vZmeZAknUOG
         ZwVUfPXkLxoXBKHVeY0cHdVsjbwIUheIaPFEo1zPKKXkD6RPZCM1mHvBx3mjp6VtfgQ6
         IK3XGnkWR7qA1idNzI626dxjuTK87Mxw2QDdRt8r5NQU6cq7hfob1yShOReORfH2GLfq
         FausFx7ZJgAGamXnx+VFNKGLSLC813Wzbda/BMPuC1+0RBtFSr5P8A+MDYmsoc4FzBtX
         Jys8YMdFG2KZG2qz/lJelpymYaIIlQzByxkUlYhsgwfDAPDS2Yik1t8GgbZYrK8rCIaY
         i3hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781154589; x=1781759389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyFerlgaYrMaDYJQQ4DjXG7o7AcnUs9BuBitZg+XRxc=;
        b=UtQLiKW4tTBKMw+OQuNmmkVJJzoLOkse3Iw4sdyF7e2CbCnHCnoMBK1wta58381gLO
         98GBR/RnkHuzdRQvH72+jx1jDedWTXYJvP+hhBfoWywh6VB7LMaZArWiIN1ZcUkoJy+b
         89uV0nzni/DjLhNe0Ar71Gtr8k5AYfSRF23+eb5ZxdVGLzdpe5zB7kWB5VlWUm0lGj1e
         pRC61BcZDDHH/fwtULK8B9Mqra13T0+jVxz75E0iKPK/USdq1tj8FO08Esr/D3bKaGOn
         nKCsVsNxJsuYuOWjmGUX3cEewTpAyXkKGt1fk3/0kjz7MyTtfh+sUfGFNUSJjaGKlcuG
         enbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781154589; x=1781759389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lyFerlgaYrMaDYJQQ4DjXG7o7AcnUs9BuBitZg+XRxc=;
        b=SNwJJfHU9uNw5SNyoM+5mhyO4zp9+YaHfkStDeznTWch+ds24Vd5t7qSmRqjlg3zsG
         CWchf6VDQVEirsa5pHDDGmRuIIw7QiUX9klIug6wdy22sJKc0qfJLRapwVZIF77DoOCc
         4cNzqlgupKH2zqPCN16i51qy67TBRklWUbmYIlRM78wfMHRev7Fl9+5BhMZxUEqOzi01
         6h8rLN/0ERVKKpkHalxAWgTXRh+nhcZF72fNhkgDIydItFiK47XD1JWFDYlgaSvnPC2s
         HzvxUvjxzEJjTEWLNv8SC/nvfBClsZt86hW3IcN/6ReZHzSXK1LzOFKt2V3X2Z4gS+Tm
         /vSw==
X-Forwarded-Encrypted: i=1; AFNElJ8TVqZmOidCgID3YqhihzQhwaj+ZZenCsmyY7DKw3u6u5e+QTHBuOdTR+QYiGNKjSe5xpGhKz23EUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNKothCLoqCH65q570VDiAbMzNGBMeCjOQye6p0IW6yCNzNTcz
	nmavP/QEEj98qR7b1tNgwPgzDFmrB2Eem+jC+AoVeSipW3Vo/Y8wuPN6gIGpRAWUQuf05Ybys5z
	l88CiRP3MDb6rKEg/n2GUPZVTNC5dFTGxsLgCLPU=
X-Gm-Gg: Acq92OGGX3hTKlo3fSERzMdP4BKLyb6c5S/cGDv1dofwwHrze/49lQuk/Y+BJj0pJie
	XejoIUfA83g4HMT/kUUQjBH6v2v4KFtbX1TxP2MEvQZAHogNbSvn1erGF1H8W0l5LbP7l80pZ+L
	QAEkeMyQdsK/+RsKKhHYxFtw2EIjYFCBLqS4KUbI/hVsWugsvppc3zWrQPd8qecVPo/7RkNp6Zu
	u4qE/iOwG5dXbyg8uPoX8FUWm2pqsB2YTmO7G7lStIMNjyaCYWHdaUdCeUAbLmqCowM74YoTEO3
	LeRuzGtc11PKOkstAsBFcm0zUEc4qG9g/qc+YC0xO9v/8LTAqNCaKFBu/SgRCONtSf9vdgbtkbb
	iRcWZsbgpPCbCYBCy+VFVPEEBubR/xl6FfR8aV0uhlmo1
X-Received: by 2002:a05:7300:aca2:b0:304:d700:1e90 with SMTP id
 5a478bee46e88-30804a5f5e2mr536231eec.3.1781154589390; Wed, 10 Jun 2026
 22:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net> <20260608-io_projection-v3-19-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-19-c5cde13a5ec4@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Jun 2026 07:09:36 +0200
X-Gm-Features: AVVi8Cf920yVhFg_hQqFb2LNc7XWN7dI5ldNW7tmfqMVwtmKAogJd1U0zilXmbw
Message-ID: <CANiq72nLZPG_Cnf+R5B4CoxzbLpOWy39A+hiVtetDD7zT6MgRQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] rust: io: implement `Io` for `Either`
To: Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:59=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> +/// General purpose sum type with two cases.
> +#[derive(Clone, Copy)]
> +pub enum Either<L, R> {
> +    /// A value of type `L`.
> +    Left(L),
> +    /// A value of type `R`.
> +    Right(R),
> +}

[ A summary of what I mentioned in the call yesterday so that others
can see it too. ]

We had `Either` in the past and we ended up removing it in commit
28753212e0f9 ("rust: types: remove `Either<L, R>`"):

    This enum is not used. Additionally, using it would result in poor
    ergonomics, because in order to do any operation on a value it has to b=
e
    matched first. Our version of `Either` also doesn't provide any helper
    methods making it even more difficult to use.

    The alternative of creating a custom enum for the concrete use-case als=
o
    is much better for ergonomics. As one can provide functions on the type
    directly and users don't need to match the value manually.

We also wanted to try to get developers to provide more concrete
enums/names for their use cases, instead of using `Either` whenever
they may have two symmetrical values.

Anyway, if we want to re-introduce it, we should likely add what we
had when we removed it (possibly just reverting the commit), which
included examples etc.; and probably add in its docs some guidance on
when (and when not) to use it.

Cc Benno.

Cheers,
Miguel
