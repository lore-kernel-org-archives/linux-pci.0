Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0B3769EF;
	Tue, 14 Jul 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026701; cv=none; b=oygtfOi473n7YQp9MAD5vnCUXMxYWjCXniEuY8bkYo1UlLsQM/lgmeK6pkxmGKQNWld0v3g4XFOVEmiAWg9DGmLvVpklRBa81/R2VswpgO+hxr6t+1I5cbhe3qfyfp6pO7U8VCBDeSSmsx6nDvos/BH0S0JComgXjb+2JMKraLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026701; c=relaxed/simple;
	bh=wUQfOTBV1z72bQI2+np/Zvtf6Gy1xUjR3pa+CFSqY7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtQgSoMVuFL2Azlj3EGcefzpYR+XZbayfRUnDwZ5hYm4xQJ7k4JGYBGxdixTp+IYuwdvVa1fNXCrlCERSRM52Nj8fWCtqPcCNQ6RbOCUpRGMuvEAF9ZjSXVoAxdUhU3AKzvVg5jzptOwFHiidlIp/ilnkrZ1XK3K8egZW5vt2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clH/BbdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clH/BbdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A3D1F000E9;
	Tue, 14 Jul 2026 10:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026699;
	bh=cgAvWPJTgRp4ZoKQUInNMdSEGGzvQ1wrE6P9rwTfTYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=clH/BbdHgbL3HnJ6Bw5DRp27d/R2798gL2SL1/xTuYF/5tLNauDQqxXnUW+CpwWDL
	 U6qtpifrNbYILgCdssUwKVa+VN3SNV8nwqlzMgf59J2d+/tM9E9oS9W+NHtI3tmmNo
	 cMt9d9m+nnkyJU7X5WS+//IJARRHF+C9T2K+ydEq2+ZjyBhM3nob+oAyf6nsk8ny/n
	 nYGT0r/hxiMBP5lY2fQ4fqMJOw6yeu/PTftpZg5zSnWGw4pRmboHQVQ+nDS68QEEzL
	 r8WCFMMD0nUaiTZzPhJjtyZlsJdl+9dHO6YD+h/7ow3uOyThKef5dXLBSZnKjjfUw3
	 g4atf7QLhpZDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 07/16] PCI/TPH: Refactor pcie_enable_tph and add
 requester variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260714104325.54444-8-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-8-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:58:18 +0000
Message-Id: <20260714105819.72A3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The documentation in `Documentation/PCI/tph.rst` was not updated to=
 reflect the signature change of `pcie_enable_tph()` or the addition of the=
 newly exported `pcie_enable_tph_ext()` API.
--

--- Patch [7]: [PATCH v20 07/16] PCI/TPH: Refactor pcie_enable_tph and add =
requester variant ---
commit 644907fcc1b63e61928d9441e443b763ecf84aa7
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Refactor pcie_enable_tph and add requester variant

This commit refactors the TPH enable logic by renaming the original function
to pcie_enable_tph_ext() and accepting an explicit requester type argument.
It also updates the signature of the pcie_enable_tph() compatibility wrapper
to use u8 for the mode parameter.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index d123f91775c65..1239a919b9a49 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -463,6 +465,23 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL(pcie_enable_tph_ext);
> +
> +/**
> + * pcie_enable_tph - Enable TPH support for device using a specific ST m=
ode
> + * @pdev: PCI device
> + * @mode: ST mode to enable: PCI_TPH_ST_(NS_MODE / IV_MODE / DS_MODE)
> + *
> + * Wrapper for pcie_enable_tph_ext(), automatically uses the pre-cached
> + * tph_max_type value (negotiated maximum requester type between device =
and
> + * root port).
> + *
> + * Return: 0 on success, otherwise negative value (-errno)
> + */
> +int pcie_enable_tph(struct pci_dev *pdev, u8 mode)

[Severity: Low]
Should Documentation/PCI/tph.rst be updated to reflect these changes?

The documentation currently shows the signature as:

  int pcie_enable_tph(struct pci_dev *pdev, int mode);

It also does not mention the newly exported pcie_enable_tph_ext() API that
driver authors might need to use.

> +{
> +	return pcie_enable_tph_ext(pdev, mode, pdev->tph_max_type);
> +}
>  EXPORT_SYMBOL(pcie_enable_tph);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D7
