Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203780;
	b=rG57S3dsyqASjugQKQkmXSAxWTGqRr/hA2m7nrAzj+XlfnxtcbLFNe993jffrBxYoFVK
	 QNLgz8cZVLu3CHWMy0obiyciX+avhlVa+QiYx+JT7mNz9tXm+6Qg1QQt8IhKpOtHVN8IC
	 Ei6w6wRgiHJuS+Wk4kPyAgPFL0v2XX9EyrgKtJFHmey3KQRgBOlCrBGOIzS8XTucaNoYs
	 QUJdtj3DXkviR12bAo6GKoltzywbrodggumuD38f4MnxOftwhnh5jKq7c0Oq+zrU6Vn6G
	 3ki6aLPrJXVjPfc7yrTkjdsM/2EFmx4ZFqUm+FGiFvw1DANcO12GjyErSGPEkkCxtgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203780;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=zNxy4TxKEn9W0ao1LVIid/JgYPfZELsjFwGZuxfMh4E=;
	b=GMlsfkrNDm0fCUNBxFiznWdOMxK5OeWhbK7Q8yUC3/COBXdZVZddZ3K8hCt92w6DK3zO
	 3xztekFHb6oCLGu3PfZkAtln+1gkbcy9G5JzUZ9G0ExNvPZGVZpG3njEtJ5epAu1+FUGe
	 qWwI3ezOfbmOs3wHJizDxmtO8YQFdhYeAIpZz2LCvur33k/HhHVESBvFw+cuYrg+tFrfF
	 1VcI2dd+2Duk12BitsbTh8dH4LGSNRzaaRJ6xle/I82w3FeJG0sL2rJEpiGHY+8aPekfp
	 zY0RNMqwmmSKf6eiPh2NClk5lhmdXc25SuDZBuf1S5Q5G1ms6wWm46uxEgEXkoZx2lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCbi5gX6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D854606A31D
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCbi5gX6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9B51F01306
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203779;
	bh=zNxy4TxKEn9W0ao1LVIid/JgYPfZELsjFwGZuxfMh4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BCbi5gX6+ASNOLCcSx55hoaYyYBWW0Cb1GBSeTpC9W9Lj6yvTBmk6n9XF6HlQpTae
	 yK8NjGTO6CMH2MCf3ShVLEp0YlTLQBjnHw3gDtNQ9aHjMh3JaXrylWbGOqrU2G52yH
	 /SCI4HD6l73515cSoPu3Fzsgp+ALMg7d3xNojCF+TVJSZPDsVqOnYwIKqmhRechG6e
	 8J9hkRdo+XheIqbBcMPGBikm45XnznxhPIMbGBSMbsuv4/2stxz/0y83Lu/kgDPFlH
	 bsUr0xcakhuPipi/0puXuhDX6wbuCaVcNdzxpQnsrGOILOcv5ii85jnBXjPw9lr5Ld
	 Hm3kGpVQ/dC0Q==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bfa7c09c9eso996529e87.2
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 09:09:39 -0700 (PDT)
X-Gm-Message-State: AFq9FYLevxKh/nM7m6ZejdoGEFx2/SIy6FfJIofjh+uson7ZqhCtCamE
	aoNtXjXifuQt4ZeQFEH0KMn4tzJWd5aWllc2wDhv4CYQRGARRR6vopsBOAQUHO+4UGZ9BMSrRXS
	K/EzPL1OcsK1VPfG+MJd0HWo6xvFt8aQ=
X-Received: by 2002:a05:6512:618a:b0:5bf:a172:db38 with SMTP id
 2adb3069b0e04-5bfcad74135mr1174502e87.59.1793203778257; Wed, 28 Oct 2026
 09:09:38 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d4aaa5e8-7366-461c-94b1-ccf3631c8bf9@6bit.com>
 <b859285b-e43e-43f2-a4f7-af82705d3513@6bit.com> <CAJZ5v0h8ke_CE1Y_nesgOU8L-R6WcPaoxFjjRp0rfyRdg+Lj1Q@mail.gmail.com>
 <c9672648-d01d-4063-b0e2-df38c3868eea@6bit.com> <CAJZ5v0i0XL0iBHE0OcM0sw8_KKBAapinJ-ZOqztn9-8=RCgxQw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i0XL0iBHE0OcM0sw8_KKBAapinJ-ZOqztn9-8=RCgxQw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 28 Oct 2026 17:09:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hOCtJMdH8VuTcMXV112JwonZg07oUrJXCHZ6JqtRHo3w@mail.gmail.com>
