Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B139D6DD
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036493; cv=fail; b=AqGzVEuzcDwqsnMcIsBh/1Jpf5ljkiJKM1vARktznOyUkVpOE9LoWXq/kKjGG9QVcMgwJKaqi6MHCHpXr4zNwpJfxHRAedWGlfQ3WnE3xT9Id+38Pv8gS9v9f7OXzOPGHs64qeCBW29qnMG5xfBBSPfbr/gO3REVdXcPLIo+xbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036493; c=relaxed/simple;
	bh=ZiT8x+cfHgSyrwMnA66rNUoxHkXDnwIwkwrIcOdA0Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuBic7kaIy62AS8xr/2mLCmK/uGgUWk8MQ6T2rQsicOIPxSGL4eUKkEUKWjJrdDKEAbzBROmniwgnHmpTfpWO6SJQn0rgaDXeIIHGMBFiMy5tkC2CR7WaVHVDqR8xm3Dz+YIH/E0TzU11cBC1rfBU413wc5pJhvuaunGum/hs6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tE2F1C3+; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tE2F1C3+"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64SM3ooh3102659
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 23:34:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZiT8x+cfHgSyrwMnA66rNUoxHkXDnwIwkwrIcOdA0Bc=; b=tE2F1C3+IWIc
	hD6uPAo9NgDmLx3SiAIqN6xdU/vi1BTlNSH50fpgV8+w2z56TbYNWRvwyATimLcQ
	6gBB7u+bSsBhHZxDEcSgqK3/4LhMs0I3XhEpCctNiBQjacxzZ64Ht3GAKINKXsRe
	2a4b6ZZDgp7DFIXB6NZzeM/x8uiRnSviRZdPNOFY+C+No5faqHXGRxg3ix2FcSdL
	ETSBtsgPPA9Za6p83WxjzQ6xcL+i2YajrLWFKyrDiNGr07q5cwUoyo4ikTdnEkY3
	yiwI4qfRPsWTAFXgnVqxw2XBZSbFpE5+g2k/neK+34pAldo7nom/u4tzd6ac5WIM
	FzG4O2F7ag==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ee7x6a75x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 23:34:51 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e61d8d99dfso9961756a34.2
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 23:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036490; cv=none;
        d=google.com; s=arc-20240605;
        b=GZK62lUSSDKOKpZdKTX1VvJaCrhfDCZFYdSR5NGZcrWmmkIxx8Xnoh11/AkjVFmgPw
         8b0eR3NWcCYCHx4QWYWMi5cxwmnVhkZMK9yBMEvvJhX5vIyQeKKr8SJ7LuiINrDOOW4I
         KtDgIkBvz17eWme1I688CooYtGFQSj0dev1b3TfUQnrQAwuDQbsVxzmYvoy6ItJ4QjLe
         zDPl/XpZ52rSGyTRiOam8dt7MTLY1Q9XD1YeLeJJ8rDrYjku5LxTRTVyWHC2fsETl0Wb
         lDV/YbC9PtLVH7jgZz1XweVBc35lXaDZPQOtfvaT4MmLyWiNAtOvGH3AVS5dlA89coiu
         pndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
        fh=56RlzcLWI1UJ59P4j+EH7kcdSh1KGvaAdrizfp//ick=;
        b=Vw9PMq1plhMwoAGdmt4FxpwGAJs5X8ivAaDy9WtdYLv1eppAzOvr0yJE+XjBBEAacB
         KOcczApF9IpWNbe/vjFUzS+45IWENA9vIgraEuDBHrzNF2Ltqvh8748459GbXPsK3d1x
         WTGgjBE8xIhNAv2kRJolOR2MnyIOsHiGhwOsO/SJ0AoV7cEzs0BeowTk1UTP+/xMOKJX
         UJpiOvIfJmCSzdePdfnPvaYDwoFmJNI4xs5dVsUeCoNPShjew6gyyHXGMkwPfeDyNtYg
         oYc2JRV88IBwJ5BQ4aWGU+JxX0wGyCMrClZZ5p3aakRYNmlXK3E7nKCxrQ9gdUI7GK50
         /Qpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036490; x=1780641290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
        b=sKgwcuU5QrX1WzT/NwUdzUgSjtgHUZdZddUrAyjum0ez4hN7QS/fnGYg+kChSJNBvy
         2u76HBjEI2hycKazIdXHeFKgnj1SEUor+fQjKwqlJ8uLQDVht07zrfGP9EHk9/TOWhz9
         ibr4//nsLzxv4GlXDIZNl3MbLuGa+OwbE8phi/LJbNNtaJnG8UVHVb9YTAMqkgzHVnaN
         0vgDgPzcGDvpXXJGVhG1YdcZybFBr9OC8dvaYnK1xa9gfdI0QppBrDa3yR7AJ5UXuH5+
         qKWISeu/CaSjFVfOMECBqXyA2owsPEhKFJAFjmUtsNZPFwMNxbQ07MorWXz8Wdo3n+Rk
         KiZw==
