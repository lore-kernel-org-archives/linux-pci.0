Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24995394EA6
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648463; cv=pass; b=TNIAGmCYQ2vq0o4gKF4+wnJNoCfqOqNLhxdkw5+wSMA9aHgbKNLHUmqDFNp0JoweowWsBsAZ4Z6ucphdSjLTgUaVvp/S85CW+VajVTQvnbB76DokCp76rUOPu7kv63c/YJNGLH9FLkI1XTOW+qXw1XxSeQEn4ZFSaax5yhEC3fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648463; c=relaxed/simple;
	bh=qme9hMeTybbvHWlc65qwT/wsA705F7QW3wsJxaveMyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhsUHCZtP+EnBbh0by+1YgIivb851UTeg1hvKpJCpvODNxOVeeFAb5LZVQJ+OtXalhz4OXo7jxy6XBtrWjcJJhyFSF8+55Px/K4xUh1HBIrvTc6PjycWQsifOpXa2eVGPS9gfJZuNWvqo2nACYNIESR9HHOb+uqhBgXRYVZ44zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WaSnrYEs; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WaSnrYEs"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1390f75d8bbso225080c88.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 15:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781648461; cv=none;
        d=google.com; s=arc-20240605;
        b=Jx9CRhVAPGGf8orjDHxR+KDxoeSQxI8ZNX0yIxA5ZJP5z6p9BIeEhKivzSkfqwAWEy
         up9tvECzVRopQPhMC6qFdsEyMphydx+v0N2jtkwDyyLETzndMqhfaW4nDc8t+BDQjeye
         WXCrntqGdIiZPcPF3yqVlXgGSE5fwwnz20HbHWHxzTxNhFdBFnhxDT0mmT4W9E1sCjSH
         eeFwF/tSEndayDIIukYAgyWApsJRsxjgnYr/2EjoTnbwcTOlgDhrnS5pZ27tgdnEUVWD
         Hb9BroysaiKQVZdoR3cIQHTnx5r/aGYllQU/igD5LSvz5jh4Nuvt8TIlvqHB1yrxh9Z+
         wkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5hm1HVaCy9nZT8d+x5IZzYgyaULXvQNG2Dw2s8INhX4=;
        fh=uHIvyCBHtIyHJS0WuX6rxNEbuQDkezi9gIKAdGXn+hU=;
        b=DbSdX1b9K6hQgaZxt4gFkAr5EaFzEk8YCRabJ8chqkB8n9bxj4V/8AXVKWT+8H6mSW
         quoNfQ23cEM8CF7jw8+Mawb77FocYK2FFb0iR4kEssMBKSagirNHZl6L7g7pDMV2DIf9
         ix9Lnj4LofZmpVUxlJZ8iVOzMmsqar/oybgx0ID8jCpkZ4ui9y9z59wZU5iqJUoXx6/d
         JgVNV+49nVNztlitZQlDVG/0CnibQS0C1C5UhZT7TnwyGX66S1RG1M0l1aa1KPsvrsYO
         ik3BqmhovTkN74QbwTi2j/yckLv9TXNU5hHimwNckp+rdtWWJlUhJ4XWIEC9nhgwq/lo
         Ec9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781648461; x=1782253261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hm1HVaCy9nZT8d+x5IZzYgyaULXvQNG2Dw2s8INhX4=;
        b=WaSnrYEslwMKTZ1E4L/bXRbsZUJBd3u1ey5KCjQyJcXHmlFiKCXDWkQSdY7WuihHc/
         PPql6fvqNUNyZ6m/xVA4RG3pRHqmCL99OmscMJkledKET3Q6WA5hq8Q94y6K/FJDucbF
         x2AKkA2y0oYjnsGSbCKwNe6s1QoGRPJ2IjWfU80HLl1rosF5wlWMWSgz3uCfvS5fbLB7
         o6YEpilC2wGv7uqWKV0WQqSWSEaAsXrKXkN1HSyIOfextoTptgjxbetLhC0pDXfPDUGx
         3YbAd7r+MdVQLSyJTXp1ksxDcvsTFMBoeeUEG7JwTgxa8RNbqtPOYP3HrSxAcY8NTC9Z
         AFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781648461; x=1782253261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hm1HVaCy9nZT8d+x5IZzYgyaULXvQNG2Dw2s8INhX4=;
        b=bqBgnk5ph4v+9Z7BxwNvLZNNxQiIvaxX4KDdOkOMGUKvtXL7oqJPTbAY+ARJBT4YWv
         dbaHXhBVxIGiDNGnscrlmuQ6t5wqWacDaHA5q4Ahwj+Xj6HPFMgDCYxh9f357y4lYfHI
         An9eiUB3ONoimF7I7X/xwM7gOrnFgPZKEWu1kXlL9HaWplpWSbHTbSx0EKYVxaY45C4l
         vi7mr2g2XVx/nQ0Ne5yK+58BmNMmjhoStEYbiM4BY7ozdpOx0RhH8TvjYFuvbRRXMQJY
         mXdIOPtQquA0BZ5rXmMJR4A42bXUxmk4uaQFG2jpvpiXmSfpScecYWTMwMr4Wf5kZtYF
         30Og==
