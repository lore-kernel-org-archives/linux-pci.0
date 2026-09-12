Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0F2868AB;
	Sat, 12 Sep 2026 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789188158; cv=none; b=txH5iCamW7wur13+2k3M9/xIK+FzVFmLeL9ijGAtnBkcdMad93hkMCgGS+WwHhofcLnN/AnpSiPqn5KnmEtq9Wk8xEBZflJZYL9sUrefocK6UCbCbDBLGRcW5u5Rmtu1UGmvK1jJmR79Uuv5Lx668hx/ZBkWi/vXgLdiu+ABZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789188158; c=relaxed/simple;
	bh=yTO9OSTvjFkr7sdR5D+3UeqqsBhJT2AZXn7hakiE8xI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fxzKGxJf9/kAgTJGzIT6PrSyJ0Xsh0CtvmigvSAWb314BQlRNLVw9Y8l5qyYRCXNx/1n2kb2R4+NWSgPBvbxnnR9/t9f8OPs+4Q5yi9n187IHOeq3qMy3fdj8D30BFpkxa/tgjLF6F6g9VoUYCsv9JpnHGx1Wq7m89lHh0YGRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWI4ixwh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWI4ixwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4581F000FF;
	Sat, 12 Sep 2026 04:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789188156;
	bh=VNZTe9Xe+aZPNBcIUPlVnByCjnVY+Ig+eRF7EPKjzQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GWI4ixwh+uCBFXa6Fmwk4tfEu4skJV4ERquTjbjbygyZz9MHTzwTNLACE/8opem3D
	 sZzJNOG0neTiy2noQ/dBQw48Wdgv2f6q/Wj9wwiw60Tlgvd/RZp9TVARPu34akBO+R
	 Ub67nhJGmj9NkJiNZz+33CqiNbeXxkixlzbcsIOY87UROD7XXwuJ0EthIN2D2Y9/h7
	 35grDKvK0dqskkbdLIvsTmWZwJCu/ZzDdaWi+Clx7sZ3OEIS4e24H0IfVa5OyKb45f
	 f3xX/kOKaZ5dg7VpXjBPRovhMoXx95Vm8IWPkEVHjAt+kTboen4Cyko3I8JTFkW6FV
	 XeSoTgNMKKkOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: of_property: Omit bus properties without a
 subordinate bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Angel J" <iamanaws@httpd.dev>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260912043106.10715-1-iamanaws@httpd.dev>
References: <20260911230420.26244-1-iamanaws@httpd.dev>
 <20260912043106.10715-1-iamanaws@httpd.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 04:42:35 +0000
Message-Id: <20260912044236.3D4581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential kernel panic due to unhandled kasprintf() memory allocat=
ion failure in of_pci_prop_compatible().
--

commit ad6194f8ec3f58cf7279c3746e014412e0aad530
Author: Angel J <iamanaws@httpd.dev>

PCI: of_property: Omit bus properties without a subordinate bus

This commit updates of_pci_add_properties() to only generate bus-range and
interrupt-map properties when a subordinate bus is present. This prevents an
early boot hang on devices that satisfy pci_is_bridge() but lack a
subordinate bus.

> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 75a358f73e694..acd2e0f70f01b 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -361,13 +361,15 @@ int of_pci_add_properties(struct pci_dev *pdev, str=
uct of_changeset *ocs,
>  		if (ret)
>  			return ret;
> =20
> -		ret =3D of_pci_prop_bus_range(pdev, ocs, np);
> -		if (ret)
> -			return ret;
> +		if (pdev->subordinate) {
> +			ret =3D of_pci_prop_bus_range(pdev, ocs, np);
> +			if (ret)
> +				return ret;
> =20
> -		ret =3D of_pci_prop_intr_map(pdev, ocs, np);
> -		if (ret)
> -			return ret;
> +			ret =3D of_pci_prop_intr_map(pdev, ocs, np);
> +			if (ret)
> +				return ret;
> +		}
>  	} else {
>  		ret =3D of_pci_prop_intr_ctrl(pdev, ocs, np);
>  		if (ret)

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in
of_pci_prop_compatible(), which is called later in this same function.

Can kasprintf() return NULL here under memory pressure?

drivers/pci/of_property.c:of_pci_prop_compatible() {
    ...
    compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =3D
        kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
    ...
}

If this happens, the compat_strs array will contain a NULL pointer.
When this array is passed to of_changeset_add_prop_string_array():

drivers/pci/of_property.c:of_pci_prop_compatible() {
    ...
    ret =3D of_changeset_add_prop_string_array(ocs, np, "compatible",
                                             compat_strs, PROP_COMPAT_NUM);
    ...
}

Does the changeset API assume all string pointers are valid, leading to a
NULL pointer dereference in strlen() when it iterates over the array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912043106.1071=
5-1-iamanaws@httpd.dev?part=3D1
