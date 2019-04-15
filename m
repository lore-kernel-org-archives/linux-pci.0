Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C15C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5308420833
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkytqJgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfDOLa3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:30:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35866 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDOLa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:30:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so19975768wml.1;
        Mon, 15 Apr 2019 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YUTp/dTmawYMxNFyqxP55xflmvzYKrX3u11B5OLhodc=;
        b=NkytqJgdNHRrrv78rAtB/Ds8j1iAkwvGytRaLjlO0PYhOnt5jDcEm4poWbCiZ5Dpk8
         4j2EUCr8yZssCgi5PyuRoZwfoSuT7NWZazk4HQKcgNKqQCYpWzv8YIrNOVBuelN+/xYk
         Q2AkcRKLBKOr7VJpy70ZqkAdY2tEViWpuASHuqVfIPwrXX4i53tfKAnzz/4mpAcBaPy2
         CwuITj1kOREijbwJEgpjv+5WWwbtmQ7Kq4PcDSXE+y3o5QAsSuTCAbIfggTzYkGFWF2o
         Yhaj6jCDBPrEkp0ODLCQa7LpVqENhqPMRBezPQZKZs4owkokN3MeF/Ps4r4UsOOUf6eQ
         s7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YUTp/dTmawYMxNFyqxP55xflmvzYKrX3u11B5OLhodc=;
        b=s6tlE01K5AG9BHRSvbqC3xt4BKjqnShZSx01pNMoFDVXyMWL+fVZaiZiL81eK4PcbN
         bG14BRx8fp+NoZhmDVORlcjbzm+rKgQDRC1XluyNGAOOazsD7Pg9WHIEGdnHBxzcB+cS
         zHhTFTNdMzBCbIY40yiqxQNLMKhSuaX/wEjOCrtOlu6/AU5J35PrMDBWUFBYcNIgMjLY
         bHi6JVPPESqqk5ibJ3ItaysnVlnUOpmef0S+BHfK4/pc0jBxYjBp2uenZd0+IYI2Oion
         y/rjAD8D+eOfg+7Qa+rwedXRHlNQyHA2u7X8HKcH6/CjOHFB2m2Dczf7aSDhtA1Fg8om
         cCew==
X-Gm-Message-State: APjAAAXcdxTXbVXhRopdnpnF8ngA3d4VEYdg0r3hKlcsRIkT0pR7QX7x
        o3sy7aB+7h2lIusPyE+UaUk=
X-Google-Smtp-Source: APXvYqyCsJ9yAxUdZHTTzx12vjDpRH/jpJ2VIZA2j4CbT9w11U5kBVVYyM/Q3oCoMg3qMPqi+Igc2g==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr21385232wml.73.1555327826957;
        Mon, 15 Apr 2019 04:30:26 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id x18sm18682791wmi.6.2019.04.15.04.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:30:26 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:30:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 07/30] PCI: tegra: Enable opportunistic update FC and ACK
Message-ID: <20190415113025.GH29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-8-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-8-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:32PM +0530, Manikanta Maddireddy wrote:
> Enable opportunistic update FC and ACK to allow data link layer send
> pending ACKs and update FC packets when link is idle instead of waiting
> for timers to expire. This improves the PCIe performance due to better
> utilization of PCIe bandwidth.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0a1EACgkQ3SOs138+
s6EClA//c3BkpNXqGgfWtua5UsJFYfVqeozrP97VI3dAucdMaQRCFH5lqY5N1vs6
4f9F4mpg1+EETSeEL3JeiXnw6nyE4+M/ghpMbf9dVEgWSbSb5Nwe2rqc2hnoW5jw
v3jl1iAtR6Q3DnKXBNEYtFdn2gQ8jN8mGskr00SrJ9wpkB2nbWZ2n76angR+L9qQ
HA3n0ICqbqITLpZcbp5lL0lNVyi0m9b7pQqx3TjS4GiSjCxpp0BbEFN1GDRianFJ
qweBOEHmXSofBOPhntnRHRQPAnhUbekv2swLlzIV7vSFBfmZX8HFcg48Wxg1zgeI
nZK72O63mwSRmL6abjO0prh5JEPT7ZE3a2pqu+puwi2iCYCKVa16EcN9U1xITL8K
1UG0Q6aGDE4/XOqqIJyyxj9BOcnNStIg8USDB/+7BKL+h2xVBGUI1mdQXhW/flKL
7gU+t2YNv5t22Tw1n6mDsFybbxOcwfE0KWQQdNxzEHCvmeZAW9b9PcQAssKV5I5X
BI6yYfSj36PybJTIOQzevg+W9F7IiG4lPvuah3pBiakaEDZjL6Y0R8YCcd0kQj5V
/nLFILOks7nXjjEmQxk05aszSOOHe22yvagRHxhgNyuXEQ2jGfV9Mo8RPLibZ5O0
AO08QUzzAIvRloydK3sXqyYqEKAQCpTz3gm4P6xhQeh5HLlsMaE=
=aPiO
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
