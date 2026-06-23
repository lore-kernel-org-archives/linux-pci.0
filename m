Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A98322749;
	Tue, 23 Jun 2026 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185986; cv=none; b=YkVnRTmXvt4qxcOUP6CUkLQe9ryyDPrbAiNQqXwyAugdW96a/ScHRycd1pVmjTYHRemFizCetE9NZenepPWRi877A87e5shgtI/sSBmxg+nqrw8rVFgIzHcgIc9YbtLUo4SgJ0LTkvbiGz9LWS++wm6s3AmtgyXwWbTjAnXhqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185986; c=relaxed/simple;
	bh=HEWEgQsp6g5VIQCg+3L9otCSOu9jCCadKKLF8IgPtAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shS+OW8Yw3zAVknyFZ4JV8r3l+HKhnQhhMVykoJSrt9QCuX3Z5HLljy+wo/rePuTACUC/iKgfh4CWhEbotRepyq9C3GfrH8fI1uATnEzgyTEYJrady8wE4fsPKzKAJ7F9crFYsNlN5ATBpr3K6uG084NO4/OU9t0nRKs05lCrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW8TTi53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW8TTi53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02A91F000E9;
	Tue, 23 Jun 2026 03:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782185984;
	bh=YAN5jcC6yPCS9WYzvPgVJMmWxakcnWc53XVkvbFYj1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jW8TTi53phA3RPCt5AutrzEquP14mh+JaHRdGzE2cnF91QzavTCcSTguXdVPuZ0jW
	 KZ9YbR3BgCsJg85j6oqsIc8pxNZKYA6pPvC6xG0c2lO4ARG+1pvWdAKtKi9jB1EI88
	 dyNw6XIGQyarr2M993V85pW/50OHHSSI8CDrj/PWn8o4uHmnuVWldes6wsLFdZvt5T
	 umpj1orByeCD3JEFtPSXM5IcZDL0xMyq5qpAGgILBQCGOmULVn2ZiKH8mX8T7XxYBR
	 lzCyZmR/3kAskn264a40WmZd/lZpzvFSFnE4cCsOSO2JDVvQf0VWgiLLQ+751b74Ok
	 pilW+G36b7AaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/11] cxl: Restore CXL HDM state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623032453.3404772-10-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:39:44 +0000
Message-Id: <20260623033944.C02A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `cxl_reset_function` mixes `goto`-based error handling=
 with scope-based cleanup (`scoped_guard`).
--

commit 632a408ad919cb36ef2b58d6bfde50d19355ae4d
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Restore CXL HDM state after PCI reset

After CXL reset, restore PCI config state enough to reach HDM MMIO,
restore cached global and per-decoder HDM state, and then run the normal
PCI restore callbacks.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 69bcfab898589..d801c91a5cbf8 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
[ ... ]
> @@ -1053,12 +1219,19 @@ int cxl_reset_function(struct pci_dev *pdev, bool=
 probe)
>  	if (rc)
>  		goto out_functions_done;
> =20
> +	rc =3D cxl_pci_target_reset_prepare(&ctx);
> +	if (rc)
> +		goto out_functions_done;
> +
>  	scoped_guard(rwsem_write, &cxl_rwsem.region) {
>  		rc =3D cxl_hdm_ranges_prepare(&range_ctx, &ctx);
>  		if (!rc)
>  			rc =3D cxl_reset_execute(pdev, dvsec);
> +		if (!rc)
> +			rc =3D cxl_restore_hdm_decoders(&ctx);
>  	}
> =20
> +	cxl_pci_target_reset_done(&ctx);
>  out_functions_done:
>  	cxl_pci_functions_reset_done(&ctx);
>  out_unlock:

[Severity: Low]
Does this code violate the guideline against mixing goto-based error handli=
ng
with scope-based cleanups in the same function?

The cleanup documentation specifies that for a given routine, either all
resources that need a goto cleanup should be converted to scope-based clean=
up,
or none of them. Could cxl_reset_function() in drivers/cxl/core/reset.c be
refactored to use a consistent error handling approach rather than mixing g=
oto
labels with scoped_guard blocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D9
