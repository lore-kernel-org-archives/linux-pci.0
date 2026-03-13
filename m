Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2B1D516C
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368452; cv=pass; b=eG5c4Lu+5wUkO+hnjAVoKK539IWLY4AIptpReEMRIwmgKyQ7Vv3fYNB2fQYtuHXrHBilL8H9QUKa/7LFN575bwMjx4SVUQTCcN/4wq/vh0cOy8nq7RyOf3zVRBa/X1g4fRMu2ZBw7K/UyHYYRamvGQlDvvKH9JGAfhQpw9WLAQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368452; c=relaxed/simple;
	bh=Nc3vSgPCiZyWTFw4ReuW9B3v4aeGpdG1apfFjxfTvD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwIMgs74oeAQiDtnLpxN4o02894nAQFNqDvJMciRWfzvoTQOQSnFFAky8smUbymUUyv+oykc39MZVNoBm/BrHD956BZHySeL+nN4oYnyEv5mH/D+KFncfIRMujAuwYk6t/xAmigNfmSf+lxqBaagzPJSsS7LXARX3Pymn3kssjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5m/2h4t; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5m/2h4t"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso2418208a12.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 19:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773368448; cv=none;
        d=google.com; s=arc-20240605;
        b=VDjK1Gz+LhGPGqap9Uc0+d1HVUHhiOCjY1VvMr0pHO/dCQdVO+L7pNBEfkoh+Kdsly
         C5l3cBAFJxR7ELrC4VHNjVqcA7oz8lqaBKX31/9zscnPnyRKlxfPhZfVJIUOi+fvS62O
         84I/19xK0nhaDqFSC7EQ/UM8JoTCskOJBeesSxcBZ+TdH+tPzTdJ3NClNUAcRU9Df9rd
         KUWTJ2yPM4bvKwKT610/ry/cn/udrG66tb0EzDOtcmHi3QGmq2uwQQvUy3a7uYfi4dWd
         AzcWpZWeBGgVHRGsgE+lf+OvLt8OKPt5fuNoFPV0mDwbOBAI+brFjV+Q9csGlQMimwd3
         PI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bF3o1la32fuvNbL6eogbD9OSVNGno1MaF2cdSSjD26g=;
        fh=stvVhoXa48gsyYndogS5b5hyntXHrWV2RslxTa20Xd8=;
        b=CYc3quzjfhTViiHhRJnxDJSHiQT2WV63QHm5cuP6Nnov0s97zk8CZTtgYH7eUo2ywT
         syqMini6wKnVZCw81LfCKMtXCVzNZvF+WIVBVB8VrjxxD66jWagZW3AL6bwQ6kGKXFPA
         6qcvNl25cW9miJW+xi2/DKiIkbtr085VuUkAZe+TLYVTsj6aySVfMmYX9u3oT60wTgrf
         VUagFYTl5hfBULzesrF4CbDmvGXEAiIkWCTes2P0Fe77N7N1Wq625HWALK0Wm5f9rNMd
         aIWLk0EJ/bRKnI00D9652UjOiKCKz3yc6YXkhcD3J0y8iyfyNBJx1fX1x0FSyWFitABA
         m+fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773368448; x=1773973248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF3o1la32fuvNbL6eogbD9OSVNGno1MaF2cdSSjD26g=;
        b=h5m/2h4tZSYh97yKPQKNRK5SkPzjkbsLDTs3h2w4/4UGx2qb5nct95DPQcMPjEmLvu
         QLz8mY/x9UqfIykNYB5GPFSB93REPQaQbSvZH460waH4nC2nP9bvd5BKNsndUcwP6Zf7
         Cdnybwni30ur9x4zy1pa6qts7Ggg9yDm3C+Q53o2EHPja3PYguRU9Lea81P+xJnazHFa
         jVqpIZtYCWZHdKquQhNfwgzwJnHquxXF3Sa8Drgc1PamUK8jq8E/SaxzG1ax3UasmBLG
         5XGKXBm5wXnrZC+MXV1OO/UlVfGlu2poukrA8a8ksFCmByoGzNleCWEQ4gq7Mw+uCM2C
         +Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773368448; x=1773973248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bF3o1la32fuvNbL6eogbD9OSVNGno1MaF2cdSSjD26g=;
        b=clbVvXWLMtn7l7wZw3lCqGwr/qPxpJ9SPA3S6F/Ptzxe5AQ9ZzoISR+LGcfcONI+O2
         wDFqLbJnf3myB7IBdnSkmZD7sFi98zYZTM8A1Uu7+wgLBwhvdbeVPoK0NFhzIqocJeJf
         PiSismnmUocFklzqXPBZRTa1d71mT80belQYR0LD6SxP1u0rylKT8fVqaRI/0aGneWlH
         wZPr6dR+xwaFVZi64kFJGk8RK3hDsI8etz0oyih1PSDfSwoyPeO2NrjOVuxcCmfn4+JO
         wY7WSKx02LY9a3h0FW9Vz6cs0dpWZGIw/wg7K4LALB6H+5FeFo4VfKHoca6IwZsE68KT
         OzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJtGgmAHm34YvotEga72qdsmymCmZwdhMcfX6fHJDCcdGkbSmTpVQJugAmJkOE5sYqnXuIGG3LNUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmeTE1EegsCK5wMEGL60U4lUdKnOYEywhgktc3HziIxoigbwV7
	vO47rIiMqUu7MOUy7bv/xZVivvkxL6DG5PaV9jmWncV2HK3yAZ0ZU6gu5RhxcHIwZcaaCbgC5RL
	5C3ZkdlDGSwGrv2/ALmvIg8vSGV187Mc=
