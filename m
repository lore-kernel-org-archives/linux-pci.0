Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F03AFD1B;
	Wed, 20 May 2026 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267376; cv=none; b=B5EJGN7DlwXZ9GK1jYssOT5dHBgo1nuAJ5ys0ozieUN5TiMfY2XbTFqhB0ebGxHp+jLGXlOpxlRNFAw0Ze2BiUjHieqIOshKtNUMaVwP6IaR5TdhE2WzdvNk7v5yw0FX5HynWTqXEyWiG+ClQxYOkf4/BrBITXnk4LquWiPVRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267376; c=relaxed/simple;
	bh=SuqMA9SJ5IZjmL+9jNs9DzlqAxqRDC7vtlPVKFr2qjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nVeuBzTaOZ6ZNDCGJoFWY0I5r7fNdCn/ZoFPeXfJuxnGxGQzdlDq64kjqL49l9qP0B1dbj2eeJqi79vmF+U+Z7qHwS3g7GMo7RJXpD9t1azXo3G57Wx7ySOsA6WB7hms4F7GnIOG2U7CY7OFPzWhsYa6ERg4P7q5goDvX8Ts25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwy3bVYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwy3bVYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9052F1F000E9;
	Wed, 20 May 2026 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779267373;
	bh=r9KJxiWJIrStZnSusMULc7O7jauDe1SDXZXWq+Nb8Ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zwy3bVYT7E5swsXlz/mZB7PyqYpKpIkuSEg5EGr6dA5+Ey0CxOduwDNFd9IZP8Qs8
	 jz+fuQ5SSyoAtzhxu3gvKHLyhkPXbAf0pHMOdZo7usb5fhbI2OxVlYzdZwz0j3dOm8
	 eVYrcBjqMUrU3i+z/3w94p18HMUeOBxHSJ54L8M79ZF8GYdomYmQmGl+ZCTGBWAAYt
	 KOb4fOkpuSX9TIbqxgTdphwk57cfBvVlIbJ5MAP7nnOBrQAQhotT9tBn6pYXcd7F7R
	 U21aS0ZsWKLAUH1QQJdGI70R//0hCvXsEsx3iS+YTs5pQII6iZ9XojpdIY4HzsfspS
	 0eidCNcY8uuMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/3] of: Factor arguments passed to of_map_id() into
 a struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vijayanand Jitta" <vijayanand.jitta@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260520-parse_iommu_cells-v15-2-b5f99ad4e7e8@oss.qualcomm.com>
References: <20260520-parse_iommu_cells-v15-2-b5f99ad4e7e8@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 08:56:11 +0000
Message-Id: <20260520085613.9052F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional dereference of `msi_node` in `of_check_msi_parent` w=
hen it can be NULL.
--

commit d17879206927f3ee695759bc3559fd04a6a551ab
Author: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: of: Factor arguments passed to of_map_id() into a struct

This patch updates of_map_id() to take a struct of_phandle_args instead of
passing the target device node and translated IDs separately. It explicitly
separates the input filter node from the output arguments and transfers
ownership of the matched node reference to the caller.

> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index e37c1b3f87362..e63a43be6c4a3 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -796,14 +796,15 @@ static int of_check_msi_parent(struct device_node *=
dev_node, struct device_node
>  /**
>   * of_msi_xlate - map a MSI ID and find relevant MSI controller node
>   * @dev: device for which the mapping is to be done.
> - * @msi_np: Pointer to target MSI controller node
> + * @msi_np: Pointer to target MSI controller node, or NULL if the caller
> + *           only needs the translated ID without receiving the controll=
er node.
> + *           If non-NULL and pointing to a non-NULL node, only entries t=
argeting
> + *           that node will be matched. If non-NULL and pointing to NULL=
, it will
> + *           receive the first matching target node with a reference hel=
d.
>   * @id_in: Device ID.
>   *
>   * Walk up the device hierarchy looking for devices with a "msi-map"
>   * or "msi-parent" property. If found, apply the mapping to @id_in.
> - * If @msi_np points to a non-NULL device node pointer, only entries tar=
geting
> - * that node will be matched; if it points to a NULL value, it will rece=
ive the
> - * device node of the first matching target phandle, with a reference he=
ld.
>   *
>   * Returns: The mapped MSI id.
>   */
> @@ -817,8 +818,21 @@ u32 of_msi_xlate(struct device *dev, struct device_n=
ode **msi_np, u32 id_in)
>  	 * "msi-map" or an "msi-parent" property.
>  	 */
>  	for (parent_dev =3D dev; parent_dev; parent_dev =3D parent_dev->parent)=
 {
> -		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &id_out))
> +		struct of_phandle_args msi_spec =3D {};
> +
> +		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &msi_spec)) {
> +			if (msi_spec.np) {
> +				/* msi-map matched: use the translated ID and target node */
> +				if (msi_spec.args_count > 0)
> +					id_out =3D msi_spec.args[0];
> +				if (msi_np && !*msi_np)
> +					*msi_np =3D of_node_get(msi_spec.np);
> +				of_node_put(msi_spec.np);
> +			}
> +			/* msi-map present but no match =E2=86=92 stop walking */
>  			break;
> +		}
> +		/* -ENODEV: msi-map absent =E2=86=92 check for msi-parent */
>  		if (!of_check_msi_parent(parent_dev->of_node, msi_np))

[Severity: High]
This is a pre-existing issue, but does of_check_msi_parent() handle a NULL
msi_np pointer correctly here?

The documentation added above explicitly states that msi_np can be NULL if
the caller only needs the translated ID without receiving the controller no=
de.
However, if msi-map is absent, execution falls through to
of_check_msi_parent() with that potentially NULL pointer.

Looking at drivers/of/irq.c:of_check_msi_parent(), if the msi-parent
property is found, it evaluates:

	if ((*msi_node && *msi_node !=3D msi_spec.np) || msi_spec.args_count !=3D =
0)
		ret =3D -EINVAL;

	if (!ret) {
		/* Return with a node reference held */
		*msi_node =3D msi_spec.np;
		return 0;
	}

If msi_np is NULL, wouldn't dereferencing it via *msi_node trigger a NULL
pointer dereference? Should this be fixed to safely handle a NULL pointer?

>  			break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-parse_iomm=
u_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com?part=3D2
