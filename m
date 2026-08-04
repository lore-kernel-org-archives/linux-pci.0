Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC747D466
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872421; cv=pass; b=M+p+3YCdi1gsc/DM9ilkOyTNPETjcPszc4IF57lwkTzVWQ8vdsJJ4yMv0WEX4QcJh5a3aMn2lk+P1jNEbxeV6s3viBGYE288yvkzawgvf+9siBix4g5CGcTrAp7/tVksBytET8Gpxkm7nMK6mJDy1I8fq7k535jilUNp79cmZMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872421; c=relaxed/simple;
	bh=rL3ZGz1AXViepxBTMOHhACSqnEyAq60Zdz+B7vwT7MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5qmEF1KmJTIj75F0IwXiCDujI8NbOaPT/A8l0osBft22PoNxF0ZM7V2dsLif/Epd1mTUKXE7FGrvhnKHt5fscxWskdv32Xydky1e5bfa3bYofo8wa44cFQ4PoPoMQHtiZE0uVgRHxA+DAV9//+ypYbixj815lg/YYvpFgvx6U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs+1Tb0V; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs+1Tb0V"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8114a4542b2so3843637b3.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 12:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785872415; cv=none;
        d=google.com; s=arc-20260327;
        b=U5QEMhRAvXNQvDWJk9UqQUf814pZWWRo6BzvQwK8kHk4LVvRZO99bUb4d02YNYmFcW
         /ct1lNPs8KBGhRD0G53rCpQMqtsLVCQVgqbomFDctgpMMliNc21ffWB1G0dkxeOGTXwV
         GJVWmQyD5huDDchesaeIyFQgmiHn1Xq0LeG54Y1vp3bSv926NjfJKKafJWNCFDpkMGca
         5wrZlELy0gGgHwSMdjuqd5fxkMw0HbH2NHWYIgk3JpL/whqvKqJ7qJmBZ+/S20acF0dA
         SuTzk5FJ3XOweQ3khBoQ01hVvoyQqX3zb9LRnPC2TkyG2mK50t2N9mepaLSB+J7Xcgjt
         y2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vFtXo5vVRQCf0aD4uHeT/9Yj5Ddh1rThZITSwsxXnAs=;
        fh=UcgJ/J/vYguLg0ybkOxqC7ExHAFlxqhZDqgyjhZyqGQ=;
        b=X6AqdzRlOnNU2yTZTdENZKbxOl57b/9W6axDpNLa/YIgQzmag4qL/r9xo0fEyYJlkV
         CLYOd6bmhm6+aq+cYLUpf5lU+hPi5vXVIzgfjxLtP1X94CkWd0p+LqxbKh0dCcFMg8HV
         RZaO2fF8Dq9iqnzBqOVApB4byf3XI+QxRLUBLXwo38m/diWhWab4HzAQMxxbgYMBRMgp
         biQPJPKmG0UAS+70KltJX+ahR1n3hJpnxCmvxTuGBTTadPYKxy/PGTpdCu7+oQRjFRmq
         zLqqmxqGSGPr22XC90c5i06Yf1WFKNXswBApekXqvinB0tN/3E6xCqifAOHgFESpoNzf
         3oug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785872415; x=1786477215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vFtXo5vVRQCf0aD4uHeT/9Yj5Ddh1rThZITSwsxXnAs=;
        b=hs+1Tb0VyO+fiByiC7t6HGwsCTMZjq62lfPVxaF8enJ9eOXmhqirQCrz3qIU73ohOH
         XqEbl+PKQe7l2QIPR2nZStVS6uKYrHrK/3WO2Y2uvtZ3qe7vp1Jgqe4hNTliEatQc623
         5ILKsVfgDI2cgKvT3zBb1DDw+n8el2wWw/6YI5bYREXFSWPKAu02XtiSZJLtRkgozUte
         qDLASPuv68ShBY47jJc3FGa2vN6DJ3Vm4mRf5VPu3K31LlCE5JEN79zW8PnhdrQ2BY5r
         ubdqQulcPuRWpJaAirqsye61fn8MjCiyR0hAtpgxHu9lgeS8JtecX2uKYtawQb67mYnC
         T5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785872415; x=1786477215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFtXo5vVRQCf0aD4uHeT/9Yj5Ddh1rThZITSwsxXnAs=;
        b=V7xlgKmYvpztzw/TIzRbiJ29VydBzzY6V2b2HK36wBE+yy3r61GsKy9zlnWrrqeaDb
         R8ZPxR4qzx61Q0NH33NN8cVhN+WvhA6HjuvtXCXEjhZfyr/d7/OKRHQhRXPe3uS+9XDR
         dTCA/RoJ1p5tIgvkMdSrFKZEPAjdv7RhhpLiDwSvYA4ug7LcTlpy6DiwU0Jn6b40hVrO
         icSl5qxCebEFiwGThgHYxWVgzJiR8eAjDdPiNd21JpVmdLTitchPHn80IjUvgIrP3tge
         dZcTabqqORXEvBnIF6tgkQhT/tU1fqGs5IYHEaPQWccAUowMhoLX9GwsM/1+lF32whDM
         JuSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJ3NcBr8eGDrQ7ND1JVDS+0xFThymGeeuyTjB+zePOySHDPg4lZmYtKT+/Sh78NWnl0/jbTw3PKR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSo9YRa20Qq/2p8L979QUjlrXuxtWQRACd67LDlkqC6K1jGgMD
	0co/4t5gWfoAaf7IcvzGvp4eiBvzyi+z+JDYNTmGb6penN5R97BFtBocRQGPSpSfljJQ8x1Cty5
	9UqoUXdg6O2T2gF4p+w47Gk2yyi35gko=
