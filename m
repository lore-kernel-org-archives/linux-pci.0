Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDD35C1A1
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108790; cv=pass; b=qqVT5ntPOrg5oYudvcRS4USJGbccBS0l5YdKfK+Wn9DRR5FVCgosZbxriMq3obZKRHToT5P+BL5JmsQDEukFjVFt/VHSCR7MWjjSJtYJ+zP0qI9rv8YG2uNqWRTDzCY/m7Qj47yAeqQ5R1tqxas9476sNhWnJs01x78KNyg72ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108790; c=relaxed/simple;
	bh=bilqSCMSAEecmWyKiMBK+HeurhiGTy9C2LXGPgGQUB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFrMTlkisYsl7rvDo+hk+cYt/HM0VZoxY2XxDrlsjUBo4LrEqAfKyUCZRlNDim+OkTBPtRSyNZk6pECdpRQvNgRCZoxKJwho+VrdlcppDHZTULnwMuekyRivoOJx8QOXCMMhaOdIitsoZwwTQkMGetZb+Mu2UaGRpketQR9RW4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ik22kvdA; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ik22kvdA"
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 96B5A3F212
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 06:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782108785;
	bh=X1nAGON1P5lZjw1PBUom5wAkoyDhSk/p+Z5qkS6Ec0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ik22kvdA0DUywT/pYdW/t9r5DecoAkJePQCfgWZRwAznbpoXa/gaf5Q3aMG3AqWyv
	 3MfnjaKezKVTh14ap/+yixNNAnIF6s7qtVEEZEMkJU6A2cHlNOyfnbyrkjMVSYtNTG
	 xW1riBCV4vi3yzBnh3blZl9LHsXbyHEX7ErqWo775sDqkgGYTePoI4GTzhtfX7sYZr
	 sjmRbdGm8AgToIPUqrodak5WBtBRPeAjHIcsl6sfgS3kkbExrxHlcXL4g7e4zh/PLH
	 ToWG/+4RKRYK9c8GyhyX6HwxLNyHN2y7twsdiKkH18nDzAeN1xOJmPtKvUV+TCwkgd
	 aTQOBtH1kvB+x3gQVN2rk5G4ppJzOotE5Zsc/tiEKi78rlAgzrlTU7KKmzj5cBOlF5
	 8NTeFHqG0WXPhTabBhE04r0WrLqkJEOpLepNiFzDDC3YUg2PakZwNuJ9DB4UDM1nnl
	 6E33Q1XuF9kMm0kF0yJCgjT5GLeWnw9IvEf7O/gNRZpnyPUyhpvdGhhWgbQ6+/lHRn
	 W494aUzdaCT3fb+w0vyHaQRY5AZKVc7vQbtv87XtGtELYyNDaVWv/ixiIgmaNsH825
	 NO9Wo2OdVLhHwhevIZeaEIWwMkPcIKqQanLFD6cUOd0dBpnhre/PhJbl/UiUefAA+T
	 67FSx78V/Apbm1FiY/xLpoKA=
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-138acbc0e69so14755693c88.0
        for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 23:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782108784; cv=none;
        d=google.com; s=arc-20240605;
        b=JIft2icWa38m2u8XYCM6s9dVuQ2sPYehlJPkKSPJYKPyPyC1SndJ1o7SrLFFR90Sc+
         u9Q2bbaz3TaxTLGk6rzH53SwYYrBSI5x2SPU04w5vXFGTTG6W1WtLRzFQpxc3iz+ULbc
         B3+wpG+aP6LRCXwONLkOtHtU38sEk0+kWCH5zZF4S05jp0I4lpm59TnCLh3v8wwQSnut
         zSRDaqAWlMXqxyG3Ipxez5ksibp3si67TIykh8WRMBFDcah4nu71Lv/juRnAVk/1uVNT
         QkMpOtxJuEO3HpXA6nYCM3RgVBpJxwHqfgXNcIRnx8hg9YP1aLBd6Rp3JWrkR0ijkIwp
         MPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=X1nAGON1P5lZjw1PBUom5wAkoyDhSk/p+Z5qkS6Ec0Q=;
        fh=us+4Rl5j0F1s5osSAcgNK69plyzZlJmlQmy3kQVe3CQ=;
        b=D9Cj66oGkwpZr+oQMPMfE3/d5FpnC5os31AhhLzBq+zThIHACdN5UiTY1vu5XVUXgy
         X455bTGiVL9dWjr7GXVf2i7FERohSpz3/LHlURheS2IbLhoOo/UFTfCXCwvxYpzUZR+i
         dcklCz53k3DbZj7JhUCr6J2dpjpKIVGfzn+Jz+kYzmWHcleSqVBvc60desrYW5pztLO/
         luGMk7avViRhOHAKB+xZhZPfTCbnuqemyGIRxcBeGdfw5rp1prUtuqaZAqrHFtm4Gqxg
         CJPl3CEBPRch8jQn+HX1B9cEG4hUxyfDkvLK3OpLCnlNzzh3KGSaByz+rqRabfJW/wp4
         5qIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782108784; x=1782713584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X1nAGON1P5lZjw1PBUom5wAkoyDhSk/p+Z5qkS6Ec0Q=;
        b=S+UBhH+X0Pf+wZuzuol8WyLobFAFcS016e/OJXW37Ywl0fi3QVZyN/3ayre6m12vzb
         CfD5UgWbAUtRe2Yhs6vemGsznflcT31Vjs9c2FsToMfCcSCxV/IweoJln2swJ3ifAcxR
         qRwLWc68X/xqYWl94SbyDaV8J0hd1JAlB7oyEl456F84o0IeI2Uo9P+893c2UIx6dGT9
         rQB/yq1wt6mHkO2v/jbj9BMKiV6V3o9kHEk/Rnkx7zf1SkYZcocYD1FS+fZ5/gJVxpY5
         ND3fL4wBoUaNuAJTKtbNOaXsgO5Yp8KkFNIZF7cosfqWqQzwXQs1zmlVAYvTgNBBn58m
         c8+g==
