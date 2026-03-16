Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529F9366058
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699289; cv=pass; b=OPyVqq2j98gWx5YMsEL1e3bSiz6hKFDk8Xrj46HPGKsYz8YhCYka4MXK0fdgaRVWEgWYlFfA9vel3hQtuYRdPiqFNxEIMm36fbaxWgFXVQsHyyZP836kgEV0t65L/2T+1fgNW5i6KEiMR+DiVy2SZYqQbtoaXIU44umWR0tiCBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699289; c=relaxed/simple;
	bh=rtrnZeqQl+lqOePojv3lREDvLjSPymz2Gx9AF8DWaII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCO+qJGwvcuJD3TRow8j+8CifE1ev4gu6uzydwDmCxGKfVzsC6Ubox8t+bxrXvwZSZRTa7lp9XOf4r4/cxjFW/bSFAWZUTTptC+StCodfMIpiepOGWCwZ9F3rlb4IX7YWVByNDXoNkIiy6eSgpx30SB7GwdDgFbPFwqaJf7yxmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U6vM/0qK; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6vM/0qK"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a1307438ddso5059501e87.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 15:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773699286; cv=none;
        d=google.com; s=arc-20240605;
        b=fjssBsNX/PH9NR327TCZ+3rqRJof0+CDsXBz/p0K2+5xqTOTocFNKgqBu4kctlz4PD
         WTzw0PzhM+tmVHYytdZJ5fJOMEFcBS27/4yRM2UmK5dzvMNi+5gmukeFuhRhG0VBTZXd
         nj40fW/WtaFqi3DyVO57iOndsTn7z2Uar0Qt1JsA06B6X4czzhUy5hUkyXJ7Dc/CWqQg
         UuK0e94sIVhaSDtmQeL7MLCttxKY7Y8RJ3Hu4my5i49/fVVMveERq/gazx08MPk1IJoM
         y2udhdQiyJMdeRXi8a53dPrRcjtBBEYkQotYUpSYspNMapKAksmKg/7+GukQx9djf6QZ
         S9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=;
        fh=0DuKKXiv2zEWdUQdxagwIm+g7zaBM7T/q2Cf6clrlaw=;
        b=InHagLt7Dg/qW1K7Brn2NDUlI0U6q/qTej2t82UAqJUZ/jXDiMIlXwdWPgl+bEiLhd
         dyTEjs2gP/5o3afXt/JDQzdrAekYPK7eM4JgJ8cU04o/tX0rlHdXQotMRtx+wQY+sCNY
         e4BntardPUKo/wKeZRWbhEfWtz9o96hrIXx6Txj0qUka2koenVGyi93xophdTALlBA0h
         wK1dXocWgTERBmyiNylyXkDSR81OexbOqaS2z554o2OZDI++hKHvKzv9C+YetHDD2Wv2
         XkzPGVljvjHOiuF7Q2my9nbgBoF+RkXJ8k6GzO3Fg5PsLAK0wyveRcTZ4KTwX/t4j2G4
         Zh/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773699286; x=1774304086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=;
        b=U6vM/0qKwdLMazJD71gF5yaKjwQIkuMWh1QQpolDCNZC7ayRaMmduy27R2WeTuoqyk
         vrVHtw0ai+f1WOpikl1Kc3yeDwhdyz/F8cNg8qNWzOWteW0s5oB2qwvoEZI0PFrCdRhw
         sqfW9gEKVkRnaMmZjoN1mI6W4wlIjc32Otc1tx6EptGS8JuZyYbaWh7b3FANnFdChE5D
         5bCtmBYqijH8KN6/3OeH1AOk+8oChJVn0/wIjc8nfA7FoWhn93d2BXWQnHn297eCbB5Q
         wtYypF4HOxvj0hxQNbzEz+2S5Z7gvi1OoTbgjoJ0yDCWJXDPC0jvs568BPMh9gTbTl1M
         cxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699286; x=1774304086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=;
        b=Ybcg1SioUqdUxBai6q8tnnbgYso6binoqVKXmLmRe17VSKLO/svhP/HQESFSv+l1OK
         gpjwAYwbOsG/Uh2yoatMI7GEjJRd08STwykayDH5pfhhDBfFsBlyGTNQYpV2gdmH6iqg
         HhPUMX7XolDEStFba8a0WPR4nZsvmvwB2rt8nfbLANPkztI7Wtnjs8BUgqkPzIpmzvAt
         BCqjFMtXO2/EPz8zuRVzTdb3zbHw0X6QE/YesRJzna/GrqQ4PNgwCJlyVo9Eo2LTI3/R
         3tGMjMw4wXNqQnCmvKhNTQ8HAfXjrakbVxrOp5mKKnXqnfS3+aMD6veldb+/Nt1f6jlH
         sNVw==
