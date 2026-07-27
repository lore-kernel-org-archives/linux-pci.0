Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF23F7AA9
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147797; cv=none; b=H3nm6dH19OlEkraZgjIfrLKobwS5boXK4Exp9cOyUUMQ8WsTlulWbXSFfYflWE4xYlkPartC3iTveroy4pBsPtOJazUUjwhWXjdR2q0C1jK6yLUH6iMWikoNaW2gcf/8Wo46cM7rUm3qCH410DwZ9IY0GnFAMUqzIy0JvgIppog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147797; c=relaxed/simple;
	bh=XwO2PgBhFobKPnaQSZVShFbdkcqjEZJ7K76uMzGXyL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cRBpdcDXhnvAUHKn1O41RUEkMu79tzuCv/FZVb8AYrCyQm5ZiOggGUuQPcJZ/njvelN4c76xhhkviIzbhJNmQYc1TEXiSEB5BmDNI0RklfjqFZTk4crH0fAE5iYvdb4QvdqHHojXtlG+/97BU/jBzhP/AgHki3SQ5jSzSbKjTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arwxZJD7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arwxZJD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1061F000E9;
	Mon, 27 Jul 2026 10:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147795;
	bh=uLNjYQoE6kwMpyriWxOjJkYCQoa9C4NiLmnO+LLdGS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=arwxZJD7XD/KjncZCglpoWz0dETbIR8RWrBe/7VRQJXTrOWELnabH1KIbYAnhypYU
	 jLnanonITtra3/CfvARDJGh6Q7Q8IfpAMfzqEj3cRwdREr7qI65YKiJt4DaL7fBLAk
	 xfrniosDawhyyfOVumWbmcbaijjrE7Eh4k3kgLtvpYMHYYl3WMBkW+xgLR162YDiCE
	 lK9che1SeWT9f+iLHHS/6qsUXNwM2CpUXiZAiN1XtUFvfh9hgkKEPQlmFvxcIN2SEM
	 6b89EdPfolCmx2kAxealoybAe2F+ftFaLR2c5nM303V6zliWzpY/5yBe5hsCGD+7D4
	 Q1xATOx/VBRmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI: rzg3s: Propagate platform_get_irq_byname()
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260727095843.116950-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260727095843.116950-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:23:13 +0000
Message-Id: <20260727102314.BC1061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of chained IRQ handlers on error paths leaves dang=
ling pointers to freed driver memory, leading to a Use-After-Free when prob=
e is deferred.
--

--- Patch [2]: [PATCH v2 2/3] PCI: rzg3s: Propagate platform_get_irq_byname=
() errors ---
commit 682dcda0e92e75148db8e1626ef00a4a02243870
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s: Propagate platform_get_irq_byname() errors

This commit updates rzg3s_pcie_init_irqdomain() to propagate the original
error code from platform_get_irq_byname() instead of always returning
-EINVAL. This allows the driver core to properly retry probing when the
interrupt provider returns -EPROBE_DEFER.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 01488660ab081..f51b5d7c19983 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1019,7 +1019,7 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_p=
cie_host *host)
> =20
>  		irq =3D platform_get_irq_byname(pdev, irq_name);
>  		if (irq < 0)
> -			return dev_err_probe(dev, -EINVAL,
> +			return dev_err_probe(dev, irq,
>  					     "Failed to parse and map INT%c IRQ\n",
>  					     'A' + i);

[Severity: High]
This is a pre-existing issue, but does this direct return leave dangling
chained handlers if a subsequent IRQ fails to probe?

Looking at rzg3s_pcie_init_irqdomain(), chained handlers are iteratively
installed on parent interrupts via irq_set_chained_handler_and_data().
If platform_get_irq_byname() fails for a subsequent IRQ (e.g., returning
-EPROBE_DEFER for "intb"), the function returns an error without invoking
irq_set_chained_handler_and_data() with NULL arguments to unregister the
previously installed handlers.

Since this patch explicitly enables probe deferral, this error path becomes
highly reachable. When probe is deferred, devm automatically frees the host
structure, but the IRQ subsystem retains the chained handlers.

If the parent interrupt triggers before the device is reprobed, would
rzg3s_pcie_intx_irq_handler() dereference the freed host pointer and cause
a use-after-free?

It appears this missing cleanup also exists if rzg3s_pcie_init_msi() fails
later in the same function, and during rzg3s_pcie_teardown_irqdomain(),
which removes the domains but leaves the chained handlers registered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095843.1169=
50-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