X-Gm-Features: AclHuK9dMc6H2Y7UBbksEDryxAqR0SF-1y3j70LPpwOIopLFtjIzaVV7ErV8brc
Message-ID: <CAJZ5v0hOCtJMdH8VuTcMXV112JwonZg07oUrJXCHZ6JqtRHo3w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION_6=2E16=5D_r8169_RTL8168h=2F8111h_fails_to_?=
	=?UTF-8?Q?probe_=E2=80=94_=22Unable_to_change_power_state_from_D3cold_to_D0=22_?=
	=?UTF-8?Q?=E2=80=94_bisected_to_4d4c10f763d7?=
To: linux-pci@vger.kernel.org
Cc: Josh Perry <josh@6bit.com>, Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com, 
	bhelgaas@google.com, hkallweit1@gmail.com, nic_swsd@realtek.com, 
	netdev@vger.kernel.org, regressions@lists.linux.dev, 
	Keng-Yu Lin <keng-yu.lin@hpe.com>, Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 9:33=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Oct 22, 2026 at 11:33=E2=80=AFPM Josh Perry <josh@6bit.com> wrote=
:
> >
> > On 10/22/26 04:50, Rafael J. Wysocki (Intel) wrote:
> > > On Thu, Oct 22, 2026 at 3:37=E2=80=AFAM Josh Perry <josh@6bit.com> wr=
ote:
> > >>
> > >> On 6/11/26 19:07, Josh Perry wrote:
> > >>> #regzbot introduced: 4d4c10f763d7
> > >>>
> > >>> Since v6.16 one of two onboard RTL8168h/8111h NICs on this board fa=
ils
> > >>> to probe on boot; the device drops to D3cold and the driver can't b=
ring
> > >>> it back:
> > >>>
> > >>>     r8169 0000:02:00.0 eth0: RTL8168h/8111h, 00:2b:67:48:40:01, XID=
 541,
> > >>> IRQ 137
> > >>>     r8169 0000:04:00.0: Unable to change power state from D3cold to=
 D0,
> > >>> device inaccessible
> > >>>     r8169 0000:04:00.0: Mem-Wr-Inval unavailable
> > >>>     r8169 0000:04:00.0: error -EIO: PCI read failed
> > >>>     r8169 0000:04:00.0: probe with driver r8169 failed with error -=
5
> > >>>
> > >>> The board has two identical RTL8168h NICs (both XID 541): 0000:02:0=
0.0
> > >>> and 0000:04:00.0. Only 04:00.0 fails =E2=80=94 its sibling 02:00.0,=
 on a
> > >>> different root port, probes and works normally on the very same ker=
nel
> > >>> and boot. The failing NIC then does not appear (no enp4s0), taking =
the
> > >>> machine's WAN offline. This strongly suggests the problem is port/
> > >>> topology-specific rather than device- or driver-specific: the upstr=
eam
> > >>> port behind 04:00.0 is placed in D3cold and the endpoint cannot be
> > >>> resumed to D0.
> > >>>
> > >>> Hardware: RTL8168h/8111h, XID 541, PCI 04:00.0 (onboard 1GbE).
> > >>> Platform: Lenovo ThinkCentre M90n-1 (11AHS0B200), BIOS M2AKT49A
> > >>> (2026-03-25, latest available). Firmware is current, so this is not=
 a
> > >>> platform-firmware issue.
> > >>>
> > >>> Bisection: v6.15 good, v6.16 bad (verified by booting both). I then
> > >>> reverted 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> > >>> initializing") together with its follow-up 907a7a2e5bf4 ("PCI/PM: S=
et up
> > >>> runtime PM even for devices without PCI PM") on top of 6.16.7: the =
NIC
> > >>> probes and links at 1Gbps/Full normally, with no workaround:
> > >>>
> > >>>     r8169 0000:04:00.0 eth1: RTL8168h/8111h, 00:2b:67:48:40:02, XID=
 541,
