Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002733F59E
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100609; cv=pass; b=X5joxJrIJLgZW0ozzubKX4J0PNp5fCFrT5dN8A1YIR8IFyAkCRi2xQGf+7qr5GZAMgrW23h1uduiUS5oQ3lZRuUSZAyNI3e5YSaRmqgHPM4pmGvx0/NigMYNUr8rrFlYR6wOxWzXXv0jg3gP4Opz+O61mgPZrWTpMx0+UDgK/gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100609; c=relaxed/simple;
	bh=qTjK1Gm4tWXhok6bo9Pd2P3GYmg6QZcGyTkBA79G+r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVCBfhVFtIUVWDotw9EScK73+95QN+UFi/RoboXgQWtdtOhCYDVdH7echsAW9vhuVNRaclik2MrP2y8VYD9yh2L21YnclldVYNzczCqDjKiALgtzaztxTqMcMnIONi2StEfQIs/XGR205g+KBaHTAS989Ak5EgsqI10EjIpcCyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZSQwd6Vw; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZSQwd6Vw"
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 950173F167
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 03:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782100262;
	bh=dSGgikQvu7j45PvDbVQYuK05bU8Ts7pfKIgYWDP3ec0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ZSQwd6VwjwrURoSMt4PRRkMxtH4hvvj7w08kyIpjIzZoW5PpI/SuIywlDBvCPTyGW
	 2Vfu/YXT+1Wp8HjGZFFtcogONNlgDFML/CFWC9spndmhLkLnl0LLZTS5YI2GJImWCX
	 FYCRBgoYDV4ztSIiCpmjmzwiFFTXv4wQxNCMW/zPExa87dSyjY+wfxKtlwt0P52h35
	 q92tg9vutQL56gD1nOD0CuGlTY9KWlbkeu19POmJGW6TU5Q5ST3R0eW2EDR2cnBa/J
	 6WIbDSaFmQ2uQqS7vFHe/w3DO90/a7w2tHtJUgimcLFGFl3ZOQ1vvvgk5FMTOHOFtB
	 AZ+RXqt6ai0wQ87OwAz3J08xpdZe3kF2JRTDaw4JuqdeHCPcYIegXKSEEwuoFEQYwJ
	 /F4xtJQrrGgFLuiLlFS/Cgw228ARqCJ5pn+6MLe6IXdyp6qrWxNhDclwPGIsoJz9Vr
	 waY379VqmWA9616Eu1DR2snPC28UPhWYvIsqMVuYto6M9hrprtbZG2SucgXZxxw8Ls
	 bjOSWHzH5xq3v7EHmrxYTzckPoJM/S3Qq/4xTt6Lj9j3ceY7zLPmiRz9sZygTyTe7Z
	 8cqTgwmB1lw2XMcPqZdlOHjT8HVzENkfsuGZ1i1Nnukuwj8FWvP5t4cgVVTjihfngb
	 py5XjsquJQhqqigaXM2bygwg=
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30beab99453so6846484eec.1
        for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 20:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782100261; cv=none;
        d=google.com; s=arc-20240605;
        b=gn70zk18Wt/1fAygXhiSNLgfnLoPf1VDB9aT7s+33uUF0NalDeDKGwqKBnS4WgN7fZ
         PiFdR3sDyYWiPME6OIqhp/dZyWndeRQBNpMs6hGtdIvz/DrUMFpYpa+bZbvrUwFiscUG
         OuFTaqvrT1pHemZ/MVTpVb53BZJDLc/E9SN9Nw3EiEgG/ZeMuM8ca+zDaFk+h5EDsjdQ
         XFI+4ecXJ5avCUdRo5m0ultuMtX0m7GAbbnQyP8E4dJcF/u/5kn63ul/rukcP/YnnE2v
         zzZqmy8fRmNtt1UjzHzk9U9KH84xrwm+nWEA9B+jBx3UGsK9ieIxmBVeFp5UvsrYCh8z
         oCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=dSGgikQvu7j45PvDbVQYuK05bU8Ts7pfKIgYWDP3ec0=;
        fh=Z3ElFVdj4o3GQEWqpqa5+f7cVHh1nQgUJYjKOQEIkXg=;
        b=MqzqcVcdPHKT1unUzk7dTz2aMABfgfNeqt5mTx9AlJydz5P7I16BFKn6Mwkz9mklMV
         q1oo5iFL6+wOF/U0A8jsfMWXyojfWlfmEPGQ/hNAuQ9eYdo0cDbpNY1p6ERHMNoW/lDe
         IE1XqKQ/PxtYSywYB2xgSpew7Pz2qOpEfkkFn+FjS4+Ds+6lt9TKqtMB0qyKbTu6O7qr
         T8+xXeEuoTHf/jZHgfyNYZyxT0Plp+DnNUDRabDvaM5rJXUBPYW49X1UtCGJl+OVKPCm
         r9vSzrVBYC6gEaOzONvrCJwppEmWez8QcuJjINMUIybWfFOOvnSlsmuii2B6ShOMGmke
         Llfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782100261; x=1782705061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSGgikQvu7j45PvDbVQYuK05bU8Ts7pfKIgYWDP3ec0=;
        b=RXhxlxB156hC1n3gAdu2zwegOVnon+SFK682MapfpnXp1AFtVj2seYtdGnoB7WRiON
         hgeSS3BMgFP2zBj1AHRkfGJzhGiZFYvH93/KYgsQiw+rU5oEUPuU55j0H3OW9Hj0W7D3
         tHC2lpgIcPJgjHdN2XIZZFYgdbY+XrjBYx+z5Hp6Gg44Wss2Ng2Q6QeCrhiK0YR+Zt0u
         1Y0Cnr1UrzdxPDoOOSKVab0uJg+Sp4SDQjG9fMIFarHrNPrKO7AdMaCo9DLpa5VSexXC
         igvV4tHWxOjc1KDDW385KbyxfbCLOPkWasWK+y6Fjr1tjwFRXLLa1GIZTTyt4NsZ573E
         X4sg==
