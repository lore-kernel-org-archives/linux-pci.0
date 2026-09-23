Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44621328B71
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170130; cv=none; b=mUL+yE0SACKMP1qSnYT7gsdg5/Go41b7JpBevz3hfQfAYygZV4BY0DtoV51eIfpMHF+FX69M8sNemJ7mMOnW8B1ZMyD5m0ANEDziU/5Fz7yu0U1TSKro3bqR82ppNxkB6BDRFYWPr/xY7U9uozCmdpUkpkqWI2+kdyDPrpvBhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170130; c=relaxed/simple;
	bh=9/mMF4dgXqjaVi8U+4WsWrrrBQr7XnEhfy8ro6nmSxQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V+m0IpHwVwq/EgcGCQXnNWoE5uV/Augm+31AnoEdWc6vNHEfWBAfZigE71nEWUFrBJYc6MC57oEDu37TMYQjQehKki8jq6rqlcdz7lvcyz0oY/C7CSCPjUQJcYbz4rx61N4kI+P550CuqC+KOeTVqWXk83sUQ/2t969kkFKeu/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpt/UGZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpt/UGZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A451F000FF;
	Wed, 23 Sep 2026 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170128;
	bh=40ZH0o6vQEq3xGZyxGMqKfZn/8WT+xsP/Osu/TnJ1S8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qpt/UGZiXMn/uXt6LPwGx87bnTOaH+PVEQYSuJfQgKsL1D7e7RMTOuFQqmof8BkD4
	 kQy9qosDWTcAbmdVudDE727DXRRPgm0o7ocjqmeNF+eIF4Om9Ifmn7foGL2MbcyG5o
	 f8Fey3efN32oa0HlbHHlmxgh0LhFLy5Ee1+9/Lfr1KZ7PzRRn3VoHxqCU/osKmgxMP
	 KZPgIaD8T9+LwPMiUmUBi4PLnnCuobLCxu3eNyeNDfnh9/6S5s73E8LccRa1WKnS7+
	 uho9l9Sa/QiRMO/YjunvpEpB7H9aP6v/umLyfHvBK4ABMK3j86++ZLG2na3ZnT8PFA
	 FXp6q8nYLKYyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] PCI: Place resources to either edge of the window
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923131757.7792-4-ilpo.jarvinen@linux.intel.com>
References: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com>
 <20260923131757.7792-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:28:48 +0000
Message-Id: <20260923132848.B7A451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: undefined behavior from 64-bit resource sizes on 32-bit syste=
ms
- [Medium] pci: res->end + 1 overflow breaks natural alignment logic
--

commit 65c3dea851ed27dd4bf3576e0a9387eaa7359798
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Subject: PCI: Place resources to either edge of the window

This commit updates the PCI resource assignment phase to use a window edge
aware resource assignment algorithm. It alters the greedy assignment logic
to place resources either to the left or right edge of the window to avoid
fragmenting contiguous free space.

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index eacce9e2486bf..1ab5d167ab5c6 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
[ ... ]
> @@ -262,16 +265,80 @@ resource_size_t pci_resource_alignment(const struct=
 pci_dev *dev,
>  	return resource_alignment(res);
>  }
> =20
> +static resource_size_t pci_max_natural_size(const struct resource *res,
> +					    resource_size_t *max_align)
> +{
> +	resource_size_t size =3D resource_size(res);
> +	resource_size_t powof2, natural_start;
> +
> +	*max_align =3D 1;
> +	if (!size)
> +		return 0;
> +
> +	powof2 =3D rounddown_pow_of_two(size);

[Severity: High]
Does this code inadvertently truncate 64-bit resource sizes on 32-bit syste=
ms?

When a 32-bit kernel is built with a 64-bit phys_addr_t (like x86 PAE or
ARM LPAE), passing a 64-bit size into rounddown_pow_of_two() casts it to an
unsigned long. If the size is a multiple of 4GB (which is common for large
GPU BARs), the lower 32 bits are silently truncated to 0, causing powof2 to
be evaluated as 0.

> +	natural_start =3D ALIGN(res->start, powof2);
> +	if (natural_start >=3D ALIGN_DOWN(res->end + 1, powof2)) {

[Severity: Medium]
Could this boundary check overflow if the window ends exactly at ~0U?

If a 32-bit system maps PCI space just below the 4GB boundary, res->end
could be 0xFFFFFFFF. In that scenario, res->end + 1 wraps to 0, which
causes ALIGN_DOWN(0, powof2) to return 0. The check natural_start >=3D 0 th=
en
unconditionally evaluates to true for unsigned types, incorrectly forcing
the algorithm to halve powof2 and potentially failing to pack memory windows
tightly.

> +		powof2 =3D max(powof2 / 2, 1U);
> +		natural_start =3D ALIGN(res->start, powof2);
> +	}
> +
> +	if (natural_start) {
> +		*max_align <<=3D __ffs(natural_start);

[Severity: High]
Does this trigger undefined behavior when passing a truncated 64-bit value?

Similar to rounddown_pow_of_two(), __ffs() takes an unsigned long. If a
64-bit natural_start is a multiple of 4GB, the cast truncates it to 0.
Passing 0 to __ffs() invokes undefined behavior, which can lead to
unpredictable results or kernel panics during boot (such as garbage shift
amounts or arch-specific trap instructions on zero inputs).

> +	} else {
> +		/*
> +		 * Zero address has infinite alignment, return the largest
> +		 * representable number even if it's not a power of two.
> +		 */
> +		*max_align =3D RESOURCE_SIZE_MAX;
> +	}
> +
> +	return powof2;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923131757.7792=
-1-ilpo.jarvinen@linux.intel.com?part=3D3
