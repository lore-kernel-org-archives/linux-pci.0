Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890F285CB4
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521414; cv=none; b=FmrNFHTla0p4gzrC/o+PzQ/U5u8Tr+L/OUEZwOEmqCY2FvS/SxHwYBXjPhK4Y1h1N1SSqHkO6JhMF8WFE6tQg8iL8LoveBO1Ni+2RZSZeVF3oW7Xl5wz6Kqi09n67dU6AldtCoq6yPjqBAK4t5aS/wzs1iZTIfxwXYLPIath2oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521414; c=relaxed/simple;
	bh=QvUs+hoXBKc2GpSV21qnsUMI7Wve21ug3kOyH15tsuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uRErRLJt7DUr+sg223aAWv7bQo2HeEWnJbqNtasCuugf7IF+l8f3aBPFURfKnwZqpAAwv8CwdouH+n6LBZhqInRhIhqCIXtbRJYKBuRTpL9ga2YMxuBOp5xNWD6/H/bIJUcOV7P34CinD/1EUisdeitENJVVMo635dDPyIX3rhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPY96dRo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPY96dRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB6F1F000E9;
	Wed,  8 Jul 2026 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521413;
	bh=C0eQQvU3TeCKjlsM287H4aWOZK1Oh38UcgfH10/GxD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KPY96dRo6mww+4UzQqfV7XS8RWKy4AzridWvQgUhLiNKZ92s/qwuciJbXAPT54EFG
	 C5cRDdLyZcysbr/VdlluSbA9d1poXt0U4LqtID+6qc+q0pX87/5G0Gquu4JCP9qCdN
	 BSmX5zWSitrI7azs6yO1M/NUXYCYRn55hoMaAQwuhNtI/7iF/mos2hQKpe2XQHspRe
	 1QUIUj9rl7Fn+RLQ3uZk0m2ZNeP2n/+fEdAHgOuxW1Xmk6HTKiH55FAcqdQYUUj6JX
	 B689Atlx6JsiRHcr4lVCJlZXAt7v/SNxtdN8HyY7PX9CTtvPpuSzdV2tw236GCpyAg
	 fKbjLllBbfWQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] PCI/ASPM: Return enabled ASPM states from
 pcie_aspm_enabled() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708-pci-aspm-fix-v3-5-6bd72451746e@kernel.org>
References: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
 <20260708-pci-aspm-fix-v3-5-6bd72451746e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:36:52 +0000
Message-Id: <20260708143653.0BB6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `pcie_aspm_enabled()` returns a boolean literal (`fals=
e`) despite its return type being changed to `u32`.
--

--- Patch [5]: [PATCH v3 5/8] PCI/ASPM: Return enabled ASPM states from pci=
e_aspm_enabled() API ---
commit 075855b1906924e43de63fd5d55e7d8fedc2a01b
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI/ASPM: Return enabled ASPM states from pcie_aspm_enabled() API

pcie_aspm_enabled() returns the pcie_link_state::aspm_enabled parameter whi=
ch
contains the enabled states. But the API currently returns the bool type
which is used by the callers to decide if ASPM is enabled or not.

To allow the future callers to also make use of the enabled ASPM states,
this patch returns the actual type of pcie_link_state::aspm_enabled, u32.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 5e7e199c78d26..3ce6b93195663 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1694,15 +1694,17 @@ module_param_call(policy, pcie_aspm_set_policy, p=
cie_aspm_get_policy,
>  	NULL, 0644);
> =20
>  /**
> - * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
> + * pcie_aspm_enabled - Get the enabled PCIe ASPM states for a device.
>   * @pdev: Target device.
>   *
>   * Relies on the upstream bridge's link_state being valid.  The link_sta=
te
>   * is deallocated only when the last child of the bridge (i.e., @pdev or=
 a
>   * sibling) is removed, and the caller should be holding a reference to
>   * @pdev, so this should be safe.
> + *
> + * Return: Enabled PCIe ASPM states. 0 if ASPM is disabled.
>   */
> -bool pcie_aspm_enabled(struct pci_dev *pdev)
> +u32 pcie_aspm_enabled(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> =20

[Severity: Low]
Does this code still return a boolean literal on the error path?

Looking at pcie_aspm_enabled(), the error path still returns false:

    if (!link)
        return false;

Since the return type of pcie_aspm_enabled() was changed to u32, returning
false compiles because false evaluates to 0, but it obfuscates the integer
semantics of the function and might trigger static analysis warnings. Could
this be updated to return 0 instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-pci-aspm-f=
ix-v3-0-6bd72451746e@kernel.org?part=3D5
