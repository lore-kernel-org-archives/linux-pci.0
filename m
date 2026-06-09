Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC116416CE6
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012202; cv=pass; b=SGDtgd4LZGywIDn3Ws5mExF3pL6rMzII2EZNkzw+2/qHuoW8bzwHKH01Egwlzrz7HvUUpratRjm2qHkDYACbnR8WuEUZdV5ynPFbGhls5EBIXziWVY5UjkGFYmOPLeAtBTmkjajY3LsEWnOwa3jGsNTTLpHLgHM+f0tmIsNHQeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012202; c=relaxed/simple;
	bh=nhzPVHz6XMP+JcENiwIDJwvObOIwhfrBJt10B7quYQM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsDrPtGo1erbv3POpCsc8UvLTgqGwHp61ccE8xojhyl05FEdvwish/xwwP/xSZ9ZGD+LTq8sDVQ2lW0qn0Sc6Z5A/eKrOk7ws2F4IX6K+xTDjC4lOv0ElKXjJrxjKfu9RqiQrjkxNE9J0RSDQ6i1mrR5zSrBOJA8gzx7u+RtE7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/bP3aIF; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/bP3aIF"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6cfb0a137c9so3463893137.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 06:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781012200; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWdW7Wm8yBGG/PcOqXiSxzdRQjRpQx4nBGnkIs3gvRnsslAQZRaigBzDgXxteRn/5k
         JllHcOAAps5JMQBSpZX0QWX9ikirvRP6aZY9le10qJ5D/5sWqFTlEQt8ZbKHXXGB2YtR
         YLWvh0X9tXpDxSEqyyi3d1c8eOb+Pj11eG6cUypSonpUs/2Ch/xo0eFwP+yySXxDW+de
         i0A+r5j1dIgahhcsXR159OgDswzrVYuHbf9Y6skEORyB4Hf4JiFTCDoFkY3Rhvd4q/E+
         V9yEiw6x00uxSkI8vONG2oi67ZO4rW8PNHAAqO8bg8nmX1VC86Z2OrIdZuCLuNvjNGUj
         /yBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:dkim-signature;
        bh=jfMvfDEA3SmU4K/PGLB/W0+/Jeh4SL7ZfMFVFyHgEHk=;
        fh=uFq9Moz0fHxKw0XK5G5/Es0dxYuhMJNVBYIjjAo2s7I=;
        b=JuCNCtWrpa/KO521pK5LfrcomlNPcL6fPV/jBpbL/ofn1XQynrJdvDmGM/k1XqINdq
         EFKrm9xIt4U70s052T8ax/LyjQV4HhQu45ts1IqLN/AhJrqghneqhKRpVKP8fjlFG4ou
         YtznstybRpcKMuMMLmTBThNAQLJczEeb8tPxRqCmLjgnBmZU9xQeYr3SNsB1bAFb2nBN
         ig1hSBe/1Op7hST06rUwFznE71/tZPmQw4NGpWx5jD+V0UMm0C2gjinmHlBJS6W9pSv0
         o4fSzq/05QsLEmIRXvYrj1DBhFDD/km7I+mKXwDRp9LWf8KOMBU84OeDOUyhou9Ymjsu
         2sxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781012200; x=1781617000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfMvfDEA3SmU4K/PGLB/W0+/Jeh4SL7ZfMFVFyHgEHk=;
        b=K/bP3aIFi9EXoU6/WPM3aFsNqEf8ZNhxb4eQ/nAPgahWDlkGOw/nMpmj+f2SkNPCf7
         1rkWoRZoVP5dXGxuMztUGlsHej9MQrBwtp0P4DzVrSkefjQsxLInEzCz0sQ10O1pwIaS
         tImqErGIdV9dzzIo0TO28h5dSYvS9/2h8zxJZw/1kwl7JSGWchSlEHwACeI5b3vgRxRt
         uhphHkgBMNMSGYS00fj3PM15IDxUU4M0hb737U6RuBBOx34ozJzNtodVh/R06oVf7D65
         69iAACgRPI7xWkvxZOVzn5j2fnk5n+VW7jL0tJWOr7x0tO0yOlQI+gIrEEqofS7IXNX7
         7e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012200; x=1781617000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfMvfDEA3SmU4K/PGLB/W0+/Jeh4SL7ZfMFVFyHgEHk=;
        b=AQkU9cyAVMaL0QDiPi0LO+QHMbkbhcI2DxvVuFBoVkgaEyQJ62j0imip6kLTOgLZb1
         3h98iQHJSqgZE5ijcDrou6HqVulQI2ydZqJomXQvIBlj8tjPwu0eVq7Pv22mYREPzpmH
         3QWPLp7XqUv/bMPIb5tEKhI2d9zbUB5N5VtRhkw13JL3h5Cta5SxCIXUf88X+9bdiOZm
         CiUYl3ngruGgXJMwGGAF9n8X67Y9wNyRimE803kR3s+Lz4oO2mdBWq3OxSWDBkHMmxCZ
         jPXFkF2/GXEpRFZAOvRY55LBH1AvSJc3zGsTFAMoVL3mGDa5ihjH/yIZtOZUVaKYaBpn
         rSzA==
