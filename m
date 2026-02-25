Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357A366060
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059862; cv=pass; b=Y9ZwWkDyZ18M2JonE4fNHL8MdEfwvwcIxZ9KCar2J4N9fbXtfWrf34g0VVz4UHuXGGTdI/qQfy0AdxSyn0MYeO5KdgdDTZfGvHeSTWxcHdZAlDGNLMRea9C+3caiPECgDpOSvL03UIcKqKao2MdY+cpF0kztw/6WkuZGzEPMh1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059862; c=relaxed/simple;
	bh=7OqNOR2pf3cTOCHBcFY4ktMJJpHonFJgCAwij4qDwtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5whyr2bl7SM7Upizp87NNk34IQt+KiKcrWe0XNvnDEm2t7Safn+xOmN73GBrtRrh2EcMYMvgeLq06+gnrcnvi7/DZ9NMnkH/oZi4y12W3R40DzzIUtecLGPDQ+RQGTFetLVPaxKW3Ne8srMN38oLrCfYGymbSNFAO84WDP6/YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVRV/1XX; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVRV/1XX"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5033b64256dso193411cf.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 14:51:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772059859; cv=none;
        d=google.com; s=arc-20240605;
        b=irr9giRqTnkRRUjMZharboSKPNZJR3ngeJXxNg7Ktzdsu0rk3bSVlKnz1X5iNyaaQc
         rTSUZP6VqSMaX831hUUcFKndJkc2fNeHt53kOl9vNXYkRcfMSQ9Xw5G8AY9Nqx2SZM9z
         i0OSohwdre6yTpagBP2FK5YLDVmfy9fAJ1N/yjV/PzeQt+4bEq8T9N7m3IOymTgx+t99
         LSge4OyMJCtQdHzm2uexdJnf0EGQTPDLIEycYHN9ssUiclhwLcjC80x0HL15fgWrqfWH
         mGDaG81CqwsvMpnYzoSqHr1mpCloIhS/nygZwoPU5N6ncc5YvuFJDFdLD4qY38RlYduz
         QCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsOXiL/6Qn9m7Yd1SU2mFbssuofZOBkFUGv1WIDmPB0=;
        fh=jf2H73lUGi9SKIOcgydcTGZ64L9NlF/TRHDo6wsxgn8=;
        b=XogHZZvWqEOSCCKwSh3aZv0XZQxwvMMxI7zbiZDRFlaNuKYbtrWrmKq3MgNUuWU1U1
         OZdv2LypPiHbLBl/PP1pD42wvmvMZP6cMQ94PvK1xM3h9ZAq8NwhQUy3mUbmCnV/B0Ti
         f32Qnq6ON3LmTNt7QW+2HZG0TKS2dXBRQ5jlwtsYt0YccqExy4GeDeL2+kL1j3nMz26s
         54XIXMplR3VTXSiOOg3h6TxRc/sd7gSOmwz3semiNzIlXyFAGflBGanmxLfQJOH6yoUA
         HrLDzSYa/vA3EIfLyG7lochZvWTjc8sqDti4KQO55zQpB0eJo4V+o+uI5Bwm6uImyft8
         7tlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772059859; x=1772664659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsOXiL/6Qn9m7Yd1SU2mFbssuofZOBkFUGv1WIDmPB0=;
        b=WVRV/1XXo2nnw8gzHzdS8IksP9JKJvN3r6Llnl75OoENUwU5YDeA9MYBGEFJ9nBAd9
         J2IyxpI+5I8/f8KlhHspyQxqjMQqFVdGuyY15FT88FsCEbh0Gnrx3OQwF8uAVf+Y/wXH
         udcDYJpAudc8TDhtI10nVAMJgFuFYzKKqOotF1h3fiM5+i+rswqgvv605CkgnyXgjh22
         2P/0AfOQoYmBaoOiaIPsQAcgXxM7WW3G21sByw1cq3WvPBd/UgRbG0bRapKQlaDnnpxF
         1/N3w/nSBohJrJPVpdytsvq1ReNEffews0/3EuPaAR4TVp4MH1SO5aTam8noYyp7wwfb
         Nc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772059859; x=1772664659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsOXiL/6Qn9m7Yd1SU2mFbssuofZOBkFUGv1WIDmPB0=;
        b=TrVW7t4fNRNENQ4A5GBUeTFMDPHgC0WHBMNUui+hWOVLwHSYTnIm7nSBKD/bhpj3eq
         WvTyEM5rVu1CkycsTg53oJCLQMidn8lx2Z0VGkcV3kwMbANOkvvPS6DHnPZKbWS5iX39
         u9+PVh9+rPH2H1/F4FaNYBiJb/na80IPhfACBN/9rEjpNsDOG/2c6fvNPlCiNYavYQpT
         4s6Wkn3H3WqRu4ZfKulUeTC3rxDB5NFVi6SqQyQF1RHW30Z8euLHDfZlN4UUnjIIr4Z5
         u4FLzlTGV8+EsgLaiNt6USNlf026HQdRHh8w7WS3hu1Sto2m+wsgF4mOLSHvJePgmXJY
         +KjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgKS4HoPAALH6xwFjV+C/ZcSgPDUipyni3+bnfDslhgHJ14IBcK5SICmJvxa5qTKz0nmG/epaDS/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LQSKxPYTODuF56ULdMzicqzwGBLaZaCjdtX/rwFhbm9CF58f
	sRi9KuvYSGIOeXpHbhFCMpEr+TJtYmbLpsAhEfgyt3PTXMzrn3h+hdx2NDNT/hBZTDFLsoyXwQh
	4UpFS1Ha6UjLEaxjw1UVI1ifomUf8U++wO8vxj7u2