X-Forwarded-Encrypted: i=1; AFNElJ/7AbJPHCbrHo+GhMQZ7jyXKUtNoMjPGLHMnum+NZ/Jk+RHIRTs2LtlxtEQRkm0djKkGqdN9weUcLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/Ocvx8MK5qDL0gX3Lq1nOYEO//eQ6EKcrmYu2IAr/x2bPdov
	HG+2wj8RuoVHcEXoAhY1liWDvXt2BZHc2GlM2ZWpuCLagpoJx10aWabIIf3aggb/oddtxKvjW3Q
	Ts25ZB9AFFyePj1iTY+nmZ1dFbmhm26GhrXjiigubRK5kom8t/F820KTzp8e19xvqCGPhWy48Il
	cGraxETwOkE6rjSDsoxzfw6oAtH12uGrUNWSs=
X-Gm-Gg: Acq92OFaJylrAdt7UMRXReE4JqMci3PHaybSmPkq2323blyDfhMApWVA0uxoDHuOz3R
	MpSS7HoydGFbbMM8xDU4jT0zidSDxqs0FvTwTafZjzLhx0IzjbsPL4PkuwDfZjvO6caLd/9xCK+
	PcjPrZOdWDWcWl1ccOP9nVmK2QElOKxvo92xgq1gpLRpYe58HdO99hPa1ssM0i0i2qnn7xpi1Ew
	j7td/x6jF34I2voCGxnhmL2bx96my4fMZ4iRk4Q5Xcf97E6Tnk=
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7e694dc2b7cmr1101949a34.17.1780036490396;
        Thu, 28 May 2026 23:34:50 -0700 (PDT)
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7e694dc2b7cmr1101924a34.17.1780036489896; Thu, 28 May 2026
 23:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca> <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com> <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
In-Reply-To: <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 28 May 2026 23:34:39 -0700
X-Gm-Features: AVHnY4LezOs9bV0UClJoUOHcNCdwbl4qfviQEKqNUnQx0j2Atcq5JV3HHpZqmfs
Message-ID: <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: mzKlvmktpbPi_I35empn6ao08lqkaOKg
X-Authority-Analysis: v=2.4 cv=d5jFDxjE c=1 sm=1 tr=0 ts=6a19338b cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=zd2uoN0lAAAA:8 a=f7uq7ceqOUF8L-MFIRoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mzKlvmktpbPi_I35empn6ao08lqkaOKg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MSBTYWx0ZWRfX8nZPmhe8AJpj
 9buDFSzjMZTtkr/xoy/T+W2QIu3nZsL3jNDF79fOUClZFJInLcBNyo2+sVM+uJ8BG7sTUwVrzS2
 Dh5MZSaPkJb5yBM1lXmYwMxmqVD2o1mNmEYuG1gqloAU3lHNM/ehAu4awlz/rdCvQT/KIc5e9q2
 uOCTn197ru+1TiWrYtaAIb0oT+gy0r/rsrwRBTF9wntPsK579YYVhqhkMII9JtDKGI37xKE1qa+
 SfgKWcv73NmhNUrDqqYy4jLh00s8xE/N21BOJKJBmEd7GJsZO9ZXfYfG6LR8mVwRfs7zZ5MRLCA
 wnyAj5QdSGFXQqHyiBppiTOA/eWl+NeJQlNYN5BjIc7XRNaPXGoLoKHOFyOn0h995FWGKFJxkh7
 OhozpsACByi7ui3qu5FOqSM6m9oL6n5aogj13lMQZCgOyyNYCLo6AMY71z2l4BGDJ6WOCFAo8tx
 cN9ZX98wNMVPOTg/9kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01

On Thu, May 28, 2026 at 12:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/28/26 06:55, Zhiping Zhang wrote:
> > On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >>>
> >> On 5/27/26 14:36, Jason Gunthorpe wrote:
> >>> On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >>>
> >>>> Yeah that's a good point, I should probably rephrase the question.
> >>>>
> >>>> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>>>
> >>>> But my question is how is that useful to a PCIe endpoint? What is th=
e effect of the ST here?
> >>>
> >>> TBH I've never heard Meta explain what their device is doing with
> >>> it. At least it seems to be super important to their device..
> >>
> >> Yeah I think at least a brief description of what is going on here wou=
ld be necessary for the review.
> >>
> >> Otherwise we have only the info that the exporter wants to give an opa=
que ST for the importer to use and no technical description what that is go=
od for, how to test it etc...
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Jason
> >>
> >
> > Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover le=
tter and the
> > patch's changelog as well.
> >
> > The short version: in this series the vfio-pci device is the completer
> > of the P2P
> > writes and mlx5 is the requester. As Jason noted, ST semantics on the c=
ompleter
> > are implementation-defined, so only the driver that owns the completer =
(here,
> > vfio-pci on behalf of its userspace owner) can hand out a meaningful ST=
; the
> > importer treats it as opaque and just places it on the TLP.
>
> Yeah but that is not really sufficient to justify a driver 2 driver inter=
face.
>
> Which PF driver is backing the vfio-pci and what effect does sending TLPs=
 with ST to it compared to TLPs without an ST?
>
> Regards,
> Christian.
>


There's no in-tree vendor PF driver =E2=80=94 the device is a Meta MTIA
accelerator managed entirely from userspace via VFIO passthrough.
That's why the ST has to flow through a uAPI: userspace owns the
device and its ST table, so it's the only entity that can publish a
meaningful value for a given dma-buf.

On the effect: the endpoint's PCIe ingress block uses the 8-bit ST as
an in-band instruction for the incoming P2P TLP =E2=80=94 selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework =E2=80=94 only the producer (userspace owner of the VFIO device) =
and
the consumer (endpoint block) need to interpret the value.

will include these words into v6's cover letter.

Thanks,
Zhiping
