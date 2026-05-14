Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD825B094
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793981; cv=none; b=Ar7RRVDVdAGYNTXDY/wq5xFKBifv8EthhH3GnxXwG3Zi45BDiDIo1THxIsD95PVr7wFXvAh0eXXiAC1dyoI+2OeahvnWYs6gpGHtOoMS+2Uf8jGbOoIO6wgifiShPcPlvvkSMDxb9OIQYTWoXJR4faP5UUtTb6vN0WF9yEeK22Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793981; c=relaxed/simple;
	bh=/dBAoUNLDU4d1GF3Y4dYMk9o+/xP3A+vptIovI2vfUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W9G6wpRyUThEph71+khWeBbk9fXxUa42VJAupePuIsVTTXLxMoHNt3V42RMAIYF0Rfn9KdDBbiQowZrZfOQyWO5bMg7/eqw6P+9Y0agVcFaa7forOWe4VKkFiMWmX7c15pqwZpSltE1G8YzBun7xoWDDULcsLBnVwR99dt6KoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhSiuIoc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhSiuIoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55873C2BCB3;
	Thu, 14 May 2026 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778793981;
	bh=/dBAoUNLDU4d1GF3Y4dYMk9o+/xP3A+vptIovI2vfUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XhSiuIocKJCoxCQyqBhWP+ufTrkH98ds8SI0QulCclKipNH/SRzuJD1h+l9HnLQK1
	 B6j3Cee9CYY7p4XFYSfIZAWty4zYu/5lLFmtt+8gZz8MUai8Q/RK4jpLNuSzB0is9G
	 3Hbpt1rz+xSdCRR3RqJzhV3vkTnD+qkL8A5ryAffNrAKFR3kpoCTFJgiolMicmIZuY
	 vtQXpgAT7a6OO8cqe4/D1UYyLLwLyFaqaiHVaT/GOyGP87THsQ8tLR8YZuBtOi9Xnw
	 BTqaWFXXsbtk3Y4ntbFIOx7I7k97eiKFwfOmMfyBiST4VK3BUlwUH9sO6KmY+Tz6Kd
	 T1roScn6+c/8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Initialize pp->lock before MSI domain
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yadu M G" <yadu.mg@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514181901.315647-1-yadu.mg@oss.qualcomm.com>
References: <20260514181901.315647-1-yadu.mg@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 21:26:20 +0000
Message-Id: <20260514212621.55873C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional double initialization of `pp->lock` in `dw_pcie_allo=
cate_domains()` destroys lock state and corrupts lockdep tracking for stand=
ard platforms.
--

commit 34c5622cf23f408a8b7191136ff7caf71c5a0456
Author: Yadu M G <yadu.mg@oss.qualcomm.com>

PCI: dwc: Initialize pp->lock before MSI domain registration

This commit adds an initialization of pp->lock in dw_pcie_allocate_domains()
to fix a lockdep warning on Qcom platforms. These platforms allocate the MSI
domain from a custom .msi_init callback, bypassing the standard
dw_pcie_host_init() flow.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index c9517a3488368..de316f103c73b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -215,6 +215,13 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>  		.host_data	=3D pp,
>  	};
> =20
> +	/*
> +	 * Initialize pp->lock here to cover direct callers from custom
> +	 * .msi_init() paths (e.g. firmware-managed platforms) that
> +	 * bypass dw_pcie_host_init().
> +	 */
> +	raw_spin_lock_init(&pp->lock);
> +

Does this unconditionally re-initialize the lock for standard platforms?

In the standard DesignWare host initialization flow, dw_pcie_host_init()
initializes pp->lock at the beginning of the function. It then calls the
platform-specific pp->ops->init() callback, which on some platforms like
Uniphier configures and enables INTx interrupts.

If an INTx interrupt fires asynchronously and its handler legitimately
acquires pp->lock, would this second raw_spin_lock_init() call in
dw_pcie_allocate_domains() destroy the lock state while it is in use?

Re-initializing the spinlock forcibly resets its internal state to
unlocked and assigns a new lockdep key, which could introduce a data
race or corrupt lock dependency tracking for platforms using the
standard initialization flow.

>  	pp->irq_domain =3D msi_create_parent_irq_domain(&info, &dw_pcie_msi_par=
ent_ops);
>  	if (!pp->irq_domain) {
>  		dev_err(pci->dev, "Failed to create IRQ domain\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514181901.3156=
47-1-yadu.mg@oss.qualcomm.com?part=3D1
