Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB498424D47;
	Mon,  3 Aug 2026 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781550; cv=none; b=PXM1O+9pj7a+nhuKuR4SkA+pOGlbJ13qK3GUgbDVZWiVwXnJWjNLsZBqG82z2DqmahJjf9XjOL9JP/r6jsYk80I/ieN4eD7/BCAKjxBu1m4MqqcT0KNTnA3/EoEAq5kgfY5+3EDdTPJXH/Gs7sGr/jrwVf7TkcZ1+YjID8auptk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781550; c=relaxed/simple;
	bh=Uy2dVPHpMEdRTZpjnvDX6UL4f0Iz/Ao1v1JPff3YeOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=POFnWP4yK0PDUjXoM20/72fztMkf1a54Az6PFXoWRg1xCctqa+XuKVOLxOtUUPkIanKDVEwU8N2EUNBUpQarnngvxSRbUJ1Vy+nNubU5MRjelNtZymldznPwFQgrJSjItcK7xmbkF+Yo0PbevpCsh7wwHIvi0m5kBDH6qlxM5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDJNOM52; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDJNOM52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3798E1F00A3A;
	Mon,  3 Aug 2026 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781549;
	bh=+ZnGg+Ik9cQm9twDKddt5rlDc2nmi4hjwRu5c1OUWuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDJNOM52Rz7RVuEbmfLtuKcJsI9mB5ynl1j8SPO4BcltvebP89e+Khpe73NH05Yui
	 FgxDMeGc/bvxnJdxy6cVkiV093XL1lOCiHTZ74PJupuou8UA9Eh+o+jY2Z4iKcIPrQ
	 IUR5HicrCvxPt5WXyiOTdf5mpaqTWikGXyWpDbc7l7vyiKBJVS1EPeENdsE+M1Kry/
	 DjvDcrK9QIWVy05gGyFJPDBu34uqep7fX3dcG95YZ9qeUqGtPxaAOJrufjnee31v18
	 QBpp3hTY0N+k5WrEBg3QcrJ0iFTbF5Tlcg668tFMGfznSIR2IWDcF/uNzDN/PzKNNf
	 HgBNzwKQVl03g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] PCI: endpoint: pci-epf-vntb: Add packed MW layout
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260803180439.1963864-4-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:25:48 +0000
Message-Id: <20260803182549.3798E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The packed_mws feature is entirely unreachable as it cannot be c=
onfigured by userspace.
- [Medium] Outbound ATU mapping is completely broken for packed memory wind=
ows due to explicit rejection.
- [Medium] Inbound translations for packed configurations are unusable and =
dynamically corrupt the shared BAR.
--

--- Patch [3]: [PATCH 03/11] PCI: endpoint: pci-epf-vntb: Add packed MW lay=
out handling ---
commit b1065455da6e47589efee078ad0c8d01095b3f1a
Author: Koichiro Den <den@valinux.co.jp>
PCI: endpoint: pci-epf-vntb: Add packed MW layout handling

Teach pci-epf-vntb to build a packed layout and advertise its logical
MWs as one version 1 translation group. Non-packed configurations keep
the version 0 layout and one MW per BAR.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index c3caec927d748..f22459e5a8c69 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> @@ -129,17 +132,27 @@ struct epf_ntb_ctrl {
>  	u32 db_entry_size;
>  	u32 db_data[MAX_DB_COUNT];
>  	u32 db_offset[MAX_DB_COUNT];
> +	u32 mw_bar;
> +	u32 mw_group_size;
>  } __packed;
> =20
> +struct epf_ntb_mw_layout {
> +	enum pci_barno barno;
> +	u64 offset;
> +	u64 size;
> +};
> +
>  struct epf_ntb {
>  	struct ntb_dev ntb;
>  	struct pci_epf *epf;
>  	struct config_group group;
> =20
>  	u32 num_mws;
> +	u32 packed_mws;

[Severity: Medium]
Will userspace be able to configure packed_mws?

It appears that there is no EPF_NTB_W(packed_mws) macro or a corresponding
entry in the epf_ntb_attrs[] configfs array, which means this field might
not be writable by userspace.

Additionally, looking at epf_ntb_num_mws_store(), it restricts num_mws to
MAX_MW (4), so the new EPF_NTB_MAX_MW (16) limit for packed configurations
cannot be reached.

[ ... ]

> @@ -227,13 +254,23 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb=
, u32 mw)
>  {
>  	phys_addr_t phys_addr;
>  	u8 func_no, vfunc_no;
> +	unsigned int count;
>  	u64 addr, size;
> -	int ret =3D 0;
> +	int ret;
> +
> +	ret =3D epf_ntb_get_mw_group(ntb, mw, NULL, &count);
> +	if (ret)
> +		return ret;
> +	if (count > 1)
> +		return -EOPNOTSUPP;

[Severity: Medium]
How will outbound memory windows be mapped for packed layouts?

If count > 1 is explicitly rejected here with -EOPNOTSUPP, and there is no
COMMAND_CONFIGURE_MW_GROUP handler in epf_ntb_cmd_handler() to manage packed
layouts, will the NTB host always receive a COMMAND_STATUS_ERROR when
attempting to map an outbound grouped window?

[ ... ]

> @@ -1656,6 +1838,7 @@ static const struct ntb_dev_ops vntb_epf_ops =3D {
>  	.db_vector_count	=3D vntb_epf_db_vector_count,
>  	.db_vector_mask		=3D vntb_epf_db_vector_mask,
>  	.db_set_mask		=3D vntb_epf_db_set_mask,
> +	.mw_get_trans_group	=3D vntb_epf_mw_get_trans_group,

[Severity: Medium]
Are the .mw_set_trans_group and .mw_clear_trans_group callbacks missing?

Without the group callbacks, the NTB subsystem falls back to using
.mw_set_trans (vntb_epf_mw_set_trans), which locklessly overwrites
epf_bar->phys_addr and epf_bar->size with a single segment's attributes.

Because all segments of a packed MW share the same BAR, won't calling this
for each segment continuously overwrite the entire BAR's inbound translation
and corrupt the mappings for all other windows in the group?

>  	.mw_set_trans		=3D vntb_epf_mw_set_trans,
>  	.mw_clear_trans		=3D vntb_epf_mw_clear_trans,
>  	.peer_mw_get_addr	=3D vntb_epf_peer_mw_get_addr,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D3
