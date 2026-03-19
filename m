Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A5134C145
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941068; cv=pass; b=Jl2ak0+7jyGWZYfI3STStGt1BlifJYM37Ew8g8Qp5uA5m/w6SOxUfBzZqeWrIBeMouQ+zCB0Ts+sccQty7oxSEaZVBMD63zZ96fpeVUEILBsAVISrncS6aZJDGmX48f7J2stOVGpgkpEc2Ie0hlmDMch61Sj42pGH2wtBDhHHDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941068; c=relaxed/simple;
	bh=PnRXQ5r536tu9dvMTvBl5NRPrIFr2RFjQXbYpbnAzLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoCtr9t3PD/GNw3Lfskl4pv+aHYIDFuFfjN5GYlGb9YfT1KQIQ9X/yAEmmrmwjcgrnuWKOZzdn1RjqcSoOqkwtP1o5b25EG3QjhgOCExii2hu2modMK2iai2ACGCgttvvWnz5rc8GMf7/JQgrfgqnbTBGq5AzmriNqtBP4niL1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sB5di3FR; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sB5di3FR"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a1307438ddso1157053e87.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 10:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773941065; cv=none;
        d=google.com; s=arc-20240605;
        b=dgOWIsu4gVLqNSR9gu1lgxVlbi5IQLnBmf21b2sSV1+aABXZKTOSOIFupUTPIAEzru
         5/9QvcwgarWdsXRlxPZDsb+MQLcQlnfx8nJWvpt7N00lsQXRa+voHfdbqEsEUMb2O2XB
         evvzxZ46LiwYgM08WSzyHDe8hVCgNgXbasqt43r5mmr3v7Unx8hM+3AHEazBYpaznL/e
         /SpkeDBR6JT0+U46z8EJja0QmzKdjtADhDHJ3ghDy0J9z8dwAhvzBk8FDCtX9yutQ01n
         CREhs6gnU0MIjWFBketncDLiQeSr3+XqJbNJpI63IM7Q+Jc867HdcYgOiHXTAOD+ZuUU
         40Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWL7Mvz3ZFb3DsvrD6klOpnMDDqkJa/pdjIb2Ow02uU=;
        fh=DGmPmYWp8k1yeh1W3kyMpydItG4I3CkoMy95gEYFYMc=;
        b=ISMgl8HRopeshWAZDWv3sWS7V8JPgobi4kgtONgCE/D7dzmsALw6LZZ/1Fo8kiq6ws
         /q32SAEDmPJZJy5+302IwNDWx2/T9DJMB+J9Z15noMpUlWkwsNnRu12DtZpLanXv4/xn
         D1Xfem3D/valr3wnhicbmh+4qAAA+nwhI0bG/MNtVHW0tRP/xZnPTSOQnmGAYScB3BLL
         re3x91/QHk2AE9l0hz/bZqZAQGP9O5/uA5+0wpIhtTJaouSRT6dKqFPtNODZcXSr19ll
         7KO4kgd+WYUrgykl7Ald3zx/S9CKjcA1BsPn2SAgsIK/dMPi/uu34xTt9DExHnBCGITy
         1WIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773941065; x=1774545865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWL7Mvz3ZFb3DsvrD6klOpnMDDqkJa/pdjIb2Ow02uU=;
        b=sB5di3FRgJ9AXnlpTkOtdsmLaYjKyf8sZRsiZOwR5HpmHxIGL2jjU8LyMmZQnHAleu
         ODrpsSSqH5k4tpjlbe1BqR4g0C/xT16CzNerIj6obCQ+CsbtCFO2qqBtRS0Mv+q8lt1P
         d8PpNaiyi+hZcdIs9ovvDvAzKiuqUN4fZ5Grl5FnScr9r8uwFk1TkI6z+oS6rWvWWxMj
         uFIiRzqoc+tCdOawOx8cT2HfgpCa7ryPk8VhHaTK1CX8oWB5nrKOomORqAQskIZerm++
         jGKnE3uIgXTlIkpLLemWDbo/z685KXLGIkfyr0L87hpdUKENvZWhFpPXFsxm6eticyrl
         TSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941065; x=1774545865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWL7Mvz3ZFb3DsvrD6klOpnMDDqkJa/pdjIb2Ow02uU=;
        b=qLvZ/ZaRY0Teesv7j1u7soQKMC3d6KjCCBnnoNZjSir439foi6bUdM1vSioGfHbbBy
         hTDiUJ6FtlFXWB0vMfH41YzUOQnqV8H7tmOWtGWlWkD/Rng5C9STb/i+lcJQQcbicOy/
         uErAH3U+RKctvJ+2mT9Mr0W9DBM2EKlOrTot1qZcA27PC2xTQa9AHD8vh7o7FKwZhrm6
         fCOvfMKFQHaYszubazpbnNt4CmppFZi8iPJqINITmh0S3B3G5Tpic/a+sd5I1N/ACCnA
         ZLO1vmtARU118SBwRcYhZPBvWciri6xUEGpt/W2t98w/8YYXuWVY1IISWR2dvG/sMAhu
         zzhA==
