Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E73A9D9D
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606279; cv=pass; b=YA4kKx8FTNbXDPkIp/T320FEp9c0wUMeLkKP6S3SBQL45+dMbYRWyM6FxVSU1xFz/7k9UF2Lt/8ULEnv35mCohMYVDnQ0ZgPH6lWtpI9GxO20p2VQ8dJFpgMexo75JEfWrTlmkw9tNxU1J7mD3lYpIcz9TMA34BljslOEc38jrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606279; c=relaxed/simple;
	bh=+uFnV8BoYScCWs0H3DAkHtcerzqW4bAA76yB8kYBKYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEWDYKApqANb0Vp58a+xZ6ss9ZwhwPa+T0WMmVBggSAA2vaRnCNyJsNCOBUUPShfnOkxmXqgQXgZaW0tw/VCQXWMtd/yTOAIEZVDiVIdyG4ZrjtmtVVPBox0HENVzPGTSEFazJkg9kdSUXWEf3HGR3RJtad6wElLwFh6rN2R1Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGN+jX2D; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGN+jX2D"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12a70b4de9bso119111c88.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 03:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774606277; cv=none;
        d=google.com; s=arc-20240605;
        b=NCx+rtdi1wiL4dh0pZaibrK8cvZRUJ+1DZ8WhcvHw06fSFZTwC20lm0EQqyupSQklL
         oN5417Cq+lCIOVLeKi5U4ZXDH/+19i81bWlzcHjHoRr9RJjLszICkgHeQagtL9yRC47C
         DVNahCGZWjXqtqpb0Z9lPRexCNOpI2SAnBVwa9NqWOlO9kR/Jz4hMP/IhTerMGq7xtZR
         WzidL9DlNzkRQUq8Bo75UXRVJOGj9ctxpC82BVAFZy19993e/9sAkv9XvFRFQUd6fDdi
         xh/EwlpIgzptDP/hIHr0hF0sE5UmJ4I2zyD7QOo+RH+jmwjW1lFQLIgdJTdS+/tQXZO+
         SMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+uFnV8BoYScCWs0H3DAkHtcerzqW4bAA76yB8kYBKYM=;
        fh=YWd8gjqwAHyiICBupNW6Hj0kNYNBxR7H7pyoAETq+8w=;
        b=dINAr9GYCi6WOi8XmlzrlRqNd+RNfLcz9Vu6KeGccQK3k+eYXXaXnN5WTbpeipqKui
         85W/sL9/8/j6zqFI9OD/f3t1/JHSPa/R4zlbixx0vifbQsPFNFOGVQwrh3sDUfwNg+dH
         bmWa9RF5AF4wgqMC1ZezhUAnDT1TtX1LCq7PasmQ5KwHFXK25WBx5aBgqlqaVFEE3mw1
         eZjdVYDhoZAYBEhYlecJGpGhEMj1uLN83FOIEzYZpp9ZoxcM93o31q5R4beNfkDwAHOp
         ap5wRLLhnZhC2lWSeo/oul+5jnDz7yY82sYSutOjxJWR9z8im1vr8TtpfPs1g2oiBMUG
         sYeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774606277; x=1775211077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uFnV8BoYScCWs0H3DAkHtcerzqW4bAA76yB8kYBKYM=;
        b=OGN+jX2DFxKdVlVCdMRX+GuUtXxlrXaQ6vdzlptBo5S0IqQJTSYbN9MlIivnFDqpP0
         NVup844o9FsQhtFlRXvKwQl9w9CnrjF9PoYjpp4Bao4tcCpjKSNF8CR/q2f5mAw2Bkr6
         peTaWlajhOGT6gwlC7LATrzk//cz2f7GRmwVhL7AkCBMqg1lc6tmO8IqJ4VN+uwLJdYG
         xvK5VMwrqBdsaRIo3NRG1QLjHMMciAVh13yLTY+qnYDmWoR/TYx+9yOzvtZsqsTalUtY
         EzyS5UW4rqVQe8dY51Yc5hNN7RbV4+Mj2wBsjNMXQEiCCfeqFnGwJqYkHpE+z04p1rVr
         75lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774606277; x=1775211077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+uFnV8BoYScCWs0H3DAkHtcerzqW4bAA76yB8kYBKYM=;
        b=aPLDaKmA0vBtoRRsF/vtVtbX5dmJ2Ig+UjfRb0GAV8D1MCQZBVNQYYnFfg9Bf4Hg3t
         xMZGae+sNiAGThPTSDrsO0CkZWnKxTCapNN6dFtvRDwSclxWWgm+PryHY6T2WOozmpUu
         F2mu3ucI7/YJlz9b2bt2MBHBAXkvFglPQ6hjnMSgyLTk5sxHmJ343ihJpWb9c1kDuPyk
         ZTudcDzS3vQY+SZXRkIbHpGyR4feq4Lp6UvnIzVSGUZi40N6ODdCSOAegj7AIHIHZdTU
         RBobh/5aO9tdTYSD/1y7cAIc9wJhs7awEXuncYMKANr1tR5yT6KUsL5YfIvnUeOspoxB
         Zcqw==
