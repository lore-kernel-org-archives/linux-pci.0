Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE153815C7
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398176; cv=pass; b=mUngEKLi3FWv2QwxK6+DVN6hcuReOdurvv2eBoXOKVi1AgxGOOskd2zukoHB9pkq7oGCyvIX1+KCEbxRkRH49g6tkqlidcLG2dGM4gdbMMTKaGqkjlm/mBJd7PFNW9kw6AVxr7x5i+DHSU4yKEr0TwvW2lXv57oYQ4JueRzkUag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398176; c=relaxed/simple;
	bh=8g5q3C7nsRWNNtihsDdWzjoOptctN5Xc2r4pN5gjoAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npwCgxwFRt2lLPcfuR2vq1Oygj+M6p/7TIH9eK1g+a99W/SXwk/dOntJlntVUWzajvZLjSFR0Zy2OdidrhNW/d/7KPNakYA9q669iGIRtp4l1WFlkC/fiWr2XDRi3TFv6u92dIO8RnPq2OsRFnogQDMN+eVKqz50mzENPXgKEm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/1tPuQ3; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/1tPuQ3"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439d8df7620so1501384f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 03:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773398173; cv=none;
        d=google.com; s=arc-20240605;
        b=I+pXJoQjRFJhAFI44FAYxRq+VpuBZREbz7ozCZabH1pX/U1QM5MoNBa8r4Woq0nzps
         0xwvTde5K/atrx43yOLs0ItNO2uybkRGPku3kXcP6BTEzTNjfDkzU5sbVmcJ/aVgvjai
         XjQBQdSdH0VtqUDVBCH/Iyu2O8g8gft2KJWLRbMAtclx+/PVEIPgDhKczDnZoWi+nmAR
         eTIN3ie23AxNprgDfyyMnXfyTRo5cC5Tr/c0wbpioAdzaXrzDjuMesyD7xXG8nVo3yA4
         /q32ROoJyUuZ29VbUpsl9c3cuvE+i3P11y76hkmnr3gCIyKeCYphhFnw25viR/EETOGg
         RwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/w5DLUFTZVMWmc49ACjqJvi6te4AWIx+IOTh3G/EERU=;
        fh=9+p3k+fxbtqAmcxW2lL+hJDq4v1Y1YKk60gbtCQzcHQ=;
        b=dNakoiGHTlIqlnQvFoP568/ru5YqpN4uek9IVwivKsxuRJ6zrWhvEcPNbPOPEnXeML
         KIDXQofG7cCy8JThI64BMKzuEfUH8dDfB9imSc67aJLD6abFyr2Ctvq77YV6ZJgJ8mxc
         9WqTAOw+RRoEbsoAhZTZq6yJ/DTt7YJty192a0Kl3i+580Udf+093Cn1fUmagBfpjMQJ
         n8Wsu4R1SE4qRetaHCXiy3f7x8KEaczZ5/7H7wwUCw8jaNWF3g0dW6CYQazBkgXlFBCI
         FpYkiKcZ3J4NY1WzFS9Satr/m2KNRdxNbSZMGIjpNXutIOefXBX7o/L9EojsuorwvjiW
         CYdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773398173; x=1774002973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/w5DLUFTZVMWmc49ACjqJvi6te4AWIx+IOTh3G/EERU=;
        b=s/1tPuQ3pvsnKiJ6NNFhcZW2U162K2KIl9xpqvLj/XgXR/hzWGHjw+T+wEh0ksRAR5
         X8F7nrxs4jRGj8G3aySYrvo6DG181oe1CAQRq1qGYhzoiDzvh9/+I4JNRZ1eg6EgU7/2
         uxNgZgBoeZtsckXPw4XrAVqpqmkawRqwzW86M6FntDSDFhk6cjWBC+PAH8migQrBygPq
         ypsK1cP8k5ZpAQM2PqWZGzQN3pTmJYAMpBhDgNyta2YFNkEyjcTLLI6P1uXTaW/P+WAU
         Nv9qjdzBGh1kzjQ0rTIuTFcDB1J3NkJeQ7AHL6op9a7rz+MD1KgNrQ20QaN+K1joYK47
         n19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398173; x=1774002973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/w5DLUFTZVMWmc49ACjqJvi6te4AWIx+IOTh3G/EERU=;
        b=ENwbC9cwBEeYoKMoMQIQfn52KFSy7zQaRxqJZH+RyM9zQyvA4s/meIGIdg9Hv/2a1L
         052LnE3vtBrXT1UXkvuTgwKc9VizEupNgA3hBAX+m9M0x5jrLwVMZTCuWSDy395bQM8Q
         Jy052KZ84atNN6pdo6ARFmPfLTFUPQInx3y7T5Ik6Y507UkCHUArtxjePLaqfmMPDoVd
         YTfboyq0Sf8v1mztRCtaUhws/bFg122JHFOW5Gij3RnsihmHPhpXk9fJZtxkyLcytpO/
         qWRT7PNS0q7mEdPrVa1IKytnlL1wz4KSmCkL6aa+NVw9F1hyi3Mz5BOg9paV3i2BnXMB
         aWAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZPbPh3C1xWXsGgbRqi8LH/7H2WxA2bMgJTt2cHs50SKkDTszZKvwWnskDadyIPhpKmVjNYLa6ODw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8vDEeocKSr3CTAS3TcmsgTTcRByvwMBxptRB+mC/YsA5c9H+
	9BAicblEaLdHfHi3LlJTrimHeC/eOU3mj28BvI5Gf9/81As2IdkPwmiRjJwWm1FBHcR1ZWhDs3R
	MMWFuLA7DffPyXZCSU9yRwO0i7l6Dt6NteRrCXURn
