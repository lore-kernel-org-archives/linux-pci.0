Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB135DA6A
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628151; cv=none; b=ew8jzRCEaJ2GK9IFDxcz5kU6ti1RuBM0RkLzK04+UF6lrRDEgi+6zibK2X65QLNOnKNYitUxc7dhBrvYcUIwvXmKWYnw40WLXnEA17udv+SrqWlUOnc3rx20moQ1nzP2uNdtF3jW5x1XhGtAVmjlSASS2iPER+1YT8klmpdTFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628151; c=relaxed/simple;
	bh=UjKFo293lgNCSMAX6HctwmI3N1OWY/b/lJkBc0nobKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LadShvjAKhTTtMINxKemN+d6pSe/XA/mgMzR6CR0B6ddu0RgyAO+zbTWIno3wZ62imgvQdKDvVlSLEUEssdUG62H4Nux9D+5Z24jZaIX1DozQE+qIeHixTZ2bputcpn68HqUYX09zuy+TuntoxxfY5X6zMaCkz3v3tNrciHpSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkNk+LNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkNk+LNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F281F000E9;
	Tue, 16 Jun 2026 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781628150;
	bh=XPieIrr5VIoys3JNKDg0vG9jmzsnngz5vcB6hrYFgC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DkNk+LNbzKYVt24cxd2UnSVdqAbtKEbk6lbpXN2cQjAgSd02U2k2hDk7Ce0B8Ear1
	 8gRKT86R3dXHzE87NnLkcD4+E774rI5ToiDdBXRKf8xZZiptDeG+zuhSFtnPC+QzZv
	 or+u+ZQRoBVk6mpIdYK457WXauurf634SIyB+K6jMCSmWPE3NrkK1edmhctH6Ph2cu
	 IekFgBUJ8aDx3CQBIIYXTbZ11MMnhEBJcZYTFdIrVKaZd/ZTvA+PZIH5jWF0BdvVDR
	 Sc1hv97Vt5xnY0TTABdrIbO2IDls6eScFZr7Gc2PekEpGlx7WcCAK+tQlfDzgrI0vK
	 0jXDQbCVqH3Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI/sysfs: Fix out-of-bounds read in
 pci_write_legacy_io()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260616163131.2763281-1-kwilczynski@kernel.org>
References: <20260616163131.2763281-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 16:42:30 +0000
Message-Id: <20260616164230.81F281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The Alpha implementation of `pci_legacy_write` passes arguments to=
 `outb`, `outw`, and `outl` in the wrong order, causing arbitrary I/O port =
writes.
--

commit 21e9260d6465f8f037bb9292c32c44b565eca000
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/sysfs: Fix out-of-bounds read in pci_write_legacy_io()

This commit addresses an out-of-bounds read in pci_write_legacy_io() by
only reading the requested number of bytes using little-endian accessors.
It also removes byte-shifting workarounds in the PowerPC architecture
code that are no longer necessary.

>     On little-endian PowerPC (POWER8 and later), they extracted the wrong
>     bytes, so a 1-byte write wrote an out-of-bounds byte instead of the
>     requested value.  On big-endian, the native load also caused out_le16=
()
>     and out_le32() to reverse the user's bytes on the wire for 2 and 4 by=
te
>     writes.  The little-endian helpers resolve both issues, so the shifts
>     are removed.
>    =20
>     No changes are needed for the Alpha platform.
>    =20
>     The legacy_io file is root-only and exists only on Alpha and PowerPC,
>     the two architectures that define HAVE_PCI_LEGACY.

[Severity: High]
This is a pre-existing issue, but the claim that no changes are needed for
Alpha doesn't seem quite right.

Looking at pci_legacy_write() in arch/alpha/kernel/pci-sysfs.c, it calls the
I/O port functions with the port and value reversed:

arch/alpha/kernel/pci-sysfs.c:pci_legacy_write() {
    ...
	switch(size) {
	case 1:
		outb(port, val);
		return 1;
	case 2:
		if (port & 1)
			return -EINVAL;
		outw(port, val);
		return 2;
	case 4:
		if (port & 3)
			return -EINVAL;
		outl(port, val);
		return 4;
	}
    ...
}

Since Alpha's outb(), outw(), and outl() expect arguments in the order
(value, port), doesn't passing port as the value and val as the port
address incorrectly use user-supplied data as the target I/O port address?

Could this allow arbitrary I/O port writes system-wide?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616163131.2763=
281-1-kwilczynski@kernel.org?part=3D1
