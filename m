Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44984 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933917AbeALPHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jan 2018 10:07:48 -0500
Date: Fri, 12 Jan 2018 16:07:44 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ian Ray <ian.ray@ge.com>, Nandor Han <nandor.han@ge.com>
Subject: Regression due to "PCI: Do not allocate more buses than available in
 parent"
Message-ID: <20180112150744.sjntmpas5noaub6g@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jat2mqe4e7ghz445"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--jat2mqe4e7ghz445
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have an ARM/DT based system [0], that no longer finds its ethernet cards
behind a PCIe switch. I bisected the problem and ended up on
a20c7f36bd3d. I tried providing some space using the suggested "pci=hpbussize=<N>",
but it does not seem to work.

I added dmesg for working, broken and broken + parameter below. At
the moment I would say this is a regression and the commit should be
reverted.

[0] arch/arm/boot/dts/imx6q-b850v3.dts

-- Sebastian

root@GE004097290225 b850v3:~# uname -a
Linux GE004097290225 4.14.0-rc3-00007-g4147c2fd9b12 #1678 SMP Fri Jan 12 15:42:05 CET 2018 armv7l GNU/Linux
root@GE004097290225 b850v3:~# dmesg | grep pci
[    0.189198] OF: PCI: host bridge /soc/pcie@1ffc000 ranges:
[    0.402498] imx6q-pcie 1ffc000.pcie: link up
[    0.402509] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.402519] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.402643] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.402656] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.402667] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.402676] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.402716] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.402756] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.402779] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.402859] pci 0000:00:00.0: supports D1
[    0.402870] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.403276] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
[    0.403478] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
[    0.404151] pci 0000:01:00.0: supports D1 D2
[    0.404159] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.432595] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.432924] pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts with (null) [bus 01])
[    0.433056] pci 0000:02:01.0: [10b5:8605] type 01 class 0x060400
[    0.433912] pci 0000:02:01.0: supports D1 D2
[    0.433921] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.434312] pci 0000:02:02.0: [10b5:8605] type 01 class 0x060400
[    0.435168] pci 0000:02:02.0: supports D1 D2
[    0.435177] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.435568] pci 0000:02:03.0: [10b5:8605] type 01 class 0x060400
[    0.436423] pci 0000:02:03.0: supports D1 D2
[    0.436432] pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.437174] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.437230] pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.437285] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.437738] pci 0000:03:00.0: [8086:1533] type 00 class 0x020000
[    0.437922] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0007ffff]
[    0.438032] pci 0000:03:00.0: reg 0x18: [io  0x0000-0x001f]
[    0.438091] pci 0000:03:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
[    0.438748] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.439458] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.439482] pci_bus 0000:03: [bus 03] partially hidden behind bridge 0000:01 [bus 01]
[    0.439909] pci 0000:04:00.0: [8086:1533] type 00 class 0x020000
[    0.440094] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x0007ffff]
[    0.440204] pci 0000:04:00.0: reg 0x18: [io  0x0000-0x001f]
[    0.440263] pci 0000:04:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
[    0.440921] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.441635] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.441658] pci_bus 0000:04: [bus 04] partially hidden behind bridge 0000:01 [bus 01]
[    0.441982] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    0.442004] pci_bus 0000:05: [bus 05] partially hidden behind bridge 0000:01 [bus 01]
[    0.442024] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
[    0.442035] pci_bus 0000:02: busn_res: can not insert [bus 02-05] under [bus 01] (conflicts with (null) [bus 01])
[    0.442056] pci_bus 0000:02: [bus 02-05] partially hidden behind bridge 0000:01 [bus 01]
[    0.442075] pci 0000:00:00.0: bridge has subordinate 01 but max busn 05
[    0.442351] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.442370] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x014fffff]
[    0.442382] pci 0000:00:00.0: BAR 9: assigned [mem 0x01500000-0x016fffff pref]
[    0.442432] pci 0000:00:00.0: BAR 6: assigned [mem 0x01700000-0x0170ffff pref]
[    0.442446] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x2fff]
[    0.442465] pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x013fffff]
[    0.442477] pci 0000:01:00.0: BAR 9: assigned [mem 0x01500000-0x016fffff 64bit pref]
[    0.442489] pci 0000:01:00.0: BAR 0: assigned [mem 0x01400000-0x01403fff]
[    0.442523] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x2fff]
[    0.442542] pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
[    0.442554] pci 0000:02:01.0: BAR 9: assigned [mem 0x01500000-0x016fffff 64bit pref]
[    0.442565] pci 0000:02:02.0: BAR 8: assigned [mem 0x01300000-0x013fffff]
[    0.442576] pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.442587] pci 0000:02:02.0: BAR 7: assigned [io  0x2000-0x2fff]
[    0.442601] pci 0000:03:00.0: BAR 0: assigned [mem 0x01100000-0x0117ffff]
[    0.442633] pci 0000:03:00.0: BAR 3: assigned [mem 0x01180000-0x01183fff]
[    0.442665] pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    0.442698] pci 0000:02:01.0: PCI bridge to [bus 03]
[    0.442719] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    0.442757] pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012fffff]
[    0.442785] pci 0000:02:01.0:   bridge window [mem 0x01500000-0x016fffff 64bit pref]
[    0.442836] pci 0000:04:00.0: BAR 0: assigned [mem 0x01300000-0x0137ffff]
[    0.442869] pci 0000:04:00.0: BAR 3: assigned [mem 0x01380000-0x01383fff]
[    0.442900] pci 0000:04:00.0: BAR 2: assigned [io  0x2000-0x201f]
[    0.442930] pci 0000:02:02.0: PCI bridge to [bus 04]
[    0.442948] pci 0000:02:02.0:   bridge window [io  0x2000-0x2fff]
[    0.442983] pci 0000:02:02.0:   bridge window [mem 0x01300000-0x013fffff]
[    0.443046] pci 0000:02:03.0: PCI bridge to [bus 05]
[    0.443135] pci 0000:01:00.0: PCI bridge to [bus 02-05]
[    0.443152] pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
[    0.443187] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x013fffff]
[    0.443215] pci 0000:01:00.0:   bridge window [mem 0x01500000-0x016fffff 64bit pref]
[    0.443258] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.443268] pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
[    0.443279] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x014fffff]
[    0.443288] pci 0000:00:00.0:   bridge window [mem 0x01500000-0x016fffff pref]
[    0.443774] pcieport 0000:00:00.0: AER enabled with IRQ 302
[    0.444054] pcieport 0000:01:00.0: enabling device (0140 -> 0143)
[    0.445358] pcieport 0000:02:01.0: enabling device (0140 -> 0143)
[    0.446721] pcieport 0000:02:02.0: enabling device (0140 -> 0143)
[    1.165358] ehci-pci: EHCI PCI platform driver