> > >>> IRQ 138
> > >>>     r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow contr=
ol rx/tx
> > >>>
> > >>> Workaround: booting an unmodified v6.16+ kernel with pcie_port_pm=
=3Doff
> > >>> also restores the NIC, which is consistent with the upstream port b=
eing
> > >>> placed in D3cold and the device failing to resume to D0 after the
> > >>> explicit-D0 init change.
> > >>>
> > >>> The follow-up 907a7a2e5bf4 does not fix this resume case: v6.18.33 =
is
> > >>> still affected (retested today on current firmware).
> > >>>
> > >>> Happy to test patches or provide full dmesg / lspci.
> > >>
> > >>
> > >> Hey guys,
> > >>
> > >> Thanks, and apologies for the slow follow-up. Multiple of you asked =
me
> > >> to test on the latest mainline.
> > >>
> > >> I had a chance to do just that today with the latest mainline v7.3.
> > >> Verdict is that it's still broken, same messages as in the original
> > >> report. pcie_port_pm=3Doff on the same build still works around it.
> > >>
> > >> dmesg, "sudo lspci -vvv" and the sysfs PM state for both boots (same
> > >> v7.3 build, only the command line differs) are attached here:
> > >>
> > >>     https://bugzilla.kernel.org/show_bug.cgi?id=3D222179
> > >>
> > >> New detail from the failing boot: the root port above the dead NIC
> > >> (00:1d.3) is in D0 but its link shows DLActive-, and the endpoint's
> > >> config space reads all-ones ("Unknown header type 7f"). With
> > >> pcie_port_pm=3Doff the port shows DLActive+ and the NIC is in D0 at
> > >> 2.5GT/s x1. So the port seems to come back but the link to 04:00.0
> > >> doesn't retrain.
> > >>
> > >> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D222179
> > >
> > > Please also try v7.3 with this patch applied:
> > >
> > > https://lore.kernel.org/linux-pci/20261015020811.1132314-1-keng-yu.li=
n@hpe.com/raw
> >
> > No dice, unfortunately. Same issue:
> >
> >    r8169 0000:04:00.0: Unable to change power state from D3cold to D0,
> > device inaccessible
> >    r8169 0000:04:00.0: Mem-Wr-Inval unavailable
> >    r8169 0000:04:00.0: error -EIO: PCI read failed
> >    r8169 0000:04:00.0: probe with driver r8169 failed with error -5
> >
> > Same state as unpatched v7.3: root port 00:1d.3 in D0 with LnkSta
> > DLActive- and ASPM L1 enabled, 04:00.0 config space reads all-ones
> > ("Unknown header type 7f"), and the correctable RxErr on 00:1d.3 at
> > ~9.7s. The PCI/r8169 dmesg lines match the unpatched boot line for line=
.
> >
> > I attached the same info for the patch run to the bugzilla ticket.
>
> Thanks for the info!
>
> Let's see what can be deduced from it.
>
> First of all, the device is clearly accessible in pci_pm_init() and
> then it somehow drops off the bus.  However, the complaint about the
> failing power state change is not from the initial power-up.  It is
> printed after setting the driver for the device, so most likely it
> comes from pci_enable_device() triggered by rtl_init_one().
> Interestingly enough, that message also says that the device's power
> state before the attempted transition to D0 is D3cold, but that is not
> the power state in which the initial power-up leaves it.  Had the
> initial power-up left the device in D3cold, it would have printed an
> "Unable to change power state" message which it doesn't do, so most
> likely right after the initial power-up the device is actually in D0.
>
> Since pcie_port_pm=3Doff makes a difference, the problem is most likely
> related to what happens to the failing device's parent port.  Namely,
> pcie_port_pm=3Doff simply prevents the port from going into D3cold which
> indicates that the failing device drops off the bus because its parent
> port goes into D3cold.  Indeed, that may be happening because the port
> probes after the failing device has been initialized and if user space
> flips the "power/control" attribute of the failing device from "on" to
> "auto" after probing the port and before probing the device itself,
> the port will suspend and go into D3cold.  Moreover, the device under
> it is still in D0 when that happens because pci_pm_runtime_suspend()
> does not change the power states of unbound devices (there is even a
> comment in that function regarding the parent of an unbound device
> possibly going into D3cold while the device is still in D0).  If that
> happens, the pci_update_current_state() call in
> pci_enable_device_flags() will update current_state for the device to
> D3cold.
>
> Of course, I'm not sure if this is what really happens and it still
> needs to be figured out why things started to fail after introducing
> the initial power-up.  I'd prefer to use the BZ ticket for
> investigating it though.

And so it turns out that turning off an ACPI power resource associated
with a PCIe root port other than the one holding the affected NIC
causes the clock of that NIC to be gated which means that this is a
platform firmware issue (the shared clock should be represented as a
shared power resource in the ACPI tables).  The older kernels hide
this issue because they never flip the ACPI power resource in question
on and off in the default configuration, but it can be provoked with
the help of the runtime PM sysfs interface of the PCIe root port in
question.

A patch from Mario to add a quirk preventing D3cold from being used
for root ports on the affected system is available:

https://bugzilla.kernel.org/attachment.cgi?id=3D311295&action=3Ddiff&collap=
sed=3D&headers=3D1&format=3Draw