X-Forwarded-Encrypted: i=1; AFNElJ/JOseRzDJNKp8HJPj9GW+xKT4n0Y93D4gc7h76PYKm/Ee5Q4uEbFdFiUEiaULWO6CjSBJBkiQqRSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYZ4x+ga7Nc4cf2k2TQVgIkJO0Qj56p61SP9wSO3uw4HE+83eB
	2jerlHrVhd1u0ER4hY8HOduluGNt2iM9Ue7XwlQ/bShay+D1+x20hbXlLFx6bVbJlgNcTeBIRuM
	DsGWkpPXk3PoFKK6P71Glm5y20R+49EJND1PXCXYD
X-Gm-Gg: Acq92OGj/CsCF0xclHlxdcKFhX8buKFkqtsQcTdF4hrVStAWC61LGpiUJpUGLWECMo7
	42G86GlHGJvdo5470/2/hnG+kJdKt+eMoVoem1bUHW4Bc3dFsrj4dwI7EuKjonf8hdvqF43bcla
	+fnA4L93clrv1jUtFPE1VVeHhc4cap5p8E8y2p/Nggo/oy3SVp7JG7smnY5OHw7EluDrarSUWim
	1bbjoGLmTgGbE3QT71NTmUWgyhsMPRXOMZwMWeM75mYDntZBLNA3MWgCIDqvIsBIs4Xr4SEVn/J
	FYdELvM=
X-Received: by 2002:a05:7022:6ba8:b0:136:ac69:b0f7 with SMTP id
 a92af1059eb24-1398f680985mr453889c88.16.1781648460211; Tue, 16 Jun 2026
 15:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-4-dmatlack@google.com>
 <ajGpxMXk9iyXLzC4@google.com>
In-Reply-To: <ajGpxMXk9iyXLzC4@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 16 Jun 2026 15:20:33 -0700
X-Gm-Features: AVVi8CfxK4mMKiv0sputj5dz4geA42BjbfG1FN5Obs96hOQRjIUk8-dblh_dgDE
Message-ID: <CALzav=eo=UwoTNTYM8Z7uKoihxfB7NtVP701qidVgoqyBKhUig@mail.gmail.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 1:09=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
> >During PCI enumeration, the previous kernel might have passed state abou=
t
> >devices that were preserved across kexec. The PCI core needs to fetch
> >this state to identify which devices are "incoming" and require special
> >handling.
> >
> >Add pci_liveupdate_setup_device() which is called during device setup
> >to fetch the serialized state (struct pci_ser) from the Live Update
> >Orchestrator. The first time this happens, pci_flb_retrieve() will run
> >and convert the array of pci_dev_ser structs into an xarray so that it
> >can be looked up efficiently.
> >
> >If a device is found in the xarray, the PCI core stores a pointer to its
> >state in dev->liveupdate_incoming and holds a reference to the incoming
> >FLB until pci_liveupdate_finish() is called by the driver.
> >
> >This ensures proper lifecycle management for incoming preserved devices
> >and allows the PCI core and drivers to apply specific Live Update
> >logic to them in subsequent commits.
> >
> >Drivers can check if a device is an incoming preserved device (e.g.
> >during probe) by calling pci_liveupdate_is_incoming().
> >
> >CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
> >domain and bdf can be guaranteed to fit in an unsigned long and be used
> >as the xarray key.
> >
> >Signed-off-by: David Matlack <dmatlack@google.com>
> >---
> > MAINTAINERS                    |   1 +
> > drivers/pci/Kconfig            |   2 +-
> > drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
> > drivers/pci/liveupdate.h       |   5 +
> > drivers/pci/probe.c            |   3 +
> > include/linux/pci_liveupdate.h |  13 ++
> > 6 files changed, 251 insertions(+), 3 deletions(-)
> >
>
> [snip]
> >
> > static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> > {
> >-      args->obj =3D phys_to_virt(args->data);
> >+      struct pci_ser *ser =3D phys_to_virt(args->data);
> >+      struct pci_flb_incoming *incoming;
> >+      int ret =3D -ENOMEM;
> >+      u32 i;
> >+
> >+      incoming =3D kmalloc_obj(*incoming);
> >+      if (!incoming)
> >+              goto err_restore_free;
> >+
> >+      incoming->ser =3D ser;
> >+      xa_init(&incoming->xa);
> >+
> >+      for (i =3D 0; i < incoming->ser->max_nr_devices; i++) {
> >+              struct pci_dev_ser *dev_ser =3D &incoming->ser->devices[i=
];
> >+              unsigned long key;
> >+
> >+              if (!dev_ser->refcount)
> >+                      continue;
> >+
> >+              key =3D pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
> >+              ret =3D xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL=
);
> >+              if (ret)
> >+                      goto err_xa_destroy;
> >+      }
> >+
> >+      args->obj =3D incoming;
> >       return 0;
> >+
> >+err_xa_destroy:
> >+      xa_destroy(&incoming->xa);
> >+      kfree(incoming);
> >+err_restore_free:
> >+      kho_restore_free(ser);
> >+      return ret;
>
> Hmm.. This is interesting, so the KHO state is freed and it cannot be
> reused. I see you already pointed out that we are putting an LUO policy
> to say that the retry is not allowed.
>
> But what should be the behaviour of liveupdate in this regard? Let the
> system boot in a normal way? This might break other subsystems as they
> might depend on PCIe restoring state properly. Also I think some of the
> PCIe state, like device-id, BAR addresses, ACLs etc, might be used as
> source of truth by other components.
>
> For example, lets say FLB retrieve() of PCIe fails, but succeeds for
> VFIO/IOMMU, now VFIO/IOMMU are restoring state of a device that is not
> restored/preserved?
>
> Should this be considered fatal?

