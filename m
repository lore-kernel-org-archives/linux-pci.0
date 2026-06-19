Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FBC360EFF
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860290; cv=none; b=lhSSg3IUuh8v0pzfwv64IwtsOm+aiH45SB8MXztuPL8AKLgM9qtJn0zxIbeYn5PZqsv6C7H9DJ0daXa73nVS8l3g/kz+cy+Ivytuun2OyjHpfmzSiu29NLGSXQ/Y3QA85kTQ4bLHFAQyzP2DnGRd79kbRejxlvbC/5DPtL+5Ab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860290; c=relaxed/simple;
	bh=XpCYNseY67EDhM3lv/3BepPIODWpBS+TI3UpRfucMFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MhSffxyAyygq/uM5U5wTcARFLVa7Jvdhkz8vMvtgeGUGvHsYIqMxBoZSqAqR+MEx4JSCj9rhZHOAphmTtpuRP4XTxVn9uBBokW68fG65xwORC2AoOiQKgZ4BkauCiU4oCL+/xr8G9ioATEm7DEAMqaYCnDOCFPE6Bgi5i0DcYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKar2K9U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKar2K9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457FB1F00A3A;
	Fri, 19 Jun 2026 09:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860289;
	bh=XpCYNseY67EDhM3lv/3BepPIODWpBS+TI3UpRfucMFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKar2K9UcxEs+BOfb+Tkg7EY4WDWpN69NUYLy1LJquyTdMY59AezeHfjggyXvLJem
	 KlTRyr3exP2Zy5l2VgGwCXWHoy7u2xxe4DCGNADTH/o45gIrMcmU9kywdNceJbcsjk
	 jxPgY4R2HSxaUcDAdqMat3zTQwwjmzDKbm4Ml8ggnzzQNlrzw5mz68qPXLbp+AEtG/
	 yAaNj/tuFUSRbv4DdzerkbC5y+s7kb0PM9ssWEwMMUcrsbyXfR2fV2UE6A3M+81eei
	 vIXm65DnhBDWTAaz1bSPxW8R0gYbIABzx1J/oJGgLgQs5wjK/DEuF7y/XAlTFo1i6Q
	 8YdE4AdtFwU4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/25] alpha/PCI: Fix __pci_mmap_fits() overflow for
 zero-length BARs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-15-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-15-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:11:28 +0000
Message-Id: <20260619091129.457FB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, __pci_mmap_fits() computes the BAR size using
> pci_resource_len() - 1, which wraps to a large value when the
> BAR length is zero, causing the bounds check to incorrectly
> succeed.
>=20
> Thus, add an early return for empty resources.
>=20
> Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D14

