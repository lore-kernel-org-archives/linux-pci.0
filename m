Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68638C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3489420825
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWjqVPid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfDOOXm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:23:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34067 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOOXm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:23:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so22240815wrq.1;
        Mon, 15 Apr 2019 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mKu4N9tE5ZOwsSL4ZaRp20InNVM/Y2tuh+h2msOQNag=;
        b=iWjqVPidNANuT7wjXUSQSvNxJ7nZ3x/x6fVAeLv4vmUGN4VxrKpFNrkfG3OLo36YJt
         JRhjhXsQEz1wFkwCKBnW+g4QXXlP4M8FCVDakmGBrEGamMoYnie2qcUU8tu89myK3qGy
         bA39zUb+TEvjqtRFcEBc5Qug+dScnV/ETwu+VbyWtnL16cVQv+rAZBpAK9OPBlhg6Xz9
         ApjmQNwzzE9kiOQJjPomANnWYHcQNBU/H4xWKWLczDcKkMqtQYHzZe225p/Ec5j7kQu1
         jjLbmp7KscHY2QX/WX5nUUf7CR7WNkkiWgaFOlJCuq8FfSyLrckjk74LIyu0vXplb+st
         jdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKu4N9tE5ZOwsSL4ZaRp20InNVM/Y2tuh+h2msOQNag=;
        b=io5Pju5AuEeUZa7lWOfeZ/mHENWGPbvTyBsfcB6xSMK8v17DT39yyeqt/n9xyq2xv7
         R/RuSVJ2wJoUU9yNpx5nRrrY2XQ2+sShO641caPRPN75WIxjIwH1YIvWkD/udnuJMIvk
         wkTIJ8tow8B7hsvGA9+QKlloqdOBez4pDVWhmkg2VvCt2w75nF4fSiR6LQkBkLbU8942
         r8wD34zHsUGskpLH1iefc137kb/3XUi0J36tYy846UtLpCJ9pyfrJKNSHgyQOEy4rQfC
         4s2TrLT4ZRCBYarKghrzGeeXHfd9P6335/MYSHSmmfi2umkHrNUnTZbVV40ERFzY/huv
         aByg==
X-Gm-Message-State: APjAAAVeRmqdIpVW83VEksvNiItf6ezEbH2Fe52j6pmAwyQKRhR0CBmG
        2goaTwt9r5nJyaOxe1011JGym/cP
X-Google-Smtp-Source: APXvYqyaax8tOIBaxJHAFE92m8SVvYQQXG7tqtKX0Uw/jvwg82KRYPZ9+Wj9eODprdNxcKvDotEyNA==
X-Received: by 2002:adf:b6a3:: with SMTP id j35mr45346993wre.25.1555338220213;
        Mon, 15 Apr 2019 07:23:40 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id o5sm16550249wmc.16.2019.04.15.07.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:23:39 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:23:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 30/30] PCI: tegra: Change link retry log level to INFO
Message-ID: <20190415142338.GD29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-31-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h+CsNYkJBPxpZ+B/"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-31-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--h+CsNYkJBPxpZ+B/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:55PM +0530, Manikanta Maddireddy wrote:
> Link retry log is info log not error, so change it to INFO log level.

The wording here is confusing. The log is clearly error level right now.
Perhaps you meant to say something like this:

    Letting users know that a link is down and in the process of being
    brought up again is informational, not an error condition.

Thierry

>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 75873e6627f9..55f8ff4f3e07 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2461,7 +2461,7 @@ static bool tegra_pcie_port_check_link(struct tegra=
_pcie_port *port)
>  		} while (--timeout);
> =20
>  		if (!timeout) {
> -			dev_err(dev, "link %u down, retrying\n", port->index);
> +			dev_info(dev, "link %u down, retrying\n", port->index);
>  			goto retry;
>  		}
> =20
> --=20
> 2.17.1
>=20

--h+CsNYkJBPxpZ+B/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0k+oACgkQ3SOs138+
s6HF4xAAhYxq+grGQlSr4fAbdgEZN6rFJZEAvpeu0/Gyo2tn2+yM84y+xhY7hR3+
FVpqMRcxg8NqUaFHcWaMsCB9lWYc2QinMbnaL3W6CiyndL2Vth0pZ8jX4ibU2lzP
MAlDg/349H0aIcbsnGadLfPgmDzxShM6dQtHcPBGRCoyGqWq9o+5e/4Z1vjW0/h8
W8oisFJiNuytJrb0oPT8quvWqF9iI/B5JeorSQ67Lj5B+eZSqOu/y1XQCduVZyhj
/dhPzBXpcP0bSHX3WtWX9f1WGFhiColFoQLc6fGKxC1HlDAMM7el84i5PhMHE30N
AVhV1bpOXCanmQ34snvabWEVitpdfmodbdIoVZZ9MQPyW6d8Zei4hp0TqPX8nGTI
lNvJgQ1LBtMapgDgg9+GTIyh+ShTNcbixyD1aA17+/cdU4Se1aTCh/QCBlAqUBez
Dwbg0/fSf6EsPnwG5EFdXyP34AXXZ3JN728EeSwsotB+Ttwm75Syu7AKesWWD183
XrrEIVcobUPbP8CibOyaeP2XVAYG8QRR3YaRvNyt/adx12axsD5cTjxWCYtQuxxg
D+cK7QqJxd/iV5liWIKYx001cN9cUFdxZeQSDg0B0bp0LFOOwNnz3TUyClwhpkdP
Gc0hVHATsjtOypnOqwSvC7TKTliUfvUyfC34tHkEACi/jkOFdFM=
=yJ4g
-----END PGP SIGNATURE-----

--h+CsNYkJBPxpZ+B/--
