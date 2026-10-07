Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAD46F4A0
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365022; cv=pass; b=gjbEFWeaMXdbvQThzGvrUr7pk8nHRoDqnZ9cDVGPyYR2k1yLO+rhflaOe7Zt6z245NaRS3jo5dZZYUAWeg1kU0ZMBnesLVGJu53kFkUWSp6MnZChKowKQWxRCB5eufGNJE6Dwcs1qC5CyH+K2wKc+H6KV/YmRDndnxe+Ja5HUyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365022; c=relaxed/simple;
	bh=SLbcq0/SQ1SX34iuBLlcNz/R/rQiFViO9wgzi9sfnTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHNPJYczSQ3/gp8VFLWeL8p++YcdTNjFRwg0CCYMMW4fLL5Qb/WM/g3CS7s8SvVc1UsA6zMk4mXs4qs6mE0dipZ5weMs+8j9qJipB59nDSvywHWOv5F30OsjENa2NuAx0M97dF5GmE3Jp6Z0ngN+25Z/lU3kYZq9rQ8/WQyn314=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnSfEfD6; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnSfEfD6"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2e26719a0fso144356366b.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2026 02:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791364849; cv=none;
        d=google.com; s=arc-20260327;
        b=Fi85EQHzX6Ap7Rw0FP4+s86RQK5feh4U+X9zUKpqxveBuO2vh9ckk8wlJoSr11pKXr
         +Z2kiVkghTANzMXWnndaVrTLKHeD7dKWTA3JbqugByyRf/EUUR2lGVkXnltaJJtJbhAv
         gigpvU2CekC+FDYHp1Oc7U8s9X7014BNjAHmdNHOSy8g9OPjzES1EZDkAeNjm6upIla/
         cu2Qz3CWZ0/kgjbxYL8Ie/0fjFzBxyM8EELZ4jvudi9fbFFA1gBC6ur2Hb2EpP0CHjga
         7DTLBFQ8ENzPpwgdqsU2fJyFAHHs9QTqYECD3oTGOYhYqlgqRg21OZ/jG3aJ8j/aYDOv
         7ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UdaN2NeMzE/Rao2EARyiWDkHNBqdlWxbGIw0jAWrMrE=;
        fh=cDmFRg6H2pwtQIIjPEgqH1c7ViwROi8+0MOxeNauHkY=;
        b=HEOz1ZXG0Q9GeuPW9DPlelRWE0YLRzp6DaUH2YO3Aym4/GZNOR9wCWmhlD2rNpMtcz
         L4T5G4XK+gwBr9fEm49zPjTMRUF4dH5vmRNQK9RlE2MP6MqWfQkhT0zzhCOG7nVUIveq
         6ntlxLPDym42fAlbzuSwMqK4lIHR6mSJ54gJpezxAq3gcxHLbhYuimLYztnUVT2TTF35
         9bNFU/NBdz5I9zu06l9bl9B5ackKTGOobApvTIpNp0lYwa+vOJ5G9D8UlOW7JvaJValL
         jPkJGv8tu5kTXAzpmLne0H6PbWa+4aQybmbDIeY9VsM0gLvCklc6L4sa71RUV4Ynlyh7
         yn5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791364849; x=1791969649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UdaN2NeMzE/Rao2EARyiWDkHNBqdlWxbGIw0jAWrMrE=;
        b=gnSfEfD6yGVJRHHIR9KR9rpGbUY1tF5q+5tURlvVLOjpzFJ/jQA7LIoKOnzJWoyvfj
         RQJyyGpP5tNndia6gKbSwswrV4F6f02OS0mIIiYpeWvPqklW3pSVg8nHRPeZWcBS+fxI
         aVWZKNbIXE6nR3IzjF5cMuVAm+7kOpBmxVjQG9J6PkXtMOnlgwfDGv8M5O+bDvVcpHbd
         je+TyLDbbdw0gIgvtXv7MGt5tzPVC1Ef7ml5E/Rp/bVM0zCwMhleOpysK1u+JfIHuAI+
         HxEGeUfLqdTejDWy7ETHkij7ktaM+N+6IM7GeFy8bkWyz6mI1mwrnybEDpgXgNT6XMmI
         OZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791364849; x=1791969649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdaN2NeMzE/Rao2EARyiWDkHNBqdlWxbGIw0jAWrMrE=;
        b=r3M+3rKWfE99O2fSgacL1s8j9onqUQ7pMdGDqkt6om0qpZSilb4SOlG4/Fr2gktLmi
         vQOXfsfe1NnYs7iJx/urLQPMOSD/gF9xn+yBYw+O7cU4S399C2nBWWm+IfY0AxaSMxZD
         gae+HmWcT4d2NPefmdTcrb1DLUt1zyR55dn26su7XW4WMmuYVroJ6tmAcfzHfZ9sLj8R
         KWL3GjAg9t08jbH/HXMgNcLc14VpBkEHcW/Ou+mcOCYSWbWkVo5ehdSUAH/Q5RfW8pU9
         mY0V94DXo79fw5ImjtS/CX2eafAwiRdgtzzGTgD1bV6vJZmJAay5AxZiFSzWkYiOsQhL
         OJ1w==
