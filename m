Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE33DFC80
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516340; cv=none; b=ceH6QmT0eDX1yq42Q8eCk8s7zfV4JGCR+Xdi2z4ORWKEpU8UJT/H0vSK1zwZG2jIxSvRfCJOFeiPxwRoCtp6HoIkFjfcBimP2o4azdUHC8m0tRssSMgJ4O5bpZUh8hhWv5sSgBQgk1yO0VeMASPU5BGLlcfdcK8EKDGO3QgZHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516340; c=relaxed/simple;
	bh=PonluXIqpdK5YVnIwW1ZKIfyugR2p2Y9j8kib4Q/qvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imKLhWv5lfoDJBHxH/xP8oT3784V2soY9gpoePHIl3dQDdpE3+GKtbwyhBufC0oiu9E2r/7r1VHBGBIoSkeNG4P/bjTnuy2Af/d6PIbu4QNu9WWT+GqUhssm+Km1LKfTMsZM1zPSVGubk9mOxFYfhj4A9PjUJeq3e/bj7RYIsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiDI5Usg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiDI5Usg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EE61F00ACA
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 10:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788516338;
	bh=+MVFKDGPp4UWg5sRJHXl+lvkq3CQatW3Z5Cpu0PPOY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LiDI5UsgHWTMHnyuAJRu5WXd2blippVQ1EjhRDEiBVHQ+3z2JeRZ7R53hOD1lolVb
	 C+GBw5OeE5d/vLIEaSG7Hl67OAu9YiFjGonBOvbUZ7mS0owGTCQMuGZ9My3t1oAxDx
	 TdBADZ9QCT/R0vce7ePuixbj18GeKoiU30YrRDIl1BafpXXldjqpG9L/ZQ0xGJm1Sx
	 mA8zl8wyH1P3N8ek3cUmLg0mbQ4L1EBqyyAcZiHVS8se1XwFD3ZvjdsElneRPQrmUO
	 qGz1LijHMM6LD5/ot3wF/SDDkmuTfEEmJvMcOwdgCQMtWr2iwtsrSg6L6/FWeXOI1R
	 cBedRM+M4XtBw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b4afc8465eso1073061e87.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 03:05:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxEeZ8Z3u7Wv6LA2X8O5luZDY+RvFAGRCSXRZOVD/3LRmkq7beVGgX35Txrmx1tiyGkS1OSIIrHJpo=@vger.kernel.org
X-Gm-Message-State: AFuF++kTc36d6QWJvxee5zWEy8p768Psidjqfb29UvIY/Ru7DCSAIuGQ
	Odj9EPeC7xuijXl699Le1Ty6dd7Le8L/+gV4SxbQ+/fb4h/FCfw7gHKXQlnGEbP4T6x8gjYPQhA
	jw8wDZiWISlwX8MCfQTodSLJeewlZKL8=
X-Received: by 2002:a05:6512:2521:b0:5b6:1a7c:fd84 with SMTP id
 2adb3069b0e04-5b61a7cfeb4mr382887e87.42.1788516337225; Fri, 04 Sep 2026
 03:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6044499.DvuYhMxLoT@rafael.j.wysocki> <20260904094030.2455645-1-peixin.xie@linux.spacemit.com>
In-Reply-To: <20260904094030.2455645-1-peixin.xie@linux.spacemit.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 12:04:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLz3=RVDD3YeT0=Xk0w_fLmGTCGMuYyZhX10th3-xtSw@mail.gmail.com>
X-Gm-Features: AcwNN1XfOQA-QVk9dEc9RzdSjjBbI02RHKxBUUUm3VlDAMgsThBFfV2VTf3DEXo
Message-ID: <CAJZ5v0hLz3=RVDD3YeT0=Xk0w_fLmGTCGMuYyZhX10th3-xtSw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ACPI: scan: Adjust power management initialization
 and PCI devices handling
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: rafael@kernel.org, andriy.shevchenko@linux.intel.com, hansg@kernel.org, 
	helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukas@wunner.de, mika.westerberg@linux.intel.com, 
	sakari.ailus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 11:41=E2=80=AFAM Peixin Xie
<peixin.xie@linux.spacemit.com> wrote:
>
> Hi Rafael,
>
> On Thu, 03 Sep 2026 18:57:09 +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This is an update of
> >
> > https://lore.kernel.org/linux-acpi/5144065.31r3eYUQgx@rafael.j.wysocki/
> >
> > that adds 1 patch, 3 two patches, and addresses review comments in patc=
h [2/4].
> >
> > The new patch drops in v3 is a cleanup relocating the acpi_bus_init_pow=
er()
> > declaration to an internal header file in the core ACPI support code (p=
atch
> > [3/4]).
> >
> > One of the patches dropped from the v2 has been folded into patch [2/4]
> > and the other two have become cleanups on top of this series that can b=
e
> > done later.
> >
> > Overall, the series aims at addressing a few issues present in the core=
 ACPI
> > device enumeration code, mostly related to the acpi_bus_attach() functi=
on.
> >
> > The first one is that, on some systems, ACPI power management is initia=
lized
> > twice for devices that have missing dependencies to start with.  An att=
empt
> > to address this issue had been made during the 7.3 merge window, but it=
 had
> > to be reverted [1].  The approach used here is roughly the same as in t=
he
> > reverted commit, but it takes PCI devices (which are a special case) in=
to
> > account.
> >
> > In addition to the above, ACPI power management may be initialized prem=
aturely
> > for device objects whose parents are not ready for enumeration.
> >
> > The other issues are that flags are unnecessarily cleared by acpi_bus_a=
ttach()
> > for devices with missing dependencies and PCI devices are handled by
> > acpi_bus_attach() like any other devices which is a mistake.
> >
> > Please see the changelogs of individual patches for details.
> >
> > Thanks!
> >
> >
> > Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-r=
ef-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]
>
> I tested the complete v3 series on the SpacemiT K3 RISC-V Pico-ITX platfo=
rm
> where the original duplicate ACPI PowerResource reference issue was
> observed.
>
> The power resource left on by firmware is now turned off as unused after
> the namespace scan. After the device dependency is satisfied, the power
> resource is turned on once for the device and is turned off normally
> during runtime suspend. Runtime resume also works correctly.
>
> Tested-by: Peixin Xie <peixin.xie@linux.spacemit.com>

Thank you!
