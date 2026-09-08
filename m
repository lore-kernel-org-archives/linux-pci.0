Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5A2370ADC
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851164; cv=none; b=OpF5S54IlNqg/ZGz1b1lKw5aS9yczbhdZzqC/Ev7aontT9QqM8UA5dTb7S3peWj5PSY0E4fxvHboMeEnUwTvNbxaJr0HBqL77NFtDb6+/HhISVbSSfSuxXLKFfzVGekZlQ8VGqr86rBi+L7FsMsZx7ufplCHUOEIe4XWBrJ3dPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851164; c=relaxed/simple;
	bh=Uh/wsGWX7WRlAerMjjJIijsb4kU9MisiGjHw+8GY0cA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y2UjJiqtdqsOZ8la8xx3UtXaXDIC2AyN7liKEcvFz9oiQuyNmcLsxeY+Gida544GkzfEfyKUa5I8wOsQteIbFd3Eaj/ZhwHA+D6+zTdKVkjVvH+mXt0aHItyQ+nAoEMWRYtA9yuLu9k/uKF5yRQlmSkClHFw0u4smcW7PjqxVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnrPO3ZU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnrPO3ZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4FD1F00A3A;
	Tue,  8 Sep 2026 07:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851162;
	bh=RlRDu+Hk2jX5yVo9AIX0U1RAch07JnwtagDFOm+NimI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mnrPO3ZUYuKeWZymGJw7Neb9Js44PTFoCJVxf4hZO/4LHVK7HJFLSUED8rYQhY1QZ
	 xcwQeLrzI6/MyWjWd48xVlVuPwaPXPXIBLHO07fO5enKtXtZEbqh1oK8gO4OLT7vjG
	 85oC+gZ4czJsuGKEldX+/c/rQEthebt9sL/DKm33MnrlD9+jaC1/XsAdWQ9j+yDciQ
	 ESUVASykqjfIHdtGP7e6i0xdjtLfe8fZGIlUiuptUwPtAnrh9j0RgDUw9F2GujGGgB
	 SgXJWJyYe2VdvJKdLOk8j61URouvalv0pclc0CqnXLuKPCyYhOHJNJleHVXNFscBIy
	 nfnPVmPBAghLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Documentation: Update after split of
 <linux/mod_devicetable.h>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908070031.32833-1-kmehltretter@gmail.com>
References: <20260908070031.32833-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:06:01 +0000
Message-Id: <20260908070601.EC4FD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>
>=20
> Most structs that were defined in <linux/mod_devicetable.h> before were
> moved to a bus specific header. Follow the movement to get the struct's
> documentation back.
>=20
> For the list of device ids in basics.rst use an explicit list of all the
> headers that have kernel-doc annotations and that are not described
> elsewhere (i.e. pci and mei_cl). <linux/device-id/acpi.h> is left out on
> purpose, ACPI_DEVICE_CLASS() is not a device id struct.
>=20
> Also repair the referencing in the zh_CN translation of pci.rst and
> don't duplicate `struct mei_cl_device_id`.
>=20
> Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers=
")
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> [Karl Mehltretter: use the :file: role in pcmcia/driver.rst, say why
>  acpi.h is left out]
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908070031.3283=
3-1-kmehltretter@gmail.com?part=3D1

