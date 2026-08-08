Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6C1624C0
	for <linux-pci@vger.kernel.org>; Sat,  8 Aug 2026 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149078; cv=pass; b=d38EoOErS7VPDuwjVVIbfrY3Vr4r9Byo6X34ld+RJMglrY2zNP+h5eMb8Dz0PCAJ1atQ+/LdJehhj9mBPhF6iBQMAPfwyerj90dCnBZhgY+YqO5Z8U1AdzydutUzKCFXWSw613+MVymrkTXiD6+Safo7q4BGTgwqFd8hqBm+EoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149078; c=relaxed/simple;
	bh=tgmdY4b08C0VSjTv0AvibQ7XxbdkRfOqw15gd8qf1+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqkBw2Shst/+TCGgmz2En2108uFayl9a8iBmO7N6TsriW2DeK7p99B4od5GYiMrPttA42dCyUJXgN49jxUEADDUlAwAo360kcibupimZ4WiJKbJIjVAChEoallEENUbCDxcRCV4dGVoS0wgRujPnps6XsGYCOY+rUHh39+py0xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji5SwFsd; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji5SwFsd"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8efcef23d21so353136d6.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 17:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786149075; cv=none;
        d=google.com; s=arc-20260327;
        b=iymFVXaRjPUBuH0TnxtUswYu/dX90SmjQZuk5vnNdZ+65GcTzik5z/ABD77HyNjV7w
         TWLhg9XqiUThUexO9fxieZDX9I0DveBs7UKTdbo8Yk9Ta4c1Es6lENiYn6BCTu/IrNLd
         hJicSyjXSx6qPJxY9ly5j4JEMH9Ibr8j8S8eVNTdJqnbrcuQv7eWd9hGzTOpTfzL/Uiz
         sem0NKZ6qROHeLcPmLkFPXRN+hzaHgiCHNR4dNKRDS1rVahbwK+s548FmC6PFTNXZ/Fr
         8H0Bl8a+OdlDQW1EfUcV29pONqY7Ou6oY12IvKy/HqxH1KPXz8nyAc7O+1FWl7bGRih1
         Q61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q+sLnBLSJymEBAHqqiSnOXhzzy/j8pS4G26DWyqc7as=;
        fh=NZZA6vYV68VSXhknTC4ADS1Cnuy5FzcHOumZ+W5/I+g=;
        b=XbvljewOmu+VwjduaZ/6dyV83zas5KoeoFyjcXsQmtq/up3dPLFOjzAOb57oBtO/5o
         Qe0hHxvsE5dM2vnx1ZVpJ5OQUZXDJ9qYthEDW7EjcMyIobWP5PQ8C23NtgftgJALpyqS
         08pmZfssU29ze5rwpWGQM8VFF5+710kBDvwrPgNpdoP4uXeM5oQ91zOMG5EodHkL/q/Z
         rgx/7VZkOFGkD9wHh/KIKHMLiFFNAi4Ct2mP8BBzIwOxy1hdBLAu3yxZI3xjRDnPJMAD
         tFAxJVaRnroG4kLfm6dcm8WQhpdW9BCLZONpBchTXRNKL3qOJ5VtG0w6Dvnaqq6Fd15K
         TLkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149075; x=1786753875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q+sLnBLSJymEBAHqqiSnOXhzzy/j8pS4G26DWyqc7as=;
        b=ji5SwFsd0/EvqroNYCiukgD54HgBK7P1GjbuM/QNngLLrvjVwyMNfm57jOhildVzOB
         HQdJaZgNobjNyXJyXrpwd+wuds8apFyn/HG8zWw0nBkbZfTvJY7Tk+DWLxs+bcZHypr5
         cxJQ0A20+1mXa36e3o1eJZdSeevvLiaZ5adtsJ6hDSoI05nUqNk7CDNTVK+0bVDW8FXn
         ZQ+xstcMxhVomAd/S72AuEQLPSsvurg7eeMrl2ayBLwFfR9PLABdbmA66zLPUR41SjwR
         64HcSju1oKD1j52feL3NFeaGNFZ2K3SFlY73HU8auCGzeovWHD08CiLv5YOyyDCro8JU
         2ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149075; x=1786753875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+sLnBLSJymEBAHqqiSnOXhzzy/j8pS4G26DWyqc7as=;
        b=l1BJvqpdWNh9X2GN+fkh4di0JlzmQPOuF1SCdDLUWRSaWexjX7IzuNIrGpbq5LTwEj
         cxCrEaaw2598bVmtftvHfRThnIaJ9eToRTfi+LDTUxiEUxJ4jOFy1aquyPGUF2UEZxAi
         2jGWL3D4Ch1y+pU6KVXVoxZ6qfEm0eiMY+I0GSmcNc5sZbq5xPNdEyybAgSNkKKJ82k6
         0QpBzOc24v2WJEVE2b8ZP+82knpD5EVxT2KhAsp2Mgm88wVDNmmGi15QVUvTQNRB2I1a
         Qy2Atw7mz+XqHHBmaztMjPPRgfgtcB+rjinyc9q6XLaoVU1tCTZfE7SSfdNBAQh8M07O
         9TGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUX2mCV15cvFdMjcPZczlD2c6HJPJeWl/GbiirmOHil+1pG/F0n2Blxtvj4WfipkUiPIje7NHsFck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXicN1Wvv5J2WLLJHWDS8Sj5rPUKFJ0C9xRd92SeKbF+7LqPvi
	GlUHYT2tOy4eUo9ROxu7BgzgogyHG2sfW7rxAWxKr0rFMEmoDrOLtiixkvlCqm4LaodqE+IPmXq
	nSinesXIlYVbcljeKqu5uNtkyu9+ODlo=