root@GE004097290225 b850v3:~# uname -a
Linux GE004097290225 4.14.0-rc3-00008-ga20c7f36bd3d #1677 SMP Fri Jan 12 14:35:23 CET 2018 armv7l GNU/Linux
root@GE004097290225 b850v3:~# dmesg | grep pci
[    0.189490] OF: PCI: host bridge /soc/pcie@1ffc000 ranges:
[    0.402486] imx6q-pcie 1ffc000.pcie: link up
[    0.402496] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.402506] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.402628] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.402642] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.402654] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.402665] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.402705] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.402745] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.402770] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.402851] pci 0000:00:00.0: supports D1
[    0.402863] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.403276] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
[    0.403477] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
[    0.404151] pci 0000:01:00.0: supports D1 D2
[    0.404159] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.432587] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.432917] pci_bus 0000:02: busn_res: can not insert [bus 02-01] under [bus 01] (conflicts with (null) [bus 01])
[    0.433260] pci_bus 0000:02: busn_res: [bus 02-01] end is updated to 02
[    0.433271] pci_bus 0000:02: busn_res: can not insert [bus 02] under [bus 01] (conflicts with (null) [bus 01])
[    0.433294] pci_bus 0000:02: [bus 02] partially hidden behind bridge 0000:01 [bus 01]
[    0.433313] pci 0000:00:00.0: bridge has subordinate 01 but max busn 02
[    0.433417] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.433437] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
[    0.433449] pci 0000:00:00.0: BAR 6: assigned [mem 0x01200000-0x0120ffff pref]
[    0.433468] pci 0000:01:00.0: BAR 0: assigned [mem 0x01100000-0x01103fff]
[    0.433498] pci 0000:01:00.0: PCI bridge to [bus 02]
[    0.433593] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.433607] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
[    0.434037] pcieport 0000:00:00.0: AER enabled with IRQ 302
[    0.434319] pcieport 0000:01:00.0: enabling device (0140 -> 0142)
[    0.687103] ehci-pci: EHCI PCI platform driver


