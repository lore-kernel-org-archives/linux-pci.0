Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDF494806
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045146; cv=pass; b=dr29ICB5maxI0GNcWL3FTr0dM5ku/hW5V5+qw3Xmlu2ZFJrVlG3TQ+d4wOlrEdwr3+66PGsE/rjvh4TThlDzQleVjLoIWMmGMWUb75LNwxQF9yF1mkhcVATyFkP2vMhNxEt/gajasrlFtMdXIRlbdq0Euio6Vx4gLf49rs2eS4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045146; c=relaxed/simple;
	bh=pZsRu4bih/fOebs02+cyeryB8ah9q5y2Gx6ty4QhO3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMsVjLwHh6X8lbe/lVIFeaukmP2jlZVvb/i4LjMS6b5Alqi649IYPoQZgsSDZvpsPxKoaN1KFnZumHODnxqdLXYVVhywsXrtkVECjimKp0uUMEyr9utzsB6kx5FTTymIM5TxpUIR4rIMIzSlHwCG09d/OyTzze1S9BAolezSc2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFj3N+Yw; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFj3N+Yw"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5283e3eff60so16319641cf.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 12:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786045144; cv=none;
        d=google.com; s=arc-20260327;
        b=LaSRBLf0QAh3NIBb/S+TI6R5PzsRhcU2A4DhckNE5u9/ca8vJaQfgj6/eFW2LFWJou
         eN+ZYbdegnz/10VL1ydwKlXX0PZs1myfuxNdG+GY7HiL8Vl5oXfcA580J8u5d9DeaqT4
         kieTEYwY5jPOn7RBDaPojwv5zq7YWxyhEhtf287LkNUOiJrY71ur/Sh6SxJ5kzkarsy5
         YC2Y4Ub3jgkZbyL1eixBXIagp0DfX6frKplTCQwPcVJjq7eC6MoymxTKsYq9RmUw8gzU
         RNNP3NHp+R3UAHtoJdLD2EqzbV30awQgi3uJtdlzH2uhHsz5Q0d9rrzpJR5px5DWq+XU
         twBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NNryo2myA6o1ZLmEL9pxSp2a/VR8Nun1pZv4kg1nG/o=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=W2ZEv+bcT9m5INjcrHwYFdV/zOprjk0WaHEpjVZiswrOuFMKPnnu5BtQXEBWH7naeC
         9zAs+9aoOgDW0YCwgyitXExHIaoe4X2u/aKIfiVX/SkIu8LWW/haJW3EBQ1SiaMXxOqv
         sM4v7Y3zFYdCcAfbCg8QeUgssS5THjmx4AMTV8jzkjwpua2b8MkzgsZ9WHSkiVvqT/19
         0SjBZVTxYSOf+tUG4g961sgL6VMH9hVlIM3VV/ND/dB/z3FtNigipGUDY3HBBw8p6lNG
         Yz3AajgRHZSbe5SlzVOpqzIjJjH0LG96V4OTkUbRKHd3oZ3ubXkNNGlIgIn2ZaJVWg+x
         vhXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786045144; x=1786649944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NNryo2myA6o1ZLmEL9pxSp2a/VR8Nun1pZv4kg1nG/o=;
        b=tFj3N+YwAX0Yk92lnJCETVEW5StxB7U69+YhkaOKPYacauduJt7d9+OlfDz2j+vpfD
         SMmqqdurcv+btLYWK7W4NvlGkIMdUV1YC+FLgIaWfUXHdJwbxgnTW426MZaIZHgSBCT8
         JxQHOtmnfa4CapWS/wwlwSKSIKNsYmZfCTOQCSDW/aTGovRSupW+8oYHc5tauJCuCSXr
         gkyg0Mrrs618CJt6qwubvT0lWBU+Zh/JsX/cj/J2LOGE32Yerhi2d2SQ6QMmqvRZCYb9
         4HvqoIOox5ow53x7rRfAK/kOR/4m5h/bUu74Aw5UhEMNFJyWptUgc+MfjRF7tutblBuG
         cRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045144; x=1786649944;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNryo2myA6o1ZLmEL9pxSp2a/VR8Nun1pZv4kg1nG/o=;
        b=SIyBHAuTPeb/MN9qA2NBHrdyZ7+E6YGCQabXZechVxOUVi0+9aFbfEuMROIz8l86f0
         W0l8XWMB6jYEBepw1bIxH01e3yD3i65Reuhe7evcSJXe1OWIV5gPMN8L/5Cg3XH4z1e1
         N0qhjgJZ88KuRfiZ5qd+/vszt3RpVS6/2C6QQmFFFUD8FIYnT0Jg06Xz5vSl2QmzK54s
         ga6xb4OUaijmGRC65GwX08hpAN3EayJCDSTB/vk+As8jNkNevvSUIpb1CzqkGzkiv01l
         HblmnXSlbXoLPORLWE8Wxf017uGWOqVxlHmQTTnyv156wqFcLrVY8ZnL173P63ujG39Q
         3dhw==
