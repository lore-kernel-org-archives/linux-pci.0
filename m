Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from latitanza.investici.org ([82.94.249.234]:23028 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2EZIul (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 26 May 2012 04:50:41 -0400
Date: Sat, 26 May 2012 10:25:52 +0200
From: Antonio Quartulli <ordex@autistici.org>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: warn_slowpath_common in drivers/pci/search.c:44 on linux-3.4.0
Message-ID: <20120526082551.GA2723@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm getting this warning with linux-3.4.0. My laptop is a DELL E5420.
Please tell me if you need further testing/debug.

Cheers,

[    1.054279] WARNING: at drivers/pci/search.c:44 pci_find_upstream_pcie_b=
ridge+0x5e/0x70()
[    1.054385] Hardware name: Latitude E5420
[    1.054457] Modules linked in:
[    1.054568] Pid: 1, comm: swapper/0 Not tainted 3.4.0ordex+ #3
[    1.054643] Call Trace:
[    1.054716]  [<ffffffff81033d4a>] warn_slowpath_common+0x7a/0xb0
[    1.054793]  [<ffffffff81033d95>] warn_slowpath_null+0x15/0x20
[    1.054869]  [<ffffffff8123899e>] pci_find_upstream_pcie_bridge+0x5e/0x70
[    1.054949]  [<ffffffff813babe7>] intel_iommu_device_group+0x77/0x100
[    1.055027]  [<ffffffff813b52d5>] add_iommu_group+0x35/0x60
[    1.055113]  [<ffffffff813b52a0>] ? bus_set_iommu+0x50/0x50
[    1.055191]  [<ffffffff8132c586>] bus_for_each_dev+0x56/0x90
[    1.055267]  [<ffffffff813b528b>] bus_set_iommu+0x3b/0x50
[    1.055344]  [<ffffffff818c4920>] intel_iommu_init+0xab0/0xb3f
[    1.055421]  [<ffffffff81120b26>] ? sys_mkdirat+0x76/0xd0
[    1.055499]  [<ffffffff8189b0db>] ? memblock_find_dma_reserve+0x13d/0x13d
[    1.055578]  [<ffffffff8189b0ee>] pci_iommu_init+0x13/0x3e
[    1.055655]  [<ffffffff810001ca>] do_one_initcall+0x3a/0x170
[    1.055732]  [<ffffffff81897c35>] kernel_init+0x148/0x1cc
[    1.055807]  [<ffffffff81897588>] ? do_early_param+0x86/0x86
[    1.055884]  [<ffffffff814fc914>] kernel_thread_helper+0x4/0x10
[    1.055963]  [<ffffffff8105de60>] ? finish_task_switch+0x80/0x110
[    1.056040]  [<ffffffff814fafdd>] ? retint_restore_args+0xe/0xe
[    1.056126]  [<ffffffff81897aed>] ? start_kernel+0x30b/0x30b
[    1.056203]  [<ffffffff814fc910>] ? gs_change+0xb/0xb



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPwJOPAAoJEFMQTLzJFOZFPQwH/iwpageWWE0YguQfAfp/QLkM
kBTGfKw4muAhJJpFZ558aZ6hukuYwvEB64DaBIWxRL8GELLktVN8ZBzi/SCdxDmE
4VHVVAbOr7WozqwI5myd6tqJJCfq6KnK/yoBvUF6+SR1PHjaY5ygD2e2gQMjXS6U
886UkqPBwucLeUPaBkKI1h0e3NdHzPqhalwFyOaTKsRUV70LPcsdzrQMJcmEUDvt
faVUY6owIbKkG7Hbi63ThHziY0RanrbvIbZsY3+V0xt3TLqZYm9+5iu5MsKzU78v
1d6ypQ34JgQJMuEHfoJsNXoi2khODj7k+FtKMCKnYXEmHIsw+jGcjr9XwgZhMDA=
=Bkad
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
