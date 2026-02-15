Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225ED25B1CB;
	Sun, 15 Feb 2026 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771197428; cv=none; b=HXLZogm2iWpMESIH2osRplNetrUMPppfEEWPsjdC/xe+WN5vj+3kwNp8yYqVb4vwyrZFt/byfGdS2oFS4NjB+EcODebMQsuryE/6/gxdOIQY8k7WcFtuGxhpLFVqfitpXfMs0lBylJrzQJRMG75cBrFk3FszGVCi9Iht/Ae+QGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771197428; c=relaxed/simple;
	bh=hnBSsfO1CGht7Gt6Qjwxucl/2XWQrXJ9/5CW+65mvNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AnOfptYPJLJl1UKxWGVitF1o56UeQQLuB0ygbBaiy7sVk4NE/Lk1oa8ElBfINIJvBUDGYQCEWbRuGoHZ8XGH/ONoCjGJjjTjhzgGXWUbwgfAkALLdRUOEw9PU9AxQdJ3wdf+5vgKbd7OVx/iG4MJ8j3EQzLTPiWPRUzst89iRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=bHYMbyAf; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="bHYMbyAf"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fDhcr1BjMz9sn0;
	Mon, 16 Feb 2026 00:17:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771197420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VHQNLDWI+8FphCwLhSQoDgXPpG2jMOl85/imasK9bqk=;
	b=bHYMbyAfq0mXpzU4xqyATjMo8v6zbYIUDk62HKUTcaOc2kxZ7tBlqmhWH1lvFpRAU+GhME
	e2tk5G7BaU5xRv3U8XaTcpODD63QKKvVrOS4SGIdwpq8x09s8lePDPvkERtKUK/Ln4o0SA
	zr+ncdwSSAOKkCGFO0MX+C7y6W8zX5uczaJ+/Ha7TsUMcwmztCaCvOLIpT9H08QfQylhpv
	CGBKQrTUCrCfAo9pRQT74jt0pdk0mZmUXdbuy/ygggslmceW4+r3aTBERWIAaQNGEUzbps
	ls4sgF6jHNGY9HeUAtbh7SxnffG0qBSxZIhl0QgqmkWedyc4xrFxm27HlHwhgQ==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: kevin.xie@starfivetech.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Possible memory leaks in 'starfive_pcie_probe'
Date: Mon, 16 Feb 2026 00:16:57 +0100
Message-ID: <87y0kta97a.fsf@>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Hello,

I was testing the latest Linus' tree on my Starfive VisionFive2 board
when I realized that kmemleak was reporting on four suspected memory
leaks (see attachment).

I am not sure what to tell about what I was doing, since I wasn't doing
anything fancy, and my setup is quite minimal. But if you need any more
details I'm more than happy to provide them.

Cheers,
Miquel


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=leaks.txt
Content-Description: leaks reported by kmemleak

unreferenced object 0xffffffd6e3942680 (size 128):
  comm "(udev-worker)", pid 372, jiffies 4294905702
  hex dump (first 32 bytes):
    70 ef 15 b9 ff ff ff ff 40 ee 51 c1 d6 ff ff ff  p.......@.Q.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 9489c4a7):
    __create_object+0x2a/0xd8
    kmemleak_alloc+0xb6/0xc8
    __kmalloc_cache_noprof+0x3c6/0x510
    request_threaded_irq+0x114/0x2e8
    devm_request_threaded_irq+0x6e/0x188
    plda_init_interrupts+0x2a6/0x5f0
    plda_pcie_host_init+0x202/0x420
    starfive_pcie_probe+0x2a8/0x490 [pcie_starfive]
    platform_probe+0xb6/0x158
    really_probe+0x180/0x8a8
    __driver_probe_device+0x154/0x368
    driver_probe_device+0x62/0x160
    __driver_attach+0x192/0x510
    bus_for_each_dev+0xe8/0x170
    driver_attach+0x3c/0x60
    bus_add_driver+0x2ac/0x570
unreferenced object 0xffffffd6e3942c80 (size 128):
  comm "(udev-worker)", pid 372, jiffies 4294905703
  hex dump (first 32 bytes):
    70 ef 15 b9 ff ff ff ff 40 ee 51 c1 d6 ff ff ff  p.......@.Q.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 836d6db5):
    __create_object+0x2a/0xd8
    kmemleak_alloc+0xb6/0xc8
    __kmalloc_cache_noprof+0x3c6/0x510
    request_threaded_irq+0x114/0x2e8
    devm_request_threaded_irq+0x6e/0x188
    plda_init_interrupts+0x2a6/0x5f0
    plda_pcie_host_init+0x202/0x420
    starfive_pcie_probe+0x2a8/0x490 [pcie_starfive]
    platform_probe+0xb6/0x158
    really_probe+0x180/0x8a8
    __driver_probe_device+0x154/0x368
    driver_probe_device+0x62/0x160
    __driver_attach+0x192/0x510
    bus_for_each_dev+0xe8/0x170
    driver_attach+0x3c/0x60
    bus_add_driver+0x2ac/0x570