X-Forwarded-Encrypted: i=1; AKwUvBz6BlXbR/QX7OwxzNsuYmXa7PHTatFQc0wZW6Es+0Aj/nHWjyBVDrq0MvjXArp2sgZWa2LZUNrJMuU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxghU52TKMwVCk8S7FQpLFI3LCoOw21sozRccCQonRVV3XYnm3
	5OZ+4J6/HqFGgkLy2DOqNCHw0KuDmLn/IqwXc+VEipeo8bGSWHY9Nx/ee9MT8b6KOu6PzGwb0ot
	tcwDvOJztbho5M1JYJWDZxSHhWa19kglIHRuLyj7P
X-Gm-Gg: AYBFou0kuguZCxvFn4j+JqryxU6nokJSZWcp/Npubc0QIE6LcstplwqM/eOmbGKv80d
	3e4pRSq1eM5M9uU/uN82GiEC7MqfBKK6gEMTs2+KNJbmqT153LQZG6IVuAv32ycwcQ++4cVS8m+
	CgVM8TBFOfRT2oMb0+GQwqOoI5anHoWckzdMaSOxuh//7p81DAoOmqX1+R+kKQjVPq/ZnOhxF03
	yyJEZt8OmE72ssnI1rETejl+cTs5jvHybRk7iignYVXkDBHxBL5U/JbV7OFvM38loDxwgqJpT2r
	CS+qsADvok7Gtq2HcQ0YTQF5zvsCWDe+cqmrtQMdqYe8IA2r5k9w6zE=
X-Received: by 2002:a17:907:1c84:b0:c2e:4705:467c with SMTP id
 a640c23a62f3a-c317bd450f0mr150496666b.10.1791364848404; Wed, 07 Oct 2026
 02:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com> <20260918200640.887030-9-dmatlack@google.com>
 <20260918191846.2f68b23b@shazbot.org> <arGVMaxfwEw_PkXy@google.com>
