Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B523909F
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787362597; cv=none; b=OYF9erduu2fhypJ129Nq0XNb1rjkv5Z83fIDNIPAA4nPHSJeg8wbR/N9pMsjEBs8S9n+NReUSFmpB5dPV7lorWPdMDOqm/8qvH5cE8eAzQRGKjpcYmq1lwEe+ODFpxQ1Tw+i2j87mc28EowX6z19HC5W1T+8jvwKySlgaNLLK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787362597; c=relaxed/simple;
	bh=5OYkoIvF657FAo9dJJg5YswKRr3L2L2Kdbmx5/PONcc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=YsNzLqi87eeN3WbnjdpYJY+KXNLGMIIxWdfsN4Yu2cbNzq4OjdnRIuaQUFKvwsx09jEG8z+oLJvbbsO3Zo1kITlBt8F69BZIS0EkPSl8zywotKee5c/uMopPTcY2phGTmdWTDeS7JLYBUJXBjWkSnlJ11TcOgqOJCoSuGrSXS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=MFrRqC4g; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="MFrRqC4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1787362585; x=1787621785;
	bh=5OYkoIvF657FAo9dJJg5YswKRr3L2L2Kdbmx5/PONcc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MFrRqC4gFKmyZWk0CGVOAe21xP4w2vnIizAljT1IP4Q3QcqH7Nzlr2+eCZsuhZ3nf
	 fqEoTC51X2VDj5e8aMRWd2aV6bTeJkKzPRx2g8E0WzZNHz7rOUE9wK/eOUOrzWVOIJ
	 4SDyfyuc8mWKCSlCiydKmaiYhNY5xESXSPH036VJ6AkSfmwxV972VTcATq7CfM6KhZ
	 0dnnPeup90SFpBVWPWTfRMl4jMNP+ziF8UQSkIqibvEoxo3sidiZiP3MTxFpqpsXlT
	 MlWHEBO+pfDZzDuqUrBzdwB578NHE5KGMHnVWimxU12I6CaYJSX4ijsF3WDZdE28jx
	 CDBxDRRPtVOig==
Date: Sat, 22 Aug 2026 01:36:21 +0000
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Rifraf <rifraf@pm.me>
Subject: linux-acpi@vger.kernel.org rafael@kernel.org bhelgaas@google.com mario.limonciello@amd.com benh@debian.org linux-pm@vger.kernel.org alison@she-devel.com b@bfa.lk
Message-ID: <8olbLgvDZvoYQa-7CIz4bp6BvuO9DbIzT4Wqoljx1hB6Vd7XaDw-GREier_L02Bq1ivjWfCjy9VlsGHZJesTnB8a3Gq7e7ETUwDpcv8BHbA=@pm.me>
Feedback-ID: 14722562:user:proton
X-Pm-Message-ID: 00f95d5dbca08b54f5c71fa1598f5f128bf6fef9
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Apologies for the duplicate email. I realized after I sent the original mes=
sage that my composer wasn't set correctly, so the message wasn't plain tex=
t and was likely encrypted.=20


Hi,
After any s2idle (S0i3) suspend/resume cycle on this machine, the entire
ASMedia ASM4242 PCIe switch subtree is gone from the bus and does not come
back. All USB-C / USB4 ports are dead until a full reboot. remove + rescan,
link retrain, and a secondary bus reset all fail to recover it.

The kernel-visible symptom is

=C2=A0 Unable to change power state from D3cold to D0, device inaccessible
but the evidence below argues that is a consequence, not the cause: by the
time the kernel looks, the switch is already electrically absent, and the
root port reports its slot as empty.

This is not an isolated machine, and it is probably not an ASUS defect.
Debian bug #1102175 (bug title is "Repeated lockups in AMDGPU DRM driver";
the relevant material is Ben Hutchings' consolidated post of 2025-07-10,
subject "Failure to resume ASMedia ASM4242 on AMD systems") records the sam=
e
ASM4242 switch, same PCI ID 1b21:2421, and the same "Unable to change power
state from D3cold to D0, device inaccessible" on two further systems, both
on 6.12.21:

=C2=A0 - System76 Thelio Mira =C2=A0 =C2=A0 =C2=A0 =C2=A0(Debian 6.12.21-am=
d64)
=C2=A0 - ASRock X870E Taichi Lite =C2=A0 =C2=A0(Gentoo 6.12.21-gentoo-dist)

Those are desktop boards from two other vendors, and there the trigger is
runtime suspend with a ~22 s watchdog soft lockup stuck in pci_mmcfg_read()=
,
rather than s2idle. So the symptom presentation differs, but the failing
part, the PCI ID and the power-state error are identical. Three independent
vendors' boards failing the same way makes a board-specific ASUS BIOS defec=
t
the less likely explanation and points at the ASMedia part itself or the
generic AMD PCIe/ACPI power-resource path.

That Debian bug was forwarded to this list on 2025-07-10:

=C2=A0 https://lore.kernel.org/linux-pci/00571ac825960730bbc1c2fe28d6d2dca2=
51d322.camel@debian.org/T/

That thread received no replies. I do not raise that as a complaint - it wa=
s
a report without a reproducer, on hardware few people have. What I am addin=
g
is the reproducer: a machine that fails 100% of the time, a scripted harnes=
s,
and the experiments below. I am happy to move this into that thread as a
follow-up instead if that is preferred.

One difference worth noting, since it may explain why this went unnoticed.
On those two systems the CPU spins in pci_mmcfg_read() reached from
pci_restore_ltr_state() <- pci_restore_state() <- pci_pm_runtime_resume() -
the runtime-PM path walking extended capabilities on a device that is alrea=
dy
inaccessible - and the visible symptom is a watchdog soft lockup. This
machine never soft-locks: the equivalent config reads return ffffffff
promptly and the failure is silent, so the only symptom a user sees is that
USB-C stopped working. Same part stuck in D3cold, different containing path=
 -
