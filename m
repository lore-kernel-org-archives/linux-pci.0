Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE836404D
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790585; cv=none; b=DUIvRO1xG1i6qeyEoq1xFOeJwHsFNnVjrs213K8q6akqOAjyw1lTtaA/upUVO04Qmk5b9dgg+YYiapCNhBbAIQSLfsjCc4U6OucTyTqTx26ZnPNGvBL7Wq8VL2YR43R7nHtH7ie6a4PUxtpnHfGahkeCVt+eMjMFIlIUJ8aZbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790585; c=relaxed/simple;
	bh=MkP4whV4n0WRvTN87uMxy06HdXRu3qnfT38+QSsgLP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0/hH7lqUNK906dcc3n5bI33wmu2jqPDNM8P4SjOVtfHTbMZVamJPoIgPTkSKZwcaks7Ir0RuNmNRAJRPsC6wC5SaegLPfSfFPfOyfCjeXHfiDI0ocQ/mbNNz0wBOtK3rQtwc+CFUb/wnKzF6k63ioaXqdVlW2b2lH/f/hlW2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvc7e/Wu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvc7e/Wu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b052562254so43865ad.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 16:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773790583; x=1774395383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8R08fAS2L/TqkBdbNFXhbiB2wc1JFGzUh5S9wXtuww4=;
        b=lvc7e/WuKaGBC03E3qC2dsAWlhQQpNr8aWFiEsG7aHARC+Xw/DRettyaan/HA3Iwot
         ZykKbbjta3+VyoGA0/5ls9gopbEAL3fSVUfl0FPU+PBoesA/W8bSjfA/Ryw6+J9E5tTG
         zcAkMgTEBzIyK61T9xKUkvIDJCsww0ilfUpjqLhR4q2y+LB2CWQcZXeZX3k6v4w4WZKc
         y/P/FPpIKqmRmcsOFM+qSHOU29vGGxurwrFrIHtGlzgjtkdx0cEUGz+WQ/GEkFg/7/X8
         Jxak6dT8SQU1IqyKNIaJFdswN2cC6/WsN6B5kuQbl6PYuw+AtBOxCr3uWtpydlFgJJ4e
         jhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790583; x=1774395383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8R08fAS2L/TqkBdbNFXhbiB2wc1JFGzUh5S9wXtuww4=;
        b=sumG13ZQF5tKl7dUz5KI8n0M/pc2hOlunfoGN32Rhbyqj4wZSlXiIxlfZPm9DYrZWB
         s1QyHQL51F2jvFwONIYQ9EXpPW1/dVfMV43YuAhAgpKjmsu5dU5JsDj8DxcQRhnpaj8f
         h+n40lQhqxVllKALKDl1b6IH81oNwu2jV5pNJRQVVtfaM71Gi6peyCwIVdZgLasUFYEf
         38E30/hmW9lz1ZFLfRzA6UUPX2w/iayx7DbCnDcyazAHfSDB6eiooihBYeLCmtkHJB+3
         9jAdbq8JrS7INp1ZxGOcg0pMGpl3v0M+W4dkNPotlp7ltVnFC9s3EX4QU2FVyys4p4Jj
         YDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr+SA+7s8MmDnJmSvWodYcxKfVVTMCzTBlXCx0wt84HjWUIpr0YVRry5XVK3GinIWwNbX3w3GLIKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrVwk/QaNHnZso5EibegyTMvwlhq4CC3shDuOAAPZURTZdnEFH
	8HPsOXD4VmP9NLK9GrHpoaHat4caeTKkvR/QFsM91ikz108iVTwrTywH6m0PqET0Uw==
X-Gm-Gg: ATEYQzz/gW6gYn4ZP3C9aEkneqChHMx27uP490Ap92ZSG4igsbS3OQwnrbot7acqZIz
	zAZYVWF8OGx1fW7T20UW1OY/ObFiYbK0bQqmX9Kpf4mVv5iN8j62z8wXissaJTPVez4jssns+BU
	Xw+qAC0RibYksocpfJynLjBGd8RbgkpSZbAdSbNv8b24n7g4b3jpvgIel5jGZyubhGw0GaKN8BL
	DBohbz5HIgINMrbYVF0a43FDoePznFvUXrqxEe/YiQaNC5zKc+vniLUEhzUTh/DHWwTJE8RFUGX
	BImP6y/GI9LevYvuZWrX1Fd9OO9BCNRKTuY254ypozZkdnUENmBFgO2HLiM9BkvamM6Yk6WZLa5
	eIVxpTz8eTm0T1zBgSBeSUtxvL2EfA0V5gfEq8SZAji22QJeajt25baACYR63/cuVJ4rqk/92U1
	3Q4+bR3sZCo+gtuWXNlq9lHeMoxXkNJi9ILZiluboVg50kQNGGjzvDK2jA7Q==
X-Received: by 2002:a17:903:22c7:b0:2ae:c566:bd99 with SMTP id d9443c01a7336-2b06e88a5f7mr1634235ad.22.1773790582361;
        Tue, 17 Mar 2026 16:36:22 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e629da3sm6015715ad.76.2026.03.17.16.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:36:21 -0700 (PDT)