X-Gm-Gg: ATEYQzxiTkzxDGkjzMtcs2aD5mhom9f1lwOsxU72vbcAAKc0KiCQSqxeHiHWvbbnIxT
	FPhJ3WbVcf36pjPDDUG9XMMo6+FDz4jZnzfoUjsMODE+v2NhY6QHgWImV0VBHn24nyJlx9s8SUU
	9w7+EPivgtqVqm884MEoWQijci7HzNrNOn0cqwKTYqboY1mFA/aZVWt9LrpXGFhfb5B8BDQl3FF
	n9dBe3oKUTKPa2B7CpcPWL7e74UmI7+p2kavz4nxRtnvlN6fR+Hst4Qy6MlPpPla/6Nz2NgTodv
	7PA5wQPUEuz4OuLFyPFFv7dpp5r8wBOAflLdptj/mzcq+BYvNpWRanBXXcPNsRDnLBEssA==
X-Received: by 2002:a05:6000:2903:b0:439:d7e1:fc51 with SMTP id
 ffacd0b85a97d-43a04dbeec1mr5539039f8f.36.1773398172510; Fri, 13 Mar 2026
 03:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-8-alistair.francis@wdc.com> <8403c8b7a832b5274743816eb77abfa4@garyguo.net>
 <CAKmqyKMXmn6=suyjhB3Kq12-UHuLbPLOHPd2JO2b3Nxn4jYHpw@mail.gmail.com>
In-Reply-To: <CAKmqyKMXmn6=suyjhB3Kq12-UHuLbPLOHPd2JO2b3Nxn4jYHpw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Mar 2026 11:35:59 +0100
X-Gm-Features: AaiRm53JNqGQ31WbLp4l7arJWG84T-kzONXay54ApMwLtspn9NZSDJv5HhHLQcU
Message-ID: <CAH5fLggOnVguVErjySphX__vs3iYAo4O+J6hrXW546JrWSq5ZA@mail.gmail.com>
Subject: Re: [RFC v3 07/27] rust: error: impl From<FromBytesWithNulError> for
 Kernel Error
To: Alistair Francis <alistair23@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com, 
	a.hindborg@kernel.org, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, wilfred.mallawa@wdc.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:20=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Fri, Feb 20, 2026 at 12:49=E2=80=AFAM Gary Guo <gary@garyguo.net> wrot=
e:
> >
> > On 2026-02-11 03:29, alistair23@gmail.com wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Implement From<FromBytesWithNulError> for the Kernel Error type
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  rust/kernel/error.rs | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > index 258b12afdcba..569d9d032ab3 100644
> > > --- a/rust/kernel/error.rs
> > > +++ b/rust/kernel/error.rs
> > > @@ -12,6 +12,7 @@
> > >      str::CStr,
> > >  };
> > >
> > > +use core::ffi::FromBytesWithNulError;
> > >  use core::num::NonZeroI32;
> > >  use core::num::TryFromIntError;
> > >  use core::str::Utf8Error;
> > > @@ -251,6 +252,12 @@ fn from(e: core::convert::Infallible) -> Error {
> > >      }
> > >  }
> > >
> > > +impl From<FromBytesWithNulError> for Error {
> > > +    fn from(_: FromBytesWithNulError) -> Error {
> > > +        code::EINVAL
> > > +    }
> > > +}
> >
> > Are we sure that `FromBytesWithNulError` maps cleanly to the `EINVAL`
> > error code?
>
> `FromBytesWithNulError` means "An error indicating that a nul byte was
> not in the expected position." [1]
>
> To me that maps with `EINVAL`
>
> 1: https://doc.rust-lang.org/std/ffi/enum.FromBytesWithNulError.html
>
> >
> > Anyhow, please add `#[inline]` for such simple functions.
>
> I can, just noting that none of the others have `#[inline]`

I think add #[inline] to these could be a nice easy issue for new
contributors. If you want, you can open an issue on our github.
Alice