s2idle here, runtime PM there.

Hutchings' conclusion there is worth repeating, because it describes this
machine exactly: "On both systems the device stuck in D3cold is the upstrea=
m
port of an ASMedia ASM4242 (PCI ID 1b21:2421) and the root complex is an AM=
D
Raphael/Granite Ridge." Root port 00:02.1 here is an AMD Raphael/Granite
Ridge GPP Bridge [1022:14db], so this is a third system matching both halve=
s
of that pairing.

This report adds five controlled experiments, all negative, which between
them eliminate the kernel-side explanations - and one positive finding from
reading the shipped AML: the ACPI power resources this subtree advertises
via _PR0/_PR3 contain no hardware access at all. _STA returns a software
flag, and _ON/_OFF only flip that flag and call debug-print helpers. That
explains why every OS-side lever failed, and it rules out the "kernel forgo=
t
to re-run _ON" theory as a fix path. Details and the AML are below.

One further data point, detailed under "Disclosed limitations" below: this
machine normally boots with pcie_aspm=3Doff (an unrelated May-2026
workaround). Removing it as a control did not produce a different resume
result - it produced no resume at all: the first s2idle attempt hard-hung
the kernel at suspend entry, SysRq dead, hard power-off required.

I first described that control as "ASPM off vs ASPM on". That description
was wrong, and I am correcting it here rather than leaving it to be found i=
n
review. pcie_aspm=3Doff does not clear ASPM. The parameter is handled by th=
e
__setup handler pcie_aspm_disable() in drivers/pci/pcie/aspm.c, which for
"off" sets aspm_policy =3D POLICY_DEFAULT, aspm_disabled =3D true and
aspm_support_enabled =3D false; the last of those makes the kernel decline =
the
PCIe _OSC handshake altogether. The design intent is stated in the comment =
on
the neighbouring pcie_no_aspm(): disabling ASPM "is intended to prevent the
kernel from modifying existing hardware state, not to clear existing state"=
.
ASPM L1 was therefore active on the ASM4242 chain in both arms of that
control; what differed was PCIe capability ownership - firmware-owned with
the parameter, OS-owned without it. The corrected axis, and what it does an=
d
does not license me to claim, is in limitation 1.


HARDWARE / SOFTWARE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=C2=A0 System =C2=A0 =C2=A0 =C2=A0 =C2=A0ASUSTeK ROG Strix G16 G614FR_G614F=
R =C2=A0(board G614FR)
=C2=A0 BIOS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0G614FR.316, release date 2026=
-05-14 =C2=A0 (latest available)
=C2=A0 CPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD Ryzen 9 9955HX3D 16-Core
=C2=A0 Sleep =C2=A0 =C2=A0 =C2=A0 =C2=A0 /sys/power/mem_sleep =3D [s2idle] =
=C2=A0(no S3/deep on this platform)
=C2=A0 Kernels =C2=A0 =C2=A0 =C2=A0 7.2.0-1-mainline (vanilla, built from t=
he v7.2 tag),
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7.2.0-1-cachyos,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.18.42-1-cachyos-l=
ts =C2=A0 =C2=A0 =C2=A0 =C2=A0(all three fail identically)

The affected subtree:

=C2=A0 00:02.1 =C2=A0AMD Raphael/Granite Ridge GPP Bridge =C2=A0[1022:14db]=
 =C2=A0(a)
=C2=A0 =C2=A005:00.0 ASM4242 PCIe Switch Upstream Port =C2=A0 =C2=A0 [1b21:=
2421]
=C2=A0 =C2=A0 06:00.0 ASM4242 PCIe Switch Downstream Port =C2=A0[1b21:2423]
=C2=A0 =C2=A0 06:01.0 ASM4242 PCIe Switch Downstream Port =C2=A0[1b21:2423]
=C2=A0 =C2=A0 06:02.0 ASM4242 PCIe Switch Downstream Port =C2=A0[1b21:2423]
=C2=A0 =C2=A0 06:03.0 ASM4242 PCIe Switch Downstream Port =C2=A0[1b21:2423]
=C2=A0 =C2=A0 =C2=A067:00.0 ASM4242 USB 3.2 xHCI Controller =C2=A0 =C2=
=A0 [1b21:2426] =C2=A0(b)
=C2=A0 =C2=A0 =C2=A068:00.0 ASM4242 USB4 / TB3 Host Router =C2=A0 =C2=A0 =
=C2=A0[1b21:2425] =C2=A0(c)

=C2=A0 (a) root port; this is the one device that SURVIVES, staying in D0
=C2=A0 (b) owns usb1 + usb2, i.e. the physical USB-C ports
=C2=A0 (c) owns thunderbolt domain0

Every other USB controller on the machine (6a:00.3, 6a:00.4, 6b:00.0 -
keyboard, Bluetooth, webcam, USB-A storage) resumes normally; usb1/usb2
belong to the ASM4242's 67:00.0, while usb3-usb7 belong to those AMD
controllers.

Two storage controls that tighten the scope:

=C2=A0 - the root NVMe is on root port 00:01.2 (a different GPP bridge enti=
rely)
=C2=A0 =C2=A0 - unaffected;
=C2=A0 - a second NVMe carrying /home sits on 00:02.2 - the adjacent siblin=
g root
=C2=A0 =C2=A0 port of the failing 00:02.1, in the same GPP complex - and it=
 is also
=C2=A0 =C2=A0 unaffected.

That second one matters: the failure is not "AMD GPP root ports break acros=
s
s2idle", and it is not the root-port driver. It is specific to the 00:02.1
-> ASM4242 branch.

