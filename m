Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8BC383C8F
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991241; cv=none; b=qSU5+AmDfOxGlzGSrcLKuDlGgSg4oc2N92uTUztu0YBMBAU3m2mcFPURCd7nsT4UtY0oXXu5GF7UFM2Fux2DTajgO/iuSnWEjL1cEcNbW3b0SbiR5ew+RNfFhqWrjiD8MmRfhOSQUdzmPVnwqS8tsJ99oeUuBIM4Bovwyne4Bo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991241; c=relaxed/simple;
	bh=UyiZ5UoF3pfTh1wC/YCHyz9CcSrLD8lXOO6GJLYVi34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zkjr7Szy7CyBGtOxTjhsIIoAHWI1DEkN/J2eElnqzw4sUtQGqP+0UFGJt6jr6LDP4FvGIj9aFp2A153ZcOSjXmliLxu1h2RgfoY36aa8E3SlOpAi/g71VgTvgHOeebhvBSytIe7CanPeWKBGkBjo9HpnVmy+6t+OXOZy5d3S9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQSImUTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQSImUTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38F61F00898;
	Sat,  3 Oct 2026 01:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991240;
	bh=OmxQnWmV9689TQLbvXilExSmx+ceUDP6tZ+BrHvDWtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQSImUTWug6hBg4nzid48CkoxqF+pWhfF0w0EgfPbET2EFfJh33RfSAPOmXfwFk7D
	 DMAqIN3PKfEB/wDqqLLXBqwTCSCPyZrFAcHd8T26KeRRn9IXdqjW6m59j0HgQKDg+H
	 OHL+CxxsBfbN+2grdRQcISE5+VlLDQGT6oKjbOBlSwXxqi2JcWm5GOkagNtsjhH6CW
	 87Mn6XA7Kibbe+PMYOd2V5goB0lPbskUgycNUnYsbvWboGhFRgmipmQ8mXdbvOmmiy
	 PsbwhlqJv/7WdZJnWl4WD4/MucgYDYmSK4qxcpjKgc+0RKrqgvpvfE0E3z89ka/m7E
	 p62mz1rnC4ANA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 4/4] PCI: Centralize pci_aer_available() checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002211828.1293177-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261002211828.1293177-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:59 +0000
Message-Id: <20261003013359.A38F61F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pcie: stale host->native_aer enables AER after MSI is disabled
--

commit 905020873a7ae5dea6e2ab6198bde259d6bd9411
Author: Bjorn Helgaas <bhelgaas@google.com>

PCI: Centralize pci_aer_available() checking

This commit centralizes the pci_aer_available() check by evaluating it once
during host bridge initialization and storing the result in host->native_ae=
r.
This aims to simplify callers by having them only check host->native_aer.

> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 32fc623dd4108..9f8c6dd434c55 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -239,8 +239,7 @@ static int get_port_device_capability(struct pci_dev =
*dev)
>  #ifdef CONFIG_PCIEAER
>  	if ((pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>               pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC) &&
> -	    dev->aer_cap && pci_aer_available() &&
> -	    host->native_aer)
> +	    dev->aer_cap && host->native_aer)

[Severity: Medium]
Could this regression of removing the dynamic pci_aer_available() check
here lead to AER being erroneously enabled if MSI is disabled later during
enumeration?

Since pci_aer_available() requires MSI to be enabled, this code used to
prevent AER from starting if MSI was turned off dynamically. By relying
only on the statically cached host->native_aer, we might bypass that
requirement.

>  		services |=3D PCIE_PORT_SERVICE_AER;
>  #endif

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1e487a213eb0f..e1ca8096bcd58 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -670,7 +670,7 @@ static void pci_init_host_bridge(struct pci_host_brid=
ge *bridge)

[ ... ]

> -	bridge->native_aer =3D port_services;
> +	bridge->native_aer =3D pci_aer_available();

[Severity: Medium]
Does this regression cache a stale value for pci_aer_available() if a
hardware quirk disables MSI after the host bridge is initialized?

For example, during device enumeration, quirk_disable_all_msi() might
be called for a specific device, disabling MSI globally:

drivers/pci/quirks.c:quirk_disable_all_msi() {
        ...
        pci_no_msi();
        ...
}

If this happens after pci_init_host_bridge() has already run,
bridge->native_aer will remain true even though pci_aer_available() would
now return false.

The AER device could then bind to the already-registered driver and
erroneously enable AER without MSI support, potentially causing interrupt
storms or unhandled errors.

>  	bridge->native_pcie_hotplug =3D port_services;
>  	bridge->native_shpc_hotplug =3D 1;
>  	bridge->native_pme =3D port_services;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002211828.1293=
177-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D4
