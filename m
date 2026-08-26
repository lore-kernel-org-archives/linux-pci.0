Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA33A5E84
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775405; cv=pass; b=HS4aYCrCf2i6Kg2HQCQ36oU/oG8D/O0hoFwBnnNWy+VHr8JFJ+69ACSL+f3pSfC72NIBW0bFNKTXah5BLlxhg/dKSPG5+JFQEXDNBtaUfF7127WGQqZ/pvXFCnThpRHaGR6rYvWrCbUz8G3/smWyE9YmesGbdKeAteEH3rVpDU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775405; c=relaxed/simple;
	bh=0/7xCDKrWR+mPFvHdaazqCFu2sK+/utgz3T0Bn+mARE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NitTifWljzeh5tWu/7PgZJJfdd9TXH/DgE8uXcBwUQGVEArs3ph8foYSw9tu4N3TeIYBzZjUf9S1qzS5XTQ9O4XLVoDmFB3gOkgGv6+rGQgphxpigntCseacVIL99V2l1rdfpLPHU3lFkNJDg6MOF21I6Sqh5B6sgIYS46P2GLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=bjpOvYnG; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="bjpOvYnG"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-854f9c32c76so6209397b3.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 13:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787775401; cv=none;
        d=google.com; s=arc-20260327;
        b=Ve2W9TZTlgYDC/51pft3ove34c3GsCgbBhonDVY09TXCF5NbZdExm4fFQhKuvyM2d7
         onsrMqWR0IpssG/QNUk/3jhgZ6aBqQRvby0gALKE5vWHaDgd4iYuj922fBBCE6P/wHmb
         2IKcigCEdb3PbyY0WIXpu+vcRZEXm+S4vrtAs9otcds8pelzTMVp/X5BYMTc/HBtetAS
         iqD+HMFKeKxpnf2B1hDC0NBqRVaRo8zt4vfcrX484EMBjyenoZFdGm+b5dHp8knjUeGe
         EKcunGdNGlZa8YRxjqDSCKdN29DkeN2F6xs99s3rVjvOd9kxomye+2NmayIfDEI+ZPc/
         ocgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MoQXIfNzH6ytuVZiisRyn/tXm97WlOfMHt4zXWCzNSw=;
        fh=GWqflLME8bOtYmugkCswD3QMNB5+GyHxzaRmmpmgctE=;
        b=YGeUEiZHdDtvarUmsWxMjsW6yxiVXlyzJ35EWj+8b3+U3HVyhs52xm2M+T+D/0ePfr
         i48R3lYIh/LbDaVfQtWglunZaafIDOPonh3CGUKzIkoLMSWloYHlPeZ0zs/9ADvR2dUY
         BIjSI4Wg9W40xPeYj+vVs+di4dI8bPffWCGBOzTD6fclhM9LaAmzt4G8MWPuOX95xZTf
         6ITvOoZRGqegIV9NDn689mfWT0xErG3Qfxss2mY4jhtsABjcK2ADgA9zuJEEStqF+Inc
         E6b19tVfqY+UXECt+8OciM7P/0BsdDSiKBnuos/7Y2Tqn/ytp5b7FznxYgCnAAauPlXj
         +mqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1787775401; x=1788380201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MoQXIfNzH6ytuVZiisRyn/tXm97WlOfMHt4zXWCzNSw=;
        b=bjpOvYnGiIA/ACRntMqOC+TeIQTPntbxIWQjQ62isp7QLoG/RcBX1kj1hMRKPH9zw9
         u0ffGgTDOTILgL8WhykI2gX8eOrQwqlJlPS4nMXzW0WEVXNAkD5qxlzwDVHmDXyOSTQr
         ynkAo/8c05SlKvKJwuJMTS3Xusu2l99mTNtFmABJfK28wu3ctW0pIZ+rlSI21AeQk9su
         J/bhzNcz0DUFsSIiUR9ZEr3UReVFOAzqQv550u0TJM3GnN+z3a+7t9CSZxwW4ZmOfftk
         Nn4CJTwRWkpYIuTf6PBktzZDIv/dat1DcTN9T1W8IzPhYOAvqxm/Nml+g4jHJdpPD9NA
         cCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775401; x=1788380201;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MoQXIfNzH6ytuVZiisRyn/tXm97WlOfMHt4zXWCzNSw=;
        b=Yyr1+i2CjDfM3QqxSCBqR/giX9ShbxGWTMCp3dFDXwywh/NgUSGgqtmTcXtzRvK+A8
         UQKhK29F527ejEKGrhEIjjDUuIPH/DH2z8YAs6/HFHHZlOj5HrqUFtCPLdHsxenPiOIc
         QywFC9MuS/OM7uaKk4ubGebj1XxRvQCKhHR4Z9ElXNiQjciD9mxXC40NibrB8Y+xFE+U
         9pCaMF0zo+qXYBqbe0G03+KCKj58+XZtdWl9M8GvTR5JBDHr3Hu2l7Pd8GJ2hcaoRXeO
         dtPfy4QLkrUJ390Oq24dmQJmuf+QjWk9aXSk7716xR2AOZ2Q8/Apmrtfpe2X2xCyXjzY
         NQLA==