X-Forwarded-Encrypted: i=1; AJvYcCXQPFB6c2kpl97uS3KJFtT3mQCPgkt8rq4L+puI0bRDvAWhzDXyMG2f2waCKTxDWHICHhexKvdJI2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrfnz2G46C8ReKMTomcjUcNf5BnOZI9xuXDb6WjzKGET/Sg/T
	3vCDLg8zrp4+MBm9moJSBBIhxnsiKYaNfpaPk76z8L+k8I+++mJPf9Q4nchsZqEPrznK6H0woId
	cf4Ezq7jk3jV695zVSNI0DwUnKPXZNU50VRGlKtuH
X-Gm-Gg: ATEYQzw1pq0vm141gyVV/lDCORvMNnOf3xadmmsChcdzAWC5OsA9G02Q6smuIS0Wx2R
	DcS+mzcKvP5eY98MrqbVYyITqjgbioI5N7mFQUZ8Wh1S/XHyrAUZVYgvxWuR4OBvlljlNtfA5Pz
	Eu0KrMGrteKdiPEbdZWU84X201yeIX2AQXdwrP9xAuKvGwHO08xteyHOXtBmqJ0ov/5ez/cKDVj
	LTVaibbFYtiYkB4nXpB8p5vrYMYOFecOTUuIwfC+iHFvsh50iIkyFHRYxc7LEWwQMiKKvVIlrK5
	My/JbNVHMM7VHiiHFt4=
X-Received: by 2002:a05:6512:208e:b0:5a1:34d2:b6da with SMTP id
 2adb3069b0e04-5a162b0a440mr3032307e87.31.1773699285744; Mon, 16 Mar 2026
 15:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-11-dmatlack@google.com> <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com> <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org> <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com> <20260316160759.GA1767448.vipinsh@google.com>
 <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com> <20260316214055.GB1846904.vipinsh@google.com>
In-Reply-To: <20260316214055.GB1846904.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 15:14:18 -0700
X-Gm-Features: AaiRm50S3PNCrqX_TvZ1JiMZN8vQiYVbYC7Ez3YpAEpqzQo0lUEJ7c1xPn8zOqk
Message-ID: <CALzav=df8K0R0gJyQ=ifoznp_CMRRtyrWchbNvcw2-wpkdaBaQ@mail.gmail.com>
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

On Mon, Mar 16, 2026 at 2:49=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Mon, Mar 16, 2026 at 10:18:22AM -0700, David Matlack wrote:
> > On Mon, Mar 16, 2026 at 9:22=E2=80=AFAM Vipin Sharma <vipinsh@google.co=
m> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > > > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > > > On Fri, Feb 27, 2026 at 9:57=E2=80=AFAM Alex Williamson <alex@sha=
zbot.org> wrote:
> > > >
> > > > > > Sorry if I don't have the whole model in my head yet, but is ex=
posing
> > > > > > the restriction to the vfio user of the device sufficient to ma=
nage the
> > > > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP =
pushes
> > > > > > the knowledge to QEMU... what does QEMU do with that knowledge?=
  Who
