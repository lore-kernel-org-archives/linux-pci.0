Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8B42AF89;
	Mon,  3 Aug 2026 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781411; cv=none; b=mzHxXOvTkG7+jjX4evogTvCSE0o+Pulh+o59ZQS7epVtjWsPrRqhHlq6D+XI9g3axMKO7t9o82S8TW+lWnoMZb/MolOKRrSTPsMC6XN/wE64iB7eqPDkP3hckOhbhZiHuMoK6jDq95UoIGo2aI68FEglpTb7n99CzoJLrZKx/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781411; c=relaxed/simple;
	bh=nb5XLmt8ots7cr3Ybf9IDMZB18i8psv2tvDR7PuCOIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eYIWfdpjr41WwK+ZUIUM3U1Zvxy+XkanhmyuLfab4tTlFqKg4RMrB3XViMJl8HCa0By/EiO32uJn4k7JmypvlVWdsNaqBlNhxbfbFdfpfwWCqmisevtORpUUmy75/8zpuRYMwKO9DAmHVJ2bg9NZX2TgubqPL06vd/EK3vxK2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftJ+C+nl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftJ+C+nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2A91F000E9;
	Mon,  3 Aug 2026 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781409;
	bh=Xx/vEphA+urhZe3JaLPF0EyHJEQG+k/5hOcBZRZ9JOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ftJ+C+nlHZIV9V6UPHNZISTGHImoh8cAldDk2W0bM6fOI++3/vEvQj4Rbix/LNEcL
	 tvDgjzE7zCcSDvRKDfqCz+sCP0NlruGlbtxLY3fW1D5HBFQ/aTUxR2Ew0Aunsnlnmj
	 Wx93hM5qylT3Z6mSpotLSh4+kZxvQCH1XHDq3Xs7pdd/topbUVjEtwFKKDBqI69Avw
	 gHJo64asNHV1vDBqL5zHxvL25SM0nRsqYnEh+A87j5CZvFwhZVSbwvVQZhM5BdzvTs
	 eFtcrTi7475ndyXO2dP4Ipmi/b3uimg+7TSOa57k3eRmb9WcVRFjQPyZDWIvl73K74
	 SgXRyNYXW99DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] NTB: epf: Parse a versioned packed MW layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260803180439.1963864-3-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:23:28 +0000
Message-Id: <20260803182329.4A2A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Missing `.mw_set_trans_group` callback breaks functionality for th=
e V1 packed memory window layout.

Pre-existing issues:
- [Critical] Untrusted offset from endpoint causes integer underflow, allow=
ing arbitrary host physical memory exposure.
- [High] Off-by-one bounds check allows out-of-bounds access and out-of-bou=
nds physical memory mappings.
- [High] Hardware command return values are silently ignored, masking endpo=
int failures.
- [High] Concurrent translation configurations race on shared endpoint conf=
iguration registers without locking.
- [High] Probe error path leaks PCI regions and I/O mappings.
--

--- Patch [2]: [PATCH 02/11] NTB: epf: Parse a versioned packed MW layout -=
--
commit 552e0bc5df4566e72805c5d6eadc9d96fa21be65
Author: Koichiro Den <den@valinux.co.jp>

NTB: epf: Parse a versioned packed MW layout

The legacy control layout cannot describe multiple logical MWs sharing
one BAR. Treat a zero version as legacy; version 1 describes all MWs as
one packed group using a BAR number and aggregate size. Derive the
equal-sized logical MWs from the existing MW count.

> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_=
epf.c
> index c47607d4f8a7f..46f37c2dea7b2 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -171,6 +179,9 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev=
, int idx)
>  		return -EINVAL;
>  	}
> =20
> +	if (ndev->ctrl_version >=3D NTB_EPF_CTRL_V1)
> +		return ndev->mw_bar;
> +

[Severity: High]
This is a pre-existing issue, but does ntb_epf_mw_to_bar() have an off-by-o=
ne
bounds check?

If idx is equal to ndev->mw_count, it bypasses the idx > ndev->mw_count che=
ck.

In legacy version 0, this accesses index 7 of a 7-element barno_map array.
In version 1, it calculates an offset equal to the entire base address regi=
ster
size in ntb_epf_peer_mw_get_addr(), resulting in a physical mapping address
exactly past the end of the region.

Could this allow the client to map and access arbitrary adjacent host physi=
cal
memory?

