Return-Path: <SRS0=mc2Y=XY=etas.com=mathias.koehrer@kernel.org>
Return-Path: <SRS0=mc2Y=XY=etas.com=mathias.koehrer@kernel.org>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Matthew Garrett <mjg59@coreos.com>, Julia Cartwright
	<julia@ni.com>, Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: RE: [PATCH] Force to clear ASPM bits if CONFIG_PCIEASPM_PERFORMANCE
 is set
Date: Fri, 9 Dec 2016 09:57:03 +0000
Message-ID: <70624f4bf1514e48ae29e84998a81a80@FE-MBX1012.de.bosch.com>
References: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
 <20161208222025.GB6693@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161208222025.GB6693@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

thanks for the response.

> > On systems that have PCIe ASPM support in the BIOS enabled the commit
> > 387d37577fdd05e9472c20885464c2a53b3c945f may lead to the situation
> > that accesses to registers of enabled PCIe devices are extremely slow.
> > This happens if the ACPI FADT declares incorrectly that the system
> > doesn't support PCIe ASPM even if this is enabled in the BIOS.
> > In this case the function pcie_no_aspm() will be called.
> > However this sets the aspm_policy to POLICY_DEFAULT even if
> > CONFIG_PCIEASPM_PERFORMANCE has been configured.
> > As result, the ASPM on a PCIe may still be set even if this is not
> > expected.
> >
> > This happens e.g. on a HP workstation 800 G1 together with an Intel
> > dual port Ethernet server adapter i350 plugged in.
> > Whenever ASPM is enabled in the BIOS the access to the LAN registers
> > are really slow (read access: slower than 20us).
> > In this setup the LnkCap of the two LAN controllers and of the
> > integrated PCIe switch is set to "ASPM L1 Enabled"
> > even if the controller is configured to be up and running.
> > There has been a lengthy discussion on this performance issue due to
> > this issue on the linux-rt-users list:
> > http://marc.info/?l=3Dlinux-rt-users&m=3D147454824515022&w=3D2
> >
> > This patch solves this issue by forcing to disable ASPM if
> > CONFIG_PCIEASPM_PERFORMANCE has been set.
>=20
> The 387d37577fdd changelog says that when ACPI_FADT_NO_ASPM is set, the
> expected behavior is for the OS to not touch the ASPM configuration, and =
that this is
> what Windows does.
>=20
> If I understand correctly, your proposal in this patch is to change this =
so that if
> ACPI_FADT_NO_ASPM is set and CONFIG_PCIEASPM_PERFORMANCE=3Dy,
> we go ahead and disable ASPM.
>=20
> Only the firmware author can tell whether it's really a bug that this sys=
tem sets
> ACPI_FADT_NO_ASPM.  It could be that there's some platform issue that is
> avoided by leaving the BIOS ASPM configuration untouched.
>=20
> If it really *is* a firmware bug, and ACPI_FADT_NO_ASPM is not supposed t=
o be
> set on this platform, CONFIG_PCIEASPM_PERFORMANCE doesn't feel like the
> right mechanism for working around it.  It should be safe to enable that =
for all
> systems, and for other systems that set ACPI_FADT_NO_ASPM correctly, we
> should not touch ASPM configuration.
>=20
> Can you open a bugzilla at http://bugzilla.kernel.org and attach the comp=
lete dmesg
> log and "lspci -vv" output?  This is a subtle area where we've had many b=
reak/fix
> cycles, and it's important to be able to go back and look at details of p=
roblems that
> motivated previous changes.
>=20
I have create a new bug report (id=3D189951).
https://bugzilla.kernel.org/show_bug.cgi?id=3D189951=20

Regards

Mathias
