Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936322;
	b=qR/pIyW5tdArsChJ6lRrD1BzbZS4KgU2zk3oqha/jgLn0WEuAPnr/LOaNuqDJSUb8XL6
	 1dhAFGfLlWoZT0xTgFik9faa7oVVVmde0h+wyZxTmhQ97N3HZIkWbXDMtRi6ozcj2Wu5H
	 Sa65Qd2sgRMyqYFKujIM9y9cJXYsCHpahYqb85jghrsYaAeRVIckrH6egYm7rFarSp/1Q
	 KNioy7btM1UkPMZePOrDrfyVIaa+0IXRtjlVOQutTOpays9alGCLJVMSpQ6vbUg2clh/f
	 xnm3iNH8cbe3w8fsTzymTPRwoKGF0OT0xkWuyH57rQTvlHIaKMB6NJzwldQpmGtWgqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936322;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LV+gXF/xXhZ1UNrTU4g9ywrHyOMfy4hD/Fc6wa02E2M=;
	b=n6vk6RgyHKKM8jT/p3QYlBQUJ/JEq1XjK23GmgC6kYjQphgfKD32CYQYvGuidPmkCeHI
	 yfXBPs+zZUl6lNUO18nBMxazj8WwvhXKyPcoloEFhjYDYG4NLl/tFeGl6LVMd6Qb4vZY3
	 KjBZJX3WtX5b6RGTLqmL06OftYAA3p2eUp0gAxJ9sNW6HLM0dxGnyRIETv30XojCWED2d
	 5WWxIMFstQqqzxHJ2TJ/wVZoI0aUNUz/mTwyGvV5Yt6ND2BkvJnKunoXim1lSV12bP1ea
	 qnE3URh4lxa8/J1GU7vl0m3rD4dh+3Z3tnNdk9LS+QFqPt+2sYYj/X+ta0W2fQh73cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=HTQu6K2L;
	arc=none smtp.remote-ip=109.224.244.123
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B0606A31B
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 13:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 927B0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=HTQu6K2L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792936319; x=1793195519;
	bh=LV+gXF/xXhZ1UNrTU4g9ywrHyOMfy4hD/Fc6wa02E2M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HTQu6K2L9yuODmflgM597mUXpZj8QuqjN8h8C9DikcVyamcVMKMqyB81pI9Gnq0nI
	 nFztp6qoja7n36XXJI85h8Nzjyps/JMTN3WcQUB7m6Rx7XE4J+hbeW8k/O56Y76nNj
	 /OnAZhqkhQ58p1VQD8LwrxRGf52VOAXg1Vc01JXPukm5HCmMVVOwxnkPHjunKJnWLZ
	 bH6Hrk7dABgnarDUnszJ6Q52jJPrevMHxeNYSWkViYlCqunrsodnkiaOc8OimHu+KC
	 c38/Cq3QS34f2WiYEk8ESADBIIzkUeGKGQ7hwd1cfDk/KhN7FVuF7Z4zAuolSoHh3V
	 vMlGlbWNL/rdQ==
Date: Sun, 25 Oct 2026 13:51:53 +0000
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: matt.protacio@pm.me
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [REGRESSION] PCI: sibling bridge windows undersized after rescan since f909e3ee3ed1 ("Remove old_size limit from bridge window sizing")
Message-ID: <aw593qmbGeozzzeSm1vyhxbK4gXyV-yVyDA8-ZHeKwFbW_VS40s9LwMVMr9NWgJl2uPqVpMegCZPGub7MkswOWo3SfngaHNDj8ayjgHR14o=@pm.me>
Feedback-ID: 135619238:user:proton
X-Pm-Message-ID: 4304c96634f9d9cb5de56797038f9640c5a896a0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Since v7.0, a remove + rescan of a PCIe switch with four sibling
downstream ports, each holding a device with a 32G and a 32M 64-bit
prefetchable BAR, no longer assigns resources to three of the four
devices. v6.19 and earlier assign all four. I bisected it to:

=C2=A0 f909e3ee3ed1 ("PCI: Remove old_size limit from bridge window sizing"=
)

#regzbot introduced: f909e3ee3ed1