X-Forwarded-Encrypted: i=1; AFNElJ+Ss0xvSxMrHaQaS2WjEJCsnhMX3jAFMYdof7F9vb0NuXtdNYuLf76JBhO3ErjDCimigs4ExKSYXLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgOqJQKTVa7lPRn/4XrXlLujTHfwNC1Nc4ffPev16yiuQQtRjU
	DH4r4BlRx70sgQS9TIaIYoRDCD/h0IvxwV42G+vFNljpCIxG0pLt4e8j6A337K9lIkauupjRokt
	wL7U+PP/7F3K5tdRo9lMm1iZVrQZpqRRQ6VNJvx8iKPX1JZvXD9DlTfWrIJ848zYpg8YNy1c1rV
	ZfaDmIzLbF5exnq2toOfoqJ8TBn2DF/4ybxgsYYFKzTT7r1fwmu4RmkABCCGryU8nIHw==
X-Gm-Gg: AfdE7ckzYZLrxuBTiQ582aqH9wRnhd0rf862M5E+wsGjx4mGlPae3+tc8TPbeXkMw6+
	sDXRlXVGtTatp84xWBlbte2kjJ2kW9fP8Yaj/KEdaW0Bh12kvKnsJXgCiG4W7q7zMS4Zz9AnsBM
	SFKHC6oHbBss2AvRU7OrKXfpb4xD2EkouGnSi4pLkpKggNRPqGLgu2SS21FUJaXPAKX38pB1E+4
	bW+iyZvLKJxrmamqXGAA3ZYRThtc2SY1ooFlN15AEe1VCA2CaQ=
X-Received: by 2002:a05:701b:4546:10b0:139:b575:d42f with SMTP id a92af1059eb24-139b575d811mr1982575c88.17.1782108783669;
        Sun, 21 Jun 2026 23:13:03 -0700 (PDT)
X-Received: by 2002:a05:701b:4546:10b0:139:b575:d42f with SMTP id
 a92af1059eb24-139b575d811mr1982562c88.17.1782108783187; Sun, 21 Jun 2026
 23:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618081803.2790848-1-aaron.ma@canonical.com>
 <c3c9df7b-20ae-41fe-8cae-ad7f9cabe823@amd.com> <CAJ6xRxXhNmehDjP4Gdx8VM5zh4cXQK8NKWVddL3kEGoroHL6WA@mail.gmail.com>
 <4280751a-87b6-4634-99c2-ed51f74ac29b@amd.com>
