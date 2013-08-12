Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:36396 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab3HLLJx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 07:09:53 -0400
Date: Mon, 12 Aug 2013 13:09:50 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH V3] ARM: tegra: disable LP2 cpuidle state if PCIe is
 enabled
Message-ID: <20130812110949.GB12042@ulmo>
References: <1376078656-1378-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
In-Reply-To: <1376078656-1378-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2013 at 02:04:16PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
> they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
> this, simply disable LP2 if the PCI driver and DT node are both enabled.

This description is no longer accurate.

> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> I intend to apply this on top of Thierry's Tegra PCIe driver series.
>=20
> v3: Only disable LP2 if a PCIe device that requests an interrupt is
> actually present. This prevents the loss of power-saving when the WAR
> isn't required.

Currently I see the informational message about LP2 being disabled
rather early in PCI setup. That's probably caused by the .map_irq()
being called during enumeration/fixup. So effectively this disables LP2
as soon as a PCI device is found, whether it needs the IRQ or not. But I
don't think we can do any better than this, so that's fine.

[...]
> diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
[...]
> +void tegra_cpuidle_pcie_irqs_in_use(void)
> +{
> +	switch (tegra_chip_id) {
> +	case TEGRA20:
> +		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
> +			tegra20_cpuidle_pcie_irqs_in_use();
> +		break;
> +	}
> +}

I plan to eventually (3.13 perhaps) support building the pci-tegra
driver as a module since most or all prerequisites are now in place, so
we'll need to export this function eventually. But we can do that when
we actually need it. Perhaps somebody will find a better fix for the LP2
problem until then.

> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
[...]
> @@ -41,6 +41,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/tegra-cpuidle.h>

That file doesn't exist in any tree I have. Perhaps it's a new file and
you forgot to add it in this commit?

I've added that file locally to test the patch and verified that it
works around the issue on TrimSlice while not causing any regressions on
Beaver (it doesn't run any code on !ARCH_TEGRA_2x_SOC anyway, but better
safe than sorry).

So with the missing header file added:

Tested-by: Thierry Reding <treding@nvidia.com>

And with an updated commit message:

Acked-by: Thierry Reding <treding@nvidia.com>

Thierry

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSCMJ9AAoJEN0jrNd/PrOhdo8P/03p3yqkc3HvN6D+HK87DmwP
z0tAediv4IAgszwq6k9Vu2PNEGsA+9N40j7tUfRNIfQeUgN5DSig72EnORU35Psm
IFLt8bEMvets05sE71dyiTNwU0cjIRGNWLmKl75UatSoCWLcCH4dgJ2c7AXwpQwM
E8QW7WM6NP8r+IAFw64I9JtMOEPQKZzQmZ7q+6i+6nUu+ljBanqGzI9luDfnputK
xJUgu0PHd+lEGWJVat3TowoH+bqX7PKJ3ON7IzNuFNn3cOI8LotHWWzK6+J35YNG
bjbGIQxYetCII+SDRThjf6ILq1DIrOjTDqHLNxXeGg7Y493QwMvvVlWN3ZG8r3TH
8XGj97M8yEJGPnLsg962oPcMt7zrvZRPbGPxgWLDRBur8/J4pyL3UmRIyHHBCjEV
mGHdcR4R9ufgxbFCr6Dj2RQ7Lg9ExBFvoOQqbx0WLHkAEilMV1g1mEG9Me/iQL6u
rCBnMobAIA4nfklqemAx6t1o+a8kLl5OLlVzX0kM1K5uBF2MYgTjbcIhXjB5MQV6
ZAf+m1+w4diAnd+Q3Zcf90XrIF1XSLLtHHeKTt9Kr9Ze2EmT17vpoqSYBMJmdZwh
/oUJa3kwme5/JWVyh/tw6lymOTxlbOOaX6qsBQkfCNaL1hBGQALQA36vmp0fqmcZ
lgLYZQCR8B8JPnyw1K20
=I//w
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
