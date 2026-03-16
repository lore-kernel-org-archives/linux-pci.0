Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F236921F
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697782; cv=none; b=CHIhvPF3uf/ZqVQBCNcUMlTF22LBFuTIDmrcKe10tmUu14w4WiO6fLMLkBttk5BL6Db9QB7nQdeMHgWW/hnFj0rl9sw42f8q8wMLvsMzBCNu3ojN+J9w1JNA8PG5OQuOQ55SLnoEswEPaTOrzADF6fukuOketT/TYsDmsS5FB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697782; c=relaxed/simple;
	bh=wQ/TGkC56TEVU9edxRoDW8klAaLsoZRqlEjOzTkcHtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht304k2C5/2od0dGUr+UuSXUCU5ooCB+LDgSJddB7nj/UsAk4MoGy1dFXKEhYVJcfRAhynqP086bTw05dFdMmA5CWGFHe/9yUZHcfZibEbI8ZzZ/sOboeV8c9baKnCyOeX+YMs+GbaQ42vSrn2vNyAbjE48lCJLNoZlAr/V20vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sz9aLFQ5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sz9aLFQ5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so28085ad.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773697780; x=1774302580; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/8z1/dIhYqxHzj3/umwHNkEcO1PtVcvAJP18LcAQq1Y=;
        b=Sz9aLFQ5ZpzjCMQbhP0GaJlUqctaX3L9daYdMHHAWK69ofV+JdrQQNZqqHNfyhJHWT
         enhHiksoJUu1HFOS7H5sV/6mmQvX287gMHDXX5CQnSr3xv5I/ftgY3RMZpoqGhum6QYn
         z4R+1BiLxyabC86ANdO18xTJk7zbt2Z3SrDV8yGup3msBjRNI2SYLUdBjwZUnwAGSVn6
         LMhCIwfYfZWZXxrJCyIpIuAKBOekqIsZhuhPIywVxn1rrlOMsD6YZI8HwEDuT/lydBNT
         3Zpgfy+IOr6GTSSADS1sYM5OjTSeSAkISsKbU/j27ic2WwLzAmamilpN7CSDCTcFAxux
         9+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697780; x=1774302580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8z1/dIhYqxHzj3/umwHNkEcO1PtVcvAJP18LcAQq1Y=;
        b=l5kvftTT/8yEbaxsa0ons5e9K+iGZ4z8UK6eALi90PObTK4XeiYQ35J72C2rYjWj7N
         cqhN1fEW9fEio4Qx+zWg4lhE20L3SNP/I2HArHc+VH6NaE4sUzc22v75GgzYxffvTvkl
         d79ncyuze0Oq5imokW1XpJmGpoWA6iK1qUhLhjwL+M2eNxEs6YLruj38Wcwicu/zu8uh
         /372HN+4s8GrAYAEMX9miASF+QKm2/zO25lEjqCV6g6qv+ABDwePXc9w0YFMi9MkcgbN
         ZqB1ded0QeBsnt8WD9X1VzD5PlOtC/H5qPmlB2AnW2Uu+wFeyH7U5CGTIJvP3BMfDWpN
         AeWA==
X-Forwarded-Encrypted: i=1; AJvYcCWiRFfbvJQzFNPkrVSzY2TN8wBVvjD06fSYYzU+xrCnkVxB71Qqfs0W3OACvFSf+Orh9V8FL3s/LNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySh+xe6xhEOfXg9iQHRV16G3aAGJyyjUaLpeQ39MF4+USRQ5dl
	F7cPmcs+iSYOndrKc/fbJ3VEYIyxG7hW6ajAex+6XDv/Vhz9+zq83OGCBUPPyeqK8w==
X-Gm-Gg: ATEYQzygP/y3HKLsSVipkmw8zEoDfEwAwv5VZk0KC4/3nPvWJBHULxfHIC2HY+5pe3m
	7+R9gvDZV9ODH6i8aOJEnZ/RNYkKffTJ2vlLXy4VXALlkYRuoQaHLDGiEbVhoJUMFtRdBdPWAGe
	RxHEB8sOQF7BSuHeka6QzWrMdn21ZoislSz032dJsOFNdf1gPvQ+gGR6vylCqzTLocmfVmZGzGd
	sMmNmhgctHXhJ9fWLU9Z8Dch0mouaMazC0aZifN2TXl2CqiZQ09DzOLqydQ04nzuKa3DMN3EFM/
	c4W8g6Lkrjmsng3Dmal6h9yBg/OcpMN5ALjKpE3A99Bk6CumEs9aBJZsMCKJnMfCbUlh83XmA12
	72qS3Q212S07+X7EfOs66FE+1jRsGOeP5a+hNEWirEHX7dc9CylGR4Q3HDgMAOaMLavkD5v96P8
	9RTd2KX4oraet4r+vxmSv2K1+I6sOzQnr+K44qzk7Bt0U4NnK2tNrj+1XlKNY7