In-Reply-To: <4280751a-87b6-4634-99c2-ed51f74ac29b@amd.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Mon, 22 Jun 2026 14:12:51 +0800
X-Gm-Features: AVVi8CczRx-0fwgAXhZEmygXXuqdWIcOW09YvpGv-7Ss0C9imGsn1mI6GGsZIaY
Message-ID: <CAJ6xRxVMQTxV9E5jrbZAjjVv-qUhE6za5e_MjTbjnj9UduLm1Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: vgaarb: Include 0x0380 devices in default selection
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 12:00=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 6/21/26 20:50, Aaron Ma wrote:
> > On Mon, Jun 22, 2026 at 1:15=E2=80=AFAM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >>
> >>
> >> On 6/18/26 01:18, Aaron Ma wrote:
> >>> Some firmware boot GPUs report class 0x0380 (PCI_CLASS_DISPLAY_OTHER)
> >>> instead of PCI_CLASS_DISPLAY_VGA. vgaarb only registers pci_is_vga()
> >>> devices, so those GPUs are not considered by vga_is_firmware_default(=
).
> >>>
> >>> On these systems the AMD GPU matches the EFI framebuffer but is
> >>> excluded from vgaarb because it is class 0x0380, while the NVIDIA GPU
> >>> does not match the EFI framebuffer but becomes vga_default_device()
> >>> through the vgaarb's enabled-device fallback.
> >>>
> >>> Register legacy VGA and 0x0380 devices in vgaarb, and expose boot_vga
> >>> for the same set of devices, so the firmware default device can be
> >>> selected correctly.
> >>>
> >>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> >>> ---
> >>>    drivers/pci/pci-sysfs.c |  3 ++-
> >>>    drivers/pci/vgaarb.c    | 10 +++++-----
> >>>    include/linux/pci.h     | 14 ++++++++++++++
> >>>    3 files changed, 21 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >>> index d37860841260c..843d83ec9550a 100644
> >>> --- a/drivers/pci/pci-sysfs.c
> >>> +++ b/drivers/pci/pci-sysfs.c
> >>> @@ -1717,7 +1717,8 @@ static umode_t pci_dev_attrs_are_visible(struct=
 kobject *kobj,
> >>>        struct device *dev =3D kobj_to_dev(kobj);
> >>>        struct pci_dev *pdev =3D to_pci_dev(dev);
> >>>
> >>> -     if (a =3D=3D &dev_attr_boot_vga.attr && pci_is_vga(pdev))
> >>> +     if (a =3D=3D &dev_attr_boot_vga.attr &&
> >>> +         pci_is_vga_or_other_display(pdev))
> >>>                return a->mode;
> >>   >   >          if (a =3D=3D &dev_attr_serial_number.attr && pci_get_=
dsn(pdev))
> >>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> >>> index c360eee11dd9e..0e0878189e3d8 100644
> >>> --- a/drivers/pci/vgaarb.c
> >>> +++ b/drivers/pci/vgaarb.c
> >>> @@ -796,7 +796,7 @@ static bool vga_arbiter_add_pci_device(struct pci=
_dev *pdev)
> >>>        }
> >>>
> >>>        if (vga_is_boot_device(vgadev)) {
> >>> -             vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n=
",
> >>> +             vgaarb_info(&pdev->dev, "setting as boot display device=
%s\n",
> >>>                            vga_default_device() ?
> >>>                            " (overriding previous)" : "");
> >>>                vga_set_default_device(pdev);
> >>> @@ -1483,8 +1483,8 @@ static int pci_notify(struct notifier_block *nb=
, unsigned long action,
> >>>
> >>>        vgaarb_dbg(dev, "%s\n", __func__);
> >>>
> >>> -     /* Only deal with VGA class devices */
> >>> -     if (!pci_is_vga(pdev))
> >>> +     /* Only deal with legacy VGA and other display controller devic=
es */
> >>> +     if (!pci_is_vga_or_other_display(pdev)) >               return =
0;
> >>>
> >>>        /*
> >>> @@ -1530,12 +1530,12 @@ static int __init vga_arb_device_init(void)
> >>>
> >>>        bus_register_notifier(&pci_bus_type, &pci_notifier);
> >>>
> >>> -     /* Add all VGA class PCI devices by default */
> >>> +     /* Add legacy VGA and other display controller PCI devices by d=
efault */
> >>>        pdev =3D NULL;
> >>>        while ((pdev =3D
> >>>                pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> >>>                               PCI_ANY_ID, pdev)) !=3D NULL) {
> >>> -             if (pci_is_vga(pdev))
> >>> +             if (pci_is_vga_or_other_display(pdev))
> >>>                        vga_arbiter_add_pci_device(pdev);
> >>>        }
> >>>
> >>> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >>> index 2c4454583c115..195ec1bdac863 100644
> >>> --- a/include/linux/pci.h
> >>> +++ b/include/linux/pci.h
> >>> @@ -792,6 +792,20 @@ static inline bool pci_is_vga(struct pci_dev *pd=
ev)
> >>>        return false;
> >>>    }
> >>>
> >>> +/**
> >>> + * pci_is_vga_or_other_display - check if the PCI device is VGA or 0=
x0380
> >>> + * @pdev: PCI device
> >>> + *
> >>> + * Return true for legacy VGA-compatible devices and for "other disp=
lay
> >>> + * controller" devices.  Some firmware-selected boot display devices=
 expose
> >>> + * class 0x0380 instead of PCI_CLASS_DISPLAY_VGA.
> >>> + */
> >>> +static inline bool pci_is_vga_or_other_display(struct pci_dev *pdev)
> >>> +{
> >>> +     return pci_is_vga(pdev) ||
> >>> +             (pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_OTHER;
> >>> +}
> >>> +
> >>>    /**
> >>>     * pci_is_display - check if the PCI device is a display controlle=
r
> >>>     * @pdev: PCI device
> >>
> >>
> >> This patch doesn't seem correct to me.  It's overloading the purpose o=
f
> >> boot_vga to cover non VGA devices.  We should be using boot_display.
> >>
> >> Trying to hypothesize what's going on here - I guess you're seeing
> >> boot_display set for more than one device due to enumeration order.
> >>
> >> Can you see if this helps instead?
> >>
> >> =E2=95=B0=E2=94=80=E2=9D=AF git diff
> >> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-comm=
on.c
> >> index 152789f00fcda..9440eb3a7b15d 100644
> >> --- a/arch/x86/video/video-common.c
> >> +++ b/arch/x86/video/video-common.c
> >> @@ -43,9 +43,6 @@ bool video_is_primary_device(struct device *dev)
> >>           if (!pci_is_display(pdev))
> >>                   return false;
> >>
> >> -       if (pdev =3D=3D vga_default_device())
> >> -               return true;
> >> -
> >>    #ifdef CONFIG_SCREEN_INFO
> >>           numres =3D screen_info_resources(si, res, ARRAY_SIZE(res));
> >>           for (i =3D 0; i < numres; ++i) {
> >
> > Hi Mario,
> >
> > I tested your change. boot_display becomes correct, but the issue is no=
t fixed.
> >
> > The kernel state becomes:
> >
> >    AMD:    boot_display=3D1, boot_vga absent
> >    NVIDIA: boot_display absent, boot_vga=3D1
> >
> > Current Xorg checks boot_display || boot_vga, so both GPUs still match.
> > The selected primary GPU still depends on Xorg's DRM device enumeration=
 order.
> >
> > So boot_vga is still wrong, and that still matters. The kernel should n=
ot
> > expose boot_vga=3D1 for NVIDIA when the firmware framebuffer is on AMD.
> >
> > My patch makes boot_vga and boot_display agree on the AMD boot display.
> >
> > Thanks,
> > Aaron
>
> Got it.  I still don't think it's correct to overload boot_vga.  It
> would be better for us to not show boot_vga at all - because it's not
> correct.
>
> Maybe we should drop the fallback code in VGA arbiter that is setting
> NVIDIA as boot_vga at all.
>
> Could you look at doing that?
>

Hi Mario,

I looked at dropping the fallback. I don't think we should remove it global=
ly;
old systems may still need vga_default_device() when no firmware framebuffe=
r
owner can be identified.

For v2 I will keep the fallback, but avoid the wrong result on this system.=
 The
0x0380 firmware display can become the default/boot_vga device, while legac=
y
VGA decoding and ownership stay limited to pci_is_vga() devices.

So this keeps compatibility, but avoids reporting NVIDIA as boot_vga when t=
he
firmware framebuffer is on AMD.

Thanks,
Aaron
