Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14B331A53
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858928; cv=pass; b=Cyzv+vUzhOxSnmYcQfTpQMqHTrSUR2L0kc2uwZtQT9tQX6q6rotM+MgH4f68hH9jaW4+deBDLwEueyezXXndstiPqC9aCv9lr8FLqrUB9NjY4KwK0uBWY00QM0Rm0O5g4omMBQv/NLfCxiRiVHFKJt3s+mB/32LPxqe1KQ0qtQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858928; c=relaxed/simple;
	bh=IIH6gb9Aspc978S77GNhCcY8LVqXRyGmxXPBoO9kTVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWZNO/eDdz+5dxA2M1BNBOd0bzGZtoZ9o2L4nheMXDu7azrnZGysfl4+Q1xGlE5Xb8joLsoovrdooBYAcQ+Hur8zIL6IO7uGcCZrLgji6eNfe5hzNjStrn9AYU6M08LQgiG6D9Xsj2IGHc2CkpucG7dM8EA4LzTl3MuZDmHqLT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIU74OsF; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIU74OsF"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137335bc3caso10776493c88.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782858923; cv=none;
        d=google.com; s=arc-20260327;
        b=NwYJGipEbL7UfUH0TKXAssxY+ZFxJ96VNzK+cRqqO1Taz6pnW3nxeO8CsgbH04aC/b
         VHxqsM8CTqS11VW8Xehe1fMGB0CL0lZ8y/hcV6V5PcW4gbB4sA61CC6EDKYQOH5tQA2O
         4ckpDkHtREIXzXvDilAJ39b4ZoJJqQrrvtYxlJZioZ0jTG70V7kP4PdONh/+44PvCO9h
         enoZCVV9tFryVZw4o+J+2LRgwye3Y0Z850scHwZjpdliFPyN6FxziwluBq2FYvlmbN5p
         EiCiTCXnZJ1N1j8GsGhJDeZ5zZRnUX2fnK9RQxeMBr/hxlgyT/pnBkyooFaEsXaBxyLw
         PPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OLXeb8c7iyYBBm1u3dFIHz9SDW0xbbNuKTG6qGPD7go=;
        fh=F9zNF9RwHWUpqO5A1/milR93ibXbjUTQyFw3qLIXe3s=;
        b=ZoizjQmglGeOx44UyYLH5CE0KsfFljHJPxImeGPjYyPWHLiWqkwj3DJTJ7jEU6zu+g
         Iepyc+qMkGIeod6449OnGJgcZwnAZqdVZRCnVZpbBGKNb8GYVcYcp9jqFOQaSR2zP4oD
         TUNMo5Xi5cNg/c5seyZiNvmwJRnb2sQ6VsJVjSb57IOZkO9S/HKmzM3pmb7rEWUy2ubx
         HcR0lDjLmuLZkBYf+UTrZbUeCXqbd3W2dnIuC6fCsm9fqmnwilQT6WfRsRNfL1Etp4Jv
         kCoaozAq38qSZQfBFG6z8me2l6HJTxX512ToxYNC8J8UC80yp82YWyLe/y9YxqFNf1SA
         4ymA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858923; x=1783463723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLXeb8c7iyYBBm1u3dFIHz9SDW0xbbNuKTG6qGPD7go=;
        b=tIU74OsFUlV3w0RTbXhocTIMXQyGIfdxV4w2f0/ZyNa30O5QCKoAji2YPY6tUioxzw
         buympSlkGYL6Bpn4SaMaEvcx4JTonwICxKPb1ktbWYiyCbn9r8dd7bGW/jX4QJdqsLLe
         gqRKdDNMnEQHh5gJ6pV/TDeTpHyjMYiMdEXAQWByHY1FKAR0p74n3fJ1iv6etIpHbDLc
         HsPkgXZDMaVb9vXoBwpdsXd5hV8ojGNHFpXzQEz2Q4sP/8xrEY4SxKtyEBwxWvDp05+T
         0yMU3daHBKYyhevq2Hut6rfWQvHVZiKaB5i47V++4rRCr/c7hTUxE1iOUPqiAWx4OY2g
         08Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858923; x=1783463723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLXeb8c7iyYBBm1u3dFIHz9SDW0xbbNuKTG6qGPD7go=;
        b=NDEzGM0PfsmkdQGK6geEZTysXJSvhMVUsb61nc8gikQFDG095wuveKifhdBaKG8B+V
         LzpmwCoMRe2RvuzFDR+VRppqz5+h+rUngl9xHt/wBo4hBN0BxNwFX0Kacn/hdGnZRfQR
         mri/8CYc4AyDwgyPfIs9WnBr4YSUoGdq2cq/e4BvUEQmOEoUCTxmw97F1NlUGKavCo2M
         8v2uyuThaC2md59z3wto67gsyO5I9pUBHOD9/TI4UEEAF2IMLOITXf/Ai07pheEpQxjH
         3ST8xxqpTC2cz3cmn9FnZu8NFRYSGT1yQ6j3VXMvUoyVSOuWyp5H9GGVMdhbWYCk5+Nm
         5jEw==
