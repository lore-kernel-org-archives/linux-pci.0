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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2090C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 10:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8FD2184B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 10:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2l9ojnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDKKRD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:17:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54635 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKKRD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 06:17:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so5977800wml.4;
        Thu, 11 Apr 2019 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RblycNJZFRqa7MldVoQZQ/Xu05FPCTLCvJAt4kE/QIk=;
        b=J2l9ojntHi2kFn4tdcHEN5Z2f06cSuYgQr4FzmgJNkP7h29iO1z551QJJTn8aFgpE9
         okthCZc9QP+bd3MC7fvB1vjWpinTTPnMs6Vg68yTcl+ccqSd/RKYdw//NygIbS/+OAyQ
         7UUWxMUnxJkjJKNqjGQ41KKQb1UpNdfU+6GwX2jYrYQ6I8shbjdrVar4sDO56Et85khQ
         l8Ggm+0MjRD0BnJTR2YqcdTIC+XD3lOR+zlOeVYsfE7SJrrFOPWib1zg6+jHrpHwTsvN
         +yYqEatBuen82xsrNsqvPWKGik3Z6zduNMdfnaiYyscotWQG6hCgG549QgV+OSeN4RYg
         szmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RblycNJZFRqa7MldVoQZQ/Xu05FPCTLCvJAt4kE/QIk=;
        b=FTtEZ6KwfZ4FWnO7yBsMsbyURbSuviezYuiwWwzSE16LaQrif84ryI6tX83GY6BNdF
         itVuVZyhkgvEXaxF0guWFeIv19+FBuPEoVexUS7PvDml0dl5BsGasRdTK+nHjditEnN8
         5apYJMhzjq+/L5yyaGWtEC14uuqc1ohkFULCN5q2WR+kCAtOkk7wa1pzLDIEP/q75c7y
         r8u809zZHl0JUIRv/oSrE16UKYambf2zog5bCJSfs5w/anJTYTNQ7tQ+0QKlZg3xjGaa
         kgEY/XxjgQGxquQmcjWRoyLfBDa2Ad6fQ9Kjz+lBSQY+JrzXvmdd3GsyfrJ1IctYcIXe
         YHWg==
X-Gm-Message-State: APjAAAXtXCEA3IR12W1YncAFn/SvoQhFSCRHhVxQjivvcXE1+PEwURMd
        9Zw7Q8A2hL4LL5gOmu2Vm+Y=
X-Google-Smtp-Source: APXvYqxEAhvPpOptFZA84zkR7+mvLRRjkp/ZckZdkMLy6BdfPtVk49xK2JQzRXHxi4zRVxDAGKoEIg==
X-Received: by 2002:a1c:9ec7:: with SMTP id h190mr6327161wme.105.1554977821269;
        Thu, 11 Apr 2019 03:17:01 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id o12sm40262711wrx.92.2019.04.11.03.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 03:17:00 -0700 (PDT)
Date:   Thu, 11 Apr 2019 12:16:57 +0200
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
Subject: Re: [PATCH V2 02/16] PCI/PME: Export pcie_pme_disable_msi() API
Message-ID: <20190411101657.GF4633@ulmo>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-3-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <1554407683-31580-3-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 01:24:29AM +0530, Vidya Sagar wrote:
> Export pcie_pme_disable_msi() API to enable drivers using this API be abl=
e to
> build as loadable modules
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes from [v1]:
> * This is a new patch in v2 series
>=20
>  drivers/pci/pcie/pme.c     | 6 ++++++
>  drivers/pci/pcie/portdrv.h | 5 +----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 54d593d10396..18e815c1e3c9 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -27,6 +27,12 @@
>   */
>  bool pcie_pme_msi_disabled;
> =20
> +void pcie_pme_disable_msi(void)
> +{
> +	pcie_pme_msi_disabled =3D true;
> +}
> +EXPORT_SYMBOL_GPL(pcie_pme_disable_msi);
> +
>  static int __init pcie_pme_setup(char *str)
>  {
>  	if (!strncmp(str, "nomsi", 5))
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 1d50dc58ac40..2be7b7e9a784 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -127,10 +127,7 @@ struct pci_dev;
>  #ifdef CONFIG_PCIE_PME
>  extern bool pcie_pme_msi_disabled;
> =20
> -static inline void pcie_pme_disable_msi(void)
> -{
> -	pcie_pme_msi_disabled =3D true;
> -}
> +void pcie_pme_disable_msi(void);
> =20
>  static inline bool pcie_pme_no_msi(void)
>  {

Perhaps also export pcie_pme_no_msi()? That way you could get rid of the
extern declaration of the pcie_pme_msi_disabled variable and make it
static to drivers/pci/pcie/pme.c?

Thierry

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyvFBkACgkQ3SOs138+
s6ELhQ//Vv9MKAZnJoNuinAuHN0VZpoVinl2xO7luTsHwQwXZxojinHPNU6svT8e
JG9n142d4+64x9LrpwAo2uK9Eur5502ru55knuDPX4f6R1s4zXjVKOSzuk5mgT/C
/tj/aBTsz5j1nONMk1JMDVdAmecEIMdxdqBu8ReXdDKWREn2e4X/1xMKC8lHkdTL
ykZid+SgzYB2S7h3edM7yUdvNbejZj6FEPfSmYHoFz4FU5TFV44KQdyCWWnLag45
eIfmeiiS5HUjC70a7hA+cEl5VzBaaVOnyb7upwk0+td4a27G5C1DjG9fimTa11ZE
JER7uYR5uspou0eAIYjUWMk2+ZVb83IOb/C5rx3G63c7ZZe5RFIZ6JMMZ5Xk8/B/
klY/NEDSZiTTFBbNKkaectjMYLbhZ958S3ysXBU8qTkJkApo7fzrWZMijyMliaXx
S87vCklXMTKXtXoxBjsEgwBCQsirwrHHlkgRCbwTpkr2P37AdMMSTB/J2jsj7pBH
ncmGzf4K61rsLlKvIu2OozM9u5zIGfI3t3NY3ZNG3vK9Do0R4HGCxhZWN/JxdXhm
QLCow0erxVPGJNNUSssiiIUyikMbmcB/ap7aI78yYZgj4jTOUhDMDBcCaj8IdluB
YRDVKLaRuwDb6vQ4i2u3y3z7Xg9/1zq0hSwpMeNry3AmsCA/EpY=
=IySS
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
