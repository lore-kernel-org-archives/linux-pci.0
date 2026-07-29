Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA3481A9E
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329585; cv=none; b=RhXdbQ5Zmjhtocw8uYkmub46HhmH5JQTkcaIfWYbzhbmuLM2ZJu23NO25w2NV2kOZGAiyUw9JvlCMpf7D73EekWuX2Wn4fAE/Pa6X7POlVYQqgIweJQvAa3DYMax0lfT+mwIsgKL6BoKALcbF0vbkX86NdGru+7n7hL0S0VqIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329585; c=relaxed/simple;
	bh=7az4CAtAkKtCclpAJTX5Oky0XygVe6zrZnqt+5m8uJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsPmLgUlGm96SItmJKBp4QbtIBp6SKxlP7sAvkqCMrxu9LunpvNg13tI8x4426fpNFdF7XP+5jVZs2Yt0olr70bYy2beXq0jNMbRzvio8p1Y4pihx79eQJay0pC9WElehpLj9Oh3KivfYXSmv7LugeIYp8hGHi4RyZfgkHmiprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nikableh.moe; spf=pass smtp.mailfrom=nikableh.moe; dkim=pass (2048-bit key) header.d=nikableh.moe header.i=@nikableh.moe header.b=dQXKousr; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=QSbWY9e6; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nikableh.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nikableh.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nikableh.moe header.i=@nikableh.moe header.b="dQXKousr";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="QSbWY9e6"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=dQXKousrv3JN33oWn1OLXHUDT41rs0VuwayIUXPIbYbaDlw/IIsuO7lsE8NA2pnJyB94+7YbkfiFWwbspQ7Nn7Oy7iI/9djflIABmomKK7/wQToRqPMgTb5bukmVNyXAS9eNOawWgiYV2MelUVfFRCIK1ovthlE7dM2l+0lq5GP0HtW7isOEpmx5fhWOSkRVjzzVH+W4cT3eSRP7Ts0ErqbtoHgtOLf7OlYGB6++vyQCELeKocw0JUcLNj4XrklAZFuY6BKOE/KhpU/Z9Rxel0SlIo1N83acfdAKtO8jgJez8bI8VLYD6Oh8Wxfa5twL6t7CNFEvWcA4dKJzozo6wQ==; s=purelymail3; d=nikableh.moe; v=1; bh=7az4CAtAkKtCclpAJTX5Oky0XygVe6zrZnqt+5m8uJM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=QSbWY9e6SyxFg/wSoL1K8t3Q0LmqrYgnkpR+N5IKKSKkiZGKZdDIH2KuTapCueJZeE/lKJjJmtZ1AvZIevWNj6SnTAAcPlWx/0qSp5eXTfZnNULXjaquL0XYEF73qsoSOT0tFl8bqKu81dtlOmMO9xJ0x5CuDXzvFJoqmkVNJWnuJGjIh6tyvJBhqDduKV1guRQ1e91Lfe172ZfyXPqueFkw345MT8/FZUhPgsGRYoZU1/s1FyFLjy6/DGtRLjrxF6dCyHC/uV3NDHZXZQ9yxOUatltwRlZR4Kn9fVxn9ohOeNH5JjZv5kc/VP02BuyFRsBZFXIHpHffrmzaXVl+Cw==; s=purelymail3; d=purelymail.com; v=1; bh=7az4CAtAkKtCclpAJTX5Oky0XygVe6zrZnqt+5m8uJM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 209604:18551:null:purelymail
X-Pm-Original-To: linux-pci@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1546544052;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 29 Jul 2026 12:52:14 +0000 (UTC)
From: Nika Krasnova <nika@nikableh.moe>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "helgaas @ kernel . org" <helgaas@kernel.org>,
	"nika @ nikableh . moe" <nika@nikableh.moe>,
	"markpearson @ lenovo . com" <markpearson@lenovo.com>,
	"bp @ alien8 . de" <bp@alien8.de>,
	"x86 @ kernel . org" <x86@kernel.org>,
	"hpa @ zytor . com" <hpa@zytor.com>,
	"mingo @ redhat . com" <mingo@redhat.com>,
	"linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
	"dave . hansen @ linux . intel . com" <dave.hansen@linux.intel.com>,
	"tglx @ kernel . org" <tglx@kernel.org>,
	"linux-pci @ vger . kernel . org" <linux-pci@vger.kernel.org>,
	"bhelgaas @ google . com" <bhelgaas@google.com>