X-Received: by 2002:a17:903:98b:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2b06402f49emr1238925ad.12.1773697779367;
        Mon, 16 Mar 2026 14:49:39 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07365b22sm14359627b3a.45.2026.03.16.14.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:49:38 -0700 (PDT)
Date: Mon, 16 Mar 2026 14:49:34 -0700
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
Message-ID: <20260316214055.GB1846904.vipinsh@google.com>
References: <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com>
 <20260316160759.GA1767448.vipinsh@google.com>
 <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com>

On Mon, Mar 16, 2026 at 10:18:22AM -0700, David Matlack wrote:
> On Mon, Mar 16, 2026 at 9:22 AM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > > On Fri, Feb 27, 2026 at 9:57 AM Alex Williamson <alex@shazbot.org> wrote:
> > >
> > > > > Sorry if I don't have the whole model in my head yet, but is exposing
> > > > > the restriction to the vfio user of the device sufficient to manage the
> > > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
> > > > > the knowledge to QEMU... what does QEMU do with that knowledge?  Who
> > > > > imposes the policy decision to decide what support is sufficient?
> > > >
> > > > Hm.. good questions. I don't think we want userspace inspecting bits
> > > > exposed by the kernel and trying to infer exactly what's being
> > > > preserved and whether it's "good enough" to use. And such a UAPI would
> > > > become tech debt once we finish development, I suspect.
> > > >
> > > > A better approach would be to hide this support from userspace until
> > > > we decide it is ready for production use-cases.
> > > >
> > > > To enable development and testing, we can add an opt-in mechanism
> > >
> > > Here is what I am trending towards sending in v3 as the opt-in mechanism:
> > >
> > > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > > index 1e82b44bda1a..770231554221 100644
> > > --- a/drivers/vfio/pci/Kconfig
> > > +++ b/drivers/vfio/pci/Kconfig
> > > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> > >  config VFIO_PCI_DMABUF
> > >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> > >
> > > +config VFIO_PCI_LIVEUPDATE
> > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > +       depends on LIVEUPDATE && VFIO_PCI
> > > +       help
> > > +         Support for preserving devices bound to vfio-pci across a Live
> > > +         Update. The eventual goal is that preserved devices can run
> > > +         uninterrupted during a Live Update, including DMA to preserved
> > > +         memory buffers and P2P. However there are many steps still needed to
> > > +         achieve this, including:
> > > +
> > > +          - Preservation of iommufd files
> > > +          - Preservation of IOMMU driver state
> > > +          - Preservation of PCI state (BAR resources, device state, ...)
> > > +          - Preservation of vfio-pci driver state
> > > +
> > > +         This option should only be enabled by developers working on
> > > +         implementing this support. Once enough support has landed in the
> > > +         kernel, this option will no longer be marked EXPERIMENTAL.
> > > +
> > > +         If you don't know what to do here, say N.
> > > +
> >
> > To use VFIO liveupdate, user has to do at least two things:
> > 1. Enable CONFIG_LIVEUPDATE
> > 2. Pass VFIO FD to a live update session.
> >
> > This means someone using it has to know what live update is and
> > intentionally pass the VFIO FDs. Isn't act of doing this itself an
> > opt-in mechanism?
> 
> If it is, then I can leave this out. Alex?
> 
> My thinking was: Distros are free to enable LIVEUPDATE and use it. The
> support it enables today is all fully functional (albeit new).
> vfio-cdev, OTOH, is not. A separate Kconfig can help express that
> difference.
> 
> Consider that LIVEUPDATE could be enabled by default in a future
> release, but vfio-cdev support might not be ready yet at that point.

But that also requires point 2 above i.e. userspace explicitly passing
VFIO FD to liveupdate. Unless there is a capability mechanism like KVM
then userspace cannot know what is exactly supported. Also, users who
are using these APIs will already be advanced users and have to know
many details about what liveupdate supports or not.

> 
> > I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
> > about how userspace will know that sufficient VFIO support exists.
> 
> I was thinking we can flip VFIO_PCI_LIVEUPDATE to be enabled by
> default (if LIVEUPDATE and VFIO_PCI are enabled), and drop
> "(EXPERIMENTAL)" from the option title. That would be how distros and
> downstream users of the kernel know that sufficient support exists to
> enable VFIO_PCI_LIVEUPDATE.
> 
> > May be write in liveupdate documentation (PATCH 11 of this series) that
> > support is experimental?
> 
> The documentation in patch 11 includes largely the same text that I
> put under VFIO_PCI_LIVEU"PDATE. But I can explicitly mention
> "experimental" as well if that's what you're asking.

Yeah, even though documentation do get stale but I think there is no
better way in this scenario.

