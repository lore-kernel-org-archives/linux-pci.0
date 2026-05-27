Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE13955DF;
	Wed, 27 May 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880808; cv=none; b=MttuPGTxVHfd4kLbGlHkrRViJUF4JfleH9QBkeiMSFkbQiyd6xVUHl+Ow/UUyB7uV1tqesQ7xJ8e+p4dnfDyonjagpawegevwYQhkHc23yCqZXSRBMY9zJINXN256t+5bPgO9vQsGOVRIodcY2wWn1JV3wVus2NUo0kVboDwsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880808; c=relaxed/simple;
	bh=A+BLCqaKxTIHa47CJMGggdaSPFGT0PJC6CoVyGwWyyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XwPPOTGdCLd8KPA4fbyo6TXt0Dal1pdCm7zR4kExbPj2jEcwtrEwbux6h0blA7Xg9l1tVeH2SfwXR3NNW4/MXFHG1ybQP79VR6SK6EaM5XhyinTyV3UEE9WlmheB0rdmlrDfHraF/xAjv7e84G6HFbgQ1TmeIp/qyhsbV9KL/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOXeu00F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOXeu00F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEFA1F000E9;
	Wed, 27 May 2026 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779880807;
	bh=v+mxMF5JZecrJK4oh9XVuajQZXGetsvxGH6jXOUj9dY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IOXeu00F5P2nGJgAvw7QTP9Y9QXeka0Po16u7PZKJDrME+/9rKN0jpTtehthOonWo
	 HFpAS4xl1kgRY8Hp5huCkckKvKH3iHSl2Jx7QCREtRgEPUY6cO/6KXc8ziAY8Cqb1F
	 N54P1Qw6g+6YJUGp3iF2OxbR3hTZvBe0RbR7ZIyuqTE+60QxTUxQHxq+Fh9/hqoQNC
	 TE2+J6/yqKe+bjfJOwFAjOWw7BVSNTLMV2aG7xgvWjqDutzpu6+bO+rP2DFKc4raL0
	 bjEeCXJNngJWWXkfGHoBJqCfs9W3ki5YZ/1LzDJCGfJpTDOCl3SeQ0MY8BF7WB1IDa
	 AkOr1E9Ep2ZPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/8] PCI/TPH: Add requester selection policy to
 pcie_enable_tph()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260527094719.43886-4-fengchengwen@huawei.com>
References: <20260527094719.43886-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 11:20:06 +0000
Message-Id: <20260527112007.3BEFA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pcie_enable_tph() modifies pdev->tph_mode before fully validating t=
he req_policy argument, leaving the device structure in a partially updated=
 state on failure.
--

commit 1247d68c408062186e5926e12085a0075507cc92
Author: Chengwen Feng <fengchengwen@huawei.com>
PCI/TPH: Add requester selection policy to pcie_enable_tph()

This commit introduces a new policy argument to pcie_enable_tph() to control
TPH requester selection. It updates the function signature, handles the
selection logic, and adapts existing callers in the bnxt and mlx5 drivers.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index b4ecc510033ab..04ff051ebed34 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> @@ -403,8 +410,18 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
> =20
>  	pdev->tph_mode =3D mode;
> =20
> -	pdev->tph_req_type =3D pdev->tph_ext_requester ? PCI_TPH_REQ_EXT_TPH :
> -						       PCI_TPH_REQ_TPH_ONLY;
> +	if (req_policy =3D=3D TPH_REQ_AUTO) {
> +		pdev->tph_req_type =3D pdev->tph_ext_requester ?
> +			PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
> +	} else if (req_policy =3D=3D TPH_REQ_STANDARD) {
> +		pdev->tph_req_type =3D PCI_TPH_REQ_TPH_ONLY;
> +	} else if (req_policy =3D=3D TPH_REQ_EXTENDED) {
> +		if (!pdev->tph_ext_requester)
> +			return -EINVAL;

[Severity: Low]
Is it intentional to update pdev->tph_mode before fully validating the
req_policy?

If the policy validation fails here and returns an error, the device
structure is left with a partially updated state. Even though
pdev->tph_enabled remains 0, could this partial update cause issues later,
or should the pdev->tph_mode assignment be deferred until after all input
validation is complete?

> +		pdev->tph_req_type =3D PCI_TPH_REQ_EXT_TPH;
> +	} else {
> +		return -EINVAL;
> +	}
> =20
>  	/* Write them into TPH control register */
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527094719.4388=
6-1-fengchengwen@huawei.com?part=3D3