If PCI FLB retrieve fails then there are certain things that cannot be
guaranteed, such as BDF (B specifically) remaining constant. This
could lead to memory corruption as the IOMMU may have live
translations in place for those specific RequesterIDs. And, in the
future, preserved devices may be doing P2P which depends on BARs not
moving. If the PCI core cannot retrieve the FLB saved by the previous
kernel, it cannot make these guarantees.

So yeah I think you're right that PCI core should treat FLB retrieve
as fatal and just panic.

> > }
> >
> > static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> > {
> >-      kho_restore_free(args->obj);
> >+      struct pci_flb_incoming *incoming =3D args->obj;
> >+
> >+      xa_destroy(&incoming->xa);
> >+      kho_restore_free(incoming->ser);
> >+      kfree(incoming);
> > }
> >
> > static struct liveupdate_flb_ops pci_liveupdate_flb_ops =3D {
> >@@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> > }
> > EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> >
> >+static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> >+{
> >+      struct pci_flb_incoming *incoming =3D NULL;
> >+      int ret;
> >+
> >+      ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&incoming);
> >+
> >+      /* Live Update is not enabled. */
> >+      if (ret =3D=3D -EOPNOTSUPP)
> >+              return NULL;
> >+
> >+      /* Live Update is enabled, but there is no incoming FLB data. */
> >+      if (ret =3D=3D -ENODATA)
> >+              return NULL;
> >+
> >+      /*
> >+       * Live Update is enabled and there is incoming FLB data, but non=
e of it
> >+       * matches pci_liveupdate_flb.compatible.
> >+       *
> >+       * This could mean that no PCI FLB data was passed by the previou=
s
> >+       * kernel, but it could also mean the previous kernel used a diff=
erent
> >+       * compatibility string (i.e. a different ABI).
> >+       */
> >+      if (ret =3D=3D -ENOENT) {
> >+              pr_info_once("No incoming FLB matched %s\n", pci_liveupda=
te_flb.compatible);
> >+              return NULL;
> >+      }
> >+
> >+      /*
> >+       * There is incoming FLB data that matches pci_liveupdate_flb.com=
patible
> >+       * but it cannot be retrieved.
> >+       */
> >+      if (ret) {
> >+              WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");
>
> I think this should probably be considered fatal as mentioned above or
> the caller of this function should get an error so it can fail. I think
> retrievel of preserved state should generally not fail unless there is
> memory corruption or ABI is incompatible.

Yeah. I think I will just call panic() here to cover all cases.

> >+              return NULL;
> >+      }
> >+
> >+      return incoming;
> >+}
> >+
>
> [snip]
> >+
> >+static inline bool pci_liveupdate_is_incoming(struct pci_dev *dev)
> >+{
> >+      return false;
> >+}
> > #endif
> >
> > #endif /* LINUX_PCI_LIVEUPDATE_H */
> >--
> >2.54.0.746.g67dd491aae-goog
> >
>
> Sami
