Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402045;
	b=Gc6+Gwl/xStDKoU4aruXeVWwc5Lrk5IJNuVmLwzyY/LxfVvrLCxuS7ZXOVgBlfVch0tO
	 9za8G+KnIouSWJ/3hOU+XCTzzIc4Un5Z2tu0lTLVaEBjS0QgfRmRiXWpi7LUXPHc5W6ty
	 hcjfr3CIZqkwQuvV7VImW+e/zRil6U1C3mqZf4iHfJkUD46BrhMyQZ1SQfmOZbl2blBo5
	 Pkyc3sm5POVlLBldqTwlozWXNXqkMHc8W9TdwUObFz76r5TjI5oPz4zE2+NIMrb3t+W73
	 q3V+rGxdverNafIPAEDuqFif+4CbBpDJCBW3Barhf2wcIzaR4w4HlAK9rcQeRxwZizQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402045;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Czh0Ko5oqa5rTRS/v2Nrjsf0Qoc7ogQtXeqY/xF+hJU=;
	b=KVZKi2wzRsaU1G6qJ0CPPkQiKXYsFnpsUT8ITi5ms9sZA3Q6Xf3WeKHHgSxlxsc9WUUa
	 7lJHkapcGVfJE3LFn/xkJx6AWFnbMNBKSF/eUE93O83u6Z8j+Q9gPsJ7nCcfbm7h3hAML
	 o1n+FgphZz63uPK0oeAYv4DHVuFgeQbnT0UbvykZvHc0IR9jj6xgvgzgFoFHeU5XcNX4l
	 6UEjPhfV3ZqZazaNwqHURrrMbW1mwey+HMZ+In3JZk5BrxpqjNKRCrZt/4PCRP4spToUT
	 z+zX6L+z5rT8vRpctM5Syknj0n12ekbc6fyrbJ66FEQkxakDI2pYWIw826E6R3PSvYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MhZr+Aud;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB08606A33F;
	Mon, 23 Nov 2026 02:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MhZr+Aud
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E857F1F000CA;
	Mon, 23 Nov 2026 02:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402045;
	bh=Czh0Ko5oqa5rTRS/v2Nrjsf0Qoc7ogQtXeqY/xF+hJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MhZr+AudlwbueZJMvfqSpcRwO6yI20gj3wwUdsZ3xOp2TAcIYXcr2lUWDrGAMUAH3
	 kMS1F4hd1QTFjS8cp7CDmr+SJFqJwV3D8nB7eBkyYCWWy4doD7KMdagdovasYg2ELq
	 HxRfIqKl9aBQ20uqrT/N4hRCzN5/8OMpL+QgirDQtJFNZ8cJkR0S3En3SRqc1cPtLv
	 PcO/pYJHLYItXYiDR9F3zmyjMowSHwJq6vg8YATGQPf76fFtT4Octmxz5doTkUlfGY
	 4ceL08sxwbVYqiLfG94XZmyc9Z0IGq0dCbP+yAZnHGn7Y7MlOFEN05uFN94rAalGLO
	 yMKhF42o934tg==
Message-ID: <sashiko-outbox-228563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 06/13] PCI/TPH: Add helpers to check standard and
 extended TPH support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261123023628.7728-7-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
 <20261123023628.7728-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 02:47:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI/TPH: pcie_std_tph_supported() ignores pci=3Dnotph
  disablement
--

commit 27f6eee7fc0406491da1b19ccf2dc89f4e4551de
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add helpers to check standard and extended TPH support

This commit adds pcie_std_tph_supported() and pcie_ext_tph_supported()
helper functions to query standard and extended TPH requester support via
pdev->tph_max_type.

> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 04c93822ee6d6..5defe407ef75b 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -23,6 +23,24 @@ enum tph_mem_type {
>  };
> =20
>  #ifdef CONFIG_PCIE_TPH
> +/**
> + * pcie_std_tph_supported - check standard TPH requester support
> + * @pdev: PCI device
> + */
> +static inline bool pcie_std_tph_supported(struct pci_dev *pdev)
> +{
> +	return pdev->tph_max_type >=3D PCI_TPH_REQ_TPH_ONLY;
> +}
> +
> +/**
> + * pcie_ext_tph_supported - check extended TPH requester support
> + * @pdev: PCI device
> + */
> +static inline bool pcie_ext_tph_supported(struct pci_dev *pdev)
> +{
> +	return pdev->tph_max_type =3D=3D PCI_TPH_REQ_EXT_TPH;
> +}

[Severity: Medium]
Should pcie_std_tph_supported() and pcie_ext_tph_supported() return false
when the kernel is booted with pci=3Dnotph?

pci_tph_init() sets pdev->tph_max_type during enumeration without checking
pci_tph_disabled, while pcie_enable_tph_ext() rejects enabling TPH with
-EINVAL when pci_tph_disabled is true.  When pci=3Dnotph is active, these
helpers still report TPH as supported, allowing the VFIO TPH feature in
the following patches to be enabled and exposed in virtual config space
even though guest writes to PCI_TPH_CTRL will fail in
pcie_enable_tph_ext().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123023628.7728=
-1-fengchengwen@huawei.com?part=3D6
