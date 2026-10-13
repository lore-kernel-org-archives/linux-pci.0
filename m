Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D6538D72
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929610; cv=none; b=fF8+SpMD2Piya4NjYH+F/z63IgdCDTU4A3JwkySk1dPXbMbHFP8hsy8Ee1AVCi6TRaI4RPknlp/yLWgywDu4cgXKE6zJuYAcUz0P4emCyaCNZUtMFB+pThK5Ut3PObgcvEreDYKSVelM2Pn6/2sAs+D569q33z6En83arvvG1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929610; c=relaxed/simple;
	bh=If74zKh22I0Qt46x68K9vV9UXeZ8a8rW2J7nn4Ucf78=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cWwiOFYsxangq+Mtae9ujhAwSK3rZv8cAZgMCxErqm/MKWemVnrTgAkTZ1PVh8YWpLDhHqtHSNEJ7UeacCUoprPmVR5Q5MYjL2dKihPQ9vOVa1h7ZznG3CNGR64eJq26aeh3YTeI0aSQoixR9itJij4maQOf8Jhxt1AH5N39D5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4YthmHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4YthmHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66721F000FF;
	Tue, 13 Oct 2026 22:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791929608;
	bh=2dnsixepM/aUA/K4IQWJ7o/vLZhGAdTScRb72cgUDOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P4YthmHTKUXjGkpcvtjxHnenk4tCZd8o0CENEurQLWb1hlWc7eIH4WmA1/t6xSV89
	 tumDn/1PHAp1eGaklql6wTTf+n7x7flE1W2qOLfmdlGHz+HJeOmYbwqR41XHvSZ2st
	 RytUkYwMADbNqGWXZmopNNKZiM0mOfGKjF+7jHYklCYOj5a/uaQWgBC8Sbv+IKQOX9
	 OtxvShCZ4dDj9Iqu1a1iGz9JVX6KMPx/+6sRb/X/NWZIyATEhPuinBMcbCLjVRO9+y
	 bBwlLswZFuO33CIVo0/XPKIk+vH/t1K8BRoGmtWxAG5CvmYA0Zq1vbC36qsL+CY3DK
	 ddlbZwHY4aQUw==
Message-ID: <sashiko-outbox-170563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] PCI: iproc: Use the EROM outbound window on BCMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261013220421.1588051-3-bhelgaas@google.com>
References: <20261013220421.1588051-1-bhelgaas@google.com>
 <20261013220421.1588051-3-bhelgaas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:13:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pci: Module build failure due to unexported devm_pci_alloc_host_bri=
dge_release
--

commit c2644cb699f7409a55741efcebcc09fcf3cf19bd
Author: Bjorn Helgaas <helgaas@kernel.org>

PCI: iproc: Use the EROM outbound window on BCMA

This commit updates the BCMA driver to request the memory window from the
EROM rather than relying on the device tree ranges. It directly uses
pci_alloc_host_bridge() to avoid requesting all DT resources and adds
validation to warn on window mismatches.

Link: https://patch.msgid.link/20260807160526.379-1-strst.gs@gmail.com
Link: https://patch.msgid.link/20260912043626.437-1-strst.gs@gmail.com

> diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/contr=
oller/pcie-iproc-bcma.c
> index 593418c2bc3aa..1e258cd8fed4f 100644
> --- a/drivers/pci/controller/pcie-iproc-bcma.c
> +++ b/drivers/pci/controller/pcie-iproc-bcma.c
[ ... ]
> @@ -38,10 +63,20 @@ static int iproc_bcma_pcie_probe(struct bcma_device *=
bdev)
>  	struct pci_host_bridge *bridge;
>  	int ret;
> =20
> -	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	bridge =3D pci_alloc_host_bridge(sizeof(*pcie));
>  	if (!bridge)
>  		return -ENOMEM;
> =20
> +	bridge->dev.parent =3D dev;
> +
> +	ret =3D devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_releas=
e,
> +				       bridge);

[Severity: Low]
Will this cause a build failure when the driver is configured as a
loadable module?

The symbol devm_pci_alloc_host_bridge_release is defined internally within
drivers/pci/probe.c but doesn't appear to be exported via EXPORT_SYMBOL()
or EXPORT_SYMBOL_GPL(). Does directly referencing it here in
iproc_bcma_pcie_probe() lead to an undefined reference error during
the linker stage?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013220421.1588=
051-1-bhelgaas@google.com?part=3D2
