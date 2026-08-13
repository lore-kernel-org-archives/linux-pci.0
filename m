Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82148CD5B
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640853; cv=none; b=EvDjCJlPwyUxBs27QYrAMYyvh7559WDxOyRK6lUfsSKMVFQX4f/ThNn6jKEeD80NnlJPk9WW2leKYmreoLYjrleqcwFJZhtZErMWRaNdPnpXGXupcyShepNEWsmYbz+zgjiE5v2guL9HGhP8iUAVCQwCMVhiuDmt+myRWbxGkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640853; c=relaxed/simple;
	bh=eCaZ/52uVLPYAYISBpk8C2EBeJ+AHDtyRB+9IKgs8yU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J8SCrzmya5jkBg5v/jekVCk+qK/XtYRWWQ87x3WpWNMrc4zymafsbQr15eez/eAHWkf1xz7nxY/xA9O+StOEW+JvjcbYnc16kYrfOlUA1i8fZf8Ln/dE0xNHD670G7lqtnV/YTBx6OKGsc3P7wPPCWdj4tkhDEIVSYUkSuXaaDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg9o0Yte; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg9o0Yte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E4E1F000E9;
	Thu, 13 Aug 2026 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786640852;
	bh=xwf7FC1AzMAi4aWb5KTsfubLsfXFduPDEy0FY/rQZUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dg9o0YteESn3e/C66bpnUEjQ1bXg+7Jj2709DJiY9CBXrrGcfi2EdCGH2+6rcwf3b
	 Psx0/T1J72cxQhlB/Il+CQT694HKSqqa4J5n0b1mqc4dOrQgtZYyWoW+l1+2K6/BtA
	 aEFhuLXhNjy4HwpUhD3V1/a/3v+XIH9CAA79omTWEgaC34nWRgnEY+dJzMhEaMxBr2
	 XYne4mkKzJyMjUC37Y1jIsJt/tg/0w+ccGSLdcOCIghqxgACwMqxenfzcfGSEsybAF
	 2XSExjYH9o3mTs327KmHenm/SV3BIxGD3VvWR2+4ekWzhAIqUpMS4TSO1Q7lwHWK7y
	 xvvH02NXZuzXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] rust: pci: expose the allocated interrupt type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260813165234.620555-6-dakr@kernel.org>
References: <20260813165234.620555-1-dakr@kernel.org>
 <20260813165234.620555-6-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:07:31 +0000
Message-Id: <20260813170731.C6E4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust_helper_pci_irq_type() causes a build failure when CONFIG_PCI i=
s disabled because pci_irq_type() is undefined.
--

--- Patch [5]: [PATCH v3 5/5] rust: pci: expose the allocated interrupt typ=
e ---
commit 60bd93f7488eb98904a6a089158302157e26da1d
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: expose the allocated interrupt type

This commit adds irq_type() on IrqVectorRegistration and IrqVector, wrapping
the new pci_irq_type() C function. It allows a driver to query the allocated
interrupt type (MSI-X, MSI, or INTx).

Link: https://lore.kernel.org/all/20260808031120.363869-4-jhubbard@nvidia.c=
om/

> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index e44905317d759..23b06becb4489 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const struct=
 device *dev)
>  	return dev_is_pci(dev);
>  }
> =20
> +__rust_helper unsigned int rust_helper_pci_irq_type(struct pci_dev *pdev)
> +{
> +	return pci_irq_type(pdev);
> +}
> +

[Severity: Low]
Does this code cause a build failure when CONFIG_PCI is disabled?

It looks like this regression could result in an implicit declaration error,
because there is no fallback stub for pci_irq_type() in the CONFIG_PCI=3Dn
block of include/linux/pci.h, and this helper is unconditionally compiled h=
ere.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813165234.6205=
55-1-dakr@kernel.org?part=3D5
