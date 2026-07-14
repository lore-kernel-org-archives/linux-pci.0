Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC334B1B0;
	Tue, 14 Jul 2026 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028463; cv=none; b=T+lBTBpabJE4F7SihG2clKPKbKxZkuXqv07kLtxgeIssBnVRgTuMatcocMQeaagmkBoRCY+JpWWohAzXLznfr2EkLofQavsR0YWnt5xMbZ8OVsgizUzpu3K7tPGteN8HEVyCCl2Qt0K7fagt/tZVpINFAweqJdLaYe/aYZ8oSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028463; c=relaxed/simple;
	bh=WIscEXtd1Xqnyz566h7uM1L4UKvR987PGTeQx04U7gQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B4HppxYo4IC4u82LeFvC8DytOo4gltHAoAIT/4lw8F5aPOpdFxlaxTHrYFYVBCx73qECuK8nmMFsXt7c9uPolFdsmtzC2ef4KhzgYJkNIPDKJU5edpvdJf6pZhvs38nth+mwYSuRVF7QCb9ZhShaXnpUWQyRTH1KhSsSePyTRqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxcjeOYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxcjeOYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14E81F000E9;
	Tue, 14 Jul 2026 11:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784028462;
	bh=qO1uFesLR7pmRefvg20lCaJ7MaY6aULXYNpUwFKj8s4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxcjeOYgzeGsp6bYSgv/OEF+dZe5JAqOK597pKKr3lJfFbbTqlfQCfw1dbD7qzBk5
	 VLPJM0n3tuzxvQxGFq5xkiV6uoFE6ztOJlYYqm2tRdsEjuAAopz5Dbat22fNKcWsZh
	 VhkQrlgM8acElm+sONeQlOwYcoq3Txeo3ifQK2tRnsMXNwKlkc3d7cLKwqqjKhyFha
	 XcNNPPZ/eorLOZqSdN0r0x/tEosqfxrKJ448KZ03e24ul1P6Nvy81fkUJQqPABbsEZ
	 SkaoqRYh7sdK5VsO1lndbq2W8UTaRd+fpAjj0UndC7kWxwOI0OdSORrOb4VMeH6hcS
	 s9ZopOpTrIMYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 11/16] PCI/TPH: Add pci_tph_dsm_supported() helper
 to detect device TPH ST _DSM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260714104325.54444-12-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-12-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:27:41 +0000
Message-Id: <20260714112741.C14E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added `pcie_tph_dsm_supported()` helper incorrectly ev=
aluates the ACPI _DSM on the Host Bridge instead of the Root Port.
- [Medium] The newly added `pcie_tph_dsm_supported()` helper does not suppo=
rt Root Complex Integrated Endpoints (RCiEPs).
--

--- Patch [11]: [PATCH v20 11/16] PCI/TPH: Add pci_tph_dsm_supported() help=
er to detect device TPH ST _DSM ---
commit b4b5ff3a7f819f0fbddf034e29a0aa1c625cb893
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST _DSM

This commit adds a new helper pcie_tph_dsm_supported() to check whether the
root port of a given PCI device exposes the TPH ST ACPI _DSM method. The
logic is guarded by CONFIG_ACPI and returns false if ACPI is disabled.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 8194f8b45e3c6..e6a850ab2b037 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> +bool pcie_tph_dsm_supported(struct pci_dev *pdev)
> +{
> +#ifdef CONFIG_ACPI
> +	struct pci_dev *rp =3D pcie_find_root_port(pdev);
> +	acpi_handle handle;
> +
> +	if (!rp || !rp->bus || !rp->bus->bridge)
> +		return false;

[Severity: Medium]
Will this check fail for Root Complex Integrated Endpoints (RCiEPs)?

Since RCiEPs do not have an upstream Root Port, pcie_find_root_port() will
return NULL and this function will return false. Should this include a
fallback to check the associated Root Complex Event Collector (RCEC) for
the _DSM?

> +
> +	handle =3D ACPI_HANDLE(rp->bus->bridge);

[Severity: Medium]
Is this evaluating the ACPI _DSM on the correct device?

By using rp->bus->bridge, this fetches the ACPI handle of the Host Bridge
(the parent of the Root Port's upstream bus). Since the TPH _DSM is
typically placed on the Root Port itself per the PCI Firmware Specification,
should this use ACPI_HANDLE(&rp->dev) instead to avoid a false negative?

> +	if (!handle)
> +		return false;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D11
