Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF2485945
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392795; cv=none; b=m3Yq6sOc6jNz878VcYhNEgacSJNzuyfYLCWQEuz9H2CDKroFg8gZvBt7GEN/nGq/IAS73157K5DTDqFVMFpCYdxGkTtgKZn+nwBuYh4p18yOyAhEahDO+eCF3ayqyxBoBvzGJFoB6uayNiqkQ/WIFkFAmAkRXmSEKriSkFoDPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392795; c=relaxed/simple;
	bh=OhdPqQYFy/eFVyd5jw1o1F0L9E3mPmnkhEz1GKBLK8U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sbEzK9P1ov7i0pyLYXFygbBBNf160WVpERwWut+emoGvFxvaVBhvfPAvNaA2a+IIKFBvn4q8tmAQzLJqy25ZbjT/xyqh85v2xXdzyF55lD8N44N64LxNMhwComZ/r+fZ4tVq+b+ZTsr2ZpucDWoQHTa1LFC/6S7hNRCfql7x4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwXLEvhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwXLEvhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF28E1F000C4;
	Mon, 19 Oct 2026 06:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392794;
	bh=DnWVsNXIesTC8Cp5P/vjXVzV6zhhynT7jjUglIYSYAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UwXLEvhh9rKyY+ED+vPtKs4DlRikD7Zn30Q0cZiJQ1Q/AMAGnIzpImpKkF7Ur5tIv
	 tjOXgDRZf/ZuviLcDsBz5eyYbpb5EaX9CFAh2pvaACNfrM1DdbZYfK8LQkCdHrkViy
	 XGbcwrvIkJeTr2HS0TVdtgN87N1lzGe2+1Lmc3crvrcHPEW0dqETfonEc2XQ24TzqO
	 yFMyKb8i1FpWqMwcA9KRwt9POR4gdTAHateENMWgekjWObOWIdz5KD6udBxAtjb0Bm
	 v8JZihlozyAN/pGbbMJfaZ4uU/ORh97piLl6N3kCP7fUKK770aqlVdLrbEl38F/vUI
	 DFxx8ksJVy6xQ==
Message-ID: <sashiko-outbox-176707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: ultrarisc: Remove bypass_ob_mem_iatu variable
 on DP1000
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xincheng Ji" <jixincheng@ultrarisc.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019-dw-pci-fix-v1-2-9b7860f919b9@ultrarisc.com>
References: <20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com>
 <20261019-dw-pci-fix-v1-2-9b7860f919b9@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:53:13 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI: ultrarisc: removing bypass_ob_mem_iatu after struct field brea=
ks bisect
--

commit 64e39828c5cda3565ca7342abcafed6f323d27d1
Author: Xincheng Ji <jixincheng@ultrarisc.com>

PCI: ultrarisc: Remove bypass_ob_mem_iatu variable on DP1000

This commit removes the assignment to pp->bypass_ob_mem_iatu in
ultrarisc_pcie_probe() now that the DWC core handles identity-mapped MEM
outbound iATU bypass directly.

> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/co=
ntroller/dwc/pcie-ultrarisc.c
> index 523f454c6c524..a0d328c0c09b7 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> @@ -154,12 +154,6 @@ static int ultrarisc_pcie_probe(struct platform_devi=
ce *pdev)
> =20
>  	pp =3D &pci->pp;
> =20
> -	/*
> -	 * DP1000 routes MEM transactions without outbound iATU windows, which
> -	 * avoids the 16-window/4GB-per-window aperture limit.
> -	 */
> -	pp->bypass_ob_mem_iatu =3D true;
> -

[Severity: Low]
Does splitting this removal from the preceding commit ("PCI: dwc: Skip MEM
outbound iATU setup for identity mappings") break bisectability when
CONFIG_PCIE_ULTRARISC is enabled?

The preceding commit already removed the bypass_ob_mem_iatu field from
struct dw_pcie_rp in drivers/pci/controller/dwc/pcie-designware.h:

struct dw_pcie_rp {
	...
	bool			ecam_enabled;
	bool			native_ecam;
-	bool			bypass_ob_mem_iatu;
	bool                    skip_l23_ready;

while ultrarisc_pcie_probe() in drivers/pci/controller/dwc/pcie-ultrarisc.c
still sets pp->bypass_ob_mem_iatu =3D true until this patch, causing a build
failure at the intermediate commit.

Should this change be squashed into the preceding commit (whose commit
message already states "Remove bypass_ob_mem_iatu and the UltraRISC-specific
setting"), or ordered before the struct member is removed from
struct dw_pcie_rp?

>  	platform_set_drvdata(pdev, ultra);
> =20
>  	ret =3D ultrarisc_pcie_init_clks(ultra);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-dw-pci-fix=
-v1-0-9b7860f919b9@ultrarisc.com?part=3D2
