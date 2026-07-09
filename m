Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6CADF6C;
	Thu,  9 Jul 2026 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559744; cv=none; b=GHLhiE9ujni4r0KrvkXccsbTd2qUs+LDoioHbuEiA7ihjLihdv8SKaTqVoyr9yt+qFmoJCQ24uI8GPob5mVNeHNaBBDUG+uC8dKx7BKful+xvTvV8x1uKG+HhEOZgdR1j/SlOPnyL/Lcvs+iaMSHh7/vsyoIfdNf7Msks09h8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559744; c=relaxed/simple;
	bh=BQTktWmkupE2sji08A0dwyP8jltxpKgHNZWcUtvLFIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AD8iUk/8i+Gs59eecGqXrQ9PXIyyzh0JvFdkYrUrbtDlz9LUfYfujkwh0J5FJz+eZLlCIPQ/MsLsUISHlZpFb+bLNU2TFHN+0b/3DQmABw4VkYBdhM5jXptZjknV3N4sBI+7Ugr4pAdw1fmPLyh/8Bs/Z3Oc4M7ZExREqn2gpcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTJLLFbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTJLLFbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0694B1F000E9;
	Thu,  9 Jul 2026 01:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559743;
	bh=OyjMOgPpV+hS1iAuW6/einjrjMYHVtf/rjEV3fl0jeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CTJLLFbLLE+cdl/S4bJS7CFYAVAzdMhqS9wpYtQJNLFZztF/iY46SGTVD3rEFdjFG
	 Pg1NFJjzXrf54dLPI73mLaTUYTgQo75dZRQwf7FNiKUZFUqi1K6RoLM0mPhiSA9/Z4
	 ZoZC6JFMNvo8QM0eOOsKrhqa0YbrFDSlVT5UFr75mZzjZymGaaHiezvzFTm+D2P9sg
	 fOMonWmBLycqZvxIinzm0aa9b0/9v5pzIc56qQH2wtZxnV2tK+3q39V64kyC65bL35
	 QMDGKTcNlt+nbr8BOQnQHothyu8ds74tQu08UpbefEGKP5aa/ZElkhivFKfFZYQkVj
	 cDN7NVmJWNydg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/11] cxl: Add CXL Device Reset helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260709010304.680422-6-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:15:42 +0000
Message-Id: <20260709011543.0694B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect ordering of CXL cache writeback (WBI), pending transacti=
on wait, and IOMMU reset preparation.
- [Medium] Premature success of WBI wait loop on device disconnect due to u=
nhandled U16_MAX status.
- [Medium] Potential false timeout in the reset wait loop due to a missing =
final hardware status check.
--

--- Patch [5]: [PATCH v9 05/11] cxl: Add CXL Device Reset helper ---
commit c832f1294f231fc19fa036ee29639b20e723c1a1
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Add CXL Device Reset helper

This commit adds an internal CXL Device Reset helper for Type 2 functions
that advertise CXL Reset in the CXL Device DVSEC. The helper handles cache
disabling, writeback, reset initiation, and re-enabling caching.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 97b72cc67b6bd..7a9b1ecfadcf9 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
[ ... ]
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 =
cap)
> +{
> +	int remaining_us =3D CXL_CACHE_WBI_TIMEOUT_US;
> +	u16 status2;
> +	int rc, rc2;
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
> +	do {
> +		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
> +		remaining_us -=3D CXL_CACHE_WBI_POLL_US;
> +
> +		rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc) {
> +			rc =3D pcibios_err_to_errno(rc);
> +			goto err_enable_cache;
> +		}
> +	} while (!(status2 & PCI_DVSEC_CXL_CACHE_INV) && remaining_us > 0);

[Severity: Medium]
If the device is disconnected or offline, pci_read_config_word() will return
success (0) and set status2 to U16_MAX (0xFFFF). Would this cause the loop
condition !(status2 & PCI_DVSEC_CXL_CACHE_INV) to evaluate to false and
bypass the wait entirely, falsely reporting success?

> +
> +	if (!(status2 & PCI_DVSEC_CXL_CACHE_INV)) {
> +		rc =3D -ETIMEDOUT;
> +		goto err_enable_cache;
> +	}
> +
> +	return 0;
[ ... ]
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
[ ... ]
> +	do {
> +		rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc || status2 =3D=3D U16_MAX)
> +			goto not_ready;
> +
> +		if (status2 & PCI_DVSEC_CXL_RST_ERR)
> +			return -EIO;
> +
> +		if (status2 & PCI_DVSEC_CXL_RST_DONE)
> +			return 0;
> +
> +not_ready:
> +		if (time_after_eq(jiffies, deadline))
> +			return -ETIMEDOUT;

[Severity: Medium]
Does this timeout check need a final hardware status read?

If a thread preemption, interrupt, or scheduling delay occurs after the
config space read but before the timeout check, the hardware condition may
be met concurrently while the jiffies have advanced past the deadline. This
could potentially lead to a false -ETIMEDOUT error despite the device being
ready.

> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);
> +	} while (true);
> +}
> +
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
> +{
> +	bool cache_disabled =3D false;
> +	u16 cap;
> +	int rc;
> +
> +	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc =3D pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc =3D cxl_reset_disable_cache(pdev, dvsec, cap);

[Severity: High]
Is it safe to wait for pending transactions and prepare the IOMMU for reset
before initiating the CXL cache Write-Back Invalidate (WBI)?

Initiating WBI in cxl_reset_disable_cache() forces the device to flush its
dirty cache lines via new DMA transactions. If the IOMMU has already been
prepared for reset (which may disable ATS, PRI, and block translations), co=
uld
these WBI transactions fault and lead to silent data loss or IOMMU errors?

Additionally, creating new pending transactions immediately before asserting
the CXL Reset might violate the PCIe requirement to drain all transactions
prior to reset. Should cxl_reset_disable_cache() happen before the IOMMU
preparation and pending transaction wait?

> +	if (rc)
> +		goto out;
> +	cache_disabled =3D true;
> +
> +	rc =3D cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
> +				    PCI_DVSEC_CXL_RST_MEM_CLR_EN);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D5