X-Gm-Gg: AR+sD11Gs2VrodMtKAE3JbpLGQj90W8ztFuo8kfisTUt8/gvdhvD7ZFkHqy2ohSBreQ
	k0yt9ngyJxC9nknk4+o+dUec5fnyXv2AwVxET6cjVeX+cgQg6GwF1mbMgeoSni+Akfq4Yu7gR4g
	p7IPvXD99GHibXp/QFesq3jvv3gKbmQWnefjQR/vxyT7F3S7CIBzIsb23gLnZaoXSRh86LrE5vi
	I31du7pSU8cYcFOWBnFp9oG4n/QYHyETo55x8Pn4vpgWQaly9HwKRH7WppZTtcqSLp0Dd4G6ArZ
	MC/QZrnhEH5LkJtCEyAVXkHLCq+UnKuCj7NWbFJuH30G5w==
X-Received: by 2002:a05:6214:4a88:b0:8ef:4ed2:316 with SMTP id
 6a1803df08f44-90881098e74mr362851146d6.1.1786149075301; Fri, 07 Aug 2026
 17:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com> <anWdGzfD7HxglsOB@wunner.de>
In-Reply-To: <anWdGzfD7HxglsOB@wunner.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Fri, 7 Aug 2026 17:31:04 -0700
X-Gm-Features: AUfX_mxIDKaLd4o5DGwV3EMOZpEUPWzNbnQTt9zpWskvRmjiibZrJFeGZXulq2I
Message-ID: <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
To: lukas@wunner.de
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 1:53=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> On Thu, Aug 06, 2026 at 09:48:08PM +0000, Derek J. Clark wrote:
> > The MSI Claw A8 (MS-1T8K) hard-locks on resume from s2idle whenever an
> > SD/MMC card is present in the onboard Realtek RTS525A card reader
> > (10ec:525a), which sits behind root port 0000:00:02.2.
>
> The RTS525A is known to falsely claim that it supports ASPM L0s,
> even though it only supports L1.  There is a patch pending to
> work around this hardware erratum, I'm wondering whether it
> makes the issue go away on the MSI Claw A8?
>
> https://lore.kernel.org/r/20260707021527.639611-1-max.lee@canonical.com/
>
Hi Lukas,

Sending again as i inadvertently hit reply instead of reply all.

The freeze still occurs with that patch applied, yes.

> > The reader's PCIe endpoint is fixed/soldered and not user-hotpluggable.
> > Firmware advertises this root port as PCIe hotplug-capable
>
> That looks like an oversight on the part of MSI.  Is there a BIOS update
> available which clears the Hot-Plug Capable bit in the Slot Capabilities
> Register?  (I'm *assuming* that bit is set -- I haven't seen any dmesg
> or lspci -vvv output in your e-mails, perhaps you could open a bug
> at bugzilla.kernel.org and upload it there.)
>