X-Gm-Gg: AR+sD11VVoW03gUtRyzh8nOl66QfUWha0htlKuBy3MdwlfhY2daY8r0bWYsbAWGLSor
	wr23p/HaioJM15PY4PH53kFkldoLVTnoqSBVJPTv5QZPUCmdRqP6IOATU11pTmZXoZJ77VUEpoD
	ZngFgwHeDN8+c6+HV5i53NyEr5Ldun7ue/I9h0zfjiUilW+7YGp1fNmpKEZxVQVNNg6PcmyW4d/
	EeA/8TN2KgnwWbM/9U1digYL9jkcsmkjHw1HNu8L0yap0Ja59IKqfUXJnp+KPEmZ3FMRCVrW35C
	1lD8w7p6vQDgO0ugR92pgvlrdjF1gwfpEaIyW8KofWDGcyESLU3HiIEClbI7R9moahBgVL/orvx
	QDliJ0xOeCXE=
X-Received: by 2002:a05:690c:6603:b0:80b:9114:3b7e with SMTP id
 00721157ae682-820222c0250mr5469797b3.12.1785872414991; Tue, 04 Aug 2026
 12:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+1pjEmQgcfhjj56yjuXWVshBM+soFC7RZHaGwaaF=ZFCr1Lyg@mail.gmail.com>
 <am8DEH0wfphdAX0n@wunner.de>
In-Reply-To: <am8DEH0wfphdAX0n@wunner.de>
From: Lowne Onema <lowneonema@gmail.com>
Date: Tue, 4 Aug 2026 21:40:03 +0200
X-Gm-Features: AUfX_mw7lrUPNLuudoGpBbPQEHke6cEdzjSF3D5JC9P9MggR4W67qO1NJ1QOcEM
Message-ID: <CA+1pjEnxg9nVy79QNGTb0Ea3s+q=Z-we5XH_fDvJbOLpXH8HDA@mail.gmail.com>
Subject: Re: [PATCH] PCI: quirks: Prevent D3 for Acer Swift SF515-51T Root
 Port to fix audio
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, rafael.j.wysocki@intel.com, alexander.deucher@amd.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the details! It's very helpful.

1. Device link: agreed this does not seem viable here. The speaker/amp isn'=
t
     enumerated as its own device (PCI, platform, or otherwise) on this
     hardware, it's just analog circuitry fed by a shared GPIO rail.
     there's no second struct device to link against.

  2. DSDT patch: I actually tried this route first, before settling on
     the quirk. Bumped SSDT5's OEM revision and added RP09.PXP as a
     second dependency in HDAS._PR0, but I struggled to recompile it
     with iasl (some header issues since several pins share an identical
     header). Also, as you note, it wouldn't help other Linux users of
     this model without each of them repeating the same disassembly by
     hand.

 3. Amending the power resource structures in drivers/acpi/: I looked
   at this a bit more and noticed RP09 and the SATA port
   (SAT0.PRT1) each have their own separate power resource in the
   ACPI tables, but both end up controlling the same physical GPIO
   pin. I'm not sure if that's something the kernel already knows
   how to handle safely, or if trying to sync RP09's power to audio
   activity could accidentally interfere with the SATA port through
   that shared pin. Still learning this part of the kernel, so
   wanted to ask before attempting it -- is that a real concern, or
   is it fine, and a better approach?

  4. BIOS update: checked, I'm unfortunately up to date with latest
     acer version (from 2019, no updates since).

  v2 below corrects the following: real name in Signed-off-by, Closes: inst=
