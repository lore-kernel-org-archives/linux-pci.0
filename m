Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908639;
	b=QMhTnnHJhKC/gHkzS69ArtfWJsToiiQcZSJUsmD36ta7JBRjzhITK4EzuscQzXW/2N3s
	 PpEZp0Fd9/cK2DYEpQcvFRal9JGC0BOY+zGgBaQ/HnFHnBjAozd+wbGkSEFeyynzrvJKk
	 Jbo0tXMloK1mb4YRY+hhAGFhQEeQ1tBPEFvuhsyy2rsgRc6Fc9gr7d7OJot4eFNO9+cx6
	 50rRx5j8Q4Kg6y94i+u7AckeFuAMKdk+/hrgLDBQN4PC2GBQs8it+d9gzDVXyoM5vyfZB
	 RoNu9+kGxJFEjfzyOP2xzBCUitgbB91sabRE8aoIN9p7orX5XOYh/bQH3t+969APDnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908639;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B3PGuBtYsDkPS6q+oBmmpl9f1c4rCqFvxlpSZWi2nUM=;
	b=I1ntnia+/xL730v/2WMsghcZZ8aXVH2Q3P/XxqrQIdtFcGAPvnFv1zSEahaZE4AAikgH
	 WBjeNwr0G5xrXpBO4sBg4Mf+7q/KYuh0VqAG/g3T3AjlJPZeKWWvbvkA+JTriNLyWLG8e
	 JhG7n9Mm6dz+thGZ/wT9/dl9mApiHvzfewyuc0OeTeLh9TPIfVxLnMvDCPkSLC3h8imPA
	 M3t7p/Pg9ycm2EyR1WG81p3tnrpuixWFAhio5c++W1bG8n/S62tYrv+V5rLRIvIz1glBE
	 D8t53Cpx4xSz6L9uYicM+m1RR4Br/kWOdtzSZfZ//lGwZgLcXfkGNJqb5+Grl03yuaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3qmXXbI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE0606A6F0
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3qmXXbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED331F008A7
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908638;
	bh=B3PGuBtYsDkPS6q+oBmmpl9f1c4rCqFvxlpSZWi2nUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=S3qmXXbIx25aGds7p3bB+v5AtkJyF+kyhfVaF0ROCKX2dI6oLSwKbRQMtvm8S8khf
	 zzdLXtVWE2OiqZhdwbeVC8kTfjfo4R7yj+1eaQL5QJtVD+jwvO48wyfHIE7JMmBXhN
	 1WQcDnOt8C3FdMpDCgWDux9Gt7hXcYw978m3rZB9p6SiQihqIt8kRh+hbxol3qljbp
	 Ji2ksMv28Br0OrulPYIKdXlTO1wlTbW0/gJ57BuQzQmN8VoWYiCs3kvUrjaSbLEKjO
	 /SKBq5uttgr6WAVYsF0Zlf2RKeDlxbGnPBv+9GJBAfXTFt04VTEJ/nmgrFygZ0yhgB
	 xZ5opK3LP4Gaw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso2183182e87.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 11:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBySOP0e0BM5G9BC1QIZaPVgn966BHbvMDijbryYwvClnJ5dyhwrplsFPaHSv+5eRpoVN82Io1MpJoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GI/iF6HV/+ide8JTkezZvzeOh2XxeAO1uI6+tU4RVR5H/pZ1d
	5RgFNAEb2+cdfiQ3Ujd8StIHBhkJTlKEP7gA/CS/RgRpNvoBA4X+GIydMLEW71KrtWWW6VKRHAE
	w3iIMU51eH4eFieRP3zxaZ/N9+3PW+gU=
X-Received: by 2002:a05:6512:4013:b0:5bf:e4e6:7f78 with SMTP id
 2adb3069b0e04-5c003ab0e58mr40161e87.39.1793908636836; Thu, 05 Nov 2026
 11:57:16 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260924132859.24751-1-fbeltranmillalen@gmail.com> <20261008232912.GA940274@bhelgaas>
In-Reply-To: <20261008232912.GA940274@bhelgaas>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 5 Nov 2026 20:57:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i38rL7xmQY=_e5ppnn3bjQJcPBKQkvS_pHVJvUqX1ksg@mail.gmail.com>
X-Gm-Features: AclHuK9RZC5U3cVKmSaUv-6y1OIrV-lQyNCOTrFAabFo6_FZlScfgW00KN5G-54
Message-ID: <CAJZ5v0i38rL7xmQY=_e5ppnn3bjQJcPBKQkvS_pHVJvUqX1ksg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PCI: take native PME control on Apple machines
To: Bjorn Helgaas <helgaas@kernel.org>, 
	=?UTF-8?Q?Francisco_Beltr=C3=A1n_Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
