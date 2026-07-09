Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287BDF6C;
	Thu,  9 Jul 2026 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559875; cv=none; b=LLv/zMiEfOmuKerjwzzRUNCENY/ACG+Z4S0MnpmfKq6Nh2pu5af40MFmGNVsoPBEQF/TVMQSWOvQ+zZeD4fG1StSEAqPakwwdeXXfxN1fTTbC3DCrRypc2rbjZBezXA0wrVEYqnQW6FndTiM23/p4vUr8LWaJKd4K4xW7TTWaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559875; c=relaxed/simple;
	bh=x6An3o3hCx4Ob6kJRNXXsvohqazfeeTuVHHctyOEa8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jz4QnbCOyBH55YM/xL4K3ELc3P8PYrFvR/RBaXtBccdgHTg3h9DAHa/b8dH+O7o6FDxFTx6yMjl7y310u6tUf/5dHAs7XO/SRlrwbdknB8oJn4BEil5nEyVFRQ75T6rUUmYGj37FsTQl01tUZTAjoYUS6wiDVo15KRCDkQe9zpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1C0bb6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1C0bb6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9867E1F000E9;
	Thu,  9 Jul 2026 01:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559873;
	bh=4MMr5Yafd+8H5/b7rM+mUdwNj0xPsnMEWyOVLmKeOok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1C0bb6VEaR/KrvxJDBPeE6bxtSLYz9gDCWMWFbx6EOfMRQ/eM5H7MicREwlajp28
	 HsTVC841xV440jfeyGxFzNn5SJOG6O284pd5ADJORYC5UifBGlQiu6x36ls5V7gvXB
	 2U/5SgjB9J6C6+pY/J6N572sSRIfIDrKnGwktFStR3u9cZaT+MYTh+sv+96I8xjnYi
	 p0PjDvbss3JluP0kWNaCQ2zgPsx7u7X5qI6hoXMx0sOLUJHc+PBfiDOYAt228tuCJL
	 e2d6PD7IIq++rGQ+7GuyfAvXInQvZ7rW4+FxgYC0xHmvxY4p9GwQhEAt0myQ1YL+SP
	 tgf5zIo0L90gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/11] cxl: Cache endpoint decoder settings during
 PCI enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260709010304.680422-5-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:17:53 +0000
Message-Id: <20260709011753.9867E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Enabling PCI_COMMAND_MEMORY and mapping unassigned BARs during ear=
ly PCI enumeration causes severe resource conflicts and system instability.
- [Medium] Mixing goto-based error handling with scope-based cleanup helper=
s (`scoped_guard()`), leading to a logical fall-through bug.
--

--- Patch [4]: [PATCH v9 04/11] cxl: Cache endpoint decoder settings during=
 PCI enumeration ---
commit 64ea438bc1dd54d340a46889f9f340251bdf644f
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Cache endpoint decoder settings during PCI enumeration

This patch populates pci_dev->hdm from PCI capability initialization
for CXL.mem functions. It temporarily sets memory space enable to read
HDM MMIO and restores the original configuration value.

> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c

[ ... ]

> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{

[ ... ]

> +	if (!(command & PCI_COMMAND_MEMORY))
> +		restore_command =3D true;
> +
> +	if (restore_command) {
> +		rc =3D pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);

[Severity: High]
Is it safe to forcefully enable memory decoding before the PCI core has
verified or assigned safe base address registers?

Since this function is called during early enumeration in
pci_init_capabilities():

drivers/pci/probe.c:pci_init_capabilities() {
    ...
    pci_ide_init(dev);
    pci_cxl_hdm_init(dev);
    ...
}

Could uninitialized or overlapping physical addresses cause the endpoint to
decode transactions intended for system memory, leading to resource
conflicts or machine check exceptions?

> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +	}

[ ... ]

> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		if (pdev->hdm)
> +			goto out_unmap;

[Severity: Medium]
Could this goto inside a scoped_guard() block lead to logical fall-through
bugs?

The cleanup subsystem guidelines advise against mixing goto and scope-based
cleanups in the same function. If pdev->hdm is already set, execution
jumps to out_unmap and then falls through to out_restore_command.

Could this cause the configuration write to be re-executed redundantly
during the error handling fall-through?

> +		pdev->hdm =3D info;
> +	}
> +	iounmap(hdm);
> +	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D4