In-Reply-To: <arGVMaxfwEw_PkXy@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 7 Oct 2026 02:20:16 -0700
X-Gm-Features: AclHuK_PI8zGCsZyvrqP1bU2CJDBBfSkmQGW03sa119GkyMLIb-ErHKkHiE7tWM
Message-ID: <CALzav=eTrH4WNPYNWAwmYSEw_imOXwRqf9y7zPDmC27dVE0zBw@mail.gmail.com>
Subject: Re: [PATCH v9 08/13] PCI: Save and restore the ACS Control register
To: Alex Williamson <alex@shazbot.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 1:36=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-09-18 07:18 PM, Alex Williamson wrote:
> > On Fri, 18 Sep 2026 20:06:34 +0000
> > David Matlack <dmatlack@google.com> wrote:
> >
> > > Save the ACS Control register in pci_save_state() and write it back
> > > in pci_restore_state(), instead of recomputing the ACS controls from
> > > scratch with pci_enable_acs().
> > >
> > > This makes ACS symmetric with the rest of a device's saved state. Tod=
ay
> > > pci_save_state() ignores ACS entirely and pci_restore_state() re-enab=
les
> > > the ACS controls from the kernel's current ACS policy. As a result, a
> > > device can come out of a reset with different ACS controls than it we=
nt
> > > in with, e.g. any controls programmed outside of pci_enable_acs() are
> > > silently dropped.
> >
> > Controls, yes, but if we're restoring controls that might have EC set
> > now, should the Egress Control Vector also be part of the save state?
> >
> > Currently EC always gets cleared on reset and won't be restored by
> > pci_enable_acs(), so we can lose both EC and the EC vector.  With this,
> > I think we restore EC but still lose the EC vector.  Thanks,
>
> The kernel does not enable Egress Control today or program the vector.
> Would this be to cover the case where firmware or userspace enabled it?
>
> Here is an updated patch to save/restore the vector, but I don't have
> any devices that support Egress Control on my normal testing system so I
> haven't been able to really test it yet.

Hey Alex, gentle ping on this.

This series is merged into the liveupdate tree to get linux-next
exposure ahead of 7.4 merge window. If this patch needs a respin or a
fixup I'd like to get the ball rolling on that.

I think the 3 options are:

1. Keep the patch as is based on the understanding that the kernel
does not enable EC today or program the vector.
2. Save/restore the EC vector (the below patch).
3. Clear EC on restore to preserve the current behavior.

And if we decide to do (2) or (3) then that could be done with a
respin of the patch ahead of the merge window, or a fixup patch on top
to send in a later rc.

Thanks!