ead
  of Link:, and Cc: stable added.

  commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if
  power managed by ACPI") made Root Ports newly eligible for D3 when
  ACPI reports the port as power-manageable. On the Acer Swift
  SF515-51T, this Root Port (Intel Cannon Point-LP PCI Express Root
  Port #9, 8086:9db0, always empty on this SKU) is put into D3 as a
  result, and doing so permanently silences the internal speakers
  until the machine is rebooted.

  Disassembly of this board's ACPI tables shows the Root Port's power
  resource (RP09.PXP) and the SATA port SAT0.PRT1 share GPIO pin
  0x0402000D as their power-good/enable line. That GPIO also gates a
  rail the internal speaker amplifier depends on, but this dependency
  is not expressed anywhere in ACPI -- HDAS._PR0 only references
  PAUD, so the OS has no way to know that putting the Root Port in D3
  cuts power the audio codec/amp circuitry needs.

  Prior to commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
  D3 if power managed by ACPI") this Root Port was never trusted for D3,
  so the missing dependency had no observable effect. Confirmed on
  hardware: forcing the port to stay in D0 (via
  /sys/.../power/control) restores audio immediately, and letting it
  re-enter D3 reliably kills it again.

  Use PCI_DEV_FLAGS_NO_D3, matched to this exact model via DMI, to
  keep the Root Port in D0, following the same pattern already used
  for other model-specific D3 breakage in this file.

  Fixes: c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if
power managed by ACPI")
  Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D212463
  Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D214125
  Cc: stable@vger.kernel.org # v5.10+
  Signed-off-by: Jacques Mironneau <lowneonema@gmail.com>
  ---
  v2: use real name in Signed-off-by, s/Link/Closes for the bugzilla
      references, add Cc: stable (per Lukas Wunner)


   drivers/pci/quirks.c | 35 +++++++++++++++++++++++++++++++++++
   1 file changed, 35 insertions(+)

  diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
  index b09f27f78..feb83a84b 100644
  --- a/drivers/pci/quirks.c
  +++ b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1471,6 +1471,41 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL,
PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
                              PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);

