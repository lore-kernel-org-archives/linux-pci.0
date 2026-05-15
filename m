Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C879363C66
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824215; cv=pass; b=jvVkK3QVqzC6bn7AeiN18zCszlDko9I2z8EkJxRm+0LTB70KDzU761y/3/U9hjzsIlO/2AJGV6v0wWdBvAlz6ycX5szBzupli9NsYX6ezHCRdZ+dy7kzLlC0kNu1XLLPVb2VEj23a+pd+UMsR25W2OTzvrc3e1NLV1qbjBi8NfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824215; c=relaxed/simple;
	bh=nzhCIyjq9dCkSwtjw+Q759vI6aIMENQjE3TsKI87kZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KP2UxquIYwKDflqPqDqaGte0nMtESQZTA1w7m2V9CDVIx2Kwy7jkZ0Bsvx/NiYeqDTC8q4kLJuOosmFUxGlWbbushpDAvBIbQdCOSjMkirCa8+q7lKK/hIc5b4tqppdbOse09vaSsTJJKjKZeETG6RJyi76ZBNfAvusou7q4jjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFe3Worf; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFe3Worf"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd0fc4c336eso938796366b.3
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 22:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778824213; cv=none;
        d=google.com; s=arc-20240605;
        b=hD4AOPicuIhYTklKZxNZBxAmAL1Bp97jnFVVSLx5cFU85eNDGCr/GlcKl1q6HJ2lfg
         y9mthqdfEMc24Lzbbd/ZownRKQpf5ucM7psp8DweJg2y0U8cQsmFN8pXmCq382sJt17C
         E1tYWRguAi+HyRcAt2YG5zlY5/lkxUuIK88BXRTTCloTT/ew3oEYCrxbes43nwNTMj1F
         lm379x2Edp5KhkKoKp0S/LPZtBw2Jwo9PIlFvznAmisJ1X4A/9XT/Y9p36EPGewDRN41
         SDfu63Drnz2IRhBwIt0cXLeG4c96zEKImPkpsrWLfoVS0hJ+W0+hoCBzaeSsd2YL0SO0
         9ICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w273JBfFAtK7fZhrin4tOyF9swchXPtxmQn41Rpjp3U=;
        fh=zLsDTHEHFho6W4Kdi4+pxKDOXg6ocArDvAVGFpTXsk0=;
        b=ISzE9wPt60LeoShLEI0Er31qJj8swi4aGVCZYAdST5VLyianqLkutUyCBXqCiIosUo
         cWJW0PT4yHtLUj9Hqscc9Js5GwH/J9zw2KcDwm5KPT4VKodh8lpLZLKPZWxM+LNF1KZd
         Gqm0PA4kLP5vaS4GFNI6m0ybVS/BKHA2VNL4wYQRBuyNuZCq6HLRztDByDQYlGtRw6RV
         nCp1fPxq7wEVbFH22gI2sZEFpdf/8ytOIs51MiSCkV04zXO2yhnXzV+tBU8HrKH1hm61
         teU9DaHW+bjaVzkEeiLkYLTwL/skXYBZbwX6mVGh2iSp+kYdBvzRDGsxKU1nJlN2Hpcd
         cAZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778824213; x=1779429013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w273JBfFAtK7fZhrin4tOyF9swchXPtxmQn41Rpjp3U=;
        b=JFe3Worf1ZVFhemrBt9Q7tj3FHueD+JT96nrPq8B9R1UhAKiEssAKtgQ23kMHx0OXc
         wYZlujkYW1G1yTqF0bHeeiec+TbMhy2Gl1C5MyeYBjmh6OorsWsBXYiTBdxYsKKrPAQf
         ZnfYKW1pwclNKGLH/AoNBPpqcOpSjSA3hU2h4/j2ujp7TiEo9hqfppElLTE4OPefADW0
         bo7exsvtXChAU39fNDKU0k8wlMKervmDafPcqyjbIGjTYKsURpDtk33Cx7pcsH3MWBW/
         YB4r97t8seQRIRso7Jdqbpok/g71Dd9zPNzM0TD0p/XYeqSZXEA7QErO7qN0caN0m36J
         m2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778824213; x=1779429013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w273JBfFAtK7fZhrin4tOyF9swchXPtxmQn41Rpjp3U=;
        b=nFh+1mZC61ReGkvRqptV3+i+mpeTeKfU/+IjYEdSCS9u8KO4+YcPgsgzi887bllPFJ
         A/2C/eJoFWKQLaigXcYwj8P33VTUdeJDahhpv9G1I11WeMnVh6+64AMJB37RXK8RQz8l
         qDX/iUgod4DTiawWaQ0ZOybY+Zro1aylL3BmqXBvwCKcRwAi3XWYpq8ztPLPwhOUjXdl
         yHBhEZwhThxEnnrcUKDT1ASYwxTmE7ToCwb3h1G7nwb2GlH28BQTsr9YW+Z0z61d05zV
         ugurjNfxmy+sZX8Vj/0N6/kJ3NoZNROjN6a47dLd4X/2l2qvx12+3vlKlbEIHKSTgPgk
         SfUw==
X-Forwarded-Encrypted: i=1; AFNElJ9qzGuhOHgcRMab7xlp3ZNtcDvsULzN79NJVUonU61ABVCWAdZljf6gB9cBhK+SS7wqa6OvpB+LadI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZup+cOuTlk7YcOlduIk5/ozvmgScphPErMOHU0ts3+5vhNx0A
	dtXdp7tAT7j1RK84ga7WEWnQTEx4cLjHKPT8i8qejDE8Yjvcr93NUan+ZsDTKHr3xBZE7PMbOWw
	9V4oWMUDlWd7Vl7RbItm4DJMCSI4jhNQ=
