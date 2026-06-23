Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382633126B2;
	Tue, 23 Jun 2026 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185679; cv=none; b=tqd9EScB0pD/Ns7TYWX+7Cs/MOoBtI4dhOWNX7i/XSRP0y89LB99rn/7dGGsxyv9mhnPPsv6WBr0U0JrZ7IX9V7Npt4g+s/1M5ToIUzhDdbhaSQkryGg698jo3gnPVnjrw644uCoYAcTHsXT3HP8GmQ/A7d2aLVqNF5V51pAooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185679; c=relaxed/simple;
	bh=BHKOx/NJ2bBh5ch2YNMc7JvOnwkJxThQisKFXGmKzl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UN8N2NOh5xV2hVP7ksmIQF97G9BcVF7RrHMc//w8Yo9qmvaBRV4fff1Kg+4yzQSLh5UbSo92IDJGNeAyE4sCcXyDIuX8BBXx4j9qySItQSYodGS6VyBoJuLNIF/B9bup5RNXo5RzEg3UZfUcz4LKk9igI+atr5iYgx+ec+zrntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1133qkH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1133qkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E7E1F000E9;
	Tue, 23 Jun 2026 03:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782185677;
	bh=hqfngQtJvZ3n/JaDEgRqMfckrP++rA3eFjU5834OWR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1133qkHPZvjHw5ovQ9joV2obl1W1cGvzfo5pZ2aMaX8u29v7oz66JlvSRkAlOy/I
	 0rSimBGocB1YL5OPmL9Du3keIQsC/RY3Q7B+vbKdsfMoKbK89V/Iekapulxx4LF8Qj
	 Frw0i7+Rc6ewJ4CA3rIhAo049ZojT7YQewOETSQ3iRvmXQitmGp1wqUOXI7lB65dvw
	 f6jhERKWQeDWbdDgIt39xZc28vai8EcAfFwmFQKrTjYwfqNm1N5OnJ8lsXvBmCuYvt
	 5WxlySCHvU7UXfYP5w5Rs0xtfxaN0QB2or/+L9IrbbFTte4S9C46kZ36P+YmU68m5z
	 qQAVbTWtGeGQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/11] PCI/cxl: Discover the CXL reset scope
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260623032453.3404772-8-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:34:37 +0000
Message-Id: <20260623033437.A0E7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mixing `goto`-based error handling with scope-based cleanup help=
ers (`scoped_guard`) in `cxl_reset_function()`, violating cleanup guideline=
s.
--

commit 0809a08ef80af3b49b6dba78ed81070b5efc26c5
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/cxl: Discover the CXL reset scope

This commit adds support to discover the CXL reset context for siblings
sharing a reset scope. It uses the Non-CXL Function Map and device
capabilities to identify participating siblings and holds references to
them until the reset context is destroyed.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 786d1060e40dd..1ae714a3595cb 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
[ ... ]
> @@ -765,14 +937,20 @@ int cxl_reset_function(struct pci_dev *pdev, bool p=
robe)
>  	if (probe)
>  		return 0;
> =20
> +	cxl_reset_context_init(&ctx, pdev);
>  	cxl_hdm_range_context_init(&range_ctx);
> =20
> +	rc =3D cxl_reset_collect_siblings(&ctx);
> +	if (rc)
> +		goto out;
> +
>  	scoped_guard(rwsem_write, &cxl_rwsem.region) {

[Severity: Medium]
Does this mix goto-based error handling with scope-based cleanup helpers?

The cleanup subsystem guidelines state that the usage of goto and scope-bas=
ed
cleanup helpers should never be mixed in the same function. Since
cxl_reset_function() already uses scoped_guard(), should the initializations
and cleanups for ctx and range_ctx be converted to use scope-based cleanups
(such as __free) instead of introducing a goto label?

>  		rc =3D cxl_hdm_ranges_prepare(&range_ctx, pdev);
>  		if (!rc)
>  			rc =3D cxl_reset_execute(pdev, dvsec);
>  	}
> -
> +out:
>  	cxl_hdm_range_context_destroy(&range_ctx);
> +	cxl_reset_context_destroy(&ctx);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D7
