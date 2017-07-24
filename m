Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Burton <paul.burton@imgtec.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] PCI: xilinx: Remove platform/architecture restrictions
Date: Mon, 24 Jul 2017 11:49:22 +0100
Message-ID: <3882569.bb2rKKAOIY@np-p-burton>
In-Reply-To: <1500856777-23383-1-git-send-email-linux@roeck-us.net>
References: <1500856777-23383-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5776958.G3JYKpbpUY";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--nextPart5776958.G3JYKpbpUY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Guenter & all,

On Monday, 24 July 2017 01:39:37 BST Guenter Roeck wrote:
> The MIPS Boston board configuration tries to enable CONFIG_PCIE_XILINX.
> That doesn't work since PCIE_XILINX depends on ARCH_ZYNQ || MICROBLAZE.
> Remove that restriction.

I'd prefer that this patch does not go in standalone. The intent for the MIPS 
Boston board is that this driver is enabled for MIPS by this patch:

https://patchwork.kernel.org/patch/9794361/

But not until after earlier patches in that series fix issues with the driver:

https://patchwork.kernel.org/patch/9794355/
https://patchwork.kernel.org/patch/9794357/
https://patchwork.kernel.org/patch/9794359/

That has been held up by disagreement about whether the driver should be using 
0-3 or 1-4 for hardware IRQ numbers, sadly, despite the driver already being 
in tree & clearly broken, and my series not changing which the driver uses...

In any case, I don't really mind if people would rather remove the 
architecture restrictions than just add MIPS, but I'd prefer this doesn't go 
in until the rest of my series since without at least patch 1 of my seres this 
will lead to various WARN()s on Boston boards.

Thanks,
    Paul

> 
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/pci/host/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 89d61c2cbfaa..ed905a5401c3 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -71,7 +71,6 @@ config PCI_HOST_GENERIC
> 
>  config PCIE_XILINX
>  	bool "Xilinx AXI PCIe host bridge support"
> -	depends on ARCH_ZYNQ || MICROBLAZE
>  	help
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.


--nextPart5776958.G3JYKpbpUY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAll10LIACgkQgiDZ+mk8
HGXoIhAAnkN/CJJHePUcRNo/Et5jPQquRvsgI9QnQUHawCNHTw7KFK6HQytRTc7z
MwUewovl9BH7j20fvVRKnpDQEMfJ7DocDP//Jez02Mgq6QPsgIbtzjYzpqsZFkba
0Fi2t8gJmXGgK8EVp9Voi0YXXIOvhxtvLkrJwRiCXC4YFW9/OGxAvDQ4vMWzjOPa
pBPVu9I8e+HzzdNlWX7cDH/tKbMB55F2VmGy64HgBpiC8+wKMvjFYhTO9325fzR/
MB/Od+qs90MU/+PIZ095lTF/M8QArmpfJPOCHXh8D5qxXPTWsPc+jcHam5ifV3Jg
ne7Wn2pnikyDPsU9w7pgKzZGLZ3ya7pAJOL+gphtznvR4NnH3Zg40FzT17j73X08
kGBYXuOSQlKWFWapv3ypbGo+SxEcpR1LHRcbK2fwkfaCTeRwzc/uH5WNDsudjfoA
MIgMAFqYGJ+qqXHgMU2ntkh2QjK4dIEuKF9k2PdfShQaiexmpGSvh9Jypw19N/tq
/nXEGmWG7ggABIq3IWyNMOL9v8V78AeDK4cFbeHydvrXDIeN5bB4Q9TnZ0tQzAsn
5F7BDbQcOsW1d5UJDEUKkN0U4yiLti2E1BoZZ8BdOcUYr9w3DUQzBKjvdz0F6oHB
nJjoFDzXXHSf3Z6kzCT31yzYAVAy2ioSkyHDe0l5fGrjxIBnvh8=
=+KPl
-----END PGP SIGNATURE-----

--nextPart5776958.G3JYKpbpUY--
