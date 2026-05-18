Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11EF146A66
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092083; cv=none; b=CYpKfi5XGYCEWwalWF58gO64E6aYodmMTpL1Nt0E9DCYUyRhVFqCu7lu52thWNBAIIqkBrnQDhPgz9xItWJK8l/+6NPJacbBHrX/owEjGYoUtxY/PYImsm4/9a1LLZZnF+bCvNt+shpT7M3iPgpq6n79IUKN87MP5gFx6yPl3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092083; c=relaxed/simple;
	bh=Ssc49JI/u9fqeDRpaZWEcr/nzFG7y4jetbvMexFQocY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=maCnG5536ZYqXob0ACIJPRkDwoKhDdBsi0cxhqL81BJ7V7wmBmUF+Jd4tkNZOhyCv7Zv6fNht8p0A5PbYyyTz09OgU7wpoJFchN1TylUoYCsa0AVGXrV7cOI2HleyxFuyrtX3OB8Ru8n69EQ3BQ12Ysv0Om8U6wPixrifI8Kntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe/fAfkg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe/fAfkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295C1C2BCB7;
	Mon, 18 May 2026 08:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779092083;
	bh=Ssc49JI/u9fqeDRpaZWEcr/nzFG7y4jetbvMexFQocY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qe/fAfkgU5BxvN62RAqhhqVfCbp0RfUVV4vmbAwMHIGkhayBf1S7Xsh5NmHI6jaCn
	 vShyA4YfOUKx+ILnRi0Pc4ZdYfrjOlbrOBQdc5ThzPyJMBHtuL9m7ZrsESv1AhSgpf
	 CLkmkWWHxqqgY0aYGzQ0EErCW2i7GIe5ajW4NfxmBJe7w2xbspTWMurfxbzfZdxki5
	 8JEqCJl9Vp7fulk1VmGx6mkFoW0dLY1xiD0QXL9bUbVmripbUdNzFz5g+mpg9k2R36
	 a5uI3xqP6HZUMuI3TKAKOMZLMU8Meq44djcQCq4/eq1NWosmwduNwZF8Qy1b2rt6nA
	 ypg/xUZgfxOlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/5] PCI/TPH: Add pcie_tph_enabled_mode() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518071701.25177-4-fengchengwen@huawei.com>
References: <20260518071701.25177-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 08:14:42 +0000
Message-Id: <20260518081443.295C1C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `pcie_tph_enabled_mode()` conflates the "disabled" state with th=
e valid `PCI_TPH_ST_NS_MODE` (No ST Mode), returning 0 for both.
--

commit 054f3de083c771d0143aa6293e77e165e4c44a41
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add pcie_tph_enabled_mode() helper

This commit adds a helper to query the enabled TPH mode on a PCI device,
useful for drivers like VFIO-PCI that need to validate TPH state.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index ba31b010f67ad..91c1e83410a3e 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> @@ -451,6 +451,18 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  }
>  EXPORT_SYMBOL(pcie_enable_tph);
> =20
> +/**
> + * pcie_tph_enabled_mode - Get current enabled TPH mode
> + * @pdev: PCI device
> + *
> + * Return the enabled TPH mode (IV/DS) or 0 if disabled.
> + */
> +int pcie_tph_enabled_mode(struct pci_dev *pdev)
> +{
> +	return pdev->tph_enabled ? pdev->tph_mode : 0;

Will returning 0 when TPH is disabled cause issues for generic callers
trying to differentiate between a disabled state and an active "No ST Mode"?

Since PCI_TPH_ST_NS_MODE is defined as 0, 0 is a valid active TPH mode
supported and enabled via pcie_enable_tph(pdev, 0).

If a generic driver uses this helper as a boolean check, for example:

    if (pcie_tph_enabled_mode(pdev))
        pcie_disable_tph(pdev);

it will incorrectly evaluate to false for NS mode, failing to properly
disable TPH.

Could this return a negative error code (e.g., -EINVAL or -ENODATA) when TPH
is disabled to avoid aliasing an active state with the disabled state?

> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_mode);
> +
[ ... ]
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 5772d48ea4446..28d0fa7621465 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
[ ... ]
> @@ -42,6 +43,8 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *d=
ev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline int pcie_tph_enabled_mode(struct pci_dev *pdev)
> +{ return 0; }

Does this stub need to be updated to match as well if a negative error code
is used for the disabled state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518071701.2517=
7-1-fengchengwen@huawei.com?part=3D3