I'm on the latest firmware they have as of abuut a month ago. They
don't participate in LVFS AFAIK but I made sure to update before
switching to Linux.

I posted them here for the entire device tree for the SD card reader:
https://github.com/ValveSoftware/SteamOS/issues/2473#issuecomment-522297281=
5

> > When native hotplug is OS-owned,
> > resuming from s2idle races the port's hotplug/PME resume handling
> > against the RTS525A's own resume sequence when a card is present,
> > hard-locking the system.
>
> This sounds like a driver bug in rtsx_pci which needs to be root-caused
> and fixed, rather than worked around.
>
> pciehp (the OS-native PCIe hotplug driver) normally doesn't de-enumerate
> and re-enumerate devices on resume from system sleep.  It uses a heuristi=
c
> to determine whether the device in the slot was replaced during system
> sleep and synthesizes a hotplug event if it believes there's now a differ=
ent
> device in the slot.  Otherwise it just leaves the device in the slot alon=
e.
> The replacement detection is in pciehp_device_replaced(),
> drivers/pci/hotplug/pciehp_hpc.c line 567.  You could try hacking
> that function to return false and see if it helps.
>

That worked! That strikes me as odd since the card is never replaced.

> The heuristic looks at the Vendor ID and Device ID in config space.
> I do recall that a different type of card readers, RTS5261, trigger
> a hotplug event when a regular UHS card is replaced with an SD Express
> card.  The card reader is hot-unplugged and the SD Express card appears
> as an NVMe drive with a different Device ID in config space:
>
> https://lore.kernel.org/r/20231016040132.23824-1-kai.heng.feng@canonical.=
com/
>
> That said, I'm not even sure RTS525A supports SD Express.
>
> What kind of card do you have inserted in the card reader, is it UHS
> or SD Express?  Does the issue go away if you eject the card before
> going to system sleep?
>

I've been using a SanDisk Ultra 32GB microSDHC UHS-I Card. And yes, it
only happens when the card is present.

> > +++ b/drivers/pci/quirks.c
> [...]
> > +/*
> > + * The MSI Claw A8 firmware advertises native PCIe hotplug support for
> > + * this root port, but native hotplug handling causes resume failures.
> > + * Prevent the PCIe port driver from claiming native hotplug ownership
> > + * of this port.
> > + */
> > +static void quirk_claw_a8_no_native_hotplug(struct pci_dev *pdev)
> > +{
> > +     if (!dmi_match(DMI_BOARD_NAME, "MS-1T8K"))
> > +             return;
> > +
> > +     if (pdev->bus->number !=3D 0 ||
> > +         PCI_SLOT(pdev->devfn) !=3D 2 ||
> > +         PCI_FUNC(pdev->devfn) !=3D 2)
> > +             return;
> > +
> > +     pci_info(pdev, "disabling native PCIe hotplug\n");
> > +     pdev->is_hotplug_bridge =3D 0;
> > +     pdev->is_pciehp =3D 0;
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x150b,
> > +                      quirk_claw_a8_no_native_hotplug);
>
> Unfortunately this is just a workaround that happens to make the
> issue disappear, but we'd really want to identify the root cause
> first.
>
> If you boot with no_console_suspend, are you able to see any messages
> on suspend or resume that could help us understand what is going on?
>

Nothing of note. After amdgpu finishes its smu resume sequence the
console _ flashes and doesn't progress.

I did try adding some debug printing to pciehp_device_replaced() but
saw no output for that either. Since that didn't work I tried
replacing each true result in the function one at a time and found the
offending case

        if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
            (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
-            reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device << =
16))))
-               return true;
+            reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device
<< 16)))) {
+               pci_info(pdev, "pdev subsystem vendor ID mismatch");
+               return false;
+
+       }


[   25.686128] rtsx_pci 0000:c2:00.0: pciehp: pdev subsystem vendor ID mism=
atch

Any insight on why that might be occurring and what my next
troubleshooting steps should be are appreciated.

** Update: after my initial email & before I sent it back to the
entire ML I did another test and printed the reg vs expected values.
It seems the SD card reader ID is reflected when it is enumerated
during resume.

reg=3D0x525a10ec expected=3D0x14af1462

Thanks,

Derek

> Thanks,
>
> Lukas
