Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F0F3A963B
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798112; cv=none; b=C3YOO3fsY50JnbOUY0qLEnDvxDaNmyCN3VkEHG4UftRu6at/ikHyzzA227M+D09zkB9s4dyyt2bSfZ9+6hnYqVn4IRUgDyKldrU3WXjPe6qE+XfgpqTTZusqxXUODzaiNb6XD2w96PHZyxVdjmjrGXDUaiOyF2pgbsPVYzJhZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798112; c=relaxed/simple;
	bh=PJqC9la0QCKs70r0CMZUmrCob+OgB+3McxcZq9WoDT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RCK6SO/rHCf4ybzMAsMxITeoKs6pC/0czASQW31e7a2/KgePcfJF1U+CefPFQv18GZoNDWF5lYPLxnAgw2nPlPtFWZdixXQP1Zsd9sbWEs7SoLUcoXrjloY5O1ftLbON1R5NRMrlUF1XEcqUnYChhA283WpreMZCtTVGnGKHbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq9bxkaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq9bxkaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BF21F000E9;
	Tue, 26 May 2026 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779798111;
	bh=o0CSNQ8UlhzpV1bAqBYsiblA6esnkhUkKgZeWDum1JA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lq9bxkaKVQRxSSzyaDsQYO47b3iZLxQ2WUScaKy0guwyNtnWrjfqAZCY8J7UvYg2k
	 45tqUG8/TKKsHvUuD0hWUbUYAK24l8vQz+aztyiZtLaXkfVJcKi6JDIHPXdrvchdOU
	 ORPTuYY65eMJ2cmecpNfmLSIxIYRwUBmBqTwYYTIS/B9Oy2/g/C6CvvyQa1cusrkaO
	 CAjDxVwDsarwYbIAfiOKrOUBmS7HiPNQ9Gl4W2RqyWjC+RFl/MoE2UBW+HxaTig/ZV
	 P7ZacKFBVToc7VxOVpCJoHqbKU48jlqw58h69TJI+IIe0Sg9WsfsQYegOqBiS4RQ3e
	 NiHegXGNCyjFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: avoid duplicate PERST# GPIO acquisition in
 legacy path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kathiravan Thirumoorthy" <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260526-fix_perst_gpio_handling-v1-1-9170507bb4e9@oss.qualcomm.com>
References: <20260526-fix_perst_gpio_handling-v1-1-9170507bb4e9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 12:21:37 +0000
Message-Id: <20260526122150.D4BF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Moving `dev_warn()` into the recursive `qcom_pcie_parse_perst()` fu=
nction causes log spam for every descendant node.
--

commit e491f3a5670e129d05694d3da834893bd5b7fd00
Author: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

PCI: qcom: avoid duplicate PERST# GPIO acquisition in legacy path

This patch aims to fix probe failures on platforms where PERST# and PHY
are described under the Root Complex node by reusing the PERST#
descriptor obtained during Root Port parsing. It also moves the warning
about reusing the PERST# from the Root Complex node into
qcom_pcie_parse_perst() to avoid polluting dmesg during legacy bindings.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 11fc604898926..77cbd204ac5cc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1824,6 +1824,7 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *=
pcie,
>  	int ret;
> =20
>  	if (pcie->reset) {
> +		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be f=
ixed!\n");
>  		reset =3D pcie->reset;
>  		goto skip_perst_parsing;
>  	}

[Severity: Low]
Could moving this warning here result in log spam for every descendant
node in the device tree?

Looking at qcom_pcie_parse_perst(), the function traverses the device
tree topology by recursively calling itself:

qcom_pcie_parse_perst()
    ...
    if (pcie->reset) {
        dev_warn(...);
        ...
        goto skip_perst_parsing;
    }
    ...
    skip_perst_parsing:
        ...
    parse_child_node:
        for_each_available_child_of_node_scoped(np, child) {
            ret =3D qcom_pcie_parse_perst(pcie, port, child);

Since pcie->reset is globally set on the pcie struct, this block will
evaluate to true during all recursive calls. Will this cause the warning
to be printed repeatedly for every switch or downstream endpoint?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-fix_perst_=
gpio_handling-v1-1-9170507bb4e9@oss.qualcomm.com?part=3D1
