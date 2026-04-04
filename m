Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312333168EB
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775329059; cv=pass; b=CotFiqQRhGXAFwaVNMEjsxjibzzyJUmlaZuZ+0lAmk8ytCkVUscb45ygG74FfgyeXQAIlQq4ucfNT2N7TQ9t0XOJK8mJs8NfFJ08HH5V/UrRBIwIkcj0GMqm74z08vBLi1yjHy4wSXpUIQvrG6ahPhbRA1sEN9XyA7Gq4VbPuRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775329059; c=relaxed/simple;
	bh=Dpo1bHWRFUqXo0uNqbtuJo1O2t+g9zkQj8ymAL8CgUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5ani+8/U2e1I6+Kr5JfMJLpwr7bYCrKH2TTpd8OKpruMOA4mINF9CzQmVEobibhWIsCSi23JmQCIjhjUoKH86v6TpLguR1P4utkZ2+Tn789DdDNh7Tg5gc10YR7Qkdv0Zh6DZu12E2GviS38TAKQ+m8kzS9poAfOGuSVEezdHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW8PckQ0; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW8PckQ0"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2cc43ca447aso83375eec.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 11:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775329057; cv=none;
        d=google.com; s=arc-20240605;
        b=XZnH+rII5EZrF7UdFHaPPpVGmUgQTL54nK8qJR+DTe2B1J9ya0BGSPqh4F70L/+K6X
         1znMag5dtRH5yHrZr9YKLLJo2vB7Wyyzk9MHFF36pCiSFVR3oYHfHLYxpw1gMz0WdZ+0
         6ZrkWyuhR81ofIJVoElWTPu/H6KOAEmvtKA96AR5OY9clj3AQoFbG4f8yH2F/o/E2Plm
         FeYAROQ7X+LZ02+5n3gTcS1ip176WUPgOfcLwYP16+BVMzUmtyKfUDXQBVdRYhf4BKqV
         sdLSVCMF6IcqZ4L6WlcJw90bfrHFn/LY9sZWhP+5gVeLH6n6y124OjD3e9nU1rgaq+8G
         fKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dpo1bHWRFUqXo0uNqbtuJo1O2t+g9zkQj8ymAL8CgUQ=;
        fh=t60Yx6hm7rDnRj1rENLdq3GIW7iJ5c9xMKc5pYOXMGg=;
        b=cOGu93mFdvrCFhRNg5Y/QSUEdO2nHJsXC+hsewXc1P2g0MoasTaE3uGNlHdYMomf5V
         6KtDZ4Yz1IxW/FifBL2e7w7tX7xWW6dW9gam6VbVWI4TFS7XTe/V7PDMQTIZebd5einx
         vzwi7nQzdt5ESNv0psddSsbQwZl6nMLS9e1AitHbvoGtAhavifWvcmO3Dto+pAn42XcN
         eutT4dFYawjTu497BawbK5QunMmT5Gfq8+BXpSNWcZ+ag6e7sZ8Nd1qq+cOtb1Q9OIqP
         nyuk7Ul6Tdry/upjcYUCtZTRekKZI/vgH9cmVavnPAwZ/FO5lKQoKqw4AvOvs8Tb0mPN
         /OeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775329057; x=1775933857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dpo1bHWRFUqXo0uNqbtuJo1O2t+g9zkQj8ymAL8CgUQ=;
        b=hW8PckQ0MTqsuTDZEDwZGOxVEXNGMV/gd5qQOY8tXqwv47sTV2feyp4lB02F+wXGLT
         nCMVoDOJmcnaqzQP48axTlxPHtKYYdybOQmdXj+WE86yVulEUira6dR9exgh9+ENXBAK
         /TMyVPUKTDdywopNSRC8ZOsI2+020BwxKTRLZr0jLUG2nDGDCAeQXa9YMb2O9q6tpgpZ
         /btG/Gey6C0B67YiBmjeFMrlVERcCDkHhBWg8h2zZOQMwoLpEm5TeUOH7QuhZEH5dpZg
         qKIFU99hoK8OM72IO4Er/in/a77dAzQlpCosrQMumAFl2AOPXpRw81JFLX/0HRkAI21B
         JUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775329057; x=1775933857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dpo1bHWRFUqXo0uNqbtuJo1O2t+g9zkQj8ymAL8CgUQ=;
        b=lnYbo5oCSKj+iiKWk1NneIeF/a0/bxAqmcrzNrF85If2y+qHtu7i5ODReeLPp/bU/S
         PA1oZyvutVeeOluMltzijiP+ue239h0yAzRbh+72mr2jUBImntClvTwtQUr8oZnobC0C
         YScvxx1AocauG2t/+UNXXF3M/+2kMV0PtLA23pgn6Vi5pN3b9pub0GnWDlIVwwriqUtQ
         qRkMFPL/8SGWQTfnBgkfUaE18AnLnNHxmI7jeKMztaedxYV6vP17/5BEOpYH28pO3OXT
         6ActZHqCgSDcI8yYveZcmTFfPs/0u9j7DnGnnaTRXumUSioyvxEMC1pXakRJ6e1alghv
         HqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd5K3OZpWwL+m6pZ/RMlU3A3KALeeQG2Jtvo2ZqBpJdS4faKTn/d2dXN+tbyRpoqPneXuozhCalH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8sjZZ7CosZz+HSwqqB/JXYN7P+WISueMfU36RBjs2EF2e1O5/
	etZxddUWLDNt70niFY3xbCIOH3Yy6CoAXbWQo3aivNbWCEABxPdTLxpXrH3iUp5EPl7w1zDz9pf
	gTeZL/44xo72v4nKNlpJr50OzNfexqow=