X-Gm-Gg: ATEYQzzUtUG4dMyZK0my5etcnTJgqO2W/fxeWkK25PrQH9RkISTGQZg0eUw72VssDad
	kFJJXCKvLMCDgpl3AbfgLNZ7njjScEk3dYbABpr21V2SZrAP8SPkOyBB5xovhc84ZaNVnuCGq6k
	qdh1lDugWqW9U3AV1Oqiv+QCySLSb6Zt/o7ec44kVSIdU8uq3XS3QW3JHoWrEcbhSGiK4Qyjbys
	f8V8iKAIMJ3I6es9lf30VqFAld7Zts62FcDsEKmUl0oTk1fG1PoteDApgOvfhIfIohdLH4Qf4Op
	oz3VWMxpTiwf8gJvhVljCcxk3sVkPD8rcXxUKQ==
X-Received: by 2002:a05:6402:35cd:b0:65b:edef:40b6 with SMTP id
 4fb4d7f45d1cf-663babb2796mr790403a12.6.1773368448051; Thu, 12 Mar 2026
 19:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-8-alistair.francis@wdc.com> <8403c8b7a832b5274743816eb77abfa4@garyguo.net>
In-Reply-To: <8403c8b7a832b5274743816eb77abfa4@garyguo.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 12:20:21 +1000
X-Gm-Features: AaiRm52El5V2cLVcjV-Q8_ZosbewKKcX058abV65Lg9yJW4Ibt_OSl9fj2Npv2A
Message-ID: <CAKmqyKMXmn6=suyjhB3Kq12-UHuLbPLOHPd2JO2b3Nxn4jYHpw@mail.gmail.com>
Subject: Re: [RFC v3 07/27] rust: error: impl From<FromBytesWithNulError> for
 Kernel Error
To: Gary Guo <gary@garyguo.net>
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com, 
	aliceryhl@google.com, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 12:49=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On 2026-02-11 03:29, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Implement From<FromBytesWithNulError> for the Kernel Error type
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  rust/kernel/error.rs | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index 258b12afdcba..569d9d032ab3 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -12,6 +12,7 @@
> >      str::CStr,
> >  };
> >
> > +use core::ffi::FromBytesWithNulError;
> >  use core::num::NonZeroI32;
> >  use core::num::TryFromIntError;
> >  use core::str::Utf8Error;
> > @@ -251,6 +252,12 @@ fn from(e: core::convert::Infallible) -> Error {
> >      }
> >  }
> >
> > +impl From<FromBytesWithNulError> for Error {
> > +    fn from(_: FromBytesWithNulError) -> Error {
> > +        code::EINVAL
> > +    }
> > +}
>
> Are we sure that `FromBytesWithNulError` maps cleanly to the `EINVAL`
> error code?

`FromBytesWithNulError` means "An error indicating that a nul byte was
not in the expected position." [1]

To me that maps with `EINVAL`

1: https://doc.rust-lang.org/std/ffi/enum.FromBytesWithNulError.html

>
> Anyhow, please add `#[inline]` for such simple functions.

I can, just noting that none of the others have `#[inline]`

Alistair

>
> Best,
> Gary
>
> > +
> >  /// A [`Result`] with an [`Error`] error type.
> >  ///
> >  /// To be used as the return type for functions that may fail.