Ten ACPI device objects in this subtree carry both _PR0 and _PR3; eight of
them correspond to enumerated PCI functions. Read that as a declaration, no=
t
a capability: as shown in the ACPI section below, these power resources are
inert - their _ON/_OFF/_STA only maintain a software flag and emit debug
prints, so nothing here can cut or restore a rail. The map is still worth
stating because it is what the kernel's PM core sees and acts on:

=C2=A0 ACPI object =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0LNXPOWER =C2=A0PCI function
=C2=A0 \_SB_.PCI0.GPP7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0:06 =C2=A0 =C2=A0 =C2=A0 0000:00:02.1 =C2=A0root port
=C2=A0 \_SB_.PCI0.GPP7.U4UP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :07 =
=C2=A0 =C2=A0 =C2=A0 0000:05:00.0 =C2=A0switch upstream
=C2=A0 \_SB_.PCI0.GPP7.U4UP.U4P0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:08 =C2=A0 =
=C2=A0 =C2=A0 0000:06:00.0 =C2=A0switch downstream
=C2=A0 \_SB_.PCI0.GPP7.U4UP.U4P0.UP0D =C2=A0 :09 =C2=A0 =C2=A0 =C2=A0 (none=
 enumerated)
=C2=A0 \_SB_.PCI0.GPP7.U4UP.U4P1 =C2=A0 =C2=A0 =C2=A0 =C2=A0:0a =C2=A0 =
=C2=A0 =C2=A0 0000:06:01.0 =C2=A0switch downstream
=C2=A0 \_SB_.PCI0.GPP7.U4UP.U4P1.UP1D =C2=A0 :0b =C2=A0 =C2=A0 =C2=A0 (none=
 enumerated)
=C2=A0 \_SB_.PCI0.GPP7.U4UP.U4P2 =C2=A0 =C2=A0 =C2=A0 =C2=A0:0c =C2=A0 =
=C2=A0 =C2=A0 0000:06:02.0 =C2=A0switch downstream
=C2=A0 \_SB_.PCI0.GPP7.U4UP.U4P2.UXHC =C2=A0 :0d =C2=A0 =C2=A0 =C2=A0 0000:=
67:00.0 =C2=A0xHCI
=C2=A0 \_SB_.PCI0.GPP7.U4UP.U4P3 =C2=A0 =C2=A0 =C2=A0 =C2=A0:0e =C2=A0 =
=C2=A0 =C2=A0 0000:06:03.0 =C2=A0switch downstream
=C2=A0 \_SB_.PCI0.GPP7.U4UP.U4P3.UHI0 =C2=A0 :0f =C2=A0 =C2=A0 =C2=A0 0000:=
68:00.0 =C2=A0USB4 router

UP0D and UP1D sit under downstream ports 0 and 1, which have nothing
attached, so neither has a PCI function of its own. Read from
/sys/bus/acpi/devices/LNXPOWER:*/path on the running system.


SYMPTOM / EVIDENCE SIGNATURE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Post-resume, config space for the whole subtree reads ffffffff:

=C2=A0 0000:00:02.1 state=3DD0 =C2=A0 =C2=A0 =C2=A0cfg=3D14db1022 =C2=A0 <-=
 root port fine
=C2=A0 0000:05:00.0 state=3DD3cold =C2=A0cfg=3Dffffffff
=C2=A0 0000:67:00.0 state=3DD3cold =C2=A0cfg=3Dffffffff
=C2=A0 0000:68:00.0 state=3DD3cold =C2=A0cfg=3Dffffffff

dmesg, quoted verbatim from the 6.18.42-LTS run (experiment 1), in the orde=
r
printed:

=C2=A0 thunderbolt 0000:68:00.0: Unable to change power state from D3hot to=
 D0, device inaccessible
=C2=A0 pcieport =C2=A0 =C2=A00000:06:02.0: Unable to change power state fro=
m D3cold to D0, device inaccessible
=C2=A0 xhci_hcd =C2=A0 =C2=A00000:67:00.0: Unable to change power state fro=
m D3cold to D0, device inaccessible
=C2=A0 pcieport =C2=A0 =C2=A00000:05:00.0: Unable to change power state fro=
m D3cold to D0, device inaccessible
=C2=A0 pcieport =C2=A0 =C2=A00000:06:03.0: Unable to change power state fro=
m D3cold to D0, device inaccessible
=C2=A0 xhci_hcd =C2=A0 =C2=A00000:67:00.0: Unable to change power state fro=
m D3cold to D0, device inaccessible
=C2=A0 xhci_hcd =C2=A0 =C2=A00000:67:00.0: Controller not ready at resume -=
19
=C2=A0 xhci_hcd =C2=A0 =C2=A00000:67:00.0: PCI post-resume error -19!
=C2=A0 xhci_hcd =C2=A0 =C2=A00000:67:00.0: HC died; cleaning up
=C2=A0 xhci_hcd =C2=A0 =C2=A00000:67:00.0: PM: dpm_run_callback(): pci_pm_r=
esume returns -19
=C2=A0 xhci_hcd =C2=A0 =C2=A00000:67:00.0: PM: failed to resume async: erro=
r -19
=C2=A0 pcieport =C2=A0 =C2=A00000:06:00.0: Unable to change power state fro=
m D3cold to D0, device inaccessible
=C2=A0 pcieport =C2=A0 =C2=A00000:06:01.0: Unable to change power state fro=
m D3cold to D0, device inaccessible

Two details so you are not misled by them:

=C2=A0 - 68:00.0 says D3hot, not D3cold, in every run where the thunderbolt=
 driver
=C2=A0 =C2=A0 is loaded - that device natively has d3cold_allowed=3D0, so t=
he kernel never
=C2=A0 =C2=A0 records D3cold for it. With the driver unloaded (experiment 5=
) the same
=C2=A0 =C2=A0 line becomes "pci 0000:68:00.0: Unable to change power state =
from unknown
=C2=A0 =C2=A0 to D0".

