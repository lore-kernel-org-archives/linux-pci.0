Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B339891E;
	Tue,  1 Sep 2026 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225691; cv=none; b=MOjmKL1BWN74fpctdn4vGKxa4PzVPMaRLyDzpEq8VHENAAbpF7ltDHVvf0SDdTnmkXukysD7T4w1LLU0d3NcYphyVsjRCUJNQ0yl9xyf0+zUawoJcIWX6e42wv2m/D58AmLr4wEtqhMG/jNYWpenij+2umznD1G737k43DAwKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225691; c=relaxed/simple;
	bh=2He7IRWhh/zVR54chcz4eyarVbby3ZlOpIJdLWTnaJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t6VcHzerGZc7hBqs96GgIyX9s+uaKtQ00aarh8oi2wUfTRVL1FyBu1QEhUwVAA+7ahb+6t51nUripv7fkUzPXYQOvd8TQ6P2dGalUR7jSr3NQMCcaP8KMev1tFLrBWiFyVHagsouYUWXd2V4TK6NYjX9ifom6X3I8yHdHc8p06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BboJtC+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BboJtC+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC6E1F000E9;
	Tue,  1 Sep 2026 01:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225688;
	bh=CAwwIUEe0fWa6gH7pJzyDofYOC3V+JfA8ibhWclLp/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BboJtC+FgciL+ZwZ27sfUpJLfjcrAotVBsI9wnC9/QjN3+N3slF2ojlOJ00wHMt/t
	 ljU5CrmMDRUAv3Bh6Yki4qfoWNC/6g18yqIpYsqXqSCKleeibGnsxR+9fyURAH1s6r
	 w57rqBRJxXktRRHJfCKHbCQhBp7qVrlE9ZX135AqBeYlYuiOuxnyrS9aI8Ld2uvT2u
	 NiDRNw3VLpkUDT3w2S6wYEXYv66hH2znMMkZEKTEITQyRDnVcyakrsLw3p+NmtiAe5
	 mdgFPK0/r5jGXgwwMjzDWSeJFC6zNHDxbXAVG8Q37MBWW9gOStBk+POpQ2gZndbZ9M
	 8zfk/i1WHKIYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] PCI: of: introduce of_pci_verify_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260901011338.1323243-4-elder@riscstar.com>
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:21:27 +0000
Message-Id: <20260901012128.2AC6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The check in of_pci_verify_node() falsely flags compliant CardBu=
s and PowerPC PCIe bridges as having an invalid device_type.
--

commit 72a980b9469901bec37d04c04dd8de642179aa44
Author: Alex Elder <elder@riscstar.com>

PCI: of: introduce of_pci_verify_node()

This commit introduces a runtime check to verify PCI devicetree nodes. It
ensures that bridge devices have the "pci" device_type property and that
endpoint devices do not.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a51dff91b196d..1838a3109514c 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c

[ ... ]

> @@ -1085,3 +1085,34 @@ int of_pci_get_equalization_presets(struct device =
*dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> +
> +/**
> + * of_pci_verify_node - Sanity check some PCI device node properties
> + * @pdev: The PCI device whose device node is checked
[ ... ]
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
> +	device_type_pci =3D of_node_is_type(np, "pci");
> +
> +	/* Bridges should have device type "pci"; endpoints should not */
> +	if (device_is_bridge =3D=3D device_type_pci)
> +		return;
> +
> +	dev_err(&pdev->dev, "PCI %s have \"pci\" device_type property\n",
> +		device_is_bridge ? "bridge should" : "endpoint should not");

[Severity: Medium]
Will this falsely flag compliant CardBus and PowerPC PCIe bridges as having=
 an
invalid device type?

The check in of_pci_verify_node() expects all bridges to have a device type=
 of
exactly "pci". However, valid PCI bridges can legitimately use "cardbus" or
"pciex" as their device_type property.

When a PCI bridge with one of these valid types is added, the following call
chain unconditionally triggers this error:

pci_bus_add_device()
  of_pci_verify_node()

This could emit a false dev_err() during boot on platforms using these
standard bridges, which might alarm users by polluting the kernel logs.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901011338.1323=
243-1-elder@riscstar.com?part=3D3