Hardware
--------
- Intel i9-13900K, ASUS PRIME Z790-P WIFI (BIOS 1840)
- Broadcom PEX88096 switch card (1000:c010) under root port 00:01.1
- 4x NVIDIA Tesla V100-SXM2-32GB (10de:1db5), one per switch
=C2=A0 downstream port. Each has BAR0 16M (32-bit non-prefetchable),
=C2=A0 BAR1 32G (64-bit prefetchable) and BAR3 32M (64-bit prefetchable).
=C2=A0 No Resizable BAR capability.

Topology after rescan:

=C2=A0 00:01.1 root port
=C2=A0 =C2=A002:00.0 PEX upstream
=C2=A0 =C2=A0 03:00.0 (pair A) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A003:04.0 (pair B)
=C2=A0 =C2=A0 =C2=A004:00.0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 08:00.0
=C2=A0 =C2=A0 =C2=A0 05:10.0 -> 06:00.0 V100 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 09:00.0 -> 0a:00.0 V100
=C2=A0 =C2=A0 =C2=A0 05:18.0 -> 07:00.0 V100 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 09:08.0 -> 0b:00.0 V100

The board firmware hangs at POST if the GPUs are powered at boot, so
they are powered after boot and hot-added with:

=C2=A0 echo 1 > /sys/bus/pci/devices/0000:00:01.1/remove
=C2=A0 echo 1 > /sys/bus/pci/rescan

Command line: pci=3Drealloc intel_iommu=3Don iommu=3Dpt. The firmware's
64-bit root window is too small and fragmented for this, so the host
uses an ACPI table override (initrd DSDT upgrade + SSDT) adding a
second root window, 0x8000000000-0xffffffffff. The problem also
reproduces in a VM without that override (see "VM reproduction").

Result on the host
------------------
Prefetchable windows after rescan:

=C2=A0 bridge =C2=A0 =C2=A0 v6.17 (good) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0v7.0.14 (bad)
=C2=A0 00:01.1 =C2=A0 =C2=A06400000000-93ffffffff 192G =C2=A06800000000-880=
7ffffff 128G+128M
=C2=A0 03:00.0 =C2=A0 =C2=A06400000000-7bffffffff =C2=A096G =C2=A0680000000=
0-7803ffffff =C2=A064G+64M
=C2=A0 03:04.0 =C2=A0 =C2=A07c00000000-93ffffffff =C2=A096G =C2=A0not assig=
ned
=C2=A0 05:10.0 =C2=A0 =C2=A06400000000-6fffffffff =C2=A048G =C2=A0680000000=
0-7001ffffff =C2=A032G+32M
=C2=A0 05:18.0 =C2=A0 =C2=A07000000000-7bffffffff =C2=A048G =C2=A0not assig=
ned
=C2=A0 09:00.0 =C2=A0 =C2=A07c00000000-87ffffffff =C2=A048G =C2=A0not assig=
ned
=C2=A0 09:08.0 =C2=A0 =C2=A08800000000-93ffffffff =C2=A048G =C2=A0not assig=
ned

On v7.0 only 06:00.0 gets BAR1. The other three log:

=C2=A0 pci 0000:0a:00.0: BAR 1 [mem size 0x800000000 64bit pref]: can't ass=
ign; no space

and the parent ports log:

=C2=A0 pci 0000:09:00.0: bridge window [mem size 0x802000000 64bit pref]: c=
an't assign; no space

There is plenty of free root window space when this happens. The
failure is inside the switch: pair A's window is the plain sum of its
two children (2 x (32G + 32M)), but after the first child's BAR1 at
0x6800000000 and its BAR3 at 0x7000000000, the second child's 32G
BAR1 needs the next 32G-aligned address, 0x7800000000, which runs
past the end of the pair window at 0x7803ffffff. Two such siblings
need about 96G of parent window, not 64G + 64M.

VM reproduction
---------------
To bisect without rebooting the host, I reproduced it in a QEMU/KVM
guest (q35, OVMF) with the same shape of topology built from emulated
switches, and the four V100s passed through with vfio-pci behind it:

=C2=A0 pcie-root-port -> x3130-upstream -> 2x xio3130-downstream
=C2=A0 =C2=A0 -> each: x3130-upstream -> 2x xio3130-downstream -> V100

with the guest's 64-bit hole set to 512G (pci-hole64-size). Inside the
guest, a remove of the root port + rescan gives exactly the host's
numbers: 48G port windows and 4/4 BAR1 on good kernels; 32G+32M port
windows, 64G+64M pair windows and 1/4 BAR1 on bad kernels. I can share
the exact QEMU arguments if that would be a useful test case.

