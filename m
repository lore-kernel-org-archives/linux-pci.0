Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF7C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928A2206BA
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr3UiL1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfDONZ2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:25:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37450 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfDONZ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 09:25:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so21988131wrm.4;
        Mon, 15 Apr 2019 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypVsvwUV8/jcJv/xVhAcDpRKDAIZjbYkMLc67NtUh/4=;
        b=Hr3UiL1E99lz++08+HhYF9+9Mx3vD2XIyB6kQ+LMP2RKixBYoiQTpVNaBWant4YNJK
         b4unq3JlkjWn8yCaI4eljNNzWK7jLQo/fTtG2FohclNmG3gPTfbTulIT3c9oQFsSMaY/
         oPhDvUfHR0X+rO8a+G5VllnWpJU759gntEAFpdSqMARanJ3+GZkpNxrJVHgPwPNtvlIr
         iEzItnYXq8w8OHgpDzYJPCd87yItrGzWKx+znrG1wQNtqhuncNVsINOVoDoXKjILCC5I
         U1XezV0c5NmxSWGSBVsMqnw6riMjvb4Iu15Lb4WcgLdlnzU4G6dsyBXv1Sjs4NgPkPyP
         +rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypVsvwUV8/jcJv/xVhAcDpRKDAIZjbYkMLc67NtUh/4=;
        b=MKtX4APNa903sToVqVQ2wQwDzi2NvmLTN44+TZt/HxYfF10A4sYMQgBTXxBusueoum
         yjQHiTwbOp/RRZlXaOcN15jQYAWk9ut8+4zkDWEyBzFIwhSwxXXxA8yYse0a7ZM3fTOg
         orZfnRb+Nlh5H4xRE88I4S2Aa13Sv4zb0BO5DstOCKRqmjv7bJwDoX4Hgkbi6NgriY5Y
         VRho9DlRY1aX8mPn4L63FS2d0yiVExmWn+SPiLki5hSYO3D/hpn8W4E6EVvguHa5/utJ
         i9ErY7cdpHTVRcURic6qoumiRJ17tNpOUEFSBlXbmrwrNMXwSk4nUyxn7pdX9GO5/Ygb
         YO+g==
X-Gm-Message-State: APjAAAWSsU0fTUB2CY78Wyi0WzD/ZfDTIybY0GQFs0lSMEZw+8sA9oIs
        2J3eqcCUYzRWCr65WHCoCWjsN8Wy
X-Google-Smtp-Source: APXvYqyUDNLNCoNXhmbNO8pCrwRze8wFmUiNPcZNpe7q/1zMFaokBTKXS3ILXqnBMqz0bBEJM3qXiw==
X-Received: by 2002:adf:efc1:: with SMTP id i1mr47013498wrp.199.1555334725918;
        Mon, 15 Apr 2019 06:25:25 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id p6sm40696967wrs.6.2019.04.15.06.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 06:25:24 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:25:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 17/30] PCI: tegra: Use switch statements in
 tegra_pcie_isr()
