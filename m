Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D34746DA;
	Tue,  4 Aug 2026 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873114; cv=none; b=btfg2wGkhw/ag72B/lcEIDwD3wHR+o4XaePcAmhIdY1fMPOfah2Dq8tKp5IrDnQ28LYsE5blV78sQbIvm1I7Z7XbaKRujs8hpr/LeRsXZMt5z3NIRHkTuLeAomo1LbF0zbbB0elLGDO+6x2FVOPgHIVuHtlYExmmtpsljbMcYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873114; c=relaxed/simple;
	bh=ktrhA6EKtSJ4/DRnQIxOFuTJzH6hDxTvj4/Fp/CW+Go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e98spE9izjuHlnjwaav+wpUcCAbt4V4VGYo9NARGIgnqVfDPhxgIqSWPsq/s4UggXCQpmqqlDcibE9j3EVgtzSk5utFNUCGv51l6tJpAxiqCeXBlmSi/bn38coR8XUJmfGBEMVktTiy6MOvNcJOOjoBJqQwF9VBjOBf0F0g0KFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMRItkXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMRItkXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1941F000E9;
	Tue,  4 Aug 2026 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873112;
	bh=lw3LY9M9OEyv5DnROr0wTyJdNNBznR1Ybp2eXytvD44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMRItkXs7s+GYXdPmeC7GrZaEkl91jm9F+RWtQgLeHcqKB7mI8+98mvaJQbiKjKQK
	 REUPOjuIpSQTtx9vgxHLsiVVAjvAqwrHbrIWcFpdsPbPEwzRp1XumX1A08BodAoAJ5
	 9s88zXk8c33JxliFwloRDTQ+QoWtebSfXmYrChIW/6buty5pucl+0EDvnqpcvFrmah
	 NKZ1/Gz4N1rPDBmpO/MZYUEJ/BjLDhrnEQ2beRoj/gW5eq+oP5PoBRD4BwxcW3RWAl
	 6GuZLwxHaR0tFEl0QHLv11rr0iTnelbEuJEcdrtf4H7sp3qdkz1CaTROUbJGpgeRG3
	 6j+1HOVIBo6gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during
 PCI enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260804192958.1823952-6-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:51:51 +0000
Message-Id: <20260804195152.4B1941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A malicious CXL device can trigger an out-of-bounds MMIO read by c=
hanging the HDM decoder count between the sizing read and the enumeration r=
ead.
- [High] Manually enabling PCI_COMMAND_MEMORY bypasses proper device and br=
idge enablement flows, risking fatal PCIe errors.
--

--- Patch [5]: [PATCH v10 05/12] cxl: Cache endpoint decoder settings durin=
g PCI enumeration ---
commit 14e10e2fbfc0ad9b68f5138b15e8cb4944bab222
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Cache endpoint decoder settings during PCI enumeration

This patch populates the pci_dev->hdm for CXL.mem functions early during
PCI enumeration from pci_bus_add_device(). This provides an early HDM
snapshot for driver-free reset paths while temporarily enabling Memory Spac=
e.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 97cb136cb2aeb..7f5946d3f2c4e 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
[ ... ]
> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				 struct cxl_register_map *map,
> +				 struct cxl_hdm_info *info)
> +{
[ ... ]
> +	hdm =3D cxl_pci_hdm_map(pdev, map, info);
> +	if (IS_ERR(hdm))
> +		return PTR_ERR(hdm);
> +
> +	decoder_count =3D cxl_hdm_decoder_count(readl(hdm +
> +						    CXL_HDM_DECODER_CAP_OFFSET));

[Severity: High]
Could a malicious CXL device trigger an out-of-bounds MMIO read here?

During the capability initialization, the component register block is mapped
using a size calculated from a first read of the capabilities. When
cxl_pci_hdm_read_info() maps this memory, it reads the capability register a
second time to get decoder_count.

If the hardware returns a larger count on this second read, the subsequent
loop over decoder_count will read from MMIO offsets that exceed the ioremap
size. If this crosses a page boundary into an unmapped page, it could cause
a synchronous page fault or kernel panic.

[ ... ]
> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
[ ... ]
> +	rc =3D pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc) {
> +		rc =3D pcibios_err_to_errno(rc);
> +		goto out_free_info;
> +	}
> +
> +	restore_command =3D !(command & PCI_COMMAND_MEMORY);
> +	if (restore_command) {
> +		rc =3D pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);

[Severity: High]
Does manually enabling PCI_COMMAND_MEMORY here risk fatal PCIe errors?

Because __pci_cxl_hdm_init() is called from pci_bus_add_device() before
drivers are bound and before pci_enable_device_mem() has enabled the
upstream bridge windows, asserting PCI_COMMAND_MEMORY directly on the
endpoint might create a PCIe topology hazard.

If the upstream bridges are not fully enabled (for example, with hotplugged
devices), they will drop the subsequent MMIO reads to the decoder registers.
This results in an Unsupported Request (UR) completion, which typically
triggers a Machine Check Exception or synchronous external abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D5