>
> From: David Matlack <dmatlack@google.com>
> Date: Fri, 11 Sep 2026 20:05:04 +0000
> Subject: [PATCH] PCI: Save and restore the ACS Control register and Egres=
s
>  Control Vector
>
> Save the ACS Control register and the ACS Egress Control Vector in
> pci_save_state() and write them back in pci_restore_state(), instead of
> recomputing the ACS controls from scratch with pci_enable_acs().
>
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
>
> Notably, this prepares the kernel to be able to adopt the ACS controls
> established by a previous kernel across a Live Update rather than
> assigning new ones through pci_enable_acs().
>
> Save and restore the Egress Control Vector as well to keep it in sync
> with the now-properly-restored Egress Control Enable bit in the ACS
> control register. The kernel never enables Egress Controls or programs
> the vector, but the firmware could have and they need to be kept in sync
> to avoid changing how P2P traffic is rounted.
>
> The size of the Egress Control Vector is not known when
> pci_allocate_cap_save_buffers() runs, as the ACS Capability register is
> only read later, in pci_acs_init(). Rather than move the allocation,
> size the save buffer for the largest vector a device can implement,
> which costs at most 32 bytes per ACS-capable device.
>
> pci_enable_acs() runs when a driver binds to a device
> (pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
> the device's state. Refresh the saved ACS state there as well, otherwise
> a subsequent reset would revert ACS back to the configuration left
> behind by firmware.
>
> Devices that rely on device-specific quirks to enable an ACS equivalent
> keep that configuration outside of the ACS Control register, so keep
> configuring ACS from scratch for them. Do the same for devices that have
> no saved ACS state at all.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/pci.c             | 117 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.h             |   5 ++
>  drivers/pci/quirks.c          |   7 ++
>  include/uapi/linux/pci_regs.h |   1 +
>  4 files changed, 129 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..e1c05866e2ee 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1021,6 +1021,106 @@ static void pci_std_enable_acs(struct pci_dev *de=
v, struct pci_acs *caps)
>                 caps->ctrl |=3D (dev->acs_capabilities & PCI_ACS_TB);
>  }
>
> +/*
> + * Layout of the ACS save buffer. @ecv holds the ACS Egress Control Vect=
or and
> + * is sized for the largest vector a device can implement.
> + */
> +struct pci_acs_saved_state {
> +       u16 ctrl;
> +       u32 ecv[8];
> +};
> +
> +/*
> + * Return the size in bytes of the ACS Egress Control Vector, or 0 if th=
e
> + * device does not implement P2P Egress Control.
> + */
> +static unsigned int pci_acs_ecv_size(struct pci_dev *dev)
> +{
> +       unsigned int bits;
> +
> +       if (!dev->acs_cap || !(dev->acs_capabilities & PCI_ACS_EC))
> +               return 0;
> +
> +       /* An Egress Control Vector Size of 0 means 256 bits */
> +       bits =3D FIELD_GET(PCI_ACS_EGRESS_BITS_MASK, dev->acs_capabilitie=
s);
> +       if (!bits)
> +               bits =3D 256;
> +
> +       /* The vector is implemented as a series of DWORD registers */
> +       return round_up(bits, 32) / 8;
> +}
> +
> +/**
> + * pci_save_acs_state - save the ACS Control register and Egress Control=
 Vector
> + * @dev: the PCI device
> + *
> + * Record the ACS configuration currently programmed in hardware so that
> + * pci_restore_acs_state() can reapply it after a reset.
> + */
> +static void pci_save_acs_state(struct pci_dev *dev)
> +{
> +       struct pci_cap_saved_state *save_state;
> +       struct pci_acs_saved_state *acs;
> +       unsigned int i, dwords;
> +
> +       if (!dev->acs_cap)
> +               return;
> +
> +       save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
> +       if (!save_state)
> +               return;
> +
> +       acs =3D (struct pci_acs_saved_state *)save_state->cap.data;
> +
> +       pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &acs->ctrl=
);
> +
> +       dwords =3D pci_acs_ecv_size(dev) / sizeof(u32);
> +       for (i =3D 0; i < dwords; i++)
> +               pci_read_config_dword(dev, dev->acs_cap + PCI_ACS_EGRESS_=
CTL_V +
> +                                     i * sizeof(u32), &acs->ecv[i]);
> +}
> +
> +/**
> + * pci_restore_acs_state - restore the ACS Control register and Egress C=
ontrol
> + *                        Vector
> + * @dev: the PCI device
> + */
> +static void pci_restore_acs_state(struct pci_dev *dev)
> +{
> +       struct pci_cap_saved_state *save_state =3D NULL;
> +       struct pci_acs_saved_state *acs;
> +       unsigned int i, dwords;
> +
> +       if (dev->acs_cap && !pci_need_dev_specific_enable_acs(dev))
> +               save_state =3D pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID=
_ACS);
> +
> +       /*
> +        * Devices that rely on device-specific quirks to enable an ACS
> +        * equivalent keep that configuration outside of the ACS Control
> +        * register, so there is nothing useful to restore for them. Conf=
igure
> +        * ACS from scratch instead, which also covers devices that have =
no
> +        * saved ACS state at all.
> +        */
> +       if (!save_state) {
> +               pci_enable_acs(dev);
> +               return;
> +       }
> +
> +       acs =3D (struct pci_acs_saved_state *)save_state->cap.data;
> +
> +       /*
> +        * Restore the Egress Control Vector before the ACS Control regis=
ter.
> +        * The vector resets to zero, so enabling P2P Egress Control firs=
t
> +        * would briefly apply the reset vector instead of the saved one.
> +        */
> +       dwords =3D pci_acs_ecv_size(dev) / sizeof(u32);
> +       for (i =3D 0; i < dwords; i++)
> +               pci_write_config_dword(dev, dev->acs_cap + PCI_ACS_EGRESS=
_CTL_V +
> +                                      i * sizeof(u32), acs->ecv[i]);
> +
> +       pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, acs->ctrl=
);
> +}
> +
>  /**
>   * pci_enable_acs - enable ACS if hardware support it
>   * @dev: the PCI device
> @@ -1057,6 +1157,15 @@ void pci_enable_acs(struct pci_dev *dev)
>         __pci_config_acs(dev, &caps, config_acs_param, 0, 0);
>
>         pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
> +
> +       /*
> +        * pci_enable_acs() runs when a driver binds to the device, i.e. =
after
> +        * pci_bus_add_device() has already saved the device's state. Ref=
resh
> +        * the saved ACS state so that a subsequent reset restores the
> +        * configuration programmed here rather than the one left behind =
by
> +        * firmware.
> +        */
> +       pci_save_acs_state(dev);
>  }
>
>  /**
> @@ -1800,6 +1909,7 @@ int pci_save_state(struct pci_dev *dev)
>         pci_save_aer_state(dev);
>         pci_save_ptm_state(dev);
>         pci_save_tph_state(dev);
> +       pci_save_acs_state(dev);
>         return pci_save_vc_state(dev);
>  }
>  EXPORT_SYMBOL(pci_save_state);
> @@ -1877,7 +1987,7 @@ void pci_restore_state(struct pci_dev *dev)
>         pci_restore_msi_state(dev);
>
>         /* Restore ACS and IOV configuration state */
> -       pci_enable_acs(dev);
> +       pci_restore_acs_state(dev);
>         pci_restore_iov_state(dev);
>
>         dev->state_saved =3D false;
> @@ -3532,6 +3642,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev =
*dev)
>         if (error)
>                 pci_err(dev, "unable to allocate suspend buffer for LTR\n=
");
>
> +       error =3D pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS,
> +                                           sizeof(struct pci_acs_saved_s=
tate));
> +       if (error)
> +               pci_err(dev, "unable to allocate suspend buffer for ACS\n=
");
> +
>         pci_allocate_vc_save_buffers(dev);
>  }
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..037c1674f164 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1095,6 +1095,7 @@ void pci_acs_init(struct pci_dev *dev);
>  void pci_enable_acs(struct pci_dev *dev);
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
> +bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
>  void pci_disable_broken_acs_cap(struct pci_dev *pdev);
> @@ -1105,6 +1106,10 @@ static inline int pci_dev_specific_acs_enabled(str=
uct pci_dev *dev,
>  {
>         return -ENOTTY;
>  }
> +static inline bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
> +{
> +       return false;
> +}
>  static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
>  {
>         return -ENOTTY;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7aee30734303..e500c202d2ec 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5476,6 +5476,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_o=
ps_get(struct pci_dev *dev)
>         return NULL;
>  }
>
> +bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
> +{
> +       const struct pci_dev_acs_ops *p =3D pci_dev_acs_ops_get(dev);
> +
> +       return p && p->enable_acs;
> +}
> +
>  int pci_dev_specific_enable_acs(struct pci_dev *dev)
>  {
>         const struct pci_dev_acs_ops *p =3D pci_dev_acs_ops_get(dev);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index facaa324bd86..66359cb94f0d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1023,6 +1023,7 @@
>  #define  PCI_ACS_UF            0x0010  /* Upstream Forwarding */
>  #define  PCI_ACS_EC            0x0020  /* P2P Egress Control */
>  #define  PCI_ACS_DT            0x0040  /* Direct Translated P2P */
> +#define  PCI_ACS_EGRESS_BITS_MASK 0xff00 /* Egress Control Vector Size *=
/
>  #define PCI_ACS_EGRESS_BITS    0x05    /* ACS Egress Control Vector Size=
 */
>  #define PCI_ACS_CTRL           0x06    /* ACS Control Register */
>  #define PCI_ACS_EGRESS_CTL_V   0x08    /* ACS Egress Control Vector */