Message-ID: <20190415132523.GS29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-18-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dQ2XShfnd5GHxhN7"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-18-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--dQ2XShfnd5GHxhN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:42PM +0530, Manikanta Maddireddy wrote:
> Use switch statements in tegra_pcie_isr() for better code readability.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 37 ++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index cdaaf13a9fd7..cf2715065a53 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -842,36 +842,39 @@ static irqreturn_t tegra_pcie_isr(int irq, void *ar=
g)
>  	};
>  	struct tegra_pcie *pcie =3D arg;
>  	struct device *dev =3D pcie->dev;
> -	u32 code, signature;
> +	u32 code, signature, fpci;
> +	u64 address;
> =20
>  	code =3D afi_readl(pcie, AFI_INTR_CODE) & AFI_INTR_CODE_MASK;
>  	signature =3D afi_readl(pcie, AFI_INTR_SIGNATURE);
>  	afi_writel(pcie, 0, AFI_INTR_CODE);
> =20
> -	if (code =3D=3D AFI_INTR_LEGACY)
> -		return IRQ_NONE;
> -
>  	if (code >=3D ARRAY_SIZE(err_msg))
> -		code =3D 0;
> +		return IRQ_NONE;
> =20
> +	switch (code) {
> +	case AFI_INTR_LEGACY:
> +		return IRQ_NONE;
>  	/*
>  	 * do not pollute kernel log with master abort reports since they
>  	 * happen a lot during enumeration
>  	 */
> -	if (code =3D=3D AFI_INTR_MASTER_ABORT)
> +	case AFI_INTR_MASTER_ABORT:
>  		dev_dbg(dev, "%s, signature: %08x\n", err_msg[code], signature);
> -	else
> +		fpci =3D afi_readl(pcie, AFI_UPPER_FPCI_ADDRESS) & 0xff;
> +		address =3D (u64)fpci << 32 | (signature & 0xfffffffc);
> +		dev_dbg(dev, "  FPCI address: %10llx\n", address);
> +		break;
> +	case AFI_INTR_TARGET_ABORT:
> +	case AFI_INTR_FPCI_DECODE_ERROR:
>  		dev_err(dev, "%s, signature: %08x\n", err_msg[code], signature);
> -
> -	if (code =3D=3D AFI_INTR_TARGET_ABORT || code =3D=3D AFI_INTR_MASTER_AB=
ORT ||
> -	    code =3D=3D AFI_INTR_FPCI_DECODE_ERROR) {
> -		u32 fpci =3D afi_readl(pcie, AFI_UPPER_FPCI_ADDRESS) & 0xff;
> -		u64 address =3D (u64)fpci << 32 | (signature & 0xfffffffc);
> -
> -		if (code =3D=3D AFI_INTR_MASTER_ABORT)
> -			dev_dbg(dev, "  FPCI address: %10llx\n", address);
> -		else
> -			dev_err(dev, "  FPCI address: %10llx\n", address);
> +		fpci =3D afi_readl(pcie, AFI_UPPER_FPCI_ADDRESS) & 0xff;
> +		address =3D (u64)fpci << 32 | (signature & 0xfffffffc);
> +		dev_err(dev, "  FPCI address: %10llx\n", address);
> +		break;
> +	default:
> +		dev_err(dev, "%s, signature: %08x\n", err_msg[code], signature);
> +		break;
>  	}
> =20
>  	return IRQ_HANDLED;

I don't think this improves readability. It does duplicate some code and
is actually longer than the previous variant, so I don't think this adds
value.

Thierry

--dQ2XShfnd5GHxhN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0hkMACgkQ3SOs138+
s6GEqg//eKPRgsBGLEsN2iMBRu5sGehlHiLyP7DbRwiXaGdnQ5q1SRKhJYmfbSwh
AWtUDqhG68TBuXDLgb5AghW90KX4RrDqlhvfnnSYpQVxuXUuLh55uHQbAjI/UP2e
RGHioLAAa+RePhWUR6S6dcsvpAo2OKrZSIk8r2/cYp/TMyRn28vw5voG8cv/yfec
rMlA+ie3HMgGrWi2SZDzkf036OPr2ZQECJPT9qr2Ayfg3W93Q/qmhiSCp5XpOZTD
eRRAOSMH37AFQVAMBGe73AQTUw0oFKZZ0hhAqUw37GFWiBM7/vuOGjYfWYgpmAG7
wQORA8WXpZ/67OmrUV98/J0Iiy1pAXOCxviS4CRTRW/oWN3gTCX2XcdprpONY/EB
fSe/mmlAu9A77FGWSE8dJc2TZG0P3OjpjXSoyVhVSGWIB7xR7qesBIplYyFKwW2k
5vGzGBf10ZaCJmJoYkHNaqF+1S3CuExc1Qzfp9wYSa5+u+sXIMm0cyjL6Qc0AJwe
/i1kUFSVK0CRk6InXPqNl9PGOZ4jiNedAXKi8P11BYFXPqTlZ7ALCy8j2obXvKGn
YmBBl/mbHe80fSpqncJeIEcjMOh1o4a6ezuyqd20EOqN/puhubxym70MJfd6ob8+
BCZuYbL1j/MOk5nD2m92KRgWOyBd8AAsqozocAenqRbqgn0GNqQ=
=lJDM
-----END PGP SIGNATURE-----

--dQ2XShfnd5GHxhN7--
