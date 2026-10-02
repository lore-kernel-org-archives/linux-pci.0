Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406926ED40
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941572; cv=none; b=gfY9nW62BnJe6sCIVeMSflxBmxwAC8xCIqCmbzbpl89xirNTIaWsH6ftjyRRi/V475RTtiMqUTDQGEFUs087xaFhmLqURpbJZBzEy79ovF8af1sZAt/2dQosWi4Y/RsVp0JwFr8OCVoEqI8a61Po2kqBjymeCE8fg39TtWRcrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941572; c=relaxed/simple;
	bh=3BWtXbyh3cVkYALlKIln34SAaH7YXs2Yix2nG8qWgr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VHUFnMDdaETkZzP4MXoYDf9QQRWmLuXFGGaBxv6LnIXp3Ip+F21+L6a+/LEn+uE2ymuzF00Cog0QLL0O+crwxN+4O5TeYVLxAyC/d0X74jDnfc5vb72RiFMrjhCymgY/DSy2jZmnW1hHWt9Ss+uR4/yHCbl+B9Ar9x977LJvg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8JpvvT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8JpvvT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197B21F000FF;
	Fri,  2 Oct 2026 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790941571;
	bh=aoLruiLdRgX4ClYKKgyDBnaedkHchCtWP7y35KcDqx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8JpvvT2UI/A1zXqc/ZupboGCFmj6gSZCQ0ztqfr2PQPi/4fGmkSkp+dbD3wdosp2
	 02wZGDt+4hZI8gFtnKA5uObWNUWnfs+szvOsoS+wHp0Npj2wWNHWL/+eeqjwy3aw59
	 jc00JT979t80M4B330CWr8fmnAMlMoRRdiIZn6pZm16Gl1OkmdVi2uFbuSQKtTp/BG
	 DkpAcMkLmnKaif33lbAzujhfTkxm1oVvAdEdU6MMGBTpnTfRHKh1096jacAyMIUZg4
	 poNpCPrDzL/EzeM9qvGzJ8UL967QKLuuPzynwpR6MtKjmyNKSFJPPNq3LfCJWq4ykL
	 xX2Ax4kWXUALg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] PCI: Place resources to either edge of the
 window
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002113319.6652-6-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:46:10 +0000
Message-Id: <20261002114611.197B21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: 64-bit truncation in pci_max_natural_size() on 32-bit archs
--

commit a3daecf300277b71086888c6fc930ab2932e9d1b
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Place resources to either edge of the window

This introduces a new greedy algorithm for PCI resource assignment that
is aware of window edges. It aims to avoid fragmenting the free space
when placing composite resources like bridge windows and VF BARs.

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 2ca3784aa323f..4c73bf6e0f706 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
[ ... ]
> @@ -262,16 +265,89 @@ resource_size_t pci_resource_alignment(const struct=
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
Does pci_max_natural_size() in drivers/pci/setup-res.c silently truncate the
64-bit size to 32 bits on 32-bit architectures?

If CONFIG_PHYS_ADDR_T_64BIT=3Dy is enabled on a 32-bit architecture and a
resource is >=3D 4GB, rounddown_pow_of_two() will receive a 0-truncated val=
ue
since it expects an unsigned long. Can this result in a shift by -1
(undefined behavior) and cause incorrect BAR size and alignment calculation=
s?

> +	natural_start =3D ALIGN(res->start, powof2);
> +	/* end =3D ~0 first overflows, then -1 brings it back */
> +	if (natural_start >=3D ALIGN_DOWN(res->end + 1, powof2) - 1) {
> +		powof2 =3D max(powof2 / 2, 1U);
> +		natural_start =3D ALIGN(res->start, powof2);
> +	}
> +
> +	if (natural_start) {
> +		*max_align <<=3D __ffs(natural_start);

[Severity: High]
Can pci_max_natural_size() in drivers/pci/setup-res.c invoke undefined
behavior on 32-bit architectures if the start address is aligned to a 4GB
boundary?

The __ffs() function expects an unsigned long. If the 64-bit natural_start
has its lower 32 bits as zero, this implicitly casts to a 32-bit zero, which
triggers undefined behavior in __builtin_ctzl(0).

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002113319.6652=
-1-ilpo.jarvinen@linux.intel.com?part=3D5
