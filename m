Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9714C1C5D59;
	Mon,  1 Jun 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333920; cv=pass; b=VBjGcW32Z0GUCWOPVXyoiClBd/ueFMPoxGYozawcIkbc/FcAWx22zkKnZzCS/jb5KcVAZIqIqU41zJkLOJ6T3nwqAuetjeU2OOwGkmV4IIUsutaM6vpe1+lwccN76HJhmN3b4OLOlHIAWCMNFhqdIOW+HX54iylIokv+ai7XY4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333920; c=relaxed/simple;
	bh=+vpAGC1TrknMvw6II9rBnvMmuze1CMlemorsIDzcTVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCnwjM4PSr6LrpMrAyNfbYudYuVbjQ5mCbe9WPjzp94QLF2K+up8gHgUbTIDpUQlTXFReR5kq+Peey9/muW7JoMicIHmgh/jSLI4nq1BjkUChLWPx2NdNx7MJzFaKigceTreDhWvOODjK3ll1ccDjzF2wmVXRtD4Oh08N59ibK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=LvxK6DaG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="LvxK6DaG"
ARC-Seal: i=1; a=rsa-sha256; t=1780333909; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cPqMm6MFAaOqjeRtQeD9vFom2fv9R1LHK5B88lG1Yb3oQjLut6GJ/lOY2SZiPmR27dGCWgCVUrNNgq2EvBjAbp/u2jLx9t6XWt9ISNU9GsFe2UGOOuTAAoKx1WqdVM0VhfZ4yAdXskeg4e2wnt8FmFTO/WrCainY3vgYx5bJJdI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780333909; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K7gwx9C/HUvw/fTqWpU4x4aPbPrLxEmT/f32t4zgniA=; 
	b=MjP3NpL0NcnOgGnTfLUSkDrgjnjzemHHBTgW8VqNDsB0r9d63NSKnTTPl618/QiosDcJ2N4NT9xIAMv+uxPIl4pCNkbPUAo5KkL5besWTRW75GVS3JFTF1wIR40UEeOyAPFYdyZX0QlFzvKYQ1iPfRvSmRRUJir4pd01wV8IVQ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780333909;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=K7gwx9C/HUvw/fTqWpU4x4aPbPrLxEmT/f32t4zgniA=;
	b=LvxK6DaGGGADgi1E8QN7S8W7gqPX5Y6SwSSk+HpZH5mbVOPJxmz4TB//iV+8yPRL
	lUGAp48yWX9RJb3yuFjWEe8Ne9FHnkdeT7kQs9vMENGP/561h3uNZmWgwyPPysmtPPx
	2i5ETaglkoDd8eMdLly1ruTEwwQD0CCF9qVKY0cQ=
Received: by mx.zohomail.com with SMTPS id 1780333907831384.7342214677782;
	Mon, 1 Jun 2026 10:11:47 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 56500182618; Mon, 01 Jun 2026 19:11:44 +0200 (CEST)
Date: Mon, 1 Jun 2026 19:11:44 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, s-vadapalli@ti.com, a-garg7@ti.com, robh@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] PCI: dwc: rockchip: Use cached PCIe capability
 offset
Message-ID: <ah29IwxwHA49zjcZ@venus>
References: <20260530153101.695580-1-18255117159@163.com>
 <20260530153101.695580-7-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xrcaif7y2tqz375n"
Content-Disposition: inline
In-Reply-To: <20260530153101.695580-7-18255117159@163.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.325.56
X-ZohoMailClient: External


--xrcaif7y2tqz375n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 06/16] PCI: dwc: rockchip: Use cached PCIe capability
 offset
MIME-Version: 1.0

Hi,

On Sat, May 30, 2026 at 11:30:51PM +0800, Hans Zhang wrote:
> dw_pcie_host_init() calls .init before caching the offset. So inside
> .init we call dw_pcie_get_pcie_cap() to trigger caching. The helper will
> perform the DBI read (hardware is already enabled) and cache the result.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

> In pcie-dw-rockchip, the call chain is:
>=20
>   static const struct dw_pcie_host_ops rockchip_pcie_host_ops =3D {
>     .init =3D rockchip_pcie_host_init,
>   };
>   rockchip_pcie_host_init()
>     -> rockchip_pcie_enable_l0s()
>       -> dw_pcie_find_capability()
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 731d93663cca..be8b6187913d 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -369,7 +369,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *=
pci)
>  	u32 cap, lnkcap;
> =20
>  	/* Enable L0S capability for all SoCs */
> -	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	cap =3D dw_pcie_get_pcie_cap(pci);
>  	if (cap) {
>  		lnkcap =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
>  		lnkcap |=3D PCI_EXP_LNKCAP_ASPM_L0S;
> --=20
> 2.34.1
>=20
>=20

--xrcaif7y2tqz375n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmodvUgACgkQ2O7X88g7
+ppavRAAgzO4oIWAhjox77nH7xg6KSYq3DXvjysPT8Fa/CZX06VQeKyVtfNb/Bji
jGnkBAqMNg4xyCEELthusI004LfHWc7N56rc7nEot0NALtO1SLcyJxQdzUkcMmL5
eFHGaaWQ9KK9lANLVtuug1z2r6ZZA3OpxzIC2zhVbAgeSOjlF5w/6rFXkCMezN3a
k1qaMEe7KEtmyiVVg+f15t6TJfE8EkH377Elq7AdyeGUwEZUQBODLzx0VnOaT8Rd
DhTR+5/cwyZ4NtmMOHbI+ugAaiblnnxFWvzy4nU6ecfmy5YGB1zcym6vWnzMyapN
4QfpC/Cnj9YHewj72Hwmfjuyu+wuQLAIFdbLvHvVdieg8V/vrkFrUPRBc0gZUuQY
nnkrZP9/gr+sLcPzGRvA5joryW8/x+IIB3cPJvPG90zqqW9ryq3PI0S3KPO4NEfZ
5lUFuh3fq5t7PfhT4PNgQegTo9XfXXv2QbodY6MYCpJSb+k4XhPlfwyVsixMNBLb
5Gg+1Rnih4CChPXZuRGZ/vtM6/KeynBMO1qGJI5aTTYI1MrQK+6iZOq7G29PbHMH
/lkWS/jqgoaXMk9mEfbCxNm80U8IAtpA9U+luyx5MK7g74YoSva0c/1RfJhtSEk4
TEJk9Bhgt8ludWvRHXaupizagD+1iAldJqKWpLySy3C64DgYWdA=
=wteE
-----END PGP SIGNATURE-----

--xrcaif7y2tqz375n--
