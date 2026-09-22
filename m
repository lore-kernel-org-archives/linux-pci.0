Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFEE55C329
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083080; cv=none; b=FJhKv8FYu6pRP2OrLA8rcnJQvwaWuhOP/DfZC1YXfokUnM5c4goaBZDOZ/HwhJaZL5AKegPeZj70xzya8x19V66cDt467CMQRmREQt6i2kGF00VHyTv3ssGygJww24rmZ+WQiwhpiiRz5dQQ70zDhMkrr7AVH+XUyHPt+N4YNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083080; c=relaxed/simple;
	bh=x7W58oePQrjYfQjB6uS+RELinrCUscmeZ6LM4E1Z+6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBRPSVsW1yenVbE3YVNuv+JUjXaBJ0qHjLDtP5nfuJ7LGXtInpUxn6Bu7RLtwfkdal1pulJ8e9rsYe27k0ap+LRytp2JeuYHoyZR6BqXodAsZh96Cjh6806zoAcgFd0qGxdc1l3Qz7YMcb1FeAokrOC/LetLyVWJHrHxQ2dJI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPibaTCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPibaTCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8301F00898
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083078;
	bh=BRpj4ATSpNSbwuj4hLiFciyfR/4zfs98FMylWbEoeCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SPibaTCi6dBBkAng02CzRNecu1XFSRg2ZqmvZxaUx4F8zghe+8PipEZY4PJdXvUxi
	 6NCUQ/zuZDpUg/JtYnQ00Dcx8Qywiae8wNPhlIpUx4fTGEBq3XINCg2fH9uncmTfmH
	 Ws6fCE7DFLeHLezpBeX+zzdBaPrLsAbV5ko+GzCWoH3t2Ct/4+lVARvYWD0hBpLsTB
	 SQCrwShNFoBZR302KM6jkiVOeaQYsYpUaru6JZemohrrulgIKz9/qOYQKIn0Ajb4J7
	 q4arECm+iP25q7XVtNZ5vEe4DuQJRa84yz8+loEPRqsxwrhhR+hKn1hpzqRFqHxClu
	 wDwjG8MTvy7+w==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so9006811fa.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 06:17:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBya4CC7BpbJVB8PwY2/O3EMGJR2zHD12/C3m3/kTpvYLIJozZp5yhplpoBfQPhDFDVPQaKwcE3ziYk=@vger.kernel.org
X-Gm-Message-State: AFuF++nqwJTO7tYSIvuXh6rd2o+gl34UlpYJtXNlcjS/lkgoSCWQnALb
	zvetDHZkKPj98AJyiRRRgP+7bYJBxSzSjTyPP4Ey68AIQXpM5Hu7em8Pz/cHFq30ZAVuBw2AoKd
	Cf+MPUHiq6CEofyE1rns5xXxDBWOz1iQ=
X-Received: by 2002:a2e:bc83:0:b0:3a1:6a25:1780 with SMTP id
 38308e7fff4ca-3a624d006eemr5092051fa.9.1790083076502; Tue, 22 Sep 2026
 06:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <905ddaea-8ed3-4c8b-ae4e-593a81e59833@linux.alibaba.com> <6fa0674c-eeb2-42b7-bea3-61bee9908fbe@linux.intel.com>
In-Reply-To: <6fa0674c-eeb2-42b7-bea3-61bee9908fbe@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 15:16:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i6xOk0zNb-JpyNiDKuiVOOK=Spp=U48vom9TM2dETSXg@mail.gmail.com>
X-Gm-Features: AcwNN1XoH6xl0j0JWnPj7EeBdeWGO9x-mA6rdO9urvdcL9OArj6b2jyYpIB6wts
Message-ID: <CAJZ5v0i6xOk0zNb-JpyNiDKuiVOOK=Spp=U48vom9TM2dETSXg@mail.gmail.com>
Subject: Re: [PATCH v13 4/5] PCI/ACPI: Centralize pcie_ports_native checking
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rafael J Wysocki <rafael@kernel.org>, 
	Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:41=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 9/20/2026 12:24 AM, Guixin Liu wrote:
> >
> >
> > =E5=9C=A8 2026/9/20 00:26, Kuppuswamy Sathyanarayanan =E5=86=99=E9=81=
=93:
> >> If the user booted with "pcie_ports=3Dnative", we take control of the =
PCIe
> >> port services unconditionally, regardless of what _OSC says.
> >>
> >> Centralize the testing of pcie_ports_native in acpi_pci_root_create(),
> >> where we interpret the _OSC results, so other places only have to chec=
k
> >> host_bridge->native_X and we don't have to sprinkle tests of
> >> pcie_ports_native everywhere.
> >>
> >> Rather than overriding the host_bridge->native_X flags after the fact,
> >> fold "pcie_ports=3Dnative" into the _OSC control mask we evaluate, i.e=
.,
> >> proceed as though the platform had granted control of the port service=
s.
> >> That way there is a single mechanism deciding each native_X flag, and =
we
> >> can report exactly which features we are overriding _OSC for instead o=
f
> >> just noting that we are overriding something:
> >>
> >>   acpi PNP0A08:00: _OSC: OS forcing control ("pcie_ports=3Dnative") of=
 [PCIeHotplug PME AER DPC]
> >>
> >> This also extends "pcie_ports=3Dnative" to host_bridge->native_dpc, wh=
ich
> >> had no pcie_ports_native fallback before.  The effect is narrow.
> >> native_dpc is only used by pci_dpc_recovered(), and only when
> >> CONFIG_PCIE_EDR=3Dn, where hotplug now waits for firmware-owned DPC
> >> recovery.
> >>
> >> host_bridge->native_ltr is deliberately not forced.  "pcie_ports=3D"
> >> controls PCIe port services and LTR is not one.  There is no
> >> PCIE_PORT_SERVICE_LTR, and native_ltr is only used by
> >> pci_configure_ltr() to enable ASPM L1.2, so forcing it would be an ASP=
M
> >> policy decision users did not ask for.
> >>
> >> SHPC hotplug is left alone for a simpler reason: SHPC is a conventiona=
l
> >> PCI feature rather than a PCIe one, so "pcie_ports=3D" has no bearing =
on
> >> it.
> >>
> >> [bhelgaas: commit log, rework OSC_PCIE_PORT_SERVICE_CONTROLS, logging]
> >> Link: https://lore.kernel.org/r/bc87c9e675118960949043a832bed86bc22bec=
bd.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@=
linux.intel.com>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>=E3=80=81
> > Should add Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream P=
orts when OS controls AER").
>
> Sure. Will add it in v14.

With that

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # ACPI core

for the $subject patch.

Thanks!