X-Forwarded-Encrypted: i=1; AHgh+RrfPNI96Es7XrViGBJnJ2mRREYsrfIGaJk1GaMjKy/vCYfkJBzdRBo9IAQ7UMhyCXcM4oFL+L/MQP0=@vger.kernel.org
X-Gm-Message-State: AFuF++m5miWhzziEEe04MkgydjjRzbBLHy8ImifoxZ1mnaCBye4ZxJGv
	Pe/4kNAdDMD01+yTdkq6zCLjb/KGDII1WYrm5eY2dL9fCPLdB9ootEa2+f0GmafeGvCgFLCGgJN
	BC/CRFw4OahZd/sFCbhFjG731QMtGzUhof3CYPEyMcg==
X-Gm-Gg: AR+sD11e+X5/G3rsEQI67IOi2yt+a68Az9tdks7GB+JR9LjQ64BanqLGD5nU8s1OcMt
	qhfViWJ6qYmHBUPRWkzg759dCgYiGoQkO7vVKpI4XkxPhlJQbvvivTMSJOGT/2cm0yWA20h8i4Y
	gTkOd/tQ0u8atgUzZLU50F1P8BJYbNKFlOX9OwddF3K4duoJ5w1oKHy+swHmN+MDf6cjWXK9bEh
	YE3eKa2YfIuoQbWSftAe3cprJVKgUvWzf74f5WqJFne5+8Otsj/WbBf1TlzIpZd7y7sK1w0i79P
	Ofb1VTDVxMBSmsF7dVrF7g1SttFAhIaot3OHAx87mPpIrFvkXH1ampkic67vqHhXjsscoy2m3j1
	s0qf18ipKVg==
X-Received: by 2002:a05:690c:e15c:20b0:825:468e:e0eb with SMTP id
 00721157ae682-85aa1a0750cmr6587537b3.15.1787775401386; Wed, 26 Aug 2026
 13:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-blackhole_quirk-v1-2-fc004672cdbd@oss.tenstorrent.com> <20260826195503.GA1554946@bhelgaas>
In-Reply-To: <20260826195503.GA1554946@bhelgaas>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 26 Aug 2026 15:16:29 -0500
X-Gm-Features: AcwNN1XrWloBzUUZjl91EBwKqKAy0KdvrxrtaK_vn9u1fg3SBOWQBODKTb62OCs
Message-ID: <CAEev2e9HzMt27wWchsQGKuLELVW5hqL4-XK4DuP6XSwS6zmouQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: quirks: Drop unassignable 32 GiB BAR 4 on
 Tenstorrent Blackhole
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joelsmith@tenstorrent.com, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Wed, Aug 26, 2026 at 2:55=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Ilpo]
>
> On Mon, Aug 24, 2026 at 11:57:07AM -0500, Anirudh Srinivasan wrote:
> > Tenstorrent Blackhole cards expose a 32 GiB BAR 4 that is unused by mos=
t
> > software talking to the card. This BAR cannot be assigned on hosts whos=
e
> > PCI aperture is smaller than 32 GiB (e.g some ARM/RISC-V systems). This
> > failure also results in BAR 0 (256 MiB) and 2 (2 MiB) being unassigned
> > because bridge windows are sized as the sum of all enabled child BARs.
> > This makes the card completely unusable on such systems.
> >
> >     spacemit-k1-pcie 80000000.pcie: PCI host bridge to bus 0000:00
> >     pci_bus 0000:00: root bus resource [bus 00-ff]
> >     pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus add=
ress [0x10000-0x10ffff])
> >     pci_bus 0000:00: root bus resource [mem 0x1100110000-0x117fffffff] =
(bus address [0x00110000-0x7fffffff])
> >     pci_bus 0000:00: root bus resource [mem 0x1800000000-0x18ffffffff p=
ref]
> >
> >     <snip>
> >
> >     pci 0000:01:00.0: [1e52:b140] type 00 class 0x120000 PCIe Endpoint
> >     pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x1fffffff 64bit pref]
> >     pci 0000:01:00.0: BAR 2 [mem 0x1120000000-0x11200fffff 64bit pref]
> >     pci 0000:01:00.0: BAR 4 [mem 0xfffffff800000000-0xffffffffffffffff =
64bit pref]
> >
> >     <snip>
> >
> >     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: =
can't assign; no space
> >     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: =
failed to assign
> >     pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: assigned
> >     pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: assigned
> >     pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: releasing
> >     pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: releasing
> >     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: =
can't assign; no space
> >     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: =
failed to assign
> >     pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: assigned
> >     pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: assigned
> >     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: can't as=
sign; no space
> >     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: failed t=
o assign
> >     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: can't ass=
ign; no space
> >     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: failed to=
 assign
