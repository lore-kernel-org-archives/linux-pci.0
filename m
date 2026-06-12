Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8F262A6
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307268; cv=none; b=GQRz9rdveLcNjkSMK/9HM5zAHFG8pvWWMSQP3otZwpz0gOGlS/KVjliaRFSV6PcHA1Ji8aPFH48hPeMhHLzkBjn7cD712QNt+TMXR6hq0teeUDL1GK4KFMVEpgUMkVzF7GfpitgdZC6fZIbVW1SeWuZ5Qo0saLbpw2jikWQdhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307268; c=relaxed/simple;
	bh=KdGVlWGc1xt7EcKmaxnCgt6R0VqmZCq87hsakbjTEFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YJJ6cZDEwjDUL4quNfglOwSxeSifeaMLQWimLZX3VsGyOqhHScRz/DPT/OVoO8HA6jGl/qA9U/B/o/qSW8eJXbJP1rij/Sivphbn77hOthTMd8RIqRr2k4KcYahppr+aZmGHnGkKjBCpD2OVthhnqTx9JSbCEpBK8kFwD4w+RjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGBGrh5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGBGrh5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EFD1F000E9;
	Fri, 12 Jun 2026 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781307267;
	bh=WV7zgm/nDozuoBgytn7wESR9Xg3RA8Njd6u1WGhADF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kGBGrh5ME4Myx0QGyQpnL23P22pnATEnatkoZX0QkDn26lnsBaXSmhXjaas4zuqm9
	 JTCMCDBUjx+uZy4pRwwqZixg/nUpSbNbakSmkOeZfsj0nsw14xeQOvNyFrE2MJbYKJ
	 gyU3LQX37VDoHQV5njIZOpqwMjmV0Oo7Tvq0jD/3glHDbASTivLGs7MqWz4sP9oY+S
	 TRijHAP7bmJQpwU2p7NiMrtiISeUVCewq5Tjh7fmdMqY/COHMN5UMTWBA9IaXt/2Q/
	 iaQlniOBKJ4he+cl02aD+nodFIA/AqgcDXn+3Zlrg+ImnCewc8n5NMjyo315bwrQTx
	 TroLcMvVb6cBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] alpha/PCI: Fix I/O port accessor argument order in
 pci_legacy_write()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260612232400.585195-1-kwilczynski@kernel.org>
References: <20260612232400.585195-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 23:34:26 +0000
Message-Id: <20260612233426.B7EFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional 4-byte dereference of a dynamically sized buffer in =
`pci_write_legacy_io()` causes KASAN slab-out-of-bounds reads and potential=
 uninitialized memory leakage to PCI legacy I/O ports.
--

commit d23423541386d95f58a7717629ce697088a7288f
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

alpha/PCI: Fix I/O port accessor argument order in pci_legacy_write()

This commit fixes the argument order for outb(), outw(), and outl() in the
Alpha architecture's pci_legacy_write() function. Previously, the port and
value arguments were swapped, resulting in incorrect writes.

> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
> index 94dbc470cd6c0..7050f0f7fe3d7 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -224,17 +224,17 @@ int pci_legacy_write(struct pci_bus *bus, loff_t po=
rt, u32 val, size_t size)

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a problem with how
the val parameter is populated by the caller.

In drivers/pci/pci-sysfs.c:pci_write_legacy_io(), there is an unconditional
4-byte dereference of the dynamically sized buffer when calling
pci_legacy_write():

    return pci_legacy_write(bus, off, *(u32 *)buf, count);

When a user writes 1 or 2 bytes to the legacy_io sysfs file,
kernfs_fop_write_iter() allocates a buffer sized to the requested length
plus a null terminator. The unconditional 32-bit dereference causes a
KASAN slab-out-of-bounds read and populates the upper bytes of val with
uninitialized heap garbage.

While it appears the Alpha outb() implementation safely truncates this to
the lowest byte, other architectures like little-endian PowerPC can
extract the uninitialized memory instead of the user's intended value:

arch/powerpc/kernel/pci-common.c:pci_legacy_write() {
    ...
    out_8(addr, val >> 24);
    ...
}

Could this lead to leaking uninitialized memory to the hardware port and
bypassing the intended device write? Does the PCI subsystem need a fix in
pci_write_legacy_io() to safely read from buf based on count before passing
it to pci_legacy_write()?

> =20
>  	switch(size) {
>  	case 1:
> -		outb(port, val);
> +		outb(val, port);
>  		return 1;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612232400.5851=
95-1-kwilczynski@kernel.org?part=3D1