X-Gm-Gg: Acq92OE7xIzWSstr3QMREVooaCp0eaRy1kCsn84rb9+RrE1tlamcHqVaRSNgt+rjQwi
	EJ81UovagUm9Azys2eUICq1KYeJ6fH63e8LRmPzRnciQBGrGoY0y5xyVYy4H9iTVMQOCo1kl/SW
	7pGJnQWN99zZvwiPSusuBeet0J7x3hakS5hB0O/qM2OOMmkbIuzNFhsndVPyoZXPXH7+VqgO2si
	1dxnSyrK206lUyJ1AJsykjmnhUBNweF/AKnU3OduTSFS62Fb/O8oqfwbrDpus2QG0fpewV9KWfI
	S5090df7R1gvktGT3nqsVPzWxyFYXFofOWP8Pg==
X-Received: by 2002:a17:907:d06:b0:bc4:d93b:2078 with SMTP id
 a640c23a62f3a-bd5177b1eb7mr127852466b.12.1778824212515; Thu, 14 May 2026
 22:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508031710.514574-1-alistair.francis@wdc.com>
 <20260508031710.514574-2-alistair.francis@wdc.com> <73b1ecdf-8754-4c17-88af-671246a6787d@de.bosch.com>
In-Reply-To: <73b1ecdf-8754-4c17-88af-671246a6787d@de.bosch.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 15 May 2026 15:49:45 +1000
X-Gm-Features: AVHnY4K0YlVX7ccrCIg2Am5gWOTSrQqEJ5vMNkhmej-0Kw8vU5JM9pQx9xSl9Ws
Message-ID: <CAKmqyKO+Pzj_z_r_tmVCuTt4gacrF9M74WknciGCbHGyBn5L=A@mail.gmail.com>
Subject: Re: [PATCH 01/18] rust: add untrusted data abstraction
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: alistair@alistair23.me, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	Jonathan.Cameron@huawei.com, bhelgaas@google.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-cxl@vger.kernel.org, djbw@kernel.org, linux-pci@vger.kernel.org, 
	alex.gaynor@gmail.com, wilfred.mallawa@wdc.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu, 
	ojeda@kernel.org, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 3:18=E2=80=AFPM Dirk Behme <dirk.behme@de.bosch.com>=
 wrote:
>
> Hi Alistair,
>
> On 08.05.2026 05:16, alistair23@gmail.com wrote:
> > From: Benno Lossin <benno.lossin@proton.me>
> >
> > When reading data from userspace, hardware or other external untrusted
> > sources, the data must be validated before it is used for logic within
> > the kernel. This abstraction provides a generic newtype wrapper
> > `Untrusted`; it prevents direct access to the inner type. The only way
> > to use the underlying data is to call `.validate()` on such a value.
> >
> > Doing so utilizes the new `Validate` trait that is responsible for all
> > of the validation logic. This trait gives access to the inner value of
> > `Untrusted` by means of another newtype wrapper `Unvalidated`. In
> > contrast to `Untrusted`, `Unvalidated` allows direct access and
> > additionally provides several helper functions for slices.
> >
> > Having these two different newtype wrappers is an idea from Simona
> > Vetter. It has several benefits: it fully prevents safe access to the
> > underlying value of `Untrusted` without going through the `Validate`
> > API. Additionally, it allows one to grep for validation logic by simply
> > looking for `Unvalidated<`.
> >
> > Any API that reads data from an untrusted source should return
> > `Untrusted<T>` where `T` is the type of the underlying untrusted data.
> > This generic allows other abstractions to return their custom type
> > wrapped by `Untrusted`, signaling to the caller that the data must be
> > validated before use. This allows those abstractions to be used both in
> > a trusted and untrusted manner, increasing their generality.
> > Additionally, using the arbitrary self types feature, APIs can be
> > designed to explicitly read untrusted data:
> >
> >      impl MyCustomDataSource {
> >          pub fn read(self: &Untrusted<Self>) -> &Untrusted<[u8]>;
> >      }
> >
> > Cc: Simona Vetter <simona.vetter@ffwll.ch>
> > Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> > Message-ID: <20240925205244.873020-2-benno.lossin@proton.me>
>
>
> Today, randomly, I was about to ask Benno if there are any plans to
> continue with his great untrusted work. Just to find that you are
> carrying this forward. Many thanks!
>
> While trying to figure out some history of this patch, it looks to me
> that the version you are using is Benno's v2:
>
> https://lore.kernel.org/rust-for-linux/20240925205244.873020-2-benno.loss=
in@proton.me/
>
> ?
>
> While the latest version from Benno I found is a v4:
>
> https://lore.kernel.org/rust-for-linux/20250814124424.516191-3-lossin@ker=
nel.org/
>
> Is there any reason not to use that?

Nope, there isn't, I just didn't know it existed. I have updated to
using the v4 submission

>
> While at this, do you have any plan to add the `Validate` trait as well?
>
> https://lore.kernel.org/rust-for-linux/20250814124424.516191-4-lossin@ker=
nel.org/

I am using the `Validate` trait, so yes :) I have pulled in patched 1,
2 and 3 from the v4 series.

>
> Thanks
>
> Dirk
>
> P.S.: Carrying this patch forward, please check if it needs an update
> regarding new "rules". E.g. it looks to me that there should be an
> update regarding the vertical style for imports?
>
> https://docs.kernel.org/rust/coding-guidelines.html#imports

Thanks, I have fixed that up.

Alistair
