Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAB36F8E5
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975989; cv=none; b=sfyPUUTRZdGMhZZ9xGPg+N0drcjcg5xybONZZj5Zk+X1mCUzQ9IRC9EuoaVIlsf/P0/es7dSoBOX694hqeCMrAp6ng0pFC4g+XsJAVbPVj36jFGmJ/i+yQ55AiL6uOuY0XPj7vDQ+4EFbo8kMBt83ClDnWhyEc11o4FstfITDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975989; c=relaxed/simple;
	bh=ZvYU5Yrxdfv3fDxI3PmN/Ky2G9fZPk1W5OF+6Kmx9Xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eaf6/AcsmEF++M2di0sJh+90l8dGiwANxAhn9Mju0MB5TLjZS2e0q1tw4cR8Z4VqbZU+UL2zQ8gVDXvr6miznDXH/HKyAKuk28PJnEuE1NceW2YW95+C33Y4FwdR6Yfottlyr6RWPZ9mcbijQyZoC7NGKxhkNOsrIHxRv55gJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKec/ASt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKec/ASt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCD31F0089A;
	Wed,  9 Sep 2026 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975988;
	bh=OZofwvOz3C3etnhDG3QVDyABx5DBrzkeapbW0Ba5uWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKec/AStIYU23kaMc3dY5KRsg/zxloBWYE/ky1iJxLzc+jgQ6eg8I6+uh1+LnJsNa
	 OPjxvzRPcXZCRgTSpCqkpLiCZSM1KkdaMUeQl0na+3u9y2u0yQdVwH3u/j+ldRRS95
	 bW2eT3cH9CipPIFwYxLu07UzinHujo4qYBqPNPKagYzUpJ3uzJEPMwcYU/CLciNgG+
	 8faoxTgrYz1sHvYovYfM2/oWTXr0ZwDR3W48zUiXqbCUNuEL/SKxjxnAqyCuZ65NCk
	 +CLmyNl6wnQJD+NG62NxlUeoLWEgE3o7pOSKgVOoiQKt0OKxSlsTG5tHaoE+TtiNtz
	 uAogo6Z0O2yEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rpaphp: Fix stack overflows when constructing DRC
 names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yudi Yang" <2000jedi@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260909173300.1144301-1-2000jedi@gmail.com>
References: <20260909173300.1144301-1-2000jedi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 17:46:27 +0000
Message-Id: <20260909174628.0DCD31F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack buffer `cell_drc_name` is passed to `strcmp` i=
f `my_index` is not found.
- [High] PCI devices added in `rpaphp_enable_slot` are not removed if `rpap=
hp_register_slot` fails.
- [High] `rpaphp_drc_info_add_slot` fails to iterate over all DRC entries a=
nd sequential elements, registering only the first slot.
- [High] Incorrect logical index calculation in `rpaphp_check_drc_props_v2`=
 when `drc.sequential_inc` is greater than 1.
- [High] The return value of `of_read_drc_info_cell()` is ignored, which ca=
n lead to uninitialized stack memory being passed to subsequent functions.
- [High] Missing cleanup of dynamically added PCI Host Bridge (PHB) or PCI =
bus when `rpaphp_add_slot()` fails.
- [High] Uninitialized struct member `drc.drc_type` is dereferenced if the =
`ibm,drc-info` property contains 0 entries.
- [High] Out-of-bounds read of device tree properties in `rpaphp_check_drc_=
props_v1` when `my_index` is not found.
--

commit 47e69de3a2a757ee69366336ebc5deb176f42fd1
Author: Yudi Yang <2000jedi@gmail.com>

    PCI: rpaphp: Fix stack overflows when constructing DRC names
   =20
    The drc-name-prefix field of ibm,drc-info is supplied by firmware and
    is not limited to fit within MAX_DRC_NAME_LEN. Using sprintf() to append
    a suffix can therefore overflow the stack buffers used for DRC names.
    Use snprintf() and reject names that would be truncated.

> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpap=
hp_core.c
> index 2316de0fd1982..39109a50fee68 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -252,8 +252,11 @@ static int rpaphp_check_drc_props_v2(struct device_n=
ode *dn, char *drc_name,
>  		/* Found it */
>  		if (my_index >=3D drc.drc_index_start && my_index <=3D drc.last_drc_in=
dex) {
>  			int index =3D my_index - drc.drc_index_start;

[Severity: High]
This is a pre-existing issue, but does this calculation correctly handle
drc.sequential_inc?=20

If sequential_inc is greater than 1, shouldn't index be divided by
sequential_inc to find the true index offset before adding it to
drc_name_suffix_start?

> -			sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
> -				drc.drc_name_suffix_start + index);
> +
> +			if (snprintf(cell_drc_name, sizeof(cell_drc_name), "%s%u",
> +				     drc.drc_name_prefix,
> +				     drc.drc_name_suffix_start + index) >=3D sizeof(cell_drc_name))
> +				return -EINVAL;
>  			break;
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but if my_index is not found,
the loop over entries completes without initializing cell_drc_name.=20

Doesn't this pass an uninitialized stack buffer to strcmp() right below?

drivers/pci/hotplug/rpaphp_core.c:rpaphp_check_drc_props_v2() {
    ...
    if (((drc_name =3D=3D NULL) ||
         (drc_name && !strcmp(drc_name, cell_drc_name))) &&
    ...
}

[Severity: High]
Also a pre-existing issue, but if the ibm,drc-info property contains 0
entries, the loop over entries doesn't execute at all, leaving drc.drc_type
uninitialized.=20

Can this lead to a crash when strcmp(drc_type, drc.drc_type) is called at
the end of this function?

[ ... ]

> @@ -355,7 +358,9 @@ static int rpaphp_drc_info_add_slot(struct device_nod=
e *dn)

[Severity: High]
This is a pre-existing issue, but of_read_drc_info_cell() can fail and
return -EINVAL.=20

If it fails, drc.drc_type is uninitialized. Can this lead to a crash
when is_php_type(drc.drc_type) is called here?

>  	if (!is_php_type(drc.drc_type))
>  		return 0;

[Severity: High]
This is a pre-existing issue, but shouldn't this function iterate over all
the hotplug slots?=20

It reads 'count' but only registers the very first slot in the first cell,
completely ignoring 'count' and 'drc.num_sequential_elems'.

> =20
> -	sprintf(drc_name, "%s%d", drc.drc_name_prefix, drc.drc_name_suffix_star=
t);
> +	if (snprintf(drc_name, sizeof(drc_name), "%s%u", drc.drc_name_prefix,
> +		     drc.drc_name_suffix_start) >=3D sizeof(drc_name))
> +		return -EINVAL;
> =20
>  	slot =3D alloc_slot_struct(dn, drc.drc_index_start, drc_name, drc.drc_p=
ower_domain);
>  	if (!slot)

[Severity: High]
This is a pre-existing issue, but if rpaphp_register_slot() fails, the error
path calls dealloc_slot_struct() but doesn't undo the device additions made
by rpaphp_enable_slot().=20

Does this leak the PCI devices and leave the system in an inconsistent stat=
e?

drivers/pci/hotplug/rpaphp_core.c:rpaphp_drc_info_add_slot() {
    ...
    retval =3D rpaphp_enable_slot(slot);
    if (!retval)
        retval =3D rpaphp_register_slot(slot);

    if (retval)
        dealloc_slot_struct(slot);

    return retval;
}

The same resource leak appears to happen in the v1 loop implementation with=
in
rpaphp_drc_add_slot().

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but out-of-bounds reads can occur
in rpaphp_check_drc_props_v1() when my_index is not found:

drivers/pci/hotplug/rpaphp_core.c:rpaphp_check_drc_props_v1() {
    ...
    for (i =3D 0; i < be32_to_cpu(indexes[0]); i++) {
        if (be32_to_cpu(indexes[i + 1]) =3D=3D my_index)
            break;

        name_tmp +=3D (strlen(name_tmp) + 1);
        type_tmp +=3D (strlen(type_tmp) + 1);
    }

    if (((drc_name =3D=3D NULL) || (drc_name && !strcmp(drc_name, name_tmp)=
)) &&
        ((drc_type =3D=3D NULL) || (drc_type && !strcmp(drc_type, type_tmp)=
)))
        return 0;
    ...
}

If the loop finishes without finding my_index, name_tmp and type_tmp advance
past the end of their property buffers. Doesn't this pass out-of-bounds
pointers to strcmp()?

[ ... ]

[Severity: High]
This is a pre-existing issue, but if rpaphp_add_slot() fails, does this
leak the newly added PHB because remove_phb_dynamic() is not called?

drivers/pci/hotplug/rpadlpar_core.c:dlpar_add_phb() {
    ...
    phb =3D init_phb_dynamic(dn);
    if (!phb)
        return -EIO;

    if (rpaphp_add_slot(dn)) {
        printk(KERN_ERR "%s: unable to add hotplug slot %s\n",
            __func__, drc_name);
        return -EIO;
    }
    return 0;
}

Does the same leak happen in dlpar_add_pci_slot(), where the newly added
PCI bus is never removed if rpaphp_add_slot() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909173300.1144=
301-1-2000jedi@gmail.com?part=3D1
