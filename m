Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBBD30E0F1
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821370; cv=pass; b=ENX8lljVj6RIcb1Y01I/DUV95hbKNEaaoB04uwAqMn8ANY0Mb++r8PgzsiYhG700xvkdV9B6dM55OJtTnkWPDFhiw3KwIiYooXCqfxl+s7ZLlX86NqBTmofq1SBdiNfR5xsP6OzVtHD3pk9N3nmKsmPdtFRFuZlPDXwZdMSdyac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821370; c=relaxed/simple;
	bh=Ee8xVylefUxsgAC7/wUPXBUGosnDj2MjwQFydFBfjuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVj5kM69yZWA6H8hr0anjTkoeZiFqxzAhUw1wu1ddZwmlOpEtjwqEkGzl0LHqYUbNGJh5oiPW4Z+Pa2qDUzxIgxmgiEVc6/s/+oJ/rJQfQXpMi2XSEkbGQFfZIiYA9ypNbmpZb2no/jmVq8CAGKtFUlRFbUfMXHRyPD3SDJKL+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/gtWsTx; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/gtWsTx"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3044f23f716so359196eec.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 11:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779821368; cv=none;
        d=google.com; s=arc-20240605;
        b=U3UiFGYA/O3IGE0FswwopsbPZjJl9tnOwKIrw57ujkIJNiIrfY7PLzot+CPUJRpbaF
         ExQiyd+jv+hBsuREWTlxdhR9n+nyZ4uaHI337l2GJkZlNOj+80ABUK3PyDKJNR/CRpFQ
         jxYHmpzUyEWR1AJu0uOGGXnO4xOzliPXcnpfeYjJxnq4eOJB+vSNNN7zlat/w7fZEaey
         ZAUlClnDvV7dTbRmbxIrcRwKlCnVFrungkBcjEhB5oEtigRA4fX7wXRHWoa81i07l3ok
         7+pJgfKB6GdBqif6ndJ9SLYXQsaHAeZDVfsWN76ztXXcU7rwch4NkOCh+mqR5b/7k64h
         j03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
        fh=aPaEpr5U2ljpSlLhKiiptoeJ8LHaTyIxh3fcxcOvZvQ=;
        b=MWCqo0OYKqNeKKiKJpa3eRO3Xfeksho+ULjorilTehSV2KklfZ6e4S1rqBayWvjH1L
         A/LWMTEAA8D4DI9WUzdglI5/dcr68wvRtBMv06URvZIQqMdevct4knNIlEdbYYJscBe1
         8VC1QlZAvPPx02v9UT3jFmzMfmWsYwe5khaDkRzIzTQoy9cLhL/Umf2e2y5Li73H6e7/
         vmkBOBDoisbDqEBBicaSfu+9njHW0ZImBsIR1FAWUVCVP571TzJTwSCikseD6opmsgSB
         f/56HGmUnoBFiO4sSSrVriVzhJCWSmveYxlgm31jNVNT+MfQzh5cVZiw7SI1HfhjDvq8
         P2iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821368; x=1780426168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
        b=H/gtWsTxLU0K+b4gFr28hm1M2IqFsQtp4OhQbOtWzR54nA/ZWN3No/6X/dzvj2sjCI
         tI1SGQ/6hvbxgGEa4S4DaMWZ2UZx2QHLMa/SddknnO4shgZFUzr1qjKX5H6YqO/YltR1
         R2KyKjtM5f1mOQxdlutG4DMBrlXHvM61XCxRtqLq7Z41pZjXRwrc1fhoC5JoDq7Lzme9
         XfmcQrhbEUshzeGkdyJRCHqfeuxp6qaxRBJ1PTfswoFhRD8OiVJSjIDm3ZWlwJ4SzMkp
         i0Zy4SaYI+HOJ/7EgzgfiDlPLcjU0bM7xMZv50tVSH2f9hM00/tvYeQscvP7+VM9a4II
         nHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821368; x=1780426168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
        b=d5klBhBmmcLzoyCQjw8+cuW+h6Zy4pg/Duk9ezn7wrnyBtPTtpIZVO1NoePXdP8alh
         tGEJJuH7ly2H9G4/Xl8ECNsgdP2vqmhcTNBwEKPevKatVKkEdIZzfnmSrXgf87XcG3No
         cPSqDGIhLc4usPpyPBDbnrgNEbcIPpcbliNVIRCnXDCSeKD/G+6eGZvpoSuKLhwO7TJ7
         qPVGNLy4+QQwigTyxCFq0e4CRvR9FtTtfvZGMe20mvc7DdqxbXmG8n9XhLh2NwpSy5I4
         qTdK7UYZ5ohQvWuilqweCQ0r71XTKme+UMak8rJYlkCf0RmMXmV7yCf9VptbV4quZD5d
         7Pxw==