X-Forwarded-Encrypted: i=1; AFNElJ+/JK0XY9XdotyYQahkTvaO4y8FHjUWXm6Y4EuM4cCHoLIwC7a74fExKryNwNkOaKQ2k3OXDbINH9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJFhb4+24zMht6Fm2FhRv6vRABVR+H1gb/NGwi25DXBYMpOw9
	IaKYCbPZC1m3Ki0vw9sk0LQb5M/2Cg2iOQQMhnLErRWIbONW2MQXqeiQZfSuzIdP0AitNvAgWfi
	WCl9S/5fNzTrG678TNCJZmSsitZrMtAd9AIdxXY4k
X-Gm-Gg: AfdE7ck3HMdJ5KMQ7fO4q5pRkfOpTJY5FZMZ6R9/1mUvfsGbItRkCRfpNOz05+VjJVM
	lDdkUlR6ZIBQ/yAHkyetIG4Xrls7pC3BekJ6beS5zdRN+jjodRuxxYgDkvWP2a7ACTH95pPMptO
	JYt5TQkquoptHnbqkT3vyjLp+IZNVMdGHc+InmCQjCmEx8GIPir4mbymK0u432PEHulwcrWVNz3
	bgQSD9hjxnl/eZjct7pdgJa5Yp+bKMyS60pNaaOwQZYDRSeGGfQR53A3RNWrqZtT5hR7b08
X-Received: by 2002:a05:7022:f690:b0:139:ed59:4b8e with SMTP id
 a92af1059eb24-13b2a1c7f1dmr3156303c88.50.1782858922721; Tue, 30 Jun 2026
 15:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-10-dmatlack@google.com>
 <aiaoc6Y6qeF_5Wn9@google.com> <20260608181906.GP1962447@nvidia.com>
In-Reply-To: <20260608181906.GP1962447@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 30 Jun 2026 15:34:56 -0700
X-Gm-Features: AVVi8Cd-vdSCkwSqwAz2qbX9b8clCFCtpt-XfTl_1BZFKIa6zUmlOyUobbTWOp8
Message-ID: <CALzav=eGkCom7rM0Mj_AEhcvfryLctRWghPaGkD2V5_bMiXTEg@mail.gmail.com>
Subject: Re: [PATCH v6 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 11:19=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Jun 08, 2026 at 11:33:07AM +0000, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:07PM +0000, David Matlack wrote:
> > > Inherit the ARI Forwarding Enable on preserved bridges and update
> > > pci_dev->ari_enabled accordingly during a Live Update. This ensures t=
hat
> > > the preserved devices on the bridge's secondary bus can be identified
> > > with the same expanded 8-bit function number after a Live Update.
> > >
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  drivers/pci/liveupdate.c | 18 ++++++++++++++++++
> > >  drivers/pci/liveupdate.h |  6 ++++++
> > >  drivers/pci/pci.c        |  8 +++++++-
> > >  3 files changed, 31 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > > index a93b7ef065f2..701276ef6cfb 100644
> > > --- a/drivers/pci/liveupdate.c
> > > +++ b/drivers/pci/liveupdate.c
> > > @@ -128,6 +128,10 @@
> > >   *    way after Live Update and ensures that IOMMU groups do not cha=
nge. Note
> > >   *    that a device will use its inherited ACS flags for the lifetim=
e of its
> > >   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> > > + *
> > > + *  * The PCI core inherits ARI Forwarding Enable on all bridges wit=
h downstream
> > > + *    preserved devices to ensure that all preserved devices on the =
bridge's
> > > + *    secondary bus are addressable after the Live Update.
> > >   */
> > >
> > >  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> > > @@ -756,6 +760,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *de=
v)
> > >     return 0;
> > >  }
> > >
> > > +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> > > +{
> > > +   u16 val;
> > > +
> > > +   guard(rwsem_read)(&pci_liveupdate.rwsem);
> > > +
> > > +   if (!dev->liveupdate.incoming)
> > > +           return -EINVAL;
> > > +
> > > +   pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> >
> > Again, I might be thinking out loud here, but since these are
> > hot-pluggable devices, with some FW / SW running on them, I'm a little
> > worried while assuming the HW registers can be trusted across a kexec.

This is, in-part [*], why I explicitly read the capability rather than
caching what the previous kernel thinks it was in struct pci_dev_ser.

In other words, the kerenl does not assume that hardware registers
remain unchanged across kexec. It reads them after kexec to determine
what state the device is in and inherits that.

[*] The other reason is just to keep the ABI as minimal as possible.

> > Say, if the bridge experiences a reset (e.g. link drop etc) during the
> > kexec blackout, the PCI_EXP_DEVCTL2 register could revert to its defaul=
t
> > state, meaning the ARI bit will be 0.
>
> This does seem like something to be concerned about, but realistically
> I think if you get a PCIe error I'm not sure the incoming kernel is
> equipped to handle it at all :\
>
> Just resuming the driver is going to fail too, I don't know how VFIO
> can learn and forward the event, and so on..
>
> But maybe it is worth being a little more defensive here

If this were to happen, the kernel would see that ARI is disabled on
the bridge after kexec and proceed with that state (ARI disabled).
Devices (devfn) 8+ on the bus would not be available to use or restore
(the kernel would not discover them during scanning). It should be
fairly obvious to the user that something went wrong (devices they are
trying to restore do not even exist) and they can reboot at that point
to recover.

This should be extremely rare though as it requires a PCIe error that
affects the bridge to race with kexec.

This seems like a reasonable way to handle this scenario, at least in
the initial version. We can always look at more gracefully handling
PCIe errors during kexec for Live Update if-and-when there is value.
