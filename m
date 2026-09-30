Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453050C28B
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780282; cv=none; b=tqcq3hwzCekvN8uzhSS12HsqSKGaaNd5sOEIyJiwBN+zQz4AJPVoVr4wkYYoOjUgskrF6sqP1T16jzCwa+OWf11YeJLlz4s2DPWTG8bSC0ZaM0wfJmaW8PqUkNanz/VPoM8r5+7UQbIAt9GiRgBzBzww10dsf+epfogk965490I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780282; c=relaxed/simple;
	bh=rJVHtpnNVeW1PTdlM4zl77WCdFBekMcx6et62ALZYI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=he9Kdu9tIf521zvaA+DysMMtMxwl3+qRS0EG6vH6SMj1ngqq3XCtf7eYb3ittuRZkWcmPgxNd/lfaAEpfZVZVgGdgaoUm0kSaL8RljIL3Qv4TVkAp5qzUFAsWVqIX0RLc7Awkq/niQNMX3a8uAybhhQ7Q79KfmkHRt5+qTg09a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPepsKKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPepsKKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D4D1F00893;
	Wed, 30 Sep 2026 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780272;
	bh=AMccqmfckUraKLHnYGS/RLNQnla8bsKTWtfBzhpZ0K4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KPepsKKMz5INVLk/tzGktRplYa5gVYXWkKLAWzkSMAxjdMry6bYflgJg+cqec7rh7
	 9p+Lb5XwDPeCNG9VtRNWlurGvv5PhIe8Z0r7ZjYDkjnG05F3q0v5+XZ3dh+KVgTeC1
	 5PigJdoRwPWiJC6Ufx4GxQTj8Gkr+3TOPUd3QOJ26nH243EyuhuZHQJnNn+AXXkiju
	 Un/objUfO3LHQIye+8wy8cFe/nRnHfvgUybTT4L2uVRdd8PdWFigVmJfO+GmLzRY38
	 QNvw75TVGpJkOxKoGiGNFlSIITsRXLiMN0NTAY74Mf1s8lpoV7ucgeMtn4RR+vIRQj
	 0D96KGWGktj9g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] PCI: meson: Remove redundant MPS configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260930145017.1356088-10-cassel@kernel.org>
References: <20260930145017.1356088-6-cassel@kernel.org>
 <20260930145017.1356088-10-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:57:52 +0000
Message-Id: <20260930145752.C0D4D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pci: outdated comment refers to payload size instead of MRRS
--

commit fd8144661bbd8beb3bd09f490b10ee35de5073e6
Author: Hans Zhang <18255117159@163.com>

PCI: meson: Remove redundant MPS configuration

The Meson PCIe controller driver manually configures maximum payload
size (MPS) through meson_set_max_payload, duplicating functionality now
centralized in the PCI core. Deprecating redundant code simplifies the
driver and aligns it with the consolidated MPS management strategy,
improving long-term maintainability.

> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/control=
ler/dwc/pci-meson.c
> index 8559d132dcde8..1d3687566ddaa 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c

[ ... ]

> @@ -256,7 +254,7 @@ static void meson_pcie_ltssm_enable(struct meson_pcie=
 *mp)
>  	meson_cfg_writel(mp, val, PCIE_CFG0);
>  }
> =20
> -static int meson_size_to_payload(struct meson_pcie *mp, int size)
> +static int meson_size_to_mrrs(struct meson_pcie *mp, int size)
>  {
>  	struct device *dev =3D mp->pci.dev;
> =20
> @@ -266,35 +264,19 @@ static int meson_size_to_payload(struct meson_pcie =
*mp, int size)
>  	 * dwc supports 2^(val+7) payload size, which val is 0~5 default to 1.
                 ^^^^^^^^^^^^^^

[Severity: Low]
Since the function has been repurposed and renamed to calculate MRRS (Max
Read Request Size), could this comment be updated to refer to MRRS rather
than "payload size" to avoid confusion?

>  	 * So if input size is not 2^order alignment or less than 2^7 or bigger
>  	 * than 2^12, just set to default size 2^(1+7).
>  	 */
>  	if (!is_power_of_2(size) || size < 128 || size > 4096) {
> -		dev_warn(dev, "payload size %d, set to default 256\n", size);
> +		dev_warn(dev, "MRRS %d, set to default 256\n", size);
>  		return 1;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145017.1356=
088-6-cassel@kernel.org?part=3D4
