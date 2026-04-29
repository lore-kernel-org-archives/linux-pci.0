Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1040FDBE
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479690; cv=pass; b=Z4AkK+sbAE8M4Z70ELLfjPLPND7hfXetG6GQe6meXjXIrW2riUbZxZ94irCFvPXJ8PhVDcnXqlHN+G1HLSOL7bycblbgw5Hh1lTHQ670LNufY7o8q+qcZBFunc2LDZK6fkmslHZM0jlB7OZolplh5MqgTH/hAnFhn1h6k6Oiwgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479690; c=relaxed/simple;
	bh=kf23xg9RLUhQr/tA8z9LpXbufKza/+MISzGlgYWrx8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jp8YHeP4g2woIvJBKY+BVQE5Te9YqXsBsXMwpOG7KqPhP0/dqBF6v84BxCA957MPK95InSBfKmv8NEdO2RcqOSBW2aqIkZrH8buLLwICeZ1wCY/LvFVYISBqRgAxnffaDPYjcBqqU98gPyyWZqTu8t3xYBBGT320vk6FD7zzCOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=hLMlD/vp; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="hLMlD/vp"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50faf8ed9c5so55100741cf.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 09:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479678; cv=none;
        d=google.com; s=arc-20240605;
        b=Wcr8FHSxvutq6FYlb2+AylI002Y0KTxOPeckD6tmvcRz0/r2GSxSOkk9m6IR9KfLKb
         wtVfkz30PJy6fdUlkdnfpiN5OvukLaXkbXbAlwyhDJbb+cvMKcuNQ/lEV1GMLYMawE0z
         vX6qGNL2IiwC8PQPHpMKLrPIyv7ORMaPfea7RRdUROUPcPuResvtoODiml8Hmdnij5/e
         HF1rqFLaY18M4bfNe7dUhwssp77DsvTAnSnw1LVd27VNLp0VmR13ENNOpj7mN5kctTvN
         QxRbjRUaXYlByDwp1BOkMBI8T4AcWpOXA7YgUJLzMWLON5RtFDIo6zBdoRzAyBE8ZT56
         eUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RGuZ4SJMokCn8C5Jef4Vuyolecb8c9bvSvvHqufnpwI=;
        fh=ZYGNxh8KP2rH2Q8tFfKWSzEZMz8N1VxYaW4KMQ3HJ9o=;
        b=jse/8NMwEj3XWnhT5kJ76nbhWqCNkdtA/U76/UuoKdYYVhVmaRtDmroQKpjcXSFdhf
         rnpAeHhfjBJqxD66pZfHh6QwR+ZEMtYHrUF7dzUI+/cHS+oCqrvugHlPpa73IfrOu951
         aNkA+J3Rz57zCNuStQw5OmKek/AtcwgOFtF8QIXpfVQdKA4BWgGBdei3kaRHijYovlPY
         bAJaqX7n1Wzt3zfVWGBB+jqV2snVcyJ5E7a+2+ixoRq1d9/uQgkEbyZ9Kl+kiSSpLlZm
         QK9T01WfkQsKxp4gojXAWzuGs2ge91Xm//cgAxyo8QFq91RVA/+X+xJnJO09WiSY3AXg
         1cDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1777479678; x=1778084478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGuZ4SJMokCn8C5Jef4Vuyolecb8c9bvSvvHqufnpwI=;
        b=hLMlD/vp7OBiyIy8RPWSkv9fW5/wWPdJoQEYp8HIAw9uyZVZT6V8xfFrgn//YOhh95
         7hi9a9TEJX6rMzz7Buz52asVc3IxqF3nJ9Db2HhK79JaM3z9rWga4FrROTmOmPZSaK7X
         p9q4HRj3oYu95MfmWB654OPuoCRl1cEYUP5QnullKmVf1EPjoK5ETJWjwiXi0pcmWXBj
         IbDEb943P+a1jfx+4VRpwMpWe7QMDGprE3JcVx+mpC71YU9T0NGecTMtP0SWTFfup3i0
         fbmvgfOh7uhvQVblcsiSREaKs81foc1S8mi/9y6YusdwoYzhMJ/KqJEniOLoP4+2BY4o
         eqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479678; x=1778084478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RGuZ4SJMokCn8C5Jef4Vuyolecb8c9bvSvvHqufnpwI=;
        b=W8WQU+egP9jyzKPzGS/X6LoyzZtdhWtBudnt4SIwmJFbd2cHDAMJgYpM31oCfpk+Zj
         pbp8ckRXyJJNQpNWTuVnmNexL2yUn3M6z4DULsspUowZgoeZ56DOrwBdb+tGG+wg+LU5
         ahqBh4doC99PJOAcV+/y/pO3IWMhX1/US+jRPyccg1IGysfhyUZet8vLiug6xTCme9Zn
         UYam4RwTLcEVtXPWAVe3ja/niA/h0lMPdZrTXlOWdABj4ggp5pqsdL50WKopF8xCh/9f
         Bve3uv/kHpA6c4utqKcInBiyQNmMrU1NXzyLyeTPYdpdSkChK9dl0FfaeHLwQ1bcFB5M
         7Ywg==
