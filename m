Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4DC3B3C08
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104673; cv=none; b=jqip4p6C3ctNWbeh4hc68jMJQk3Iige6TptMkOKzRH5hqYiGbcsV4BFLoXu0ZiRxWbJXV56wCo6qa4CeltpQ/IiG3kVB46eQlwEHeUO0rH8QNtBsr71u8dbl8N56YbF/b2fbPFhrdgvqR1Vv1E4SM7/FkefresPVcqJdja1UL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104673; c=relaxed/simple;
	bh=rQ7mfB3EYi70QNZWf717Nf+rNM9jz7GMt/lQwiPA4lE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i2BNtkqSFeVVKAK8oVO2lZXxNwsrZ+f36IvOHOhZS2tLrdi9B2zRrPRPYOyVnw4LSBph8W5KTal/mp4+3pJzziXoJP5YI8C7SIIPq0fA1HaPuJSUGv3RRqxQ+DLyjGRZHXnCzg09PAauYL2Xu8IlKkMOIcQ5kar9qlv76Bq3Z1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN/VS9Jk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN/VS9Jk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FEEC2BCB0;
	Wed,  6 May 2026 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104673;
	bh=rQ7mfB3EYi70QNZWf717Nf+rNM9jz7GMt/lQwiPA4lE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WN/VS9Jk/EHmcSh0gcUIUbxAlpi3CMM4UXLY3q1VCDYIwD0IhF2y6ukIlLaRIMKWu
	 GKD3JLiL21oLVQpw1WkMst+ZgVtQ+PNsip6d8uqRcXSZNCWnoPhpdq38DQ9M+nZdPa
	 yE2jqFCxjr/ASpjhjJnO07PQlVu4Dug+AmYJxH2WfgSPeAD5bEibj6AV6V81tDR5xW
	 wJ70+uLQz7WzL8wHSZ98hxtZT7R9KOJQ23Kip08iMSA7wwCHC9ubylIRA1Zjjp7ELg
	 CRg9cegT89aIvnsw3P3CHccE1/b8+izuVFwUCmtEk8fbaRZKL4fQsTA6YPOyeyoNgl
	 EfQZQ3UAIvd1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
Reply-To: sashiko@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB4393E25E07CD496D60B994F4DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393E25E07CD496D60B994F4DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:57:52 +0000
Message-Id: <20260506215753.12FEEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unchecked NULL pointer dereference in `pci_dev_has_memory_bars()` =
when evaluating the upstream bridge of a Downstream Port.
--

commit ed8b20f412e18730ccf6172bf08ed537dfd42012
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

This commit adds enhanced ACS controls checks introduced by PCIe Gen 5 to
ensure better device isolation. It verifies specific ACS controls on devices
that support the PCI_ACS_ECAP capability.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0c15de0aedb2..b684ae4e92b5e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -3551,6 +3551,53 @@ void pci_configure_ari(struct pci_dev *dev)
>  	}
>  }
> =20
> +static bool pci_dev_has_memory_bars(struct pci_dev *pdev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i <=3D PCI_ROM_RESOURCE; i++) {
> +		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
> +{
> +	/*
> +	 * For ACS DSP/USP Memory Target Access Control, either Request
> +	 * Redirect or Request Blocking must be enabled to enforce isolation.
> +	 * According to PCIe spec 7.0, the DSP Memory Target Access is
> +	 * applicable to both Root Ports and Switch Downstream Ports that have
> +	 * applicable Memory BAR space to protect. So if the device does not
> +	 * have a Memory BAR, it skips the check.
> +	 */
> +	if (pci_dev_has_memory_bars(pdev) &&
> +	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) !=3D PCI_ACS_MAC_RB &&
> +	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) !=3D PCI_ACS_MAC_RR)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {
> +		/*
> +		 * The USP Memory Target Access is only applicable to
> +		 * downstream ports that have applicable Memory BAR space in
> +		 * the Switch Upstream Port to protect.
> +		 */
> +		if (pci_dev_has_memory_bars(pci_upstream_bridge(pdev)) &&

Could pci_upstream_bridge() return NULL here?

If the device resides on a root bus, which can sometimes occur in certain
virtualized environments or hardware topologies, pci_upstream_bridge() will
return NULL.

If that happens, would pci_dev_has_memory_bars() dereference the NULL
pointer when evaluating pci_resource_flags()?

> +		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) !=3D PCI_ACS_MAC_RB &&
> +		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) !=3D PCI_ACS_MAC_RR)
> +			return false;
> +
> +		/* PCI_ACS_URRC is applicable to Downstream Ports only. */
> +		if (!(ctrl & PCI_ACS_URRC))
> +			return false;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB439385689A=
32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D6
