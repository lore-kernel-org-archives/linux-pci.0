Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CC27B340;
	Tue, 23 Jun 2026 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185762; cv=none; b=AJYDr3MCtG5uB9xCukullv+e++S+vWxrmHsxdgZpeaeFqtN60yj0OGq0gepSoHc70q3lxRkTXtg/zrO7JahbHrXKfLVeHaWiWTMWPqMjBO+fC60k8x8ibiLVJEmTVBCSOAl4FvuWk5gR73ONIBQ2oklMt6UrofD32vDydOVPg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185762; c=relaxed/simple;
	bh=0VBpyl4/nNEiJaoRRFRWf2muCUNJPqFrNISeUwEQVSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fk7yMysiIrDbQjwy0L3Z88KznEPKNHX8b2HYLHlK+wE3UjtsrI0pA9zjWvzIP5hYTy9aFeOHBEm2Dq0JJciyw6zcYWbacE0IUNHN7fLWQG9TzNjyjpdXCPZ5wCyh+i9sSLY2CuFg0cCrJhlY4qtRUwkA8oP01QgBpceCqGBdrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifh4CyhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifh4CyhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0C91F000E9;
	Tue, 23 Jun 2026 03:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782185761;
	bh=9zYJ14hPCT1FYsa6L+F6wnOsiArwo3KVpmw+FUdGOO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ifh4CyhSGiSFzWOCLzHIBtk4cJmDiTqP06R1CPqCgbjZYJrr7rRhiaKs+uFO6IPdw
	 b+KPWiekwsTH44Jjwdi359TLLcaDc5iUqw2YhOJ1eDnLg2bM4mwFqD35KV+N+KvRBy
	 6FZq8Pf/M4oZFxVFWBjEgviJGByRJxJLtXAUI8XFD68yya40/JIbYXzcOSIxjZPq7g
	 mSq9LsmYt+X/VFaa73R9BdvWiGcaQvORtd3qTuWfD1Ycq5STq2mv9L/kn0FFs5iNnS
	 oUOKpvXIfhacENh3r/X0nXuIKLJoxSug564I5S8tlz6QThuEJpM2XwIw3itco3qCTD
	 p4tJcoctRZEDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/11] cxl: Add CXL Device Reset helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623032453.3404772-6-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:36:01 +0000
Message-Id: <20260623033601.7D0C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Read-modify-write of CXL_CTRL2 register accidentally re-triggers s=
elf-clearing commands on error paths.
--

commit 2cd253f3fe48a32fcac990882cdcc0aac716f026
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Add CXL Device Reset helper

This commit adds an internal helper for Type 2 CXL functions that support C=
XL
Reset. The helper disables caching, initiates writeback and reset, waits for
completion, and re-enables caching.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index fc52d3abdb5b4..fdfcc9e825e03 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c

[ ... ]

> +static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 s=
et,
> +				  u16 clear)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	ctrl2 |=3D set;
> +	ctrl2 &=3D ~clear;
> +
> +	rc =3D pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);

[Severity: High]
If a timeout occurs in cxl_reset_disable_cache() while the=20
PCI_DVSEC_CXL_INIT_CACHE_WBI command is still in flight, the error path
calls cxl_reset_enable_cache() which relies on this read-modify-write
operation.

Since the hardware operation timed out, the self-clearing command bit might
still be read as 1. Does writing 1 back to this bit here unintentionally
re-trigger the hung hardware operation?

Should self-clearing command bits like PCI_DVSEC_CXL_INIT_CACHE_WBI and
PCI_DVSEC_CXL_INIT_CXL_RST be explicitly masked out from ctrl2 before the
pci_write_config_word() call to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D5