Subject: Re: [PATCH] x86/PCI: Disable D3cold on Intel BE200 Wi-Fi on Lenovo IdeaPad Pro 5 14IAH10
Date: Wed, 29 Jul 2026 14:52:02 +0200
Message-ID: <20260729125202.33719-1-nika@nikableh.moe>
In-Reply-To: <ec2bc0c14bc036a5e81da6e1fab67a20efe53699.camel@intel.com>
References: <20260722021321.68902-1-nika@nikableh.moe> <20260728200559.GA1391432@bhelgaas> <ec2bc0c14bc036a5e81da6e1fab67a20efe53699.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: koshi/0.3.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

On Tue, 28 Jul 2026 20:14:36 +0000, "Grumbach, Emmanuel" <emmanuel.grumbach=
@intel.com> wrote:
> We try to avoid resetting the firmware during suspend / resume. Out of
> curiosity, can you try to reset it?

I applied your hunk on top of 7.1.3, with my quirk removed, and it makes
no difference. The patched and unpatched runs fail identically:

  iwlwifi 0000:01:00.0: timeout waiting for FW reset ACK (inta_hw=3D0xfffff=
fff, reset_done 1)
  ieee80211 phy0: PM: dpm_run_callback(): wiphy_resume [cfg80211] returns -=
110
  ieee80211 phy0: PM: failed to resume async: error -110

On Tue, 28 Jul 2026 15:05:59 -0500, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> I guess this means "lspci -xs01:00.0" after resume shows all 0xff?

Yes. Before suspend:

  $ lspci -xs01:00.0
  01:00.0 Network controller: Intel Corporation Wi-Fi 7(802.11be) AX1775*/A=
X1790*/BE20*/BE401/BE1750* 2x2 (rev 1a)
  00: 86 80 2b 27 06 04 10 00 1a 00 80 02 10 00 80 00
  10: 04 00 20 8c 00 00 00 00 00 00 00 00 00 00 00 00
  20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 f4 00
  30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00

and after resume:

  $ lspci -xs01:00.0
  01:00.0 Network controller: Intel Corporation Wi-Fi 7(802.11be) AX1775*/A=
X1790*/BE20*/BE401/BE1750* 2x2 (rev 1a)
  00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

I've noticed that the root port above the card also never brings the
link back up:

  pcieport 0000:00:06.0: Data Link Layer Link Active not set in 100 msec
  [...]
  iwlwifi 0000:01:00.0: timeout waiting for FW reset ACK (inta_hw=3D0xfffff=
fff, reset_done 1)
  ieee80211 phy0: PM: failed to resume async: error -110

0000:00:06.0 is the parent of 01:00.0. pci_pm_resume_noirq() only
reaches that wait with prev_state =3D=3D PCI_D3cold, so the root port itsel=
f
was in D3cold, not just the endpoint. When the wait fails, everything
below the port is marked disconnected.

  $ lspci -PP -s 01:00.0
  00:06.0/01:00.0 Network controller: Intel Corporation Wi-Fi 7(802.11be) A=
X1775*/AX1790*/BE20*/BE401/BE1750* 2x2 (rev 1a)

(The "100 msec" there is the settle delay argument rather than the wait.
pcie_wait_for_link_delay() polls DLLLA for up to a second and also tries
pcie_failed_link_retrain(), so a larger d3cold_delay would not help.)

As far as I can tell the BE200 and its firmware are not involved. By the
time iwlwifi runs, the link is already down and every read returns ones,
which is what I would expect if the card never got its power back. That
also explains why a module reload and a PCI remove/rescan cannot revive
it: a rescan needs a working link.

D3cold on this port means switching off the ACPI power resource
\_SB.PC00.RP10.PXP_. I turned on the AML interpreter's method tracing
(trace_debug_layer=3D0x80, trace_debug_level=3D0x10, trace_state=3Denable) =
and
ran a suspend/resume where the card did not come back, to see whether
the firmware's power-on sequence runs at all. Other methods interleave
in the raw log, so this is grepped for RP10:

  Method Begin [\_SB.PC00.RP10.PXP._OFF] execution.
  Method Begin [\_SB.PC00.RP10.GPRS] execution.
  Method End [\_SB.PC00.RP10.GPRS] execution.
  Method Begin [\_SB.PC00.RP10.DL23] execution.
  Method End [\_SB.PC00.RP10.DL23] execution.
  Method Begin [\_SB.PC00.RP10.POFF] execution.
  Method Begin [\_SB.PC00.RP10.GPPR] execution.
  Method End [\_SB.PC00.RP10.GPPR] execution.
  Method End [\_SB.PC00.RP10.POFF] execution.
  Method End [\_SB.PC00.RP10.PXP._OFF] execution.
  Method Begin [\_SB.PC00.RP10.PXP._ON] execution.
  Method Begin [\_SB.PC00.RP10.GPRS] execution.
  Method End [\_SB.PC00.RP10.GPRS] execution.
  Method Begin [\_SB.PC00.RP10.PON] execution.
  Method End [\_SB.PC00.RP10.PON] execution.
  Method Begin [\_SB.PC00.RP10.L23D] execution.
  Method End [\_SB.PC00.RP10.L23D] execution.
  Method End [\_SB.PC00.RP10.PXP._ON] execution.

