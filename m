Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB61FF7C7
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771381103; cv=pass; b=c+p6ILGgecWq38fKaxNMSzw26VOgo+4OJxHObzWdW/2Cvut8qVWl6wX560ap+9iARYQeCAqhGPmocRec4o6Bgzwji5gEKrs2yKNtj/8cOue+0psFz7P1BgTVEL06L+r8bn4a1POCRxCyS8vtwZhI0vtdwHZUtSDBTaHm8l780Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771381103; c=relaxed/simple;
	bh=oisk5RNGpe9X3B4rnNrrpIM/YAw2CyQ7pCGjtBnp3LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=askaL9mFaUz+TmmAxTO/AkEpkLW8W70GRmN87HomY2nvAJeCXxxcV+Y89ibcekmAUaD7zkQIX6s/qjx7XxP74YpHEPLJOA0JVicMrtrlL2KuccmKzfEg/kP9Wxby7zyWvQn5AuNFB5mJlGKezGXApUabynymEcIYbzATrUN65Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpByvxaA; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpByvxaA"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f8d80faebso58892766b.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 18:18:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771381100; cv=none;
        d=google.com; s=arc-20240605;
        b=k9Uws9BiAt/esQZJujFZoVbZJtiRpRsSNESl6DOxCRTubVu3vwapb4E4YU4/PfvQWi
         SkmgoTP3HVY1Lt5qXdVpv/0ErKBUtlEvsMhsfy+Itcg+/mILJ4u+raSPHIuhSx+qYo8g
         OIP+LzuWu7w/7zdwkiUNN6sNavFd8q4cAohqBBK5zG7il1IEgh83o2ALn3wK0SPAPqM9
         dqJSaL9XVdpOxVmxaq9sigx8jycTusIxPoFwn6Jrk7W5m+NH9aVuxnISysdQzAnOXBPa
         4OfRzCWLkPWZM87bD0KiV1DruqYqOaqdhRtZzqxlv72Z4tCNSLHFc14wMke0glGHZSSU
         Mc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oisk5RNGpe9X3B4rnNrrpIM/YAw2CyQ7pCGjtBnp3LE=;
        fh=Ikz4S7bRKIBQpsHPXZNjydW5OblKZNO2FnNjF8zCDjA=;
        b=EY7z4Nm1p+NuZoVdGW7DZi6d6yIxYYzGlJAgzW84nXRGkQWCvKXBGo/+rpUM2zrGLi
         b79yG8OEt6ULArPVj12jaVfM7RD22OIyTM3Uh8qAjvBlPy8qG+y1h0PFohFyBPprSqK5
         vtpAepdKY75DeOOR80JD6G9Wo5iIvulL11XrLrh2NcR48hY7wVc3mQfnHRJAsdi/+lAa
         h9bQRnvZgV5kJPwChSAZJxEodYa0htBBJrsV+QsgIK57+kjZgLR8FY9bX8G3dqCc2DqL
         hWN6EQ/wxFoyA5yo63J7xoROVAtDLMfbolSxNIoBL//DyXTttsjwdEzuL2KTPvryh46X
         CCAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771381100; x=1771985900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oisk5RNGpe9X3B4rnNrrpIM/YAw2CyQ7pCGjtBnp3LE=;
        b=jpByvxaAdfjRsOfPiOQAodpAVVLRxR2MeIWdlW005xLzXoPH5BcC7s2D1ShgO5j5Jn
         /y5Wkpb99qJui36tSejkvEPumsE+akubQsBud21XznDpcTLook5pCeIQPhODlaJFxxhJ
         r+EVvQc1hq30dbFr5ox/aoFhrKZNckRT9SpUEfjdQ1mJo6+AJhoE5TS1144JAAAukZI+
         iz32grPxYgG1OY79JknQBUr7T3ctEPqWcfhq/0IzYo2KauXMC2J7oo/ULaWvjzoEhpdI
         lAvEiCrzw0hCw+IGQgqSqV8b4plqrYbBdblU8axZlfnmaIRASpTgkIw3hDesAIMOytlV
         WCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771381100; x=1771985900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oisk5RNGpe9X3B4rnNrrpIM/YAw2CyQ7pCGjtBnp3LE=;
        b=RBYoAZrOWO/zv2vFatNlM7wCzusl1uI71tVYzUsew2HwMHzGlHKhCxpQ7hooDdxdzv
         3o1+vIkyNAAHTay8ZUKx+AXzYRLPulG7lAEL1vJ1VIpxSLWESL5OvuUnEs3T9Y3MN9Dp
         bJsXP2TL/xsauyHsbfZTEpLjVDDptzgohs3GPN8JuuSnHOo6hDw+CaqnI3YBMsX6p+MX
         N3atli/I/KVbh38IzmwoODyet/6dTurRaD0tZcZWblxI5AyJURnb2hwnrPUCrd8N55PH
         JDNo5E/OCXCDROt/qH823gH8x9s44fiePar6l9MJ/tUNOO7IBNvJgju4ikptyNIWBSyg
         B0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZDCm+vmwz7K/d3N43oaKUw9UlATpNzKq2N4i0ImwClbKQ48ljtQ8gyvBQTh5d78vESiaXF6GFg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWZUIGK/DiYvOUKkphImWun8F7J8wIKCDxJElbBp4OtASZUeg
	S1HSqhGCVZEAxSEIuvZ09eInfEscKSPsgUVtO7uswiL9+qkHpNvEWl7EZhGOBCZbVAzrGi0Qi3x
	5Ma00teCbnqYUssIGCq1ybVCUQ2Xwb6I=