=C2=A0 - On the 7.2.0 kernel the last-but-two line reads
=C2=A0 =C2=A0 "pci_pm_resume.llvm.17501866033367866400 returns -19". That s=
uffix is an
=C2=A0 =C2=A0 artifact of CachyOS building with clang/LTO, not a different =
code path;
=C2=A0 =C2=A0 the LTS build is GCC and prints the clean symbol shown above.

Plus, when the thunderbolt driver is loaded, 9 WARNs reached via
tb_resume_noirq, from drivers/thunderbolt/ctl.c - the one I captured verbat=
im
is at ctl.c:1131 in tb_cfg_read() on 6.18.42, and line numbers there vary b=
y
version - setting taint bit 9 (W), i.e. tainted goes 12288 -> 12800. See
experiment 5: with the driver unloaded the count is 0 and taint stays 12288=
,
so these are symptom only.

suspend_stats: success:1 fail:0, last_failed_dev:0000:67:00.0,
last_failed_step:resume - identical in all four completed runs. The suspend
itself is genuine: last_hw_sleep read 11495788 / 19500641 / 12466797 /
21666626 us across experiments 1/2/3/5 (11.50 / 19.50 / 12.47 / 21.67 s), s=
o
the SoC really entered a hardware sleep state rather than idling in S0.


GROUND TRUTH: THE PCIe LINK IS DOWN AND THE SLOT READS EMPTY
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Read from the surviving side (root port 00:02.1, which stays in D0):

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0healthy,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0pre-suspend =C2=A0 after resume
=C2=A0 LnkSta =C2=A0(setpci -s 00:02.1 CAP_EXP+12.w) =C2=A0 0x3044 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x1101
=C2=A0 Data Link Layer Active =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 SltSta =C2=A0(CAP_EXP+1a.w), Presence Detect =C2=A0 =C2=A00x0040 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0000
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(bit 6 set)
=C2=A0 setpci -s 05:00.0 DEVICE_ID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02421 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ffff

The root port is healthy, in D0, driving its link, and sees no device
present.


WHAT WAS RULED OUT - FIVE CONTROLLED EXPERIMENTS, ALL NEGATIVE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Each was run with a verified precondition (kernel cmdline checked on
/proc/cmdline, not merely staged; fresh boot with suspend_stats at 0/0; RTC
wake alarm confirmed armed and in the future before suspending).

1. Not a kernel regression, and not a distro patch.
--------------------------------------------------

6.18.42 LTS fails identically to 7.2.0 - same ffffffff, same 9 WARNs, same
last_failed_dev - and so does vanilla v7.2 built from the mainline tag
(7.2.0-1-mainline, 2026-08-21; see limitation 2 for the log excerpt). Three
kernels, two toolchains, patched and unpatched, one signature. There is no
bisectable window, and the 6.12.21 reports in Debian #1102175 put the same
failure on the same part well over a year earlier. CachyOS, vanilla
mainline, Debian and Gentoo all reproduce it.

Not the 6.7 USB4 wakeup quirk. For the avoidance of the obvious first
question: commit 7d08f21f8c63 ("x86/PCI: Avoid PME from D3hot/D3cold for AM=
D
Rembrandt and Phoenix USB4", Linux 6.7) removes D3hot and D3cold from the
PME_Support mask of Root Ports above USB4 controllers when amd-pmc will be
involved in the suspend. It is long since present in every kernel tested
here, but it cannot apply on this platform: the fixups in
arch/x86/pci/fixup.c are declared against specific AMD Root Port device IDs=
 -
0x162e/0x162f (Rembrandt) and 0x1668/0x1669 (Phoenix) - and this machine's
root port 00:02.1 is 1022:14db, which is not among them. The CPU is Fire
Range / Zen 5 (cpu family 26). Consistent with that, 00:02.1 still
advertises:

=C2=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)

i.e. D3hot/D3cold are still in its PME_Support mask, so the quirk
demonstrably did not run. Whether extending it to this generation would
help is a question for the maintainer; I have not assumed it would, and not=
e
that experiment 3 below shows blocking the D3cold transition outright did
not save the subtree.

Related precedent in the same file: quirk_tuxeo_rp_d3 sets
PCI_DEV_FLAGS_NO_D3 on the Root Port above an AMD USB4 controller for one
DMI-matched machine, under the comment "Putting PCIe root ports on Ryzen
SoCs with USB4 controllers into D3hot may cause problems when the system
attempts wake up from s2idle. =C2=A0On the TUXEDO Sirius 16 Gen 1 with a sp=
ecific
old BIOS this manifests as a system hang." That is not the failure reported
here - the root port on this machine stays in D0 across the cycle and it is
the subtree beneath it that vanishes - but it shows the general hazard is
already recognised, and it is the closest existing shape of fix I found. I
have not tested PCI_DEV_FLAGS_NO_D3 on 00:02.1: experiment 3 blocked D3cold
only, not D3hot.

2. pcie_port_pm=3Doff - no effect.
--------------------------------

Zero change in any measured value. Consistent with the _PR3 map above: this
subtree is powered down through the ACPI power-resource path, not through
the PCIe portdrv PM service that this parameter disables.

3. d3cold_allowed=3D0 on the PARENTS (root port + switch upstream/downstrea=
m),
=C2=A0 =C2=A0not just the endpoints - no effect.
---------------------------------------------------------------------------

The knob was written and read back as 0 on all seven of 00:02.1, 05:00.0,
06:00.0, 06:01.0, 06:02.0, 06:03.0, 67:00.0. The subtree died anyway,
identically: ffffffff across the board, same last_failed_dev, same 9 WARNs.

