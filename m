Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4D46D086
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051360; cv=none; b=ASQTbpOtbJ9CdarzvEn3XqIEsPAGMSbIzIty7lzyDWuGd5h212owassdpZ/CbuQ5Htb3vtfDF3FviOakqqgFroZsEyPjUeqYu34dQW8ML5f1XtGdLusYxyrKJRXOH3VDoDylUc/KaBW2ald9+su44Sf+8jvQGhx0EphTgYHkc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051360; c=relaxed/simple;
	bh=KMXzO9+v3HYgkIKcg/xNuWVUld+raWdBXEOyg8akErw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O4rsobaoBWpjGdRlhGy78XSqFnbtdApCgnZm9jrZZ8vup8q/6JxD8JaB4liwLdisS0YJmt2zAqdYw+mNSEEb9aEPMJSVQR3QYiaDRR/wpPqR5Wsm7Go6BI/IQzYUCU/ghbHwt+YmAstOzEH75Dhe3I8WjyK26RiXoPv0E0F9R7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgOyHHIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgOyHHIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334761F000FF;
	Thu, 10 Sep 2026 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051359;
	bh=dSLlPCajdOXLpfuXJ09KAYyz3S1HV8GI7OcxY4/iF9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZgOyHHIfDgVWVewRogaUGVEXtS1GMDFWdiQYVq637thXduH9SXLd8TsZabuHN/BMB
	 ygSqR6nQ72+NGPhQnsio03eeC/NetUYB83TMq8TsGPEEd7NLd5w6rqxLchsyHzd2oM
	 TeDhpqmjlUlnLjIfnSMzTL4/LyLoSFfUgO3/EL0DectCLdnwfbpS5DE0iP8JlHsmlz
	 ObiBH05yOpY//iwzzhSIIiF6isodlxuFDncPcLqhxDHLdNGdJjgPU3qFiXtz7v96C3
	 vPXmZBtssQmKs1JAg8IDxSLIoSjZYSH2SgTwDMuVXjK4OFnFsanhP5KgWU71aCFbwt
	 aCP6b6Ie3xbOA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] PCI: Tolerate non-prefetchable 64-bit BARs in
 prefetchable windows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910143440.3865663-2-ardb+git@google.com>
References: <20260910143440.3865663-2-ardb+git@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:42:38 +0000
Message-Id: <20260910144239.334761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect Bridge Prefetching Check: The condition uses the child d=
evice's PCIe capability to infer bus prefetching behavior, allowing unsafe =
speculative reads on conventional PCI buses.
--

commit c6de2abeab7f85fbfb09d4554945da6aa13b56ac
Author: Ard Biesheuvel <ardb@kernel.org>

PCI: Tolerate non-prefetchable 64-bit BARs in prefetchable windows

This commit updates the PCI core to tolerate firmware allocations of
non-prefetchable 64-bit BARs inside prefetchable bridge windows for PCIe
devices. It bypasses the previous rejection logic by explicitly checking
the device's PCIe capability.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..e33eb9f3a1394 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -761,7 +761,8 @@ struct resource *pci_find_parent_resource(const struc=
t pci_dev *dev,
>  			 * not, the allocator made a mistake.
>  			 */
>  			if (r->flags & IORESOURCE_PREFETCH &&
> -			    !(res->flags & IORESOURCE_PREFETCH))
> +			    !(res->flags & IORESOURCE_PREFETCH) &&
> +			    !pci_is_pcie(dev))

[Severity: High]
Could this logic mistakenly expose devices on conventional PCI buses to
unsafe speculative reads?

If a system has a PCI-to-PCIe reverse bridge connected to a conventional
PCI bus, the reverse bridge is the child device and has a PCIe capability.=
=20
In this scenario, wouldn't pci_is_pcie(dev) evaluate to true in
pci_find_parent_resource?

If firmware maps a non-prefetchable resource of this reverse bridge into a
prefetchable window of the upstream conventional PCI bridge, this check
would allow the kernel to successfully claim it.

When the CPU reads from this range, the upstream conventional PCI bridge
will issue speculative burst reads on the conventional PCI bus.=20

Could this cause unintended read side-effects like advancing FIFOs or clear=
ing
read-to-clear interrupt registers on non-prefetchable BARs?

>  				return NULL;
> =20
>  			/*

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910143440.3865=
663-2-ardb+git@google.com?part=3D1