X-Gm-Gg: ATEYQzzF/CjcGooukpLx49FuGL3kLPc5ojLtAsPDA8PZDw6YSwwGJXdCg1yLrGVawm0
	dx2Q5zMz7UUVqsrwQ9R6b8VHd3fBpAnLH9qt18SCND1x/EqGxiHPtwxkGMdGX8+VP1EPgcNEvQi
	FWKsaTEGOdW2u3IuliR6hm626jtxTYtvolbQrcEzuVxXzGdhyOOrr0UVYGLfGOd3pz+epOKwVGT
	aj8AZXWUDXdUWlwFzjjYXARlj9fFUjRTy3fHo7vgzUv6qVqKs/7fpP/+9s1K3G3Y6FhwqrSGXTE
	0Wg/Q8lmOe3yidQirbrYjeGGe2/czuS73fc+20Dsx8AHPm/qcjKL
X-Received: by 2002:a05:622a:10c:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-507441cb73fmr3920551cf.8.1772059858971; Wed, 25 Feb 2026
 14:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org> <aZ9yWlcqs2b6FLxy@google.com> <aZ931bYILhhkhW-Y@google.com>
In-Reply-To: <aZ931bYILhhkhW-Y@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 25 Feb 2026 14:50:47 -0800
X-Gm-Features: AaiRm51aoTymXymwCHLQ9gcq3ldQPi6BvUrjqTLQO_zSuAjigNCnBqzqKSIxD-4
Message-ID: <CAAywjhShWTQbkwhDYB=9a_PZjGHnJ-=HTLAzDBvnDsmtvP=Auw@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 2:29=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Feb 25, 2026 at 10:06:18PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Feb 25, 2026 at 02:33:28PM -0700, Alex Williamson wrote:
> > > On Thu, 29 Jan 2026 21:24:51 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> > > > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pc=
i.c
> > > > index 0c771064c0b8..19e88322af2c 100644
> > > > --- a/drivers/vfio/pci/vfio_pci.c
> > > > +++ b/drivers/vfio/pci/vfio_pci.c
> > > > @@ -258,6 +258,10 @@ static int __init vfio_pci_init(void)
> > > >   int ret;
> > > >   bool is_disable_vga =3D true;
> > > >
> > > > + ret =3D vfio_pci_liveupdate_init();
> > > > + if (ret)
> > > > +         return ret;
> > > > +
> > > >  #ifdef CONFIG_VFIO_PCI_VGA
> > > >   is_disable_vga =3D disable_vga;
> > > >  #endif
> > > > @@ -266,8 +270,10 @@ static int __init vfio_pci_init(void)
> > > >
> > > >   /* Register and scan for devices */
> > > >   ret =3D pci_register_driver(&vfio_pci_driver);
> > > > - if (ret)
> > > > + if (ret) {
> > > > +         vfio_pci_liveupdate_cleanup();
> > > >           return ret;
> > > > + }
> > > >
> > > >   vfio_pci_fill_ids();
> > > >
> > > > @@ -281,6 +287,7 @@ module_init(vfio_pci_init);
> > > >  static void __exit vfio_pci_cleanup(void)
> > > >  {
> > > >   pci_unregister_driver(&vfio_pci_driver);
> > > > + vfio_pci_liveupdate_cleanup();
> > > >  }
> > > >  module_exit(vfio_pci_cleanup);
> > > >
> > > > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/=
pci/vfio_pci_liveupdate.c
> > > > new file mode 100644
> > > > index 000000000000..b84e63c0357b
> > > > --- /dev/null
> > > > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > > > @@ -0,0 +1,69 @@
> > > ...
> > > > +static const struct liveupdate_file_ops vfio_pci_liveupdate_file_o=
ps =3D {
> > > > + .can_preserve =3D vfio_pci_liveupdate_can_preserve,
> > > > + .preserve =3D vfio_pci_liveupdate_preserve,
> > > > + .unpreserve =3D vfio_pci_liveupdate_unpreserve,
> > > > + .retrieve =3D vfio_pci_liveupdate_retrieve,
> > > > + .finish =3D vfio_pci_liveupdate_finish,
> > > > + .owner =3D THIS_MODULE,
> > > > +};
> > > > +
> > > > +static struct liveupdate_file_handler vfio_pci_liveupdate_fh =3D {
> > > > + .ops =3D &vfio_pci_liveupdate_file_ops,
> > > > + .compatible =3D VFIO_PCI_LUO_FH_COMPATIBLE,
> > > > +};
> > > > +
> > > > +int __init vfio_pci_liveupdate_init(void)
> > > > +{
> > > > + if (!liveupdate_enabled())
> > > > +         return 0;
> > > > +
> > > > + return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > > > +}
> > >
> > > liveupdate_register_file_handler() "pins" vfio-pci with a
> > > try_module_get().  Since this is done in our module_init function and
> > > unregister occurs in our module_exit function, rather than relative
> > > to any actual device binding or usage, this means vfio-pci CANNOT be
> > > unloaded.  That seems bad.  Thanks,
> >
> > Hmm... IIUC the concern here is about liveupdate policy if the user
> > wants to unload a module which was previously marked for preservation?
> >
> > AFAICT, In such a case, the user is expected to close the LUO session F=
D,
> > which "unpreserves" the FD. Finally, when rmmod is executed, the __exit
> > (vfio_pci_cleanup) calls vfio_pci_liveupdate_cleanup() which ends up
> > calling liveupdate_unregister_file_handler(), thereby dropping the ref
> > held by the liveupdate orchestrator which allows the module to be
> > unloaded.
> >
>
> Ohh wait, You're right, Alex. I just realized the __exit won't even be
> reached because of the internal pin. The current implementation creates
> a catch-22 where the module pins itself during init and can't reach the
> unregister call in exit. I believe we should drop the ref when the user
> closes the session FD? Additionally, should we move try_module_get out of
> the global liveupdate_register_file_handler() and instead take the ref
> only when a file is actually marked for preservation?

If we don't do try_module_get during registration, the registered file
handler can go away on module unload while LUO is using the handler
during FD preservation. This makes it racy. Maybe register/unregister
need to move outside the module_init/exit.
>
> Thanks,
> Praan
>
> > I think we should document this policy somewhere or have a dev_warn to
> > scream at the users when they try unloading the module without closing
> > the session FD.
> >
> > Thanks,
> > Praan
> >
> > >
> > > Alex
> > >
> > > > +
> > > > +void vfio_pci_liveupdate_cleanup(void)
> > > > +{
> > > > + if (!liveupdate_enabled())
> > > > +         return;
> > > > +
> > > > + liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> > > > +}
