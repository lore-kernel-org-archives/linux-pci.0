Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133201448D5
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546651; cv=none; b=F9EXKVv1d1DEEn+6fsySgvb3boTellha1Ogu4nNGK4NmCbDYRA6BSCwt/jDQPFmaI9baq1CRkZbDP0o6sj9p/AotUin4QEiXL7YTgUdrBs/xja1O4vMBWsVH1Ui4+mkXEVHiyIpKBfSd7fmIEYeX8RiHxA74IoiEMkuGDUJ/mB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546651; c=relaxed/simple;
	bh=4ZWkVf9u/8wTuDGHDpw7AcCFPqEWMtYG7dm6iFF8G2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FjsUtvi8mi/i9jcqLYX3PUhBka++ZOF0RNDyssXWC2N/vc4eNfBVdqq/A9OBUWAruwMNRCG+BgocSokmpnABMYsg+ZzQjoVIHhJ2qXA1YOFsfoqKkYM0oDEavYWOVBs7v5VgzhLWt3hhiGpk7IkvGalDPk9PKZ/LQDVZdhX9HGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG8fZuMM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG8fZuMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACB1C2BCB0;
	Tue, 12 May 2026 00:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778546650;
	bh=4ZWkVf9u/8wTuDGHDpw7AcCFPqEWMtYG7dm6iFF8G2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cG8fZuMM2ThIaFC3IsUGlHRouJFNkEyiVum4K/Di1+k8qslsbPX5c/OthAEfUN4jD
	 ck/LMjLSeTqvFxyDefkPYYSZqQZU3XKYBK7ZzdY4TI2AcAOYAJuoYZM2lv0TQwEBXr
	 CJ0eizmTvbVVlDQlJysO5LyJANnV5oUmNa9GZG0q3gz/z2WWfJUnHeL2mA31dFSuJ0
	 fgbh/lV4z64ZaKaUo4lqN6+GpazmjRmveFVNCkJYdOwGv0icmbqr28bwoglNRBltJw
	 d2CBJQ5C2HpulK8iFhEChDFVvIW0iOslUKNA+Eh5bgmWu039XO2kPt1UZRAxVGm08L
	 EzBpkxJeLj5ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] PCI: cadence: HPA: Add post-link delay
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260511055923.37117-4-18255117159@163.com>
References: <20260511055923.37117-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 00:44:10 +0000
Message-Id: <20260512004410.8ACB1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing device tree property silently disables the mandatory 100 m=
s PCIe link training delay.
- [High] The function `cdns_pcie_hpa_host_link_setup()` aborts the entire P=
CIe root complex probe if no downstream endpoint is connected.
--

commit 53fefd8ead01e523abe2d99bb9e1db2677c7f7ec
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: HPA: Add post-link delay

This commit updates the Cadence HPA link setup function to include a=20
100 ms delay after link training completes for speeds greater than=20
5.0 GT/s. It also reads the max-link-speed device tree property to=20
initialize the max link speed if it hasn't been set by a glue driver.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/dri=
vers/pci/controller/cadence/pcie-cadence-host-hpa.c
> index 0f540bed58e88..8ef58ed01daaa 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
[ ... ]
> @@ -304,6 +306,8 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc=
 *rc)
>  	ret =3D cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
>  	if (ret)
>  		dev_dbg(dev, "PCIe link never came up\n");
> +	else
> +		pci_host_common_link_train_delay(pcie->max_link_speed);
> =20
>  	return ret;

This isn't a regression introduced by this patch, but since we are modifyin=
g=20
this function, does returning ret here abort the entire PCIe root complex=20
probe if no downstream endpoint is connected?

When no endpoint is connected, cdns_pcie_host_wait_for_link() returns=20
-ETIMEDOUT. Returning that error back to the caller causes=20
cdns_pcie_hpa_host_setup() to fail initialization.=20

Could this break hotplug functionality or standard empty-slot handling=20
when the slot is unoccupied at boot?

>  }
> @@ -313,6 +317,7 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
[ ... ]
> @@ -343,6 +348,9 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
>  		rc->cfg_res =3D res;
>  	}
> =20
> +	if (pcie->max_link_speed < 1)
> +		pcie->max_link_speed =3D of_pci_get_max_link_speed(np);

If the max-link-speed property is missing from the device tree,=20
of_pci_get_max_link_speed() will return -EINVAL.

Will assigning this negative error code directly to pcie->max_link_speed=20
cause the post-link delay check to fail?

When pci_host_common_link_train_delay() is called:

static inline void pci_host_common_link_train_delay(int max_link_speed)
{
        if (max_link_speed > 2)
                msleep(PCIE_RESET_CONFIG_WAIT_MS);
}

Since -EINVAL is a negative value, the condition max_link_speed > 2=20
evaluates to false. This appears to silently bypass the required 100 ms=20
delay for Gen3+ speeds entirely.

Should the return value of of_pci_get_max_link_speed() be validated=20
before assignment?

> +
>  	/* Put EROM Bar aperture to 0 */
>  	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_EROM, 0x=
0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511055923.3711=
7-1-18255117159@163.com?part=3D3
