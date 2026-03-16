Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1FD3CF68D
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680978; cv=pass; b=eKWXqxUgfgYujUYQTH1a/sYAb50Rxvsuhh4in/wcUK6bMxwKNRifwm8svnXe/pUSaW1fpyCQ1daqIbaOsmTCFgY2b4CaPIM3KpcPmyxSMpGArd83t0AgaI6HqqBMds1go3bSMF/ovhesrfEtvMIK/tuvua5kPw5doZ4Rza9pdjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680978; c=relaxed/simple;
	bh=NNTfBBJ92pV51Q9pBimiCqTRiAqNEv5Iq9TZRM69uyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnV7wvOiYqz+hkkt7LR7mpeigTT3V68XKuFL/WcN1ANLXcBkX3XANMT7dSX0laI15dqIRGSzoQJ97woA7xbnK89qEDEEMRl2EYc4UMa0gRqZCukBiJBvq9DCP6KCxBw+R8wuj4wUuDBA+e/DjvTn3XLQ41rkGakA67XBZRCPNUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4J/xobT; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4J/xobT"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a13f6bcbf4so6849728e87.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 10:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773680976; cv=none;
        d=google.com; s=arc-20240605;
        b=DnNXVPjKE5V667ND8UFf057n327YDtSoJ/zFcbhaPQ+HH8kH+RoyPfSj0xPJaNQzww
         W5PPgYHlfDWh11mI7fqLowlQwOdEt3mm9fIyw/eB8M6UuD5XFEKABcfLBpmGR5G7Ofu1
         71EX8HcaXXVFmn5CqMLUoAdsM8OG5d16qg737ZZcJ0a9/oo1tZymxVpdSzrFUcb5CDzf
         WHCGBbqu5A5psm2M9R8Y5QJF42IrkQRJzmMGCg8fMVpnZ/nMLxFmgUn5ddU7jyci/XJW
         v99foFykygpZDm/EHisqt0EN3O+6AsOdyRV1Cw7j/LLJFXece3NuMK3JpBpRbHlk+dz4
         nK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=;
        fh=kiiBO04bsyzmBYPramPHPpae+mreNjMDqcp9ZgNe3Po=;
        b=aeetUV5Gs6zTh3Tm9Fq2iy3YE5v0tm8FzTm5SZThTC7BiQBXHfSZ2ahOa8+jpH6C5E
         960YfnAaSR8xmRBV2M8NvmJpC6K3NIuZC0Ml8AbwKkaMU5Q45owHj9kotBahekZypuEF
         ZzVBoua5uZSRTncHE5AI3v+HAsjrkZ9y/kkQldl6zSHDO2XnSfsmjivJzk8fVyQ0DOL4
         GHHfFNrt5xWXL7sZuBj7mmWpMdkWja5+4xBhjrkeeaIyQQLJqTeGd38GQuydr1Y+GXsl
         wJidzdLngIg70ys7vtvu+kptJ6fA1BoWNCyoZY1heGJzyy0gQGxgoFRmvjKtd9tKF7f0
         jXMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773680976; x=1774285776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=;
        b=o4J/xobTqd61lsctsq1Mp5DIFrv6bPcSemwW0YkargjsE1WDYYBUULHlKBMCDgKPtj
         5fhMwNYHxYqciVnh8PL2wMKPEoV96+hIy8NDYDzoZl+GhXvBaH/QuNo/rcXK2s/Ayfbv
         PKomlm9ztOHqo123bsT3x7R2n3tg29nr6V7XHLhbLlHHTpmNcCqu8sdyA+7OFaPD0BUf
         cFbnfgnrEHYKTjk575MTqX76oiNSSki8NSgASzqPoYMRwxGt0I7bZayK2J5a8eiU411c
         VBPbrjTqsBo1uDOIE2Uyl/MB2SLTYmlNXZiCXfEbLpMh9ZB6OaWxgNkwvT9frHFEwRkb
         67PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680976; x=1774285776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=;
        b=Cfab38n7qhUrJthSCjecNiHiFuoshP/hhmuPGGVX4+tokIppx550+wsO2dEvGGaB2G
         oky3uWpaPJGXqWXEAJ8whxAVIQwHqkbxEOIsQ8UhOSJnK46jkAfr49EDFNif0gv/CfnC
         clm9EAbK1a9EOEusyPUJx412OGphp2Pw1IiIKFcCmDQs43dZme9kQk7Ill7Vj4c/GJMk
         gB+r4oK7ugHABYicBY9VjubUAZNBUIDz1k82GuSH5X9YKgAjzwWNo+KmMhnRxU1sGW4y
         1vdzZE5mZMhpudBrceWN+qzdFk/jcZAIaDjgfoi+IO39y4TvoRReNpeMesMN5HCNUDDr
         M8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTnR5GIwOKdbxZlTP+LHW42qwR4EF9LmB5hSrbxal/wvp2mLicH5N1GuJecwPMq0ZnDH3nf83qFeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyilVtrAcGauxnIYuYvKW0AuLwj7eU/IS2Lyj3GjR3CjB8BNhs7
	MMhZJXXFjonojbm5iqSIGZrayi+JJ0ioPHVlvYXTGeLu1QJEAQAh4jpaITG+Q40ySKFnDqJm82G
	VoAjq3R75IJmDenIyWymYvaJpeTxquL2g0AiGQgCZ
X-Gm-Gg: ATEYQzye4BFcs4qpJYHj5G3acjGwpuQpOTjZxpXlzJRnJxFFAzBxzJERJ6RcY+fZhci
	SLRD1nWeXnfgZMC3gGEw8U1SwflRM5NF1V4fZ6dkLKvTHG+tSI127ItammUAbKgGTaARzdUo0pt
	3vloroSm5h8ZoAQgDmY7gdZT2xQ/2a/nSslAy+Oj0QZLgZscslyI7DhMGJjAj1p1YCH5EE7Bfh/
	xLZSstQvZ8I0tKjDyZj5bvkiKIJc1dNze68IZ+xK/lNGcSPiUe9YNp9y8g7TqwF+rB4Mb97VvX7
	UMhxiuEY
X-Received: by 2002:a05:6512:64e2:b0:59f:6a2e:49e4 with SMTP id
 2adb3069b0e04-5a1626fb8abmr3594350e87.7.1773680975067; Mon, 16 Mar 2026
 10:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <20260314061747.GD4177610.vipinsh@google.com>
In-Reply-To: <20260314061747.GD4177610.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 10:09:07 -0700
X-Gm-Features: AaiRm52NY6sLPHJr9Fl_13O_4mOB8Cua734qhyhURDdG8FlJ-PNRJ5f7ttW8G5g
Message-ID: <CALzav=cQQny8AXzewtSe2pM-Z20+K9UbTcNBiy6SC4PUzR3sng@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
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
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:03=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:
> > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/=
vfio_pci_liveupdate.c
> > @@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_li=
veupdate_fh =3D {
> >
> >  int __init vfio_pci_liveupdate_init(void)
> >  {
> > +     int ret;
> > +
> >       if (!liveupdate_enabled())
> >               return 0;
> >
> > -     return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > +     ret =3D liveupdate_register_file_handler(&vfio_pci_liveupdate_fh)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);
>
> May be we should rename pci_liveupdate_register_fh() to something like
> pci_register_to_liveupdate_flb(). In the current way, it is confusing to
> why same handler is getting registered at two places.
>
> Above name will also make it similar to IOMMU series as well
>   https://lore.kernel.org/kvm/20260203220948.2176157-2-skhawaja@google.co=
m/

Will do.