I want to be careful about how much the resume messages support here,
because my earlier draft over-read them. The honest comparison, counted fro=
m
the journal:

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 without =C2=A0 =C2=A0with d3cold_allowed=3D0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 the knob =C2=A0 on all seven
=C2=A0 xhci_hcd 67:00.0 ... from D3cold =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01
=C2=A0 xhci_hcd 67:00.0 ... from D3hot =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01
=C2=A0 pcieport 05:00.0 / 06:00-03.0 ... D3cold =C2=A0 =C2=A0 5 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A05 =C2=A0(unchanged)
=C2=A0 thunderbolt 68:00.0 ... from D3hot =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0(unchanged,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0see above)

So one of the two xHCI messages changed; the five bridge messages did not
change at all despite the knob being confirmed set on them. I would not lea=
n
on that as proof the PM core "declined D3cold" everywhere.

The reason the strings are weak evidence cuts both ways, and is worth
stating explicitly: the D3cold reported after resume is
pci_update_current_state() reading ffffffff and inferring D3cold. It is a
symptom label, not a record of how the device got there - so neither its
presence nor its absence tells you what the kernel actually decided.

What does survive from this experiment is the part that does not depend on
message text: with D3cold administratively refused across the entire parent
chain, the subtree was still gone on resume. Whatever removes power is not
taking the kernel's D3cold decision as its input.

4. Link retrain and secondary bus reset - no effect; not runtime-recoverabl=
e.
---------------------------------------------------------------------------=
-

Run on the already-dead subtree. Retrain (LnkCtl bit 5) drove LnkSta
0x1101 -> 0x1901 with the Training bit stuck at 1 and DLActive still 0: the
root port trains forever against no partner. A secondary bus reset
(BRIDGE_CONTROL bit 6, held 100 ms, held value re-read as 0x0052 to confirm
the write landed) followed by /sys/bus/pci/rescan changed nothing. PERST#
toggling is something remove+rescan never does, so this was an independent
test, and it also failed.

5. The thunderbolt driver is not involved at all.
-------------------------------------------------

Suspended with the module not loaded (removed holders-downward:
modprobe -r ucsi_acpi, then modprobe -r typec, which cascades thunderbolt),
68:00.0 driverless, thunderbolt domain torn down. The xHCI died identically=
.
Notably the kernel taint stayed unchanged and there were zero WARNs -
confirming the 9 tb_cfg splats are the driver polling an already-dead
router, not a step in the failure. 68:00.0's error text became "Unable to
change power state from unknown to D0" (no driver, so no recorded PM state)=
.

Taken together: the failure is below the PCIe PM layer, below the port
driver, and independent of the USB4 driver. After resume the switch is not
merely in a low-power state - it is unpowered, and nothing the root port ca=
n
do brings it back. Only a full reboot (firmware POST) revives it.


THE ACPI POWER RESOURCES FOR THIS SUBTREE ARE INERT - THEY CONTAIN NO
HARDWARE ACCESS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

My earlier draft listed "the kernel never re-runs _ON on resume" as a live
candidate, and flagged the LNXPOWER:06/07/0d/0f resources reporting status=
=3D1
against a provably dead link as unexplained. I have now read the AML, and
both are resolved. The _PR0/_PR3 power resources for this subtree do not
control power.

Full extraction available (asm4242-acpi-pwrs-aml.txt); reproduce with
acpidump -b && iasl -e dsdt.dat -d ssdt6.dat.

First - the table is AMD's, not the OEM's:

=C2=A0 DefinitionBlock ("", "SSDT", 2, "AMD", =C2=A0 =C2=A0"DISCUSB4", 0x00=
000002) =C2=A0<- the
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0USB4 subtree
=C2=A0 DefinitionBlock ("", "DSDT", 2, "_ASUS_", "Notebook", 0x01072009) =
=C2=A0<-
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0everything else

All ten devices in the subtree carry both _PR0 and _PR3, and both point at
the same per-device PWRS:

=C2=A0 Name (_PR0, Package (0x01) { PWRS })
=C2=A0 Name (_PR3, Package (0x01) { PWRS })

_STA returns a software variable, not a rail:

=C2=A0 PowerResource (PWRS, 0x00, 0x0000)
=C2=A0 {
=C2=A0 =C2=A0 =C2=A0 Method (_STA, 0, Serialized)
=C2=A0 =C2=A0 =C2=A0 {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...M460 debug print...
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If (CondRefOf (PSTA)) { PSTA () }
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Return (PW3S) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// <-- Name (PW3S, Zero)
=C2=A0 =C2=A0 =C2=A0 }

=C2=A0 =C2=A0 =C2=A0 Method (_ON, 0, Serialized)
=C2=A0 =C2=A0 =C2=A0 {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If ((PW3S =3D=3D Zero)) =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// <-- edge-guarded
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PW3S =3D One
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...M460 debug print...
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If (CondRefOf (XHGP)) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If (((ESTA =
=3D=3D Zero) && (XHGP <=3D 0x03))) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Local0 =3D M4F1 (XHGP)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If (CondRefOf (P_ON)) { P_=
ON () }
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
=C2=A0 =C2=A0 =C2=A0 }

=C2=A0 =C2=A0 =C2=A0 Method (_OFF, 0, Serialized) { /* mirror image: PW3S =
=3D Zero, then P_OF () */ }
=C2=A0 }

PW3S is declared Name (PW3S, Zero) - a plain namespace integer, one per
device, ten in the table. It is not a field in any OperationRegion.

And the callees do nothing to hardware:

=C2=A0 - PSTA() - M460 debug prints only.

=C2=A0 - P_ON() / P_OF() - identical bodies apart from the debug string: ea=
ch
=C2=A0 =C2=A0 calls M644 (0xFED80200, 0x04, 0x10) and then prints. M644 is
=C2=A0 =C2=A0 CpmDumpData, a read-and-print diagnostic dumper. Both the "on=
" and the
=C2=A0 =C2=A0 "off" path issue the same call with the same arguments, so it=
 cannot be