Cc: bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Darrell Gum <d@rrell.co>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 1:29=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Matthew (author of 7bc5a2bad0b8), Darrell, Andreas, Mika,
> Yehezkel, Lukas, linux-usb]
>
> On Thu, Sep 24, 2026 at 10:28:59AM -0300, Francisco Beltr=C3=A1n Millal=
=C3=A9n wrote:
> > Since commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
> > negotiate_os_control() skips the _OSC handshake on Apple machines and
> > hardcodes the set of features the OS takes over, because those firmware=
s
> > return failure once _OSI("Darwin") has been acknowledged.  The hardcode=
d
> > set is ~OSC_PCI_EXPRESS_PME_CONTROL, i.e. everything except PME.  No
> > reason was given for leaving PME out.
>
> It's clear there *was* a reason, but I don't know either.  Maybe
> Matthew will remember?
>
> > The result is that host_bridge->native_pme stays 0, so portdrv never
> > registers the PME service for any root port.  A PCIe device that
> > runtime suspends still arms PME# (the PCI core enables it because
> > pci_dev_run_wake() only looks at capability), asserts it when it needs
> > attention, and is never resumed: no service handles the root port
> > interrupt, and the polling fallback in pci_pme_list_scan() skips the
> > device whenever the bridge above it is runtime suspended, which is
> > exactly when the device itself is suspended.
> >
> > On a MacBookPro14,3 this silently breaks USB-C hotplug.  Both xHCI
> > controllers sit inside the Thunderbolt (Alpine Ridge) switches and
> > runtime suspend to D3hot when idle, together with their parent
> > bridges.  Plugging a SuperSpeed device in is then never noticed:
> >
> >   0000:7d:00.0 suspended, PMCSR 0x8103 (D3hot, PME_En=3D1, PME_Status=
=3D1)
> >   ... no kernel message at all, for minutes ...
> >
> > The device only appears once something else resumes the controller,
> > which makes it look intermittent.  The firmware on this machine does no=
t
> > handle PME on behalf of the OS either: XHC2/XHC3 declare _PRW returning
> > GPE 0x6D, that GPE is enabled and has never fired, and its _L6D handler
> > notifies PWRB, XHC1 and HDEF only - never XHC2 or XHC3.
> >
> > With PME control taken, the root port PME interrupt is serviced and the
> > controller is resumed as soon as something is plugged in.
> >
> > Use calculate_control() for the assumed set rather than open coding it:
> > that is by definition the set that would have been requested, it drops =
a
> > magic constant, and on a kernel built without some of those features it
> > no longer claims control of services the OS cannot provide.
> >
> > Note this also makes pme_is_native() true for pciehp (drivers/pci/
> > hotplug/pciehp_core.c), so hotplug ports now disable their interrupt
> > across suspend and clear spurious events on resume, as they do on every
> > non-Apple machine.  x86_apple_machine covers Macs back to 2006, so this
> > reaches models that were never tested with native PME.
> >
> > Tested on a MacBookPro14,3, 6.18.49, with a USB 3.1 SATA enclosure:
> >
> >   - before: plugged in at 09:20 with 0000:7d:00.0 runtime suspended, st=
ill
> >     invisible at 09:21 with PME_Status latched at 1; only appeared when
> >     0000:7d:00.0 was forced to power/control=3Don.
> >   - with pcie_ports=3Dnative (which reaches the same code path in
> >     get_port_device_capability()): pcie_pme bound to 5 root ports, and =
the
> >     same enclosure enumerated in the same second it was plugged in, 66 =
s
> >     after the controller had suspended, with nothing forced.
> >   - with this patch, nothing forced: pcie_pme bound to 5 root ports and=
 the
> >     _OSC line now reads "OS assumes control of [PCIeHotplug SHPCHotplug=
 PME
> >     AER PCIeCapability LTR DPC]".  The enclosure was unplugged at 20:42=
:13,
> >     0000:7d:00.0 runtime suspended to D3hot, and on plugging it back in=
 at
> >     20:43:06 (53 s later) the root port took a PME interrupt and the de=
vice
> >     enumerated in the same second.
> >   - wifi, internal keyboard, touchbar and audio all came up; 66 warning=
s
> >     and 45 errors during boot, against 65/43 on the distribution kernel=
.
> >
> > One rough edge, reproducible on both boots: the port driver logs
> > "PME: Spurious native interrupt!" right before the device is resumed.
> > pcie_pme_handle_request() falls back to pcie_pme_walk_bus() when the ro=
ot
> > port reports its own requester ID without PCI_PM_CTRL_PME_STATUS set, a=
nd
> > that walk skips PCIe devices, so the xHCI is never attributed.  The dev=
ice
> > is still resumed and the wakeup works, but attributing PMEs from PCIe
> > devices behind a switch looks like a separate shortcoming; it is not
> > addressed here.
> >
> > Boot with pcie_ports=3Dnative also showed no new AER/DPC activity and
> > slightly fewer warnings than a boot without it, so taking the remaining
> > control bit does not appear to disturb anything else on this machine.
> >
> > Fixes: 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
> > Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@g=
mail.com>
>
> I don't object from a PCI standpoint, but Rafael generally takes care
> of acpi/pci_root.c.  I would again suggest putting some of the commit
> log detail below "---" and relying on the https://patch.msgid.link/
> tag Rafael adds.

So I trimmed the changelog a bit and applied the patch as 7.5 material.

Thanks!

>
> > ---
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -568,9 +568,14 @@
> >        * Apple always return failure on _OSC calls when _OSI("Darwin") =
has
> >        * been called successfully. We know the feature set supported by=
 the
> >        * platform, so avoid calling _OSC at all
> > +      *
> > +      * Assume control of the same features that would have been reque=
sted,
> > +      * PCIe PME included.  Leaving PME out disables the PME service f=
or
> > +      * every root port, and nothing takes over: a device that runtime
> > +      * suspends asserts PME# and is never resumed.
> >        */
> >       if (x86_apple_machine) {
> > -             root->osc_control_set =3D ~OSC_PCI_EXPRESS_PME_CONTROL;
> > +             root->osc_control_set =3D calculate_control();
> >               decode_osc_control(root, "OS assumes control of",
> >                                  root->osc_control_set);
> >               return;