Release results (Ubuntu mainline builds, plus v7.3 built from stable):

=C2=A0 v6.17.12 =C2=A0good
=C2=A0 v6.18 =C2=A0 =C2=A0 good
=C2=A0 v6.19 =C2=A0 =C2=A0 good
=C2=A0 v7.0 =C2=A0 =C2=A0 =C2=A0bad
=C2=A0 v7.0.14 =C2=A0 bad
=C2=A0 v7.1 =C2=A0 =C2=A0 =C2=A0bad
=C2=A0 v7.2 =C2=A0 =C2=A0 =C2=A0bad
=C2=A0 v7.3-rc3 =C2=A0bad
=C2=A0 v7.3 =C2=A0 =C2=A0 =C2=A0bad

Bisect
------
Between v6.19 and v7.0, limited to drivers/pci, kernel/resource.c,
include/linux/pci.h and include/linux/ioport.h.=20
The parent of f909e3ee3ed1, 4326ab1806a5, is good; f909e3ee3ed1 is bad.

# bad: [028ef9c96e96197026887c0f092424679298aae8] Linux 7.0
# good: [05f7e89ab9731565d8a62e3b5d1ec206485eeb0b] Linux 6.19
        git bisect start 'v7.0' 'v6.19' '--' 'drivers/pci' 'kernel/resource=
.c' 'include/linux/pci.h' 'include/linux/ioport.h'
# bad: [cb3ca564682a0a02a9f95b7b22ad434a7389daaf] Merge branch 'pci/control=
ler/cadence-j721e'
        git bisect bad cb3ca564682a0a02a9f95b7b22ad434a7389daaf
# good: [bf37448d9b7793544904ccf21e5844b6ff4af3c0] Merge branch 'pci/pwrctr=
l'
        git bisect good bf37448d9b7793544904ccf21e5844b6ff4af3c0
# bad: [73b4779864b1e6adad015d14047ae63b88ef9c4c] Merge branch 'pci/resourc=
e'
        git bisect bad 73b4779864b1e6adad015d14047ae63b88ef9c4c
# bad: [9629f71722bb994f4b95088bc37a14f9aeaa5f90] PCI: Log reset and restor=
e of resources
        git bisect bad 9629f71722bb994f4b95088bc37a14f9aeaa5f90
# bad: [f909e3ee3ed1a44202f09ac7e637a0f9ec372225] PCI: Remove old_size limi=
t from bridge window sizing
        git bisect bad f909e3ee3ed1a44202f09ac7e637a0f9ec372225
# good: [bc75c8e5071120e919beb39e69f0979cccfdf219] PCI: Rewrite bridge wind=
ow head alignment function
        git bisect good bc75c8e5071120e919beb39e69f0979cccfdf219
# good: [4326ab1806a52888d1cd076b9020677703e25545] resource: Increase MAX_I=
ORES_LEVEL to 8
        git bisect good 4326ab1806a52888d1cd076b9020677703e25545
# first bad commit: [f909e3ee3ed1a44202f09ac7e637a0f9ec372225] PCI: Remove =
old_size limit from bridge window sizing


Notes
-----
From the patch discussion, f909e3ee3ed1 fixed Simon Richter's xe BAR
resize failure (the aligned old size used as a lower bound after
3baeae36039a), so I assume a plain revert would bring that back. I
haven't tested a revert of v7.0 either: it conflicts with later
changes in setup-bus.c and I didn't want to hand-port it.

My reading of setup-bus.c, offered as a guess rather than a diagnosis:
pbus_size_mem() sizes a window as the plain sum of max(r_size, align)
over its children, while placement in __assign_resources_sorted()
goes in descending alignment order. When a child window's size is not
a multiple of its alignment (here 32G + 32M at 32G alignment), the
next sibling's start has to skip to the next 32G boundary, and the
plain sum leaves no room for that gap. Before f909e3ee3ed1 the old
size lower bound seems to have covered it in my case. I couldn't work
out exactly where the 48G per-port windows on v6.19 come from, so I
may be missing something.

I'm happy to test patches, a revert, or debug output on both the host
and the VM. The VM setup makes it quick to try kernels.

Thanks,

Matt
