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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0FEC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F392087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9B1UW1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfDONhT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:37:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33731 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfDONhT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 09:37:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so22045186wrp.0;
        Mon, 15 Apr 2019 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2AWxSgrL61qdQYQQd0J3i3dmFjmKQGVfDlr56Xa9OS8=;
        b=P9B1UW1mT15HUND7oRr48Fatjoj5R6pUApUDKxyYngQ309tHGl2FmCx1tRNld0VI/y
         9DorJJ4iExhhTmwVi94jrUIS4Pna+lk68i78Mt91xWd4op65vE7Zo3jeJaoSMoYDtTXX
         iUW+TbKVQJhkb+skTTTQ8mkUh9fcdJDNh0+LWENgde2apSMFfjZHOeqyz9H5xMvxd103
         1CJaHEPC4z7AO9eXwGlnb0G0ar1LeIDksXLm+eu90MGEF7AjVNn70fHSCgpUBIBmQtEr
         1e7Vs986tjk1WeLo++GgtZqxpySrLy2MdCnBkaqbbvc2hZjL64PrtEOorzjA5C8ZpRGt
         QY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2AWxSgrL61qdQYQQd0J3i3dmFjmKQGVfDlr56Xa9OS8=;
        b=UavFr/pYtoK2xI1i1gjLZ033FmVe6d04Z0gfQkjyx8CbuZBsqXHstEvjL9LvaysHh2
         zHRzYbouzTstvLdbLAlDhX2ndEOlS+9TR2NBF+7vOeVVg1eQNdoMhFri8aNGNHb8Sxe3
         eWJUqN+56FX9j/aFyG7EhtQeZis49lghJtAe7zTDj9aSdPe91n0/LBp3Q+5ADzgigQf7
         sf1T7tD6QagmEj/o8jISjoDMWOyRPsv2XXQHjjx58nYG6Y6IkzWb+JT+uGkH9Qe5f9A6
         2w4gxnKGZMc/zP4JA9D/OmQJEZi60X4OOy4E9nyrnwWyzr2U5lyWPov9bkO0vAERx1gL
         LCWw==
X-Gm-Message-State: APjAAAWpdLj/hojNPhjNtgEPuefPVvkBVAXq77aug+z19q9X50kIloJg
        NClVydb7hpblMDCeKPhin7HrGi+n
X-Google-Smtp-Source: APXvYqxmWDqT/ngkhNbC8HnBSKSS+YAQu4ED1xk6HjmVfH2QQXwYiqMnb08eQusuleKmGMF5sa1/gw==
X-Received: by 2002:adf:f3ce:: with SMTP id g14mr12228040wrp.129.1555335437501;
        Mon, 15 Apr 2019 06:37:17 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id f1sm44368733wrt.87.2019.04.15.06.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 06:37:16 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:37:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 21/30] PCI: tegra: Add "pci" type check before parsing
 child device tree node
Message-ID: <20190415133715.GV29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-22-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SidV/bKy1CyabPX8"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-22-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--SidV/bKy1CyabPX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:46PM +0530, Manikanta Maddireddy wrote:
> Each root port is added as a child device tree node of PCIe controller
> node. These child nodes are parsed using open firmware PCI bus accessor
> functions. If the child node is not of "pci" type then device tree
> parsing fails. Add "pci" type check before parsing child device tree node.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 3 +++
>  1 file changed, 3 insertions(+)

Erm... what is the use-case that you're trying to support? Why would we
ever have children nodes that are not of type "pci"?

Thierry

>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 8fdc7934d4c9..d08a63132c77 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2197,6 +2197,9 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *p=
cie)
>  		unsigned int index;
>  		u32 value;
> =20
> +		if (!of_node_is_type(port, "pci"))
> +			continue;
> +
>  		err =3D of_pci_get_devfn(port);
>  		if (err < 0) {
>  			dev_err(dev, "failed to parse address: %d\n", err);
> --=20
> 2.17.1
>=20

--SidV/bKy1CyabPX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0iQsACgkQ3SOs138+
s6FUyxAAnkf01jh7+eaGARzrET2gB0JFF7X1kJ7PqoRi3aCw713hwZl800YqX9r0
3rHlnJHLbaezlo1IO25/YS1Z0rYpYxP5Ji6tI9y+XSOaFeBxDCd7a37YPUFzi9EB
mg5THpQenNc5oYQLxW6GeEdmSyTLvGaNnT6Eqlxighemb7WW2Vcnf7cMx5o566Dk
xXlpwiTCVuHVZstPiEUzLcxDw6iTLT1CQKzp3DQGOtCyf88B0IuuEOT1Mnp+co14
rGjYDQz/GzY7trOKv39lkMPO6jUKSz69tFjGbDiFHNX5iiU5ebKy906yi4vxivDv
o6/p33w0VpFQ+fFbyzKME9aNi+vcc2C8sBmrEhx+l/Igozr8F5x/s62ItNBVGgfT
LfdpwnU+L5UX83cH6LhoRbOJCfdBkGaRkKWRLzDig5rB37ShUaMDK8K2P4kY9lZp
IFg/jn+DElCZyjEOSCG2CyWES3Nqe718X1PU458x8A9pBHPOSsVhrgYYZl16DapA
BCdJ9UttI5vGTjmKR4j3yh7hIuZA50tcWZB7V5LE8XNdGrSRE/f+oQZnV0f1+Ug9
fVdojcg58HqXFdyn4uIVEPPRE+ZXdqx9dGuN0hXfI+Jfx16U8cV8LUtqDElZ4B4r
CwK5fgXx3jdGIVUopGuW7Cx9Mu7zZ5Q5xn0y3RXSVqoaNMh3+1w=
=2f7d
-----END PGP SIGNATURE-----

--SidV/bKy1CyabPX8--