=C2=A0 =C2=A0 asserting or de-asserting anything.

=C2=A0 - The only remaining path to real work is M4F1
=C2=A0 =C2=A0 (CpmCheckExpanderInputEvent), reachable solely under
=C2=A0 =C2=A0 ESTA =3D=3D Zero && XHGP <=3D 0x03. XHGP is declared once as
=C2=A0 =C2=A0 Name (XHGP, 0xFF) and is never assigned anywhere in the table=
 - every
=C2=A0 =C2=A0 other occurrence is a read in this guard or in a debug print.
=C2=A0 =C2=A0 0xFF <=3D 0x03 is false, so this branch is dead code.

What follows
------------

1. status=3D1 is live but vacuous. The sysfs status attribute is a fresh _S=
TA
=C2=A0 =C2=A0evaluation on every read - status_show() in drivers/acpi/devic=
e_sysfs.c
=C2=A0 =C2=A0calls acpi_evaluate_integer(handle, "_STA", ...), and the attr=
ibute only
=C2=A0 =C2=A0exists when the device has an _STA method. So this is not a st=
ale kernel
=C2=A0 =C2=A0cache. But _STA returns PW3S, so the value only reports what t=
he AML last
=C2=A0 =C2=A0wrote to its own flag. It says nothing about whether the rail =
is up, and
=C2=A0 =C2=A0it should not be read as contradicting the ffffffff config rea=
ds. I
=C2=A0 =C2=A0withdraw that part of my earlier framing.

2. "The kernel failed to re-run _ON" is dead as a fix path. Re-running _ON
=C2=A0 =C2=A0cannot restore this subtree, because _ON does not power anythi=
ng. A
=C2=A0 =C2=A0kernel-side quirk that forced _OFF then _ON across resume - wh=
ich is
=C2=A0 =C2=A0where I was heading - would flip a variable and emit two debug=
 strings.
=C2=A0 =C2=A0Worth stating plainly so nobody spends time on it.

3. It explains why every OS-side lever failed. Rounds 1-5 eliminated portdr=
v
=C2=A0 =C2=A0PM, the D3cold decision, link retrain, secondary bus reset and=
 the
=C2=A0 =C2=A0thunderbolt driver. The reason none of them mattered is that t=
here is no
=C2=A0 =C2=A0OS-reachable power control for this subtree at all. The ACPI i=
nterface
=C2=A0 =C2=A0that appears to offer one is bookkeeping.

4. The power gating happens below ACPI, and it is not restored on S0i3 exit=
.
=C2=A0 =C2=A0That points at the SoC/PMFW path rather than anything the OS d=
rives.
=C2=A0 =C2=A0Combined with the AMD-authored DISCUSB4 table and the same fai=
lure on
=C2=A0 =C2=A0System76 and ASRock boards, an ASUS-specific BIOS defect now l=
ooks
=C2=A0 =C2=A0unlikely; AMD's discrete-USB4 reference design or its platform=
 firmware
=C2=A0 =C2=A0is the better fit.

What I still cannot tell you
----------------------------

This shows what does not gate the rail. It does not show what does. I canno=
t
see the PMFW/SMU side from userspace, and I have not proven the rail is
physically down as opposed to the link being held in reset by something els=
e
- only that the switch is off the bus by three independent probes and that
no ACPI-visible mechanism can bring it back. Naming the responsible firmwar=
e
component is where I need help.

One consequence worth checking on your side: if _PR0/_PR3 are advertised bu=
t
inert, the kernel's PM core is making D3cold decisions for these devices
against power resources that cannot honour them. Whether that is merely
useless here or actively harmful - e.g. whether the kernel should decline
_PR3-based D3cold when the resources are known-inert - is a policy question
I am not equipped to answer.


DISCLOSED LIMITATIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Please weigh these - I would rather flag them than have them found later.

1. Non-default kernel cmdline. The clean-cmdline control hard-hung the
=C2=A0 =C2=A0machine - and it did not test the variable I first said it tes=
ted.
---------------------------------------------------------------------------

All experiments above carried pcie_aspm=3Doff pci=3Dnoaer iommu=3Dpt
amdgpu.dcdebugmask=3D0x10. I said I would run a clean-cmdline control. I ra=
n
it, it hung the box, and on re-examination I had mis-labelled what it
varied. Both halves are below, because the negative result is evidence and
the mislabel would otherwise mislead you.

pcie_aspm=3Doff was removed from the boot entry (pci=3Dnoaer left in place)=
 and
the machine rebooted into 7.2.0-1-cachyos. Link state, read from the
hardware registers rather than inferred from the cmdline:

=C2=A0 00:02.1 =C2=A0LnkCtl: ASPM L1 Enabled =C2=A0 =C2=A0 <- root port
=C2=A0 05:00.0 =C2=A0LnkCtl: ASPM L1 Enabled =C2=A0 =C2=A0 <- switch upstre=
am
=C2=A0 06:02.0 =C2=A0LnkCtl: ASPM L1 Enabled =C2=A0 =C2=A0 <- switch downst=
ream
=C2=A0 67:00.0 =C2=A0LnkCtl: ASPM L1 Enabled =C2=A0 =C2=A0 <- ASM4242 xHCI
=C2=A0 00:01.1 =C2=A0LnkCtl: ASPM Disabled =C2=A0 =C2=A0 =C2=A0 <- dGPU roo=
t port

67:00.0 config space read 24261b21 (healthy), nothing was plugged into
either USB-C port.

I originally read that as "removing the parameter re-enabled L1 on the
ASM4242 chain and nothing else". It did not - L1 was already enabled there.
Re-measured on 7.2.0-1-mainline with pcie_aspm=3Doff on the cmdline, same
BIOS, same board:

=C2=A0 00:02.1 =C2=A0LnkCtl: ASPM L1 Enabled =C2=A0 =C2=A0 <- identical, pa=
rameter present
=C2=A0 00:02.2 =C2=A0LnkCtl: ASPM L1 Enabled
=C2=A0 00:01.1 =C2=A0LnkCtl: ASPM Disabled

and a write of "performance" to /sys/module/pcie_aspm/parameters/policy
returns -EPERM ("can't disable ASPM; OS doesn't have ASPM control"), which
is the documented behaviour: pcie_aspm=3Doff sets aspm_support_enabled =3D
false, so the kernel never requests PCIe control. The _OSC lines differ
exactly as that predicts, and are byte-identical between the CachyOS and
vanilla-mainline boots:

=C2=A0 with pcie_aspm=3Doff:
=C2=A0 =C2=A0 acpi PNP0A08:00: _OSC: not requesting OS control;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0OS requires [ExtendedConfig ASPM ClockPM MSI]

=C2=A0 without it:
=C2=A0 =C2=A0 acpi PNP0A08:00: _OSC: OS now controls
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0[PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]

So the variable that control changed was not ASPM link state. It was who
owns PCIe capability control - firmware, or the OS.

The first s2idle attempt killed the machine outright. Not a failed resume -
a hard hang at suspend entry, with no resume at all:

=C2=A0 - Last journal line:
=C2=A0 =C2=A0 systemd-sleep[10774]: Performing sleep operation 'suspend'...
=C2=A0 - "PM: suspend entry (s2idle)" never printed. In the four preceding =
boots
=C2=A0 =C2=A0 on this same kernel that line is flushed within 0.1 ms of the
=C2=A0 =C2=A0 systemd-sleep line, 4/4.
=C2=A0 - Display dark (PowerDevil DPMS, fired pre-sleep), keyboard backligh=
t
=C2=A0 =C2=A0 still lit - the EC was never told to power down.
=C2=A0 - SysRq was dead (REISUB did nothing), i.e. the kernel itself was go=
ne,
=C2=A0 =C2=A0 not just the GPU.
=C2=A0 - Recovery required a hard power-off.

So the clean-cmdline control cannot be performed on this machine: with ASPM
enabled, there is no resume to inspect, because the system does not survive
the suspend. I cannot report a 67:00.0 post-resume config value for the
ASPM-enabled case, and I do not expect ever to be able to.

What this does tell you, stated on the corrected axis:

=C2=A0 PCIe capability control: firmware (pcie_aspm=3Doff)
=C2=A0 =C2=A0 ASPM L1 on 00:02.1 -> 67:00.0: =C2=A0enabled
=C2=A0 =C2=A0 s2idle outcome: system resumes; ASM4242 subtree returns unpow=
ered,
=C2=A0 =C2=A0 ffffffff, reboot-only recovery (all experiments above).

=C2=A0 PCIe capability control: OS (_OSC granted, stock cmdline)
=C2=A0 =C2=A0 ASPM L1 on 00:02.1 -> 67:00.0: =C2=A0enabled
=C2=A0 =C2=A0 s2idle outcome: system hard-hangs at suspend entry; no resume=
, no oops,
=C2=A0 =C2=A0 hard power-off required.

Both arms ran with L1 active on that chain, so this pair does not bracket
ASPM. What it shows is that handing PCIe capability control to the OS on
this board turns a broken resume into a fatal suspend. I am not claiming "n=
o
configuration of this link is survivable" - I claimed that in an earlier
draft and it was not supported. The L1-genuinely-off case is untested; see
below.

Two disclosures about that run, since they limit what I can claim:

=C2=A0 - pci=3Dnoaer was still set, so the AER service driver was disabled =
and no
=C2=A0 =C2=A0 ACSViol output could be produced. I therefore cannot confirm =
the hang
=C2=A0 =C2=A0 was the same AER cascade documented below, only that it is co=
nsistent
=C2=A0 =C2=A0 with it. A silent dmesg here is not evidence of absence - the=
 probe was
=C2=A0 =C2=A0 muted.

=C2=A0 - ramoops was configured (max_reason=3D4) but captured nothing, as e=
xpected:
=C2=A0 =C2=A0 a hard hang raises no oops or panic, and the required hard po=
wer-off
=C2=A0 =C2=A0 does not preserve DRAM. There is no post-mortem dump to attac=
h.

For context on why pcie_aspm=3Doff is on this machine at all: it was added =
in
May 2026 (BIOS v314, kernel 7.0.6-1) to stop a PCIe AER cascade that caused
full system lockups. That cascade did name this root port and both ASM4242
endpoints - but it also named a second, unrelated root port and the devices
behind it, and I would rather quote it in full than crop it to the part tha=
t
suits my argument:

=C2=A0 pcieport 0000:00:01.1: AER: Uncorrectable (Non-Fatal): ACSViol (Firs=
t)
=C2=A0 nvidia =C2=A0 0000:01:00.0: AER: can't recover (no error_detected ca=
llback)
=C2=A0 snd_hda_intel 0000:01:00.1: AER: can't recover
=C2=A0 pcieport 0000:00:02.1: AER: Uncorrectable (Non-Fatal): ACSViol (Firs=
t)
=C2=A0 xhci_hcd 0000:67:00.0: AER: can't recover
=C2=A0 thunderbolt 0000:68:00.0: AER: can't recover

So the AER problem was not confined to the 00:02.1 -> ASM4242 branch; it hi=
t
00:01.1, the dGPU root port, as well. I therefore cannot claim the AER
cascade and this resume failure are two symptoms of one marginal link. What
the 2026-08-20 hang does support is the weaker statement that early Fire
Range AGESA has marginal PCIe behaviour on more than one root port, and tha=
t
pcie_aspm=3Doff is load-bearing here rather than a stale workaround.