X-Gm-Gg: AeBDievEhx3+1i5v07evTdaA3xwzuCpM6cV0jbm4xuErDMGJMyPGVglTMZSeyDv9q49
	Y1Ap1PxOOfW3vpOmBgb7KC3rrjpSaubqon2I3cF2+KRVK+7/jRiHhyu5V4x4kxEsMurlQOEpX94
	6jJk2L4Q+kBsmosNRNDEKy7RmajJjY1jtx5C0Chs7J+/EDa2Fb57C8mvC84kkaZCkhBDscK41i5
	Ix9B4KI7VwEYFNUHmh/wdJMX+eTZyBgAqwfVHzf2UylhiYrpXZrC8+9qgytH5DZItasKDg7vm5C
	Hd9/eeNyd6G+2Ihka7gvVDoCsdP5uxJt4szsgIv/ESqpgjDOKZ7rk4eLTY2wuj34VuMRTEF0AcS
	k2GQcvrzrvjoBVCCHlu0nWM8=
X-Received: by 2002:a05:7300:aa8d:b0:2cb:cc20:1771 with SMTP id
 5a478bee46e88-2cbfdb8142amr1797820eec.7.1775329057099; Sat, 04 Apr 2026
 11:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323153807.1360705-1-gary@kernel.org> <20260323153807.1360705-3-gary@kernel.org>
In-Reply-To: <20260323153807.1360705-3-gary@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 4 Apr 2026 20:57:24 +0200
X-Gm-Features: AQROBzB07bZJqe_QfYpU84UafC2n0TqoqgFxBdtNVi67KZHjlaS5_K2l556ldMw
Message-ID: <CANiq72=L_GtftTstEznWi908HwcWLmD=cf0gnmLcGkfN+RTaMw@mail.gmail.com>
Subject: Re: [PATCH 2/8] rust: io: generalize `Mmio` to arbitrary type
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 4:38=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> Currently, `io::Mmio` always represent an untyped region of a compile-tim=
e
> known minimum size, which is roughly equivalent to `void __iomem*` (but
> with bound checks). However, it is useful to also be to represent I/O
> memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`.
>
> Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, or=
 a
> DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
> existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. This
> change brings the MMIO closer to the DMA coherent allocation types that w=
e
> have, which is already typed.
>
> To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
> `KnownSize` trait to represent compile-time known minimum size of a
> specific type.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