root@GE004097290225 b850v3:~# uname -a
Linux GE004097290225 4.14.0-rc3-00008-ga20c7f36bd3d #1677 SMP Fri Jan 12 14:35:23 CET 2018 armv7l GNU/Linux
root@GE004097290225 b850v3:~# dmesg | grep pci
[    0.000000] Kernel command line: root=/dev/mmcblk1p2 ro rootwait cma=128M bootcause=POR quiet watchdog.handle_boot_enabled=1 pci=hpbussize=10 console=ttymxc2 video=DP-1:1024x768@60 video=HDMI-A-1:1024x768@60
[    0.189510] OF: PCI: host bridge /soc/pcie@1ffc000 ranges:
[    0.402622] imx6q-pcie 1ffc000.pcie: link up
[    0.402632] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.402642] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.402770] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.402783] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.402794] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.402804] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.402842] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.402883] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.402907] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.402987] pci 0000:00:00.0: supports D1
[    0.402999] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.403408] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
[    0.403611] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
[    0.404286] pci 0000:01:00.0: supports D1 D2
[    0.404294] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.432726] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.433051] pci_bus 0000:02: busn_res: can not insert [bus 02-01] under [bus 01] (conflicts with (null) [bus 01])
[    0.433395] pci_bus 0000:02: busn_res: [bus 02-01] end is updated to 02
[    0.433407] pci_bus 0000:02: busn_res: can not insert [bus 02] under [bus 01] (conflicts with (null) [bus 01])
[    0.433430] pci_bus 0000:02: [bus 02] partially hidden behind bridge 0000:01 [bus 01]
[    0.433450] pci 0000:00:00.0: bridge has subordinate 01 but max busn 02
[    0.433551] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.433569] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
[    0.433582] pci 0000:00:00.0: BAR 6: assigned [mem 0x01200000-0x0120ffff pref]
[    0.433598] pci 0000:01:00.0: BAR 0: assigned [mem 0x01100000-0x01103fff]
[    0.433629] pci 0000:01:00.0: PCI bridge to [bus 02]
[    0.433724] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.433737] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
[    0.434169] pcieport 0000:00:00.0: AER enabled with IRQ 302
[    0.434443] pcieport 0000:01:00.0: enabling device (0140 -> 0142)
[    0.684674] ehci-pci: EHCI PCI platform driver

--jat2mqe4e7ghz445
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpYzz0ACgkQ2O7X88g7
+poL7g/+PKo2fM1i9TEW8LwBFFdCPqbMT8Umz3r4cLkcteYD54w0U0ln5M3rosz5
zvViSHoXsn3KrAMvpXmMGJjmTcuMsWAFoZj8McD0rQG5JFOvP1DppXr5vZ1DAaTM
/0n8j8y3rG96P3DCRca0tXQAHGpgg74+UV//ufFf+uQkqZB2hmNwrPxAQPEuUyhp
TuW0B/7gDbccMK4ke3XlmaDn9S+jiNNb02El5H+KSP9Mr8BUr1Uy611LSKWj/IFf
YdZ/dv2rUNtebafNS047GdfDgP89RE/Dw2D44G0b7NzxUjzsqmrJ+mlmucyhdYQz
/hJtmz7iRezhU2VzmDbdpUqR2XFYhKJFjG0iYQsbx66DGf9Q/zUETrfosXJZndIr
HplMa0cKRBZf/wg2Cz9LlOXH2T46ogYG5HgDLaxoDvTHJzgraIwLGirFkkfM8Sax
Kq1VjgJABrF1IbLaU9IEU/k0e01CuoRf6nnBwKsotKnNNvWqY/ZjvNt+q5zOoFq6
njayQ+9Y06Kj9iPABFPQcB7U4HPaSTa9acKoINHYScjl8VPwwxsQH16YwYeoduQm
Azm+4GifYyMSorrR8s/y+UlbUl5rozkOl1tePmyBeEmSTHSnZAVTB+5sseBci/rZ
S3pJTVUnRMlzNXjBeQJtWyAF29cSSi2LHun8JV/MJUfRfFpy9GA=
=h2HB
-----END PGP SIGNATURE-----

--jat2mqe4e7ghz445--
