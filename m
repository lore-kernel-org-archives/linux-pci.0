Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896233;
	b=z2QTBiwz1OtllLdMOk4VHg1GGEoxoqAdm0Yt9C+nBck8OmWYO2l5qZtBduv7g6F2vn3X
	 NpsrDpV3QSATLboxqD3pqIVUqOA8zEh3ENhvCWcGDP+9y+XO0Fu90l82evie5m9KlOPYo
	 8ffLqXsu7PAQMPDn5va1c6Oyw3H9z3/skTa39R1EvHkPOqbm9d2RYzDlX2Zww/V3sOlaA
	 8GWPPJ/8jO2LJst4/lGHAbeGFBlNcQVvy29e06+QygTUDXwa4YVenkEQS41Hf8pz6kfXk
	 3HwBFAex+0dxrYxoRiat0HaR9v2ShYMgiwCegnkKQPZT60rqo/NS1e1l0ZO955nHz8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896233;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LyVPz6LwSukuLvnMJGHH37PdzB/EW0tq0umc3WbV6zQ=;
	b=LsR22PpSWfym3hdRevhTZLyJBs3/2juTn+omBoQqIo8HXE0Mjb3RhfH+oOkQEjACWXYB
	 +DKMo9YX1pONGxywSYdx/80NEDg5fxr8F5CEVQmAkguqevgA+QEE7d/i+dazmU3K069Ga
	 INVLL5zKPLKZlgDuMNwLIM+nAwBlLrsJDFkcxzK2OPTFIWQcKmuDuqTfVcUe3TXvYdZb5
	 J6mZYYixw94L63xXKzvKyi91RpwcNebGmwxXqjtId7gvmrsPqr+LTyif3pwx3eHB/Zh9w
	 33ecV6R3AenrHAXO+OYoxViOc9Ie99X5gi1QjVM8SqgmYAsuxV84d0VnEDK2+YtCqkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFZdnvMa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F9606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFZdnvMa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931CD1F00919;
	Thu,  5 Nov 2026 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896232;
	bh=LyVPz6LwSukuLvnMJGHH37PdzB/EW0tq0umc3WbV6zQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFZdnvMak66jE2OQT7UotgCSn2RbzrRBleGaZMPrNxszmSV/3cbwzOPX3qt2+S9US
	 uPvovMHFQSaBTVNPpTK3kI9EjISfm4u8xGkUkFpvwPtGIJafWF41TKKN6jo9Hgyfdc
	 OuqHE3io92gUpaV9UK2ruK33FtGC6+/OzREQZFI+YxgyFedOIo3F+E2wCEwLbgDDkv
	 Opepk6mxodEE71GYDoN2ZxkJyThDJ84aCugY9rkqWlTxyF4HVG7lnSchiQjmvrTuJ+
	 dPx9B2QoOnOOIvZzKBbnQgTFR/qXy8EZCLhV2dFQgfm768cj/y9EXYawkhgjX3q8bF
	 x+uZSSyZqh0ew==
Message-ID: <sashiko-outbox-199499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] PCI: of: introduce of_pci_verify_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105153801.435566-5-elder@riscstar.com>
References: <20261105153801.435566-1-elder@riscstar.com>
 <20261105153801.435566-5-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:30:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI: of: of_pci_verify_node() defined outside CONFIG_PCI guard
--

commit 3ae9eba1c84ba51b7f2ee89655e65140eb2d2cd0
Author: Alex Elder <elder@riscstar.com>

PCI: of: introduce of_pci_verify_node()

This commit introduces of_pci_verify_node() and calls it from
pci_bus_add_device() to check that devicetree nodes for PCI bridges have a
device_type property of "pci" or "pciex", and that PCI endpoint nodes do no=
t.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a51dff91b196d..5a040ed836744 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -1085,3 +1085,35 @@ int of_pci_get_equalization_presets(struct device =
*dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> +
> +/**
> + * of_pci_verify_node - Sanity check some PCI device node properties
> + * @pdev: The PCI device whose device node is checked
> + *
> + * PCI enumeration authoritatively discovers what we need to know about
> + * a PCI device.  A devicetree-based platform will represent a PCI root
> + * bridge with a node, but otherwise devicetree doesn't typically include
> + * many PCI nodes.  Where such nodes do exist, experience has shown that
> + * the "device_type" property is sometimes wrong, so warn about that.
> + */
> +void of_pci_verify_node(struct pci_dev *pdev)
> +{
> +	struct device_node *np =3D pci_device_to_OF_node(pdev);
> +	bool device_is_bridge;
> +	bool device_type_pci;
> +
> +	/* Nothing to check if there's no pre-existing devicetree node */
> +	if (!np)
> +		return;
> +
> +	device_is_bridge =3D pci_is_bridge(pdev);
> +	device_type_pci =3D of_node_is_type(np, "pci") ||
> +			  of_node_is_type(np, "pciex");
> +
> +	/* Bridges should have device type "pci"; endpoints should not */
> +	if (device_is_bridge =3D=3D device_type_pci)
> +		return;
> +
> +	dev_err(&pdev->dev, "PCI %s have \"pci\" device_type property\n",
> +		device_is_bridge ? "bridge should" : "endpoint should not");
> +}

[Severity: Low]
Should of_pci_verify_node() be placed inside the #ifdef CONFIG_PCI block in
drivers/pci/of.c rather than at the end of the file?

drivers/pci/of.o is built whenever CONFIG_OF is enabled so that PCI endpoint
controller drivers can use the exported devicetree helpers defined after
the #endif /* CONFIG_PCI */ guard:

drivers/pci/of.c:
    bool of_pci_supply_present(struct device_node *np)
    {
        ...
    }
    EXPORT_SYMBOL_GPL(of_pci_supply_present);

    #endif /* CONFIG_PCI */

    int of_pci_get_max_link_speed(struct device_node *node)

Since of_pci_verify_node() is only called from pci_bus_add_device() in
drivers/pci/bus.c (which is only built when CONFIG_PCI is enabled), defining
it after #endif /* CONFIG_PCI */ causes it to be compiled as unused code wh=
en
CONFIG_OF=3Dy and CONFIG_PCI=3Dn.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105153801.4355=
66-1-elder@riscstar.com?part=3D4