Date: Tue, 17 Mar 2026 16:36:17 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260317232431.GA2795773.vipinsh@google.com>
References: <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com>
 <20260316160759.GA1767448.vipinsh@google.com>
 <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com>
 <20260316214055.GB1846904.vipinsh@google.com>
 <CALzav=df8K0R0gJyQ=ifoznp_CMRRtyrWchbNvcw2-wpkdaBaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=df8K0R0gJyQ=ifoznp_CMRRtyrWchbNvcw2-wpkdaBaQ@mail.gmail.com>

On Mon, Mar 16, 2026 at 03:14:18PM -0700, David Matlack wrote:
> On Mon, Mar 16, 2026 at 2:49 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Mon, Mar 16, 2026 at 10:18:22AM -0700, David Matlack wrote:
> > > On Mon, Mar 16, 2026 at 9:22 AM Vipin Sharma <vipinsh@google.com> wrote:
> > > >
> > > > On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > > > > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > > > > On Fri, Feb 27, 2026 at 9:57 AM Alex Williamson <alex@shazbot.org> wrote:
> > > > >
> > > > > > > Sorry if I don't have the whole model in my head yet, but is exposing
> > > > > > > the restriction to the vfio user of the device sufficient to manage the
> > > > > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
> > > > > > > the knowledge to QEMU... what does QEMU do with that knowledge?  Who
> > > > > > > imposes the policy decision to decide what support is sufficient?
> > > > > >
> > > > > > Hm.. good questions. I don't think we want userspace inspecting bits
> > > > > > exposed by the kernel and trying to infer exactly what's being
> > > > > > preserved and whether it's "good enough" to use. And such a UAPI would
> > > > > > become tech debt once we finish development, I suspect.
> > > > > >
> > > > > > A better approach would be to hide this support from userspace until
> > > > > > we decide it is ready for production use-cases.
> > > > > >
> > > > > > To enable development and testing, we can add an opt-in mechanism
> > > > >
> > > > > Here is what I am trending towards sending in v3 as the opt-in mechanism:
> > > > >
> > > > > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > > > > index 1e82b44bda1a..770231554221 100644
> > > > > --- a/drivers/vfio/pci/Kconfig
> > > > > +++ b/drivers/vfio/pci/Kconfig
> > > > > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> > > > >  config VFIO_PCI_DMABUF
> > > > >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> > > > >
> > > > > +config VFIO_PCI_LIVEUPDATE
> > > > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > > > +       depends on LIVEUPDATE && VFIO_PCI
> > > > > +       help
> > > > > +         Support for preserving devices bound to vfio-pci across a Live
> > > > > +         Update. The eventual goal is that preserved devices can run
> > > > > +         uninterrupted during a Live Update, including DMA to preserved
> > > > > +         memory buffers and P2P. However there are many steps still needed to
> > > > > +         achieve this, including:
> > > > > +
> > > > > +          - Preservation of iommufd files
> > > > > +          - Preservation of IOMMU driver state
> > > > > +          - Preservation of PCI state (BAR resources, device state, ...)
> > > > > +          - Preservation of vfio-pci driver state
> > > > > +
> > > > > +         This option should only be enabled by developers working on
> > > > > +         implementing this support. Once enough support has landed in the
> > > > > +         kernel, this option will no longer be marked EXPERIMENTAL.
> > > > > +
> > > > > +         If you don't know what to do here, say N.
> > > > > +
> > > >
> > > > To use VFIO liveupdate, user has to do at least two things:
> > > > 1. Enable CONFIG_LIVEUPDATE
> > > > 2. Pass VFIO FD to a live update session.
> > > >
> > > > This means someone using it has to know what live update is and
> > > > intentionally pass the VFIO FDs. Isn't act of doing this itself an
> > > > opt-in mechanism?
> > >
> > > If it is, then I can leave this out. Alex?
> > >
> > > My thinking was: Distros are free to enable LIVEUPDATE and use it. The
> > > support it enables today is all fully functional (albeit new).
> > > vfio-cdev, OTOH, is not. A separate Kconfig can help express that
> > > difference.
> > >
> > > Consider that LIVEUPDATE could be enabled by default in a future
> > > release, but vfio-cdev support might not be ready yet at that point.
> >
> > But that also requires point 2 above i.e. userspace explicitly passing
> > VFIO FD to liveupdate. Unless there is a capability mechanism like KVM
> > then userspace cannot know what is exactly supported.
> 
> Yes that is why I propose not exposing the support to userspace at all
> until it is ready, by compiling it out of kernel via new Kconfig. This
> way it does not get accidentally enabled in distros or downstream
> kernels before it is ready.
> 
> > Also, users who
> > are using these APIs will already be advanced users and have to know
> > many details about what liveupdate supports or not.
> 
> VMMs will be the ones preserving VFIO cdev files. I think you are
> suggesting they should know what versions of Linux support what kind
> of preservation? Like QEMU would know that Linux 7.1-7.4 supports
> partial VFIO preservation and 7.5+ supports fully? That does not sound
> like a good situation to be in.

I agree, for VMM its better to just assume it is a complete preservation
feature but it is an experimental code in kernel.

> 
> I think it's much better to hide the support behind Kconfig until its
> ready. That way the PRESERVE_FD ioctl just fails on kernels that do
> not fully support (because VFIO_PCI_LIVEUPDATE is not enabled), and
> succeeds on kernels that do fully support.
> 
> If someone wants to enable and use VFIO_PCI_LIVEUPDATE while it is
> still marked experimental, they're on their own.
> 

Sounds good. Thanks!