One hypothesis I previously reported as retired is not. I wrote that this
hang ruled out the alternative that pcie_aspm=3Doff was itself causing the
resume failure by breaking the ASPM L1.2 sequencing S0i3 depends on -
reasoning that the machine got worse "with ASPM restored". Since L1 was
enabled in both arms, ASPM was never restored and that hypothesis remains
open. I withdraw the retirement.

The experiment that would actually close it, still untested: boot without
pcie_aspm=3Doff but with pcie_aspm.policy=3Dperformance. That leaves the AS=
PM
code path live and the OS holding _OSC control, while holding the links
electrically L1-off - the one configuration in which L1 is genuinely off on
the wire, and the only one that separates "the parameter disabled ASPM
handling" from "L1 is off on the wire". I will follow up with that result.
It carries a real risk of repeating the hang, since it also grants the OS
_OSC control.

2. Distro kernels - now with a vanilla-mainline control (2026-08-21).
---------------------------------------------------------------------

Experiments 1-5 ran on CachyOS builds (patched Arch derivatives; versions a=
s
shipped). To remove that variable I built vanilla v7.2 from git.kernel.org =
-
same upstream base as the 7.2.0 CachyOS build, so it is a patched-vs-vanill=
a
comparison and not a version change - and re-ran the harness unchanged:

=C2=A0 kernel 7.2.0-1-mainline, 2026-08-21 13:48
=C2=A0 BEFORE =C2=A00000:67:00.0 state=3DD0 =C2=A0 =C2=A0 =C2=A0cfg=3D24261=
b21
=C2=A0 AFTER =C2=A0 0000:67:00.0 state=3DD3cold =C2=A0cfg=3Dffffffff
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 suspend_stats: success 1, fail 0,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0last_failed_dev 0000:67:00.0, step resume
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 taint 12288 -> 12800, tb_cfg warns 0 -> =
9,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xhci resume failures 3

Vanilla mainline fails identically, down to the WARN count and the taint
delta. The toolchain differs too (the 7.2.0 CachyOS build is clang/LTO,
which is why symbols in its traces carry an .llvm.<hash> suffix; 6.18.42-LT=
S
and vanilla are GCC and print clean symbols) and makes no difference to the
outcome. Together with the same defect reported on Debian and Gentoo kernel=
s
(#1102175), this is not a distro artifact.

3. Whether an earlier kernel ever recovered from this is unknown.
-----------------------------------------------------------------

An earlier claim to that effect in my own notes was withdrawn: it rested on
a "usb 3-1: reset ... using xhci_hcd" line that belongs to a different
controller (6a:00.3), not the ASM4242. USB bus numbers do not follow PCI
topology here - usb1/usb2 are the ASM4242's; usb3+ are the AMD controllers'=
.


REPRODUCER
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Suspend, then read config space - do not judge by sysfs device nodes, which
persist in kernel memory and read "alive" through total failure:

=C2=A0 sudo rtcwake -m no -s 35
=C2=A0 systemctl suspend
=C2=A0 sleep 60
=C2=A0 for d in 0000:05:00.0 0000:67:00.0 0000:68:00.0; do
=C2=A0 =C2=A0 echo -n "$d cfg=3D"
=C2=A0 =C2=A0 sudo dd if=3D/sys/bus/pci/devices/$d/config bs=3D4 count=3D1 =
status=3Dnone \
=C2=A0 =C2=A0 =C2=A0 | od -An -tx4
=C2=A0 done
=C2=A0 # ffffffff =3D off the bus
=C2=A0 sudo setpci -s 00:02.1 CAP_EXP+12.w
=C2=A0 # 0x3044 healthy / 0x1101 dead (bit 13 =3D DLActive)


LOGS
=3D=3D=3D=3D

Full logs from each round (pre/post PCI state, suspend_stats, taint, WARN
counts, scoped USB reset counts, collateral checks) are available on reques=
t,
and I am happy to attach them here or post them to a bugzilla.kernel.org
entry, whichever you prefer:

=C2=A0 - asm4242-suspend-6.18.42-1-cachyos-lts.log =C2=A0 =C2=A0 =C2=A0 =
=C2=A0- experiment 1
=C2=A0 - asm4242-suspend-7.2.0-1-cachyos.log =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0- experiment 2
=C2=A0 - asm4242-suspend-7.2.0-1-cachyos-round3-d3cold.log - experiment 3
=C2=A0 - asm4242-suspend-7.2.0-1-cachyos-round5-notb.log =C2=A0- experiment=
 5
=C2=A0 - asm4242-suspend-7.2.0-1-mainline-mainline-vanilla.log - vanilla v7=
.2
=C2=A0 =C2=A0 control (limitation 2)
=C2=A0 - asm4242-suspend-7.2.0-1-cachyos-round6-noaspm.log - the clean-cmdl=
ine
=C2=A0 =C2=A0 control that hard-hung the machine; note this varies PCIe _OS=
C
=C2=A0 =C2=A0 ownership, not ASPM link state (limitation 1). It truncates m=
id-run at
=C2=A0 =C2=A0 the wake-alarm line, which is itself the evidence
=C2=A0 - asm4242-acpi-pwrs-aml.txt - the disassembled PWRS power-resource A=
ML,
=C2=A0 =C2=A0 the P_ON/P_OF/PSTA bodies, the M644 =3D CpmDumpData helper, a=
nd every
=C2=A0 =C2=A0 occurrence of XHGP showing the M4F1 branch is unreachable

Happy to run further tests on request - this machine reproduces the bug 100=
%
of the time, and I have a scripted harness for it.

Thanks,
bullfrog650



Sent with Proton Mail secure email.


