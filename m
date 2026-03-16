Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BD326D45
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681536; cv=pass; b=rHVZ9aQSBLtBRSuTX2MthAgcH3wImNcOfdmpbbcDHe54S3zpQtuPDjjwaWxJHgSShLzWVw0K20NB4tLJjA94a5M9bjdZqCPbl69wwWzTgyWPVFtsDTRMkGKtPVy+bZFQBuTDiB5tYxGfjfmYS5QHiKeIFJlblarKn2tHBUJ3Dnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681536; c=relaxed/simple;
	bh=0Jl1H4VRajEElLJx6lQQ4elVW/zvvj1c6yvcKK9sD7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVxOmh6SB3Y25haQ+dzKf4jcPIhDvNzl1/isQwgWL7SXLiTNC1jU+7Z/DS6kbPawu2DMmaUepSDPCVE0yC5TG+c6EpesiYctTarTYmR+6/gVs/SqN/juETlbmxkZ34TmDdkViERugdR1ryV3ac+TQ8QiNvOsvxuY9usiMzJ1mt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWnRpn8s; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWnRpn8s"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fff77ff6ddso851028137.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 10:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681533; cv=none;
        d=google.com; s=arc-20240605;
        b=eiRc6HZjWhnZu3RxkRmigTwKMdEx7v8fHPhjkaBMwJCTiCFO+QTGAeHZDFzTI+eZD1
         UlV0WTxt4miGLcghyccEcmLa/FzKkvPjxgFCF/l2J08X3RMS1qQkPQm9P7EBkLLyfPLj
         xqsOLnXF6vdt0Do+ooVh9WW0SpONG2+GdOI6sZL2SPcoaVxXJecwILCNOt5YJNFtFePe
         pliZnmj6oX9sY8QmLwp+4EI+NOUKrbOB9qtVOXp/G9BwQZMIkHb3NVhBuVONvy7oTYI1
         7tsv6XgqEI06kHRdEs+IMyoCJb9KGAQWAzWtMn1ledBCX2G5jHTFQhgwg1LTaBKsQ3Fw
         MeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=;
        fh=zg/opW5VSpj6LE1ddQ21HOahJKYCW79uDCNzjGqQw44=;
        b=i0n1HExzHAbP+8ety3zG4bOwhLBzOK8LbSszXPjLKQky0Z69vyLHXgaLIraL9SvebJ
         B1NZE4qMNm+xcWmPgy5sa+RH8NJvaXYHtH3h12nzIUYG7ieBZeuXi4dy6FpjJZiD/2GN
         jAhlCeZ3JoNb5h6hMom1IAgcBoZCPOKoBj8W3aXbpwmxbzI7nbWUpXxGFw7/z6DFNCnv
         3fHWqV4pb8A7QthnskMG2sYr2Q0YvFj5EncCtRkPIV6uo9nTJSfUeixwwkvmyVGiNec3
         CDlR8OKFWjhigtkkR2IV7jLz1UfM10PM9o6KJFL5jz2wlNsZ5usw0Q77K7GImmujDuZW
         LcyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773681533; x=1774286333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=;
        b=lWnRpn8sPsmYuL/qKxXUBQyFgK8y9+MKBBOs/ieA6uJUiCJHbftHMniA44yNHqt4pd
         hIjDcYAZ6kTMtfBp+Bd+rLOr7/8mW+bO8+G0HfwVAUusjRj9oxbmK6YtujguOdRNklE7
         KElyDzQSSjdnBsXp9s3dBen7lTDU2GXDcJMKxYsR/6seO4ffAKk+bzqJRpOEEA6YhQ8z
         N2C9XeRgAhv5VSxR9/D9ms4RTk5uFeWSG3JPDUyxo8VvOBVoE12B+z8flL3zSJQg6ULk
         qUBFoWeUZuP2S/WGzR+nDdoNvx7frMPW+s11dsletmXmfxVeVZEVcLJUXmkyUJJWdjGe
         01rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681533; x=1774286333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=;
        b=Zput6Xz/TpycNby5Rk08JZ6DubM37DcIl7t2MhIzRQPKMmqzCXjj29EjWkRedYANwE
         s+F1GAe9oredL0qalxsFeMffsyiEkPYsJA7LiwCOs9ooXfk579z82KZrcvShxlVKjTOh
         hHY2wS/NgqInP7apzCg+Ok4zeixSXord/nid1EnV4d/81/Qtm0lFwXgLK1eMUIMKto+T
         yatZGcmeE+U2KQXb9Cy5oreJZYnYZjwOVtbsspnzr0Z3zSudko2TVaUn5ylvfRj/wLgk
         LB7lrvA1FdwUlxovwRzdn877HIwq7WdJonLqZU38Y7LPnXYvFew2Dg4Lnjotzq45w9+v
         7VQw==
X-Forwarded-Encrypted: i=1; AJvYcCWPLgHeF4p/d2jcB8DXayP1DTXIn8trjkP5TQpmU9zqlHbOyI2eeEBkKD79e2ta7m0WtUyMqHupvVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTAosupLTaD/RFr9L+x3T7Tqe5cMycXXgY3H8xyogY50cnzL8V
	UVnVuNQOkq64te9CMDK/iqjWXFSSPqcBt9oGjXYfvvPz7SUT9aAZD9lKGsW3bx/6U65RbNTew6N
	ZJUqrqLPy7LbWlMW7P4PI/AdxwrMq5Lvib+Y42PTb
