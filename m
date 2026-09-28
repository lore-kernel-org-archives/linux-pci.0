Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A93546C4;
	Mon, 28 Sep 2026 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559805; cv=none; b=q5RkizW+2aTtxKQzaXeatl79GLlcHP/seFfyfTfWlZe8HkyUjubRp7K5DcrGsbIGe6w2KuWhhDrmaOaUxf23h0koVZyRKjZUE9qzLLkWh3d5ud+rAfx7Yn6Q6eFFfZzH2KL9JpgjNMxm9mDTLtaZOw4kKxEVcxtTMxGRVpG/4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559805; c=relaxed/simple;
	bh=kcDQS3+tPEloPzyk8jri+x3Ursgon8IYapRDpndmTFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cD02sVm7zUSUKcw98Q69IJwDdb1px6MFNlDUouWB9ky5h5aTNe6ZPxun9ofjO4vveoOv83lpT4e2Mq9r7Kx+6Q0XwwmuRBjpECrz+EInsCmnEP7uQxMDMvXSfevfkYEsguGplkbiVWVff75VeDykWn6omT+lU7Tgll7+b3XLLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENDCcq+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENDCcq+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA5A1F000FF;
	Mon, 28 Sep 2026 01:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559803;
	bh=ZzRMcY8xVcmfPVw8jWPDrJIOdXG4oeDCD3vLfxcn+8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ENDCcq+FV77Or4mG3kU2ZEsv8jGzwjOAtt2hf2jnHh2yfiUpgY83ZnKRU7HKTLzEI
	 kzSxWCBIcTf1afqMI6Hw+Ajney+BPDofFFAYBBk06tRhRWI0+fzBDB4hkomFvirYk1
	 boJwk79Z/yncihScAOeMZ9L6Rnt/8WBqd0ePYKO+T9zLDgVKvH2RiUN5zY9IpdOkDS
	 gYVChXk3XBaoUEsJr+9LJKITHc6touqkrbfYd2qvNPclxSOB3RzRXMxDy52cJeS9fo
	 QcN4qRDsXsJeaQzUVr9dul0sXisKw/S+gq7i99YxB8D+zx6lEmfkDfqWzlfKk9N2LU
	 vD0gw6lNQsj7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/22] rust: add bindings for hash.h
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260928011123.450800-9-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-9-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:43:22 +0000
Message-Id: <20260928014323.4FA5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] rust: linkage failure for hash helpers when CONFIG_CRYPTO=3Dn
- [Low] rust: bindings_helper.h include violates alphabetical sorting
--

commit d3a13bbc1d2175dfb4494c82add6ef5923646f93
Author: Alistair Francis <alistair.francis@wdc.com>

rust: add bindings for hash.h

Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
and crypto_free_shash() available to Rust.

> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 4b31aa7f432f5..fd223b6c5aafc 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -30,6 +30,7 @@
> =20
>  #include <linux/acpi.h>
>  #include <linux/gpu_buddy.h>
> +#include <crypto/hash.h>

[Severity: Low]
Is this include placed in the correct alphabetical order?=20

This file requires alphabetical sorting, but <crypto/hash.h> was placed=20
after <linux/gpu_buddy.h> instead of before the <drm/...> and <linux/...>=20
headers.

>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>

[ ... ]

> diff --git a/rust/helpers/hash.c b/rust/helpers/hash.c
> new file mode 100644
> index 0000000000000..23a63618a3709
> --- /dev/null
> +++ b/rust/helpers/hash.c
> @@ -0,0 +1,18 @@

[ ... ]

> +__rust_helper void rust_helper_crypto_free_shash(struct crypto_shash *tf=
m)
> +{
> +	crypto_free_shash(tfm);

[Severity: Low]
Will this cause a linkage failure when CONFIG_CRYPTO is disabled?

This unguarded call to crypto_free_shash() resolves to the external symbol=
=20
crypto_destroy_tfm(), which is not compiled when CONFIG_CRYPTO=3Dn.

> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 440fb7638e3cb..09ec69f736b19 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -66,6 +66,7 @@
>  #include "fs.c"
>  #include "fwctl.c"
>  #include "gpu.c"
> +#include "hash.c"

[Severity: Low]
Does this unconditionally compile the hash helpers into the rust_helpers
object?

Because hash.c is included here without any configuration guards, the=20
crypto_free_shash() usage above is compiled even when the crypto subsystem
is disabled, leading to the undefined reference link error.

>  #include "interrupt.c"
>  #include "io.c"
>  #include "irq.c"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D8