+/*
+ * The Root Port that the Acer Swift SF515-51T's internal, always-empty PC=
Ie
+ * slot is wired to (Intel Cannon Point-LP PCI Express Root Port #9) share=
s a
+ * GPIO power-good/enable line (0x0402000D) with SAT0.PRT1, a SATA port, p=
er
+ * this board's own ACPI tables -- confirmed via DSDT/SSDT disassembly, no=
t a
+ * naming coincidence. That GPIO gates a physical rail that isn't document=
ed
+ * as a dependency anywhere else in ACPI, but real-world testing on this
+ * exact hardware shows it also feeds circuitry the internal speaker
+ * amplifier depends on: forcing this Root Port to stay out of D3 restores
+ * audio, and putting it back into D3 reliably kills it again.
+ *
+ * Before commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 i=
f
+ * power managed by ACPI"), this Root Port was never trusted for D3 at all=
,
+ * so the missing dependency was invisible -- the shared rail just stayed =
on
+ * incidentally. That commit's broadened trust condition lets this specifi=
c,
+ * always-empty port enter D3, silently cutting the rail and killing the
+ * internal speakers.
+ */
+static const struct dmi_system_id acer_sf515_rp_d3_dmi_table[] =3D {
+     {
+             .matches =3D {
+                     DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
+                     DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Swift SF515-51T"),
+             },
+     },
+     {}
+};
+
+static void quirk_acer_sf515_rp09_no_d3(struct pci_dev *pdev)
+{
+     if (dmi_check_system(acer_sf515_rp_d3_dmi_table))
+             pdev->dev_flags |=3D PCI_DEV_FLAGS_NO_D3;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9db0,
quirk_acer_sf515_rp09_no_d3);
+
 /*
  * This was originally an Alpha-specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
--
2.34.1

Jacques Mironneau

Le dim. 2 ao=C3=BBt 2026 =C3=A0 10:42, Lukas Wunner <lukas@wunner.de> a =C3=
=A9crit :
>
> On Sat, Aug 01, 2026 at 08:10:25PM +0200, Lowne Onema wrote:
> > commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if
> > power managed by ACPI") made Root Ports newly eligible for D3 when
> > ACPI reports the port as power-manageable. On my Acer Swift
> > SF515-51T, this Root Port (Intel Cannon Point-LP PCI Express Root
> > Port #9, 8086:9db0, always empty on this SKU) is put into D3 as a
> > result, and doing so permanently silences the internal speakers
> > until the machine is rebooted.
> >
> > Disassembly of this board's ACPI tables shows the Root Port's power
> > resource (RP09.PXP) and the SATA port SAT0.PRT1 share GPIO pin
> > 0x0402000D as their power enable line. That GPIO also gates a
> > rail the internal speaker amplifier depends on, but this dependency
> > is not expressed anywhere in ACPI -- HDAS._PR0 only references
> > PAUD, so the kernel has no way to know that putting the Root Port in D3
> > cuts power the audio codec/amp circuitry needs.
> [...]
> > I went with a DMI-matched PCI_DEV_FLAGS_NO_D3 quirk since that seems to
> > be the go-to pattern in this file for "device breaks in D3" cases (I sa=
w
> > quirk_no_ata_d3 above it). Is that the right mechanism here, or would
> > you prefer something scoped differently?
>
> It is *one* option.  An alternative approach we've used in similar
> cases is to create a device link.  It allows expressing a power
> dependency of one device on another device.  E.g. GPUs frequently
> expose an HDA controller as Function 1 of a PCI device which is
> only accessible if Function 0 (the actual GPU) is powered on.
> See quirk_gpu_hda() in drivers/pci/quirks.c.  For this approach
> you need two struct device (the supplier and the consumer) and
> I'm not sure if the speaker or speaker amplifier is represented
> as a struct device.  If it's not, then this approach is not viable.
> A workaround might be to use the HDA controller as supplier (to which
> the speaker is attached), but that's not perfect.
>
> Another option would be to patch the ACPI tables.  There are several
> ways to do this via the initrd, via EFI etc.  See:
>
> admin-guide/acpi/initrd_table_override.rst
> https://github.com/xCuri0/ReBarUEFI/wiki/DSDT-Patching
> https://wiki.archlinux.org/title/DSDT
>
> Using a DSDT patch benefits other OSes you might have installed,
> but doesn't benefit other Linux users who encounter the same problem.
>
> In drivers/acpi/x86/ we carry a number of ACPI quirks for problematic
> devices.  Amending that would be a third option to overcome the issue.
> The kernel enumerates power resources and the dependencies of devices
> on them, basically you'd have to add a quirk to amend those data
> structures.  At the bottom of drivers/acpi/power.c, you'll find
> existing quirks for products with broken power resource descriptions.
> I don't know why these live in power.c, they're x86-specific and
> everything in this file is also compiled into kernels for other
> ACPI-supporting arches such as arm64.  Generally we try to move such
> quirks to files that are only compiled on x86 (such as everything
> under drivers/acpi/x86) or at least #ifdef them to CONFIG_X86.
>
> The fourth and best option would be if the vendor would provide
> a BIOS update to fix the ACPI table.  Often vendors are loathe
> to do this for older products and then a workaround at the OS level
> is the only solution, but please double-check that you've got the
> latest BIOS version installed.
>
> > Fixes: c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if
> > power managed by ACPI")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D212463
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D214125
> > Signed-off-by: paasshme <lowneonema@gmail.com>
>
> A minor nit, you should use your real name in the Signed-off-by tag,
> you may want to use "Closes:" instead of "Link:" and you may also
> want to add a tag "Cc: stable@vger.kernel.org # v5.10+".
>
> > Apologies in advance for any formatting/process mistakes,
> > that's my first patch.
>
> You're doing great!  I am sorry for the breakage caused by my commit!
>
> Thanks,
>
> Lukas
