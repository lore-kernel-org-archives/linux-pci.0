Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE382DECC2;
	Tue,  1 Sep 2026 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225478; cv=none; b=SU1eyj4BwRBxPbHBg7MT7rCaWC9QPEQ2rPqsTsjs/KRg26OuqU88yjxdQf64qPHx14uGIucICXuOBShCc7A400oRjERlAhQfNuhFvkf5hMMdxIw+4hQV/ACig5OfNhpig6YUSjQ4Q6I5laFBAN+w3GfepyPh/PLizbexvYxcIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225478; c=relaxed/simple;
	bh=uOMx/fjLRldWTqXzA3GutF2/SbD7iMGQfF/AJpEusGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JcIPMgoBR3hYdVij07X4tlsI5vbbAcV7osTLRIbuh+8z2wKeb4p42F7bPNrYcEgWkPxMQcbQqZXI3M8I/wz8ldQKGS8hM9fl2J77AC6EDi47SsvcLmioobDqk/9//3K2SSEMltOtawwkc/b1wLa+MSlcaienpheHzpyO2HBkAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjOBmGAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjOBmGAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C763E1F000E9;
	Tue,  1 Sep 2026 01:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225466;
	bh=4yQAhBNHPlYYjZM3KGvhKNqRzsADjJRlEbhY7jnCmfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjOBmGAWtxsG64/RxFkhorgPmSkSkAm5C4LRaTNMOwRWIfvDc6tKPOND4UhUcEMCz
	 ApD6FSs0yfjtlnAXMK7kKpk+5g4Gc+hoOdNXayB4ok8rTJ/5nwxQTZA+e5smjhqKMS
	 heBcbNZSKBIp+oWJJ6Tf00JgnB+5JKmkWD8FYCl7HboGiWEvQVgPXKmEDeNXX9ddLU
	 btNbOTSZGbap9yHvoTNBg4U2Z5t7WDr3LVJusu7cYqrfbfBi30vUbGyAWpD247Ip0b
	 OI7J2tgxMqsxbJlr4Miao5dJHio0D9PfkUSsrGtvDQNW6TPTA90Tx8O93XLO4ccxHN
	 4NdrtJrS6onKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/21] lib: rspdm: Support SPDM get_version
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260901010347.2614656-15-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-15-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:17:45 +0000
Message-Id: <20260901011745.C763E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added `kernel::sync` import violates the kernel vertical =
import style guidelines.
--

commit 2c0be141f2603418ed69b0153c6ee75043525d1f
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_version

Support the GET_VERSION SPDM command.

[ ... ]

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 1883579b817aa..58d86ea06fd93 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
> @@ -18,8 +18,10 @@
>      c_int,
>      c_void, //
>  };
> +use core::pin::Pin;
>  use core::ptr;
>  use kernel::prelude::*;
> +use kernel::sync::{new_mutex, Mutex};

[Severity: Low]
Should the kernel::sync import in lib/rspdm/lib.rs be reformatted to follow
the kernel vertical import style guidelines rather than grouping multiple i=
tems
on a single line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D14
