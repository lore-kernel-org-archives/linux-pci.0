Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377C8C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0131C2147C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmF8110m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfDOPMk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:12:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33921 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfDOPMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:12:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so22470733wrq.1;
        Mon, 15 Apr 2019 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YUC0JOxqCvISdfR8qfTAc1Z41XP+YkOKy0a3JLf4K4U=;
        b=AmF8110mNpstvLeLLmsVPwxB6G8ZCCOHsM8X+h3qecp6FYWQusgoaMxQHKYLjOJz1D
         J4OUgD6jxGemCr31UA/IjAN+rliLK4JR9UuR3OVw70nZgdXY3xfp6CeOVQhGXWGRGmXI
         RcL1j3cKp8CnMJ0ro+eLguFfWqgTAOwF0NYnybhi9i2yKyQJ7y+kNzhJl/qBl6OSRsz9
         LoevMwaUh6lwDnnvyv8NzfRqU/nbfJct1VlLwuN7izT/hwmB7zOSJE7yKCoJal4LGpmu
         88hbwkP+fP5tUZB0n6MYu+Jxqefm/2cckcwUG5vVMgbB7NCESCxXkpAP3QJQr1DpMl9K
         WEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YUC0JOxqCvISdfR8qfTAc1Z41XP+YkOKy0a3JLf4K4U=;
        b=ZLIsc2NLg7zxVOL0AHg6iTgviN9RocmUJOg76DOl5VA71mxGVKtOzqyB8R+xtWNZHG
         /94t5xjH9WnGbOsK8qkY7RJChF51pKPwI3RyVg8oiATl7ASVelEqmqp4mRQJoxm+DITF
         yOljK6YfjVIvTZtaxBhE/EgM3nGcHdXOJv7CSMcj8MFTON+yXO/6a0Su5atqovafFMDW
         P3SoTDpBZYZ3butgsIQ8aUFT59se0gXVx91wQN5TMKa6gA8TE8Dds4uoaSByEchM1ofB
         pFtcuzQqZTEo81rGUtl8VEujL5xrcTt0t2H6rT6pufu9octgyygrOG9HYY45MwQcDFD+
         jgDA==
X-Gm-Message-State: APjAAAWLVvuQ7Kd//6Dt5Rpi2s62QnpQZj4XxxDjpSnoorScNvetSSsv
        poqIYq2ULYWhSb0o0sDizyE=
X-Google-Smtp-Source: APXvYqx+fUuy9h1W6ieAkqIfMCTqk1xe+KBE1p6H+Pgihsw3uQmRZZ3HgtPwgALM4u4N0NrH8MNIkA==
X-Received: by 2002:adf:f60e:: with SMTP id t14mr46283120wrp.39.1555341157051;
        Mon, 15 Apr 2019 08:12:37 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id b9sm26650365wmc.9.2019.04.15.08.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:12:36 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:12:35 +0200
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
Subject: Re: [PATCH V2 13/16] arm64: tegra: Enable PCIe slots in P2972-0000
 board
Message-ID: <20190415151235.GH29254@ulmo>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-14-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zVyz+SkbhTrRQGHt"
Content-Disposition: inline
In-Reply-To: <1554407683-31580-14-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--zVyz+SkbhTrRQGHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 01:24:40AM +0530, Vidya Sagar wrote:
> Enable PCIe controller nodes to enable respective PCIe slots on
> P2972-0000 board. Following is the ownership of slots by different
> PCIe controllers.
> Controller-0 : M.2 Key-M slot
> Controller-1 : On-board Marvell eSATA controller
> Controller-3 : M.2 Key-E slot
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v1]:
> * Dropped 'pcie-' from phy-names property strings
>=20
>  arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |  2 +-
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 50 ++++++++++++++++=
++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/=
boot/dts/nvidia/tegra194-p2888.dtsi
> index 246c1ebbd055..13263529125b 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -191,7 +191,7 @@
>  						regulator-boot-on;
>  					};
> =20
> -					sd3 {
> +					vdd_1v8ao: sd3 {
>  						regulator-name =3D "VDD_1V8AO";
>  						regulator-min-microvolt =3D <1800000>;
>  						regulator-max-microvolt =3D <1800000>;
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/ar=
m64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index b62e96945846..82eb30bceaa6 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -169,4 +169,54 @@
>  			};
>  		};
>  	};
> +
> +	pcie@14180000 {
> +		status =3D "okay";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_2>,
> +		       <&p2u_3>,
> +		       <&p2u_4>,
> +		       <&p2u_5>;

You can use multiple entries on a single line, especially if they are
this short.

> +		phy-names =3D "p2u-0", "p2u-1", "p2u-2",
> +			    "p2u-3";

Same here.

> +	};
> +
> +	pcie@14100000 {
> +		status =3D "okay";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_0>;
> +		phy-names =3D "p2u-0";
> +	};
> +
> +	pcie@14140000 {
> +		status =3D "okay";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_7>;
> +		phy-names =3D "p2u-0";
> +	};
> +
> +	pcie@141a0000 {
> +		status =3D "disabled";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_12>,
> +		       <&p2u_13>,
> +		       <&p2u_14>,
> +		       <&p2u_15>,
> +		       <&p2u_16>,
> +		       <&p2u_17>,
> +		       <&p2u_18>,
> +		       <&p2u_19>;
> +
> +		phy-names =3D "p2u-0", "p2u-1", "p2u-2",
> +			    "p2u-3", "p2u-4", "p2u-5",
> +			    "p2u-6", "p2u-7";

And here.

Thierry

> +	};
>  };
> --=20
> 2.7.4
>=20

--zVyz+SkbhTrRQGHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0n2MACgkQ3SOs138+
s6EKUg/8CuQgd9IJSKcSqBqVy1qkktbrZ2TyIU+Nz6bWffZLOjmQVPJ/k1r6oyEW
RTMkDFsBdstbWGnHahJN69f0EphUtoQrWVwUW8T2qaddvOF7QWiuQ7FRgwUOeRJL
Or7wH64G/6JXpUX5hpVk9tSRTIv0Kngy7lV86+SD4RcmaEtKEJ+BT1Ks86Ak0v5Q
5wUFKIsUo8Rem8PBxCWlsRvGRN6+DkvLrkvdkekOo3D1QmoLbST0iFzfdV+BSeCn
D6DB1RJKzYwC8Lbf2T4816Gn+CuzcqwL8Hi5NYoNswn9SKvyVBri+JpZs4ZFqzrI
Dk6APQhJllMBfDghXaFGIovjqJZAdML3vKrOXmbAoW4H9Uvsj2vF7gwT2PGKzPwo
XZjUaa9QZn4KQZpOAtCiRFfD4b2aeJdokEwCVdRzTLoYOsXr8dIrZ3Wf3t0J6YVp
uVfpY8z8h2Cke0fsO7qQu1FqVWYBvw0sDuB/s8YCR6gf7g5WDiioYJJVRtcF5P55
NxL/LuieA5u7nfsdk2SEXKmiDo8uRGVLiTDEPppvrNlQnEPKxUFA1ZViXFRIYyaF
uQNFoJ1S9jWOd28PaiW5ruTig3oXNoU8CRHt6d0cdbjvzWk+MXiBfaXQQ/b19L6N
qZj5tCrjVJ1ZQFSXWsbjXVaFBZprQw00r30B7J3lKGv2GSfBImM=
=euk7
-----END PGP SIGNATURE-----

--zVyz+SkbhTrRQGHt--
