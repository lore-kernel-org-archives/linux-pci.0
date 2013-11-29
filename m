Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:36944 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab3K2Naq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2013 08:30:46 -0500
Date: Fri, 29 Nov 2013 14:29:58 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, treding@nvidia.com,
	pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 08/31] pci: tegra: use reset framework
Message-ID: <20131129132957.GU22771@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-9-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULJ2Z7kCM1hyNsWd"
In-Reply-To: <1384548866-13141-9-git-send-email-swarren@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ULJ2Z7kCM1hyNsWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 15, 2013 at 01:54:03PM -0700, Stephen Warren wrote:
[...]
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 0afbbbc55c81..174a5bc2d993 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -39,6 +39,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>

Can't you also remove the linux/clk/tegra.h include now that none of the
functions it declares are used anymore?

Otherwise looks good to me:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--ULJ2Z7kCM1hyNsWd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmJbVAAoJEN0jrNd/PrOhDHwQAIc9/Y/paQQ8HQ1EvLTwh6jr
ZEjpYkzQzXhkO65mU1PWY5JXyB7D3WmCAhBXDnoHmXSnj1qmhQdlC+RXFcAIsMJQ
wXPlo+aeXHEnw+RehQvevJPSAIuXTXbcQeHfmRFqoh1EBqC+ccXzvVmy2+zV6+jq
T7wPPBiT5/ld3IxvZiGtZeM/MCH27iAb0KYkhcFUaY96Z2s9gbzOwzQebjM6Fgcn
gmX6mpVW/M1/cvlwWcEwoJ4pum5D2uqX2ys1uGfQ+HPGMub0cIpsi/uXrLMiJ+O+
exAwjj3Y2RRME9RgvX+tr8g+QBJLURkfH23Fw9wFjBkgXezMFcJNALk2Wy9qs5/N
98Lly/Y+YAXiUIJyfmZQkte4JH253JBtIZWYoGbnF41EVOyxrVJ65ZlnieP08aGb
LEtmELZyT7yNh6N6nrDhm7saT1WhsXGT4QLAiMOJfflvIMI/T2T/ZO90uDfaa7HO
b5vRyUfoKZBElYjwqqFQNWdydpeFO/BssWgH8OMAbrjEChT2GnSPQFAExddDOrCi
PkXv0Df9RsIcBPjHNnfC3UB2v6hd5WAQjWYitih0iSpRQLp1NlkkXI6pe68qVlZG
cT9UVnsh18TL5MmAflzSknTDstQmoTgBVj4tF+anEc1Ijl0/CdRkyWUsAhNNkx9H
Y9ChG/vPwoY2gxp2k6M+
=3mjw
-----END PGP SIGNATURE-----

--ULJ2Z7kCM1hyNsWd--