X-Forwarded-Encrypted: i=1; AFNElJ8yWi7pvWRDMQzPJ55MOTOJYTHvTFSwc3mu7MzJ6VDieMhTSuDpnrzTXiD4/GKAxBspCi0JH4gv0WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2CqRPTwPkBpysHZEbg2SD6PEvOYQ70XI+DbuqQKdncSF2AgLc
	BMUQRvVOMFIKbKtfulSV9p3uQRp8QrQCSsSFDoXgWQj/e7ngBkhTyaKCAB86jQwAvc1J5t+XekQ
	sXuzUjn6SjSMOK2ChRVHsMQsAFaZH1cA=
X-Gm-Gg: Acq92OE4xcZqhzwYndwrzEYgZ64hIGFv2Ng/AElVazQgDBpXbP1mZnv+gqS59El3fV0
	TLuciE9J582isiPRGS3uZFTtorV+qG23UWk23eH2L525Hfn7QGhS50ivGreh3AXlQLSIpWo+uge
	gLaop7UHFbxg7+yt7XkPHwkJgQzPIvX9fYaH8NqMEYkCMndAz5FGo5fOHemdXO65ejkKMd+g3Z1
	GndmOl6IiDaffPZqVWWDohnGXrNkhDUZYpWs3Ezim6oLhiiFT7ZEtAUbEhvaZd8nVI4d9ht36mk
	rbGNsHYdRYmcRlts+7kX2DsJd59UJdtPXxrQhdwRVWMMZpBjgIowOtAkw8Q136uZXnn9AdOtK4j
	vDhCUAr2qZkImuqZlZeFOxAQ=
X-Received: by 2002:a05:7300:5711:b0:2dc:e799:934f with SMTP id
 5a478bee46e88-30449099a11mr4340063eec.3.1779821368216; Tue, 26 May 2026
 11:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525202921.124698-1-dakr@kernel.org> <20260525202921.124698-23-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-23-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 20:49:15 +0200
X-Gm-Features: AVHnY4LynmVmerdJFsxXUCWY1urLy48wQB7u14V2mO2sDmYd9U9x9x1s6x7Cz50
Message-ID: <CANiq72=iLUncNw35tpRinUt15W0aqsEiNn+rMcjC3VGq0gx0Rg@mail.gmail.com>
Subject: Re: [PATCH v5 22/24] rust: types: add `ForLt` trait for higher-ranked
 lifetime support
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com, 
	ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	pcolberg@redhat.com, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 10:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> +/// Representation of types generic over a lifetime.
> +///
> +/// The type must be covariant over the generic lifetime, i.e. the lifet=
ime parameter
> +/// can be soundly shortened.

I wonder if we could keep some of the commit message around here -- it
was a well-written one!

> +/// The full syntax is
> +/// ```

Nit: we are not fully consistent treewide about this, but please add a
newline before (and after) examples/code blocks.

> +/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse=
<'a>)`

Nit: please end comments with a period (most in the patch are already OK).

> +        // https://github.com/rust-lang/rust/issues/152489

Linked to:

  https://github.com/Rust-for-Linux/linux/issues/355

and tagged the issue with our label upstream.

> +    // Currently the Rust compiler doesn't check this, see the above Pro=
veWf documentation.

Nit: `ProveWf`

> +/// Obtain a type that implements `ForLt` for the given higher-ranked ty=
pe.

Nit: [`ForLt`] like below.

> +/// Please refer to the documentation of [`ForLt`] trait.

"of the"?

> +#[allow(non_snake_case)] // The macro shares the name with the trait.

We normally put comments on top of attributes, but if somehow that
messes up the formatting or similar, please ignore it.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