> > > > > > imposes the policy decision to decide what support is sufficien=
t?
> > > > >
> > > > > Hm.. good questions. I don't think we want userspace inspecting b=
its
> > > > > exposed by the kernel and trying to infer exactly what's being
> > > > > preserved and whether it's "good enough" to use. And such a UAPI =
would
> > > > > become tech debt once we finish development, I suspect.
> > > > >
> > > > > A better approach would be to hide this support from userspace un=
til
> > > > > we decide it is ready for production use-cases.
> > > > >
> > > > > To enable development and testing, we can add an opt-in mechanism
> > > >
> > > > Here is what I am trending towards sending in v3 as the opt-in mech=
anism:
> > > >
> > > > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > > > index 1e82b44bda1a..770231554221 100644
> > > > --- a/drivers/vfio/pci/Kconfig
> > > > +++ b/drivers/vfio/pci/Kconfig
> > > > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> > > >  config VFIO_PCI_DMABUF
> > > >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUF=
FER
> > > >
> > > > +config VFIO_PCI_LIVEUPDATE
> > > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > > +       depends on LIVEUPDATE && VFIO_PCI
> > > > +       help
> > > > +         Support for preserving devices bound to vfio-pci across a=
 Live
> > > > +         Update. The eventual goal is that preserved devices can r=
un
> > > > +         uninterrupted during a Live Update, including DMA to pres=
erved
> > > > +         memory buffers and P2P. However there are many steps stil=
l needed to
> > > > +         achieve this, including:
> > > > +
> > > > +          - Preservation of iommufd files
> > > > +          - Preservation of IOMMU driver state
> > > > +          - Preservation of PCI state (BAR resources, device state=
, ...)
> > > > +          - Preservation of vfio-pci driver state
> > > > +
> > > > +         This option should only be enabled by developers working =
on
> > > > +         implementing this support. Once enough support has landed=
 in the
> > > > +         kernel, this option will no longer be marked EXPERIMENTAL=
.
> > > > +
> > > > +         If you don't know what to do here, say N.
> > > > +
> > >
> > > To use VFIO liveupdate, user has to do at least two things:
> > > 1. Enable CONFIG_LIVEUPDATE
> > > 2. Pass VFIO FD to a live update session.
> > >
> > > This means someone using it has to know what live update is and
> > > intentionally pass the VFIO FDs. Isn't act of doing this itself an
> > > opt-in mechanism?
> >
> > If it is, then I can leave this out. Alex?
> >
> > My thinking was: Distros are free to enable LIVEUPDATE and use it. The
> > support it enables today is all fully functional (albeit new).
> > vfio-cdev, OTOH, is not. A separate Kconfig can help express that
> > difference.
> >
> > Consider that LIVEUPDATE could be enabled by default in a future
> > release, but vfio-cdev support might not be ready yet at that point.
>
> But that also requires point 2 above i.e. userspace explicitly passing
> VFIO FD to liveupdate. Unless there is a capability mechanism like KVM
> then userspace cannot know what is exactly supported.

Yes that is why I propose not exposing the support to userspace at all
until it is ready, by compiling it out of kernel via new Kconfig. This
way it does not get accidentally enabled in distros or downstream
kernels before it is ready.

> Also, users who
> are using these APIs will already be advanced users and have to know
> many details about what liveupdate supports or not.

VMMs will be the ones preserving VFIO cdev files. I think you are
suggesting they should know what versions of Linux support what kind
of preservation? Like QEMU would know that Linux 7.1-7.4 supports
partial VFIO preservation and 7.5+ supports fully? That does not sound
like a good situation to be in.

I think it's much better to hide the support behind Kconfig until its
ready. That way the PRESERVE_FD ioctl just fails on kernels that do
not fully support (because VFIO_PCI_LIVEUPDATE is not enabled), and
succeeds on kernels that do fully support.

If someone wants to enable and use VFIO_PCI_LIVEUPDATE while it is
still marked experimental, they're on their own.

> > > I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
> > > about how userspace will know that sufficient VFIO support exists.
> >
> > I was thinking we can flip VFIO_PCI_LIVEUPDATE to be enabled by
> > default (if LIVEUPDATE and VFIO_PCI are enabled), and drop
> > "(EXPERIMENTAL)" from the option title. That would be how distros and
> > downstream users of the kernel know that sufficient support exists to
> > enable VFIO_PCI_LIVEUPDATE.
> >
> > > May be write in liveupdate documentation (PATCH 11 of this series) th=
at
> > > support is experimental?
> >
> > The documentation in patch 11 includes largely the same text that I
> > put under VFIO_PCI_LIVEU"PDATE. But I can explicitly mention
> > "experimental" as well if that's what you're asking.
>
> Yeah, even though documentation do get stale but I think there is no
> better way in this scenario.

Ok will do.
