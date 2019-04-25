Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D3C43219
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD892084F
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 18:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaApaGFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfDYSVb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:21:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33760 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfDYSVa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2019 14:21:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so211453plo.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DbfVxgdfCkhec35GU1HQ4GzG8kpZ8WlM4OxO53B8PaE=;
        b=iaApaGFcj6uU2U94JYwH+aiYpAs7mH4qgTvb/UfwCTNP1OssqnPAGZHW7IpbqdtiYp
         PyIuw9vaPpUD6RIQXKUtWGkSMvCzm3i5yCj4lH+X4560EZv9zmEXdNBAESbJ9v6+aOSV
         X++1ZxWBxs4iDNmx5gM00p77NUpD85HuuGe1GibMkOsENpkcOtmd35qt73CJhLIM2Cxh
         a+YNZry3+A1b2YcezOlSUbKGZ40TC2qUo3zcSW0L78XJYGbf9QzXqwIe3rG3oTfp9RuT
         k/Xqvp8/Oqyzg8Z9HdPmDsNmRNrhpxw6FrYQDR5AVepA2k3Jr9F8F8rwF1ZGAqfF04q/
         AXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DbfVxgdfCkhec35GU1HQ4GzG8kpZ8WlM4OxO53B8PaE=;
        b=MqD24R+aFZwYWq5vMrKt9mP8NWjX7dRAnKur/WZeyAHMYEMLxAcnQNo9W85mzhAXyX
         CrApvjvJ7Xjh9WWBB0geqq5qGqQAWiubLAPOSgdmKDjsx8OiFT5JBe3OY6Wv+5THzQOX
         +RfOkO64pklpYwYAhFy6h48vpbP44B5MNk/Lclru0LSY1RXsjz0OPSaiOqhI/to5caCY
         hiUicYQVbyKebLeUYg7FWX+21VLXaDnpGr685XPzz+k9JO75Y+JdI/LXoBr8Hle+eM9C
         LQRL+fWs9LzxCBppZUCt3qE3tp3EllVGQHBL7PQ6GD+10mYqoTjXVGqeWvOgoPtHvZjv
         J3tw==
X-Gm-Message-State: APjAAAUPSOrY9Z6TOypHxDMP84c1E+MxRoiPLtXoNQJOrBMZgyqFAAss
        5PYSB+OH77rDZDgGJ679pTVjCA==
X-Google-Smtp-Source: APXvYqx49q90L/wWwW5GuHsq/Eb9SbYDthv2PbvdhVaz1WB1tjR5W5Iz+vYFKxKh8VhUnwu/NtNifA==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr38726843pls.73.1556216488899;
        Thu, 25 Apr 2019 11:21:28 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id a18sm12011087pfg.177.2019.04.25.11.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 11:21:26 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:21:21 -0700
From:   Benson Leung <bleung@google.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Mackerras <paulus@samba.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:AMD KFD" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER" 
        <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] platform/chrome: chromeos_laptop: use helper
 pci_dev_id
Message-ID: <20190425182121.GA175682@google.com>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
 <e882f58b-0808-952e-d293-5e8cc3f04c97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <e882f58b-0808-952e-d293-5e8cc3f04c97@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Wed, Apr 24, 2019 at 09:17:19PM +0200, Heiner Kallweit wrote:
> Use new helper pci_dev_id() to simplify the code.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-By: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/chromeos_laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform=
/chrome/chromeos_laptop.c
> index 24326eecd..7abbb6167 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -125,7 +125,7 @@ static bool chromeos_laptop_match_adapter_devid(struc=
t device *dev, u32 devid)
>  		return false;
> =20
>  	pdev =3D to_pci_dev(dev);
> -	return devid =3D=3D PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	return devid =3D=3D pci_dev_id(pdev);
>  }
> =20
>  static void chromeos_laptop_check_adapter(struct i2c_adapter *adapter)
> --=20
> 2.21.0
>=20
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlzB+qEACgkQHwn1ewov
5lip2g//eS1J0w28ODQxNNXn6vFg16ufHWY3pS3fpqOzY2iOnxmiL4V9a8qXXgs6
Nb7+tl1LTqFgN10TKr4KcYiPShVug0uz3SX9Gx6sI8d0C8Cy74QrQf4wQp48cg6I
0J0BgM0Icd6QdpdrNYZrcRmFJc7FY16i30SMAuINtfcnqgw4oU6hSG3qNXjqNrFG
2VUUjZHpvbAwWso0xToWjfK0TNPQXSslFKi+ROjvWlL+y0TGUBbcMbxviAp1H35X
CuT5Ijknh8FdG+NaMFnGXf6JvzGORNgXlAon15XEbKDf25/K/JyyDh9nJuPesOwG
MmYEiWj29dwg3/8rKvuWpuJVqWplC4x+ZCFvvEaDFeoxZuoLVc5QkVMRkupxwoA7
Ux1/Q9A7YS7OjOPhN2DikJIn2hEJnEyCBU2PdKEZToCUJ/C2gA+WqHyNXcflOldD
PBJSisoYM4LcuV1hhhfXUU/n/BgVPbmYWfvyQpHEbDpnlnDxMb+LheCgDlBn9mAh
QBD82gS5LcMo20071hVEqReV4zBzOc+S+h/4OxYW2HCNyn3qwztqYOge2oM/ezQ8
CV98H+KfIw+dYK8Vi40O9C05+NRkcAY/RaZzjQMyDJG2KxcO1mZhdhhbzCBRuS0o
pj3CU8ScPFa+s0qe7xk/Pac8fR6hmcse8jaJKX7in5MDKQNQ2CY=
=Oshd
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
