Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CC35D5F8
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212100; cv=pass; b=qwAUbq7KCyTYL5igZLfuMLph+ykpK4Dvo8SODCREPLwcTaazqIUDRo4Jh8BY555ZD1WExtTegFpbv4fsDlLbvCi6zzR8fVGxdBLppDxjen4A3wtIs8K0rXhO82r+lhQ54zWZddTsoSsHvFRYne+I+tYFWSGyPy6ZHxBW+MX9LhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212100; c=relaxed/simple;
	bh=hgtMP8VUtY9P76ez7WKUM8aE1sgvg9AP+19rjG+g6HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKcMMW92lSEfB96jV7Fds29kafD+jg+zzdft937YZZTArRTP/BczCA2MLq553xqjomAoocXUwW+oTHk3gpuP2VPLdAMahxdm5/NZbhGxaPuxHCj1RfYDHmcXqzJKIRTVsLPaeemaGjnaaEIhhYpdlGsV5qyM1KzhjW5opjGTWn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PgPiHSvB; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgPiHSvB"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-389ebb0e885so33548271fa.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 09:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772212097; cv=none;
        d=google.com; s=arc-20240605;
        b=geiq2LixFKAEGl1Oz1R+nbFIaq9GjLsGMWUsqOgcSFttl77Va9/EPdwlydk7YeTQux
         MasT+Udjvu20JI7LtxqukGtvuD53kjrSfleEfAk+/EJc2RTHyUSe/pAnp6Pv4YDHarKJ
         n+cd0x2mEFb7tYsdxGL5QPNLfr2NF1Zmf2OVtWxLe5YVigiLxQ62+7S1WIittUbFRFJv
         swTA5Ec03iJtaP2ip+7qYLCqwdfn35eoTxU9GCDmA/LdiznNosBjFznGg7LadYDLahYz
         NjiOL3g/FtVxBYyixA7rT93WWYXcmMmUs3IjkaReRNUxOYTspkynZOY2RPtx7vxPPgFB
         wjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y7MEfERrDZZYp0c3EO05mpNNZJ5XP1zAqLXvGoyft2Y=;
        fh=vDjhafQfLVAQYlYEqhwVZeHRcDuVuPS574/r49D+5cw=;
        b=ibd0NOvwPshoQi2BdR3SjPUr5xafglvPjgZwsYO94aHvy53OV48vy+q+QKxx/0BLU7
         xI3fxriJ8bJXz1OEK2OksqTxqfxyFzMvS1MKcc8ubbyGvGLJDmA4lJc33k4qtKaWXf0G
         rynfCucU79TDjBrGsdHzkAb2hAKx6Jl9I+2C+bgJypPR1qyOAe4lQYl4v5uEYKcB3+Fx
         gTuTtkQGkOq7d2RQ1yc1qyaT4AInRyUI9TNu+m252j0HanVJXJO85EbsMlFmWwQYdpky
         QsVPGbEP5ScWTYMs9u/ErVLnUUlOI2dI9lu99Yj4dAI8cCrJt2aZAXuBvLfPvl97eC7Y
         9Qqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772212097; x=1772816897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7MEfERrDZZYp0c3EO05mpNNZJ5XP1zAqLXvGoyft2Y=;
        b=PgPiHSvBUI+6gG4LIWdV1P8tP+hFkKXk+TFFDvSHQY50WokDZVU56YMWiqXkadzDvF
         dmtlcfNCGrEBiqCje044yvDu+SRSRfiletzn5UHk6aDk5+045qCqDx9KZIhw/o27OQyt
         UCKQGipmAhUvcb93PWkufu6jfbdDWWfD7jV0cQTUEWeMstaBqGManjqzjqQYtybdqa4L
         pEO1bYIczqigj3PY5FSg2rMiDk5C7w1QRrnXsEnaAKPLDJTj6pp3XYC4Ydv2DCasxQxQ
         uDX642xnkksbRVZwr1quu0e2bw6oAYru6aoEG0ikwUHlNxPLSG690KLg3C8rSaGWmiey
         vDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772212097; x=1772816897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7MEfERrDZZYp0c3EO05mpNNZJ5XP1zAqLXvGoyft2Y=;
        b=ACszZagnNfoSc8teXhxvgW8mf6UlE0ERs311EMGB2RVo+MRdvr0FBA23c9tfjvIo4Y
         PfQlrarEmJeTIbdhcQzSCXAEgDFrVlpusY2mkciTpcRScVw3kIMzdQRiuvDyjgxnRbUg
         8/E/rajN3uFP/bslP53vv3L9Ag66ciI20XuUx06GkvnqeCJ7S90xzn8DsBhcOiMX1ZHc
         QwgO6hZiAmTbfjsqnI/Dq4H4VAxAPNA9wnAzP8nW/S0CQHk4Qw8Wwy5L2Zxot4Amgjec
         L5D+2NSp0xoNFod56lfdIfp7xIB68p22yWBdcPEJyahMzVYyIkpbteGdxi9CA8aoGlkK
         ZhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqsFGWfXk1zC6X8AvCTV/kQykaxet5SULjdQeelTYohycOzXMk+2XsdeVG01pWVGjiabbg6fWEj1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0X2PoXXvVEDvPJRd1fPv2UWfakHcKC53Xwb45RCsaV1QPjDqo
	juN8ZzQs6IB5wHMtfmlTxCpnflPKUwpHbdK/wZzbZyZygfMW5eSTS9Lr3T65jTyDq7ITIBRSlN9
	iozdR652sJYqtWjNjm2+IHg2wXtkN5fdRc6hoD/Kj