X-Forwarded-Encrypted: i=1; AFNElJ/brNar+m7H2whjQAytDwzyl0yh/On8oPToHqVH3aGFbxuS5IF2a1YjVkBEVwUU0od6tsnf9G4hu8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjjcd9YzdrOyzPho6jsi2Eb03P5il2/oG1dQMWvuW47VPDBnyt
	7aO5XlmsrVgFmo0RSxdlBmj8QFfYPn85NLIgV6RVTHlfe/h+ZhZu/E71mIPzL+LGzhloAczJMSu
	90qeJVB++W5JwEnAhsNsMrlKdZWx/1xuTL2JwHzA1ujWQ0QcUMZJBue1HGj3NMoE+24tp5ia7I6
	wqsgFhbgX/59Jory/uUJA7vVB/EW/WX5UYLgCTTqlBJlw117GvsEX5
X-Gm-Gg: AfdE7ckam6xAZE2gITgLcO9pMHk4AGX0/OFUBGV7F7IG1gROnyTju746S8H2W5eDZYc
	BCa3oXsNUCaHjfKu6wnhKMNVgsr9QNSiqiHQ4HquJKY+piI5ex8Ug4zm/vR4RyuWyTjqUbQ0Tdh
	ajVwGXZrpWDrOequ8gXXyN+sY9lkeNL4QfNKm2BOZ5u7mzBFxJS685KQntCTk6ydAfQnajc5gqn
	Q8VIl4gkTS5+a9fjxFThrpNtWiOpx56GxSxCap/6TNhyeVfEY8=
X-Received: by 2002:a05:7022:1601:b0:137:f4ec:29ff with SMTP id a92af1059eb24-139a210724dmr8807145c88.22.1782100261036;
        Sun, 21 Jun 2026 20:51:01 -0700 (PDT)
X-Received: by 2002:a05:7022:1601:b0:137:f4ec:29ff with SMTP id
 a92af1059eb24-139a210724dmr8807109c88.22.1782100259773; Sun, 21 Jun 2026
 20:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618081803.2790848-1-aaron.ma@canonical.com> <c3c9df7b-20ae-41fe-8cae-ad7f9cabe823@amd.com>