X-Forwarded-Encrypted: i=1; AFNElJ/PcJZeFAnahp2QaVKJ3hzkh6Ys+/5HyCJHqrixBhHfGiyEjQW7fsOOHEorNQPxPA4e2CTwHdHwcdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJ5yrNu/rUnadYawRJWn6a3GRnEDnST8cp39xSwqPI/ckfvqi
	OiprbzxLKAZyFKHi6lQ68PUDf4KqZ36TOT7CB9Yz1yR+gT6Cc5sDyAX8+/1rQCrhYQfii0RiaVY
	kaF6d6fOz/jR6UPNfhC3RoFGgYO7+Ybn7H85NXQ/xSIzl8GAHZS3qekr6Ug==
X-Gm-Gg: AeBDievMu1oi+g1L3FwdayuDmVsvNN0LKy43LEPgN8bWYcraLt1UslQeXlb1minkMet
	FvQGKK7GCqJGr0fMrZG5IQbZhAFt+v6rALh3B77k2qR4+FUflehVWE7a/QB/RSSkfvTMbUPYweu
	qyCrQx4hUTwnYWRbQX/E67W98F+hJOWZ9VIWxse63PccAbdwICVmKuEjgETmUnYsh/o2RV1ZCFt
	ctRUIdJ8yIigz7m/EPbXN5d1bCPOF7BW7e1LKNeYoC0dBjv6zy+HHWQ59FcN+4ULk48BAv39JZD
	z6BtM4XEnr7g3so=
X-Received: by 2002:a05:622a:4a12:b0:50e:6054:bc with SMTP id
 d75a77b69052e-51018978cfdmr67334971cf.16.1777479677836; Wed, 29 Apr 2026
 09:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428225146.3104063-1-gloveless@jqluv.com> <21ed8a45-f19f-4a14-9aed-dbe0f545ae27@amd.com>
In-Reply-To: <21ed8a45-f19f-4a14-9aed-dbe0f545ae27@amd.com>
From: Geramy Loveless <gloveless@jqluv.com>
Date: Wed, 29 Apr 2026 09:21:07 -0700
X-Gm-Features: AVHnY4L1rBkzBiYrQqjJpKoZhi9xkiCMvP-Rzsag5p0cpIY7J4jtOWb7m6L_ECc
Message-ID: <CAGpo2meOiExOK=r9y7Jiio0XmJ2vDtE_4NkeCniQ873jEqynyw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: release empty sibling bridge windows during
 window resize
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Cristian Cocos <cristi@ieee.org>, linux-pci@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On 4/29/26 00:51, Geramy Loveless wrote:
> > pbus_reassign_bridge_resources() refuses to release bridge windows that
> > have child resources. On multi-port PCIe switches (e.g. Thunderbolt
> > docks), empty sibling downstream ports hold small reservations that
> > prevent the parent window from being freed and re-sized for rebar.
> >
> > Walk descendants of the target window depth-first, saving and freeing
> > each empty bridge window so the parent can then be released and grown.
> >
> > Without this change, attempts to grow a window deep below a switch
> > fabric leave nested empty windows pinning the ancestor:
> >
> >   pcieport 0000:65:00.0: bridge window [mem 0x8880000000-0x98800fffff
> >     64bit pref]: not released, active children present
> >   pcieport 0000:00:03.2: bridge window [mem 0x8880000000-0x98800fffff
> >     64bit pref]: not released, active children present
> >
> > With the bottom-up walk and upstream ancestry check, the chain unwinds
> > and the rebar succeeds:
> >
> >   pcieport 0000:96:00.0: bridge window [...]: releasing
> >   pcieport 0000:95:00.0: bridge window [...]: releasing
> >   pcieport 0000:94:00.0: bridge window [...]: releasing
> >   pcieport 0000:65:00.0: bridge window [...]: releasing
> >   amdgpu 0000:97:00.0: BAR 0 [mem 0x9000000000-0x97ffffffff 64bit pref]=
:
> >     assigned
>
> That sounds reasonable and I can see the rollback store
>
> But do we make sure that we can allocate all released child resources add=
itional to the resized resource?
I am not sure I will need to investigate to see if the other code in
the kernel follows this path correctly, I would assume it does since
the parent is being released by this code if there was no children, we
are just releasing the children too if applicable essentially.
Thats my thoughts they could be inaccurate though since i'm not
extremely involved in linux kernel code until recently.

>
> E.g. in the above example how is the new size of the bridge window determ=
ined? Does it include the released child resources so that they can be even=
tually be re-allocated when drivers start needing them?

This patch basically releases the children so the system that deals
with allocating and changing window size can actually change it.
So basically the only blocker to window resizing was this patch,
whatever pcie already does in linux basically now can happen with the
children released without further changes.
Does that make sense?

