Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9083E00A8
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966349; cv=none; b=rrCY725n6TYxrD4WaBrX73zr9SCHOJ3oMgk5txyWL+OftfjuzhI+ainmBkQauwo1M3pXzwS3EyU+f/2pbixPs05r2fh1hQMOJdsFBil/pyLIXpP9UmYW4e2mwhBztaTbG34/BB9jVYmjCdKzBh3WceEFqff/6rKM8I0l1w1B1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966349; c=relaxed/simple;
	bh=qsd7Mvi3Lwt1djfeSodR6tmUk0wha21pLexL/f9qICA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C915IrW/cV5WdWLWuFrv7eZNS0NQOA7tAwd2inQMBOKIywmlBgVu7STTCcCZivJxbXtkDH0Dgkzvc/FV0h5O+MqYani41YZteOEyQGOpxEutxuVBDIeKBPilqS9uCYnH+ZAOb1lqo4UxiZ3C54nSFXyqKuTkMZulCVjwjs/xLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4uar4gf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4uar4gf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C194E1F00A3A;
	Thu, 28 May 2026 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779966347;
	bh=Q2N/rqR1iZoWOXWWwqkrfm/c6BqjbB+uvLkioq3vOtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4uar4gfxtZifAIl31XaAM5fK1/Dn/wObcbrEmPmtJmZAm7Sm2donnlrq+CrWOIVr
	 xPU8/v11aMS8+tIh2Rep2GIDwAjeDF6U5ZTu2u54lIS6f2xHbkkX+7gEvdaLcQEECj
	 dwdWsmFoooewfoe8RfXLrgPSxEKM1AddbZ3DYYo0qC/r66m68i0epJGcjYsUaw/x3E
	 o32iWvJFr0ZgGc+wUXLylyHvfCViQ74u9i1UFuIfOzgrCrgh9JwPAjGavwtiWRTm3v
	 5R7CPHnRFO1Om/esHhlrKZb1X+RviUqHFQjUg+16n0TwWvg5DXHmLqbvpnx7MJl+1F
	 tj6YOcmwO+K3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] cxl/pci: Add CXL DVSEC reset helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528083154.137979-6-smadhavan@nvidia.com>
References: <20260528083154.137979-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 11:05:47 +0000
Message-Id: <20260528110547.C194E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Device control bits modified during CXL reset are not properly=
 restored on error or success, risking unintended memory clears.
- [High] `cxl_reset_wait_done()` unconditionally sleeps for the maximum res=
et timeout duration instead of actively polling.
- [High] `cxl_reset_wait_cache_inv()` incorrectly returns success if the de=
vice is disconnected and the config space read returns `0xFFFF`.
- [Medium] Missing rollback of `PCI_DVSEC_CXL_INIT_CACHE_WBI` if cache inva=
lidation times out.
--

commit 79504f256cc3acc66c73c075be3fa3a60d62e4c6
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl/pci: Add CXL DVSEC reset helper

This patch adds a helper function to execute CXL Reset via the CXL Device D=
VSEC.
It verifies reset capabilities, manages IOMMU traffic, disables caching, and
polls for cache invalidation and reset completion.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 01effbb4e7cd1..1dd880f5a333f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

[ ... ]

> +static int cxl_reset_wait_cache_inv(struct pci_dev *pdev, int dvsec)
> +{
> +	int remaining_us =3D CXL_RESET_CACHE_WBI_TIMEOUT_US;
> +	u16 status2;
> +	int rc;
> +
> +	do {
> +		usleep_range(CXL_RESET_CACHE_WBI_POLL_US,
> +			     CXL_RESET_CACHE_WBI_POLL_US + 1);
> +		remaining_us -=3D CXL_RESET_CACHE_WBI_POLL_US;
> +
> +		rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return rc;
> +
> +		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
> +			return 0;

[Severity: High]
Does this code incorrectly return success if the device is disconnected?

If the device is suddenly removed, pci_read_config_word() can return 0 with
status2 set to 0xFFFF. Since PCI_DVSEC_CXL_CACHE_INV is bit 0, this evaluat=
es
as true, causing the loop to prematurely exit with success.

Furthermore, proceeding with the reset causes the subsequent
cxl_reset_wait_done() function to unconditionally sleep for up to 100 secon=
ds
before realizing the device is gone, leading to an extreme system stall.

> +	} while (remaining_us > 0);
> +
> +	pci_err(pdev, "CXL cache WB+I timed out\n");
> +	return -ETIMEDOUT;
> +}

