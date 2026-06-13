Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B638D3E3
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345146; cv=pass; b=a1VBb6+jY0at3d5YB9ZvH4b/nB9+h9941pEXLR99QCyMdyF9iPZjUfnGJ3EeTkD09Q8ntoTIe8fNwW9ThxSRND9ndff1pQxBj04ECrv96zpY35boTpYbWN/01u70TTMyir+2ns1HWGci+D/exEcthUjU0oTObCBY8ePRluM6vKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345146; c=relaxed/simple;
	bh=a9H86iIlJln7zNImJOs7H3Twwdm5fUP3s4vZPkvhH/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHJjf3J1+hnfBOzV0YwacxmdmGB4X1Zmya8zQpatvEg9RByw0RIEcx3rH2DSxUtsuJT8FwD4XKrCecgX7WNH+Gk+kZmgZ2P95vuz32r9d8OuwEM151X80W2kSLpS80Ta8lF6lnhfrl0zR5iMPlqhiBGa8q/Lf0+hNCM7KYogx6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0YJjDzn; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0YJjDzn"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304e86ecebfso116934eec.0
        for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 03:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781345144; cv=none;
        d=google.com; s=arc-20240605;
        b=jSp4SfcHuDglNLYU2YUBGlQWHYAdabUs1sb2UsI84AlqGmRep3xho2hT6zg5WBgAkp
         WruI4oYhSuN3LP53W1mLt3UuPn4RX52t36FGYdh+L01CpGg58tA82rx3NjuaidMZWAWd
         lT0xfbEO4GyYR0ymUgvKCpwV77RukuzOio2ncwCZAp+DCndMxk54G/Wa39dEF6p5EllL
         +uviJtn+8aGSxDDqR2uRkVqvV58fvaTaJkfSAgHxsLduymZxgcx6GxlOlbjEQDqqLuX7
         eZ9bk4PPmnSwOxdrQT8r2/HruCIxpPU39Dfcnlmq5fbgE7Wi4uahN44G69ZA6ga7TAM1
         y0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBjNOSpJlw+yD+1WI2YpvIUWPKEOoXhGnrq65FYW9Fw=;
        fh=RD4IBjLeuVGyBLUt67QXKXz5m6QeyHvFUZBxxdZ0MJE=;
        b=hOvxZuii8w+vx20uTPq02KoVoymbmZP2HOmNHvWRQB9HQQeNUJr1qgswF2qtcKCEKt
         5P2HWe4S9l7+v+q2DwmOzgr7hlguX1XMp5DYSnVJWA8atKTxpEFRy20GO5EQFqJ6DcZl
         4qepgiNbp8w8jEgmLY8sxsVLckoaLdAAsbh+L/WDJHQYqOJATRqJeY2REPUBT+h47jbE
         m4yOgwPghbR7URBRtOxExztWO6X77yDtFMY7v6DCbXvPwMs1/UE3taKfs/o9zLv7XuG+
         zPxrnF8zBFbXN/Wfqre1CvITMRf8ScXg33MmGgUNaq5wLss43EelB2U5HZUQzdiWP3qP
         M8Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781345144; x=1781949944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBjNOSpJlw+yD+1WI2YpvIUWPKEOoXhGnrq65FYW9Fw=;
        b=P0YJjDzngWKHGVmAdWfeK5gk2LSS4Sb+MoggD5JFI5PxPJMSE+wmx9y1q+eyR6dR12
         YjjeqDv4qCXpbEN3OxT43PVmBlkEu8QqEA5xZ+o4wmdCy0IIgQlMAPsTjWT6XIvt2au6
         1natKfkTWi6kKIE/wryypLgFMR0byhp3s16KQdo5QePFX56JwhPJJYyUVCPXtVxjXbw6
         9EiNYmJAWc9mSfltX+YMlew7FyoDUIkvEJ6j0+Aol5U0ddBTOPkrDIZs6t1XzgK8Q6+e
         Rd2Du8tqyCYH5kGpnu1XZLgPiF7nMPedGroRy9UodSIfog+PBDz2iL8wvYcrGkT2eiFV
         9NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781345144; x=1781949944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBjNOSpJlw+yD+1WI2YpvIUWPKEOoXhGnrq65FYW9Fw=;
        b=BftLYztupwSUKWa481nzZTpWsHdjtw8MZDohS2sUcVtcuB38p7V4hbMG6TkyeqV304
         sR08hgzhPLefdkKd+Tg4dp0hKvM2nJdf+k93x4dJ/ZXV27aW28JEas2EOzdU654dsUpz
         ikWKLsJ4X+X0YKSRabRV3CrQol0GfolRs1TjV5TIX1uBvTiv0i4Z+DlYnf5uq+T/rtCV
         p+7qTFC6aKg8JQ4Sc3aNATpN6X3J3hQ/VgRo/eYp3bPMAC8N1LXWN9fqiy/LC/QoJlN1
         bfPJfT+qjAc9X4TkL0n+MMi/Dh6Af2s+B73GxGEB8Ht0UfkKrtot632Mle/FqPRYTPdk
         PTmw==
