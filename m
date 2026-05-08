Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EC8635D
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211944; cv=none; b=qvB0RDgDnzJ/wstCOEBtTFdW6MBGEMVTSfVpJF6jdOUgXMZ1wWMW9k0Pbsv7FzU5afzx+BNmsdeOHfP+ZNdzu2eHVevtwMADHXhP1R89HV0jPkrrkexhZgdSpmoogjMbX8JfhXOn3GXChbSHT9CCG9FyXcvFkmssTo82jNRSeWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211944; c=relaxed/simple;
	bh=TZvjDkRrsvyYtai6/4fqD71zkwm9S1hQzyg2/Z0clOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jZ6ElC7j2Js1//6aFJ6icubOag3AaMY5bTZKVDtiNTUeBW9mzEgDHwezsU2eWk4PxXyVKnmbGpBo+r1+wIcYZYTyd5S4sTUnLs7pLDrdlWYNE5gzKNo5TsYR9XVWsNqiUTKqudYyCtKJiQt+BCcHwdBhG1vBj4ll5uCPyrSxSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjOL5F9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjOL5F9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D2FC2BCB0;
	Fri,  8 May 2026 03:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778211944;
	bh=TZvjDkRrsvyYtai6/4fqD71zkwm9S1hQzyg2/Z0clOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BjOL5F9wNf168Lrif69MpgcWe0vYnJpcmTVMAeUJ+hLgUxeRzTfDB8bh5WjnBJVzE
	 6VBpuJIfPIfTNXj/iyx9dEacuDOpsuMKmwlH7y3a2Wywgt18K/GlCgSAvVyid9E64z
	 lMcOpUL0EszS4BuYBTs0dqp4UGix2oC4F3+XM9r3tmPUi2KkxBXDAVvlw80j9ggZdz
	 oRi8l/SYbJvJVJSyoLXCs3jv0n6JVg8KuD/gmOa8lxkTAlLFC+TcW5G5tsUrdufy7s
	 dQmRYDgWim+/xOdtt6jgikYwjLLYsZBFrUaUyLaCdOv2gOkHLeSwHDC6mSbaEy55rc
	 PeG9/rb7cJ2JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/18] X.509: Make certificate parser public
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260508031710.514574-3-alistair.francis@wdc.com>
References: <20260508031710.514574-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 03:45:43 +0000
Message-Id: <20260508034543.D9D2FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to adjust the `#include <linux/time.h>=
` directive to `#include <linux/time64.h>`, but the patch fails to do so.
--

commit b079c32d2fd414877e2d8a8b3e079a1f6c2dc220
Author: Lukas Wunner <lukas@wunner.de>

X.509: Make certificate parser public

This commit makes struct x509_certificate and its associated parsing functi=
ons
public to allow CMA-SPDM access to the Subject Alternative Name. It moves
these definitions from the private x509_parser.h to a new public header.

>     The private header file x509_parser.h previously included <linux/time=
.h>
>     for the definition of time64_t.  That definition was since moved to
>     <linux/time64.h> by commit 361a3bf00582 ("time64: Add time64.h header
>     and define struct timespec64"), so adjust the #include directive as p=
art
>     of the move to the new public header file <keys/x509-parser.h>.

[ ... ]

> diff --git a/include/keys/x509-parser.h b/include/keys/x509-parser.h
> new file mode 100644
> index 0000000000000..8b68e720693a6
> --- /dev/null
> +++ b/include/keys/x509-parser.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* X.509 certificate parser
> + *
> + * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#ifndef _KEYS_X509_PARSER_H
> +#define _KEYS_X509_PARSER_H
> +
> +#include <linux/cleanup.h>
> +#include <linux/time.h>

Does this include directive match the intention stated in the commit messag=
e?

The commit message mentions adjusting the include to <linux/time64.h>, but =
it
appears this still includes <linux/time.h>.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D2
