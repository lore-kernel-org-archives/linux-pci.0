Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4237C10F;
	Thu, 26 Mar 2026 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547856; cv=none; b=kc5X3LNlgkPyy9s1uMyl8BAnVJ7HOHudY75vhaDZZ1/zpP+65gOkE9xIV0HJo71UCqFuym0cLlg56xdBQv/UKmwq429lgXbuiv3+838M+b7hxTQx7DOZ04rKabrPzCWFKflyD4Ib3U+Z2A63gJpOWLsMsViNWtOxm/WuTQ1tekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547856; c=relaxed/simple;
	bh=22oNilBZlJUUCdA/Pia9IX5nPwPaZ8ns1hjBMqCnAJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p1QV2ZHx4wDxY8Jmw+e+Il+uXIDoCswpDUHL1Buud9ER7f6CGn+TdzXh6mMojyBxeUF8QaOWmajnFoguaVfAdnhiX7CZ438DAAm8tJX7JItOb3aK0dTnnFEXHCq3+6uXDUDYqt6B3ZT0WtmAKqJ55xxgXUTZibFjvtijww/nEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgFervbw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgFervbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26883C116C6;
	Thu, 26 Mar 2026 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547855;
	bh=22oNilBZlJUUCdA/Pia9IX5nPwPaZ8ns1hjBMqCnAJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mgFervbw2VgLktSDFmP44MuNPnCwHJw215ux1cZm74pxu//exlAIIIkTv9M5/KT4p
	 FAC2FGi488Ul54OgxhuYzROgdZzXVB8ydO5gE5x1f+cx7FHhe0jl3p8lhDX9ZegpiY
	 gmWIPPPuMtF8CKlV1kNo4QKilw+NofiqQhIKPzaPkgvDxbDkiydZ6e76grwazVUgXF
	 nFvZuL+UJY5By+YIT8e2V16WLt6TmGADzEOvLo9Qf7kdPkZ70vcGZPgTA3mQ9fQyry
	 1iKStOxWXpospH79vM1gh5f5J5/CNxBMLFbiOnfiMpMvrmaLjCCMiRKIZdDaDEMYGJ
	 4I6s05OZpAhbQ==
Date: Thu, 26 Mar 2026 12:57:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Georg Klima <Georg.Klima@durst-group.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"thunderbolt@lists.linux.dev" <thunderbolt@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"georg_klima@gmx.at" <georg_klima@gmx.at>
Subject: Re: [BUG] Thunderbolt runtime resume during PCIe removal causes IRQ
 warning and shutdown failure.
Message-ID: <20260326175733.GA1328693@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>

On Thu, Mar 26, 2026 at 04:09:05PM +0000, Georg Klima wrote:
> Hello,
> I am reporting a reproducible shutdown issue involving Thunderbolt, PCIe =
hotplug, and runtime PM on a Lenovo ThinkPad P16.
> System fails to power off cleanly when PCIe ASPM is enabled. After the ke=
rnel prints "Power off", it emits warnings and does not complete shutdown.
> Workaround:
> Booting with "pcie_aspm=3Doff" avoids the issue completely.
> Reproducible: Always

Thanks for the report!  If this ever worked on an older kernel,
bisecting is an option.  It would be ideal to confirm and bisect with
an upstream kernel.

I don't have any reason to think this would be specific to Fedora,
although the repro scenario is so simple that we should see lots of=20
reports if it's a problem in upstream.

"pcie_aspm=3Doff" is supposed to keep Linux from touching ASPM
configuration at all.  Can you collect the output of "sudo lspci -vv"
when booted that way, and again when booted without "pcie_aspm=3Doff"?

> Environment:
>=20
>   *   Hardware: Lenovo ThinkPad P16 (21RQ003BGE)
>   *   BIOS: N4FET30W (1.11) 10/03/2025
>   *   Kernel: 6.19.10-200.fc43.x86_64
>   *   Distribution: Fedora 43
>   *   Platform: Intel (Meteor Lake)
>   *   Thunderbolt controller: 0000:8a:00.0
>=20
> Steps to reproduce:
>=20
>   1.  Boot system with default kernel parameters (ASPM enabled)
>   2.  Run: systemctl poweroff
>   3.  Observe that system does not power off and prints kernel warnings
>=20
> Observed output (excerpt):
> thunderbolt 0000:8a:00.0: interrupt for TX ring 0 is already enabled
> WARNING: drivers/thunderbolt/nhi.c:147 at ring_interrupt_active+0x246/0x2=
f0 [thunderbolt]
> CPU: 17 PID: 204 Comm: irq/128-pciehp Tainted: G O 6.19.10-200.fc43.x86_6=
4 #1 PREEMPT(lazy)
> Call Trace:
> tb_ring_start+0x149/0x330 [thunderbolt]
> tb_ctl_start+0x1b/0xc0 [thunderbolt]
> tb_domain_runtime_resume+0x19/0x40 [thunderbolt]
> __rpm_callback+0x48/0x1f0
> rpm_callback+0x6d/0x80
> rpm_resume+0x4ab/0x6d0
> __pm_runtime_resume+0x52/0x90
> device_release_driver_internal+0xad/0x200
> pci_stop_bus_device+0x63/0x80
> pci_stop_and_remove_bus_device+0x16/0x30
> pciehp_unconfigure_device+0x96/0x170
> pciehp_disable_slot+0x66/0x110
> pciehp_handle_presence_or_link_change+0x65/0x160
> pciehp_ist+0x14f/0x1d0
> irq_thread_fn+0x25/0x60
> Additional warnings also observed:
> thunderbolt 0000:8a:00.0: interrupt for RX ring 0 is already enabled
> Earlier runs also produced:
> "BUG: scheduling while atomic"
> Additionally, xHCI reports:
> xhci_hcd ... Controller not ready at resume -19
> Analysis:
> The trace indicates that during PCIe hotplug removal (pciehp), the kernel=
 triggers a runtime PM resume:
> pci_stop_and_remove_bus_device
> =E2=86=92 device_release_driver_internal
> =E2=86=92 __pm_runtime_resume
> =E2=86=92 rpm_resume
> =E2=86=92 tb_domain_runtime_resume
> This results in Thunderbolt reinitializing rings and attempting to enable=
 interrupts that are already active, triggering warnings in ring_interrupt_=
active().
> This appears to be an ordering issue where runtime PM resume occurs durin=
g device teardown, possibly in IRQ thread context (pciehp), which may also =
explain the previously observed "scheduling while atomic".
> The issue is strongly dependent on ASPM behavior, suggesting interaction =
between PCIe link power management and runtime PM.
> Expected behavior:
>=20
>   *   System should power off cleanly
>   *   No runtime resume during device removal
>   *   No IRQ reinitialization warnings
>   *   No scheduling in atomic context
>=20
> Please let me know if further logs or testing (older kernels, mainline, d=
ebug options) would be helpful.
> Identical behaviour with 6.19.8-200.fc43.x86_64
> Thanks,
>=20
>=20
> Georg Klima
>=20
> Senior Engineer Image Processing
> Development Department / Innovation Center East
> [cid:a9da318e-f8cc-479a-9dfa-f541b757b072]
> Durst Austria GmbH
>=20
> Julius-Durst-Str. 11, 9900 Lienz, AUSTRIA
> VAT Rg. No.: ATU44640705
> P +43 485271777 612
> Georg.Klima@durst-group.com <mailto:Georg.Klima@durst-group.com>
> durst-group.com <https://www.durst-group.com>
>=20
>=20



> Mar 26 09:44:00 fedora kernel: Linux version 6.19.10-200.fc43.x86_64 (moc=
kbuild@68010f67a3dc45419d007174c1547ce9) (gcc (GCC) 15.2.1 20260123 (Red Ha=
t 15.2.1-7), GNU ld version 2.45.1-4.fc43) #1 SMP PREEMPT_DYNAMIC Wed Mar 2=
5 16:09:19 UTC 2026
> Mar 26 09:44:00 fedora kernel: Command line: BOOT_IMAGE=3D(hd0,gpt2)/vmli=
nuz-6.19.10-200.fc43.x86_64 root=3DUUID=3D2f377dfc-1d36-4d0e-8fdc-cd0a3d5d8=
d28 ro rootflags=3Dsubvol=3Droot rd.luks.uuid=3Dluks-73987f2e-002a-40e7-add=
4-6bfcdf615f80 rd.driver.blacklist=3Dnouveau,nova_core modprobe.blacklist=
=3Dnouveau,nova_core nvidia-drm.modeset=3D1
> Mar 26 09:44:00 fedora kernel: x86/split lock detection: #AC: crashing th=
e kernel on kernel split_locks and warning on user-space split_locks
> Mar 26 09:44:00 fedora kernel: BIOS-provided physical RAM map:
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x0000000000000000-0x00000=
0000009ffff] usable
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x00000000000a0000-0x00000=
000000fffff] reserved
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x0000000000100000-0x00000=
0004b52efff] usable
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x000000004b52f000-0x00000=
00052a2efff] reserved
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x0000000052a2f000-0x00000=
00053f2efff] ACPI NVS
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x0000000053f2f000-0x00000=
00053ffefff] ACPI data
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x0000000053fff000-0x00000=
00053ffffff] usable
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x0000000054000000-0x00000=
000687fffff] reserved
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x00000000c0000000-0x00000=
000cfffffff] reserved
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x00000000fed20000-0x00000=
000fed7ffff] reserved
> Mar 26 09:44:00 fedora kernel: BIOS-e820: [mem 0x0000000100000000-0x00000=
0188fffffff] usable
> Mar 26 09:44:00 fedora kernel: NX (Execute Disable) protection: active
> Mar 26 09:44:00 fedora kernel: APIC: Static calls initialized
> Mar 26 09:44:00 fedora kernel: efi: EFI v2.7 by Lenovo
> Mar 26 09:44:00 fedora kernel: efi: ACPI=3D0x53ffe000 ACPI 2.0=3D0x53ffe0=
14 SMBIOS=3D0x4ee37000 SMBIOS 3.0=3D0x4ee2a000 TPMFinalLog=3D0x53f06000 MEM=
ATTR=3D0x43186018 ESRT=3D0x44539d98 MOKvar=3D0x4bf37000 RNG=3D0x53ffc018 TP=
MEventLog=3D0x53fec018=20
> Mar 26 09:44:00 fedora kernel: random: crng init done
> Mar 26 09:44:00 fedora kernel: efi: Remove mem492: MMIO range=3D[0xc00000=
00-0xcfffffff] (256MB) from e820 map
> Mar 26 09:44:00 fedora kernel: e820: remove [mem 0xc0000000-0xcfffffff] r=
eserved
> Mar 26 09:44:00 fedora kernel: secureboot: Secure boot enabled
> Mar 26 09:44:00 fedora kernel: Kernel is locked down from EFI Secure Boot=
 mode; see man kernel_lockdown.7
> Mar 26 09:44:00 fedora kernel: SMBIOS 3.8.0 present.
> Mar 26 09:44:00 fedora kernel: DMI: LENOVO 21RQ003BGE/21RQ003BGE, BIOS N4=
FET30W (1.11 ) 10/03/2025
> Mar 26 09:44:00 fedora kernel: DMI: Memory slots populated: 2/4
> Mar 26 09:44:00 fedora kernel: tsc: Detected 3100.000 MHz processor
> Mar 26 09:44:00 fedora kernel: tsc: Detected 3072.000 MHz TSC
> Mar 26 09:44:00 fedora kernel: e820: update [mem 0x00000000-0x00000fff] u=
sable =3D=3D> reserved
> Mar 26 09:44:00 fedora kernel: e820: remove [mem 0x000a0000-0x000fffff] u=
sable
> Mar 26 09:44:00 fedora kernel: last_pfn =3D 0x1890000 max_arch_pfn =3D 0x=
400000000
> Mar 26 09:44:00 fedora kernel: MTRR map: 7 entries (3 fixed + 4 variable;=
 max 23), built from 10 variable MTRRs