X-Forwarded-Encrypted: i=1; AFNElJ+KSHTISjkJrovy/q1+rxlwB+lDpeHT1VSYb1m4LgYbzPFCDulEvmZh7XidIvM2p8veIAwb36DcFzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIukQ7Fwg8lUKbv22aR/YR2ChFpji7dWWi1/ylmAmMw26X7uyE
	JFd3qrZpO3yCr9LUxH8t7fFBRIevy7YAxa7kYU2Tzn+XRNHG2GQjsnKxROeAU/jnlCdJSg4bGDR
	G0c/ebCj+jHW2PjSxzSGnqlycnDJbYaE=
X-Gm-Gg: Acq92OFGCxHcsEyrQS60ILrTPHhejOorUxWS0NV/CGco24oHIZXEDQ837KXhKWP1ikl
	4OGAY4UZFKXeJtxrECZN49WWwrnpsE69B63MKn/q4jYsAIv1J6OTw7lly93myDJVwqa1du+I4jo
	mLCsKWhASR3u+lS/LXGN06+N6K1Ovf89pPDpCDKChEJNRECEYtoxQRUTL5Kbxh/OjX97WGwGTwh
	Ai5Ysym//dABWJ6ay4S5UeWbvG2G0zmvZQyTc21cAUc+Eg2wVEeXf5qv8n7e3Qsl1Tz/7z3HbLj
	UmL/63H1VcGfiDM8MP0AVaUeMB+2fJpFe46PehqAlGapRAhE8HWjM0QaqX4YMsMwYIGwVlwdZL0
	ZQxxs9CQbIg6VQNwVC1jQRno=
X-Received: by 2002:a05:7300:641a:b0:304:e327:aef8 with SMTP id
 5a478bee46e88-3081ff62e8fmr1477519eec.2.1781345143929; Sat, 13 Jun 2026
 03:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net> <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Jun 2026 12:05:30 +0200
X-Gm-Features: AVVi8Ce5ZWN0tgHXx4wgAxeDGhIDTq9KOdKjeJ9s14OzuckvDKwA8hSyjUXURv0
Message-ID: <CANiq72mLqrcdZEAGM1wJ6OE7yUxzDT4dRsYjO91kPzoB5h6mfw@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] rust: io: add dynamically-sized `Region` type
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 6:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> +    /// Create a raw mutable pointer from given base address and size.
> +    ///
> +    /// The alignment of `base` is checked, and `size` is checked agains=
t the minimum size specified
> +    /// via const generics.
> +    #[inline]
> +    pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Res=
ult<*mut Self> {
> +        if size < SIZE || base.align_offset(4) !=3D 0 || !size.is_multip=
le_of(4) {
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(Self::ptr_from_raw_parts_mut(base, size))
> +    }

Hmm... I wonder if, at least for the `try_` one, we should have `//
INVARIANT:` on top of the `Ok`, since we at least checked that part.

> +// Stable since Rust 1.87.0.
> +#![feature(unsigned_is_multiple_of)]

It indeed appears available without changes since Rust 1.82.0 <=3D MSRV.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

I think Danilo asked for the Acked-by back in the first version but
you dropped it since the patch changed, so here it is again :)

Thanks!

Cheers,
Miguel