[ ... ]

> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 =
cap)
> +{
> +	int rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE))
> +		return 0;
> +
> +	rc =3D cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
> +		return 0;
> +
> +	rc =3D cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
> +	if (rc)
> +		goto err_enable_cache;
> +
> +	rc =3D cxl_reset_wait_cache_inv(pdev, dvsec);
> +	if (rc)
> +		goto err_enable_cache;
> +
> +	return 0;
> +
> +err_enable_cache:
> +	/*
> +	 * Best effort rollback: preserve the original WB+I failure even if
> +	 * re-enabling CXL.cache also fails.
> +	 */
> +	cxl_reset_enable_cache(pdev, dvsec, cap);
> +	return rc;
> +}

[Severity: Medium]
Does this error path leave PCI_DVSEC_CXL_INIT_CACHE_WBI set?

cxl_reset_enable_cache() only clears PCI_DVSEC_CXL_DISABLE_CACHING. Since
cache writeback and invalidation typically requires a 0-to-1 transition,
leaving PCI_DVSEC_CXL_INIT_CACHE_WBI stuck at 1 might prevent future
invalidation operations from succeeding.

> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	static const u32 reset_timeout_ms[] =3D { 10, 100, 1000, 10000, 100000 =
};
> +	u32 timeout_ms;
> +	u16 status2;
> +	int rc, idx;
> +
> +	idx =3D FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >=3D ARRAY_SIZE(reset_timeout_ms))
> +		idx =3D ARRAY_SIZE(reset_timeout_ms) - 1;
> +	timeout_ms =3D reset_timeout_ms[idx];
> +
> +	msleep(max_t(u32, timeout_ms, CXL_RESET_MIN_QUIET_MS));

[Severity: High]
Does this code unconditionally sleep for the maximum reset timeout duration
instead of actively polling?

The reset_timeout_ms array maxes out at 100,000 ms. Unconditionally sleeping
forces the kernel thread (and any locks held across the reset) to block for
the worst-case time on every reset, causing massive latency and potentially
triggering the kernel's hung task watchdog.

> +	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +				  &status2);

[ ... ]

> +static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_c=
lear)
> +{

[ ... ]

> +	rc =3D cxl_reset_wait_done(pdev, dvsec, cap);
> +	if (rc)
> +		goto out_iommu;
> +
> +	rc =3D cxl_reset_update_ctrl2(pdev, dvsec, 0,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING);
> +
> +out_ctrl2:
> +	if (rc && ctrl2_clear)
> +		cxl_reset_update_ctrl2(pdev, dvsec, 0, ctrl2_clear);

[Severity: Critical]
Are the device control bits correctly restored on success and error paths?

On the success path, if cxl_reset_update_ctrl2() returns 0, the condition
(rc && ctrl2_clear) is false and skips clearing the ctrl2_clear bits.
The PCI_DVSEC_CXL_RST_MEM_CLR_EN bit remains set indefinitely.

In subsequent calls to cxl_dev_reset(..., mem_clear =3D false), the lockless
RMW cycle in cxl_reset_update_ctrl2() to set PCI_DVSEC_CXL_INIT_CXL_RST
preserves the previously leaked PCI_DVSEC_CXL_RST_MEM_CLR_EN bit. This
could trigger an unintended memory-clearing reset, leading to data
destruction.

Additionally, on error paths like when cxl_reset_wait_done() fails, the code
jumps to out_iommu:

	rc =3D cxl_reset_wait_done(pdev, dvsec, cap);
	if (rc)
		goto out_iommu;

This skips the out_ctrl2 block entirely, permanently leaking
PCI_DVSEC_CXL_DISABLE_CACHING and PCI_DVSEC_CXL_RST_MEM_CLR_EN.

> +out_iommu:
> +	pci_dev_reset_iommu_done(pdev);
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528083154.1379=
79-1-smadhavan@nvidia.com?part=3D5
