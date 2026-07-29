Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0133AB260
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361741; cv=none; b=eeeVuh4jl7U9OgW4liQjO+xxcrSYHRp/IH2V1nbs+mMZBzsQAlypKD35lcOlh4IozBZVxous6AnyQAM1N0s7DWQpDI3azZXNPLLMfSvQuE0mNDuCOmrbYpW4YXOjgEA+z5Yz4kVP8KlInEt390i4knIibWuY6kYkNHQhFgNT/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361741; c=relaxed/simple;
	bh=A0ekx1xKTTjvCrPHDYdf4rtTZibBMLxr+CEo7mvfKEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uWe3pehUCagzquwZ+Q/G/s66dBxQu9FrNHcfykFECvB2D+sRK1Jo+YvdyqTZJtI7rqMM5NUXrF9cH4xFFm39CFTMAbRhnQFcFbFNpTHyW1jr88u+WYmjLuMGyceXk1ec3TNRbkjZ71QtYu/KSuTOSzoJAZeabWU8V+YmowI6RPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRbQHaSc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRbQHaSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E2B1F00A3A;
	Wed, 29 Jul 2026 21:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785361739;
	bh=hLyWdqnBlJXKa3TUcf7D9RxIesK3YpwkxdQ1pOkLlkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRbQHaScQfPs2KuY2NY2WXbhpy1cqxadxeTIIm2eFok0pNVYpopPAW+tDNPaTEnLa
	 GIut6Zy5Bj8LIaN006kwaxUz+iB9LU1AyY1FDbnDOO8rXihmFIEd2Yq3wnFVyjYCOp
	 G6xKTXDh7qAaWzSgcJ0uvFHeCk8S1bymHruDaCox1OGSGZxZx0ujIsS7sZEpc40+cD
	 HlAhiOuB3sIsoKAxtmTuvXTkkmm2bvn9Kzkp7YuFj7JMgCWx04YDTOxy9XqIGJpg+w
	 f8Tb8mX9ohyG9z3oe7LywM/8739mV85mqJPKjAeS0X3bcFt8QQOoALVKniSRf8x1Uc
	 tjMrQCNPDr4HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix unmap potentially unmapping the wrong
 iATU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729213520.1187704-2-cassel@kernel.org>
References: <20260729213520.1187704-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 21:48:59 +0000
Message-Id: <20260729214859.B9E2B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unmapping the cached MSI iATU window without flushing posted write=
s can cause AXI bridge lockups.

Pre-existing issues:
- [High] The cached outbound iATU mapping for MSI interrupts does not track=
 the endpoint function number, causing misrouted interrupts.
--

--- Patch [1]: [PATCH] PCI: dwc: ep: Fix unmap potentially unmapping the wr=
ong iATU ---
commit f97e3684cb2dd4f7108472fedeb7f80a99737691
Author: Niklas Cassel <cassel@kernel.org>

    PCI: dwc: ep: Fix unmap potentially unmapping the wrong iATU
   =20
    The persistent MSI iATU mapping can conflict with the dynamic MSI-X iATU
    mapping, since they are both using ep->msi_mem_phys.
   =20
    If dw_pcie_ep_raise_msi_irq() caches the iATU mapping, and then
    dw_pcie_ep_raise_msix_irq() is called, it maps the same address to a new
    window/iATU.
   =20
    Link: https://lore.kernel.org/linux-pci/20260729051542.DC2741F000E9@smt=
p.kernel.org/

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 7d2794945704e..051b234260352 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1124,6 +1124,15 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *e=
p, u8 func_no,
>  		return -EPERM;
>  	}
> =20
> +	/*
> +	 * ep->msi_iatu_mapped means that an MSI target address is cached,
> +	 * unmap it first so that we can reuse ep->msi_mem_phys for MSI-X.
> +	 */
> +	if (ep->msi_iatu_mapped) {
> +		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped =3D false;
> +	}

[Severity: High]
Does unmapping the cached MSI iATU window here without flushing posted writ=
es
risk an AXI bridge lockup?

In a multi-function endpoint, if Function 0 raises an MSI, the write is pos=
ted
to the AXI bridge and the iATU mapping is intentionally kept active to avoid
unmapping while in-flight.

If Function 1 immediately raises an MSI-X, this unconditionally unmaps the
cached MSI mapping. Since there is no dummy read or flush before
dw_pcie_ep_unmap_addr(), the previous MSI write might still be in the AXI
bridge's posted write buffer when its iATU translation window is disabled,
which could violate hardware constraints and lead to a lockup or dropped MSI
writes.

[Severity: High]
This is a pre-existing issue, but does the pre-existing MSI caching logic
cause misrouted interrupts for multi-function endpoints?

Looking at dw_pcie_ep_raise_msi_irq(), the caching logic erroneously skips
iATU reconfiguration solely based on the target address and size, failing
to check for a mismatch in the requested func_no:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_raise_msi_irq() {
    ...
	if (ep->msi_iatu_mapped && (ep->msi_msg_addr !=3D msg_addr ||
				    ep->msi_map_size !=3D map_size)) {
		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
		ep->msi_iatu_mapped =3D false;
	}
    ...
}

If multiple functions share the same host MSI target address and size, the
second function to raise an MSI will reuse the iATU mapping cached by the
first function.

Since the DWC iATU mapping is programmed with the func_no of the original
function, subsequent MSIs from other functions will be sent with the wrong
Requester ID. This could lead to IOMMU faults or interrupt routing
failures on the host.

The struct dw_pcie_ep appears to be missing a field to store the cached
func_no to properly track this:

drivers/pci/controller/dwc/pcie-designware.h:struct dw_pcie_ep {
    ...
	/* MSI outbound iATU state */
	bool			msi_iatu_mapped;
	u64			msi_msg_addr;
	size_t			msi_map_size;
};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729213520.1187=
704-2-cassel@kernel.org?part=3D1
