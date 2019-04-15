Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A04C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB4C2087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3uJQL63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDONfQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:35:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38607 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfDONfQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 09:35:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so22015765wro.5;
        Mon, 15 Apr 2019 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/N9tyPUbiSgTG94lZVPkhAPk8xaSZ3PkoUJGC+Y1YNo=;
        b=i3uJQL639T7+sbW5th+cJTUl+NnyBhXICiWNyZK32Uvphw74jkkQ3Wwaxs2zc9zPJ2
         B5PSpbUmU3YgKdFEXTLafg3wEQu1+caq/kMamqIPdfGGXFWwhFSwOu+gXwSLs8lD9Y0S
         MKtkxavuWSERtyBiEVG5ZxxhzlRWPmQkVC4WWf6riN0hM1z3vjEgC4WS+EoVkmY5woaY
         ihF0gGMYDsZ+y9AxsGSALAJ6/hX93jcxQKLxcqkOcaKXOcD0c/t7rXxYabo61JUZpGMj
         ii2ouvvxhPtqj/OX3Z7j52/W42kTwi2sCp5osxU3kbuwIx5v0AbBw8QPVMZw0TkdB6QR
         KZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/N9tyPUbiSgTG94lZVPkhAPk8xaSZ3PkoUJGC+Y1YNo=;
        b=Yd5WxJTpi9vf4wSK2H0HSkWlIgMiBVocWnWWaEAj2RG/oaSzf4GMNErW9ziWbOLZDI
         iMxO18XaBcBCJ2mipbrBrSB4MjoArQLNiQJODC8tvrAuEH0CPhlDP4a9+JNcMG+vUHsi
         3ONnHKRUpGG/jgXlE9giJ9mrvsxV3GFnU/NvPzgTTPm+GiRZHs04ya8Qh0BvIv+5xR58
         I36q0yNm2WALRuwhZV9tc3Tkea9nnJOeBxRJrnvUPkryktJGF7SVTT78ieXzU2EkOMG3
         N43sDSsAxk0klVsnGS7+5jpqkyBscM7jfy6xzHT9bGaVYsbcjkYkP2O2pr/5RIdQJZ7h
         /g1Q==
X-Gm-Message-State: APjAAAUcPDgZmqTYhcvhgOUIU4mV53NGar3so1E84FhHtgbI46xM8Z0F
        J11e6ayMdQ1NZXMgErdxbhI=
X-Google-Smtp-Source: APXvYqytq7ksJ1uIh/QCz3Td7+9j6QqqIp5ZGxL4A14j1rlGqSKVI8h/bKBnDNv9IKp2ebW6kzcsmg==
X-Received: by 2002:adf:e506:: with SMTP id j6mr363479wrm.41.1555335313537;
        Mon, 15 Apr 2019 06:35:13 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id r196sm23155172wmf.22.2019.04.15.06.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 06:35:12 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:35:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 19/30] PCI: tegra: Use legacy irq for port service drivers
Message-ID: <20190415133511.GU29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-20-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FfX2iGK5t5ehHnsE"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-20-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--FfX2iGK5t5ehHnsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:44PM +0530, Manikanta Maddireddy wrote:
> Tegra signals PCIe services like AER, PME, etc over legacy IRQ line.
> By default service drivers register interrupt routine over MSI IRQ line,
> use pcie_pme_disable_msi() function to disable MSI for service drivers.
>=20
> PME and AER interrupts registered to MSI without this change
> cat /proc/interrupts | grep -i pci
> 36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
> 37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
> 76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif
>=20
> PME and AER interrupts registered to legacy IRQ with this change
> cat /proc/interrupts | grep -i pci
> 36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW not=
if
> 37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index dcfe97711cb5..11be88a394e3 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -41,6 +41,7 @@
>  #include <soc/tegra/pmc.h>
> =20
>  #include "../pci.h"
> +#include "../pcie/portdrv.h"
> =20
>  #define INT_PCI_MSI_NR (8 * 32)
> =20
> @@ -2724,6 +2725,9 @@ static int tegra_pcie_probe(struct platform_device =
*pdev)
>  		goto put_resources;
>  	}
> =20
> +	/* PME events are received over legacy INTR, so disable MSI for PME */
> +	pcie_pme_disable_msi();
> +

I don't know about Bjorn, but to me it seems like this should be an
explicit property of the PCI host bridge rather than some global
variable. We already have a couple of flags for similar purposes in
struct pci_host_bridge.

The above seems like it should always work fine and I can't envision a
device where we'd ever have a Tegra PCIe root complex and a different
host bridge, so this wouldn't make a difference one way or the other,
but this global variable seems like a suboptimal solution to me.

Bjorn?

Thierry

--FfX2iGK5t5ehHnsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0iI8ACgkQ3SOs138+
s6FPaw//blhb2pCkcEGoGDEOW0RH5PpoG7mPFH+LMSGmVNycRI0GdO/f+WebaBem
ZaDxr9RcWowyZIugthAFeyU2fkhojal1PuXfa9ZSUPkIc5+4VLySkjUcwfv+lbZ+
9mXDn2Ej8TOslHYraXxmZ55/iVi326+pdlFXcgENYdlz1s+EjsL17o6jjbdJIMns
YlkUbB9hExhcKT1VPDohSB7fudBgfxnfMvXZaPuW6/j84czUEnrtGpFaTBBsdPcQ
VI+rxxcNGJeS1tS/wUuwaPbgjgRMY8AODpD18o2pvhlnsCROvdQ28TTRvqL758L8
rbFr2pvsHiqYblo+R+yxsYeB1OG7/CK/JZpqXNLCuuW8jGvH5LzMRmyMa8OUOjGC
7kAXZKShJ3daLTmAxxhSGnTUS/aQZLopSjwzP6cZrtZHM+27KiodHPEWY/EwPFYW
Fa/Fl7OiohSIwvQAmrZCuc4RUdQBC9JF7/adWdeyuNXFZUlNLbRJhhQa+m2By69L
G2Po/BV7zjuDmRsbAMbUEFYORyXtMA56aHm1t97IL6HSxtBQ/TkR0jEfHO32+Vhw
6UfbrGBbuiYPXZKcYzv7b3yjCA5odRrDveQptxFaCgKLqYpUKNAfuLmYI7j8Px9O
RanIJB2kgzToTahe21suSajiTKDRaLjh/Q/cg0PJ94x5quQNgZ8=
=3mmt
-----END PGP SIGNATURE-----

--FfX2iGK5t5ehHnsE--
