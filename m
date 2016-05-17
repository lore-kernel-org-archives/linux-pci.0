Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: next-20160517 - lockdep splat in pcie code
From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1463510162_2853P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 17 May 2016 14:36:02 -0400
Message-ID: <4249.1463510162@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--==_Exmh_1463510162_2853P
Content-Type: text/plain; charset=us-ascii

Seen during boot on next-20160517. This apparently sneaked into the tree
sometime after -0502 (probably after -0512 but I can't prove it at the moment)

[    1.806765] INFO: trying to register non-static key.
[    1.806772] the code is fine but needs lockdep annotation.
[    1.806777] turning off the locking correctness validator.
[    1.806786] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.6.0-next-20160517-00001-gede618fce89c-dirty #276
[    1.806794] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A17 08/19/2015
[    1.806802]  0000000000000086 000000009200d6c8 ffff88022ca23a90 ffffffffa83f99f3
[    1.806815]  0000000000000000 ffff880223727d40 ffff88022ca23b00 ffffffffa80c1de1
[    1.806826]  0000000000000246 0000000000000000 ffffffffffffffff ffff88022ca23ad8
[    1.806834] Call Trace:
[    1.806845]  [<ffffffffa83f99f3>] dump_stack+0x68/0x95
[    1.806855]  [<ffffffffa80c1de1>] register_lock_class+0x541/0x550
[    1.806861]  [<ffffffffa8404b6c>] ? widen_string+0x3c/0xf0
[    1.806870]  [<ffffffffa80c4108>] __lock_acquire+0x88/0x1260
[    1.806876]  [<ffffffffa840751a>] ? vsnprintf+0x36a/0x520
[    1.806886]  [<ffffffffa81bdfc1>] ? kfree_const+0x21/0x30
[    1.806893]  [<ffffffffa80c56d1>] lock_acquire+0xb1/0x200
[    1.806904]  [<ffffffffa852874e>] ? pm_runtime_no_callbacks+0x1e/0x40
[    1.806915]  [<ffffffffa8a07831>] _raw_spin_lock_irq+0x41/0x50
[    1.806923]  [<ffffffffa852874e>] ? pm_runtime_no_callbacks+0x1e/0x40
[    1.806932]  [<ffffffffa852874e>] pm_runtime_no_callbacks+0x1e/0x40
[    1.806942]  [<ffffffffa844fe36>] pcie_port_device_register+0x226/0x560
[    1.806950]  [<ffffffffa8450542>] pcie_portdrv_probe+0x32/0xa0
[    1.806959]  [<ffffffffa84423e0>] pci_device_probe+0x90/0x100
[    1.806969]  [<ffffffffa851e390>] driver_probe_device+0x1c0/0x310
[    1.806977]  [<ffffffffa851e57f>] __driver_attach+0x9f/0xb0
[    1.806983]  [<ffffffffa851e4e0>] ? driver_probe_device+0x310/0x310
[    1.806992]  [<ffffffffa851bf53>] bus_for_each_dev+0x73/0xc0
[    1.807000]  [<ffffffffa851dafe>] driver_attach+0x1e/0x20
[    1.807008]  [<ffffffffa851d614>] bus_add_driver+0x124/0x220
[    1.807020]  [<ffffffffa91d88a9>] ? set_debug_rodata+0x12/0x12
[    1.807029]  [<ffffffffa851eaed>] driver_register+0x7d/0x100
[    1.807039]  [<ffffffffa92105f2>] ? pcie_port_setup+0x7c/0x7c
[    1.807045]  [<ffffffffa84417dd>] __pci_register_driver+0x5d/0x60
[    1.807054]  [<ffffffffa9210655>] pcie_portdrv_init+0x63/0x73
[    1.807064]  [<ffffffffa8000410>] do_one_initcall+0x50/0x1b0
[    1.807072]  [<ffffffffa91d88a9>] ? set_debug_rodata+0x12/0x12
[    1.807080]  [<ffffffffa91d921d>] kernel_init_freeable+0x1b3/0x240
[    1.807089]  [<ffffffffa89fe1ae>] kernel_init+0xe/0x100
[    1.807095]  [<ffffffffa8a0867f>] ret_from_fork+0x1f/0x40
[    1.807102]  [<ffffffffa89fe1a0>] ? rest_init+0x140/0x140
[    1.819159] efifb: probing for efifb


--==_Exmh_1463510162_2853P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVztkkgdmEQWDXROgAQJmfhAAguDZ6WmQtCHqsdnNujRP7YGklrt8fZi8
Ekknf1eyKOwjKSVATm/+XcQKA6g3vsGq6uzPSIIP+RIDE4Hfj47tV+JDjCySxrPK
XoZgppmr4JPdakTOIOnHnZvfIgrCRrjQCDPzNRvKENERPGVD0SM8SYFQY5X3fnxc
qmi6TdrbefzEm+WndwHxQY5fVzazOFcpQSTqYlvN9shwe1pwT7v+PiIzRrU1p6iG
TC2k7P50v1vj2XHKkK9zLhs2Rqg++k1VruyML4mgFHESaPoqCDuC120EODm5O2Rb
RsulURgbXmZnc73MukAWEWVOmObUAnpaolZjMyfuj2tEaCfWQ74GtLzBHqF71o6x
ME5D46ziWCSkdUmSABdloFq9glMggMMmF61Asu4smVmtCWWwS3gXCGrXS01ggNyH
JtFuNmJgrwT8piFkznP47lwC/XUnqSMcrnyD3Jt8oz+c4ayLQfh3IxTz9siraSMd
3TzKip3VERpM/vl+1qV6UdssAGcozmYFpq337YEYu8dEH2LMDcSQIkqUP2+xkkkd
3r4IsVdB00Ah3qbMVbJ6UhWUelZwz0g2vR/MBiiuwcKlzSj0FQPeFbMXCMQYpeNy
mHA8cNIJppquiRFFw0KGTxsohpTYcn4mli/BnWRyPQKbiqiyNDiUjMnXZxW5v6zC
KsjkJA5YZ3M=
=KdaM
-----END PGP SIGNATURE-----

--==_Exmh_1463510162_2853P--
