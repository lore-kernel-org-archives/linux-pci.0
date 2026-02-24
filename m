Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760053AA1B8
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960649; cv=pass; b=BSggDzqljm1p3Jn4yYbXrYbzxt3ShxX50YHwuQoaBocEeUbjcQA1w0H32V/hQb0N4wfQqgU81j01iweHZ9djvvNgzRHzEGG1ZtAzrsm8X63+iF+dYAPjdvJggjGR6lbDei3RGEer6YqJlw4Lar2mpESzcfnbTwVSi4sx8VFKaJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960649; c=relaxed/simple;
	bh=2a4zbszLImV50LYJlWzhpafrcVDLmcGNsmNOQqAvaHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs7O3EgdlKRAKPHXlDrCBI2jeE9IHxk6gOAyzfxQkAqk/UzyUjCJxD8OtRIabQLmuEBe5TfEfI6AuuWNvvyVZcA3UfteKj/GluFxYo1ptilXq65RwwPzxXQy9ceWt89OfupTUAWwUC1tavj1swP30LRSZXz2c2xO189gwIHHpIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yW6aa2Cu; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yW6aa2Cu"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-386fb2c31e2so52938871fa.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 11:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771960645; cv=none;
        d=google.com; s=arc-20240605;
        b=O1asG6EiBCNcICXCq2RRjlbFDNCxTZKHO/76BXHAwsnGCltbT7TwscLNUFnEenT27M
         HmKT6bRxL76gs2NyL2pnW2JKrrPugfJ7uWpSmD3ciMrZ39aUFHywm0d9oqKOA5JeVqbR
         sQGw0yZvN0mKowShmFWS1ZyraYMToZ/YxNCg59AAKPDnzQLdglm4iSiqmO9yIbkqRsU8
         ZCGQcAigl3hig9vq9PBxbmcMOo6qw86zh/0qd88Si9jI6LM0ZdS/bNeYIzDVMQ5NVSVD
         qKFhZ0i+NimNb5dVNm/J9gR+Ajgr9VoY87uIXniu6xyLShujc4ti3/5DgpTSN1sdXYht
         pXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z8YRbhMW1jrVERHtyC2DuVPZZxUiR82Iag5u5UTa32g=;
        fh=afI5/yeOf+IKkM/ymOuUB2rzq3hIbbEQgN7FUN21PXs=;
        b=MTVWt1AVMF5KUmhxnjx+b518oHdqgQYbVZQwRoWt420UanUlY4cxZLnLyezVZ5vJQ5
         MMZfdNWTm4si+QFp02ZTh4/nMvevs7VWopwW23r7qpIY2xAPYnVHiJH8NPN3HFgmhEXC
         aJTe9YRByZAZPxwpMIiROmnGI90TLeQ00Z3j9v2Z2bO+UZKXE7wnCdULBdEBh7xkhtrs
         RGX5BZsmY4G6zI+hFaVW+oi7flc6VGuFw4jNblNqcb6JeBE/EYMsOog4++8OpXAIPQdZ
         eTZbpF7pitBEOhF/ezlgPcL5voRKpB8XBibKPaxrM1dhpA8nbluohfWFlfyVNpb8a84o
         jXMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771960645; x=1772565445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8YRbhMW1jrVERHtyC2DuVPZZxUiR82Iag5u5UTa32g=;
        b=yW6aa2CuPZF42UeSQUqShl6k4YAqFr99jv22mDOSrPq1GwWsVX2S/9LWQ2s7KQAzwp
         ErFxjiJX1Mkg12RTmTum/cdK2k4BqW6f0vVD9gqrMAkim6WzP4Di4DozeGWIJdWCJt9O
         J8pwUQxRzStDRfEZYDB7Pesee1QGjOy40Vi1Sy5H+n+3t0JIMN2oXKG1wvLjRetmXdvl
         rIalclYR1qLILW2HrUhvWaaRytfmTeRzmmZb+VQBFFtbH7epubGXsyDi/+YQzZ1q6HOq
         r2Gjek3DxIWVeLfL/h4MRPQKfuJJfbCtevhapSplj5Ae4LIDMLSWI8aeEXqMo6yJDpRP
         j+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960645; x=1772565445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z8YRbhMW1jrVERHtyC2DuVPZZxUiR82Iag5u5UTa32g=;
        b=RFcZRvJLIYTHx7h5pMwqISk9e2zDGgzHM/4gctBYixFlLKZUWTlNLKU7hl8np9zebA
         frHr1kHyZiXWXmHBcIyXxxvnLTld2b7rsc4pFCgeIaMw5rAND28S1+R2BKBlTcufhk6M
         ryTprgf9zYPuAZ26ilCBn5eGC3jtDkjnq2XSRd4Cri2bgMIkKSB0FvpKsS2H9e1XIopP
         lUlR+N8oItLQim0YnSBtN791oXlKibGMw2Bvp1/YozSPO2ANEbSrWvWv9jAhxDwHaF50
         UYJf6WrmVg9Ka780PRIPgPy/sjkWFgpSKtf3PD+HS2lGee4+xtA+XikN1OQS0gkeGu9j
         /7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWfVQutTSo9dSKvO/bIIpXsZ2Fk+U+Hq0+IboXwn51A1Hq3Ok2D8S++gq91Dz1tlo5R1j9s15+fRTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDeNqzipEYySabvPFmyenzuVUedHwmel90t7F0toy/J6GkigW
	u3FQ/wzWhT7S8WNbLRre1YYvczwEMXJbxC6Jaxcnk4Ntt/ff3OgU/uq0XpTrlvd4aQMvIeLhiy/
	nakNasZoSZsepSsm5PT2yfafo6fHz5owMzGi56OvM