X-Gm-Gg: ATEYQzwmDty843EisF2nzdfovK+TxM9gINkeTPBZ6oYUIHBeTKgIucGVdus5cucVR4v
	xLPb0B4D6G2GDYZAE8jgxuL00a11nJlGmJdK2LxKLigiLrNIU6PemhtgHhNcc3VJBjBxX0Ovmsq
	nOM567sD82JT91GkprrfOciIlmpk/0pUTRBJaYHP3CNIT+FDHMDbzM31WyzqbpbjWhetEXInhiK
	/Y/9XfYP5fBfo8+XpEgiwYrz90UTO7eGyRPn3GBTG2PeP2ETT2PM2rQ1vwQDnhl7QcxnFVCjbao
	3rx5dIj0
X-Received: by 2002:a05:6102:d87:b0:601:f3b6:f2ce with SMTP id
 ada2fe7eead31-6020e27c32bmr5393489137.12.1773681532920; Mon, 16 Mar 2026
 10:18:52 -0700 (PDT)
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
 <abNOwcOTXqxCxNzt@google.com> <20260316160759.GA1767448.vipinsh@google.com>
In-Reply-To: <20260316160759.GA1767448.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 10:18:22 -0700
X-Gm-Features: AaiRm50L1lnLwO1eCIJNJtk4Bw53fGwzF8hjQ-eN_1dFmVAntzs-kWI2tT0ZbZU
Message-ID: <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
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

On Mon, Mar 16, 2026 at 9:22=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > On Fri, Feb 27, 2026 at 9:57=E2=80=AFAM Alex Williamson <alex@shazbot=
.org> wrote:
> >
> > > > Sorry if I don't have the whole model in my head yet, but is exposi=
ng
> > > > the restriction to the vfio user of the device sufficient to manage=
 the
> > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP push=
es
> > > > the knowledge to QEMU... what does QEMU do with that knowledge?  Wh=
o
> > > > imposes the policy decision to decide what support is sufficient?
> > >
> > > Hm.. good questions. I don't think we want userspace inspecting bits
> > > exposed by the kernel and trying to infer exactly what's being
> > > preserved and whether it's "good enough" to use. And such a UAPI woul=
d
> > > become tech debt once we finish development, I suspect.
> > >
> > > A better approach would be to hide this support from userspace until
> > > we decide it is ready for production use-cases.
> > >
> > > To enable development and testing, we can add an opt-in mechanism
> >
> > Here is what I am trending towards sending in v3 as the opt-in mechanis=
m:
> >
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index 1e82b44bda1a..770231554221 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> >  config VFIO_PCI_DMABUF
> >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> >
> > +config VFIO_PCI_LIVEUPDATE
> > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > +       depends on LIVEUPDATE && VFIO_PCI
> > +       help
> > +         Support for preserving devices bound to vfio-pci across a Liv=
e
> > +         Update. The eventual goal is that preserved devices can run
> > +         uninterrupted during a Live Update, including DMA to preserve=
d
> > +         memory buffers and P2P. However there are many steps still ne=
eded to
> > +         achieve this, including:
> > +
> > +          - Preservation of iommufd files
> > +          - Preservation of IOMMU driver state
> > +          - Preservation of PCI state (BAR resources, device state, ..=
.)
> > +          - Preservation of vfio-pci driver state
> > +
> > +         This option should only be enabled by developers working on
> > +         implementing this support. Once enough support has landed in =
the
> > +         kernel, this option will no longer be marked EXPERIMENTAL.
> > +
> > +         If you don't know what to do here, say N.
> > +
>
> To use VFIO liveupdate, user has to do at least two things:
> 1. Enable CONFIG_LIVEUPDATE
> 2. Pass VFIO FD to a live update session.
>
> This means someone using it has to know what live update is and
> intentionally pass the VFIO FDs. Isn't act of doing this itself an
> opt-in mechanism?

If it is, then I can leave this out. Alex?

My thinking was: Distros are free to enable LIVEUPDATE and use it. The
support it enables today is all fully functional (albeit new).
vfio-cdev, OTOH, is not. A separate Kconfig can help express that
difference.

Consider that LIVEUPDATE could be enabled by default in a future
release, but vfio-cdev support might not be ready yet at that point.

> I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
> about how userspace will know that sufficient VFIO support exists.

I was thinking we can flip VFIO_PCI_LIVEUPDATE to be enabled by
default (if LIVEUPDATE and VFIO_PCI are enabled), and drop
"(EXPERIMENTAL)" from the option title. That would be how distros and
downstream users of the kernel know that sufficient support exists to
enable VFIO_PCI_LIVEUPDATE.

> May be write in liveupdate documentation (PATCH 11 of this series) that
> support is experimental?

The documentation in patch 11 includes largely the same text that I
put under VFIO_PCI_LIVEU"PDATE. But I can explicitly mention
"experimental" as well if that's what you're asking.
