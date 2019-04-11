Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9877C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E3F20818
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 10:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5repd78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfDKKN7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:13:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39306 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKKN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 06:13:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so6557781wrn.6;
        Thu, 11 Apr 2019 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHwzttuhA7DO8ITpRLUHkH5/Yi142wVjw+S5wWHn5Mw=;
        b=L5repd78WBjyQvpurU3hL0bVuHnIM25uaTn1PO00nQEr+1NqkDAt7HvPHkz5HcUOGj
         a2SdQyxJRMEzY3I95ipFh9gk0H+u1ly0RQo278NIvqaVIvPl50saWYQxMT1e8LllpN/O
         /PdYonYa8wuJWu400H42TPVLCabjIqSj26ErzvDqOfeexUzWmZe/mvbQxaQ/uBtqM9LJ
         N5gAhmpk2/CYZfs2WWki2WODcQ0ycbWzJC/TjZrnzirF6JrVw4GMZgxnRqU7SRgxchaH
         uMHscXse0Wu1j0vW263xlulQEzS/ADIdkN5FgufLiq19nivJClmXIGEYOmFcjTJ5YfBR
         fMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHwzttuhA7DO8ITpRLUHkH5/Yi142wVjw+S5wWHn5Mw=;
        b=swiuRydR7wOYyo2suiMb8KyC+47b5fnPn1VDiULkINBj/Fg1sK31eNQfefRdzjS1qw
         Tr56bsP1bkg6U3ii71stMYbLk4ef347m3KnPejTOJfVunCK4AJF6WBVvI+BMbeQiOXoW
         VKlIVruFz2goCCzmGd9fdTe9APwWG1bkdluNXDp8e1z9JiAwXTNzs6tXVUmA6c91gFxg
         4a6TnUa2JlQTvlitDQf03fqIgRFg4s6YZON4PYmKRG1LhywJM42bQljnrQ3spZ4+H2tY
         3ZYBQGJA7easq8IMd9AZTk4Ns+3Bt0E0R1D4NksGD4elXNSNYJfDUDKgnaw/aDtnaKUf
         n0hg==
X-Gm-Message-State: APjAAAXFttXcBAOooH5iAp/2xIJEVOFUI6n5Zo2plLNf2v9Ncsp8Y7D8
        pip3wJt7VuSa7XjwmWSo+v0=
X-Google-Smtp-Source: APXvYqwgHrK8lcFw9rpObVZuOhITVqtXNc+HEQiwPVHWt657Nb0/iTxapCzCWX0KdA0AvqjV3pO1vw==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr30441884wrn.193.1554977635656;
        Thu, 11 Apr 2019 03:13:55 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id o15sm34817870wrj.59.2019.04.11.03.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 03:13:54 -0700 (PDT)
Date:   Thu, 11 Apr 2019 12:13:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 01/16] PCI: Add #defines for PCIe spec r4.0 features
Message-ID: <20190411101353.GE4633@ulmo>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-2-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <1554407683-31580-2-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 01:24:28AM +0530, Vidya Sagar wrote:
> Add #defines for the Data Link Feature and Physical Layer 16.0 GT/s
> features.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes from [v1]:
> * None
>=20
>  include/uapi/linux/pci_regs.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 5c98133f2c94..3e01b55d548d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -705,7 +705,9 @@
>  #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
>  #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
> +#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
> +#define PCI_EXT_CAP_ID_PL	0x26	/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL
> =20
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1045,4 +1047,22 @@
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOL=
D_Scale */
>  #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
> =20
> +/* Data Link Feature */
> +#define PCI_DLF_CAP		0x04	/* Capabilities Register */
> +#define  PCI_DLF_LOCAL_DLF_SUP_MASK	0x007fffff  /* Local Data Link Featu=
re Supported */
> +#define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchan=
ge Enable */
> +#define PCI_DLF_STS		0x08	/* Status Register */
> +#define  PCI_DLF_REMOTE_DLF_SUP_MASK	0x007fffff  /* Remote Data Link Fea=
ture Supported */
> +#define  PCI_DLF_REMOTE_DLF_SUP_VALID	0x80000000  /* Remote Data Link Fe=
ature Support Valid */
> +
> +/* Physical Layer 16.0 GT/s */
> +#define PCI_PL_16GT_CAP		0x04	/* Capabilities Register */
> +#define PCI_PL_16GT_CTRL	0x08	/* Control Register */
> +#define PCI_PL_16GT_STS		0x0c	/* Status Register */
> +#define PCI_PL_16GT_LDPM_STS	0x10	/* Local Data Parity Mismatch Status R=
egister */
> +#define PCI_PL_16GT_FRDPM_STS	0x14	/* First Retimer Data Parity Mismatch=
 Status Register */
> +#define PCI_PL_16GT_SRDPM_STS	0x18	/* Second Retimer Data Parity Mismatc=
h Status Register */
> +#define PCI_PL_16GT_RSVD	0x1C	/* Reserved */
> +#define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */

This looks correct comparing to the specification. However, this leaves
out some definitions, so I'm wondering if perhaps this should include
all field definitions. There are also extended capabilities between the
current maximum 0x1F and 0x25. Perhaps those should be added as well. I
guess this could always be done as a follow-up.

Perhaps it'd be better to change the subject to more accurately reflect
that you're only adding a couple of PCIe 4.0 features.

Other than that:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyvE14ACgkQ3SOs138+
s6Ggng/+LPX1tyWJWnSyBg/qhlXoB8rVsvcfYiZxFfoQUU9ypVHSw3HF57mMi1hp
mDEp6vuvrpBKQEl2BCLP4lAUsL0KapZQPW9Ox+94aKa+Y9V8Z3w7xOqQmWIC47To
lhh3sH9dY0Bwc3Oi9frJx/mBDV5OgDTMxA5a5oo5jizm/gJsWXiJnB8CqIYWcAhs
J5RsXBVT4Y5frrTW9M2zOFKW4b56hW8jieWjKZrbNfAh88CABo4VZMfGV95oJN0P
ADPAS3Bz9UsUleL/WN+kslx9I6stKOMN8dZTFio+sGSTnOEZXy72mBcyRMwjCOxc
G3JUtQE77u6I0h3h6Xomt/NBbAcfDxbJoQpUkt5MlfGZRXVaAixIS4UDjmJ895Vd
UwmhagN2T1eoukMk5Fz+hJ3yHcIWIMKeFAybQn8v3TBZQJCaCm6xuuDcfYqlLSP+
5TX2a+r5Z7hbRWo28pqgb0I3V2DZwLPwbTslm1ZJQO7nhbiaXAhZcWwsgGzwDX15
hiu6uQquNVkE2DjuPoXxQhhF+fRlwpFRdTMpK4OLH2GM8eZ4Z3djOif4Bfgd6Qzd
52ITNFL99A058QQ8Z1d8OaHe6fDOxufZhC7eR5kqrWl8/oWyzHsNgeqmYOVmm7lz
axjfiVTvpjdtFjrYCIzba2USCqyzQjZWS96YmuQHgA4WLwBOAzc=
=Wz/A
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
