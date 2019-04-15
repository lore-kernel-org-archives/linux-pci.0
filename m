Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE2C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E30020880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTnt09zV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfDOOHx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:07:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43474 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfDOOHx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:07:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so17467359wrx.10;
        Mon, 15 Apr 2019 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8aQZnSy7gH5zeQJIB/y24sxD65Upa4zC8WGmQL+aeNY=;
        b=WTnt09zV4+cbKa3rDQiSsC4xFeQoMMyrJwS56gCiqk+rcx3MnidwuOPgsbAwxesu+n
         ZivldjReKsRJAB7aBXdYtfPOz7lXu0fr0Guq9Xq8Lu+fJgyRZ2jXYIM9Z2zGXYXCIToF
         JfUyVMwbXsttQERbRpKoxvl3FtyR4vLBp1KpEWOWGKVqcmmw0chOuDHANS2CCRhMQlE5
         dgBJoh3M8hlmWPcWUufDDV03qi4CsWZlLXuVYApOheWe62CkIPt0uWbQvMm0H301P3AD
         EsE+SoLs5/fx1fWwtoyKKxkjfD825cvrpZNH2YrKPIuAWuGzOpr6++6HEXKsb0hpyKic
         Wd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8aQZnSy7gH5zeQJIB/y24sxD65Upa4zC8WGmQL+aeNY=;
        b=NdoFdLOE73G2eahOvHzdX5V6ObSB0VBjcwkZZi5StKZpc6AqyTuyAea67ojyswnxKj
         QjJzQzC1QHqPKC1WTDLkjWpSTgBFAzAeqj7h2GIxHc9Xa2aBOlvUEQ6om2dygclQo0OD
         0XN5HD96n5CJmrqZ9O5jZXT8jofSAc4T++iFsL1b8B4tpOi7GutPu7RWXifpth2jKjwy
         LcWCClPV+SpG7WovRg6P0TETXzsSQKU5cFuIRjr2N/crDxo5SjM1enBQpCou6aVM6LMF
         6wjiISoSgyYuidNmNJexnNAbQX6VedJkZhuN17oP6MJKrEYIJ0oB7IhIfVRLpCQBo+fT
         caNw==
X-Gm-Message-State: APjAAAXrxSvcLhKIM0i7bxAe8ObymV3XU+ElMF8TBIqruvlQeMm+mGd7
        fWMUmNprvkcDw5rWgtg4MwI=
X-Google-Smtp-Source: APXvYqxJM2tZ5+KGcLRk6N07aKqnh5rrs0llwelKJXWgIzVyfzdkCYFvadCRkVy4/krOodNZYlmGYg==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr50516913wrv.19.1555337270845;
        Mon, 15 Apr 2019 07:07:50 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id e16sm72930922wrs.0.2019.04.15.07.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:07:50 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:07:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 23/30] dt-bindings: pci: tegra: Document PCIe DPD pinctrl
 optional prop
Message-ID: <20190415140749.GY29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-24-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I2k41U2G4dq8LTBU"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-24-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--I2k41U2G4dq8LTBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:48PM +0530, Manikanta Maddireddy wrote:
> Document PCIe DPD pinctrl optional property to put PEX clk & BIAS pads
> in low power mode.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt      | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.tx=
t b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index 145a4f04194f..fbbd3bcb3435 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -65,6 +65,15 @@ Required properties:
>    - afi
>    - pcie_x
> =20
> +Optional properties:
> +- pinctrl-names : The pin control state names.
> +- pinctrl-0: PCIe IO(bias & REFCLK) deep power down(DPD) disable state.
> +  In Tegra210 PCIe clamps are not controlling IO signals, so there
> +  is leakagae power even after PCIe power partition is off. Pass

leakage

> +  pinctrl phandle to allow driver to explicitly put PCIe IO in DPD state.
> +- pinctrl-1: PCIe IO(bias & REFCLK) deep power down(DPD) enable state.
> +  Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.

This is confusingly documented. Your pinctrl-names should list exactly
what states are supported. The generic pinctrl bindings already specify
how to define pinctrl states, so I don't think you need to describe all
of the pinctrl-{0,1,...} states again.

Also, looking at the driver you seem to use custom names for the pinctrl
states, but those states are really just the "active" and the "idle"
states, for which there are standard names.

Something like this perhaps:

- pinctrl-names: A list of pinctrl state names. Must contain the
  following entries:
  - "default": active state, puts PCIe I/O out of deep power down state
  - "idle": puts PCIe I/O into deep power down state

It then goes without saying that the phandle pointed to by pinctrl-0
corresponds to the pinctrl state named by the first entry in
pinctrl-names.

If you use those default names for the states, I don't think you even
need extra code, the pinctrl subsystem should be able to take of that
for you.

Thierry

> +
>  Required properties on Tegra124 and later (deprecated):
>  - phys: Must contain an entry for each entry in phy-names.
>  - phy-names: Must include the following entries:
> --=20
> 2.17.1
>=20

--I2k41U2G4dq8LTBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0kDIACgkQ3SOs138+
s6HHOw/+Jc2mbic/Ku1DnLSeFPLLEtrssAJMW9l090a4FdfhFqqfhpgHcDfVOrMH
gfAG2EEFbXmXbeOMcYXuNTBxBQuY/gBF14xGTFeHm+sQ/BIBzFIwWYd1i/nFtdnl
f8Dre95O3PvLWrx682tEkm+TGulukVfYyM9OQ+jI34djofo72W34uuewAB0dtjQB
7GQb+IgwwxOxosppm8iTM7UdHJLpHLB21cZdaig9DkIxNxh7l/aaUh96so0GZ6Y5
7QWqkuIHAy9jOArxccjFqQ4TPr1IQDyUNdcxuFYaWZ7ZIeGTubIMfAgGM4xyPx99
ppSCoQQHsuen1OoP7nvjlTDreYzNfI4AAfNcFw5OOW5qbmBqQO0PTvTMk4eFtAFZ
2iF1dv2yWazYzRXdNqxFYfUMo0hX41zsHwBf7KUfFEaX0BAImjV3LuVbUvSyXI7+
0bVcmE5Tk2AlomJq7Dg5540k3esjt1sYOxr1F1DwyQaQbzuO/uW+5VdREklA8AYU
7qC6nzTsPkTW3IKoIBqa2IhQ+3Qrh9a2WkeCL30w+2isdgaLyi1e6+my9GLugcGp
1luVT4x9enkUkM6ChNx8uJ+5H7R8O8isXwTH6wsB9dUz0Izo91tA/mi87JKy9mV8
9BFhD/xn7jM2Oml+YpCh11pAKBLfXQxuSfE+e/ss2Uij7AdemWo=
=BwQh
-----END PGP SIGNATURE-----

--I2k41U2G4dq8LTBU--