> >     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: can't ass=
ign; no space
> >     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: failed to=
 assign
> >     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: can't as=
sign; no space
> >     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: failed t=
o assign
> >     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: can't ass=
ign; no space
> >     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: failed to=
 assign
> >     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: can't ass=
ign; no space
> >     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: failed to=
 assign
> >
> > Add a header fixup that walks the root-bus apertures and drops BAR 4
> > when it is larger than every root-bus aperture. Resource assignment
> > skips resources with zero flags (pdev_resource_assignable()), so the
> > bridge window then sizes to BARs 0/2 and succeeds. This was tested on a
> > Spacemit-K3 RISC-V board that has only 4GiB of BAR space. tt-smi and
> > tt-bh-linux are able to run on the card.
> >
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> >  drivers/pci/quirks.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b09f27f7846fc..df54e379c116b 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6415,3 +6415,35 @@ static void pci_mask_replay_timer_timeout(struct=
 pci_dev *pdev)
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_tim=
er_timeout);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_tim=
er_timeout);
> >  #endif
> > +
> > +/*
> > + * Drop unused 32 GiB BAR 4 on Tenstorrent Blackhole cards so the card=
 is
> > + * usable on systems with smaller host bridge apertures.
> > + */
> > +static void quirk_tenstorrent_blackhole_bar4(struct pci_dev *pdev)
> > +{
> > +     struct resource *res =3D &pdev->resource[4];
> > +     struct pci_bus *bus =3D pdev->bus;
> > +     struct resource *win;
> > +
> > +     if (!(res->flags & IORESOURCE_MEM))
> > +             return;
> > +
> > +     /* Find the root bus; its resource list holds the host apertures =
*/
> > +     while (bus->parent)
> > +             bus =3D bus->parent;
> > +
> > +     pci_bus_for_each_resource(bus, win) {
> > +             if (!win || !(win->flags & IORESOURCE_MEM))
> > +                     continue;
> > +             if (resource_size(res) <=3D resource_size(win))
> > +                     return;
> > +     }
> > +
> > +     pci_info(pdev, "BAR 4 %pR larger than every host bridge aperture,=
 dropping it\n",
> > +              res);
> > +     res->start =3D 0;
> > +     res->end =3D 0;
> > +     res->flags =3D 0;
>
> This seems problematic because the hardware BAR still exists even if
> we zero out res->flags.
>
> This is a problem because pci_enable_device() will successfully enable
> a device and turn on PCI_COMMAND_MEMORY even though the hardware BAR
> may contain junk.  And if a driver ioremaps this BAR, it is
> ioremapping physical address 0, which doesn't end well.
>
> I know this from bitter experience :)
>
> If you have some device-specific way to actually disable the BAR in
> the hardware, that could work.

lspci for this device doesn't show this BAR region. Are you saying
that BAR4 still exists (but points to 0) ? Our driver doesn't seem to
have any issues with this, but some other driver may not play well
with this.

$ lspci -d 1e52: -vvv
0000:01:00.0 Processing accelerators: Tenstorrent Inc Blackhole
        Subsystem: Tenstorrent Inc p150a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at 1800000000 (64-bit, prefetchable) [size=3D512M]
        Region 2: Memory at 1820000000 (64-bit, prefetchable) [size=3D1M]
        Capabilities: <access denied>
        Kernel driver in use: tenstorrent

>
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TENSTORRENT, 0xb140, quirk_tens=
torrent_blackhole_bar4);
> >
> > --
> > 2.43.0
> >
