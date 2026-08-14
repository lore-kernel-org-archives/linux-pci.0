Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50394908A2
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726658; cv=none; b=Iv3++SHrt9wi7BmXgjAwG2u13pTibMx9tWDfj3e+6qDobIMO3F9qGV77v4LlsVTf7WEO/8sOlSK8DtAAqgJTePKDfkC0WurirLreS5vdSqq8ive6zLSnewpzoN5QZ14KZ9oyyK6cqtoHsUL5vJcllO1gvSF6Mb3LcCNsiBEQvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726658; c=relaxed/simple;
	bh=jc8+4iJRGt3m8sBRzQ7rjxASiMEMGDryh0CT89MZOxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LxFmZE6MkSB6AHLFr1KIjpp61vg0klqg0cEUKrTB2LyDkSWrqd1tDGiT+3OYMO6bBqjMF8kfyKa3jjqvwpe6o8zujN99eg4tWLT4dv+Y1YnWc3H4STtgZAFqApHTetDsYfBb1i2aK8eQYeogicHgOMPmpSSCl6LrR/CKIfOA6/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN497ZlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN497ZlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E711F000E9;
	Fri, 14 Aug 2026 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786726657;
	bh=vkzEpzPLb2tB8cqiJguDFo3OmSfieYCVGMqYPd8G0y4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gN497ZlD/gm91PX7NvRvhvecdZGbfIGHrMypDQTQ2l/5KCR3j+Ur7wHbDEKboC+Is
	 +7xaMvuyVcb1V6A4BXpO0gvGZKiPf5rQPqcVwiUoprUN/RSC52zyGDP65Wrq662m2E
	 U/L/udV7f5lC35HvyMdIOOCkgIxuHQiHrGYfMWb2RHnJhUspnRuMzBiX1vXKxiRuNf
	 /gNR6rTmaGNzdpUtRO6SHDL31lXs8ehFFtgQHL+gPGgxKeegOSuZH8iAjuFeMMeNuJ
	 b1safe2+DVpaEk+cyVprf1bzf6l45PkXDmJY90cZebeTjMJpvnF3zRTME2+gO7bSp2
	 +KFzaWQPQIjTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: probe: Fix 64-bit limit truncation in prefetchable
 window
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814164652.43501-1-raizudeen.kerneldev@gmail.com>
References: <20260814164652.43501-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:57:36 +0000
Message-Id: <20260814165737.22E711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If a 64-bit prefetchable memory window is disabled via its high re=
gisters (`mem_base_hi > mem_limit_hi`), the kernel fails to propagate this =
disabled state and may incorrectly enable the window using only the 32-bit =
low registers.
--

--- Patch [1]: [PATCH] PCI: probe: Fix 64-bit limit truncation in prefetcha=
ble window ---
commit 83ac911fac4a068a7685be844df59a43a0825bcf
Author: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

PCI: probe: Fix 64-bit limit truncation in prefetchable window

This commit fixes a missing truncation check for 64-bit limit addresses on
32-bit platforms in pci_read_bridge_mmio_pref(). It ensures the memory
window is properly handled or disabled if the limit exceeds 32 bits, and
updates the error message to include both base and limit.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18d..0cf2d1d351467 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -479,9 +479,10 @@ static void pci_read_bridge_mmio_pref(struct pci_dev=
 *dev, struct resource *res,
>  	base =3D (pci_bus_addr_t) base64;
>  	limit =3D (pci_bus_addr_t) limit64;
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in how
disabled 64-bit windows are handled just above this code.

If a 64-bit prefetchable memory window is disabled by firmware setting the
upper 32-bit registers such that mem_base_hi > mem_limit_hi, the kernel
skips appending the high bits to base64 and limit64:

        if (mem_base_hi <=3D mem_limit_hi) {
                base64 |=3D (u64) mem_base_hi << 32;
                limit64 |=3D (u64) mem_limit_hi << 32;
        }

If the lower 16-bit registers happen to evaluate to base <=3D limit (for
instance, if both base and limit are 0), will the subsequent check at the
end of pci_read_bridge_mmio_pref() incorrectly succeed?

        if (base <=3D limit) {
                region.start =3D base;
                region.end =3D limit + 0xfffff;
                pcibios_bus_to_resource(dev->bus, res, &region);

Could this cause the kernel to incorrectly enable a 1MB window at address 0
instead of marking the resource as disabled, potentially overlapping with
system RAM?

> -	if (base !=3D base64) {
> -		pci_err(dev, "can't handle bridge window above 4GB (bus address %#010l=
lx)\n",
> -			(unsigned long long) base64);
> +	if (base !=3D base64 || limit !=3D limit64) {
> +		pci_err(dev, "can't handle bridge window above 4GB (bus address %#010l=
lx-%#010llx)\n",
> +			(unsigned long long) base64,
> +			(unsigned long long) limit64);
>  		return;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814164652.4350=
1-1-raizudeen.kerneldev@gmail.com?part=3D1