The resume side mirrors the suspend side: PON() and L23D() going up,
DL23() and POFF() coming down. The firmware runs the whole sequence and
reports success. The link still does not train.

Two registers in the port's own config space say more, both named by the
ASL. L23R sits at 0xE2 bit 3; L23D writes it and then polls until the
hardware clears it, and DL23 does the same with L23E on the way down.
LTSM is at 0x32B, which the firmware's own debug strings call the LTSSM
state.

Before suspend:

  $ setpci -s 00:06.0 0xe2.b
  11

  $ for i in $(seq 5); do setpci -s 00:06.0 0x32b.b; done
  40
  40
  40
  40
  40

After the failed resume:

  $ setpci -s 00:06.0 0xe2.b
  91

  $ for i in $(seq 5); do setpci -s 00:06.0 0x32b.b; done
  01
  01
  01
  01
  01

L23R (0x08) is clear both times, so the request L23D makes does
complete. For comparison, the sibling root port 0000:00:06.2, whose link
is up:

  $ for i in $(seq 3); do setpci -s 00:06.2 0x32b.b; done
  33
  40
  40

I do not know how the values in 0x32B map to LTSSM states, so the only
thing I can point at is the comparison: the failing port sits in a state
it never occupies while a link is up. If anyone has the decode for that
register, I would like to know what 0x01 is.

I can send the full acpidump output, or the decompiled DSDT and SSDTs,
off-list to anyone who wants to look at PON()/POFF() and the GPRS()
helper themselves.

> Another thing.. Does Windows run the same suspend / resume sequence?
> It also uses D3cold? I'd expect Lenovo to run thorough validation on
> those flows on Windows and report possible bugs to us.

I've dualbooted Windows 11 on this machine. The results:

  PS C:\Users\user> powercfg /a
  The following sleep states are available on this system:
      Standby (S0 Low Power Idle) Network Connected
      Hibernate
      Fast Startup

  The following sleep states are not available on this system:
      Standby (S1)
          The system firmware does not support this standby state.
          This standby state is disabled when S0 low power idle is supporte=
d.

      Standby (S2)
          The system firmware does not support this standby state.
          This standby state is disabled when S0 low power idle is supporte=
d.

      Standby (S3)
          The system firmware does not support this standby state.
          This standby state is disabled when S0 low power idle is supporte=
d.
          The current Device Guard configuration has disabled this standby
  state.

      Hybrid Sleep
          Standby (S3) is not available.
          The hypervisor does not support this standby state.

  PS C:\Users\user> powercfg /devicequery wake_armed
  USB4 Root Router (1.0)
  Intel(R) Wi-Fi 7 BE200 320MHz

Output from devmgmt.msc for our BE200:

  Current power state:
  D0

  Power capabilities:
  00000089
  PDCAP_D0_SUPPORTED
  PDCAP_D3_SUPPORTED
  PDCAP_WAKE_FROM_D3_SUPPORTED

  Power state mappings:
  S0 -> D0
  S1 -> D3
  S2 -> D3
  S3 -> D3
  S4 -> D3
  S5 -> D3

The device clearly uses D3, but that does not distinguish D3hot from
D3cold. Windows' DEVICE_POWER_STATE enumeration [1] bottoms out at
PowerDeviceD3, and a driver does not initiate the D3hot -> D3cold step
at all: it requests D3hot, and the device reaches D3cold only when the
bus driver or the system firmware removes the power source [2]. So what
Device Manager reports is the requested D-state, not whether the rail
was subsequently removed. This machine also sleeps via S0 Low Power Idle
rather than S3, so the Sx -> Dx table above does not even describe the
flow that matters here.

Entering D3cold while the system stays in S0 has to be enabled by the
power policy owner, through the INF or a SetD3ColdSupport() call [2].
Does the Windows BE200 driver enable D3cold transitions in S0 on
platforms like this one? If it does not, then Windows never takes the
card below D3hot here, and the D3cold->D0 path would never have been
exercised in validation.

Given that the failure is at the link layer above the device rather than
in the device itself, this should probably be a PCI quirk in
drivers/pci/quirks.c instead of arch/x86/pci/fixup.c.

[1] https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/ne-w=
dm-_device_power_state
[2] https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/enabl=
ing-transitions-to-d3cold

--=20
Nika Krasnova