X-Forwarded-Encrypted: i=1; AFNElJ8lpxySFkTh10C0xXnvaCRjEMFikSGSDXE96UR1sGegE2iCTTZl8V7eyo4AaSuSQv+4qNvpToXiGWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2TqzxvMImifQccP30s74ZLAFApg7y2fVWCyHJTEXyeaJOjA9
	l7NbONoSWVcElHb9jenQ2T24djFDvTr8fopXhIlz2GE/mW6Ct26Kz0X+g+4ajJLORB7CYe6n5Ji
	9OcQ3fAoPAxpBWVe0RXxtb9fQ6RJI9UA=
X-Gm-Gg: Acq92OElS6B9fiwsQZ+LkF2pT739JTuYgwOrMZK0DAaTTSwapAunLA0ZyTwXGBtpURR
	J5OIlqZIbiqlNwb25Jlj/Pl8BEICxBzJd6Bq8G4D8I9Y2xB7z6bRpD8fjvOhFvJzT/bxd4HZGr0
	7HkPOL8Q8Umke7FBvmQwgY4E1E6PtJ+9678Lbn7+rQKiJPTHwEsDj4/CG+oCFlNlsY1ONTQJEsg
	cIPa4AXC/kKpZKLw66GIZJ5A6YUTmR/FaSTYPvHcPGo4XR7WQJn512P7Aw3+d6kDRrVegbmjwPh
	2Kp0dGsZ6r+IQlVf5As1BR29ed4=
X-Received: by 2002:a05:6102:548c:b0:639:1e8b:ecd9 with SMTP id
 ada2fe7eead31-6fefa23308cmr10377940137.20.1781012199589; Tue, 09 Jun 2026
 06:36:39 -0700 (PDT)
Received: from 922524751902 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 06:36:38 -0700
Received: from 922524751902 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 06:36:38 -0700
From: manisadhasivam.linux@gmail.com
In-Reply-To: <20260522070646.203115-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522070646.203115-1-jtornosm@redhat.com>
Date: Tue, 9 Jun 2026 06:36:38 -0700
X-Gm-Features: AVVi8Ce_P2VLojOc9kycU6EoL1PlQq47Nd5prQV2Yp4Bcj0p3ZHpvVx3-YePVQM
Message-ID: <CAGyK6cpa89aHZELLBnc9nBwQdivir7-P9_e+CLQKzbzQzXWjsg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Disable broken FLR on MediaTek MT7925
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, linux-pci@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhelgaas@google.com, alex@shazbot.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2026 09:06:46 +0200, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> said:
> The MediaTek MT7925 WiFi device advertises FLR capability, but it does
> not work correctly. This manifests in VFIO passthrough scenarios: normal
> VM operation works fine, including clean shutdown/reboot. However, when
> the VM terminates uncleanly (crash, force-off), VFIO attempts to reset
> the device before it can be assigned to another VM. Because FLR is broken=
,
> the reset fails preventing reuse.
>
> This is similar to its predecessor MT7922 (see commit 81f64e925c29 ("PCI:
> Avoid FLR for Mediatek MT7922 WiFi")), but with different symptoms.
> The MT7922 issue manifests as config read failures (returning ~0) after
> FLR. The MT7925 shows different behavior: config reads work correctly
> after FLR, but firmware communication fails.
>
> First VM start with MT7925 works fine:
>   mt7925e 0000:08:00.0: ASIC revision: 79250000
>   mt7925e 0000:08:00.0: WM Firmware Version: ____000000, Build Time:
>     20260106153120
>
> After force reset or VM crash, when VFIO attempts FLR to reset the device
> for reassignment, firmware initialization fails:
>   mt7925e 0000:08:00.0: ASIC revision: 79250000
>   mt7925e 0000:08:00.0: Message 00000010 (seq 1) timeout
>   mt7925e 0000:08:00.0: Failed to get patch semaphore
>   [Repeats with increasing sequence numbers 2-10]
>   mt7925e 0000:08:00.0: hardware init failed
>
> The driver cannot acquire the patch semaphore needed for firmware
> initialization, indicating that FLR does not properly reset the firmware
> state. The device remains in this broken state until physical power cycle=
.
>
> Disable FLR for MT7925 so the PCI core falls back to Secondary Bus Reset,
> which successfully resets the device and allows reinitialization for VFIO
> passthrough reuse.
>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> v4: Improved commit message with specific dmesg evidence showing firmware
>   initialization failure after FLR (Bjorn Helgaas feedback)
> v2: https://lore.kernel.org/all/20260521061205.12727-1-jtornosm@redhat.co=
m/
>
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 000000000000..111111111111 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5607,6 +5607,7 @@
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
>   * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
> + * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
>   */
>  static void quirk_no_flr(struct pci_dev *dev)
>  {
> @@ -5617,6 +5618,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, =
quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);
>
>  /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
>  static void quirk_no_flr_snet(struct pci_dev *dev)
> --
> 2.53.0
>
>
>

--
=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=E0=
=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=
=AF=8D