X-Gm-Gg: ATEYQzxbU2IRyYhH7ROnvBsc28AbZkDdlo/j1r39XVU66o/AFVDTKk4SZE9attInUug
	jZjAcjJuLUbAY4gOQWn0fHOl+8jgbnoLjpiRvBj87daCOce780BIBHbWmNBc5SmAMKiiqQoHIyX
	4cdlnRn/qIP/9Q8iDOxzjUndEUFuaClVXRYe65JqPxha9jNGAje1fq+2i7eAxvxq4YoKCnWmTdk
	7OVkMel9mTTPXM2DuLlFWzQCXD5VoEta+cKzIbA8ApBzHdGEpTXDhp5T3pHS1hMUGYfaPsbNqrT
	laFsLxk=
X-Received: by 2002:a2e:be8b:0:b0:386:e7a5:e26d with SMTP id
 38308e7fff4ca-389a5d5146bmr47895731fa.2.1771960644178; Tue, 24 Feb 2026
 11:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-6-dmatlack@google.com>
 <aZ3wBpYSF7mQv_GZ@google.com>
In-Reply-To: <aZ3wBpYSF7mQv_GZ@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Feb 2026 11:16:55 -0800
X-Gm-Features: AaiRm51YtBXd00PzQGhlvFr4r1F_UzQj5UbNk9Nur9O6pTAPmY6O7yFJgVZNGgc
Message-ID: <CALzav=cabKYFs3yhBEWOS9qseOY7rSh7F_Q40fu4spnYpmZMtQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/22] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Pranjal Shrivastava <praan@google.com>
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 10:38=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
> On Thu, Jan 29, 2026 at 09:24:52PM +0000, David Matlack wrote:

> > +     /*
> > +      * Reset the device and restore it back to its original state bef=
ore
> > +      * handing it to the next kernel.
> > +      *
> > +      * Eventually both of these should be dropped and the device shou=
ld be
> > +      * kept running with its current state across the Live Update.
> > +      */
> > +     if (vdev->reset_works)
> > +             ret =3D __pci_reset_function_locked(pdev);
>
> I see the 'Eventually both of these should be dropped' comment,
> which acknowledges that a reset is a v1 crutch. However, I wanted to
> clarify the fallback strategy here.
>
> If vdev->reset_works is false, we skip the reset but still jump into the
> new kernel. For devices that don't support FLR, are we comfortable jumpin=
g
> with the device potentially still hot?

That situation is already possible today. Simply use a VFIO device
that does not support reset, close it, and then kexec into a new
kernel. vfio_pci_core_disable() (which runs when the last reference to
the VFIO device file is dropped) also skips the reset, and kexec does
not reset devices.

Note that we still restore the state, which at least will reset the
device's configuration back to a sane default, including disabling bus
mastering.

> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index e90859956514..9aa1587fea19 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -81,6 +81,34 @@ struct vfio_device {
> >  #endif
> >  };
> >
> > +struct vfio_device_file {
> > +     struct vfio_device *device;
> > +     struct vfio_group *group;
> > +
> > +     u8 access_granted;
> > +     u32 devid; /* only valid when iommufd is valid */
> > +     spinlock_t kvm_ref_lock; /* protect kvm field */
> > +     struct kvm *kvm;
> > +     struct iommufd_ctx *iommufd; /* protected by struct vfio_device_s=
et::lock */
> > +};
> > +
> > +extern const struct file_operations vfio_device_fops;
> > +
>
> There seem to be two extern declarations for vfio_device_fops in both
> vfio_pci_priv.h and include/linux/vfio.h. Could we consolidate these?

Sure I can clean those up.

> > +static inline struct vfio_device_file *to_vfio_device_file(struct file=
 *file)
> > +{
> > +     if (file->f_op !=3D &vfio_device_fops)
> > +             return NULL;
> > +
> > +     return file->private_data;
> > +}
> > +
> > +static inline struct vfio_device *vfio_device_from_file(struct file *f=
ile)
> > +{
> > +     struct vfio_device_file *df =3D to_vfio_device_file(file);
> > +
> > +     return df ? df->device : NULL;
> > +}
> > +
>
> I'm a little uncomfortable with this part. Why is it necessary to expose
> the internal vfio_device_file structure to drivers? If this is only to
> support vfio_device_from_file(), could we not keep the structure private
> and just export the helper function instead?

Yeah, no problem.

> Exposing internal state into the public API introduces some maintenance
> constraints for e.g. if vfio_main.c ever changes how it tracks
> file-to-device mappings or its internal security state (like
> access_granted), it now has to worry about breaking external drivers.
>
> I believe we expose the struct just to power these static inline helper
> (mainly vfio_device_from_file) ? Instead, could we treat
> `vfio_device_file` as an opaque type in the public header (like struct
> iommu_group) and move the implementation of vfio_device_from_file() into
> vfio_main.c as an exported symbol? This gives drivers the vfio_device
> pointer they need without leaking the core's private internals.

Good points.