unreferenced object 0xffffffd6e3943680 (size 128):
  comm "(udev-worker)", pid 372, jiffies 4294905785
  hex dump (first 32 bytes):
    70 ef 15 b9 ff ff ff ff 40 be 51 c1 d6 ff ff ff  p.......@.Q.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 414126a):
    __create_object+0x2a/0xd8
    kmemleak_alloc+0xb6/0xc8
    __kmalloc_cache_noprof+0x3c6/0x510
    request_threaded_irq+0x114/0x2e8
    devm_request_threaded_irq+0x6e/0x188
    plda_init_interrupts+0x2a6/0x5f0
    plda_pcie_host_init+0x202/0x420
    starfive_pcie_probe+0x2a8/0x490 [pcie_starfive]
    platform_probe+0xb6/0x158
    really_probe+0x180/0x8a8
    __driver_probe_device+0x154/0x368
    driver_probe_device+0x62/0x160
    __driver_attach+0x192/0x510
    bus_for_each_dev+0xe8/0x170
    driver_attach+0x3c/0x60
    bus_add_driver+0x2ac/0x570
unreferenced object 0xffffffd6e3943c80 (size 128):
  comm "(udev-worker)", pid 372, jiffies 4294905785
  hex dump (first 32 bytes):
    70 ef 15 b9 ff ff ff ff 40 be 51 c1 d6 ff ff ff  p.......@.Q.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c42897b8):
    __create_object+0x2a/0xd8
    kmemleak_alloc+0xb6/0xc8
    __kmalloc_cache_noprof+0x3c6/0x510
    request_threaded_irq+0x114/0x2e8
    devm_request_threaded_irq+0x6e/0x188
    plda_init_interrupts+0x2a6/0x5f0
    plda_pcie_host_init+0x202/0x420
    starfive_pcie_probe+0x2a8/0x490 [pcie_starfive]
    platform_probe+0xb6/0x158
    really_probe+0x180/0x8a8
    __driver_probe_device+0x154/0x368
    driver_probe_device+0x62/0x160
    __driver_attach+0x192/0x510
    bus_for_each_dev+0xe8/0x170
    driver_attach+0x3c/0x60
    bus_add_driver+0x2ac/0x570

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmSU+kbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZRMdEAClcKoFeQplPhdslRL9+fLF5nLZQjubSxyNh66n9V7b96vCvjj8pUV3Gfjz
euP1gh+mV1VIx8FYLxh7+igdAiejnlL7yLwxA8gCJlPvez5FnjGw20/0heRvOQwY
OyrhaLxEhU94pL/tyDUJHKIo6E25eysJrOOYR8u9wTXj+b9FkgcKo4UYvI/72QRl
eRjUHv80JOFFVBBfkF8U6iCEC8cOmo26LAvLB2e4Zs1SWq00qFSLxwedB3qwZ+Qp
YX1+MkjUl+syn8TW0o+5XW7nBr8/XOe4v/9vCNox4FtTPH4h2jNKF3MYB180yRXr
qX36So5AoiHQbSb9GnkgiH3d/IExhzCVbvn4M3ssl3k1B0D6Btf161VVwJ34b1uH
3nc/zpsMsEPO3i2kF25zw/S+jzw2qpGDDTAARdD1GZLdZPacJHlcB286OveLx8KN
PCnCJSiVxYrRLwSHQ6dfPX3oVoDxmY2TsnWzpq1vAb2bXrCOEooLrEeJyv6DIpFt
V2rN/hYxy/S2V2JyghQhOT1l2mmcPEM82GcBR9M89U5txbZrtt2aLi7KZ5sGBva9
419yXCc0pXBegEStmF8vsrkFk1cyUurlXjX2sjT0X1xQb2cH5h5NerKdeKIJ+pKM
hSz9BIB7AFF1gd01YLh+8u2T/hxstJYzXc4rlKpOklspl78iqg==
=dT2C
-----END PGP SIGNATURE-----
--==-=-=--
