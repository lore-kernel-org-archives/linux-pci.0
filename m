Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:39988 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbaD3OTS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Apr 2014 10:19:18 -0400
Received: by mail-wg0-f45.google.com with SMTP id b13so1806237wgh.16
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2014 07:19:17 -0700 (PDT)
Message-ID: <5361065E.80304@monstr.eu>
Date: Wed, 30 Apr 2014 16:19:10 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Srikanth Thokala <sthokal@xilinx.com>, bhelgaas@google.com
CC: grant.likely@linaro.org, robh+dt@kernel.org,
	jgunthorpe@obsidianresearch.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3] pcie: Add Xilinx PCIe Host Bridge IP driver
References: <1397561911-11647-1-git-send-email-sthokal@xilinx.com>
In-Reply-To: <1397561911-11647-1-git-send-email-sthokal@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RRHm6IoEN7DfJnpVAh13IietsX9aHf5dv"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RRHm6IoEN7DfJnpVAh13IietsX9aHf5dv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On 04/15/2014 01:38 PM, Srikanth Thokala wrote:
> This is the driver for Xilinx AXI PCIe Host Bridge Soft IP
>=20
> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> ---
> Changes in v3:
> - Rebased on v3.15.0-rc1
> - Added support for interrupt-map DT functionality.
> - Removed map_irq() wrapper, instead using of_irq_parse_and_map_pci().
> - Modified resource mapping logic as per the series
>   "PCI: ARM: add support for generic PCI host controller"
> - Modified devicetree binding documentation to update with interrupt-
>   map properties.
> - Use devm calls wherever applicable.
> - Fixed minor comments from Jason
> - Thanks Jason for the review and suggestions.
>=20
> Changes in v2:
> - Rebased on v3.14.0-rc8
> - Removed IP specific DT properties like include-rc, axibar-num etc.,
>   as suggested by Jason and Bjorn, Thanks
> ---
>  .../devicetree/bindings/pci/xilinx-pcie.txt        |   62 ++
>  drivers/pci/host/Kconfig                           |    7 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-xilinx.c                      |  999 ++++++++++++=
++++++++
>  4 files changed, 1069 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.t=
xt
>  create mode 100644 drivers/pci/host/pci-xilinx.c

Any comment on this patch?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--RRHm6IoEN7DfJnpVAh13IietsX9aHf5dv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNhBl8ACgkQykllyylKDCH49wCfWE9bLKJgU6Lc/gbyIX3o9pJT
WuoAniVKqqaWYKicccMgCkg8MSz8En7u
=t95h
-----END PGP SIGNATURE-----

--RRHm6IoEN7DfJnpVAh13IietsX9aHf5dv--
