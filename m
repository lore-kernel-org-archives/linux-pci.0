Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E43CE4B5;
	Thu,  1 Oct 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851745; cv=none; b=SDqu19AgGw+VlXET2dtOh4VEAlWHI242HONj2gZyreeokqND/CSSjXsqtHe+b9lC0trxv01KyDIycXaZdM4Ly5nFTxq+5QdOz4FB3s+Ips5Fym/m4zDA364cXCCALUUWueDgJfjNM5vrPH+i3rZEuRn3IjsXEgPCbWxlZOGtZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851745; c=relaxed/simple;
	bh=2Hrs8QMV6GsYOJAbuSsm7QGqkHqKZ7Ay/UjH11hw8x8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n17Tt2xvEm9yxKoj1u9dsiqe5hgqQOzdRtNGQVooBL4Mgv9X+4se58oR6RlyzEkAn/BZNvkv6qJ2PblPe6ORBaq1I+YgUuZhwlZVK1L8SVjK3D38kQgGBI/vN3KUxPWaBS0CSJl5w3m0UJlYWheRlxh/ukpIs/tLjEElhwwD+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4Ol6oZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4Ol6oZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED5A1F000FF;
	Thu,  1 Oct 2026 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851743;
	bh=uXWZUO5AyYO1ad/4Ur7tiRq4S8A66YpDVdDFoC8fKJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S4Ol6oZ6BRAobYKTp/UAXibRjDDEctL8KZtHFfdAkpGVrn0PRs4pmgJefKQq4mH5L
	 c3LMILJCZBZJOmEzJZ9YO7rZgKD58+c6PqZwCtj3OmYzgLFULHtkvh6zo5BW6JsDvd
	 ZxPVt2fOTXiPirOuqBALbKu6vbV+6oqPruBMCt8elVJG3FfTBUzuOPdd8cFltQBbHC
	 eiIdHGMjewr0UCWfKkl7Y+poem6C+cXJj20i5R19LaIDGqi4QAfvQUpVeMsMAMvVdI
	 Qz0IkysR8YJVLG5rrzRoITaMox5ozJJVzFlIZeWOg0dUYiyun1tpA72M45vqt/ewO3
	 zaPnFZbzbjBzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 14/16] cxl: Restore CXL state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001092227.3004747-15-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-15-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:49:03 +0000
Message-Id: <20261001104903.8ED5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl: PCI config space corruption if state not saved before reset
--

commit ac710a7fdaa9ca778d4721319e9ec092a2bb0d6c
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Restore CXL state after PCI reset

This commit restores the PCI configuration needed for HDM access, followed =
by
cached HDM decoder and CXL Device DVSEC state after a PCI reset. It stops at
the first restoration failure and preserves a disabled PCI command snapshot.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 679a605da24c4..0acc471d0d7e2 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c

[ ... ]

> +static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
> +						  u16 *command)
> +{
> +	u32 saved_config =3D pdev->saved_config_space[PCI_COMMAND / 4];
> +	u32 restore_config;
> +
> +	device_lock_assert(&pdev->dev);
> +	*command =3D saved_config & 0xffff;
> +
> +	/*
> +	 * pci_restore_state() is the available interface for restoring BARs and
> +	 * related PCI state needed to reach HDM MMIO. Temporarily alter its sa=
ved
> +	 * command value so that it enables MSE but cannot enable BME or INTx
> +	 * before CXL state restoration completes. Preserve the original saved
> +	 * value for the outer PCI reset path.
> +	 */
> +	restore_config =3D saved_config | PCI_COMMAND_MEMORY |
> +			 PCI_COMMAND_INTX_DISABLE;
> +	restore_config &=3D ~PCI_COMMAND_MASTER;
> +
> +	pdev->saved_config_space[PCI_COMMAND / 4] =3D restore_config;
> +	pci_restore_state(pdev);

[Severity: High]
Does this code corrupt the PCI configuration space if the state was not sav=
ed
before the reset?

cxl_restore_pci_state_for_hdm_restore() unconditionally calls
pci_restore_state() without verifying that pdev->state_saved is true.
pci_restore_state() writes the contents of pdev->saved_config_space back to
the hardware's PCI configuration registers. If the caller did not successfu=
lly
call pci_save_state() prior to the reset, this array contains uninitialized
zeroes (or stale data from a prior suspend cycle).

Writing this invalid state wipes the device's BARs and configuration,
permanently breaking access to the CXL device.

> +	pdev->saved_config_space[PCI_COMMAND / 4] =3D saved_config;
> +}

[ ... ]

> +static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
> +{
> +	u32 *saved_command =3D &pdev->saved_config_space[PCI_COMMAND / 4];
> +	int rc;
> +
> +	rc =3D pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABL=
E);
> +	if (rc)
> +		pci_err(pdev,
> +			"failed to disable device after CXL reset failure: %d\n",
> +			pcibios_err_to_errno(rc));
> +
> +	/* Preserve the pre-reset snapshot if PCI state has not been restored. =
*/
> +	if (!pdev->state_saved) {
> +		rc =3D pci_save_state(pdev);

[Severity: High]
This error path explicitly handles the !pdev->state_saved case, which indic=
ates
that a missing saved state is anticipated during a reset, yet it is
unconditionally restored on the success path.

> +		if (rc)
> +			pci_err(pdev,
> +				"failed to save disabled state after CXL reset failure: %d\n",
> +				rc);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D14
