Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024E3ACA7C;
	Wed,  8 Jul 2026 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507400; cv=none; b=QF+JRSKZLgVl/ksxFU/Q1EjQWQ5l+dGKaNKX3MuBNu1ytO1cRvhrMUdoatcBxTjSh/noTb7hRCYBsu8dFWqf3liATTBq/RQyDD2/WHdfKgJitIem2b7Uv+x8ITWd/GGd+VaBTqVT4dguvA3iiaiQ/hpDFYFIyTcljvdChSDiL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507400; c=relaxed/simple;
	bh=uJBOg5a1fncflhd9ukrVEW+8wu2g8Xfd+z7xobfQwPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EKrgFTKlsALc7Q1W0FFKr+5NdyGo0iZeTDHSx9G1i/MlTqCfR2Y+f1iqHp2QoSInx6B30BEO+BL3Js6Xs5GgsrtQBnAFVQmABJg884Xsn7OaPr37hjohxnzxbZ+LwU/Kb+YYmf0YGKSokG69xy70a26bSVwUO6vqs3Xyhoa7iHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfC9GLS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfC9GLS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3361F000E9;
	Wed,  8 Jul 2026 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507389;
	bh=pSs/U4SDImk2FjQuehMAS8/ghAonodc8RSsObJXlgwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfC9GLS3QTb7VIoc7ls0cJK30jlNhStUny6DLIcUEly4NZq/VwzYnOfBdhDT1GQuX
	 SWiA/a02nAj5ZhyOxRNpf++GR4dd+NIdZGn3uG/KYSFIEH/ShHNubRdA23aRCmuX6Q
	 Cj5VKuWJrfvWHWimZQXHXCfecAtEwHyn3qPqXpx92qzcI5i/+rtrN7dSuNyGf2SNkJ
	 SSB9tphQuf2Lukcawa5u/7G+KKCg9Ad7uohMU6G0ZJ5bi9naaaODQdmFgWigDyyUYJ
	 arjx7NRMxg8TtTjp9a+S/LDipwUKL6nq7R6ey94AO4w7aBCMg4ZaTIjgIocx/pn0ya
	 po1yf6epUHWsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 8/9] PCI: of: Set fwnode device of newly created PCI
 device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708100302.517792-9-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
 <20260708100302.517792-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:43:08 +0000
Message-Id: <20260708104309.0F3361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `fwnode->dev` pointer is not cleared in the error paths of `of=
_pci_make_dev_node()` and `of_pci_make_host_bridge_node()`, potentially lea=
ving a dangling pointer.
--

--- Patch [8]: [PATCH v9 8/9] PCI: of: Set fwnode device of newly created P=
CI device nodes ---
commit deed8a4ace1f4465ff17d82fc17dc458281c89a1
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Set fwnode device of newly created PCI device nodes

This commit sets the fwnode device field for dynamically created PCI
device nodes to prevent fw_devlink from incorrectly using the PCI root
bridge as a supplier. It ensures proper links are created by pointing
devlink directly to the PCI device.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 8dd558a490bbd..ca83006b7c7e2 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c

[ ... ]

> @@ -709,6 +710,13 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (ret)
>  		goto out_free_node;
> =20
> +	/*
> +	 * Set the fwnode device in order to have fw_devlink creating links
> +	 * pointing to this PCI device instead of walking up to the PCI host
> +	 * bridge.
> +	 */
> +	fw_devlink_set_device(&np->fwnode, &pdev->dev);
> +
>  	ret =3D of_changeset_apply(cset);
>  	if (ret)
>  		goto out_free_node;

[Severity: High]
If of_changeset_apply() fails here, the code jumps to the out_free_node
error path in of_pci_make_dev_node() without clearing the fwnode.dev
pointer that was just set.

If the node survives due to an external reference acquired during partial
application (such as from an OF_RECONFIG_ATTACH_NODE listener), could this
leave np->fwnode.dev pointing to &pdev->dev?

When the PCI device is later freed, does this result in a dangling pointer
and a potential use-after-free?

Should fw_devlink_set_device(&np->fwnode, NULL) be called in the error
handling path to safely undo the assignment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100302.5177=
92-1-herve.codina@bootlin.com?part=3D8