X-Gm-Gg: AZuq6aLhkLrVpUpIADw8ss0kPyqrhzYC3U+Dm/Y8WeuMLz3SFzLneMmFK3cxoxpse1R
	CD37731ntgYJ1GSqWpa6YhHdeeQFs0/irs0J+Q6sBjaGhUrEdlSM8R6h2da9xRSpyKQZxpDbljQ
	6XVzVvn/AQm0tjP5kgq8RqAE9FuFyNAJrv/mvVX0eLVJepsaW3Cvd6kD8vRyoGOUG1qsEaTWbi4
	3fGPLzBxzIxDZl1/6i8hdHJweHv/N4kONZSflfYXyfVDsaEettIWeuUaVAsUW4i356GzfSTxF/E
	OWF/LzSyLgFNc8Si5arqhr/k5ZGj5rSWko2DQw==
X-Received: by 2002:a17:907:8e95:b0:b88:50ea:f64f with SMTP id
 a640c23a62f3a-b903ce412bemr23014066b.11.1771381099947; Tue, 17 Feb 2026
 18:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com> <20260217235604.GA1595019@nvidia.com>
In-Reply-To: <20260217235604.GA1595019@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 18 Feb 2026 12:17:53 +1000
X-Gm-Features: AaiRm51IyO5p1ZFm7PemT4PZZF2gD_mhc5e0kBVSJ5OU9yRJy4LX-SjwiRKMPKk
Message-ID: <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 9:56=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Feb 11, 2026 at 01:29:07PM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Security Protocols and Data Models (SPDM) [1] is used for authenticatio=
n,
> > attestation and key exchange. SPDM is generally used over a range of
> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >
> > >From the kernels perspective SPDM is used to authenticate and attest d=
evices.
> > In this threat model a device is considered untrusted until it can be v=
erified
> > by the kernel and userspace using SPDM. As such SPDM data is untrusted =
data
> > that can be mallicious.
> >
> > The SPDM specification is also complex, with the 1.2.1 spec being almos=
t 200
> > pages and the 1.3.0 spec being almost 250 pages long.
> >
> > As such we have the kernel parsing untrusted responses from a complex
> > specification, which sounds like a possible exploit vector. This is the=
 type
> > of place where Rust excels!
>
> I was arguing for exactly this at a recent conference, so I'm glad to
> see it. It is a great meaningful usecase for rust in the kernel.

Woo, someone is on board!

>
> IIRC the netlink was my suggestion too, it really needs a careful
> look on its own. It is much better than sysfs, but comes with its own
> pitfalls.

It was!

>
> You might want to try to break this up into two parts, one just dumps
> a large text file in debugfs where there are not uAPI rules. This
> would let the rust work proceed.

I'm currently thinking of splitting this in 3 parts. One for the
ground work patches (crypto), one for SPDM (without netlink) and then
a final one for netlink support.

I feel that this RFC proves netlink can work, which is important. For
SPDM the authenticated syfs attribute is enough to provide usefulness
to userspace to merge that while sending the netlink later.

That way hopefully everything is a little more self contained, but
still has users and value to justify being merged.

That's a good idea about debugfs though, I'll keep that in mind

Alistair

>
> And another to introduce a proper uAPI for the data.
>
> It will be easier to get the right people interested in both parts if
> it is split up I think, given the size.
>
> Jason