> Mar 26 09:44:00 fedora kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- =
UC  WB  WP  UC- WT =20
> Mar 26 09:44:00 fedora kernel: x2apic: enabled by BIOS, switching to x2ap=
ic ops
> Mar 26 09:44:00 fedora kernel: last_pfn =3D 0x54000 max_arch_pfn =3D 0x40=
0000000
> Mar 26 09:44:00 fedora kernel: esrt: Reserving ESRT space from 0x00000000=
44539d98 to 0x0000000044539ee8.
> Mar 26 09:44:00 fedora kernel: e820: update [mem 0x44539000-0x44539fff] u=
sable =3D=3D> reserved
> Mar 26 09:44:00 fedora kernel: Using GB pages for direct mapping
> Mar 26 09:44:00 fedora kernel: secureboot: Secure boot enabled
> Mar 26 09:44:00 fedora kernel: RAMDISK: [mem 0x28713000-0x31c6ffff]
> Mar 26 09:44:00 fedora kernel: ACPI: Early table checksum verification di=
sabled
> Mar 26 09:44:00 fedora kernel: ACPI: RSDP 0x0000000053FFE014 000024 (v02 =
LENOVO)
> Mar 26 09:44:00 fedora kernel: ACPI: XSDT 0x0000000053FFD228 0001A4 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: FACP 0x000000004ED4B000 000114 (v06 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: DSDT 0x000000004ECC4000 0830A2 (v02 =
LENOVO ICL      00000002      01000013)
> Mar 26 09:44:00 fedora kernel: ACPI: FACS 0x0000000053EE3000 000040
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE4B000 00012E (v02 =
LENOVO TxtSsdt  00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE4A000 00038C (v02 =
LENOVO Pmax_Dev 00000001 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE49000 000626 (v02 =
LENOVO Cpu0Ist  00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE48000 0005FB (v02 =
LENOVO Cpu0Hwp  00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE47000 0001AB (v02 =
LENOVO Cpu0Psd  00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE46000 000394 (v02 =
LENOVO Cpu0Cst  00003001 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE44000 001BAF (v02 =
LENOVO ApIst    00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE42000 001620 (v02 =
LENOVO ApHwp    00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE40000 001349 (v02 =
LENOVO ApPsd    00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE3F000 000FBB (v02 =
LENOVO ApCst    00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE3B000 003BC8 (v02 =
LENOVO CpuSsdt  00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EE3A000 00059B (v02 =
LENOVO CtdpB    00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: DTPR 0x000000004EE38000 000088 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EDA1000 0012A6 (v02 =
LENOVO PDatTabl 00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004ED5C000 000DA0 (v02 =
LENOVO DTbtSsdt 00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004ED5B000 00060E (v02 =
LENOVO Tpm2Tabl 00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: TPM2 0x000000004ED5A000 00004C (v04 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004ED57000 002739 (v02 =
LENOVO IgfxSsdt 00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004ED4D000 009CEA (v02 =
LENOVO TcssSsdt 00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: ECDT 0x000000004ED4C000 000053 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: HPET 0x000000004ED4A000 000038 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: APIC 0x000000004ED49000 000358 (v05 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: MCFG 0x000000004ED48000 00003C (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004ECB5000 00E434 (v02 =
LENOVO ArSB_2DR 00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004ECB4000 0000FD (v02 =
LENOVO PID0Ssdt 00000010 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004ECB2000 001890 (v02 =
LENOVO ProjSsdt 00000010 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004ECAD000 004248 (v02 =
LENOVO DptfTabl 00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: LPIT 0x000000004EC99000 0000CC (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: WSMT 0x000000004EC98000 000028 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EC90000 00755A (v02 =
LENOVO TbtTypeC 00000000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: DBGP 0x000000004EC8F000 000034 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: DBG2 0x000000004EC8E000 00005C (v00 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: NHLT 0x000000004EC8D000 0009B8 (v00 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: MSDM 0x000000004EC8C000 000055 (v03 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004EC76000 001016 (v02 =
LENOVO UsbCTabl 00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: BATB 0x000000004EC74000 00004A (v02 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: DMAR 0x000000004BF72000 000098 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004BF6F000 0028FB (v02 =
LENOVO NvOptTbl 00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004BF6D000 0011A0 (v02 =
LENOVO St00Ssdt 00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: FPDT 0x000000004BF44000 000044 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004BF43000 00012E (v02 =
LENOVO TxtSsdt  00001000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004BF41000 0019AC (v02 =
LENOVO SocGpe   00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004BF3E000 0028D3 (v02 =
LENOVO SocCmn   00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: SSDT 0x000000004BF3B000 002F1B (v02 =
LENOVO PchGpe   00003000 INTL 20210930)
> Mar 26 09:44:00 fedora kernel: ACPI: PHAT 0x000000004BF3A000 0007CC (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: BGRT 0x000000004BF39000 000038 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: UEFI 0x0000000052E61000 000076 (v01 =
LENOVO TP-N4F   00001110 PTEC 00000002)
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving FACP table memory at [mem =
0x4ed4b000-0x4ed4b113]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving DSDT table memory at [mem =
0x4ecc4000-0x4ed470a1]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving FACS table memory at [mem =
0x53ee3000-0x53ee303f]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee4b000-0x4ee4b12d]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee4a000-0x4ee4a38b]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee49000-0x4ee49625]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee48000-0x4ee485fa]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee47000-0x4ee471aa]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee46000-0x4ee46393]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee44000-0x4ee45bae]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee42000-0x4ee4361f]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee40000-0x4ee41348]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee3f000-0x4ee3ffba]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee3b000-0x4ee3ebc7]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ee3a000-0x4ee3a59a]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving DTPR table memory at [mem =
0x4ee38000-0x4ee38087]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4eda1000-0x4eda22a5]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ed5c000-0x4ed5cd9f]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ed5b000-0x4ed5b60d]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving TPM2 table memory at [mem =
0x4ed5a000-0x4ed5a04b]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ed57000-0x4ed59738]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ed4d000-0x4ed56ce9]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving ECDT table memory at [mem =
0x4ed4c000-0x4ed4c052]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving HPET table memory at [mem =
0x4ed4a000-0x4ed4a037]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving APIC table memory at [mem =
0x4ed49000-0x4ed49357]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving MCFG table memory at [mem =
0x4ed48000-0x4ed4803b]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ecb5000-0x4ecc3433]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ecb4000-0x4ecb40fc]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ecb2000-0x4ecb388f]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ecad000-0x4ecb1247]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving LPIT table memory at [mem =
0x4ec99000-0x4ec990cb]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving WSMT table memory at [mem =
0x4ec98000-0x4ec98027]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ec90000-0x4ec97559]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving DBGP table memory at [mem =
0x4ec8f000-0x4ec8f033]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving DBG2 table memory at [mem =
0x4ec8e000-0x4ec8e05b]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving NHLT table memory at [mem =
0x4ec8d000-0x4ec8d9b7]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving MSDM table memory at [mem =
0x4ec8c000-0x4ec8c054]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4ec76000-0x4ec77015]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving BATB table memory at [mem =
0x4ec74000-0x4ec74049]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving DMAR table memory at [mem =
0x4bf72000-0x4bf72097]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4bf6f000-0x4bf718fa]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4bf6d000-0x4bf6e19f]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving FPDT table memory at [mem =
0x4bf44000-0x4bf44043]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4bf43000-0x4bf4312d]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4bf41000-0x4bf429ab]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4bf3e000-0x4bf408d2]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving SSDT table memory at [mem =
0x4bf3b000-0x4bf3df1a]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving PHAT table memory at [mem =
0x4bf3a000-0x4bf3a7cb]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving BGRT table memory at [mem =
0x4bf39000-0x4bf39037]
> Mar 26 09:44:00 fedora kernel: ACPI: Reserving UEFI table memory at [mem =
0x52e61000-0x52e61075]
> Mar 26 09:44:00 fedora kernel: APIC: Switched APIC routing to: cluster x2=
apic
> Mar 26 09:44:00 fedora kernel: No NUMA configuration found
> Mar 26 09:44:00 fedora kernel: Faking a node at [mem 0x0000000000000000-0=
x000000188fffffff]
> Mar 26 09:44:00 fedora kernel: NODE_DATA(0) allocated [mem 0x188ffd5280-0=
x188fffffff]
> Mar 26 09:44:00 fedora kernel: Zone ranges:
> Mar 26 09:44:00 fedora kernel:   DMA      [mem 0x0000000000001000-0x00000=
00000ffffff]
> Mar 26 09:44:00 fedora kernel:   DMA32    [mem 0x0000000001000000-0x00000=
000ffffffff]
> Mar 26 09:44:00 fedora kernel:   Normal   [mem 0x0000000100000000-0x00000=
0188fffffff]
> Mar 26 09:44:00 fedora kernel:   Device   empty
> Mar 26 09:44:00 fedora kernel: Movable zone start for each node
> Mar 26 09:44:00 fedora kernel: Early memory node ranges
> Mar 26 09:44:00 fedora kernel:   node   0: [mem 0x0000000000001000-0x0000=
00000009ffff]
> Mar 26 09:44:00 fedora kernel:   node   0: [mem 0x0000000000100000-0x0000=
00004b52efff]
> Mar 26 09:44:00 fedora kernel:   node   0: [mem 0x0000000053fff000-0x0000=
000053ffffff]
> Mar 26 09:44:00 fedora kernel:   node   0: [mem 0x0000000100000000-0x0000=
00188fffffff]
> Mar 26 09:44:00 fedora kernel: Initmem setup node 0 [mem 0x00000000000010=
00-0x000000188fffffff]
> Mar 26 09:44:00 fedora kernel: On node 0, zone DMA: 1 pages in unavailabl=
e ranges
> Mar 26 09:44:00 fedora kernel: On node 0, zone DMA: 96 pages in unavailab=
le ranges
> Mar 26 09:44:00 fedora kernel: On node 0, zone DMA32: 35536 pages in unav=
ailable ranges
> Mar 26 09:44:00 fedora kernel: On node 0, zone Normal: 16384 pages in una=
vailable ranges
> Mar 26 09:44:00 fedora kernel: ACPI: PM-Timer IO Port: 0x1808
> Mar 26 09:44:00 fedora kernel: ACPI: X2APIC_NMI (uid[0xffffffff] high lev=
el lint[0x1])
> Mar 26 09:44:00 fedora kernel: IOAPIC[0]: apic_id 2, version 32, address =
0xfec00000, GSI 0-119
> Mar 26 09:44:00 fedora kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_=
irq 2 dfl dfl)
> Mar 26 09:44:00 fedora kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_=
irq 9 high level)
> Mar 26 09:44:00 fedora kernel: ACPI: Using ACPI (MADT) for SMP configurat=
ion information
> Mar 26 09:44:00 fedora kernel: ACPI: HPET id: 0x8086a201 base: 0xfed00000
> Mar 26 09:44:00 fedora kernel: e820: update [mem 0x431a5000-0x431a5fff] u=
sable =3D=3D> reserved
> Mar 26 09:44:00 fedora kernel: TSC deadline timer available
> Mar 26 09:44:00 fedora kernel: CPU topo: Max. logical packages:   1
> Mar 26 09:44:00 fedora kernel: CPU topo: Max. logical nodes:      1
> Mar 26 09:44:00 fedora kernel: CPU topo: Num. nodes per package:  1
> Mar 26 09:44:00 fedora kernel: CPU topo: Max. logical dies:       1
> Mar 26 09:44:00 fedora kernel: CPU topo: Max. dies per package:   1
> Mar 26 09:44:00 fedora kernel: CPU topo: Max. threads per core:   1
> Mar 26 09:44:00 fedora kernel: CPU topo: Num. cores per package:    24
> Mar 26 09:44:00 fedora kernel: CPU topo: Num. threads per package:  24
> Mar 26 09:44:00 fedora kernel: CPU topo: Allowing 24 present CPUs plus 0 =
hotplug CPUs
> Mar 26 09:44:00 fedora kernel: PM: hibernation: Registered nosave memory:=
 [mem 0x00000000-0x00000fff]
> Mar 26 09:44:00 fedora kernel: PM: hibernation: Registered nosave memory:=
 [mem 0x000a0000-0x000fffff]
> Mar 26 09:44:00 fedora kernel: PM: hibernation: Registered nosave memory:=
 [mem 0x431a5000-0x431a5fff]
> Mar 26 09:44:00 fedora kernel: PM: hibernation: Registered nosave memory:=
 [mem 0x44539000-0x44539fff]
> Mar 26 09:44:00 fedora kernel: PM: hibernation: Registered nosave memory:=
 [mem 0x4b52f000-0x53ffefff]
> Mar 26 09:44:00 fedora kernel: PM: hibernation: Registered nosave memory:=
 [mem 0x54000000-0xffffffff]
> Mar 26 09:44:00 fedora kernel: [mem 0x68800000-0xfed1ffff] available for =
PCI devices
> Mar 26 09:44:00 fedora kernel: Booting paravirtualized kernel on bare har=
dware
> Mar 26 09:44:00 fedora kernel: clocksource: refined-jiffies: mask: 0xffff=
ffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> Mar 26 09:44:00 fedora kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bits=
:24 nr_cpu_ids:24 nr_node_ids:1
> Mar 26 09:44:00 fedora kernel: percpu: Embedded 84 pages/cpu s221184 r819=
2 d114688 u524288
> Mar 26 09:44:00 fedora kernel: pcpu-alloc: s221184 r8192 d114688 u524288 =
alloc=3D1*2097152
> Mar 26 09:44:00 fedora kernel: pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 0=
7=20
> Mar 26 09:44:00 fedora kernel: pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 1=
5=20
> Mar 26 09:44:00 fedora kernel: pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 2=
3=20
> Mar 26 09:44:00 fedora kernel: Kernel command line: BOOT_IMAGE=3D(hd0,gpt=
2)/vmlinuz-6.19.10-200.fc43.x86_64 root=3DUUID=3D2f377dfc-1d36-4d0e-8fdc-cd=
0a3d5d8d28 ro rootflags=3Dsubvol=3Droot rd.luks.uuid=3Dluks-73987f2e-002a-4=
0e7-add4-6bfcdf615f80 rd.driver.blacklist=3Dnouveau,nova_core modprobe.blac=
klist=3Dnouveau,nova_core nvidia-drm.modeset=3D1
> Mar 26 09:44:00 fedora kernel: printk: log buffer data + meta data: 26214=
4 + 917504 =3D 1179648 bytes
> Mar 26 09:44:00 fedora kernel: Dentry cache hash table entries: 8388608 (=
order: 14, 67108864 bytes, linear)
> Mar 26 09:44:00 fedora kernel: Inode-cache hash table entries: 4194304 (o=
rder: 13, 33554432 bytes, linear)
> Mar 26 09:44:00 fedora kernel: software IO TLB: area num 32.
> Mar 26 09:44:00 fedora kernel: Fallback order for Node 0: 0=20
> Mar 26 09:44:00 fedora kernel: Built 1 zonelists, mobility grouping on.  =
Total pages: 25015503
> Mar 26 09:44:00 fedora kernel: Policy zone: Normal
> Mar 26 09:44:00 fedora kernel: mem auto-init: stack:all(zero), heap alloc=
:on, heap free:off
> Mar 26 09:44:00 fedora kernel: SLUB: HWalign=3D64, Order=3D0-3, MinObject=
s=3D0, CPUs=3D24, Nodes=3D1
> Mar 26 09:44:00 fedora kernel: ftrace: allocating 63414 entries in 248 pa=
ges
> Mar 26 09:44:00 fedora kernel: ftrace: allocated 248 pages with 5 groups
> Mar 26 09:44:00 fedora kernel: Dynamic Preempt: lazy
> Mar 26 09:44:00 fedora kernel: rcu: Preemptible hierarchical RCU implemen=
tation.
> Mar 26 09:44:00 fedora kernel: rcu:         RCU event tracing is enabled.
> Mar 26 09:44:00 fedora kernel: rcu:         RCU restricting CPUs from NR_=
CPUS=3D8192 to nr_cpu_ids=3D24.
> Mar 26 09:44:00 fedora kernel:         Trampoline variant of Tasks RCU en=
abled.
> Mar 26 09:44:00 fedora kernel:         Rude variant of Tasks RCU enabled.
> Mar 26 09:44:00 fedora kernel:         Tracing variant of Tasks RCU enabl=
ed.
> Mar 26 09:44:00 fedora kernel: rcu: RCU calculated value of scheduler-enl=
istment delay is 100 jiffies.
> Mar 26 09:44:00 fedora kernel: rcu: Adjusting geometry for rcu_fanout_lea=
f=3D16, nr_cpu_ids=3D24
> Mar 26 09:44:00 fedora kernel: RCU Tasks: Setting shift to 5 and lim to 1=
 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D24.
> Mar 26 09:44:00 fedora kernel: RCU Tasks Rude: Setting shift to 5 and lim=
 to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D24.
> Mar 26 09:44:00 fedora kernel: RCU Tasks Trace: Setting shift to 5 and li=
m to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D24.
> Mar 26 09:44:00 fedora kernel: NR_IRQS: 524544, nr_irqs: 2248, preallocat=
ed irqs: 16
> Mar 26 09:44:00 fedora kernel: rcu: srcu_init: Setting srcu_struct sizes =
based on contention.
> Mar 26 09:44:00 fedora kernel: kfence: initialized - using 2097152 bytes =
for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
> Mar 26 09:44:00 fedora kernel: Console: colour dummy device 80x25
> Mar 26 09:44:00 fedora kernel: printk: legacy console [tty0] enabled
> Mar 26 09:44:00 fedora kernel: ACPI: Core revision 20250807
> Mar 26 09:44:00 fedora kernel: hpet: HPET dysfunctional in PC10. Force di=
sabled.
> Mar 26 09:44:00 fedora kernel: APIC: Switch to symmetric I/O mode setup
> Mar 26 09:44:00 fedora kernel: DMAR: Host address width 42
> Mar 26 09:44:00 fedora kernel: DMAR: DRHD base: 0x000000fc800000 flags: 0=
x0
> Mar 26 09:44:00 fedora kernel: DMAR: dmar0: reg_base_addr fc800000 ver 7:=
0 cap e9de008cee690462 ecap 1aca9a00f0ef5e
> Mar 26 09:44:00 fedora kernel: DMAR: DRHD base: 0x000000fc810000 flags: 0=
x1
> Mar 26 09:44:00 fedora kernel: DMAR: dmar1: reg_base_addr fc810000 ver 7:=
0 cap e9de008cee690462 ecap 1aca9a00f0efde
> Mar 26 09:44:00 fedora kernel: DMAR: SATC flags: 0x1
> Mar 26 09:44:00 fedora kernel: DMAR-IR: IOAPIC id 2 under DRHD base  0xfc=
810000 IOMMU 1
> Mar 26 09:44:00 fedora kernel: DMAR-IR: HPET id 0 under DRHD base 0xfc810=
000
> Mar 26 09:44:00 fedora kernel: DMAR-IR: Queued invalidation will be enabl=
ed to support x2apic and Intr-remapping.
> Mar 26 09:44:00 fedora kernel: DMAR-IR: Enabled IRQ remapping in x2apic m=
ode
> Mar 26 09:44:00 fedora kernel: clocksource: tsc-early: mask: 0xffffffffff=
ffffff max_cycles: 0x2c47f5688fc, max_idle_ns: 440795305069 ns
> Mar 26 09:44:00 fedora kernel: Calibrating delay loop (skipped), value ca=
lculated using timer frequency.. 6144.00 BogoMIPS (lpj=3D3072000)
> Mar 26 09:44:00 fedora kernel: CPU0: Thermal monitoring enabled (TM1)
> Mar 26 09:44:00 fedora kernel: x86/cpu: User Mode Instruction Prevention =
(UMIP) activated
> Mar 26 09:44:00 fedora kernel: CET detected: Indirect Branch Tracking ena=
bled
> Mar 26 09:44:00 fedora kernel: Last level iTLB entries: 4KB 0, 2MB 0, 4MB=
 0
> Mar 26 09:44:00 fedora kernel: Last level dTLB entries: 4KB 0, 2MB 0, 4MB=
 0, 1GB 0
> Mar 26 09:44:00 fedora kernel: process: using mwait in idle threads
> Mar 26 09:44:00 fedora kernel: mitigations: Enabled attack vectors: user_=
kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
> Mar 26 09:44:00 fedora kernel: Speculative Store Bypass: Mitigation: Spec=
ulative Store Bypass disabled via prctl
> Mar 26 09:44:00 fedora kernel: Spectre V2 : Mitigation: Enhanced / Automa=
tic IBRS
> Mar 26 09:44:00 fedora kernel: VMSCAPE: Mitigation: IBPB before exit to u=
serspace
> Mar 26 09:44:00 fedora kernel: Spectre V1 : Mitigation: usercopy/swapgs b=
arriers and __user pointer sanitization
> Mar 26 09:44:00 fedora kernel: Spectre V2 : mitigation: Enabling conditio=
nal Indirect Branch Prediction Barrier
> Mar 26 09:44:00 fedora kernel: x86/fpu: Supporting XSAVE feature 0x001: '=
x87 floating point registers'
> Mar 26 09:44:00 fedora kernel: x86/fpu: Supporting XSAVE feature 0x002: '=
SSE registers'
> Mar 26 09:44:00 fedora kernel: x86/fpu: Supporting XSAVE feature 0x004: '=
AVX registers'
> Mar 26 09:44:00 fedora kernel: x86/fpu: Supporting XSAVE feature 0x200: '=
Protection Keys User registers'
> Mar 26 09:44:00 fedora kernel: x86/fpu: Supporting XSAVE feature 0x800: '=
Control-flow User registers'
> Mar 26 09:44:00 fedora kernel: x86/fpu: Supporting XSAVE feature 0x1000: =
'Control-flow Kernel registers (KVM only)'
> Mar 26 09:44:00 fedora kernel: x86/fpu: xstate_offset[2]:  576, xstate_si=
zes[2]:  256
> Mar 26 09:44:00 fedora kernel: x86/fpu: xstate_offset[9]:  832, xstate_si=
zes[9]:    8
> Mar 26 09:44:00 fedora kernel: x86/fpu: xstate_offset[11]:  840, xstate_s=
izes[11]:   16
> Mar 26 09:44:00 fedora kernel: x86/fpu: xstate_offset[12]:  856, xstate_s=
izes[12]:   24
> Mar 26 09:44:00 fedora kernel: x86/fpu: Enabled xstate features 0x1a07, c=
ontext size is 880 bytes, using 'compacted' format.
> Mar 26 09:44:00 fedora kernel: Freeing SMP alternatives memory: 56K
> Mar 26 09:44:00 fedora kernel: pid_max: default: 32768 minimum: 301
> Mar 26 09:44:00 fedora kernel: Yama: becoming mindful.
> Mar 26 09:44:00 fedora kernel: SELinux:  Initializing.
> Mar 26 09:44:00 fedora kernel: LSM support for eBPF active
> Mar 26 09:44:00 fedora kernel: landlock: Up and running.
> Mar 26 09:44:00 fedora kernel: Mount-cache hash table entries: 131072 (or=
der: 8, 1048576 bytes, linear)
> Mar 26 09:44:00 fedora kernel: Mountpoint-cache hash table entries: 13107=
2 (order: 8, 1048576 bytes, linear)
> Mar 26 09:44:00 fedora kernel: smpboot: CPU0: Intel(R) Core(TM) Ultra 9 2=
75HX (family: 0x6, model: 0xc6, stepping: 0x2)
> Mar 26 09:44:00 fedora kernel: Performance Events: XSAVE Architectural LB=
R, PEBS fmt6+-baseline,  AnyThread deprecated, Lunarlake Hybrid events, 32-=
deep LBR, full-width counters, Intel PMU driver.
> Mar 26 09:44:00 fedora kernel: core: cpu_core PMU driver:=20
> Mar 26 09:44:00 fedora kernel: ... version:                   6
> Mar 26 09:44:00 fedora kernel: ... bit width:                 48
> Mar 26 09:44:00 fedora kernel: ... generic counters:          10
> Mar 26 09:44:00 fedora kernel: ... generic bitmap:            00000000000=
003ff
> Mar 26 09:44:00 fedora kernel: ... fixed-purpose counters:    4
> Mar 26 09:44:00 fedora kernel: ... fixed-purpose bitmap:      00000000000=
0000f
> Mar 26 09:44:00 fedora kernel: ... value mask:                0000fffffff=
fffff
> Mar 26 09:44:00 fedora kernel: ... max period:                00007ffffff=
fffff
> Mar 26 09:44:00 fedora kernel: ... global_ctrl mask:          0001000f000=
003ff
> Mar 26 09:44:00 fedora kernel: signal: max sigframe size: 3632
> Mar 26 09:44:00 fedora kernel: Estimated ratio of average max frequency b=
y base frequency (times 1024): 1717
> Mar 26 09:44:00 fedora kernel: rcu: Hierarchical SRCU implementation.
> Mar 26 09:44:00 fedora kernel: rcu:         Max phase no-delay instances =
is 400.
> Mar 26 09:44:00 fedora kernel: Timer migration: 2 hierarchy levels; 8 chi=
ldren per group; 2 crossnode level
> Mar 26 09:44:00 fedora kernel: NMI watchdog: Enabled. Permanently consume=
s one hw-PMU counter.
> Mar 26 09:44:00 fedora kernel: smp: Bringing up secondary CPUs ...
> Mar 26 09:44:00 fedora kernel: smpboot: x86: Booting SMP configuration:
> Mar 26 09:44:00 fedora kernel: .... node  #0, CPUs:        #1  #2  #3  #4=
  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
> Mar 26 09:44:00 fedora kernel: core: The event 0x5d0 is not supported as =
an auto-counter reload event.
> Mar 26 09:44:00 fedora kernel: core: cpu_atom PMU driver:=20
> Mar 26 09:44:00 fedora kernel: ... version:                   6
> Mar 26 09:44:00 fedora kernel: ... bit width:                 48
> Mar 26 09:44:00 fedora kernel: ... generic counters:          8
> Mar 26 09:44:00 fedora kernel: ... generic bitmap:            00000000000=
000ff
> Mar 26 09:44:00 fedora kernel: ... fixed-purpose counters:    6
> Mar 26 09:44:00 fedora kernel: ... fixed-purpose bitmap:      00000000000=
00077
> Mar 26 09:44:00 fedora kernel: ... value mask:                0000fffffff=
fffff
> Mar 26 09:44:00 fedora kernel: ... max period:                00007ffffff=
fffff
> Mar 26 09:44:00 fedora kernel: ... global_ctrl mask:          00000077000=
000ff
> Mar 26 09:44:00 fedora kernel: smp: Brought up 1 node, 24 CPUs
> Mar 26 09:44:00 fedora kernel: smpboot: Total of 24 processors activated =
(147456.00 BogoMIPS)
> Mar 26 09:44:00 fedora kernel: Memory: 97863412K/100062012K available (22=
589K kernel code, 4588K rwdata, 17848K rodata, 5196K init, 5796K bss, 21588=
92K reserved, 0K cma-reserved)
> Mar 26 09:44:00 fedora kernel: devtmpfs: initialized
> Mar 26 09:44:00 fedora kernel: x86/mm: Memory block size: 2048MB
> Mar 26 09:44:00 fedora kernel: ACPI: PM: Registering ACPI NVS region [mem=
 0x52a2f000-0x53f2efff] (22020096 bytes)
> Mar 26 09:44:00 fedora kernel: clocksource: jiffies: mask: 0xffffffff max=
_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> Mar 26 09:44:00 fedora kernel: posixtimers hash table entries: 16384 (ord=
er: 6, 262144 bytes, linear)
> Mar 26 09:44:00 fedora kernel: futex hash table entries: 8192 (524288 byt=
es on 1 NUMA nodes, total 512 KiB, linear).
> Mar 26 09:44:00 fedora kernel: PM: RTC time: 08:43:58, date: 2026-03-26
> Mar 26 09:44:00 fedora kernel: NET: Registered PF_NETLINK/PF_ROUTE protoc=
ol family
> Mar 26 09:44:00 fedora kernel: DMA: preallocated 4096 KiB GFP_KERNEL pool=
 for atomic allocations
> Mar 26 09:44:00 fedora kernel: DMA: preallocated 4096 KiB GFP_KERNEL|GFP_=
DMA pool for atomic allocations
> Mar 26 09:44:00 fedora kernel: DMA: preallocated 4096 KiB GFP_KERNEL|GFP_=
DMA32 pool for atomic allocations
> Mar 26 09:44:00 fedora kernel: audit: initializing netlink subsys (disabl=
ed)
> Mar 26 09:44:00 fedora kernel: audit: type=3D2000 audit(1774514638.022:1)=
: state=3Dinitialized audit_enabled=3D0 res=3D1
> Mar 26 09:44:00 fedora kernel: thermal_sys: Registered thermal governor '=
fair_share'
> Mar 26 09:44:00 fedora kernel: thermal_sys: Registered thermal governor '=
bang_bang'
> Mar 26 09:44:00 fedora kernel: thermal_sys: Registered thermal governor '=
step_wise'
> Mar 26 09:44:00 fedora kernel: thermal_sys: Registered thermal governor '=
user_space'
> Mar 26 09:44:00 fedora kernel: cpuidle: using governor menu
> Mar 26 09:44:00 fedora kernel: efi: Freeing EFI boot services memory: 197=
472K
> Mar 26 09:44:00 fedora kernel: acpiphp: ACPI Hot Plug PCI Controller Driv=
er version: 0.5
> Mar 26 09:44:00 fedora kernel: PCI: ECAM [mem 0xc0000000-0xcfffffff] (bas=
e 0xc0000000) for domain 0000 [bus 00-ff]
> Mar 26 09:44:00 fedora kernel: PCI: Using configuration type 1 for base a=
ccess
> Mar 26 09:44:00 fedora kernel: kprobes: kprobe jump-optimization is enabl=
ed. All kprobes are optimized if possible.
> Mar 26 09:44:00 fedora kernel: HugeTLB: registered 1.00 GiB page size, pr=
e-allocated 0 pages
> Mar 26 09:44:00 fedora kernel: HugeTLB: 16380 KiB vmemmap can be freed fo=
r a 1.00 GiB page
> Mar 26 09:44:00 fedora kernel: HugeTLB: registered 2.00 MiB page size, pr=
e-allocated 0 pages
> Mar 26 09:44:00 fedora kernel: HugeTLB: 28 KiB vmemmap can be freed for a=
 2.00 MiB page
> Mar 26 09:44:00 fedora kernel: raid6: skipped pq benchmark and selected a=
vx2x4
> Mar 26 09:44:00 fedora kernel: raid6: using avx2x2 recovery algorithm
> Mar 26 09:44:00 fedora kernel: fbcon: Taking over console
> Mar 26 09:44:00 fedora kernel: ACPI: Added _OSI(Module Device)
> Mar 26 09:44:00 fedora kernel: ACPI: Added _OSI(Processor Device)
> Mar 26 09:44:00 fedora kernel: ACPI: Added _OSI(Processor Aggregator Devi=
ce)
> Mar 26 09:44:00 fedora kernel: ACPI BIOS Error (bug): Failure creating na=
med object [\_SB.PC00.TXHC.RHUB.SS01._UPC], AE_ALREADY_EXISTS (20250807/dsw=
load2-326)
> Mar 26 09:44:00 fedora kernel: ACPI Error: AE_ALREADY_EXISTS, During name=
 lookup/catalog (20250807/psobject-220)
> Mar 26 09:44:00 fedora kernel: ACPI: Skipping parse of AML opcode: Method=
 (0x0014)
> Mar 26 09:44:00 fedora kernel: ACPI BIOS Error (bug): Failure creating na=
med object [\_SB.PC00.TXHC.RHUB.SS01._PLD], AE_ALREADY_EXISTS (20250807/dsw=
load2-326)
> Mar 26 09:44:00 fedora kernel: ACPI Error: AE_ALREADY_EXISTS, During name=
 lookup/catalog (20250807/psobject-220)
> Mar 26 09:44:00 fedora kernel: ACPI: Skipping parse of AML opcode: Method=
 (0x0014)
> Mar 26 09:44:00 fedora kernel: ACPI BIOS Error (bug): Failure creating na=
med object [\_SB.PC00.TXHC.RHUB.SS02._UPC], AE_ALREADY_EXISTS (20250807/dsw=
load2-326)
> Mar 26 09:44:00 fedora kernel: ACPI Error: AE_ALREADY_EXISTS, During name=
 lookup/catalog (20250807/psobject-220)
> Mar 26 09:44:00 fedora kernel: ACPI: Skipping parse of AML opcode: Method=
 (0x0014)
> Mar 26 09:44:00 fedora kernel: ACPI BIOS Error (bug): Failure creating na=
med object [\_SB.PC00.TXHC.RHUB.SS02._PLD], AE_ALREADY_EXISTS (20250807/dsw=
load2-326)
> Mar 26 09:44:00 fedora kernel: ACPI Error: AE_ALREADY_EXISTS, During name=
 lookup/catalog (20250807/psobject-220)
> Mar 26 09:44:00 fedora kernel: ACPI: Skipping parse of AML opcode: Method=
 (0x0014)
> Mar 26 09:44:00 fedora kernel: ACPI BIOS Error (bug): Could not resolve s=
ymbol [\_SB.PC02.RP21.PXSX.TBDU.XHCI.RHUB.SS01], AE_NOT_FOUND (20250807/dsw=
load2-162)
> Mar 26 09:44:00 fedora kernel: ACPI Error: AE_NOT_FOUND, During name look=
up/catalog (20250807/psobject-220)
> Mar 26 09:44:00 fedora kernel: ACPI: Skipping parse of AML opcode: Scope =
(0x0010)
> Mar 26 09:44:00 fedora kernel: ACPI BIOS Error (bug): Could not resolve s=
ymbol [\_SB.PC02.RP21.PXSX.TBDU.XHCI.RHUB.SS02], AE_NOT_FOUND (20250807/dsw=
load2-162)
> Mar 26 09:44:00 fedora kernel: ACPI Error: AE_NOT_FOUND, During name look=
up/catalog (20250807/psobject-220)
> Mar 26 09:44:00 fedora kernel: ACPI: Skipping parse of AML opcode: Scope =
(0x0010)
> Mar 26 09:44:00 fedora kernel: ACPI: 29 ACPI AML tables successfully acqu=
ired and loaded
> Mar 26 09:44:00 fedora kernel: ACPI Error: No pointer back to namespace n=
ode in package (____ptrval____) (20250807/dsargs-301)
> Mar 26 09:44:00 fedora kernel: ACPI Error: No pointer back to namespace n=
ode in package (____ptrval____) (20250807/dsargs-301)
> Mar 26 09:44:00 fedora kernel: ACPI: EC: EC started
> Mar 26 09:44:00 fedora kernel: ACPI: EC: interrupt blocked
> Mar 26 09:44:00 fedora kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0=
x62
> Mar 26 09:44:00 fedora kernel: ACPI: EC: Boot ECDT EC used to handle tran=
sactions
> Mar 26 09:44:00 fedora kernel: ACPI: [Firmware Bug]: BIOS _OSI(Linux) que=
ry ignored
> Mar 26 09:44:00 fedora kernel: ACPI: USB4 _OSC: OS supports USB3+ Display=
Port+ PCIe+ XDomain+
> Mar 26 09:44:00 fedora kernel: ACPI: USB4 _OSC: OS controls USB3+ Display=
Port+ PCIe+ XDomain+
> Mar 26 09:44:00 fedora kernel: ACPI: Interpreter enabled
> Mar 26 09:44:00 fedora kernel: ACPI: PM: (supports S0 S4 S5)
> Mar 26 09:44:00 fedora kernel: ACPI: Using IOAPIC for interrupt routing
> Mar 26 09:44:00 fedora kernel: PCI: Using host bridge windows from ACPI; =
if necessary, use "pci=3Dnocrs" and report a bug
> Mar 26 09:44:00 fedora kernel: PCI: Ignoring E820 reservations for host b=
ridge windows
> Mar 26 09:44:00 fedora kernel: ACPI: Enabled 10 GPEs in block 00 to 7F
> Mar 26 09:44:00 fedora kernel: ACPI: Enabled 8 GPEs in block 80 to DF
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC00.LPCB.EC__.PUBS: New power=
 resource
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC00.RP01.PG00: New power reso=
urce
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC00.RP21.PXP_: New power reso=
urce
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC00.TBT0: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC00.TBT1: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC00.D3C_: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.XHCI.RHUB.HS02.WWPR: New =
power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.XHCI.RHUB.HS14.BTRT: New =
power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.XHCI.RHUB.HS14.DBTR: New =
power resource
> Mar 26 09:44:00 fedora kernel: ACPI Error: No pointer back to namespace n=
ode in package (____ptrval____) (20250807/dsargs-301)
> Mar 26 09:44:00 fedora kernel: ACPI Error: No pointer back to namespace n=
ode in package (____ptrval____) (20250807/dsargs-301)
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.RP01.PXP_: New power reso=
urce
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.RP07.PXP_: New power reso=
urce
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.RP09.PXP_: New power reso=
urce
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.RP13.PXSX.SDPR: New power=
 resource
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.RP15.PXSX.WRST: New power=
 resource
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.RP17.PXP_: New power reso=
urce
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC02.RP21.PXP_: New power reso=
urce
> Mar 26 09:44:00 fedora kernel: ACPI: \PIN_: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \PPIN: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \PINP: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \SPR4: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \SPR5: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \SPR6: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: \SPR7: New power resource
> Mar 26 09:44:00 fedora kernel: ACPI: PCI Root Bridge [PC00] (domain 0000 =
[bus 00-7f])
> Mar 26 09:44:00 fedora kernel: acpi PNP0A08:00: _OSC: OS supports [Extend=
edConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> Mar 26 09:44:00 fedora kernel: acpi PNP0A08:00: _OSC: OS now controls [PC=
IeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
> Mar 26 09:44:00 fedora kernel: PCI host bridge to bus 0000:00
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: root bus resource [io  0x=
0000-0x0cf7 window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: root bus resource [io  0x=
9000-0xffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: root bus resource [mem 0x=
000a0000-0x000bffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: root bus resource [mem 0x=
70000000-0xaeffffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: root bus resource [mem 0x=
6000000000-0x3ffbfffffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: root bus resource [bus 00=
-7f]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:00.0: [8086:7d1c] type 00 clas=
s 0x060000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:01.0: [8086:7ecc] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:00:01.0: PCI bridge to [bus 04]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:01.0:   bridge window [mem 0x8=
2200000-0x822fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:01.0: PME# supported from D0 D=
3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:00:01.0: PTM enabled (root), 4ns =
granularity
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: [8086:7d67] type 00 clas=
s 0x030000 PCIe Root Complex Integrated Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: BAR 0 [mem 0x6848000000-=
0x6848ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: BAR 2 [mem 0x6810000000-=
0x681fffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: DMAR: Skip IOMMU disabli=
ng for graphics
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: Video device with shadow=
ed ROM at [mem 0x000c0000-0x000dffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: PME# supported from D0 D=
3hot
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: VF BAR 0 [mem 0x00000000=
-0x00ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: VF BAR 0 [mem 0x00000000=
-0x06ffffff 64bit pref]: contains BAR 0 for 7 VFs
> Mar 26 09:44:00 fedora kernel: pci 0000:00:04.0: [8086:ad03] type 00 clas=
s 0x118000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:04.0: BAR 0 [mem 0x6849080000-=
0x684909ffff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0: [8086:ae4d] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0: PCI bridge to [bus 01]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0:   bridge window [io  0x9=
000-0x9fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0:   bridge window [mem 0x7=
0000000-0x740fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0:   bridge window [mem 0x6=
000000000-0x6801ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0: PME# supported from D0 D=
3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0: PTM enabled (root), 4ns =
granularity
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0: [8086:7ec4] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0: PCI bridge to [bus 20-49]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0:   bridge window [mem 0x7=
6000000-0x821fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0:   bridge window [mem 0x6=
820000000-0x683bffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0: PME# supported from D0 D=
3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0: PTM enabled (root), 4ns =
granularity
> Mar 26 09:44:00 fedora kernel: pci 0000:00:08.0: [8086:ae4c] type 00 clas=
s 0x088000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:08.0: BAR 0 [mem 0x68490b7000-=
0x68490b7fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0a.0: [8086:ad0d] type 00 clas=
s 0x118000 PCIe Root Complex Integrated Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0a.0: BAR 0 [mem 0x6849040000-=
0x684907ffff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0a.0: enabling Extended Tags
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0b.0: [8086:ad1d] type 00 clas=
s 0x120000 PCIe Root Complex Integrated Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0b.0: BAR 0 [mem 0x6840000000-=
0x6847ffffff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0b.0: BAR 4 [mem 0x68490b6000-=
0x68490b6fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.0: [8086:7ec0] type 00 clas=
s 0x0c0330 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.0: BAR 0 [mem 0x68490a0000-=
0x68490affff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.0: PME# supported from D3ho=
t D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.2: [8086:7ec2] type 00 clas=
s 0x0c0340 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.2: BAR 0 [mem 0x6849000000-=
0x684903ffff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.2: BAR 2 [mem 0x68490b5000-=
0x68490b5fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.2: supports D1 D2
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.2: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:00:14.0: [8086:ae7f] type 00 clas=
s 0x050000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:14.0: BAR 0 [mem 0x68490b0000-=
0x68490b3fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:14.0: BAR 2 [mem 0x68490b4000-=
0x68490b4fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:1f.0: [8086:ae10] type 00 clas=
s 0x060100 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:1f.5: [8086:ae23] type 00 clas=
s 0x0c8000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0x=
fe010fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:04:00.0: [144d:a810] type 00 clas=
s 0x010802 PCIe Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:04:00.0: BAR 0 [mem 0x82200000-0x=
82203fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:01.0: PCI bridge to [bus 04]
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: [10de:2c38] type 00 clas=
s 0x030000 PCIe Legacy Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: BAR 0 [mem 0x70000000-0x=
73ffffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: BAR 1 [mem 0x6000000000-=
0x67ffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: BAR 3 [mem 0x6800000000-=
0x6801ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: BAR 5 [io  0x9000-0x907f]
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: ROM [mem 0xfff80000-0xff=
ffffff pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: Enabling HDA controller
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: PME# supported from D0 D=
3hot
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.1: [10de:22e9] type 00 clas=
s 0x040300 PCIe Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.1: BAR 0 [mem 0x74000000-0x=
74003fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0: PCI bridge to [bus 01]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0: PCI bridge to [bus 20-49]
> Mar 26 09:44:00 fedora kernel: ACPI: PCI Root Bridge [PC02] (domain 0000 =
[bus 80-df])
> Mar 26 09:44:00 fedora kernel: acpi PNP0A08:01: _OSC: OS supports [Extend=
edConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> Mar 26 09:44:00 fedora kernel: acpi PNP0A08:01: _OSC: OS now controls [PC=
IeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
> Mar 26 09:44:00 fedora kernel: PCI host bridge to bus 0000:80
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:80: root bus resource [io  0x=
2000-0x8bff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:80: root bus resource [mem 0x=
af000000-0xbdffffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:80: root bus resource [mem 0x=
4000000000-0x5fdfffffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:80: root bus resource [bus 80=
-df]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:14.0: [8086:7f6e] type 00 clas=
s 0x0c0330 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:14.0: BAR 0 [mem 0x5002a00000-=
0x5002a0ffff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:14.0: PME# supported from D3ho=
t D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:14.5: [8086:7f2f] type 00 clas=
s 0x000000 PCIe Root Complex Integrated Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:15.0: [8086:7f4c] type 00 clas=
s 0x0c8000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:15.0: BAR 0 [mem 0x00000000-0x=
00000fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:15.3: [8086:7f4f] type 00 clas=
s 0x0c8000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:15.3: BAR 0 [mem 0x5002a18000-=
0x5002a18fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:16.0: [8086:7f68] type 00 clas=
s 0x078000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:16.0: BAR 0 [mem 0x5002a17000-=
0x5002a17fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:16.0: PME# supported from D3hot
> Mar 26 09:44:00 fedora kernel: pci 0000:80:19.0: [8086:7f7a] type 00 clas=
s 0x0c8000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:19.0: BAR 0 [mem 0x00000000-0x=
00000fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:19.1: [8086:7f7b] type 00 clas=
s 0x0c8000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:19.1: BAR 0 [mem 0x00000000-0x=
00000fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0: [8086:7f40] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0: PCI bridge to [bus 83]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0:   bridge window [io  0x5=
000-0x5fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0:   bridge window [mem 0xb=
a100000-0xbaafffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0:   bridge window [mem 0x5=
000200000-0x5000bfffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: [8086:7f44] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: PCI bridge to [bus 88-d8]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4:   bridge window [mem 0xb=
0000000-0xb7ffffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4:   bridge window [mem 0x4=
000000000-0x4fffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: PME# supported from D0 D=
3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0: [8086:7f38] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0: PCI bridge to [bus 81]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0:   bridge window [io  0x4=
000-0x4fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0:   bridge window [mem 0xb=
9700000-0xba0fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0:   bridge window [mem 0x5=
000c00000-0x50015fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.6: [8086:7f3e] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.6: PCI bridge to [bus 86]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.6:   bridge window [mem 0xb=
9500000-0xb96fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.6: PME# supported from D0 D=
3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.6: PTM enabled (root), 4ns =
granularity
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0: [8086:7f30] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0: PCI bridge to [bus 82]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0:   bridge window [io  0x3=
000-0x3fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0:   bridge window [mem 0xb=
8b00000-0xb94fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0:   bridge window [mem 0x5=
001600000-0x5001ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4: [8086:7f34] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4: PCI bridge to [bus 85]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4:   bridge window [io  0x2=
000-0x2fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4:   bridge window [mem 0xb=
8100000-0xb8afffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4:   bridge window [mem 0x5=
002000000-0x50029fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4: PME# supported from D0 D=
3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4: PTM enabled (root), 4ns =
granularity
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.6: [8086:7f36] type 01 clas=
s 0x060400 PCIe Root Port
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.6: PCI bridge to [bus 84]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.6:   bridge window [mem 0xb=
8000000-0xb80fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.6: PME# supported from D0 D=
3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.6: PTM enabled (root), 4ns =
granularity
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.0: [8086:7f12] type 00 clas=
s 0x060100 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.3: [8086:7f50] type 00 clas=
s 0x040100 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.3: BAR 0 [mem 0x5002a10000-=
0x5002a13fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.3: BAR 4 [mem 0x5000000000-=
0x50001fffff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.3: PME# supported from D3ho=
t D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.4: [8086:7f23] type 00 clas=
s 0x0c0500 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.4: BAR 0 [mem 0x5002a14000-=
0x5002a140ff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.4: BAR 4 [io  0x6000-0x601f]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.5: [8086:7f24] type 00 clas=
s 0x0c8000 conventional PCI endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.5: BAR 0 [mem 0xbab00000-0x=
bab00fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0: PCI bridge to [bus 83]
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Upstream Port
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: PCI bridge to [bus 89-d8]
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0xb=
0000000-0xb7ffffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0x4=
000000000-0x4fffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: enabling Extended Tags
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: supports D1 D2
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: PCI bridge to [bus 88-d8]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Downstream Port
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0: PCI bridge to [bus 8a]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0:   bridge window [mem 0x4=
ffff00000-0x4fffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0: enabling Extended Tags
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0: supports D1 D2
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Downstream Port
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: PCI bridge to [bus 8b-b0]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0xb=
4000000-0xb7efffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0x0=
0000000-0xffefffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: enabling Extended Tags
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: supports D1 D2
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Downstream Port
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0: PCI bridge to [bus b1]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0:   bridge window [mem 0xb=
7f00000-0xb7ffffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0: enabling Extended Tags
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0: supports D1 D2
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Downstream Port
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: PCI bridge to [bus b2-d8]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0xb=
0000000-0xb3efffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0x0=
0000000-0xffefffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: enabling Extended Tags
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: supports D1 D2
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: PCI bridge to [bus 89-d8]
> Mar 26 09:44:00 fedora kernel: pci 0000:8a:00.0: [8086:5781] type 00 clas=
s 0x0c0340 PCIe Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:8a:00.0: BAR 0 [mem 0x4ffff00000-=
0x4ffff3ffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:8a:00.0: BAR 2 [mem 0x4ffff40000-=
0x4ffff40fff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:8a:00.0: enabling Extended Tags
> Mar 26 09:44:00 fedora kernel: pci 0000:8a:00.0: supports D1 D2
> Mar 26 09:44:00 fedora kernel: pci 0000:8a:00.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0: PCI bridge to [bus 8a]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: PCI bridge to [bus 8b-b0]
> Mar 26 09:44:00 fedora kernel: pci 0000:b1:00.0: [8086:5782] type 00 clas=
s 0x0c0330 PCIe Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:b1:00.0: BAR 0 [mem 0xb7f00000-0x=
b7f0ffff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:b1:00.0: enabling Extended Tags
> Mar 26 09:44:00 fedora kernel: pci 0000:b1:00.0: PME# supported from D3ho=
t D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0: PCI bridge to [bus b1]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: PCI bridge to [bus b2-d8]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0: PCI bridge to [bus 81]
> Mar 26 09:44:00 fedora kernel: pci 0000:86:00.0: [8086:125c] type 00 clas=
s 0x020000 PCIe Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:86:00.0: BAR 0 [mem 0xb9500000-0x=
b95fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:86:00.0: BAR 3 [mem 0xb9600000-0x=
b9603fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:86:00.0: PME# supported from D0 D=
3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.6: PCI bridge to [bus 86]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0: PCI bridge to [bus 82]
> Mar 26 09:44:00 fedora kernel: pci 0000:85:00.0: [10ec:5264] type 00 clas=
s 0xff0000 PCIe Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:85:00.0: BAR 1 [mem 0xb8100000-0x=
b8100fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:85:00.0: supports D1 D2
> Mar 26 09:44:00 fedora kernel: pci 0000:85:00.0: PME# supported from D1 D=
2 D3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4: PCI bridge to [bus 85]
> Mar 26 09:44:00 fedora kernel: pci 0000:84:00.0: [8086:272b] type 00 clas=
s 0x028000 PCIe Endpoint
> Mar 26 09:44:00 fedora kernel: pci 0000:84:00.0: BAR 0 [mem 0xb8000000-0x=
b8003fff 64bit]
> Mar 26 09:44:00 fedora kernel: pci 0000:84:00.0: PME# supported from D0 D=
3hot D3cold
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.6: PCI bridge to [bus 84]
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PEPD: Duplicate LPS0 _DSM func=
tions (mask: 0x1)
> Mar 26 09:44:00 fedora kernel: Low-power S0 idle used by default for syst=
em suspend
> Mar 26 09:44:00 fedora kernel: ACPI: EC: interrupt unblocked
> Mar 26 09:44:00 fedora kernel: ACPI: EC: event unblocked
> Mar 26 09:44:00 fedora kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0=
x62
> Mar 26 09:44:00 fedora kernel: ACPI: EC: GPE=3D0x46
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC00.LPCB.EC__: Boot ECDT EC i=
nitialization complete
> Mar 26 09:44:00 fedora kernel: ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to ha=
ndle transactions and events
> Mar 26 09:44:00 fedora kernel: iommu: Default domain type: Translated
> Mar 26 09:44:00 fedora kernel: iommu: DMA domain TLB invalidation policy:=
 lazy mode
> Mar 26 09:44:00 fedora kernel: SCSI subsystem initialized
> Mar 26 09:44:00 fedora kernel: libata version 3.00 loaded.
> Mar 26 09:44:00 fedora kernel: ACPI: bus type USB registered
> Mar 26 09:44:00 fedora kernel: usbcore: registered new interface driver u=
sbfs
> Mar 26 09:44:00 fedora kernel: usbcore: registered new interface driver h=
ub
> Mar 26 09:44:00 fedora kernel: usbcore: registered new device driver usb
> Mar 26 09:44:00 fedora kernel: pps_core: LinuxPPS API ver. 1 registered
> Mar 26 09:44:00 fedora kernel: pps_core: Software ver. 5.3.6 - Copyright =
2005-2007 Rodolfo Giometti <giometti@linux.it>
> Mar 26 09:44:00 fedora kernel: PTP clock support registered
> Mar 26 09:44:00 fedora kernel: EDAC MC: Ver: 3.0.0
> Mar 26 09:44:00 fedora kernel: efivars: Registered efivars operations
> Mar 26 09:44:00 fedora kernel: NetLabel: Initializing
> Mar 26 09:44:00 fedora kernel: NetLabel:  domain hash size =3D 128
> Mar 26 09:44:00 fedora kernel: NetLabel:  protocols =3D UNLABELED CIPSOv4=
 CALIPSO
> Mar 26 09:44:00 fedora kernel: NetLabel:  unlabeled traffic allowed by de=
fault
> Mar 26 09:44:00 fedora kernel: mctp: management component transport proto=
col core
> Mar 26 09:44:00 fedora kernel: NET: Registered PF_MCTP protocol family
> Mar 26 09:44:00 fedora kernel: PCI: Using ACPI for IRQ routing
> Mar 26 09:44:00 fedora kernel: PCI: pci_cache_line_size set to 64 bytes
> Mar 26 09:44:00 fedora kernel: pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0x=
fe010fff]: can't claim; no compatible bridge window
> Mar 26 09:44:00 fedora kernel: e820: reserve RAM buffer [mem 0x431a5000-0=
x43ffffff]
> Mar 26 09:44:00 fedora kernel: e820: reserve RAM buffer [mem 0x44539000-0=
x47ffffff]
> Mar 26 09:44:00 fedora kernel: e820: reserve RAM buffer [mem 0x4b52f000-0=
x4bffffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: vgaarb: setting as boot =
VGA device
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: vgaarb: bridge control p=
ossible
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: vgaarb: VGA device added=
: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: vgaarb: bridge control p=
ossible
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: vgaarb: VGA device added=
: decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
> Mar 26 09:44:00 fedora kernel: vgaarb: loaded
> Mar 26 09:44:00 fedora kernel: Monitor-Mwait will be used to enter C-1 st=
ate
> Mar 26 09:44:00 fedora kernel: Monitor-Mwait will be used to enter C-2 st=
ate
> Mar 26 09:44:00 fedora kernel: Monitor-Mwait will be used to enter C-3 st=
ate
> Mar 26 09:44:00 fedora kernel: clocksource: Switched to clocksource tsc-e=
arly
> Mar 26 09:44:00 fedora kernel: VFS: Disk quotas dquot_6.6.0
> Mar 26 09:44:00 fedora kernel: VFS: Dquot-cache hash table entries: 512 (=
order 0, 4096 bytes)
> Mar 26 09:44:00 fedora kernel: pnp: PnP ACPI init
> Mar 26 09:44:00 fedora kernel: system 00:00: [io  0x0680-0x069f] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:00: [io  0x164e-0x164f] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x1800-0x189f] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x0800-0x087f] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x0880-0x08ff] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x0900-0x097f] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x0980-0x09ff] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x0a00-0x0a7f] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x0a80-0x0aff] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x0b00-0x0b7f] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x0b80-0x0bff] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x15e0-0x15ef] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x1600-0x167f] could no=
t be reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [io  0x1640-0x165f] could no=
t be reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [mem 0xc0000000-0xcfffffff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [mem 0xfed10000-0xfed13fff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [mem 0xfed18000-0xfed18fff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [mem 0xfed19000-0xfed19fff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [mem 0xfeb00000-0xfebfffff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [mem 0xfed20000-0xfed3ffff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: system 00:03: [mem 0xfed90000-0xfed93fff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: pnp 00:04: disabling [mem 0x00000000-0x000=
00fff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64=
bit pref]
> Mar 26 09:44:00 fedora kernel: pnp 00:04: disabling [mem 0x00000000-0x000=
00fff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64=
bit pref]
> Mar 26 09:44:00 fedora kernel: system 00:04: [mem 0xfedc0000-0xfedc7fff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: system 00:04: [mem 0xc0000000-0xcfffffff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: system 00:04: [mem 0xfed20000-0xfed7ffff] =
could not be reserved
> Mar 26 09:44:00 fedora kernel: system 00:04: [mem 0xfc800000-0xfc81ffff] =
could not be reserved
> Mar 26 09:44:00 fedora kernel: system 00:04: [mem 0xfed45000-0xfed8ffff] =
could not be reserved
> Mar 26 09:44:00 fedora kernel: system 00:04: [mem 0xfee00000-0xfeefffff] =
has been reserved
> Mar 26 09:44:00 fedora kernel: system 00:05: [io  0xff00-0xfffe] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: system 00:06: [io  0x1854-0x1857] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000c0000-0x000=
c3fff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000c8000-0x000=
cbfff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000d0000-0x000=
d3fff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000d8000-0x000=
dbfff] because it overlaps 0000:00:02.0 BAR 6 [mem 0x000c0000-0x000dffff]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x00000000-0x000=
9ffff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64=
bit pref]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000c0000-0x000=
c3fff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06=
ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000c8000-0x000=
cbfff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06=
ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000d0000-0x000=
d3fff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06=
ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000d8000-0x000=
dbfff disabled] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06=
ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000e0000-0x000=
e3fff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64=
bit pref]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000e8000-0x000=
ebfff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64=
bit pref]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x000f0000-0x000=
fffff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64=
bit pref]
> Mar 26 09:44:00 fedora kernel: pnp 00:07: disabling [mem 0x00100000-0x6ff=
fffff] because it overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64=
bit pref]
> Mar 26 09:44:00 fedora kernel: system 00:07: [mem 0xfec00000-0xfed3ffff] =
could not be reserved
> Mar 26 09:44:00 fedora kernel: system 00:07: [mem 0xfed4c000-0xffffffff] =
could not be reserved
> Mar 26 09:44:00 fedora kernel: system 00:08: [io  0x8c00-0x8cfe] has been=
 reserved
> Mar 26 09:44:00 fedora kernel: pnp: PnP ACPI: found 9 devices
> Mar 26 09:44:00 fedora kernel: clocksource: acpi_pm: mask: 0xffffff max_c=
ycles: 0xffffff, max_idle_ns: 2085701024 ns
> Mar 26 09:44:00 fedora kernel: NET: Registered PF_INET protocol family
> Mar 26 09:44:00 fedora kernel: IP idents hash table entries: 262144 (orde=
r: 9, 2097152 bytes, linear)
> Mar 26 09:44:00 fedora kernel: tcp_listen_portaddr_hash hash table entrie=
s: 65536 (order: 8, 1048576 bytes, linear)
> Mar 26 09:44:00 fedora kernel: Table-perturb hash table entries: 65536 (o=
rder: 6, 262144 bytes, linear)
> Mar 26 09:44:00 fedora kernel: TCP established hash table entries: 524288=
 (order: 10, 4194304 bytes, linear)
> Mar 26 09:44:00 fedora kernel: TCP bind hash table entries: 65536 (order:=
 9, 2097152 bytes, linear)
> Mar 26 09:44:00 fedora kernel: TCP: Hash tables configured (established 5=
24288 bind 65536)
> Mar 26 09:44:00 fedora kernel: MPTCP token hash table entries: 65536 (ord=
er: 9, 1572864 bytes, linear)
> Mar 26 09:44:00 fedora kernel: UDP hash table entries: 65536 (order: 10, =
4194304 bytes, linear)
> Mar 26 09:44:00 fedora kernel: UDP-Lite hash table entries: 65536 (order:=
 10, 4194304 bytes, linear)
> Mar 26 09:44:00 fedora kernel: NET: Registered PF_UNIX/PF_LOCAL protocol =
family
> Mar 26 09:44:00 fedora kernel: NET: Registered PF_XDP protocol family
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: ROM [mem 0xfff80000-0xff=
ffffff pref]: can't claim; no compatible bridge window
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0: bridge window [io  0x100=
0-0x0fff] to [bus 20-49] add_size 1000
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: VF BAR 0 [mem 0x68020000=
00-0x6808ffffff 64bit pref]: assigned
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0: bridge window [io  0xa00=
0-0xafff]: assigned
> Mar 26 09:44:00 fedora kernel: pci 0000:00:1f.5: BAR 0 [mem 0x74100000-0x=
74100fff]: assigned
> Mar 26 09:44:00 fedora kernel: pci 0000:00:01.0: PCI bridge to [bus 04]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:01.0:   bridge window [mem 0x8=
2200000-0x822fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: ROM [mem 0x74080000-0x74=
0fffff pref]: assigned
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0: PCI bridge to [bus 01]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0:   bridge window [io  0x9=
000-0x9fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0:   bridge window [mem 0x7=
0000000-0x740fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0:   bridge window [mem 0x6=
000000000-0x6801ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0: PCI bridge to [bus 20-49]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0:   bridge window [io  0xa=
000-0xafff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0:   bridge window [mem 0x7=
6000000-0x821fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0:   bridge window [mem 0x6=
820000000-0x683bffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x=
0cf7 window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: resource 5 [io  0x9000-0x=
ffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: resource 6 [mem 0x000a000=
0-0x000bffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: resource 7 [mem 0x7000000=
0-0xaeffffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:00: resource 8 [mem 0x6000000=
000-0x3ffbfffffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:04: resource 1 [mem 0x8220000=
0-0x822fffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:01: resource 0 [io  0x9000-0x=
9fff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:01: resource 1 [mem 0x7000000=
0-0x740fffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:01: resource 2 [mem 0x6000000=
000-0x6801ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:20: resource 0 [io  0xa000-0x=
afff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:20: resource 1 [mem 0x7600000=
0-0x821fffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:20: resource 2 [mem 0x6820000=
000-0x683bffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: bridge window [io  0x100=
0-0x0fff] to [bus 8b-b0] add_size 1000
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: bridge window [mem 0x001=
00000-0x000fffff 64bit pref] to [bus 8b-b0] add_size 200000 add_align 100000
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: bridge window [io  0x100=
0-0x0fff] to [bus b2-d8] add_size 1000
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: bridge window [mem 0x001=
00000-0x000fffff 64bit pref] to [bus b2-d8] add_size 200000 add_align 100000
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: bridge window [io  0x100=
0-0x0fff] to [bus 89-d8] add_size 2000
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: bridge window [io  0x100=
0-0x0fff] to [bus 88-d8] add_size 3000
> Mar 26 09:44:00 fedora kernel: pci 0000:80:15.0: BAR 0 [mem 0x5002a15000-=
0x5002a15fff 64bit]: assigned
> Mar 26 09:44:00 fedora kernel: pci 0000:80:19.0: BAR 0 [mem 0x5002a16000-=
0x5002a16fff 64bit]: assigned
> Mar 26 09:44:00 fedora kernel: pci 0000:80:19.1: BAR 0 [mem 0x5002a19000-=
0x5002a19fff 64bit]: assigned
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: bridge window [io  size =
0x3000]: can't assign; no space
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: bridge window [io  size =
0x3000]: failed to assign
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: bridge window [io  size =
0x3000]: can't assign; no space
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: bridge window [io  size =
0x3000]: failed to assign
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0: PCI bridge to [bus 83]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0:   bridge window [io  0x5=
000-0x5fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0:   bridge window [mem 0xb=
a100000-0xbaafffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0:   bridge window [mem 0x5=
000200000-0x5000bfffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: bridge window [io  size =
0x2000]: can't assign; no space
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: bridge window [io  size =
0x2000]: failed to assign
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: bridge window [io  size =
0x2000]: can't assign; no space
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: bridge window [io  size =
0x2000]: failed to assign
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: bridge window [mem 0x400=
0000000-0x40001fffff 64bit pref]: assigned
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: bridge window [mem 0x400=
0200000-0x40003fffff 64bit pref]: assigned
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0: PCI bridge to [bus 8a]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0:   bridge window [mem 0x4=
ffff00000-0x4fffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: PCI bridge to [bus 8b-b0]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0xb=
4000000-0xb7efffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0x4=
000000000-0x40001fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0: PCI bridge to [bus b1]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0:   bridge window [mem 0xb=
7f00000-0xb7ffffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: PCI bridge to [bus b2-d8]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0xb=
0000000-0xb3efffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0x4=
000200000-0x40003fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: PCI bridge to [bus 89-d8]
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0xb=
0000000-0xb7ffffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0x4=
000000000-0x4fffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: PCI bridge to [bus 88-d8]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4:   bridge window [mem 0xb=
0000000-0xb7ffffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4:   bridge window [mem 0x4=
000000000-0x4fffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0: PCI bridge to [bus 81]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0:   bridge window [io  0x4=
000-0x4fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0:   bridge window [mem 0xb=
9700000-0xba0fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0:   bridge window [mem 0x5=
000c00000-0x50015fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.6: PCI bridge to [bus 86]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.6:   bridge window [mem 0xb=
9500000-0xb96fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0: PCI bridge to [bus 82]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0:   bridge window [io  0x3=
000-0x3fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0:   bridge window [mem 0xb=
8b00000-0xb94fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0:   bridge window [mem 0x5=
001600000-0x5001ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4: PCI bridge to [bus 85]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4:   bridge window [io  0x2=
000-0x2fff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4:   bridge window [mem 0xb=
8100000-0xb8afffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4:   bridge window [mem 0x5=
002000000-0x50029fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.6: PCI bridge to [bus 84]
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.6:   bridge window [mem 0xb=
8000000-0xb80fffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:80: Some PCI device resources=
 are unassigned, try booting with pci=3Drealloc
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:80: resource 4 [io  0x2000-0x=
8bff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:80: resource 5 [mem 0xaf00000=
0-0xbdffffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:80: resource 6 [mem 0x4000000=
000-0x5fdfffffff window]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:83: resource 0 [io  0x5000-0x=
5fff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:83: resource 1 [mem 0xba10000=
0-0xbaafffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:83: resource 2 [mem 0x5000200=
000-0x5000bfffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:88: resource 0 [io  size 0x30=
00]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:88: resource 1 [mem 0xb000000=
0-0xb7ffffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:88: resource 2 [mem 0x4000000=
000-0x4fffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:89: resource 0 [io  size 0x20=
00]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:89: resource 1 [mem 0xb000000=
0-0xb7ffffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:89: resource 2 [mem 0x4000000=
000-0x4fffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:8a: resource 2 [mem 0x4ffff00=
000-0x4fffffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:8b: resource 0 [io  size 0x10=
00]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:8b: resource 1 [mem 0xb400000=
0-0xb7efffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:8b: resource 2 [mem 0x4000000=
000-0x40001fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:b1: resource 1 [mem 0xb7f0000=
0-0xb7ffffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:b2: resource 0 [io  size 0x10=
00]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:b2: resource 1 [mem 0xb000000=
0-0xb3efffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:b2: resource 2 [mem 0x4000200=
000-0x40003fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:81: resource 0 [io  0x4000-0x=
4fff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:81: resource 1 [mem 0xb970000=
0-0xba0fffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:81: resource 2 [mem 0x5000c00=
000-0x50015fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:86: resource 1 [mem 0xb950000=
0-0xb96fffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:82: resource 0 [io  0x3000-0x=
3fff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:82: resource 1 [mem 0xb8b0000=
0-0xb94fffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:82: resource 2 [mem 0x5001600=
000-0x5001ffffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:85: resource 0 [io  0x2000-0x=
2fff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:85: resource 1 [mem 0xb810000=
0-0xb8afffff]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:85: resource 2 [mem 0x5002000=
000-0x50029fffff 64bit pref]
> Mar 26 09:44:00 fedora kernel: pci_bus 0000:84: resource 1 [mem 0xb800000=
0-0xb80fffff]
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.0: enabling device (0000 ->=
 0002)
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.1: extending delay after po=
wer-on from D3hot to 20 msec
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.1: D0 power state depends o=
n 0000:01:00.0
> Mar 26 09:44:00 fedora kernel: pci 0000:b1:00.0: enabling device (0000 ->=
 0002)
> Mar 26 09:44:00 fedora kernel: PCI: CLS 128 bytes, default 64
> Mar 26 09:44:00 fedora kernel: DMAR: Intel-IOMMU force enabled due to pla=
tform opt in
> Mar 26 09:44:00 fedora kernel: DMAR: No RMRR found
> Mar 26 09:44:00 fedora kernel: DMAR: No ATSR found
> Mar 26 09:44:00 fedora kernel: DMAR: dmar0: Using Queued invalidation
> Mar 26 09:44:00 fedora kernel: DMAR: dmar1: Using Queued invalidation
> Mar 26 09:44:00 fedora kernel: Trying to unpack rootfs image as initramfs=
=2E..
> Mar 26 09:44:00 fedora kernel: pci 0000:00:02.0: Adding to iommu group 0
> Mar 26 09:44:00 fedora kernel: pci 0000:00:00.0: Adding to iommu group 1
> Mar 26 09:44:00 fedora kernel: pci 0000:00:01.0: Adding to iommu group 2
> Mar 26 09:44:00 fedora kernel: pci 0000:00:04.0: Adding to iommu group 3
> Mar 26 09:44:00 fedora kernel: pci 0000:00:06.0: Adding to iommu group 4
> Mar 26 09:44:00 fedora kernel: pci 0000:00:07.0: Adding to iommu group 5
> Mar 26 09:44:00 fedora kernel: pci 0000:00:08.0: Adding to iommu group 6
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0a.0: Adding to iommu group 7
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0b.0: Adding to iommu group 8
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.0: Adding to iommu group 9
> Mar 26 09:44:00 fedora kernel: pci 0000:00:0d.2: Adding to iommu group 9
> Mar 26 09:44:00 fedora kernel: pci 0000:00:14.0: Adding to iommu group 10
> Mar 26 09:44:00 fedora kernel: pci 0000:00:1f.0: Adding to iommu group 11
> Mar 26 09:44:00 fedora kernel: pci 0000:00:1f.5: Adding to iommu group 11
> Mar 26 09:44:00 fedora kernel: pci 0000:04:00.0: Adding to iommu group 12
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.0: Adding to iommu group 13
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.1: Adding to iommu group 13
> Mar 26 09:44:00 fedora kernel: pci 0000:80:14.0: Adding to iommu group 14
> Mar 26 09:44:00 fedora kernel: pci 0000:80:14.5: Adding to iommu group 15
> Mar 26 09:44:00 fedora kernel: pci 0000:80:15.0: Adding to iommu group 16
> Mar 26 09:44:00 fedora kernel: pci 0000:80:15.3: Adding to iommu group 16
> Mar 26 09:44:00 fedora kernel: pci 0000:80:16.0: Adding to iommu group 17
> Mar 26 09:44:00 fedora kernel: pci 0000:80:19.0: Adding to iommu group 18
> Mar 26 09:44:00 fedora kernel: pci 0000:80:19.1: Adding to iommu group 18
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.0: Adding to iommu group 19
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1b.4: Adding to iommu group 20
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.0: Adding to iommu group 21
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1c.6: Adding to iommu group 22
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.0: Adding to iommu group 23
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.4: Adding to iommu group 24
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1d.6: Adding to iommu group 25
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.0: Adding to iommu group 26
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.3: Adding to iommu group 26
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.4: Adding to iommu group 26
> Mar 26 09:44:00 fedora kernel: pci 0000:80:1f.5: Adding to iommu group 26
> Mar 26 09:44:00 fedora kernel: pci 0000:88:00.0: Adding to iommu group 27
> Mar 26 09:44:00 fedora kernel: pci 0000:89:00.0: Adding to iommu group 28
> Mar 26 09:44:00 fedora kernel: pci 0000:89:01.0: Adding to iommu group 29
> Mar 26 09:44:00 fedora kernel: pci 0000:89:02.0: Adding to iommu group 30
> Mar 26 09:44:00 fedora kernel: pci 0000:89:03.0: Adding to iommu group 31
> Mar 26 09:44:00 fedora kernel: pci 0000:8a:00.0: Adding to iommu group 32
> Mar 26 09:44:00 fedora kernel: pci 0000:b1:00.0: Adding to iommu group 33
> Mar 26 09:44:00 fedora kernel: pci 0000:86:00.0: Adding to iommu group 34
> Mar 26 09:44:00 fedora kernel: pci 0000:85:00.0: Adding to iommu group 35
> Mar 26 09:44:00 fedora kernel: pci 0000:84:00.0: Adding to iommu group 36
> Mar 26 09:44:00 fedora kernel: DMAR: Intel(R) Virtualization Technology f=
or Directed I/O
> Mar 26 09:44:00 fedora kernel: PCI-DMA: Using software bounce buffering f=
or IO (SWIOTLB)
> Mar 26 09:44:00 fedora kernel: software IO TLB: mapped [mem 0x00000000389=
89000-0x000000003c989000] (64MB)
> Mar 26 09:44:00 fedora kernel: clocksource: tsc: mask: 0xffffffffffffffff=
 max_cycles: 0x2c47f5688fc, max_idle_ns: 440795305069 ns
> Mar 26 09:44:00 fedora kernel: clocksource: Switched to clocksource tsc
> Mar 26 09:44:00 fedora kernel: platform rtc_cmos: registered platform RTC=
 device (no PNP device found)
> Mar 26 09:44:00 fedora kernel: Initialise system trusted keyrings
> Mar 26 09:44:00 fedora kernel: Key type blacklist registered
> Mar 26 09:44:00 fedora kernel: workingset: timestamp_bits=3D36 max_order=
=3D25 bucket_order=3D0
> Mar 26 09:44:00 fedora kernel: integrity: Platform Keyring initialized
> Mar 26 09:44:00 fedora kernel: integrity: Machine keyring initialized
> Mar 26 09:44:00 fedora kernel: cryptd: max_cpu_qlen set to 1000
> Mar 26 09:44:00 fedora kernel: NET: Registered PF_ALG protocol family
> Mar 26 09:44:00 fedora kernel: xor: automatically using best checksumming=
 function   avx      =20
> Mar 26 09:44:00 fedora kernel: Key type asymmetric registered
> Mar 26 09:44:00 fedora kernel: Asymmetric key parser 'x509' registered
> Mar 26 09:44:00 fedora kernel: Block layer SCSI generic (bsg) driver vers=
ion 0.4 loaded (major 244)
> Mar 26 09:44:00 fedora kernel: io scheduler mq-deadline registered
> Mar 26 09:44:00 fedora kernel: io scheduler kyber registered
> Mar 26 09:44:00 fedora kernel: io scheduler bfq registered
> Mar 26 09:44:00 fedora kernel: atomic64_test: passed for x86-64 platform =
with CX8 and with SSE
> Mar 26 09:44:00 fedora kernel: pcieport 0000:00:01.0: PME: Signaling with=
 IRQ 124
> Mar 26 09:44:00 fedora kernel: pcieport 0000:00:01.0: AER: enabled with I=
RQ 124
> Mar 26 09:44:00 fedora kernel: pcieport 0000:00:06.0: PME: Signaling with=
 IRQ 125
> Mar 26 09:44:00 fedora kernel: pcieport 0000:00:06.0: AER: enabled with I=
RQ 125
> Mar 26 09:44:00 fedora kernel: pcieport 0000:00:07.0: PME: Signaling with=
 IRQ 126
> Mar 26 09:44:00 fedora kernel: pcieport 0000:00:07.0: AER: enabled with I=
RQ 126
> Mar 26 09:44:00 fedora kernel: pcieport 0000:00:07.0: pciehp: Slot #6 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+=
 IbPresDis- LLActRep+
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1b.0: PME: Signaling with=
 IRQ 127
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1b.0: pciehp: Slot #0 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+=
 IbPresDis- LLActRep+
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1b.4: PME: Signaling with=
 IRQ 128
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1b.4: AER: enabled with I=
RQ 128
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot #25 At=
tnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl=
+ IbPresDis- LLActRep+
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1c.0: PME: Signaling with=
 IRQ 129
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1c.0: pciehp: Slot #0 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+=
 IbPresDis- LLActRep+
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1c.6: PME: Signaling with=
 IRQ 130
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1c.6: AER: enabled with I=
RQ 130
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1d.0: PME: Signaling with=
 IRQ 131
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1d.0: pciehp: Slot #0 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+=
 IbPresDis- LLActRep+
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1d.4: PME: Signaling with=
 IRQ 132
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1d.4: AER: enabled with I=
RQ 132
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1d.4: pciehp: Slot #17 At=
tnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl=
+ IbPresDis- LLActRep+
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1d.6: PME: Signaling with=
 IRQ 133
> Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1d.6: AER: enabled with I=
RQ 133
> Mar 26 09:44:00 fedora kernel: pcieport 0000:89:01.0: pciehp: Slot #1 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+=
 IbPresDis- LLActRep+
> Mar 26 09:44:00 fedora kernel: pcieport 0000:89:03.0: pciehp: Slot #3 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+=
 IbPresDis- LLActRep+
> Mar 26 09:44:00 fedora kernel: ACPI: AC: AC Adapter [AC] (on-line)
> Mar 26 09:44:00 fedora kernel: input: Sleep Button as /devices/LNXSYSTM:0=
0/LNXSYBUS:00/PNP0C0E:00/input/input0
> Mar 26 09:44:00 fedora kernel: ACPI: button: Sleep Button [SLPB]
> Mar 26 09:44:00 fedora kernel: input: Lid Switch as /devices/LNXSYSTM:00/=
LNXSYBUS:00/PNP0C0D:00/input/input1
> Mar 26 09:44:00 fedora kernel: ACPI: button: Lid Switch [LID]
> Mar 26 09:44:00 fedora kernel: input: Power Button as /devices/LNXSYSTM:0=
0/LNXSYBUS:00/PNP0C0C:00/input/input2
> Mar 26 09:44:00 fedora kernel: ACPI: button: Power Button [PWRB]
> Mar 26 09:44:00 fedora kernel: acpi-fan PNP0C0B:00: Using Microsoft fan e=
xtensions
> Mar 26 09:44:00 fedora kernel: thermal LNXTHERM:00: registered as thermal=
_zone0
> Mar 26 09:44:00 fedora kernel: ACPI: thermal: Thermal Zone [THM0] (60 C)
> Mar 26 09:44:00 fedora kernel: Serial: 8250/16550 driver, 32 ports, IRQ s=
haring enabled
> Mar 26 09:44:00 fedora kernel: hpet_acpi_add: no address or irqs in _CRS
> Mar 26 09:44:00 fedora kernel: Non-volatile memory driver v1.3
> Mar 26 09:44:00 fedora kernel: Linux agpgart interface v0.103
> Mar 26 09:44:00 fedora kernel: tpm_tis STM0925:00: 2.0 TPM (device-id 0x3=
, rev-id 1)
> Mar 26 09:44:00 fedora kernel: ACPI: battery: Slot [BAT0] (battery presen=
t)
> Mar 26 09:44:00 fedora kernel: ACPI: bus type drm_connector registered
> Mar 26 09:44:00 fedora kernel: intel-lpss 0000:80:15.0: enabling device (=
0000 -> 0002)
> Mar 26 09:44:00 fedora kernel: intel-lpss 0000:80:19.0: enabling device (=
0000 -> 0002)
> Mar 26 09:44:00 fedora kernel: intel-lpss 0000:80:19.1: enabling device (=
0000 -> 0002)
> Mar 26 09:44:00 fedora kernel: CAN device driver interface
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:00:0d.0: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:00:0d.0: new USB bus registe=
red, assigned bus number 1
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:00:0d.0: hcc params 0x20007f=
c1 hci version 0x120 quirks 0x0000000200009810
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:00:0d.0: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:00:0d.0: new USB bus registe=
red, assigned bus number 2
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:00:0d.0: Host supports USB 3=
=2E2 Enhanced SuperSpeed
> Mar 26 09:44:00 fedora kernel: usb usb1: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.19
> Mar 26 09:44:00 fedora kernel: usb usb1: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
> Mar 26 09:44:00 fedora kernel: usb usb1: Product: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: usb usb1: Manufacturer: Linux 6.19.10-200.=
fc43.x86_64 xhci-hcd
> Mar 26 09:44:00 fedora kernel: usb usb1: SerialNumber: 0000:00:0d.0
> Mar 26 09:44:00 fedora kernel: hub 1-0:1.0: USB hub found
> Mar 26 09:44:00 fedora kernel: hub 1-0:1.0: 1 port detected
> Mar 26 09:44:00 fedora kernel: usb usb2: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.19
> Mar 26 09:44:00 fedora kernel: usb usb2: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
> Mar 26 09:44:00 fedora kernel: usb usb2: Product: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: usb usb2: Manufacturer: Linux 6.19.10-200.=
fc43.x86_64 xhci-hcd
> Mar 26 09:44:00 fedora kernel: usb usb2: SerialNumber: 0000:00:0d.0
> Mar 26 09:44:00 fedora kernel: hub 2-0:1.0: USB hub found
> Mar 26 09:44:00 fedora kernel: hub 2-0:1.0: 2 ports detected
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:80:14.0: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:80:14.0: new USB bus registe=
red, assigned bus number 3
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:80:14.0: hcc params 0x20007f=
c1 hci version 0x120 quirks 0x0000000200009810
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:80:14.0: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:80:14.0: new USB bus registe=
red, assigned bus number 4
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:80:14.0: Host supports USB 3=
=2E2 Enhanced SuperSpeed
> Mar 26 09:44:00 fedora kernel: usb usb3: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.19
> Mar 26 09:44:00 fedora kernel: usb usb3: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
> Mar 26 09:44:00 fedora kernel: usb usb3: Product: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: usb usb3: Manufacturer: Linux 6.19.10-200.=
fc43.x86_64 xhci-hcd
> Mar 26 09:44:00 fedora kernel: usb usb3: SerialNumber: 0000:80:14.0
> Mar 26 09:44:00 fedora kernel: hub 3-0:1.0: USB hub found
> Mar 26 09:44:00 fedora kernel: hub 3-0:1.0: 16 ports detected
> Mar 26 09:44:00 fedora kernel: usb usb4: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.19
> Mar 26 09:44:00 fedora kernel: usb usb4: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
> Mar 26 09:44:00 fedora kernel: usb usb4: Product: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: usb usb4: Manufacturer: Linux 6.19.10-200.=
fc43.x86_64 xhci-hcd
> Mar 26 09:44:00 fedora kernel: usb usb4: SerialNumber: 0000:80:14.0
> Mar 26 09:44:00 fedora kernel: hub 4-0:1.0: USB hub found
> Mar 26 09:44:00 fedora kernel: hub 4-0:1.0: 6 ports detected
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:b1:00.0: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:b1:00.0: new USB bus registe=
red, assigned bus number 5
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:b1:00.0: hcc params 0x20007f=
c1 hci version 0x120 quirks 0x0000000200009810
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:b1:00.0: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:b1:00.0: new USB bus registe=
red, assigned bus number 6
> Mar 26 09:44:00 fedora kernel: xhci_hcd 0000:b1:00.0: Host supports USB 3=
=2E2 Enhanced SuperSpeed
> Mar 26 09:44:00 fedora kernel: usb usb5: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.19
> Mar 26 09:44:00 fedora kernel: usb usb5: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
> Mar 26 09:44:00 fedora kernel: usb usb5: Product: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: usb usb5: Manufacturer: Linux 6.19.10-200.=
fc43.x86_64 xhci-hcd
> Mar 26 09:44:00 fedora kernel: usb usb5: SerialNumber: 0000:b1:00.0
> Mar 26 09:44:00 fedora kernel: hub 5-0:1.0: USB hub found
> Mar 26 09:44:00 fedora kernel: hub 5-0:1.0: 2 ports detected
> Mar 26 09:44:00 fedora kernel: usb usb6: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.19
> Mar 26 09:44:00 fedora kernel: usb usb6: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
> Mar 26 09:44:00 fedora kernel: usb usb6: Product: xHCI Host Controller
> Mar 26 09:44:00 fedora kernel: usb usb6: Manufacturer: Linux 6.19.10-200.=
fc43.x86_64 xhci-hcd
> Mar 26 09:44:00 fedora kernel: usb usb6: SerialNumber: 0000:b1:00.0
> Mar 26 09:44:00 fedora kernel: hub 6-0:1.0: USB hub found
> Mar 26 09:44:00 fedora kernel: hub 6-0:1.0: 2 ports detected
> Mar 26 09:44:00 fedora kernel: usbcore: registered new interface driver u=
sbserial_generic
> Mar 26 09:44:00 fedora kernel: usbserial: USB Serial support registered f=
or generic
> Mar 26 09:44:00 fedora kernel: i8042: PNP: PS/2 Controller [PNP0303:KBD,P=
NP0f13:MOU] at 0x60,0x64 irq 1,12
> Mar 26 09:44:00 fedora kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> Mar 26 09:44:00 fedora kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> Mar 26 09:44:00 fedora kernel: mousedev: PS/2 mouse device common for all=
 mice
> Mar 26 09:44:00 fedora kernel: rtc_cmos rtc_cmos: RTC can wake from S4
> Mar 26 09:44:00 fedora kernel: rtc_cmos rtc_cmos: registered as rtc0
> Mar 26 09:44:00 fedora kernel: rtc_cmos rtc_cmos: setting system clock to=
 2026-03-26T08:43:59 UTC (1774514639)
> Mar 26 09:44:00 fedora kernel: rtc_cmos rtc_cmos: alarms up to one month,=
 y3k, 114 bytes nvram
> Mar 26 09:44:00 fedora kernel: input: AT Translated Set 2 keyboard as /de=
vices/platform/i8042/serio0/input/input3
> Mar 26 09:44:00 fedora kernel: device-mapper: core: CONFIG_IMA_DISABLE_HT=
ABLE is disabled. Duplicate IMA measurements will not be recorded in the IM=
A log.
> Mar 26 09:44:00 fedora kernel: device-mapper: uevent: version 1.0.3
> Mar 26 09:44:00 fedora kernel: device-mapper: ioctl: 4.50.0-ioctl (2025-0=
4-28) initialised: dm-devel@lists.linux.dev
> Mar 26 09:44:00 fedora kernel: intel_pstate: Intel P-state driver initial=
izing
> Mar 26 09:44:00 fedora kernel: Hybrid CPU capacity scaling enabled
> Mar 26 09:44:00 fedora kernel: processor cpu0: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu1: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu2: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu3: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu4: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu5: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu6: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu7: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu8: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu9: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu10: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu11: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu12: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu13: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu14: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu15: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu16: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu17: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu18: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu19: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu20: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu21: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu22: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: processor cpu23: EM: created perf domain
> Mar 26 09:44:00 fedora kernel: intel_pstate: HWP enabled
> Mar 26 09:44:00 fedora kernel: simple-framebuffer simple-framebuffer.0: [=
drm] Registered 1 planes with drm panic
> Mar 26 09:44:00 fedora kernel: [drm] Initialized simpledrm 1.0.0 for simp=
le-framebuffer.0 on minor 0
> Mar 26 09:44:00 fedora kernel: Freeing initrd memory: 152948K
> Mar 26 09:44:00 fedora kernel: Console: switching to colour frame buffer =
device 480x150
> Mar 26 09:44:00 fedora kernel: simple-framebuffer simple-framebuffer.0: [=
drm] fb0: simpledrmdrmfb frame buffer device
> Mar 26 09:44:00 fedora kernel: hid: raw HID events driver (C) Jiri Kosina
> Mar 26 09:44:00 fedora kernel: usbcore: registered new interface driver u=
sbhid
> Mar 26 09:44:00 fedora kernel: usbhid: USB HID core driver
> Mar 26 09:44:00 fedora kernel: drop_monitor: Initializing network drop mo=
nitor service
> Mar 26 09:44:00 fedora kernel: Initializing XFRM netlink socket
> Mar 26 09:44:00 fedora kernel: NET: Registered PF_INET6 protocol family
> Mar 26 09:44:00 fedora kernel: Segment Routing with IPv6
> Mar 26 09:44:00 fedora kernel: RPL Segment Routing with IPv6
> Mar 26 09:44:00 fedora kernel: In-situ OAM (IOAM) with IPv6
> Mar 26 09:44:00 fedora kernel: mip6: Mobile IPv6
> Mar 26 09:44:00 fedora kernel: NET: Registered PF_PACKET protocol family
> Mar 26 09:44:00 fedora kernel: can: controller area network core
> Mar 26 09:44:00 fedora kernel: NET: Registered PF_CAN protocol family
> Mar 26 09:44:00 fedora kernel: ENERGY_PERF_BIAS: Set to 'normal', was 'pe=
rformance'
> Mar 26 09:44:00 fedora kernel: microcode: Current revision: 0x0000011b
> Mar 26 09:44:00 fedora kernel: microcode: Updated early from: 0x00000118
> Mar 26 09:44:00 fedora kernel: IPI shorthand broadcast: enabled
> Mar 26 09:44:00 fedora kernel: sched_clock: Marking stable (1344001414, 6=
493134)->(1387856204, -37361656)
> Mar 26 09:44:00 fedora kernel: registered taskstats version 1
> Mar 26 09:44:00 fedora kernel: Loading compiled-in X.509 certificates
> Mar 26 09:44:00 fedora kernel: Loaded X.509 cert 'Fedora kernel signing k=
ey: b33503c70c7984136c5ec42e1cf021082a94def4'
> Mar 26 09:44:00 fedora kernel: Loaded X.509 cert 'Fedora IMA CA: a8a00c31=
663f853f9c6ff2564872e378af026b28'
> Mar 26 09:44:00 fedora kernel: Demotion targets for Node 0: null
> Mar 26 09:44:00 fedora kernel: page_owner is disabled
> Mar 26 09:44:00 fedora kernel: Key type .fscrypt registered
> Mar 26 09:44:00 fedora kernel: Key type fscrypt-provisioning registered
> Mar 26 09:44:00 fedora kernel: Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
> Mar 26 09:44:00 fedora kernel: Key type big_key registered
> Mar 26 09:44:00 fedora kernel: Key type trusted registered
> Mar 26 09:44:00 fedora kernel: Key type encrypted registered
> Mar 26 09:44:00 fedora kernel: Loading compiled-in module X.509 certifica=
tes
> Mar 26 09:44:00 fedora kernel: Loaded X.509 cert 'Fedora kernel signing k=
ey: b33503c70c7984136c5ec42e1cf021082a94def4'
> Mar 26 09:44:00 fedora kernel: ima: Allocated hash algorithm: sha256
> Mar 26 09:44:00 fedora kernel: audit: type=3D1807 audit(1774514639.594:2)=
: action=3Dmeasure func=3DKEXEC_KERNEL_CHECK res=3D1
> Mar 26 09:44:00 fedora kernel: evm: Initialising EVM extended attributes:
> Mar 26 09:44:00 fedora kernel: audit: type=3D1807 audit(1774514639.594:3)=
: action=3Dappraise func=3DPOLICY_CHECK appraise_type=3Dimasig res=3D1
> Mar 26 09:44:00 fedora kernel: evm: security.selinux
> Mar 26 09:44:00 fedora kernel: evm: security.SMACK64 (disabled)
> Mar 26 09:44:00 fedora kernel: audit: type=3D1807 audit(1774514639.594:4)=
: action=3Dmeasure func=3DMODULE_CHECK res=3D1
> Mar 26 09:44:00 fedora kernel: evm: security.SMACK64EXEC (disabled)
> Mar 26 09:44:00 fedora kernel: evm: security.SMACK64TRANSMUTE (disabled)
> Mar 26 09:44:00 fedora kernel: evm: security.SMACK64MMAP (disabled)
> Mar 26 09:44:00 fedora kernel: evm: security.apparmor (disabled)
> Mar 26 09:44:00 fedora kernel: evm: security.ima
> Mar 26 09:44:00 fedora kernel: evm: security.capability
> Mar 26 09:44:00 fedora kernel: evm: HMAC attrs: 0x1
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:db
> Mar 26 09:44:00 fedora kernel: integrity: Loaded X.509 cert 'Lenovo Ltd.:=
 ThinkPad Product CA 2012: 838b1f54c1550463f45f98700640f11069265949'
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:db
> Mar 26 09:44:00 fedora kernel: integrity: Loaded X.509 cert 'Lenovo UEFI =
CA 2014: 4b91a68732eaefdd2c8ffffc6b027ec3449e9c8f'
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:db
> Mar 26 09:44:00 fedora kernel: integrity: Loaded X.509 cert 'Microsoft Wi=
ndows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:db
> Mar 26 09:44:00 fedora kernel: integrity: Loaded X.509 cert 'Microsoft Co=
rporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:db
> Mar 26 09:44:00 fedora kernel: integrity: Loaded X.509 cert 'Microsoft Co=
rporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:db
> Mar 26 09:44:00 fedora kernel: integrity: Loaded X.509 cert 'Microsoft UE=
FI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:MokListRT (MOKvar table)
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:MokListRT (MOKvar table)
> Mar 26 09:44:00 fedora kernel: integrity: Loaded X.509 cert 'Red Hat, Inc=
=2E: fedoraca: b280c7ae6b884e0f4d2a0d8724c25eaf6c65c326'
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:MokListRT (MOKvar table)
> Mar 26 09:44:00 fedora kernel: integrity: Loading X.509 certificate: UEFI=
:MokListRT (MOKvar table)
> Mar 26 09:44:00 fedora kernel: integrity: Loaded X.509 cert 'fedora_17738=
25796_a49598e7: fa66a59de18816a7bba2366a4641107cfeb207fa'
> Mar 26 09:44:00 fedora kernel: alg: No test for 842 (842-scomp)
> Mar 26 09:44:00 fedora kernel: PM:   Magic number: 2:467:726
> Mar 26 09:44:00 fedora kernel: pci 0000:01:00.1: hash matches
> Mar 26 09:44:00 fedora kernel: RAS: Correctable Errors collector initiali=
zed.
> Mar 26 09:44:00 fedora kernel: Lockdown: swapper/0: hibernation is restri=
cted; see man kernel_lockdown.7
> Mar 26 09:44:00 fedora kernel: clk: Disabling unused clocks
> Mar 26 09:44:00 fedora kernel: PM: genpd: Disabling unused power domains
> Mar 26 09:44:00 fedora kernel: Freeing unused decrypted memory: 2028K
> Mar 26 09:44:00 fedora kernel: Freeing unused kernel image (initmem) memo=
ry: 5196K
> Mar 26 09:44:00 fedora kernel: Write protecting the kernel read-only data=
: 43008k
> Mar 26 09:44:00 fedora kernel: Freeing unused kernel image (text/rodata g=
ap) memory: 1984K
> Mar 26 09:44:00 fedora kernel: Freeing unused kernel image (rodata/data g=
ap) memory: 584K
> Mar 26 09:44:00 fedora kernel: x86/mm: Checked W+X mappings: passed, no W=
+X pages found.
> Mar 26 09:44:00 fedora kernel: Run /init as init process
> Mar 26 09:44:00 fedora kernel:   with arguments:
> Mar 26 09:44:00 fedora kernel:     /init
> Mar 26 09:44:00 fedora kernel:   with environment:
> Mar 26 09:44:00 fedora kernel:     HOME=3D/
> Mar 26 09:44:00 fedora kernel:     TERM=3Dlinux
> Mar 26 09:44:00 fedora kernel: usb 3-3: new full-speed USB device number =
2 using xhci_hcd
> Mar 26 09:44:00 fedora kernel: psmouse serio1: trackpoint: Elan TrackPoin=
t firmware: 0x00, buttons: 3/3
> Mar 26 09:44:00 fedora kernel: input: TPPS/2 Elan TrackPoint as /devices/=
platform/i8042/serio1/input/input5
> Mar 26 09:44:00 fedora kernel: usb 3-3: New USB device found, idVendor=3D=
06cb, idProduct=3D00f9, bcdDevice=3D 0.00
> Mar 26 09:44:00 fedora kernel: usb 3-3: New USB device strings: Mfr=3D0, =
Product=3D0, SerialNumber=3D1
> Mar 26 09:44:00 fedora kernel: usb 3-3: SerialNumber: 5e50f82d85b2
> Mar 26 09:44:00 fedora systemd[1]: Successfully made /usr/ read-only.
> Mar 26 09:44:00 fedora systemd[1]: systemd 258.7-1.fc43 running in system=
 mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE +SMACK +SECCOMP -GCRYPT +GN=
UTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LI=
BCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRE=
NCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTM=
P +SYSVINIT +LIBARCHIVE)
> Mar 26 09:44:00 fedora systemd[1]: Detected architecture x86-64.
> Mar 26 09:44:00 fedora systemd[1]: Running in initrd.
> Mar 26 09:44:00 fedora systemd[1]: No hostname configured, using default =
hostname.
> Mar 26 09:44:00 fedora systemd[1]: Hostname set to <fedora>.
> Mar 26 09:44:00 fedora systemd[1]: bpf-restrict-fs: LSM BPF program attac=
hed
> Mar 26 09:44:00 fedora systemd[1]: Queued start job for default target in=
itrd.target.
> Mar 26 09:44:00 fedora kernel: usb 3-4: new high-speed USB device number =
3 using xhci_hcd
> Mar 26 09:44:00 fedora systemd[1]: Created slice system-systemd\x2dcrypts=
etup.slice - Slice /system/systemd-cryptsetup.
> Mar 26 09:44:00 fedora systemd[1]: Expecting device dev-disk-by\x2duuid-2=
f377dfc\x2d1d36\x2d4d0e\x2d8fdc\x2dcd0a3d5d8d28.device - /dev/disk/by-uuid/=
2f377dfc-1d36-4d0e-8fdc-cd0a3d5d8d28...
> Mar 26 09:44:00 fedora systemd[1]: Expecting device dev-disk-by\x2duuid-7=
3987f2e\x2d002a\x2d40e7\x2dadd4\x2d6bfcdf615f80.device - /dev/disk/by-uuid/=
73987f2e-002a-40e7-add4-6bfcdf615f80...
> Mar 26 09:44:00 fedora systemd[1]: Reached target initrd-usr-fs.target - =
Initrd /usr File System.
> Mar 26 09:44:00 fedora systemd[1]: Reached target slices.target - Slice U=
nits.
> Mar 26 09:44:00 fedora systemd[1]: Reached target swap.target - Swaps.
> Mar 26 09:44:00 fedora systemd[1]: Reached target timers.target - Timer U=
nits.
> Mar 26 09:44:00 fedora systemd[1]: Listening on systemd-journald-dev-log.=
socket - Journal Socket (/dev/log).
> Mar 26 09:44:00 fedora systemd[1]: Listening on systemd-journald.socket -=
 Journal Sockets.
> Mar 26 09:44:00 fedora systemd[1]: Listening on systemd-udevd-control.soc=
ket - udev Control Socket.
> Mar 26 09:44:00 fedora systemd[1]: Listening on systemd-udevd-kernel.sock=
et - udev Kernel Socket.
> Mar 26 09:44:00 fedora systemd[1]: Reached target sockets.target - Socket=
 Units.
> Mar 26 09:44:00 fedora systemd[1]: Starting kmod-static-nodes.service - C=
reate List of Static Device Nodes...
> Mar 26 09:44:00 fedora systemd[1]: memstrack.service - Memstrack Anylazin=
g Service skipped, no trigger condition checks were met.
> Mar 26 09:44:00 fedora systemd[1]: Starting systemd-journald.service - Jo=
urnal Service...
> Mar 26 09:44:00 fedora systemd[1]: Starting systemd-modules-load.service =
- Load Kernel Modules...
> Mar 26 09:44:00 fedora systemd[1]: systemd-pcrphase-initrd.service - TPM =
PCR Barrier (initrd) skipped, unmet condition check ConditionSecurity=3Dmea=
sured-uki
> Mar 26 09:44:00 fedora systemd[1]: Starting systemd-vconsole-setup.servic=
e - Virtual Console Setup...
> Mar 26 09:44:00 fedora systemd[1]: Finished kmod-static-nodes.service - C=
reate List of Static Device Nodes.
> Mar 26 09:44:00 fedora systemd[1]: Starting systemd-tmpfiles-setup-dev-ea=
rly.service - Create Static Device Nodes in /dev gracefully...
> Mar 26 09:44:00 fedora systemd-journald[369]: Collecting audit messages i=
s disabled.
> Mar 26 09:44:00 fedora systemd[1]: Finished systemd-tmpfiles-setup-dev-ea=
rly.service - Create Static Device Nodes in /dev gracefully.
> Mar 26 09:44:00 fedora systemd[1]: Starting systemd-sysusers.service - Cr=
eate System Users...
> Mar 26 09:44:00 fedora kernel: fuse: init (API version 7.45)
> Mar 26 09:44:00 fedora systemd[1]: Finished systemd-sysusers.service - Cr=
eate System Users.
> Mar 26 09:44:00 fedora systemd[1]: Starting systemd-tmpfiles-setup-dev.se=
rvice - Create Static Device Nodes in /dev...
> Mar 26 09:44:00 fedora systemd[1]: Finished systemd-tmpfiles-setup-dev.se=
rvice - Create Static Device Nodes in /dev.
> Mar 26 09:44:00 fedora systemd[1]: Finished systemd-vconsole-setup.servic=
e - Virtual Console Setup.
> Mar 26 09:44:00 fedora systemd[1]: Reached target local-fs-pre.target - P=
reparation for Local File Systems.
> Mar 26 09:44:00 fedora kernel: i2c_dev: i2c /dev entries driver
> Mar 26 09:44:00 fedora systemd[1]: Reached target local-fs.target - Local=
 File Systems.
> Mar 26 09:44:00 fedora systemd[1]: Starting dracut-cmdline-ask.service - =
dracut ask for additional cmdline parameters...
> Mar 26 09:44:00 fedora systemd[1]: Finished systemd-modules-load.service =
- Load Kernel Modules.
> Mar 26 09:44:00 fedora systemd[1]: Starting systemd-sysctl.service - Appl=
y Kernel Variables...
> Mar 26 09:44:00 fedora systemd[1]: Finished systemd-sysctl.service - Appl=
y Kernel Variables.
> Mar 26 09:44:00 fedora systemd[1]: Started systemd-journald.service - Jou=
rnal Service.
> Mar 26 09:44:00 fedora kernel: usb 3-4: New USB device found, idVendor=3D=
04f2, idProduct=3Db83f, bcdDevice=3D65.03
> Mar 26 09:44:00 fedora kernel: usb 3-4: New USB device strings: Mfr=3D3, =
Product=3D1, SerialNumber=3D2
> Mar 26 09:44:00 fedora kernel: usb 3-4: Product: Integrated Camera
> Mar 26 09:44:00 fedora kernel: usb 3-4: Manufacturer: Chicony Electronics=
 Co.,Ltd.
> Mar 26 09:44:00 fedora kernel: usb 3-4: SerialNumber: 0001
> Mar 26 09:44:00 fedora kernel: hid-generic 0003:04F2:B83F.0001: hiddev96,=
hidraw0: USB HID v1.11 Device [Chicony Electronics Co.,Ltd. Integrated Came=
ra] on usb-0000:80:14.0-4/input4
> Mar 26 09:44:00 fedora kernel: hid-sensor-hub 0003:04F2:B83F.0001: hiddev=
96,hidraw0: USB HID v1.11 Device [Chicony Electronics Co.,Ltd. Integrated C=
amera] on usb-0000:80:14.0-4/input4
> Mar 26 09:44:00 fedora kernel: usb 3-14: new full-speed USB device number=
 4 using xhci_hcd
> Mar 26 09:44:00 fedora kernel: gpio gpiochip0: line cnt 592 is greater th=
an fast path cnt 512
> Mar 26 09:44:00 fedora kernel: intel_vsec 0000:00:0a.0: enabling device (=
0000 -> 0002)
> Mar 26 09:44:00 fedora kernel: intel_vpu 0000:00:0b.0: enabling device (0=
000 -> 0002)
> Mar 26 09:44:00 fedora kernel: usb 3-14: New USB device found, idVendor=
=3D8087, idProduct=3D0036, bcdDevice=3D 0.00
> Mar 26 09:44:00 fedora kernel: usb 3-14: New USB device strings: Mfr=3D0,=
 Product=3D0, SerialNumber=3D0
> Mar 26 09:44:00 fedora kernel: intel_vpu 0000:00:0b.0: [drm] Firmware: in=
tel/vpu/vpu_37xx_v1.bin, version: 20251113*MTL_CLIENT_SILICON-NVR+NN-deploy=
ment*72f907ffc780df5579a2fed65afc4944da8b0e44*72f907ffc780df5579a2fed65afc4=
944da8b0e44*72f907ffc78
> Mar 26 09:44:00 fedora kernel: intel_vpu 0000:00:0b.0: [drm] Scheduler mo=
de: HW
> Mar 26 09:44:00 fedora kernel: ACPI: bus type thunderbolt registered
> Mar 26 09:44:00 fedora kernel: rtsx_pci 0000:85:00.0: enabling device (00=
00 -> 0002)
> Mar 26 09:44:00 fedora kernel: [drm] Initialized intel_vpu 1.0.0 for 0000=
:00:0b.0 on minor 0
> Mar 26 09:44:00 fedora kernel: input: ELAN0685:00 04F3:320B Mouse as /dev=
ices/pci0000:80/0000:80:19.1/i2c_designware.3/i2c-3/i2c-ELAN0685:00/0018:04=
F3:320B.0002/input/input6
> Mar 26 09:44:00 fedora kernel: input: ELAN0685:00 04F3:320B Touchpad as /=
devices/pci0000:80/0000:80:19.1/i2c_designware.3/i2c-3/i2c-ELAN0685:00/0018=
:04F3:320B.0002/input/input8
> Mar 26 09:44:00 fedora kernel: hid-generic 0018:04F3:320B.0002: input,hid=
raw1: I2C HID v1.00 Mouse [ELAN0685:00 04F3:320B] on i2c-ELAN0685:00
> Mar 26 09:44:00 fedora kernel: Key type psk registered
> Mar 26 09:44:00 fedora kernel: thunderbolt 0000:8a:00.0: host router rese=
t successful
> Mar 26 09:44:00 fedora kernel: input: ELAN0685:00 04F3:320B Mouse as /dev=
ices/pci0000:80/0000:80:19.1/i2c_designware.3/i2c-3/i2c-ELAN0685:00/0018:04=
F3:320B.0002/input/input9
> Mar 26 09:44:00 fedora kernel: input: ELAN0685:00 04F3:320B Touchpad as /=
devices/pci0000:80/0000:80:19.1/i2c_designware.3/i2c-3/i2c-ELAN0685:00/0018=
:04F3:320B.0002/input/input11
> Mar 26 09:44:00 fedora kernel: hid-multitouch 0018:04F3:320B.0002: input,=
hidraw1: I2C HID v1.00 Mouse [ELAN0685:00 04F3:320B] on i2c-ELAN0685:00
> Mar 26 09:44:00 fedora kernel: nvme 0000:04:00.0: platform quirk: setting=
 simple suspend
> Mar 26 09:44:00 fedora kernel: nvme nvme0: pci function 0000:04:00.0
> Mar 26 09:44:00 fedora kernel: nvme nvme0: D3 entry latency set to 10 sec=
onds
> Mar 26 09:44:00 fedora kernel: nvme nvme0: 15/0/0 default/read/poll queues
> Mar 26 09:44:00 fedora kernel:  nvme0n1: p1 p2 p3
> Mar 26 09:44:00 fedora kernel: typec port0: bound usb2-port1 (ops connect=
or_ops)
> Mar 26 09:44:00 fedora kernel: typec port0: bound usb4_port1 (ops connect=
or_ops [thunderbolt])
> Mar 26 09:44:00 fedora kernel: typec port0: bound usb3-port1 (ops connect=
or_ops)
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] Found meteorlake =
(device ID 7d67) integrated display version 14.00 stepping D0
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] VT-d active for g=
fx access
> Mar 26 09:44:01 fedora kernel: Console: switching to colour dummy device =
80x25
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: vgaarb: deactivate vga =
console
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] Using Transparent=
 Hugepages
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: vgaarb: VGA decodes cha=
nged: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
> Mar 26 09:44:01 fedora kernel: typec port1: bound usb3-port6 (ops connect=
or_ops)
> Mar 26 09:44:01 fedora kernel: typec port1: bound usb6-port1 (ops connect=
or_ops)
> Mar 26 09:44:01 fedora kernel: typec port1: bound usb4_port1 (ops connect=
or_ops [thunderbolt])
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] Finished loading =
DMC firmware i915/mtl_dmc.bin (v2.23)
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT0: GuC firmware=
 i915/mtl_guc_70.bin version 70.53.0
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT0: GUC: submiss=
ion enabled
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT0: GUC: SLPC en=
abled
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT0: GUC: RC enab=
led
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT1: GuC firmware=
 i915/mtl_guc_70.bin version 70.53.0
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT1: HuC firmware=
 i915/mtl_huc_gsc.bin version 8.5.4
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT1: HuC: authent=
icated for clear media
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT1: GUC: submiss=
ion enabled
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT1: GUC: SLPC en=
abled
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT1: GUC: RC enab=
led
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] Protected Xe Path=
 (PXP) protected content support initialized
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] Registered 4 plan=
es with drm panic
> Mar 26 09:44:01 fedora kernel: [drm] Initialized i915 1.6.0 for 0000:00:0=
2.0 on minor 1
> Mar 26 09:44:01 fedora kernel: ACPI: video: Video Device [GFX0] (multi-he=
ad: yes  rom: no  post: no)
> Mar 26 09:44:01 fedora kernel: input: Video Bus as /devices/LNXSYSTM:00/L=
NXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input12
> Mar 26 09:44:01 fedora kernel: ACPI: video: [Firmware Bug]: ACPI(PXSX) de=
fines _DOD but not _DOS
> Mar 26 09:44:01 fedora kernel: ACPI: video: Video Device [PXSX] (multi-he=
ad: yes  rom: no  post: no)
> Mar 26 09:44:01 fedora kernel: input: Video Bus as /devices/LNXSYSTM:00/L=
NXSYBUS:00/PNP0A08:00/device:17/LNXVIDEO:01/input/input13
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT1: Loaded GSC f=
irmware i915/mtl_gsc_1.bin (cv1.0, r102.1.15.1926, svn 1)
> Mar 26 09:44:01 fedora kernel: i915 0000:00:02.0: [drm] GT1: HuC: authent=
icated for all workloads
> Mar 26 09:44:01 fedora kernel: typec port2: bound usb3-port5 (ops connect=
or_ops)
> Mar 26 09:44:01 fedora kernel: typec port2: bound usb6-port2 (ops connect=
or_ops)
> Mar 26 09:44:01 fedora kernel: typec port2: bound usb4_port3 (ops connect=
or_ops [thunderbolt])
> Mar 26 09:44:05 fedora kernel: fbcon: i915drmfb (fb0) is primary device
> Mar 26 09:44:06 fedora kernel: i915 0000:00:02.0: [drm] PHY A failed to r=
equest refclk
> Mar 26 09:44:06 fedora kernel: Console: switching to colour frame buffer =
device 480x150
> Mar 26 09:44:06 fedora kernel: i915 0000:00:02.0: [drm] fb0: i915drmfb fr=
ame buffer device
> Mar 26 09:44:16 fedora kernel: BTRFS: device label fedora devid 1 transid=
 2059 /dev/mapper/luks-73987f2e-002a-40e7-add4-6bfcdf615f80 (252:0) scanned=
 by mount (1050)
> Mar 26 09:44:16 fedora kernel: BTRFS info (device dm-0): first mount of f=
ilesystem 2f377dfc-1d36-4d0e-8fdc-cd0a3d5d8d28
> Mar 26 09:44:16 fedora kernel: BTRFS info (device dm-0): using crc32c (cr=
c32c-lib) checksum algorithm
> Mar 26 09:44:16 fedora kernel: BTRFS info (device dm-0): enabling ssd opt=
imizations
> Mar 26 09:44:16 fedora kernel: BTRFS info (device dm-0): turning on async=
 discard
> Mar 26 09:44:16 fedora kernel: BTRFS info (device dm-0): enabling free sp=
ace tree
> Mar 26 08:44:17 fedora systemd-journald[369]: Received SIGTERM from PID 1=
 (systemd).
> Mar 26 08:44:17 fedora kernel: audit: type=3D1404 audit(1774514657.191:5)=
: enforcing=3D1 old_enforcing=3D0 auid=3D4294967295 ses=3D4294967295 enable=
d=3D1 old-enabled=3D1 lsm=3Dselinux res=3D1
> Mar 26 08:44:17 fedora kernel: SELinux:  Permission firmware_load in clas=
s system not defined in policy.
> Mar 26 08:44:17 fedora kernel: SELinux:  Permission kexec_image_load in c=
lass system not defined in policy.
> Mar 26 08:44:17 fedora kernel: SELinux:  Permission kexec_initramfs_load =
in class system not defined in policy.
> Mar 26 08:44:17 fedora kernel: SELinux:  Permission policy_load in class =
system not defined in policy.
> Mar 26 08:44:17 fedora kernel: SELinux:  Permission x509_certificate_load=
 in class system not defined in policy.
> Mar 26 08:44:17 fedora kernel: SELinux:  Permission allowed in class io_u=
ring not defined in policy.
> Mar 26 08:44:17 fedora kernel: SELinux:  Class memfd_file not defined in =
policy.
> Mar 26 08:44:17 fedora kernel: SELinux: the above unknown classes and per=
missions will be allowed
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability network_peer_c=
ontrols=3D1
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability open_perms=3D1
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability extended_socke=
t_class=3D1
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability always_check_n=
etwork=3D0
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability cgroup_seclabe=
l=3D1
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability nnp_nosuid_tra=
nsition=3D1
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability genfs_seclabel=
_symlinks=3D1
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability ioctl_skip_clo=
exec=3D0
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability userspace_init=
ial_context=3D0
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability netlink_xperm=
=3D0
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability netif_wildcard=
=3D0
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability genfs_seclabel=
_wildcard=3D0
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability functionfs_sec=
label=3D0
> Mar 26 08:44:17 fedora kernel: SELinux:  policy capability memfd_class=3D0
> Mar 26 08:44:17 fedora kernel: audit: type=3D1403 audit(1774514657.274:6)=
: auid=3D4294967295 ses=3D4294967295 lsm=3Dselinux res=3D1
> Mar 26 08:44:17 fedora systemd[1]: Successfully loaded SELinux policy in =
83.526ms.
> Mar 26 08:44:17 fedora systemd[1]: RTC configured in localtime, applying =
delta of 60 minutes to system time.
> Mar 26 08:44:17 fedora systemd[1]: Relabeled /dev/, /dev/shm/, /run/ in 6=
=2E063ms.
> Mar 26 08:44:17 fedora systemd[1]: systemd 258.7-1.fc43 running in system=
 mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE +SMACK +SECCOMP -GCRYPT +GN=
UTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LI=
BCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRE=
NCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTM=
P +SYSVINIT +LIBARCHIVE)
> Mar 26 08:44:17 fedora systemd[1]: Detected architecture x86-64.
> Mar 26 08:44:17 fedora systemd[1]: bpf-restrict-fs: LSM BPF program attac=
hed
> Mar 26 08:44:17 fedora kernel: zram: Added device: zram0
> Mar 26 08:44:17 fedora systemd[1]: systemd-ask-password-plymouth.service:=
 Deactivated successfully.
> Mar 26 08:44:17 fedora systemd[1]: initrd-switch-root.service: Deactivate=
d successfully.
> Mar 26 08:44:17 fedora systemd[1]: Stopped initrd-switch-root.service - S=
witch Root.
> Mar 26 08:44:17 fedora systemd[1]: systemd-journald.service: Scheduled re=
start job, restart counter is at 1.
> Mar 26 08:44:17 fedora systemd[1]: Created slice machine.slice - Virtual =
Machine and Container Slice.
> Mar 26 08:44:17 fedora systemd[1]: Created slice system-akmods\x2dkeygen.=
slice - Slice /system/akmods-keygen.
> Mar 26 08:44:17 fedora systemd[1]: Created slice system-getty.slice - Sli=
ce /system/getty.
> Mar 26 08:44:17 fedora systemd[1]: Created slice system-sshd\x2dkeygen.sl=
ice - Slice /system/sshd-keygen.
> Mar 26 08:44:17 fedora systemd[1]: Created slice system-systemd\x2dfsck.s=
lice - Slice /system/systemd-fsck.
> Mar 26 08:44:17 fedora systemd[1]: Created slice system-systemd\x2dzram\x=
2dsetup.slice - Slice /system/systemd-zram-setup.
> Mar 26 08:44:17 fedora systemd[1]: Created slice user.slice - User and Se=
ssion Slice.
> Mar 26 08:44:17 fedora systemd[1]: systemd-ask-password-console.path - Di=
spatch Password Requests to Console Directory Watch skipped, unmet conditio=
n check ConditionPathExists=3D!/run/plymouth/pid
> Mar 26 08:44:17 fedora systemd[1]: Started systemd-ask-password-wall.path=
 - Forward Password Requests to Wall Directory Watch.
> Mar 26 08:44:17 fedora systemd[1]: Set up automount proc-sys-fs-binfmt_mi=
sc.automount - Arbitrary Executable File Formats File System Automount Poin=
t.
> Mar 26 08:44:17 fedora systemd[1]: Expecting device dev-disk-by\x2duuid-F=
9A2\x2dDA2A.device - /dev/disk/by-uuid/F9A2-DA2A...
> Mar 26 08:44:17 fedora systemd[1]: Expecting device dev-disk-by\x2duuid-d=
5bf4d09\x2d7f11\x2d4acd\x2da48c\x2d445c5ec7a7d6.device - /dev/disk/by-uuid/=
d5bf4d09-7f11-4acd-a48c-445c5ec7a7d6...
> Mar 26 08:44:17 fedora systemd[1]: Expecting device dev-zram0.device - /d=
ev/zram0...
> Mar 26 08:44:17 fedora systemd[1]: Reached target blockdev@dev-mapper-luk=
s\x2d73987f2e\x2d002a\x2d40e7\x2dadd4\x2d6bfcdf615f80.target - Block Device=
 Preparation for /dev/mapper/luks-73987f2e-002a-40e7-add4-6bfcdf615f80.
> Mar 26 08:44:17 fedora systemd[1]: Reached target cryptsetup.target - Loc=
al Encrypted Volumes.
> Mar 26 08:44:17 fedora systemd[1]: Reached target getty.target - Login Pr=
ompts.
> Mar 26 08:44:17 fedora systemd[1]: Reached target imports.target - Image =
Downloads.
> Mar 26 08:44:17 fedora systemd[1]: Stopped target initrd-switch-root.targ=
et - Switch Root.
> Mar 26 08:44:17 fedora systemd[1]: Stopped target initrd-fs.target - Init=
rd File Systems.
> Mar 26 08:44:17 fedora systemd[1]: Stopped target initrd-root-fs.target -=
 Initrd Root File System.
> Mar 26 08:44:17 fedora systemd[1]: Reached target integritysetup.target -=
 Local Integrity Protected Volumes.
> Mar 26 08:44:17 fedora systemd[1]: Reached target slices.target - Slice U=
nits.
> Mar 26 08:44:17 fedora systemd[1]: Reached target veritysetup.target - Lo=
cal Verity Protected Volumes.
> Mar 26 08:44:17 fedora systemd[1]: Listening on dm-event.socket - Device-=
mapper event daemon FIFOs.
> Mar 26 08:44:17 fedora systemd[1]: Listening on lvm2-lvmpolld.socket - LV=
M2 poll daemon socket.
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-ask-password.sock=
et - Query the User Interactively for a Password.
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-coredump.socket -=
 Process Core Dump Socket.
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-creds.socket - Cr=
edential Encryption/Decryption.
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-factory-reset.soc=
ket - Factory Reset Management.
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-journald-audit.so=
cket - Journal Audit Socket.
> Mar 26 08:44:17 fedora systemd[1]: systemd-pcrextend.socket - TPM PCR Mea=
surements skipped, unmet condition check ConditionSecurity=3Dmeasured-uki
> Mar 26 08:44:17 fedora systemd[1]: systemd-pcrlock.socket - Make TPM PCR =
Policy skipped, unmet condition check ConditionSecurity=3Dmeasured-uki
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-resolved-monitor.=
socket - Resolve Monitor Varlink Socket.
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-resolved-varlink.=
socket - Resolve Service Varlink Socket.
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-udevd-control.soc=
ket - udev Control Socket.
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-udevd-varlink.soc=
ket - udev Varlink Socket.
> Mar 26 08:44:17 fedora systemd[1]: Listening on systemd-userdbd.socket - =
User Database Manager Socket.
> Mar 26 08:44:17 fedora systemd[1]: Mounting dev-hugepages.mount - Huge Pa=
ges File System...
> Mar 26 08:44:17 fedora systemd[1]: Mounting dev-mqueue.mount - POSIX Mess=
age Queue File System...
> Mar 26 08:44:17 fedora systemd[1]: Mounting sys-kernel-debug.mount - Kern=
el Debug File System...
> Mar 26 08:44:17 fedora systemd[1]: Mounting sys-kernel-tracing.mount - Ke=
rnel Trace File System...
> Mar 26 08:44:17 fedora systemd[1]: auth-rpcgss-module.service - Kernel Mo=
dule supporting RPCSEC_GSS skipped, unmet condition check ConditionPathExis=
ts=3D/etc/krb5.keytab
> Mar 26 08:44:17 fedora systemd[1]: fips-crypto-policy-overlay.service - B=
ind-mount FIPS crypto-policy in FIPS mode skipped, unmet condition check Co=
nditionKernelCommandLine=3Dfips=3D1
> Mar 26 08:44:17 fedora systemd[1]: iscsi-starter.service skipped, unmet c=
ondition check ConditionDirectoryNotEmpty=3D/var/lib/iscsi/nodes
> Mar 26 08:44:17 fedora systemd[1]: Starting kmod-static-nodes.service - C=
reate List of Static Device Nodes...
> Mar 26 08:44:17 fedora systemd[1]: Starting lvm2-monitor.service - Monito=
ring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> Mar 26 08:44:17 fedora systemd[1]: modprobe@configfs.service - Load Kerne=
l Module configfs skipped, unmet condition check ConditionKernelModuleLoade=
d=3D!configfs
> Mar 26 08:44:17 fedora systemd[1]: modprobe@dm_mod.service - Load Kernel =
Module dm_mod skipped, unmet condition check ConditionKernelModuleLoaded=3D=
!dm_mod
> Mar 26 08:44:17 fedora systemd[1]: modprobe@drm.service - Load Kernel Mod=
ule drm skipped, unmet condition check ConditionKernelModuleLoaded=3D!drm
> Mar 26 08:44:17 fedora systemd[1]: modprobe@fuse.service - Load Kernel Mo=
dule fuse skipped, unmet condition check ConditionKernelModuleLoaded=3D!fuse
> Mar 26 08:44:17 fedora systemd[1]: Mounting sys-fs-fuse-connections.mount=
 - FUSE Control File System...
> Mar 26 08:44:17 fedora systemd[1]: Starting modprobe@loop.service - Load =
Kernel Module loop...
> Mar 26 08:44:17 fedora systemd[1]: plymouth-switch-root.service: Deactiva=
ted successfully.
> Mar 26 08:44:17 fedora systemd[1]: Stopped plymouth-switch-root.service -=
 Plymouth switch root service.
> Mar 26 08:44:17 fedora systemd[1]: systemd-boot-clear-sysfail.service - C=
lear SysFail Entry If The Boot Is Successful skipped, unmet condition check=
 ConditionPathExists=3D/sys/firmware/efi/efivars/LoaderEntrySysFail-4a67b08=
2-0a4c-41cf-b6c7-440b29bb8c4f
> Mar 26 08:44:17 fedora systemd[1]: systemd-fsck-root.service: Deactivated=
 successfully.
> Mar 26 08:44:17 fedora systemd[1]: Stopped systemd-fsck-root.service - Fi=
le System Check on Root Device.
> Mar 26 08:44:17 fedora systemd[1]: systemd-hibernate-clear.service - Clea=
r Stale Hibernate Storage Info skipped, unmet condition check ConditionPath=
Exists=3D/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-938=
7-6d876050dc67
> Mar 26 08:44:17 fedora systemd[1]: Starting systemd-journald.service - Jo=
urnal Service...
> Mar 26 08:44:17 fedora systemd[1]: Starting systemd-modules-load.service =
- Load Kernel Modules...
> Mar 26 08:44:17 fedora systemd[1]: Starting systemd-network-generator.ser=
vice - Generate Network Units from Kernel Command Line...
> Mar 26 08:44:17 fedora systemd[1]: systemd-pcrmachine.service - TPM PCR M=
achine ID Measurement skipped, unmet condition check ConditionSecurity=3Dme=
asured-uki
> Mar 26 08:44:17 fedora systemd[1]: Starting systemd-remount-fs.service - =
Remount Root and Kernel File Systems...
> Mar 26 08:44:17 fedora systemd[1]: systemd-tpm2-setup-early.service - Ear=
ly TPM SRK Setup skipped, unmet condition check ConditionSecurity=3Dmeasure=
d-uki
> Mar 26 08:44:17 fedora systemd[1]: Starting systemd-udev-load-credentials=
=2Eservice - Load udev Rules from Credentials...
> Mar 26 08:44:17 fedora systemd[1]: Starting systemd-udev-trigger.service =
- Coldplug All udev Devices...
> Mar 26 08:44:17 fedora systemd[1]: Mounted dev-hugepages.mount - Huge Pag=
es File System.
> Mar 26 08:44:17 fedora kernel: BTRFS info (device dm-0 state M): use zstd=
 compression, level 1
> Mar 26 08:44:17 fedora systemd[1]: Mounted dev-mqueue.mount - POSIX Messa=
ge Queue File System.
> Mar 26 08:44:17 fedora systemd[1]: Mounted sys-kernel-debug.mount - Kerne=
l Debug File System.
> Mar 26 08:44:17 fedora systemd[1]: Mounted sys-kernel-tracing.mount - Ker=
nel Trace File System.
> Mar 26 08:44:17 fedora systemd[1]: Finished kmod-static-nodes.service - C=
reate List of Static Device Nodes.
> Mar 26 08:44:17 fedora systemd[1]: Mounted sys-fs-fuse-connections.mount =
- FUSE Control File System.
> Mar 26 08:44:17 fedora systemd[1]: Finished systemd-modules-load.service =
- Load Kernel Modules.
> Mar 26 08:44:17 fedora systemd[1]: Finished systemd-network-generator.ser=
vice - Generate Network Units from Kernel Command Line.
> Mar 26 08:44:17 fedora systemd[1]: Finished systemd-remount-fs.service - =
Remount Root and Kernel File Systems.
> Mar 26 08:44:17 fedora systemd[1]: iscsi-onboot.service - Special handlin=
g of early boot iSCSI sessions skipped, unmet condition check ConditionDire=
ctoryNotEmpty=3D/sys/class/iscsi_session
> Mar 26 08:44:17 fedora systemd[1]: systemd-hwdb-update.service - Rebuild =
Hardware Database skipped, unmet condition check ConditionNeedsUpdate=3D/etc
> Mar 26 08:44:17 fedora systemd-journald[1166]: Collecting audit messages =
is enabled.
> Mar 26 08:44:17 fedora systemd[1]: Starting systemd-random-seed.service -=
 Load/Save OS Random Seed...
> Mar 26 08:44:17 fedora systemd[1]: Starting systemd-sysctl.service - Appl=
y Kernel Variables...
> Mar 26 08:44:17 fedora systemd[1]: Starting systemd-tmpfiles-setup-dev-ea=
rly.service - Create Static Device Nodes in /dev gracefully...
> Mar 26 08:44:17 fedora systemd-journald[1166]: /run/log/journal/0ba6a6ba8=
28d446f88fa7e5e22e444d9/system.journal: Realtime clock jumped backwards rel=
ative to last journal entry, rotating.
> Mar 26 08:44:17 fedora systemd[1]: systemd-tpm2-setup.service - TPM SRK S=
etup skipped, unmet condition check ConditionSecurity=3Dmeasured-uki
> Mar 26 08:44:17 fedora systemd[1]: Finished systemd-udev-load-credentials=
=2Eservice - Load udev Rules from Credentials.
> Mar 26 08:44:17 fedora kernel: audit: type=3D1130 audit(1774511057.687:7)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system=
_r:init_t:s0 msg=3D'unit=3Dsystemd-udev-load-credentials comm=3D"systemd" e=
xe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
> Mar 26 08:44:17 fedora systemd[1]: Started systemd-journald.service - Jou=
rnal Service.
> Mar 26 08:44:17 fedora kernel: audit: type=3D1130 audit(1774511057.690:8)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system=
_r:init_t:s0 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/li=
b/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:44:17 fedora kernel: loop: module loaded
> Mar 26 08:44:17 fedora kernel: audit: type=3D1130 audit(1774511057.698:9)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system=
_r:init_t:s0 msg=3D'unit=3Dmodprobe@loop comm=3D"systemd" exe=3D"/usr/lib/s=
ystemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:44:17 fedora kernel: audit: type=3D1131 audit(1774511057.698:10=
): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syste=
m_r:init_t:s0 msg=3D'unit=3Dmodprobe@loop comm=3D"systemd" exe=3D"/usr/lib/=
systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:44:17 fedora systemd-journald[1166]: Received client request to=
 flush runtime journal.
> Mar 26 08:44:17 fedora kernel: audit: type=3D1130 audit(1774511057.719:11=
): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syste=
m_r:init_t:s0 msg=3D'unit=3Dlvm2-monitor comm=3D"systemd" exe=3D"/usr/lib/s=
ystemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:44:17 fedora kernel: audit: type=3D1130 audit(1774511057.721:12=
): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syste=
m_r:init_t:s0 msg=3D'unit=3Dsystemd-sysctl comm=3D"systemd" exe=3D"/usr/lib=
/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:44:17 fedora kernel: audit: type=3D1334 audit(1774511057.724:13=
): prog-id=3D53 op=3DLOAD
> Mar 26 08:44:17 fedora kernel: audit: type=3D1334 audit(1774511057.724:14=
): prog-id=3D54 op=3DLOAD
> Mar 26 08:44:17 fedora systemd-journald[1166]: /var/log/journal/0ba6a6ba8=
28d446f88fa7e5e22e444d9/system.journal: Realtime clock jumped backwards rel=
ative to last journal entry, rotating.
> Mar 26 08:44:17 fedora systemd-journald[1166]: Rotating system journal.
> Mar 26 08:44:17 fedora kernel: zram0: detected capacity change from 0 to =
16777216
> Mar 26 08:44:17 fedora kernel: intel_pmc_ssram_telemetry 0000:00:14.0: en=
abling device (0000 -> 0002)
> Mar 26 08:44:17 fedora kernel: Adding 8388604k swap on /dev/zram0.  Prior=
ity:100 extents:1 across:8388604k SSDsc
> Mar 26 08:44:18 fedora kernel: input: Intel HID events as /devices/platfo=
rm/INTC1070:00/input/input14
> Mar 26 08:44:18 fedora kernel: idma64 idma64.0: Found Intel integrated DM=
A 64-bit
> Mar 26 08:44:18 fedora kernel: idma64 idma64.1: Found Intel integrated DM=
A 64-bit
> Mar 26 08:44:18 fedora kernel: mc: Linux media interface: v0.10
> Mar 26 08:44:18 fedora kernel: Intel(R) 2.5G Ethernet Linux Driver
> Mar 26 08:44:18 fedora kernel: Copyright(c) 2018 Intel Corporation.
> Mar 26 08:44:18 fedora kernel: igc 0000:86:00.0: PTM enabled, 4ns granula=
rity
> Mar 26 08:44:18 fedora kernel: nvidia: loading out-of-tree module taints =
kernel.
> Mar 26 08:44:18 fedora kernel: input: PC Speaker as /devices/platform/pcs=
pkr/input/input15
> Mar 26 08:44:18 fedora kernel: igc 0000:86:00.0 (unnamed net_device) (uni=
nitialized): PHC added
> Mar 26 08:44:18 fedora kernel: nvidia-nvlink: Nvlink Core is being initia=
lized, major device number 509
> Mar 26 08:44:18 fedora kernel:=20
> Mar 26 08:44:18 fedora kernel: igc 0000:86:00.0: 4.000 Gb/s available PCI=
e bandwidth (5.0 GT/s PCIe x1 link)
> Mar 26 08:44:18 fedora kernel: igc 0000:86:00.0 eth0: MAC: a8:2b:dd:e3:4b=
:c9
> Mar 26 08:44:18 fedora kernel: nvidia 0000:01:00.0: enabling device (0002=
 -> 0003)
> Mar 26 08:44:18 fedora kernel: nvidia 0000:01:00.0: vgaarb: VGA decodes c=
hanged: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone
> Mar 26 08:44:18 fedora kernel: igc 0000:86:00.0 enp134s0: renamed from et=
h0
> Mar 26 08:44:18 fedora kernel: NVRM: loading NVIDIA UNIX Open Kernel Modu=
le for x86_64  580.126.18  Release Build  (dvs-builder@U22-I3-H04-01-6)  We=
d Feb 11 18:33:27 UTC 2026
> Mar 26 08:44:18 fedora kernel: i801_smbus 0000:80:1f.4: SPD Write Disable=
 is set
> Mar 26 08:44:18 fedora kernel: i801_smbus 0000:80:1f.4: SMBus using PCI i=
nterrupt
> Mar 26 08:44:18 fedora kernel: intel-spi 0000:80:1f.5: enabling device (0=
400 -> 0402)
> Mar 26 08:44:18 fedora kernel: Bluetooth: Core ver 2.22
> Mar 26 08:44:18 fedora kernel: NET: Registered PF_BLUETOOTH protocol fami=
ly
> Mar 26 08:44:18 fedora kernel: Bluetooth: HCI device and connection manag=
er initialized
> Mar 26 08:44:18 fedora kernel: Bluetooth: HCI socket layer initialized
> Mar 26 08:44:18 fedora kernel: Bluetooth: L2CAP socket layer initialized
> Mar 26 08:44:18 fedora kernel: Bluetooth: SCO socket layer initialized
> Mar 26 08:44:18 fedora kernel: videodev: Linux video capture interface: v=
2.00
> Mar 26 08:44:18 fedora kernel: i2c i2c-18: Successfully instantiated SPD =
at 0x52
> Mar 26 08:44:18 fedora kernel: i2c i2c-18: Successfully instantiated SPD =
at 0x53
> Mar 26 08:44:18 fedora kernel: cfg80211: Loading compiled-in X.509 certif=
icates for regulatory database
> Mar 26 08:44:18 fedora kernel: Loaded X.509 cert 'sforshee: 00b28ddf47aef=
9cea7'
> Mar 26 08:44:18 fedora kernel: Loaded X.509 cert 'wens: 61c038651aabdcf94=
bd0ac7ff06c7248db18c600'
> Mar 26 08:44:18 fedora kernel: nvidia-modeset: Loading NVIDIA UNIX Open K=
ernel Mode Setting Driver for x86_64  580.126.18  Release Build  (dvs-build=
er@U22-I3-H04-01-6)  Wed Feb 11 18:19:14 UTC 2026
> Mar 26 08:44:18 fedora kernel: iTCO_vendor_support: vendor-support=3D0
> Mar 26 08:44:18 fedora kernel: mei_gsc_proxy 0000:80:16.0-0f73db04-97ab-4=
125-b893-e904ad0d5464: bound 0000:00:02.0 (ops i915_gsc_proxy_component_ops=
 [i915])
> Mar 26 08:44:18 fedora kernel: spd5118 18-0052: DDR5 temperature sensor: =
vendor 0x00:0xb3 revision 2.2
> Mar 26 08:44:18 fedora kernel: spd5118 18-0053: DDR5 temperature sensor: =
vendor 0x00:0xb3 revision 2.2
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: ThinkPad ACPI Extras v0.26
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: http://ibm-acpi.sf.net/
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: ThinkPad BIOS N4FET30W (1.1=
1 ), EC N4FHT27W
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: Lenovo ThinkPad P16 Gen 3, =
model 21RQ003BGE
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: radio switch found; radios =
are enabled
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: This ThinkPad has standard =
ACPI backlight brightness control, supported by the ACPI video driver
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: Disabling thinkpad-acpi bri=
ghtness events by default...
> Mar 26 08:44:18 fedora kernel: spi-nor spi0.0: supply vcc not found, usin=
g dummy regulator
> Mar 26 08:44:18 fedora kernel: spi-nor spi0.0: unrecognized JEDEC id byte=
s: f7 f0 30 09 03 00
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: rfkill switch tpacpi_blueto=
oth_sw: radio is unblocked
> Mar 26 08:44:18 fedora kernel: iwlwifi 0000:84:00.0: enabling device (000=
0 -> 0002)
> Mar 26 08:44:18 fedora kernel: RAPL PMU: API unit is 2^-32 Joules, 4 fixe=
d counters, 655360 ms ovfl timer
> Mar 26 08:44:18 fedora kernel: RAPL PMU: hw unit of domain pp0-core 2^-14=
 Joules
> Mar 26 08:44:18 fedora kernel: RAPL PMU: hw unit of domain package 2^-14 =
Joules
> Mar 26 08:44:18 fedora kernel: RAPL PMU: hw unit of domain pp1-gpu 2^-14 =
Joules
> Mar 26 08:44:18 fedora kernel: RAPL PMU: hw unit of domain psys 2^-14 Jou=
les
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: secondary fan control detec=
ted & enabled
> Mar 26 08:44:18 fedora kernel: thinkpad_acpi: battery 1 registered (start=
 75, stop 80, behaviours: 0xb)
> Mar 26 08:44:18 fedora kernel: ACPI: battery: new hook: ThinkPad Battery =
Extension
> Mar 26 08:44:18 fedora kernel: pci 0000:00:08.0: Setting to D3hot
> Mar 26 08:44:18 fedora kernel: iwlwifi 0000:84:00.0: Detected crf-id 0x20=
01910, cnv-id 0x2001910 wfpm id 0x80000000
> Mar 26 08:44:18 fedora kernel: iwlwifi 0000:84:00.0: PCI dev 272b/00f4, r=
ev=3D0x472, rfid=3D0x112200
> Mar 26 08:44:18 fedora kernel: iwlwifi 0000:84:00.0: Detected Intel(R) Wi=
-Fi 7 BE200 320MHz
> Mar 26 08:44:18 fedora kernel: [drm] [nvidia-drm] [GPU ID 0x00000100] Loa=
ding driver
> Mar 26 08:44:18 fedora kernel: intel_pmc_core INT33A1:00:  initialized
> Mar 26 08:44:18 fedora kernel: iwlwifi 0000:84:00.0: loaded firmware vers=
ion 101.6e695a70.0 gl-c0-fm-c0-c101.ucode op_mode iwlmld
> Mar 26 08:44:18 fedora kernel: input: ThinkPad Extra Buttons as /devices/=
platform/thinkpad_acpi/input/input16
> Mar 26 08:44:18 fedora kernel: iTCO_wdt iTCO_wdt: Found a Intel PCH TCO d=
evice (Version=3D6, TCOBASE=3D0x8e00)
> Mar 26 08:44:18 fedora kernel: iTCO_wdt iTCO_wdt: initialized. heartbeat=
=3D30 sec (nowayout=3D0)
> Mar 26 08:44:18 fedora kernel: EXT4-fs (nvme0n1p2): mounted filesystem d5=
bf4d09-7f11-4acd-a48c-445c5ec7a7d6 r/w with ordered data mode. Quota mode: =
none.
> Mar 26 08:44:18 fedora kernel: intel_rapl_common: Found RAPL domain packa=
ge
> Mar 26 08:44:18 fedora kernel: intel_rapl_common: Found RAPL domain core
> Mar 26 08:44:18 fedora kernel: intel_rapl_common: Found RAPL domain uncore
> Mar 26 08:44:18 fedora kernel: intel_rapl_common: Found RAPL domain psys
> Mar 26 08:44:18 fedora kernel: usbcore: registered new interface driver b=
tusb
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: Device revision is 0
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: Secure boot is enabled
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: OTP lock is disabled
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: API lock is enabled
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: Debug lock is disabled
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: Minimum firmware build 1 =
week 10 2014
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: Bootloader timestamp 2022=
=2E18 buildtype 1 build 16362
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: DSM reset method type: 0x=
01
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: Found device firmware: in=
tel/ibt-0291-0291.sfi
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: Boot Address: 0x100800
> Mar 26 08:44:18 fedora kernel: Bluetooth: hci0: Firmware Version: 155-3.26
> Mar 26 08:44:18 fedora kernel: uvcvideo 3-4:1.0: Found UVC 1.50 device In=
tegrated Camera (04f2:b83f)
> Mar 26 08:44:18 fedora kernel: uvcvideo 3-4:1.2: Found UVC 1.50 device In=
tegrated Camera (04f2:b83f)
> Mar 26 08:44:18 fedora kernel: usbcore: registered new interface driver u=
vcvideo
> Mar 26 08:44:19 fedora kernel: nvidia 0000:01:00.0: Enabling HDA controll=
er
> Mar 26 08:44:19 fedora kernel: snd_hda_intel 0000:01:00.1: Disabling MSI
> Mar 26 08:44:19 fedora kernel: snd_hda_intel 0000:01:00.1: Handle vga_swi=
tcheroo audio client
> Mar 26 08:44:19 fedora kernel: snd_hda_intel 0000:80:1f.3: SoundWire enab=
led on CannonLake+ platform, using SOF driver
> Mar 26 08:44:19 fedora kernel: proc_thermal_pci 0000:00:04.0: enabling de=
vice (0000 -> 0002)
> Mar 26 08:44:19 fedora kernel: intel_rapl_common: Found RAPL domain packa=
ge
> Mar 26 08:44:19 fedora kernel: input: HDA NVidia HDMI/DP,pcm=3D3 as /devi=
ces/pci0000:00/0000:00:06.0/0000:01:00.1/sound/card0/input17
> Mar 26 08:44:19 fedora kernel: input: HDA NVidia HDMI/DP,pcm=3D7 as /devi=
ces/pci0000:00/0000:00:06.0/0000:01:00.1/sound/card0/input18
> Mar 26 08:44:19 fedora kernel: input: HDA NVidia HDMI/DP,pcm=3D8 as /devi=
ces/pci0000:00/0000:00:06.0/0000:01:00.1/sound/card0/input19
> Mar 26 08:44:19 fedora kernel: input: HDA NVidia HDMI/DP,pcm=3D9 as /devi=
ces/pci0000:00/0000:00:06.0/0000:01:00.1/sound/card0/input20
> Mar 26 08:44:19 fedora kernel: NVRM: testIfDsmSubFunctionEnabled: GPS ACP=
I DSM called before _acpiDsmSupportedFuncCacheInit subfunction =3D 11.
> Mar 26 08:44:19 fedora kernel: iwlwifi 0000:84:00.0: Detected RF FM, rfid=
=3D0x112200
> Mar 26 08:44:19 fedora kernel: iwlwifi 0000:84:00.0: base HW address: e0:=
d5:5d:70:d2:e4
> Mar 26 08:44:19 fedora kernel: iwlwifi 0000:84:00.0 wlp132s0f0: renamed f=
rom wlan0
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: enab=
ling device (0000 -> 0002)
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: DSP =
detected with PCI class/subclass/prog-if 0x040100
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: boun=
d 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: use =
msi interrupt mode
> Mar 26 08:44:19 fedora kernel: acpi device:62: SDCA function UAJ (type 6)=
 at 0x3
> Mar 26 08:44:19 fedora kernel: acpi device:63: SDCA function HID (type 10=
) at 0x4
> Mar 26 08:44:19 fedora kernel: acpi device:5e: SDCA function SmartAmp (ty=
pe 1) at 0x1
> Mar 26 08:44:19 fedora kernel: acpi device:60: SDCA function SmartAmp (ty=
pe 1) at 0x1
> Mar 26 08:44:19 fedora kernel: nvme nvme0: using unchecked data buffer
> Mar 26 08:44:19 fedora kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1=
=2E3
> Mar 26 08:44:19 fedora kernel: Bluetooth: BNEP filters: protocol multicast
> Mar 26 08:44:19 fedora kernel: Bluetooth: BNEP socket layer initialized
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: hda =
codecs found, mask 4
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: NHLT=
 device BT(0) detected, ssp_mask 0x4
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: BT l=
ink detected in NHLT tables: 0x4
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: DMIC=
s detected in NHLT tables: 2
> Mar 26 08:44:19 fedora kernel: cs42l43 sdw:0:0:01fa:4243:01: supply vdd-p=
 not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: cs42l43 sdw:0:0:01fa:4243:01: supply vdd-d=
 not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: cs42l43 sdw:0:0:01fa:4243:01: supply vdd-a=
 not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: cs42l43 sdw:0:0:01fa:4243:01: supply vdd-i=
o not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: cs42l43 sdw:0:0:01fa:4243:01: supply vdd-c=
p not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: Firm=
ware paths/files for ipc type 1:
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3:  Fir=
mware file:     intel/sof-ipc4/arl-s/sof-arl-s.ri
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3:  Fir=
mware lib path: intel/sof-ipc4-lib/arl-s
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3:  Top=
ology file:     function topologies
> Mar 26 08:44:19 fedora kernel: NET: Registered PF_QIPCRTR protocol family
> Mar 26 08:44:19 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: Load=
ed firmware library: ADSPFW, version: 2.14.1.1
> Mar 26 08:44:19 fedora kernel: RPC: Registered named UNIX socket transpor=
t module.
> Mar 26 08:44:19 fedora kernel: RPC: Registered udp transport module.
> Mar 26 08:44:19 fedora kernel: RPC: Registered tcp transport module.
> Mar 26 08:44:19 fedora kernel: RPC: Registered tcp-with-tls transport mod=
ule.
> Mar 26 08:44:19 fedora kernel: RPC: Registered tcp NFSv4.1 backchannel tr=
ansport module.
> Mar 26 08:44:19 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: supply VDD=
_P not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: supply VDD=
_IO not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: supply VDD=
_A not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: supply VDD=
_P not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: supply VDD=
_IO not found, using dummy regulator
> Mar 26 08:44:19 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: supply VDD=
_A not found, using dummy regulator
> Mar 26 08:44:20 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: Boot=
ed firmware version: 2.14.1.1
> Mar 26 08:44:20 fedora kernel: cs42l43 sdw:0:0:01fa:4243:01: devid: 0x042=
a43, rev: 0xa1, otp: 0x03
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: Cirrus Log=
ic CS35L56 Rev B0 OTP3 fw:3.4.4 (patched=3D0)
> Mar 26 08:44:20 fedora kernel: cs42l43 sdw:0:0:01fa:4243:01: Slave 6 stat=
e check1: UNATTACHED, status was 1
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: Cirrus Log=
ic CS35L56 Rev B0 OTP3 fw:3.4.4 (patched=3D0)
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: Slave 1 st=
ate check1: UNATTACHED, status was 1
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: Slave 2 st=
ate check1: UNATTACHED, status was 1
> Mar 26 08:44:20 fedora kernel: Adding alias for supply vdd-amp,(null) -> =
vdd-amp,sdw:0:0:01fa:4243:01
> Mar 26 08:44:20 fedora kernel: cs42l43-codec cs42l43-codec: supply vdd-am=
p not found, using dummy regulator
> Mar 26 08:44:20 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: load=
ing topology: intel/sof-ipc4-tplg/sof-arl-cs42l43-l0-cs35l56-l2-2ch.tplg
> Mar 26 08:44:20 fedora kernel: sof-audio-pci-intel-mtl 0000:80:1f.3: Topo=
logy: ABI 3:29:1 Kernel ABI 3:23:1
> Mar 26 08:44:20 fedora kernel: sof_sdw sof_sdw: ASoC: Parent card not yet=
 available, widget card binding deferred
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: supply VDD=
_B not found, using dummy regulator
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: supply VDD=
_AMP not found, using dummy regulator
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: supply VDD=
_B not found, using dummy regulator
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: supply VDD=
_AMP not found, using dummy regulator
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: DSP1: cirr=
us/cs35l56-b0-dsp1-misc-17aa2347.wmfw: format 3 timestamp 0x6864754d
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: DSP1: cirr=
us/cs35l56-b0-dsp1-misc-17aa2347.wmfw: Tue 01 Jul 2025 18:54:52 Central Day=
light Time
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: DSP1: cirr=
us/cs35l56-b0-dsp1-misc-17aa2347.wmfw: format 3 timestamp 0x6864754d
> Mar 26 08:44:20 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: DSP1: cirr=
us/cs35l56-b0-dsp1-misc-17aa2347.wmfw: Tue 01 Jul 2025 18:54:52 Central Day=
light Time
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Waiting for firmware down=
load to complete
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Firmware loaded in 233583=
9 usecs
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Waiting for device to boot
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Device booted in 55709 us=
ecs
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: dsbr: enable: 0x01 value:=
 0x0f
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Found Intel DDC parameter=
s: intel/ibt-0291-0291.ddc
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Applying Intel DDC parame=
ters completed
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Firmware timestamp 2026.3=
 buildtype 1 build 2203
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Firmware SHA1: 0xd68504ef
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Fseq status: Success (0x0=
0)
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Fseq executed: 00.00.04.2=
02
> Mar 26 08:44:21 fedora kernel: Bluetooth: hci0: Fseq BT Top: 00.00.04.202
> Mar 26 08:44:21 fedora kernel: Bluetooth: MGMT ver 1.23
> Mar 26 08:44:22 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: DSP1: Firm=
ware: 1a10d6 vendor: 0x2 v3.13.3, 41 algorithms
> Mar 26 08:44:22 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: DSP1: Firm=
ware: 1a10d6 vendor: 0x2 v3.13.3, 41 algorithms
> Mar 26 08:44:22 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: DSP1: cirr=
us/cs35l56-b0-dsp1-misc-17aa2347-amp2.bin: v3.13.3
> Mar 26 08:44:22 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: DSP1: Misc=
: C:\Users\pfoskey\Desktop\Yang\P16\Default Use Case-CS35L56 [I2C - 0x60] @=
 Virtual CS35L56 x2 on Wind
> Mar 26 08:44:22 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: DSP1: cirr=
us/cs35l56-b0-dsp1-misc-17aa2347-amp1.bin: v3.13.3
> Mar 26 08:44:22 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: DSP1: Misc=
: C:\Users\pfoskey\Desktop\Yang\P16\Default Use Case-CS35L56 [I2C - 0x68] @=
 Virtual CS35L56 x2 on Wind
> Mar 26 08:44:22 fedora kernel: NVRM: testIfDsmSubFunctionEnabled: GPS ACP=
I DSM called before _acpiDsmSupportedFuncCacheInit subfunction =3D 11.
> Mar 26 08:44:22 fedora kernel: [drm] Initialized nvidia-drm 0.0.0 for 000=
0:01:00.0 on minor 0
> Mar 26 08:44:22 fedora kernel: nvidia 0000:01:00.0: [drm] Cannot find any=
 crtc or sizes
> Mar 26 08:44:23 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: Slave 1 st=
ate check1: UNATTACHED, status was 1
> Mar 26 08:44:23 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: Slave 2 st=
ate check1: UNATTACHED, status was 1
> Mar 26 08:44:23 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: Calibratio=
n applied
> Mar 26 08:44:23 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:1: Tuning PID=
: 0x25, SID: 0x7, TID: 0x4
> Mar 26 08:44:23 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: Calibratio=
n applied
> Mar 26 08:44:23 fedora kernel: cs35l56 sdw:0:2:01fa:3556:01:0: Tuning PID=
: 0x15, SID: 0x7, TID: 0x4
> Mar 26 08:44:23 fedora kernel: sof_sdw sof_sdw: hda_dsp_hdmi_build_contro=
ls: no PCM in topology for HDMI converter 3
> Mar 26 08:44:23 fedora kernel: input: sof-soundwire Jack as /devices/pci0=
000:80/0000:80:1f.3/sof_sdw/sound/card1/input21
> Mar 26 08:44:23 fedora kernel: input: sof-soundwire HDMI/DP,pcm=3D5 as /d=
evices/pci0000:80/0000:80:1f.3/sof_sdw/sound/card1/input22
> Mar 26 08:44:23 fedora kernel: input: sof-soundwire HDMI/DP,pcm=3D6 as /d=
evices/pci0000:80/0000:80:1f.3/sof_sdw/sound/card1/input23
> Mar 26 08:44:23 fedora kernel: input: sof-soundwire HDMI/DP,pcm=3D7 as /d=
evices/pci0000:80/0000:80:1f.3/sof_sdw/sound/card1/input24
> Mar 26 08:44:23 fedora kernel: igc 0000:86:00.0 enp134s0: NIC Link is Up =
1000 Mbps Full Duplex, Flow Control: RX
> Mar 26 08:44:25 fedora kernel: Bluetooth: RFCOMM TTY layer initialized
> Mar 26 08:44:25 fedora kernel: Bluetooth: RFCOMM socket layer initialized
> Mar 26 08:44:25 fedora kernel: Bluetooth: RFCOMM ver 1.11
> Mar 26 08:44:27 fedora kernel: Lockdown: systemd-logind: hibernation is r=
estricted; see man kernel_lockdown.7
> Mar 26 08:44:27 fedora kernel: rfkill: input handler disabled
> Mar 26 08:44:28 fedora kernel: usb 3-3: reset full-speed USB device numbe=
r 2 using xhci_hcd
> Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: Data Link Layer Lin=
k Active not set in 100 msec
> Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot(25): C=
ard not present
> Mar 26 08:44:29 fedora kernel: ------------[ cut here ]------------
> Mar 26 08:44:29 fedora kernel: thunderbolt 0000:8a:00.0: interrupt for TX=
 ring 0 is already enabled
> Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: Controller not read=
y at resume -19
> Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: PCI post-resume err=
or -19!
> Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: HC died; cleaning up
> Mar 26 08:44:29 fedora kernel: WARNING: drivers/thunderbolt/nhi.c:147 at =
ring_interrupt_active+0x246/0x2f0 [thunderbolt], CPU#3: kworker/u96:5/1092
> Mar 26 08:44:29 fedora kernel: Modules linked in: snd_seq_dummy rfcomm sn=
d_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_f=
ib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 =
nft_reject nft_ct snd_soc_cs42l43 snd_soc_cs42l43_sdw pinctrl_cs42l43 spi_c=
s42l43 nft_chain_nat nf_nat snd_soc_sof_sdw nf_conntrack snd_sof_probes snd=
_soc_intel_hda_dsp_common nf_defrag_ipv6 nf_defrag_ipv4 nf_tables snd_soc_c=
s35l56_sdw snd_soc_cs35l56 sunrpc snd_soc_cs35l56_shared snd_soc_cs_amp_lib=
 snd_soc_rt711_sdca qrtr snd_soc_wm_adsp cs42l43_sdw regmap_sdw_mbq cs_dsp =
snd_hda_codec_intelhdmi cs42l43 regmap_sdw bnep snd_soc_dmic snd_sof_pci_in=
tel_mtl snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt=
 snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_=
intel_hda soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_=
utils snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_qui=
rks soundwire_generic_allocation snd_soc_sdw_utils snd_hda_codec_nvhdmi
> Mar 26 08:44:29 fedora kernel:  snd_soc_acpi snd_hda_codec_hdmi crc8 inte=
l_uncore_frequency processor_thermal_device_pci soundwire_bus snd_hda_intel=
 intel_uncore_frequency_common processor_thermal_device snd_soc_sdca snd_hd=
a_codec x86_pkg_temp_thermal processor_thermal_wt_hint snd_soc_core intel_p=
owerclamp snd_hda_core platform_temperature_control coretemp snd_compress i=
wlmld snd_intel_dspcfg uvcvideo processor_thermal_soc_slider ac97_bus kvm_i=
ntel snd_intel_sdw_acpi btusb vfat uvc mac80211 processor_thermal_rfim snd_=
pcm_dmaengine snd_hwdep fat videobuf2_vmalloc btmtk kvm intel_rapl_msr proc=
essor_thermal_rapl snd_seq videobuf2_memops libarc4 btrtl iTCO_wdt snd_ctl_=
led irqbypass intel_rapl_common snd_seq_device videobuf2_v4l2 btbcm lenovo_=
wmi_other intel_pmc_bxt nvidia_drm(O) intel_pmc_core rapl iwlwifi processor=
_thermal_wt_req snd_pcm spi_nor thinkpad_acpi mtd spd5118 videobuf2_common =
btintel mei_gsc_proxy lenovo_wmi_helpers iTCO_vendor_support nvidia_modeset=
(O) pmt_telemetry intel_cstate processor_thermal_power_floor snd_timer
> Mar 26 08:44:29 fedora kernel:  platform_profile lenovo_wmi_capdata01 cfg=
80211 videodev bluetooth spi_intel_pci i2c_i801 mei_me pmt_discovery int340=
3_thermal processor_thermal_mbox intel_uncore pcspkr snd nvidia(O) think_lm=
i igc firmware_attributes_class mc wmi_bmof rfkill spi_intel i2c_smbus mei =
idma64 int3400_thermal pmt_class intel_hid acpi_tad int340x_thermal_zone so=
undcore acpi_pad joydev acpi_thermal_rel intel_pmc_ssram_telemetry sparse_k=
eymap loop nfnetlink zram lz4hc_compress lz4_compress dm_crypt xe drm_ttm_h=
elper drm_suballoc_helper gpu_sched drm_gpuvm drm_exec drm_gpusvm_helper i9=
15 ucsi_acpi typec_ucsi typec i2c_algo_bit nvme drm_buddy nvme_core ttm rts=
x_pci_sdmmc hid_multitouch nvme_keyring mmc_core nvme_auth drm_display_help=
er i2c_hid_acpi video ghash_clmulni_intel rtsx_pci thunderbolt hkdf intel_v=
pu i2c_hid cec intel_vsec wmi pinctrl_meteorlake pinctrl_meteorpoint serio_=
raw hid_sensor_hub i2c_dev fuse
> Mar 26 08:44:29 fedora kernel: CPU: 3 UID: 0 PID: 1092 Comm: kworker/u96:=
5 Tainted: G           O        6.19.10-200.fc43.x86_64 #1 PREEMPT(lazy)=20
> Mar 26 08:44:29 fedora kernel: Tainted: [O]=3DOOT_MODULE
> Mar 26 08:44:29 fedora kernel: Hardware name: LENOVO 21RQ003BGE/21RQ003BG=
E, BIOS N4FET30W (1.11 ) 10/03/2025
> Mar 26 08:44:29 fedora kernel: Workqueue: pm pm_runtime_work
> Mar 26 08:44:29 fedora kernel: RIP: 0010:ring_interrupt_active+0x25b/0x2f=
0 [thunderbolt]
> Mar 26 08:44:29 fedora kernel: Code: 89 5c 24 08 44 89 44 24 04 e8 81 5d =
fb d3 48 8d 3d 7a a9 e8 ff 44 8b 44 24 04 48 8b 4c 24 10 4d 89 f1 48 89 c6 =
48 8b 54 24 18 <67> 48 0f b9 3a 4d 8b 77 08 44 8b 5c 24 08 49 8b 76 18 45 8=
4 e4 0f
> Mar 26 08:44:29 fedora kernel: RSP: 0018:ffffd04d80affcc0 EFLAGS: 00010082
> Mar 26 08:44:29 fedora kernel: RAX: ffffffffc05237b3 RBX: 000000000000000=
0 RCX: ffffffffc05237e3
> Mar 26 08:44:29 fedora kernel: RDX: ffff8cdb441144c0 RSI: ffffffffc05237b=
3 RDI: ffffffffc04eb000
> Mar 26 08:44:29 fedora kernel: RBP: 0000000000000001 R08: 000000000000000=
0 R09: ffffffffc05237d2
> Mar 26 08:44:29 fedora kernel: R10: ffff8cdb41f3b320 R11: 00000000fffffff=
f R12: 0000000000000001
> Mar 26 08:44:29 fedora kernel: R13: 0000000000038200 R14: ffffffffc05237d=
2 R15: ffff8cdb5c0d8b40
> Mar 26 08:44:29 fedora kernel: FS:  0000000000000000(0000) GS:ffff8cf2d89=
6f000(0000) knlGS:0000000000000000
> Mar 26 08:44:29 fedora kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Mar 26 08:44:29 fedora kernel: CR2: 000055f4842eb958 CR3: 00000001b042e00=
1 CR4: 0000000000f72ef0
> Mar 26 08:44:29 fedora kernel: PKRU: 55555554
> Mar 26 08:44:29 fedora kernel: Call Trace:
> Mar 26 08:44:29 fedora kernel:  <TASK>
> Mar 26 08:44:29 fedora kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  tb_ring_start+0x149/0x330 [thunderbolt]
> Mar 26 08:44:29 fedora kernel:  tb_ctl_start+0x1b/0xc0 [thunderbolt]
> Mar 26 08:44:29 fedora kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  tb_domain_runtime_resume+0x19/0x40 [thund=
erbolt]
> Mar 26 08:44:29 fedora kernel:  __rpm_callback+0x48/0x1f0
> Mar 26 08:44:29 fedora kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  rpm_callback+0x6d/0x80
> Mar 26 08:44:29 fedora kernel:  rpm_resume+0x4ab/0x6d0
> Mar 26 08:44:29 fedora kernel:  pm_runtime_work+0x70/0xb0
> Mar 26 08:44:29 fedora kernel:  process_one_work+0x192/0x350
> Mar 26 08:44:29 fedora kernel:  worker_thread+0x196/0x300
> Mar 26 08:44:29 fedora kernel:  ? __pfx_worker_thread+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  kthread+0xfc/0x240
> Mar 26 08:44:29 fedora kernel:  ? __pfx_kthread+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  ? __pfx_kthread+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  ret_from_fork+0x130/0x1a0
> Mar 26 08:44:29 fedora kernel:  ? __pfx_kthread+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  ret_from_fork_asm+0x1a/0x30
> Mar 26 08:44:29 fedora kernel:  </TASK>
> Mar 26 08:44:29 fedora kernel: ---[ end trace 0000000000000000 ]---
> Mar 26 08:44:29 fedora kernel: ------------[ cut here ]------------
> Mar 26 08:44:29 fedora kernel: thunderbolt 0000:8a:00.0: interrupt for RX=
 ring 0 is already enabled
> Mar 26 08:44:29 fedora kernel: WARNING: drivers/thunderbolt/nhi.c:147 at =
ring_interrupt_active+0x246/0x2f0 [thunderbolt], CPU#3: kworker/u96:5/1092
> Mar 26 08:44:29 fedora kernel: Modules linked in: snd_seq_dummy rfcomm sn=
d_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_f=
ib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 =
nft_reject nft_ct snd_soc_cs42l43 snd_soc_cs42l43_sdw pinctrl_cs42l43 spi_c=
s42l43 nft_chain_nat nf_nat snd_soc_sof_sdw nf_conntrack snd_sof_probes snd=
_soc_intel_hda_dsp_common nf_defrag_ipv6 nf_defrag_ipv4 nf_tables snd_soc_c=
s35l56_sdw snd_soc_cs35l56 sunrpc snd_soc_cs35l56_shared snd_soc_cs_amp_lib=
 snd_soc_rt711_sdca qrtr snd_soc_wm_adsp cs42l43_sdw regmap_sdw_mbq cs_dsp =
snd_hda_codec_intelhdmi cs42l43 regmap_sdw bnep snd_soc_dmic snd_sof_pci_in=
tel_mtl snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt=
 snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_=
intel_hda soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_=
utils snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_qui=
rks soundwire_generic_allocation snd_soc_sdw_utils snd_hda_codec_nvhdmi
> Mar 26 08:44:29 fedora kernel:  snd_soc_acpi snd_hda_codec_hdmi crc8 inte=
l_uncore_frequency processor_thermal_device_pci soundwire_bus snd_hda_intel=
 intel_uncore_frequency_common processor_thermal_device snd_soc_sdca snd_hd=
a_codec x86_pkg_temp_thermal processor_thermal_wt_hint snd_soc_core intel_p=
owerclamp snd_hda_core platform_temperature_control coretemp snd_compress i=
wlmld snd_intel_dspcfg uvcvideo processor_thermal_soc_slider ac97_bus kvm_i=
ntel snd_intel_sdw_acpi btusb vfat uvc mac80211 processor_thermal_rfim snd_=
pcm_dmaengine snd_hwdep fat videobuf2_vmalloc btmtk kvm intel_rapl_msr proc=
essor_thermal_rapl snd_seq videobuf2_memops libarc4 btrtl iTCO_wdt snd_ctl_=
led irqbypass intel_rapl_common snd_seq_device videobuf2_v4l2 btbcm lenovo_=
wmi_other intel_pmc_bxt nvidia_drm(O) intel_pmc_core rapl iwlwifi processor=
_thermal_wt_req snd_pcm spi_nor thinkpad_acpi mtd spd5118 videobuf2_common =
btintel mei_gsc_proxy lenovo_wmi_helpers iTCO_vendor_support nvidia_modeset=
(O) pmt_telemetry intel_cstate processor_thermal_power_floor snd_timer
> Mar 26 08:44:29 fedora kernel:  platform_profile lenovo_wmi_capdata01 cfg=
80211 videodev bluetooth spi_intel_pci i2c_i801 mei_me pmt_discovery int340=
3_thermal processor_thermal_mbox intel_uncore pcspkr snd nvidia(O) think_lm=
i igc firmware_attributes_class mc wmi_bmof rfkill spi_intel i2c_smbus mei =
idma64 int3400_thermal pmt_class intel_hid acpi_tad int340x_thermal_zone so=
undcore acpi_pad joydev acpi_thermal_rel intel_pmc_ssram_telemetry sparse_k=
eymap loop nfnetlink zram lz4hc_compress lz4_compress dm_crypt xe drm_ttm_h=
elper drm_suballoc_helper gpu_sched drm_gpuvm drm_exec drm_gpusvm_helper i9=
15 ucsi_acpi typec_ucsi typec i2c_algo_bit nvme drm_buddy nvme_core ttm rts=
x_pci_sdmmc hid_multitouch nvme_keyring mmc_core nvme_auth drm_display_help=
er i2c_hid_acpi video ghash_clmulni_intel rtsx_pci thunderbolt hkdf intel_v=
pu i2c_hid cec intel_vsec wmi pinctrl_meteorlake pinctrl_meteorpoint serio_=
raw hid_sensor_hub i2c_dev fuse
> Mar 26 08:44:29 fedora kernel: CPU: 3 UID: 0 PID: 1092 Comm: kworker/u96:=
5 Tainted: G        W  O        6.19.10-200.fc43.x86_64 #1 PREEMPT(lazy)=20
> Mar 26 08:44:29 fedora kernel: Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
> Mar 26 08:44:29 fedora kernel: Hardware name: LENOVO 21RQ003BGE/21RQ003BG=
E, BIOS N4FET30W (1.11 ) 10/03/2025
> Mar 26 08:44:29 fedora kernel: Workqueue: pm pm_runtime_work
> Mar 26 08:44:29 fedora kernel: RIP: 0010:ring_interrupt_active+0x25b/0x2f=
0 [thunderbolt]
> Mar 26 08:44:29 fedora kernel: Code: 89 5c 24 08 44 89 44 24 04 e8 81 5d =
fb d3 48 8d 3d 7a a9 e8 ff 44 8b 44 24 04 48 8b 4c 24 10 4d 89 f1 48 89 c6 =
48 8b 54 24 18 <67> 48 0f b9 3a 4d 8b 77 08 44 8b 5c 24 08 49 8b 76 18 45 8=
4 e4 0f
> Mar 26 08:44:29 fedora kernel: RSP: 0018:ffffd04d80affcc0 EFLAGS: 00010082
> Mar 26 08:44:29 fedora kernel: RAX: ffffffffc05237b3 RBX: 000000000000000=
0 RCX: ffffffffc05237eb
> Mar 26 08:44:29 fedora kernel: RDX: ffff8cdb441144c0 RSI: ffffffffc05237b=
3 RDI: ffffffffc04eb000
> Mar 26 08:44:29 fedora kernel: RBP: 0000000000001000 R08: 000000000000000=
0 R09: ffffffffc05237d2
> Mar 26 08:44:29 fedora kernel: R10: ffff8cdb41f3b320 R11: 00000000fffffff=
f R12: 0000000000000001
> Mar 26 08:44:29 fedora kernel: R13: 0000000000038200 R14: ffffffffc05237d=
2 R15: ffff8cdb5c0ddd40
> Mar 26 08:44:29 fedora kernel: FS:  0000000000000000(0000) GS:ffff8cf2d89=
6f000(0000) knlGS:0000000000000000
> Mar 26 08:44:29 fedora kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Mar 26 08:44:29 fedora kernel: CR2: 000055f4842eb958 CR3: 00000001b042e00=
1 CR4: 0000000000f72ef0
> Mar 26 08:44:29 fedora kernel: PKRU: 55555554
> Mar 26 08:44:29 fedora kernel: Call Trace:
> Mar 26 08:44:29 fedora kernel:  <TASK>
> Mar 26 08:44:29 fedora kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  tb_ring_start+0x149/0x330 [thunderbolt]
> Mar 26 08:44:29 fedora kernel:  ? _raw_spin_unlock_irq+0x15/0x40
> Mar 26 08:44:29 fedora kernel:  tb_ctl_start+0x24/0xc0 [thunderbolt]
> Mar 26 08:44:29 fedora kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  tb_domain_runtime_resume+0x19/0x40 [thund=
erbolt]
> Mar 26 08:44:29 fedora kernel:  __rpm_callback+0x48/0x1f0
> Mar 26 08:44:29 fedora kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  rpm_callback+0x6d/0x80
> Mar 26 08:44:29 fedora kernel:  rpm_resume+0x4ab/0x6d0
> Mar 26 08:44:29 fedora kernel:  pm_runtime_work+0x70/0xb0
> Mar 26 08:44:29 fedora kernel:  process_one_work+0x192/0x350
> Mar 26 08:44:29 fedora kernel:  worker_thread+0x196/0x300
> Mar 26 08:44:29 fedora kernel:  ? __pfx_worker_thread+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  kthread+0xfc/0x240
> Mar 26 08:44:29 fedora kernel:  ? __pfx_kthread+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  ? __pfx_kthread+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  ret_from_fork+0x130/0x1a0
> Mar 26 08:44:29 fedora kernel:  ? __pfx_kthread+0x10/0x10
> Mar 26 08:44:29 fedora kernel:  ret_from_fork_asm+0x1a/0x30
> Mar 26 08:44:29 fedora kernel:  </TASK>
> Mar 26 08:44:29 fedora kernel: ---[ end trace 0000000000000000 ]---
> Mar 26 08:44:30 fedora kernel: thunderbolt 0000:8a:00.0: 0: timeout writi=
ng config space 2 to 0x1
> Mar 26 08:44:30 fedora kernel: thunderbolt 0000:8a:00.0: 0: timeout readi=
ng config space 2 from 0x6e
> Mar 26 08:44:30 fedora kernel: thunderbolt 0000:8a:00.0: 0: timeout readi=
ng config space 2 from 0x6b
> Mar 26 08:44:30 fedora kernel: thunderbolt 0000:8a:00.0: 0: failed to res=
tore TMU configuration
> Mar 26 08:44:31 fedora kernel: thunderbolt 0000:8a:00.0: 0: timeout writi=
ng config space 2 to 0x19
> Mar 26 08:44:31 fedora kernel: thunderbolt 0000:8a:00.0: 0: timeout writi=
ng config space 2 to 0x19
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b1:00.0: remove, state 4
> Mar 26 08:44:31 fedora kernel: usb usb6: USB disconnect, device number 1
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b1:00.0: USB bus 6 deregiste=
red
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b1:00.0: remove, state 4
> Mar 26 08:44:31 fedora kernel: usb usb5: USB disconnect, device number 1
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b1:00.0: Host halt failed, -=
19
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b1:00.0: Host not accessible=
, reset failed.
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b1:00.0: USB bus 5 deregiste=
red
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:8a: busn_res: [bus 8a] is rel=
eased
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:8b: busn_res: [bus 8b-b0] is =
released
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:b1: busn_res: [bus b1] is rel=
eased
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:b2: busn_res: [bus b2-d8] is =
released
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:89: busn_res: [bus 89-d8] is =
released
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot(25): C=
ard present
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot(25): L=
ink Up
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Upstream Port
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: PCI bridge to [bus 00]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0:   bridge window [io  0x0=
000-0x0fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0x0=
0000000-0x000fffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0x0=
0000000-0x000fffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: enabling Extended Tags
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: supports D1 D2
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: Adding to iommu group 27
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge configuration inv=
alid ([bus 00-00]), reconfiguring
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Downstream Port
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: PCI bridge to [bus 00]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0:   bridge window [io  0x0=
000-0x0fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0:   bridge window [mem 0x0=
0000000-0x000fffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0:   bridge window [mem 0x0=
0000000-0x000fffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: enabling Extended Tags
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: supports D1 D2
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: Adding to iommu group 28
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Downstream Port
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: PCI bridge to [bus 00]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0:   bridge window [io  0x0=
000-0x0fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0x0=
0000000-0x000fffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0x0=
0000000-0x000fffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: enabling Extended Tags
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: supports D1 D2
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: Adding to iommu group 29
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Downstream Port
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: PCI bridge to [bus 00]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0:   bridge window [io  0x0=
000-0x0fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0:   bridge window [mem 0x0=
0000000-0x000fffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0:   bridge window [mem 0x0=
0000000-0x000fffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: enabling Extended Tags
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: supports D1 D2
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: Adding to iommu group 30
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: [8086:5780] type 01 clas=
s 0x060400 PCIe Switch Downstream Port
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: PCI bridge to [bus 00]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0:   bridge window [io  0x0=
000-0x0fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0x0=
0000000-0x000fffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0x0=
0000000-0x000fffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: enabling Extended Tags
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: supports D1 D2
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: Adding to iommu group 31
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: PCI bridge to [bus 89-d8]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: bridge configuration inv=
alid ([bus 00-00]), reconfiguring
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge configuration inv=
alid ([bus 00-00]), reconfiguring
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: bridge configuration inv=
alid ([bus 00-00]), reconfiguring
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge configuration inv=
alid ([bus 00-00]), reconfiguring
> Mar 26 08:44:31 fedora kernel: pci 0000:8a:00.0: [8086:5781] type 00 clas=
s 0x0c0340 PCIe Endpoint
> Mar 26 08:44:31 fedora kernel: pci 0000:8a:00.0: BAR 0 [mem 0x00000000-0x=
0003ffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:8a:00.0: BAR 2 [mem 0x00000000-0x=
00000fff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:8a:00.0: enabling Extended Tags
> Mar 26 08:44:31 fedora kernel: pci 0000:8a:00.0: supports D1 D2
> Mar 26 08:44:31 fedora kernel: pci 0000:8a:00.0: PME# supported from D0 D=
1 D2 D3hot D3cold
> Mar 26 08:44:31 fedora kernel: pci 0000:8a:00.0: Adding to iommu group 32
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: PCI bridge to [bus 8a-d8]
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:8a: busn_res: [bus 8a-d8] end=
 is updated to 8a
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: PCI bridge to [bus 8b-d8]
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:8b: busn_res: [bus 8b-d8] end=
 is updated to b1
> Mar 26 08:44:31 fedora kernel: pci 0000:b2:00.0: [8086:5782] type 00 clas=
s 0x0c0330 PCIe Endpoint
> Mar 26 08:44:31 fedora kernel: pci 0000:b2:00.0: BAR 0 [mem 0x00000000-0x=
0000ffff 64bit]
> Mar 26 08:44:31 fedora kernel: pci 0000:b2:00.0: enabling Extended Tags
> Mar 26 08:44:31 fedora kernel: pci 0000:b2:00.0: PME# supported from D3ho=
t D3cold
> Mar 26 08:44:31 fedora kernel: pci 0000:b2:00.0: Adding to iommu group 33
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: PCI bridge to [bus b2-d8]
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:b2: busn_res: [bus b2-d8] end=
 is updated to b2
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: PCI bridge to [bus b3-d8]
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:b3: busn_res: [bus b3-d8] end=
 is updated to d8
> Mar 26 08:44:31 fedora kernel: pci_bus 0000:89: busn_res: [bus 89-d8] end=
 is updated to d8
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: disabling bridge window =
[mem 0x00000000-0x000fffff] to [bus 8a] (unused)
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge window [mem 0x001=
00000-0x000fffff 64bit pref] to [bus 8b-b1] add_size 200000 add_align 100000
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge window [mem 0x001=
00000-0x000fffff] to [bus 8b-b1] add_size 200000 add_align 100000
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: disabling bridge window =
[mem 0x00000000-0x000fffff 64bit pref] to [bus b2] (unused)
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge window [mem 0x001=
00000-0x000fffff 64bit pref] to [bus b3-d8] add_size 200000 add_align 100000
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge window [mem 0x001=
00000-0x000fffff] to [bus b3-d8] add_size 200000 add_align 100000
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge window [mem 0x001=
00000-0x003fffff 64bit pref] to [bus 89-d8] add_size 400000 add_align 100000
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge window [mem 0x001=
00000-0x003fffff] to [bus 89-d8] add_size 400000 add_align 100000
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4: bridge window [io  =
size 0x4000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4: bridge window [io  =
size 0x4000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4: bridge window [io  =
size 0x4000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4: bridge window [io  =
size 0x4000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge window [mem 0xb00=
00000-0xb7ffffff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge window [mem 0x400=
0000000-0x4fffffffff 64bit pref]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge window [io  size =
0x4000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge window [io  size =
0x4000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge window [io  size =
0x4000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge window [io  size =
0x4000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: bridge window [mem 0x400=
0000000-0x40000fffff 64bit pref]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge window [mem 0xb00=
00000-0xb3efffff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge window [mem 0x400=
0100000-0x47ffffffff 64bit pref]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: bridge window [mem 0xb3f=
00000-0xb3ffffff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge window [mem 0xb40=
00000-0xb7efffff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge window [mem 0x480=
0000000-0x4fffefffff 64bit pref]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge window [io  size =
0x1000]: can't assign; no space
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge window [io  size =
0x1000]: failed to assign
> Mar 26 08:44:31 fedora kernel: pci 0000:8a:00.0: BAR 0 [mem 0x4000000000-=
0x400003ffff 64bit pref]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:8a:00.0: BAR 2 [mem 0x4000040000-=
0x4000040fff 64bit pref]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: PCI bridge to [bus 8a]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0:   bridge window [mem 0x4=
000000000-0x40000fffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: PCI bridge to [bus 8b-b1]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0xb=
0000000-0xb3efffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0x4=
000100000-0x47ffffffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:b2:00.0: BAR 0 [mem 0xb3f00000-0x=
b3f0ffff 64bit]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: PCI bridge to [bus b2]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0:   bridge window [mem 0xb=
3f00000-0xb3ffffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: PCI bridge to [bus b3-d8]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0xb=
4000000-0xb7efffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0x4=
800000000-0x4fffefffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: PCI bridge to [bus 89-d8]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0xb=
0000000-0xb7ffffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0x4=
000000000-0x4fffffffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4: PCI bridge to [bus =
88-d8]
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4:   bridge window [me=
m 0xb0000000-0xb7ffffff]
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4:   bridge window [me=
m 0x4000000000-0x4fffffffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: PCI: No. 2 try to assign unassigned res
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.0: bridge window [io  =
0x5000-0x5fff]: releasing
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1c.0: bridge window [io  =
0x4000-0x4fff]: releasing
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1d.0: bridge window [io  =
0x3000-0x3fff]: releasing
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1d.4: bridge window [io  =
0x2000-0x2fff]: releasing
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: disabling bridge window =
[mem 0x00000000-0x000fffff disabled] to [bus 8a] (unused)
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: disabling bridge window =
[mem 0x00000000-0x000fffff 64bit pref disabled] to [bus b2] (unused)
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4: bridge window [io  =
0x2000-0x5fff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: bridge window [io  0x200=
0-0x5fff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: bridge window [io  0x200=
0-0x2fff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: bridge window [io  0x300=
0-0x3fff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: bridge window [io  0x400=
0-0x4fff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: bridge window [io  0x500=
0-0x5fff]: assigned
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0: PCI bridge to [bus 8a]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0:   bridge window [io  0x2=
000-0x2fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:00.0:   bridge window [mem 0x4=
000000000-0x40000fffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0: PCI bridge to [bus 8b-b1]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0:   bridge window [io  0x3=
000-0x3fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0xb=
0000000-0xb3efffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:01.0:   bridge window [mem 0x4=
000100000-0x47ffffffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0: PCI bridge to [bus b2]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0:   bridge window [io  0x4=
000-0x4fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:02.0:   bridge window [mem 0xb=
3f00000-0xb3ffffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0: PCI bridge to [bus b3-d8]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0:   bridge window [io  0x5=
000-0x5fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0xb=
4000000-0xb7efffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:89:03.0:   bridge window [mem 0x4=
800000000-0x4fffefffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0: PCI bridge to [bus 89-d8]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0:   bridge window [io  0x2=
000-0x5fff]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0xb=
0000000-0xb7ffffff]
> Mar 26 08:44:31 fedora kernel: pci 0000:88:00.0:   bridge window [mem 0x4=
000000000-0x4fffffffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4: PCI bridge to [bus =
88-d8]
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4:   bridge window [io=
  0x2000-0x5fff]
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4:   bridge window [me=
m 0xb0000000-0xb7ffffff]
> Mar 26 08:44:31 fedora kernel: pcieport 0000:80:1b.4:   bridge window [me=
m 0x4000000000-0x4fffffffff 64bit pref]
> Mar 26 08:44:31 fedora kernel: pcieport 0000:88:00.0: enabling device (00=
00 -> 0003)
> Mar 26 08:44:31 fedora kernel: pcieport 0000:89:00.0: enabling device (00=
00 -> 0003)
> Mar 26 08:44:31 fedora kernel: pcieport 0000:89:01.0: enabling device (00=
00 -> 0003)
> Mar 26 08:44:31 fedora kernel: pcieport 0000:89:01.0: pciehp: Slot #1 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+=
 IbPresDis- LLActRep+
> Mar 26 08:44:31 fedora kernel: pcieport 0000:89:02.0: enabling device (00=
00 -> 0003)
> Mar 26 08:44:31 fedora kernel: pcieport 0000:89:03.0: enabling device (00=
00 -> 0003)
> Mar 26 08:44:31 fedora kernel: pcieport 0000:89:03.0: pciehp: Slot #3 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+=
 IbPresDis- LLActRep+
> Mar 26 08:44:31 fedora kernel: thunderbolt 0000:8a:00.0: enabling device =
(0000 -> 0002)
> Mar 26 08:44:31 fedora kernel: thunderbolt 0000:8a:00.0: host router rese=
t successful
> Mar 26 08:44:31 fedora kernel: pci 0000:b2:00.0: enabling device (0000 ->=
 0002)
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b2:00.0: xHCI Host Controller
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b2:00.0: new USB bus registe=
red, assigned bus number 5
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b2:00.0: hcc params 0x20007f=
c1 hci version 0x120 quirks 0x0000000200009810
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b2:00.0: xHCI Host Controller
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b2:00.0: new USB bus registe=
red, assigned bus number 6
> Mar 26 08:44:31 fedora kernel: xhci_hcd 0000:b2:00.0: Host supports USB 3=
=2E2 Enhanced SuperSpeed
> Mar 26 08:44:31 fedora kernel: usb usb5: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.19
> Mar 26 08:44:31 fedora kernel: usb usb5: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
> Mar 26 08:44:31 fedora kernel: usb usb5: Product: xHCI Host Controller
> Mar 26 08:44:31 fedora kernel: usb usb5: Manufacturer: Linux 6.19.10-200.=
fc43.x86_64 xhci-hcd
> Mar 26 08:44:31 fedora kernel: usb usb5: SerialNumber: 0000:b2:00.0
> Mar 26 08:44:31 fedora kernel: hub 5-0:1.0: USB hub found
> Mar 26 08:44:31 fedora kernel: hub 5-0:1.0: 2 ports detected
> Mar 26 08:44:31 fedora kernel: usb usb6: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.19
> Mar 26 08:44:31 fedora kernel: usb usb6: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
> Mar 26 08:44:31 fedora kernel: usb usb6: Product: xHCI Host Controller
> Mar 26 08:44:31 fedora kernel: usb usb6: Manufacturer: Linux 6.19.10-200.=
fc43.x86_64 xhci-hcd
> Mar 26 08:44:31 fedora kernel: usb usb6: SerialNumber: 0000:b2:00.0
> Mar 26 08:44:31 fedora kernel: hub 6-0:1.0: USB hub found
> Mar 26 08:44:31 fedora kernel: hub 6-0:1.0: 2 ports detected
> Mar 26 08:44:31 fedora kernel: typec port1: bound usb3-port6 (ops connect=
or_ops)
> Mar 26 08:44:31 fedora kernel: typec port1: bound usb6-port1 (ops connect=
or_ops)
> Mar 26 08:44:31 fedora kernel: typec port1: bound usb4_port1 (ops connect=
or_ops [thunderbolt])
> Mar 26 08:44:31 fedora kernel: typec port2: bound usb3-port5 (ops connect=
or_ops)
> Mar 26 08:44:31 fedora kernel: typec port2: bound usb6-port2 (ops connect=
or_ops)
> Mar 26 08:44:31 fedora kernel: typec port2: bound usb4_port3 (ops connect=
or_ops [thunderbolt])
> Mar 26 08:44:32 fedora kernel: rfkill: input handler enabled
> Mar 26 08:45:23 fedora kernel: nvidia 0000:01:00.0: Enabling HDA controll=
er
> Mar 26 08:45:26 fedora kernel: kauditd_printk_skb: 31 callbacks suppressed
> Mar 26 08:45:26 fedora kernel: audit: type=3D1305 audit(1774511126.610:27=
7): op=3Dset audit_pid=3D0 old=3D1414 auid=3D4294967295 ses=3D4294967295 su=
bj=3Dsystem_u:system_r:auditd_t:s0 res=3D1
> Mar 26 08:45:26 fedora kernel: audit: type=3D1131 audit(1774511126.611:27=
8): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:init_t:s0 msg=3D'unit=3Dauditd comm=3D"systemd" exe=3D"/usr/lib/system=
d/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:45:26 fedora kernel: audit: type=3D1131 audit(1774511126.611:27=
9): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:init_t:s0 msg=3D'unit=3Dsystemd-tmpfiles-setup comm=3D"systemd" exe=3D=
"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:45:26 fedora kernel: audit: type=3D1131 audit(1774511126.640:28=
0): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:init_t:s0 msg=3D'unit=3Dsystemd-fsck@dev-disk-by\x2duuid-F9A2\x2dDA2A =
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? ter=
minal=3D? res=3Dsuccess'
> Mar 26 08:45:26 fedora kernel: EXT4-fs (nvme0n1p2): unmounting filesystem=
 d5bf4d09-7f11-4acd-a48c-445c5ec7a7d6.
> Mar 26 08:45:26 fedora kernel: audit: type=3D1131 audit(1774511126.648:28=
1): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:init_t:s0 msg=3D'unit=3Dsystemd-cryptsetup@luks\x2d73987f2e\x2d002a\x2=
d40e7\x2dadd4\x2d6bfcdf615f80 comm=3D"systemd" exe=3D"/usr/lib/systemd/syst=
emd" hostname=3D? addr=3D? terminal=3D? res=3Dfailed'
> Mar 26 08:45:26 fedora kernel: audit: type=3D1131 audit(1774511126.650:28=
2): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:init_t:s0 msg=3D'unit=3Dsystemd-fsck@dev-disk-by\x2duuid-d5bf4d09\x2d7=
f11\x2d4acd\x2da48c\x2d445c5ec7a7d6 comm=3D"systemd" exe=3D"/usr/lib/system=
d/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:45:26 fedora kernel: audit: type=3D1131 audit(1774511126.651:28=
3): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:init_t:s0 msg=3D'unit=3Dsystemd-remount-fs comm=3D"systemd" exe=3D"/us=
r/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:45:26 fedora kernel: audit: type=3D1131 audit(1774511126.651:28=
4): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:init_t:s0 msg=3D'unit=3Dsystemd-tmpfiles-setup-dev comm=3D"systemd" ex=
e=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuc=
cess'
> Mar 26 08:45:26 fedora kernel: audit: type=3D1131 audit(1774511126.651:28=
5): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:init_t:s0 msg=3D'unit=3Dsystemd-tmpfiles-setup-dev-early comm=3D"syste=
md" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> Mar 26 08:45:26 fedora kernel: zram0: detected capacity change from 16777=
216 to 0
> Mar 26 08:45:26 fedora kernel: audit: type=3D1131 audit(1774511126.677:28=
6): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst=
em_r:init_t:s0 msg=3D'unit=3Dlvm2-monitor comm=3D"systemd" exe=3D"/usr/lib/=
systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Mar 26 08:45:26 fedora systemd-shutdown[1]: Syncing filesystems and block=
 devices.
> Mar 26 08:45:26 fedora systemd-shutdown[1]: Sending SIGTERM to remaining =
processes...