In-Reply-To: <c3c9df7b-20ae-41fe-8cae-ad7f9cabe823@amd.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Mon, 22 Jun 2026 11:50:48 +0800
X-Gm-Features: AVVi8CflWfY6b02TDtCr9-mRfVE2lVX5fFbyjeafZ4_o2x8nzBNhxkEwbeE5pgA
Message-ID: <CAJ6xRxXhNmehDjP4Gdx8VM5zh4cXQK8NKWVddL3kEGoroHL6WA@mail.gmail.com>
Subject: Re: [PATCH] PCI: vgaarb: Include 0x0380 devices in default selection
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:15=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 6/18/26 01:18, Aaron Ma wrote:
> > Some firmware boot GPUs report class 0x0380 (PCI_CLASS_DISPLAY_OTHER)
> > instead of PCI_CLASS_DISPLAY_VGA. vgaarb only registers pci_is_vga()
> > devices, so those GPUs are not considered by vga_is_firmware_default().
> >
> > On these systems the AMD GPU matches the EFI framebuffer but is
> > excluded from vgaarb because it is class 0x0380, while the NVIDIA GPU
> > does not match the EFI framebuffer but becomes vga_default_device()
> > through the vgaarb's enabled-device fallback.
> >
> > Register legacy VGA and 0x0380 devices in vgaarb, and expose boot_vga
> > for the same set of devices, so the firmware default device can be
> > selected correctly.
> >
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >   drivers/pci/pci-sysfs.c |  3 ++-
> >   drivers/pci/vgaarb.c    | 10 +++++-----
> >   include/linux/pci.h     | 14 ++++++++++++++
> >   3 files changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index d37860841260c..843d83ec9550a 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1717,7 +1717,8 @@ static umode_t pci_dev_attrs_are_visible(struct k=
object *kobj,
> >       struct device *dev =3D kobj_to_dev(kobj);
> >       struct pci_dev *pdev =3D to_pci_dev(dev);
> >
> > -     if (a =3D=3D &dev_attr_boot_vga.attr && pci_is_vga(pdev))
> > +     if (a =3D=3D &dev_attr_boot_vga.attr &&
> > +         pci_is_vga_or_other_display(pdev))
> >               return a->mode;
>  >   >          if (a =3D=3D &dev_attr_serial_number.attr && pci_get_dsn(=
pdev))
> > diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> > index c360eee11dd9e..0e0878189e3d8 100644
> > --- a/drivers/pci/vgaarb.c
> > +++ b/drivers/pci/vgaarb.c
> > @@ -796,7 +796,7 @@ static bool vga_arbiter_add_pci_device(struct pci_d=
ev *pdev)
> >       }
> >
> >       if (vga_is_boot_device(vgadev)) {
> > -             vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
> > +             vgaarb_info(&pdev->dev, "setting as boot display device%s=
\n",
> >                           vga_default_device() ?
> >                           " (overriding previous)" : "");
> >               vga_set_default_device(pdev);
> > @@ -1483,8 +1483,8 @@ static int pci_notify(struct notifier_block *nb, =
unsigned long action,
> >
> >       vgaarb_dbg(dev, "%s\n", __func__);
> >
> > -     /* Only deal with VGA class devices */
> > -     if (!pci_is_vga(pdev))
> > +     /* Only deal with legacy VGA and other display controller devices=
 */
> > +     if (!pci_is_vga_or_other_display(pdev)) >               return 0;
> >
> >       /*
> > @@ -1530,12 +1530,12 @@ static int __init vga_arb_device_init(void)
> >
> >       bus_register_notifier(&pci_bus_type, &pci_notifier);
> >
> > -     /* Add all VGA class PCI devices by default */
> > +     /* Add legacy VGA and other display controller PCI devices by def=
ault */
> >       pdev =3D NULL;
> >       while ((pdev =3D
> >               pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> >                              PCI_ANY_ID, pdev)) !=3D NULL) {
> > -             if (pci_is_vga(pdev))
> > +             if (pci_is_vga_or_other_display(pdev))
> >                       vga_arbiter_add_pci_device(pdev);
> >       }
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 2c4454583c115..195ec1bdac863 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -792,6 +792,20 @@ static inline bool pci_is_vga(struct pci_dev *pdev=
)
> >       return false;
> >   }
> >
> > +/**
> > + * pci_is_vga_or_other_display - check if the PCI device is VGA or 0x0=
380
> > + * @pdev: PCI device
> > + *
> > + * Return true for legacy VGA-compatible devices and for "other displa=
y
> > + * controller" devices.  Some firmware-selected boot display devices e=
xpose
> > + * class 0x0380 instead of PCI_CLASS_DISPLAY_VGA.
> > + */
> > +static inline bool pci_is_vga_or_other_display(struct pci_dev *pdev)
> > +{
> > +     return pci_is_vga(pdev) ||
> > +             (pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_OTHER;
> > +}
> > +
> >   /**
> >    * pci_is_display - check if the PCI device is a display controller
> >    * @pdev: PCI device
>
>
> This patch doesn't seem correct to me.  It's overloading the purpose of
> boot_vga to cover non VGA devices.  We should be using boot_display.
>
> Trying to hypothesize what's going on here - I guess you're seeing
> boot_display set for more than one device due to enumeration order.
>
> Can you see if this helps instead?
>
> =E2=95=B0=E2=94=80=E2=9D=AF git diff
> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.=
c
> index 152789f00fcda..9440eb3a7b15d 100644
> --- a/arch/x86/video/video-common.c
> +++ b/arch/x86/video/video-common.c
> @@ -43,9 +43,6 @@ bool video_is_primary_device(struct device *dev)
>          if (!pci_is_display(pdev))
>                  return false;
>
> -       if (pdev =3D=3D vga_default_device())
> -               return true;
> -
>   #ifdef CONFIG_SCREEN_INFO
>          numres =3D screen_info_resources(si, res, ARRAY_SIZE(res));
>          for (i =3D 0; i < numres; ++i) {

Hi Mario,

I tested your change. boot_display becomes correct, but the issue is not fi=
xed.

The kernel state becomes:

  AMD:    boot_display=3D1, boot_vga absent
  NVIDIA: boot_display absent, boot_vga=3D1

Current Xorg checks boot_display || boot_vga, so both GPUs still match.
The selected primary GPU still depends on Xorg's DRM device enumeration ord=
er.

So boot_vga is still wrong, and that still matters. The kernel should not
expose boot_vga=3D1 for NVIDIA when the firmware framebuffer is on AMD.

My patch makes boot_vga and boot_display agree on the AMD boot display.

Thanks,
Aaron
