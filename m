Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523F194C98;
	Tue, 25 Aug 2026 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625948; cv=none; b=fGfjnbInzLb/H3YNsO5ztqPGrNCQZTDanKdEl3ifiXfGTB08xBn+O12TWDYc/SnTRtr7BOUKf3OLvLgomiK/DEZg6875aFeDnuX/CkudS429gNUBAJ0qyUyeWBasC4NE+ADaoLxl77czLE+m5GAcCKg34lcyVjAefXhjGjyrP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625948; c=relaxed/simple;
	bh=qU+QMmCEzKURoXJlyasiA/Edy9Tl+hUODdvD2amOXRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jmo4YkUroDzd+4GKux6jlkv77KBE+wMO0cDB7BKdAA4tUbrICJNNw5WVd9oE80qJ8MIusXf7gwFP0skVyq0/YnGw3VnG17SdKhvnSLOZZVgyT0PshBATl/G2EZt1Gj0u1dXWrBppEZqSLrG1A9g092680yDsWhntMyRurqys2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZV0EFNO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZV0EFNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3867A1F000E9;
	Tue, 25 Aug 2026 02:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787625947;
	bh=jAyZSBmeE7AquGR+ZoRUpNJ9f6QcpCvGlB0fQZY4XVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZV0EFNOrdZTQ4DPPRwx5UuOlEECm6Jqm+rgQbLQVN/mNeoW8IzPTJdr+CAsMbpxq
	 g6dBUEMbemfn7/7J9yoZofMKWbwlBuMjSYY0z7lOL3D2/2HKnd5dVbNsCvv+Ug0tYv
	 LYBRBW6y1Gp9m+KjyhTGqSwv3rIMH6wGoBDc24ZIuTJ2WvcdTati//k/Iepj15l2DO
	 mXp2TW/vpkZCmBrYKTdMxqe+vlUShgBbctmmEb+wARK2RoNTcup3ZQ3WFCoPCaKAHz
	 CB2cLNt9PAihjBo58GE1+Usr4UXy9IAEyAihsDiaEyyL+VBLkID0chW5KJgVqI9dvt
	 uSAOPAaAy9nsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] cxl/hdm: Add function to restore CXL.mem
 decode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260825022628.3651434-4-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-4-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:45:46 +0000
Message-Id: <20260825024547.3867A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `cxl_trigger_poison_list()` can trigger a kernel panic by derefere=
ncing an ERR_PTR when checking `is_cxl_endpoint(port)`.
--

--- Patch [3]: [PATCH v2 03/13] cxl/hdm: Add function to restore CXL.mem de=
code ---
commit 3dc5dc9495c42e77bea8b303acf10562a2ca0f7a
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

cxl/hdm: Add function to restore CXL.mem decode

This commit adds a function to put an endpoint back in HDM decode before
its decoders are committed again. It takes the Global Control value to
enable decode and skips endpoints that decode through DVSEC ranges.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d55d764895f88..7c898c60f60f6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> +int cxl_endpoint_enable_hdm_decode(struct cxl_memdev *cxlmd, u32 global_=
ctrl)
> +{
> +	struct cxl_port *endpoint =3D cxlmd->endpoint;

[Severity: High]
This is a pre-existing issue, but since we are accessing cxlmd->endpoint
here, can this endpoint be an error pointer that causes a panic elsewhere?

Looking at cxl_trigger_poison_list() in drivers/cxl/core/memdev.c, if a
privileged user writes to the sysfs attribute trigger_poison_list early:

    port =3D cxlmd->endpoint;
    if (!port || !is_cxl_endpoint(port))
        return -EINVAL;

If the sysfs attribute is accessed before bus enumeration completes, or if
enumeration fails on a device lacking DVSEC capabilities, cxlmd->endpoint
remains set to ERR_PTR(-ENXIO).

The !port check evaluates to false for an ERR_PTR, and the error pointer is
then passed to is_cxl_endpoint(), which blindly dereferences it causing an
invalid memory access and a kernel panic.

Could this be prevented by using IS_ERR_OR_NULL() instead when validating
the port?

> +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&endpoint->dev);
> +	int rc;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D3