Basically our only job is to make sure to release the children and the
rest of the linux kernel can continue forward and resize the window,
the stopper was the children not getting released essentially.

>
> Regards,
> Christian.
>
> >
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> > ---
> > v3:
> >  - Restructure helper: outer loop only recurses; inner iterates bus
> >    resources via pci_bus_for_each_resource(). The release path is now
> >    unified, so the caller-side block in pbus_reassign_bridge_resources(=
)
> >    is gone.
> >  - Walk the resource tree upstream when checking ancestry of @b_win,
> >    so descendants in nested topologies are also released (Ilpo).
> >  - Drop pci_resource_is_bridge_win() filter; bus resources are
> >    inherently bridge windows.
> >  - Rename pci_bus_release_empty_bridge_resources() to
> >    pbus_release_empty_bridge_resources().
> >  - Drop misleading "Uses PCI bus/device iterators..." paragraph from
> >    commit message.
> >  - Kerneldoc tweaks per Ilpo's review.
> >
> > v2:
> >  - Use PCI bus/device iterators instead of walking raw resource tree.
> >  - Save released resources to rollback list.
> >  - Filter via pci_resource_is_bridge_win() (now removed in v3).
> >  - Call release before the !res->child check.
> >  - Check bridge->subordinate before recursion.
> > ---
> >  drivers/pci/setup-bus.c | 63 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 61 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 4cf120ebe5a..0c1fb654c9c 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -2292,6 +2292,60 @@ void pci_assign_unassigned_bridge_resources(stru=
ct pci_dev *bridge)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> >
> > +/*
> > + * pci_bus_release_empty_bridge_resources - Bottom-up release of bridg=
e
> > + * window resources in empty subtrees.
> > + * @bus: PCI bus whose child bridges to process
> > + * @b_win: Ancestor bridge window; only children of this resource are =
released
> > + * @saved: List to save released resources for rollback
> > + *
> > + * Recurses depth-first into subordinate buses, then releases bridge w=
indows
> > + * on the way back up.  Each resource is individually saved before rel=
ease so
> > + * the entire operation can be rolled back.
> > + */
> > +static void pci_bus_release_empty_bridge_resources(struct pci_bus *bus=
,
> > +                                                struct resource *b_win=
,
> > +                                                struct list_head *save=
d)
> > +{
> > +     struct pci_dev *dev;
> > +
> > +     list_for_each_entry(dev, &bus->devices, bus_list) {
> > +             struct resource *r;
> > +             unsigned int i;
> > +
> > +             if (!dev->subordinate)
> > +                     continue;
> > +
> > +             /* Recurse first =E2=80=94 release deepest resources befo=
re parents */
> > +             pci_bus_release_empty_bridge_resources(dev->subordinate,
> > +                                                   b_win, saved);
> > +
> > +             pci_dev_for_each_resource(dev, r, i) {
> > +                     if (!pci_resource_is_bridge_win(i))
> > +                             continue;
> > +
> > +                     if (!resource_assigned(r))
> > +                             continue;
> > +
> > +                     if (r->parent !=3D b_win)
> > +                             continue;
> > +
> > +                     if (r->child) {
> > +                             const char *res_name =3D pci_resource_nam=
e(dev, i);
> > +
> > +                             pci_info(dev, "%s %pR: not released, chil=
dren still present\n",
> > +                                      res_name, r);
> > +                             continue;
> > +                     }
> > +
> > +                     if (pci_dev_res_add_to_list(saved, dev, r, 0, 0))
> > +                             continue;
> > +
> > +                     pci_release_resource(dev, i);
> > +             }
> > +     }
> > +}
> > +
> >  /*
> >   * Walk to the root bus, find the bridge window relevant for @res and
> >   * release it when possible. If the bridge window contains assigned
> > @@ -2316,7 +2370,12 @@ static int pbus_reassign_bridge_resources(struct=
 pci_bus *bus, struct resource *
> >
> >               i =3D pci_resource_num(bridge, res);
> >
> > -             /* Ignore BARs which are still in use */
> > +             /* Release empty sibling bridge windows bottom-up */
> > +             if (bridge->subordinate)
> > +                     pci_bus_release_empty_bridge_resources(
> > +                             bridge->subordinate, res, saved);
> > +
> > +             /* Ignore bridge windows which are still in use */
> >               if (!res->child) {
> >                       ret =3D pci_dev_res_add_to_list(saved, bridge, re=
s, 0, 0);
> >                       if (ret)
> > @@ -2327,7 +2386,7 @@ static int pbus_reassign_bridge_resources(struct =
pci_bus *bus, struct resource *
> >                       const char *res_name =3D pci_resource_name(bridge=
, i);
> >
> >                       pci_warn(bridge,
> > -                              "%s %pR: was not released (still contain=
s assigned resources)\n",
> > +                              "%s %pR: not released, active children p=
resent\n",
> >                                res_name, res);
> >               }
> >
>
