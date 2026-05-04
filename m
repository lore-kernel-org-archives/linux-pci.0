Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E412E62A4
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880048; cv=none; b=Ta8AbqRmK5gCIhktjNSyEfUf+KtP8oMtKlEYbvmm+HJyeE5Cpl8Cav9h4OsytMcZIn3rDUhm81TgfkXcredgvQy/LI+0IbBsAVNYLu1X2J99ZvMdngZDWyzsfmVzltivEb9rdM01ViUJRlefQxHjR90NgAH9V/+GVbGt0ethD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880048; c=relaxed/simple;
	bh=nLpFKxxy96RsMsb4YVhVd7d+qnyjcU94pUM7BVaMUJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IcSnQHyf4ic64S/WW0DFEFnOAXqlQArCDcutzvG8NMvlO1gbv8Otr7f48SlSaFusvppgZLOmACJUIZY6hMonwybTsx3j3+BhT6QF1kw26ULnXCpHOmOLqpI4CZlz0vgFfj+7cZd3cDRjnLpAhorbvNIWp5XtwOVaIZkN0dzsNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4XmGl4I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4XmGl4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A35C2BCB8;
	Mon,  4 May 2026 07:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777880047;
	bh=nLpFKxxy96RsMsb4YVhVd7d+qnyjcU94pUM7BVaMUJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=u4XmGl4IrIzjJnDqirYIMm0GY88K0SLMj2h2ToRZ+M/5KSyOaIyn4rOFAKSY4seBi
	 kW8EuZARkVlKTNWOkPXgCJDpO0ALA0bqeEaEyturIT3I9cfehBHucbOQ4jsGWi+VQj
	 lkpI4PCisAVvwNptIT37Acp8JbDSMVBprNF38KosUXygBsCNvH5tO9i+CMX7hikc+E
	 CCu2fbjWR97DwkQ/ZPLJSZqKJHxoTvmJXbJlIpb2ZZRf7MzOcBXfMr9hje9yyktxhu
	 +b8UGBeKi2g9e6OcxGEoIHtVWjQV0tUnwjvI9+1WDXfexr1soNH63cfM5KB3usWddb
	 H3WPsCYEVyZXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] char: agp: amd64 - fix null-ptr-deref in
 amd64_fetch_size and related functions
Reply-To: sashiko@lists.linux.dev
To: w15303746062@163.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260504065441.99033-1-w15303746062@163.com>
References: <20260504065441.99033-1-w15303746062@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 07:34:07 +0000
Message-Id: <20260504073407.A8A35C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch masks a kernel crash symptom without fixing the underlyi=
ng broken error propagation in `agp_amd64_probe()`, allowing the driver to =
erroneously proceed without hardware.
- [Low] The newly added NULL pointer safeguards across multiple initializat=
ion and cleanup functions are mathematically redundant or structurally unre=
achable.
--

commit 97080eec153aeef89c2ae80f04042c9b13cb0fb4
Author: Mingyu Wang <25181214217@stu.xidian.edu.cn>

char: agp: amd64 - fix null-ptr-deref in amd64_fetch_size and related funct=
ions

This patch adds safeguards across the AMD64 AGP driver to verify that
node_to_amd_nb() and its misc pointer are not null. It attempts to fix a
kernel panic in environments without a physical AMD Northbridge.

> diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> --- a/drivers/char/agp/amd64-agp.c
> +++ b/drivers/char/agp/amd64-agp.c
> @@ -121,14 +121,16 @@ static struct aper_size_info_32 amd64_aperture_size=
s[7] =3D
>  static int amd64_fetch_size(void)
>  {
>  	struct pci_dev *dev;
> +	struct amd_northbridge *nb;
>  	int i;
>  	u32 temp;
>  	struct aper_size_info_32 *values;
> =20
> -	dev =3D node_to_amd_nb(0)->misc;
> -	if (dev=3D=3DNULL)
> +	nb =3D node_to_amd_nb(0);
> +	if (!nb || !nb->misc)
>  		return 0;

Does returning 0 here merely mask the underlying issue?

The patch prevents a crash by handling the missing hardware here, but this
still allows the driver to erroneously proceed without hardware. Should
agp_amd64_probe() be fixed to abort on cache_nbs() < 0 instead of just
checking for =3D=3D -1, so the error propagates properly when hardware is
missing?

[ ... ]

> @@ -187,8 +189,12 @@ static int amd_8151_configure(void)
> =20
>  	/* Configure AGP regs in each x86-64 host bridge. */
>  	for (i =3D 0; i < amd_nb_num(); i++) {
> -		agp_bridge->gart_bus_addr =3D
> -			amd64_configure(node_to_amd_nb(i)->misc, gatt_bus);
> +		struct amd_northbridge *nb =3D node_to_amd_nb(i);
> +
> +		if (!nb || !nb->misc)
> +			continue;

Are these safeguards necessary inside the loop?=20

Since the loop is bounded by amd_nb_num(), isn't the Northbridge descriptor
and its misc pointer guaranteed to be non-NULL if amd_nb_num() is greater
than zero? This applies to amd_8151_configure(), amd64_cleanup(), and
cache_nbs().

[ ... ]

> @@ -391,6 +409,7 @@ static int uli_agp_init(struct pci_dev *pdev)
>  {
>  	u32 httfea,baseaddr,enuscr;
>  	struct pci_dev *dev1;
> +	struct amd_northbridge *nb;
>  	int i, ret;
>  	unsigned size =3D amd64_fetch_size();
> =20
> @@ -411,9 +430,14 @@ static int uli_agp_init(struct pci_dev *pdev)
>  		goto put;
>  	}
> =20
> +	nb =3D node_to_amd_nb(0);
> +	if (!nb || !nb->misc) {
> +		ret =3D -ENODEV;
> +		goto put;
> +	}

Is this check structurally reachable?

If amd64_fetch_size() returned 0 earlier in this function due to missing
hardware, the array lookup for uli_sizes will fail. This causes an early
-ENODEV exit before ever reaching this new check. The same unreachable
logic appears to apply to the changes in nforce3_agp_init().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504065441.9903=
3-1-w15303746062@163.com?part=3D1