X-Gm-Message-State: AOJu0Ywg3ulGpbZ8wljllJRhJ7tgnswXocExfxz0nH92H8x2gL8yIYwn
	6miYHsPCq4JRUoBCfqndiXllKpKmCRSaYKPpYy0gCouTcOIjd82lB3eNqX5tnx9dcUMumspqNio
	Mso4PidW3hokvRNH+MTqYHfjOaoyOpuUa2riLNhQ=
X-Gm-Gg: AR+sD12pkv2ybT/IL37/Tz6Cu9nM89zJzc9TVmzeOeLpDBMKYLhpWOxtbvl+8kd3q2W
	OYcc1zbs2Ibn+tI3PIRRNOodqj30apMz+mE5VtActsArE4U8w7WP/54BKgZsYTQrDmlR9bL7iIm
	ded0RP9+lJzJRc5XJUc4VnK8rn9M8XPgtireM/QnKj2+SXaHTTN97GTKTCpWVDyZhzdWPEImLHV
	V38SMzbZNE5HQIsBz9jKjPq9BN0cMnfCGoA1wP8zqb+O8q8H2LD1Z2yv3QYmIB8On0gcDfE/haG
	qk5tCUgkkwixfYGYqcJp+9/iH9FKpAl1APDnYDjxQhvmMA==
X-Received: by 2002:a05:622a:411:b0:51c:e14:87a7 with SMTP id
 d75a77b69052e-52ce60e900cmr177493651cf.28.1786045144090; Thu, 06 Aug 2026
 12:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806190439.12022-1-derekjohn.clark@gmail.com> <20260806191942.39B691F000E9@smtp.kernel.org>
In-Reply-To: <20260806191942.39B691F000E9@smtp.kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 6 Aug 2026 12:38:52 -0700
X-Gm-Features: AUfX_mz1my3wgtPNVK9lIPUcA32hoZSI-uH2kaE1mQFxmSM0blLQR-HhSyV2W4A
Message-ID: <CAFqHKTk47MvjVvijt_JKH53pMmaNMWSGvU9QkTuj6zJ7XHhnXQ@mail.gmail.com>
Subject: Re: [PATCH] pci: quirks: Disable native PCIe hotplug on MSI Claw A8
 root bridge
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The quirk disables native PCIe hotplug on the shared host bridge=
 rather than specifically for the target root port, which breaks hotplug fu=
nctionality for dynamically enumerated Thunderbolt/USB4 devices system-wide=
.
> --
>
> --- Patch [1]: [PATCH] pci: quirks: Disable native PCIe hotplug on MSI Cl=
aw A8 root bridge ---
> commit 841400e3b6d906dff0f94738835128127178d2e6
> Author: Derek J. Clark <derekjohn.clark@gmail.com>
>
> pci: quirks: Disable native PCIe hotplug on MSI Claw A8 root bridge
>
> This commit adds a quirk for the MSI Claw A8 to prevent s2idle resume fai=
lures
> caused by the Realtek card reader. It disables native PCIe hotplug on the=
 host
> bridge when the specific root port is found.
>
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
>
> [ ... ]
>
> > +static void quirk_claw_a8_no_native_hotplug(struct pci_dev *pdev)
> > +{
> > +     struct pci_host_bridge *bridge;
> > +
> > +     if (!dmi_match(DMI_BOARD_NAME, "MS-1T8K"))
> > +             return;
> > +
> > +     if (pdev->bus->number !=3D 0 ||
> > +         PCI_SLOT(pdev->devfn) !=3D 2 ||
> > +         PCI_FUNC(pdev->devfn) !=3D 2)
> > +             return;
> > +
> > +     bridge =3D pci_find_host_bridge(pdev->bus);
> > +     if (!bridge)
> > +             return;
> > +     dev_info(&pdev->dev, "disabling native PCIe hotplug\n");
> > +     bridge->native_pcie_hotplug =3D false;
>
> [Severity: High]
> Does setting bridge->native_pcie_hotplug =3D false here break hotplug
> functionality for dynamically enumerated Thunderbolt/USB4 devices on this
> system?
>
> Because the pci_host_bridge is a shared structure, modifying it globally
> prevents the pciehp driver from claiming any hotplug-capable PCIe port un=
der
> that domain. While this might be the only fixed slot reporting HotPlug+ d=
uring
> boot, downstream ports on dynamically hot-plugged PCIe switches (like
> Thunderbolt docks, eGPUs, or NVMe enclosures) rely on the host bridge's n=
ative
> hotplug capability to function.
>
> Would it be safer to clear pdev->is_pciehp and pdev->is_hotplug_bridge on=
 the
> specific root port instead of modifying the shared host bridge?
>

Hi robot, and any humans reading this,

This identified something I missed when scoping the patch. The two USB
ports on top of the unit are USB4/TB capable and are affected by the
root bridge quirk. In a previous version of the patch I did try
pdev->is_hotplug_bridge =3D false to no effect, but was not aware of
pdev->is_pciehp. I will try with both and see if that resolves it at
the lower scope.

Thanks,
Derek

> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x150b,
> > +                      quirk_claw_a8_no_native_hotplug);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806190439.12=
022-1-derekjohn.clark@gmail.com?part=3D1
