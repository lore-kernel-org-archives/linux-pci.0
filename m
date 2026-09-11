Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66852F531B
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170461; cv=none; b=UrgJuLmdWeRM5RZqCUmHlZQsvgXHzslid4GF8MaJV6/8jjLs+NEQyiDn10H6k6zqbilIo/+Ac+JsRtoyRcuumPYtyAZuriAjqRwXlUA4qWR3UsqA7eoUo5RoBpF3rVEf3NJwRN2+FklFRZVGQ7tZJbWJHUvXXNP8MBQHYTo/jrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170461; c=relaxed/simple;
	bh=7jduGPasPjNZA7MYMMs1/1uI0BXVZYCz0mvZm4SQDqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YI0cG6iItCXcmAWc58WEMUnwp42F1erVw102lEASDTU/AAh0+tYbS2AovestNBb+jGSVtQgQgVESJciuif5j0qstluJwD5mjDi+9uoUmJF6l4R+GfNe+Om3d6X1Y/2WBqaGbpq+qydEu7aUPyRCV/2QaKlknIEvaEwxJVkcfFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCdZB0hr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCdZB0hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C1E1F000FF;
	Fri, 11 Sep 2026 23:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170456;
	bh=+dKBx72eZvm1Szss9jXHyUAtj/R4H+OfRfUj3q3B4g0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WCdZB0hrNWt1kZK5FM1Y2AoEh/CyhNV4emTTgRiiLHlUfR/au+d07ARGDafsIC0Rw
	 J0fkF7prBq1XKxq+gSi3NNpbkhMxASdAuQXSy9ebEjozj2G2XXpblxqERKzp+zaqTC
	 RByUXJXd1IP9u6DiDx0TmEym/tvw8GiWNoSbMvZIF9JBRjDHXBZ5AifwGT3EzE4+58
	 CIw3vR266hsGbjnCV9tyRgKk4EOPJY66d5CgNIcW3aNw7JTI9RicrLb/MY7YQNFT3R
	 Zn14DU8xtsKI8/f66lfgQ5hrazyvPLTPU03IfjLVJTqTYpIhhJv1Ysuh9XDpUSnGsG
	 U+41DZ97fKVAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] PCI: brcmstb: Declare and assign quirk
 OB_WIN_MAXSZ_128MB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-6-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:47:36 +0000
Message-Id: <20260911234736.89C1E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The OB_WIN_MAXSZ_128MB quirk handler silently truncates outbound m=
emory resources and completely ignores subsequent memory windows due to an =
unconditional early exit.
--

commit 6fb01c14c0bdf317322f341660866644991a983a
Author: Jim Quinlan <james.quinlan@broadcom.com>

PCI: brcmstb: Declare and assign quirk OB_WIN_MAXSZ_128MB
   =20
Even though only BMIPs chips have this quirk, it is more uniform and
readable to define this specific quirk where each outbound window is must
be <=3D SZ_128M.

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 71ddd8a760af9..401898d04d521 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c

[ ... ]

> @@ -1294,11 +1296,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  			return -EINVAL;
>  		}
> =20
> -		if (is_bmips(pcie)) {
> +		if (BQUIRK(pcie, OB_WIN_MAXSZ_128MB)) {
>  			u64 start =3D res->start;
>  			unsigned int j, nwins =3D resource_size(res) / SZ_128M;
> =20
> -			/* bmips PCIe outbound windows have a 128MB max size */
> +			/* PCIe outbound windows have a 128MB max size */
>  			if (nwins > BRCM_NUM_PCIE_OUT_WINS)
>  				nwins =3D BRCM_NUM_PCIE_OUT_WINS;

[Severity: High]
This is a pre-existing issue, but does this logic leave resources smaller t=
han
128MB unmapped due to integer division dropping the remainder?

Also, instead of returning an error like the non-quirk path does when the
window count is exceeded, oversized resources seem to be silently capped he=
re.

Could this lead to leaving some required memory regions unmapped?

>  			for (j =3D 0; j < nwins; j++, start +=3D SZ_128M)

[Severity: High]
This is also a pre-existing issue inherited from the earlier is_bmips()
implementation, but looking at brcm_pcie_setup() just past this loop:

			for (j =3D 0; j < nwins; j++, start +=3D SZ_128M)
				brcm_pcie_set_outbound_win(pcie, j, start,
							   start - entry->offset,
							   SZ_128M);
			break;

Does this unconditional break force an early exit from the resource iterati=
on
loop over bridge->windows?

If platforms define multiple memory regions in their device tree (such as t=
he
four 128MB PCIe memory regions in bcm7425.dtsi), wouldn't this break cause =
the
handler to map only the first resource and ignore the subsequent memory win=
dows?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D5
