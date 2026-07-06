Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949F3812C2
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350786; cv=none; b=gAAthwZiFOGakywgbgVhT5nYMJ3+voGjhwodL7byhsZga6xcaJYsyKoFF1N0ZRSkPoSdB3e7aIhIPy7m7pjjxjiZoHQ8mt0FTTyJEUcf8zZGaJ4PraidvgM06pkojLwO8K+WN6Qz9ZnpJC4jJTsdlrJkuqTivYtRvlS8mx/tNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350786; c=relaxed/simple;
	bh=JevGBzmWQO9zbrhY97otZQ1cXEXB1tRQttW1vQz7XMs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=clGB17ylfzA9Qwu7LVisArXqjOV6dQBoX26cnuWy8U1zCF9zl6to3m3hlM4NzCVkztMaSdN9r5YRspX4ebEAo2bJ2a8qQ9iQ94AFFAPehthFU71Pr1E5dq+Ej7zqtlyoHJM0lQ9qcXSaWtMRtgxiyfpUOPvKvZMeU/nDNMZOkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krOi3OW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krOi3OW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44521F000E9
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783350785;
	bh=CabqnN8/KK/kZOS3/MFLTfj5rd4TkvLO+0w9sPiM1Zw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=krOi3OW12ngJLscoCga3Lde0FIChi7F8zJV++U2qwAppy+aKFJLY0Xr/0cCbJlZw/
	 6ZcW4QQAOMO5DarcdzhjlqVUuFMsGxQ+wzoqfLsTXTta7JS7z1wHsvNY4n1G5D3DKf
	 Aj4jaU5gnPKxXo7bIeLrURnAxi5qfnwHDff6weB6Qy0PGXMO2CEXT7ryYIsfrmWJaM
	 qxaQO+kQuz2sgjGkL/kMJLjT7GWGQ7kdHpuemHmTRwnuZWv8VSlkpZ65tw6PqNPB63
	 lxJ0rRn+zvEoi8IheQVjegW+ZoA0LmsG/BBnsvgzagqytMwsgOcQhI2lwk8WFjOOFt
	 xxET9JAbUV8Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Documentation: Update after split of
 <linux/mod_devicetable.h>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
In-Reply-To: <ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783349758.git.ukleinek@kernel.org>
References: <ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783349758.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 15:13:04 +0000
Message-Id: <20260706151304.D44521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The kernel-doc for the ACPI_DEVICE_CLASS macro is lost because incl=
ude/linux/device-id/acpi.h is omitted from the new explicit header list in =
basics.rst.
--

commit c40d3b75cc5cb1e55623d0db318301a1e8676b9b
Author: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>

Documentation: Update after split of <linux/mod_devicetable.h>

Most structs that were defined in include/linux/mod_devicetable.h before we=
re
moved to a bus specific header. This commit follows the movement to get the
documentation back by using an explicit list of per-subsystem headers.

> diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-a=
pi/basics.rst
> index 8b6a5888cb11d..647e14254cfb8 100644
> --- a/Documentation/driver-api/basics.rst
> +++ b/Documentation/driver-api/basics.rst
> @@ -10,9 +10,36 @@ Driver Entry and Exit points
>  Driver device table
>  -------------------
> =20
> -.. kernel-doc:: include/linux/mod_devicetable.h
> +.. kernel-doc:: include/linux/device-id/amba.h
> +   :internal:

[Severity: Low]
Does this new explicit list of headers miss include/linux/device-id/acpi.h?

It appears that leaving it out drops the kernel-doc for the ACPI_DEVICE_CLA=
SS
macro from the generated documentation.

> +.. kernel-doc:: include/linux/device-id/cdx.h
> +   :internal:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ede7ce64f20e10660eb=
f6bc1b41836dad750ae3b.1783349758.git.ukleinek@kernel.org?part=3D1