>  	return ndev->barno_map[BAR_MW1 + idx];
>  }

[ ... ]

> @@ -520,21 +560,27 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev =
*ntb, int idx,
>  				    phys_addr_t *base, resource_size_t *size)
>  {
>  	struct ntb_epf_dev *ndev =3D ntb_ndev(ntb);
> -	u32 offset =3D 0;
> +	resource_size_t offset =3D 0;
>  	int bar;
> =20
>  	bar =3D ntb_epf_mw_to_bar(ndev, idx);
>  	if (bar < 0)
>  		return bar;
> =20
> +	if (ndev->ctrl_version >=3D NTB_EPF_CTRL_V1)
> +		offset =3D (resource_size_t)idx * ndev->mw_size;
> +	else if (idx =3D=3D 0)
> +		offset =3D readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> +
>  	if (base)
>  		*base =3D pci_resource_start(ndev->ntb.pdev, bar) + offset;
> =20
> -	if (size)
> -		*size =3D pci_resource_len(ndev->ntb.pdev, bar) - offset;
> +	if (size) {
> +		if (ndev->ctrl_version >=3D NTB_EPF_CTRL_V1)
> +			*size =3D ndev->mw_size;
> +		else
> +			*size =3D pci_resource_len(ndev->ntb.pdev, bar) - offset;
> +	}

[Severity: High]
This is a pre-existing issue, but could the untrusted offset read from the
endpoint cause an integer underflow here?

The offset is read directly from endpoint-controlled registers and subtract=
ed
from pci_resource_len() without validation. If an untrusted peer endpoint s=
ets
NTB_EPF_MW1_OFFSET to a value larger than the mapped resource size, does the
unsigned subtraction underflow?

This could produce a near-maximum integer value for the mapping size, allow=
ing
an untrusted peer endpoint to map and access arbitrary host physical memory.

>  	return 0;
>  }

[ ... ]

> @@ -601,6 +647,7 @@ static const struct ntb_dev_ops ntb_epf_ops =3D {
>  	.db_vector_count	=3D ntb_epf_db_vector_count,
>  	.db_vector_mask		=3D ntb_epf_db_vector_mask,
>  	.db_set_mask		=3D ntb_epf_db_set_mask,
> +	.mw_get_trans_group	=3D ntb_epf_mw_get_trans_group,
>  	.mw_set_trans		=3D ntb_epf_mw_set_trans,
>  	.mw_clear_trans		=3D ntb_epf_mw_clear_trans,

[Severity: High]
Does the missing .mw_set_trans_group callback break the version 1 packed me=
mory
window layout?

Because this layout defines version 1 windows as a group, the framework enf=
orces
that translations must be configured via .mw_set_trans_group, actively reje=
cting
single .mw_set_trans calls by returning -EOPNOTSUPP via ntb_mw_check_single=
ton.

By failing to implement and export .mw_set_trans_group in ntb_epf_ops, is it
impossible to configure any version 1 memory windows?

[Severity: High]
This is a pre-existing issue, but do ntb_epf_mw_clear_trans() and
ntb_epf_mw_set_trans() completely discard hardware command return values?

In ntb_epf_mw_clear_trans(), the return value of ntb_epf_send_command()
is never assigned to the ret variable, making the subsequent if (ret)
check dead code.

This masks endpoint hardware failures and falsely informs the
framework that the window was successfully torn down, potentially causing s=
ystem
faults if the system reuses a window still active on the endpoint.

[Severity: High]
This is a pre-existing issue, but does ntb_epf_mw_set_trans() race on shared
endpoint configuration registers without locking?

The parameter registers like NTB_EPF_LOWER_ADDR are written without holding
ndev->cmd_lock, which is only acquired later inside ntb_epf_send_command().

If multiple processors configure different memory windows concurrently, cou=
ld
one thread overwrite the parameter registers before another thread sends its
command, leading to incorrectly routed memory windows?

>  	.peer_mw_get_addr	=3D ntb_epf_peer_mw_get_addr,

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the probe error path leak mapped reg=
ions?

Looking at ntb_epf_init_pci(), if it fails after pci_request_regions() succ=
eeds
(for example, during pci_iomap()), the err_pci_regions label disables the d=
evice
but omits calling pci_release_regions() and pci_iounmap().

Does this permanently leak the allocated resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D2