X-Forwarded-Encrypted: i=1; AJvYcCUuO/4rX5iHTPF9+SM8jdzi9nlYKBd6BXaRF9fYqZqFNkl7PJHoIwVs2kbqilprtkkF2gX6zCjsd4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWAC87wSIu0OtjX9pAcpnkzEv7yZdOZ9aINzW0CQv4J11y+K2
	xiRkcd1+oSOfUScjtk+2RJNoEqVyEQ89TobiF488PsknndKP/DhcCMGI5m26IyPH9kQpLQ7h8zR
	K6Lqx7P3T0RPmZMjnG/eWqdiofdoZwo9noE+PYKyL
X-Gm-Gg: ATEYQzyrSy4+JRaayfMS4oiNJ2gQeqAZJ6iepGiOj7DYqaaaOPvSw4pQGN/ZdoHfLMx
	1Pu6KMdDVl+AhANuDHgXqj+Ye3bozCd+mi56iulvBpP6A75krfTUhY+Ao8YPpgltyZi4s49Eetp
	l5YBqtKCPvXcAmN4Yvij4qzgIR7kHsbqwaciIH1RS+30uUKKGlbb2zdiuYMb7cylabnRKi7PDCf
	A/G8lLsI9YUQrcJgkoE7omQulaWKzefGXuUcZlU/MN9N0E/nSPcMcmh/UTsWkjsPqxPstmBeYI1
	W4fYgSQG
X-Received: by 2002:a05:6512:4016:b0:5a2:7e5b:5a48 with SMTP id
 2adb3069b0e04-5a27e5b5b70mr1566015e87.26.1773941064245; Thu, 19 Mar 2026
 10:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org> <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org> <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org> <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com> <20260313083918.00005731@linux.microsoft.com>
 <CALzav=eGLpo5nrsHq5L8bUTC=FWZ-SgrTE1FoScrWB4p+NDgnA@mail.gmail.com> <20260319093932.000078c2@linux.microsoft.com>
In-Reply-To: <20260319093932.000078c2@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 19 Mar 2026 10:23:56 -0700
X-Gm-Features: AaiRm53rqLDO8igOEPnPEHv7Le9OPlkg99gzLBiOllDBuZj0inzOHo1IukO9vNo
Message-ID: <CALzav=fvG+s6MYNzxhuHFmQkmTRJJASXAGs=zQWWSnSv3Y=J9A@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
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

On Thu, Mar 19, 2026 at 9:39=E2=80=AFAM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:
>
> Hi David,
>
> On Mon, 16 Mar 2026 11:11:20 -0700
> David Matlack <dmatlack@google.com> wrote:
>
> > On Fri, Mar 13, 2026 at 8:39=E2=80=AFAM Jacob Pan
> > <jacob.pan@linux.microsoft.com> wrote:
> > > On Thu, 12 Mar 2026 23:39:45 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> >
> > > > +config VFIO_PCI_LIVEUPDATE
> > > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > > +       depends on LIVEUPDATE && VFIO_PCI
> > > > +       help
> > > > +         Support for preserving devices bound to vfio-pci across
> > > > a Live
> > > > +         Update. The eventual goal is that preserved devices can
> > > > run
> > > > +         uninterrupted during a Live Update, including DMA to
> > > > preserved
> > > > +         memory buffers and P2P. However there are many steps
> > > > still needed to
> > > > +         achieve this, including:
> > > > +
> > > > +          - Preservation of iommufd files
> > > > +          - Preservation of IOMMU driver state
> > > In the interim, what do you think about moving forward with noiommu
> > > mode without preserving IOMMU driver state?
> >
> > I haven't gotten a chance to look at your noiommu patches yet, but I
> > do think noiommu will probably be a good way to develop the VFIO and
> > PCI support for Live Update without blocking on IOMMU driver support.
> >
> > > I=E2=80=99ve tested your
> > > vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works
> > > as expected.
> >
> > Would you be able to send patches to add noiommu support to VFIO
> > selftests? That would be very helpful toward allowing us to develop
> > and test Live Update support with noiommu.
>
> It is included in the noiommu patchset; the only difference is that the
> VFIO cdev name is prefixed with noiommu, which is not strictly required
> and is done out of caution.
>
> /dev/vfio/
> |-- devices
> |   `-- noiommu-vfio0
>
> https://lore.kernel.org/linux-iommu/20260312155637.376854-10-jacob.pan@li=
nux.microsoft.com/

This one flew under my radar. I will take a look and respond there, thanks!