X-Forwarded-Encrypted: i=1; AJvYcCWPm2wTZOGC6wv/xqJW5eaXNualCviIqufGuHdPwPRgEYVDkznvCie8VL1pEaRy3kGHx0bjxUXko14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EhOyrNANMKVVfn5Gr4ULMPfGrMfNGhGIa8XmP94JNFCaczd+
	cIXczwv7U1Xt3L9bbfbgTRf8bJRYCEFsKWibgUkVmmaPHmVWXiUFDngaQrvU3xf9hiqhKDWIc1O
	TPHkhqxmfF5cd4wElezWNcb2rPN28c0I=
X-Gm-Gg: ATEYQzyNaeHILRoW9/nRTjZg7y1XLgqf8rVE+gF34/iOA1lz9Qgc964sivbBCD8lu9j
	QpPzX+v30TTslF/1cNaVhYEqFxNG2RLHmQ4rNAdGuSNbUZHmcLco6sHbcO4JYbVyXFO8tmTRf0j
	6Zu80tMcJ+N/twccau12lvu2pEPoJYqbbLiJhqK5uItUrMLOhLAEYvHOSuYwX0Ly+WyR2r2g1WR
	Qpbz0sg4f8a9RFiw9gqhBZpJ0qEemDHrL6+pefw255zVlprUl4kvJdRbKYqzGoKckhe+zmTM/7I
	Ilue08xjydDzghKxytnwcJh7qUfXnHFboD7KW00pA1z69avGpD4fSOY1L/fT9/kfWOK6bTDgBpP
	Ae17/bqDCvxt0fnE8HMWx1WE=
X-Received: by 2002:a05:693c:2c07:b0:2c1:778:d888 with SMTP id
 5a478bee46e88-2c185e6c137mr515564eec.4.1774606277404; Fri, 27 Mar 2026
 03:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323153807.1360705-1-gary@kernel.org> <U_v6wkMtfgu8yfV2Nh5Im8t1w4KZ7mdbG3VQciT2g3DULhsKBXJgIz2psuj76-V94TPNtUry3J727gLTbUByug==@protonmail.internalid>
 <20260323153807.1360705-4-gary@kernel.org> <87ldfey8nh.fsf@t14s.mail-host-address-is-not-set>
 <DHCSEZH8M3JU.3LB4M2ERBJSYX@garyguo.net>
In-Reply-To: <DHCSEZH8M3JU.3LB4M2ERBJSYX@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 11:11:04 +0100
X-Gm-Features: AQROBzAc4vO9OJHfJtMaQN5CiuyoS_KQK7JMXrfbHVTl0wLJ7I2VVbDBNfr8YhI
Message-ID: <CANiq72nmM_L2qSZtrvPN1bt9OzMiKu7NUZQXM=TknhbCOU=wuA@mail.gmail.com>
Subject: Re: [PATCH 3/8] rust: io: use pointer types instead of address
To: Gary Guo <gary@garyguo.net>, Tamir Duberstein <tamird@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:35=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This is a `*mut T` -> `*const c_void` cast which needs
> `cast_const().cast::<c_void>` which I think is less readable than just `a=
s`.
>
> It's also existing code that I haven't touched in this commit.

I agree it is usually best to change it independently.

In any case, regarding the suggestion, the latter form is more
restricted, which is what we wanted when we enabled the Clippy lints,
no? Cc'ing Tamir.

I agree it is definitely less readable when one is not accustomed to
the `cast` methods (e.g. which one is supposed to be used for what
etc.), i.e. `as` is just obvious. On the other hand, it also makes
more explicit that we are doing a "bigger jump", i.e. both const and
type, which is why `as` is "worse" in that it allows for more things
to happen at once.

Cheers,
Miguel