X-Gm-Gg: ATEYQzzrAKOR2wbi+g4R3ApQA3E55VwE/Op5avbM01qAOHrgxi8KudEJ13LGm1fD2qf
	mTvS48Q9CTEgfR/TQI2ZM44LNDTsU+D8qsP9f8QvS9wtQ5YLe842AE0ug4CoVCFesoPhpbYTuR/
	sSdBHMpgP1VnTBLW9tom2gS6Jc8ateDOGicSVhRhBWbiTrRsVjsopD8+eBLvuH8B5c4givG0/+P
	yfW2qe0sBFlODTsP+RGeSE/norkzB16QHE8c+KMi0leBJ4hHFWDKHUt95m2qHvVGNVLidGMFsgB
	XMHk1dwwKc5CPPY39Q==
X-Received: by 2002:a05:651c:50f:b0:385:f7ce:f321 with SMTP id
 38308e7fff4ca-389ff15f271mr19911451fa.26.1772212096622; Fri, 27 Feb 2026
 09:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org> <aaDqhjdLyf1qSTSh@google.com> <20260227084658.3767d801@shazbot.org>
In-Reply-To: <20260227084658.3767d801@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 27 Feb 2026 09:07:48 -0800
X-Gm-Features: AaiRm519T9RurPcNiWyO80VEVhcFvT0_H9lBfATMd1KVW4QtGFBpubzCvVI4oqQ
Message-ID: <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 7:47=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Fri, 27 Feb 2026 00:51:18 +0000
> David Matlack <dmatlack@google.com> wrote:
>
> > On 2026-02-26 05:00 PM, Alex Williamson wrote:
> > > On Thu, 29 Jan 2026 21:24:57 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> > > >
> > > > - vdev->reset_works =3D !ret;
> > > >   pci_save_state(pdev);
> > > >   vdev->pci_saved_state =3D pci_store_saved_state(pdev);
> > >
> > > Isn't this a problem too?  In the first kernel we store the initial,
> > > post reset state of the device, now we're storing some arbitrary stat=
e.
> > > This is the state we're restore when the device is closed.
> >
> > The previous kernel resets the device and restores it back to its
> > post reset state in vfio_pci_liveupdate_freeze() before handing off
> > control to the next kernel. So my intention here is that VFIO will
> > receive the device in that state, allowing it to call
> > pci_store_saved_state() here to capture the post reset state of the
> > device again.
> >
> > Eventually we want to drop the reset in vfio_pci_liveupdate_freeze() an=
d
> > preserve vdev->pci_saved_state across the Live Update. But I was hoping
> > to add that in a follow up series to avoid this one getting too long.
>
> I appreciate reviewing this in smaller chunks, but how does userspace
> know whether the kernel contains a stub implementation of liveupdate or
> behaves according to the end goal?

Would a new VFIO_DEVICE_INFO_CAP be a good way to communicate this
information to userspace?

> Also, didn't we violate our own contract in this patch by adding the
> reset_works field to the serialization data without updating the
> compatibility string?  Thanks,

Yes, I will fix that in v3.
