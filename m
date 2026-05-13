Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885639734B
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644734; cv=none; b=WhcxzZ+Y4Vjo0Aed49nkl5T7RuVJelDRZaEjy9GFgAcdsVhP1to27A9HjKh2EdCH3u0WL4qyUxkK2Fos9HI8dAYGetk0crdXnMR/4MooT1EuAGqWV6zXzcbQes7inTwdFXaID/3fXL89NOGPkP8EdYquGb9MdthpDZzSol349qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644734; c=relaxed/simple;
	bh=zPzfMCz3c4jliJ8m565eugL/iH+vQvnrlYj7sEjQK1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EBUQBEeL+VEGkqFpSCpN0RZ+dxvgobnbJgUH1lXVehuqsu/BWqJI9+3vlcjnG1phRr0/XI2NH2/wtdBz7UHikoTd17GfdByK1kSaL79XrTKMY9vIG6cCzbasMoyhufv/HJPz81sv59jYfaKiTsSNqc7rJgJBP9IKEZXcND4Mp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV+xtr8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV+xtr8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C09C2BCC9;
	Wed, 13 May 2026 03:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778644734;
	bh=zPzfMCz3c4jliJ8m565eugL/iH+vQvnrlYj7sEjQK1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sV+xtr8nxmA7tq+nBDzOS/YqhwzRB7S5HnlB3vdjH3BFD+B88eMThFnWWY8sHnkAU
	 C9AjxW0PmyrUgj67ojBohxKGM/RYERCv5JbCDfoARfSQn0jgI2KJe0rgZ8ammkdPYJ
	 qv3gSdCMmEq9V3deXn4vg6dY/biUwcsVDTmW5PcauXFsStjJNYH5lUXAJt3KOdMYze
	 AqDLes6tk1EJQe1Om4q+e8XW9QiMO4NJrwP0LWxbGYJS6woVOVKwDZokGO4TFXNL1j
	 0UNQ5UIetWmeAU1TZ0q5vszgaM7ibi6JjHvC7UjpQK6xleeyPbGXLlujZJ+Q4AuDhS
	 HZxAbW5ROId6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: tegra194: Use aspm-l1-entry-delay-ns DT
 property for L1 entrance latency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512034821.1320714-1-mmaddireddy@nvidia.com>
References: <20260512034821.1320714-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:58:53 +0000
Message-Id: <20260513035854.21C09C2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] L1 entrance latency calculation prevents programming a hardware =
value of 0.
--

commit 63300af08363595c90cc1e642b1cf857792eae94
Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>

PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance laten=
cy

This commit parses the aspm-l1-entry-delay-ns device tree property to
configure the ASPM L1 entrance latency. It converts the delay from
nanoseconds to a 3-bit hardware encoding.

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index 9dcfa194050e7..c9716d6144517 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
[ ... ]
> @@ -1141,6 +1146,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pci=
e_dw *pcie)
>  		dev_info(pcie->dev,
>  			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
> =20
> +	/* Default to max latency of 7. */
> +	pcie->aspm_l1_enter_lat =3D 7;
> +	ret =3D of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
> +	if (!ret) {
> +		u32 us =3D max(val / 1000, 1U);
> +
> +		pcie->aspm_l1_enter_lat =3D min(ilog2(us) + 1, 7);

The commit message states the value is converted to a hardware encoded 3-bit
value that is equal to log2(ns/1000) + 1. Does this calculation prevent
programming a hardware value of 0?

By using max(val / 1000, 1U), the minimum value for us is 1. Since
ilog2(1) + 1 is 1, pcie->aspm_l1_enter_lat can never evaluate to 0.

If the hardware supports an encoded value of 0 to represent delays less than
1us, this logic prevents configuring it.

> +	}
> +
>  	ret =3D of_property_read_u32(np, "num-lanes", &pcie->num_lanes);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512034821.1320=
714-1-mmaddireddy@nvidia.com?part=3D1
