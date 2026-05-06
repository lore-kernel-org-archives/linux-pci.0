Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0DC355F25
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100932; cv=none; b=Ku/6INFiiDHPfq1kGqv8lOl8tEqXNm3CcVBb+aaGIGp3P4gKdGbBEDe9qEuyQkGEZtY1rRzv3Gbb8z/a1+cpxPJxXhRlQbV5LgKqcguTX3ZCKyDdfMXLnZRQowzq/Ef9U3LmJoR4PXyTab/zJItseinfImoXmU2P7G2nShHlPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100932; c=relaxed/simple;
	bh=KV9N3HMDZe9iB27wUyhT0PmERVNMt82BheECX206Rtw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qCTsT6ObOmTwveIvsmQPRozFfF7i4uvyfa84l+213C8V9AGWsvdFnWjG+6fOYGSV91RH1+6jL1cHWUIR+d/hROKSPbiXqx9W8n8i0m9b4yCzdpROLQ9sRWSvE64aISNmo/sHJPhNMs4vsWK5k7TJb8xsWFufNmqyRi/ayLLg9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtqiW+qn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtqiW+qn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D863C2BCB0;
	Wed,  6 May 2026 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778100931;
	bh=KV9N3HMDZe9iB27wUyhT0PmERVNMt82BheECX206Rtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QtqiW+qnjUj5oPju5CY995h7NMWt3o3ADE6PM8/TKMfTBel/tm17jsyVQQ1hxsEWa
	 dHhLnA0DUWwo/24QD8T/fJr47o8KEYACiZltGFaNfskmJFggTU+swaTTXSkgtdS9lV
	 7JB+7aBNGM4bRS2wzu9ZclsaBUXiP0v2QQxVw131l+uWnjyswLj2LNSMP3IjYv/kqT
	 uOKsbdT7A8Y5NViBekiWn0EjmjEAyCyEkzPJ80ddawFlG8p8glX30QxQRmeiZmAgV+
	 s9l63VkDEc3IqoYIc/kwp64T5fGXrZF/rPZWmsH1LtvgoycB9XtQugtT6+nRBNPXYv
	 sXP3X9FLSkzTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] PCI: tegra: Explicitly specify PMC instance to use
Reply-To: sashiko@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-pmc-v1-5-a6de5da7216b@nvidia.com>
References: <20260506-pmc-v1-5-a6de5da7216b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:55:30 +0000
Message-Id: <20260506205531.7D863C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unassigned error code in tegra_pcie_get_resources() when devm_tegr=
a_pmc_get() fails causes a kernel panic.
--

commit 03b6ac6d72e8b9fdb4c4e55b15fd0c26dfc93236
Author: Thierry Reding <treding@nvidia.com>

PCI: tegra: Explicitly specify PMC instance to use

Currently the kernel relies on a global variable to reference the PMC
context. This commit updates the driver to use an explicit lookup for
the PMC and passes that to the public PMC APIs.

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 512309763d1fb..2c6c521e69017 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c

[ ... ]

> @@ -1432,6 +1436,12 @@ static int tegra_pcie_get_resources(struct tegra_p=
cie *pcie)
>  		return err;
>  	}
> =20
> +	pcie->pmc =3D devm_tegra_pmc_get(dev);
> +	if (IS_ERR(pcie->pmc)) {
> +		dev_err_probe(dev, PTR_ERR(pcie->pmc), "failed to get PMC\n");
> +		return err;

Does this code accidentally return success when devm_tegra_pmc_get() fails?

If devm_tegra_pmc_get() returns an error pointer, the error path is taken,
but err is not updated. Looking earlier in tegra_pcie_get_resources(), err
is 0 from the successful call to tegra_pcie_resets_get().

If the function returns 0, probe will continue with an error pointer
stored in pcie->pmc.

Later, when tegra_pcie_power_on() calls tegra_pmc_powergate_power_off(),
will it dereference this error pointer and cause a kernel panic?

Should this return the result of dev_err_probe() instead?

> +	}
> +
>  	if (soc->program_uphy) {
>  		err =3D tegra_pcie_phys_get(pcie);
>  		if (err < 0) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-pmc-v1-0-a=
6de5da7216b@nvidia.com?part=3D5
