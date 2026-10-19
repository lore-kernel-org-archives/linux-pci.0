Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D73CAA2F
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392962; cv=none; b=YZj3A1TcSVE0Wc7+NBLlthL3ReLwOQ6JIiPkQaZ5PU+IZFez18rKlGeC8jLQKbxtgSnnT6+tHLOKeQtJagtQrXC6WyxpLVSwbOGoEdjBtxsoXzFkWREGyMwyMRqgMGunrhviz52S+cBI1mSfmWSBARO0IY2wbbr7DIRUhI/HM6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392962; c=relaxed/simple;
	bh=4wHRS2S+HrN8z5w31aD1ea7ceCBvKUTTLKRuyzxo2oE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OUP8iep/NMzn77e1fLbGFkFYmU13yh18AgpVsfi9HdVUcth2OtSfp+rKtYaNX8VCgfI8RWrzr5AKOvPB/RG5wbRK3p6Q7zQkjA25KS4wsTSrupR4YzVUrYGslDczBc0SQfMeoGL/YoTA9gNXNptDjpuer6I2dhhbmY6Vnd7ZDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgLV2i86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgLV2i86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB8C1F000C4;
	Mon, 19 Oct 2026 06:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392960;
	bh=4wHRS2S+HrN8z5w31aD1ea7ceCBvKUTTLKRuyzxo2oE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DgLV2i86vhYJkZPMBISRf956rQgtNmTibQI6PvAwLLrHPbdowSRXKE6BEkmvnNcKO
	 jeVz8F/fOT3aD4oI7wTwqDHCjXRpFx433Xopx8WKRk97wnWUZmVJV3SjHAtLPH9KTM
	 vriz2/tQlDYByjgWqInFcsMjrYFAzZA/E30LpV/udUd8fqj57VmRwuo73bHgOKYjjp
	 O3hhLxYzeRefie5IYcBe1BwqbpE7LSaS/K2SQaBNZ7baxqbxPuBGmgyHqji2KzlH1s
	 PTsmMddpP7jCspGcB0Rmo7+1jjQCDChWAl8fnqvM94IyiyOIrKXS351VeOazlyv2Qw
	 W64whjHaZsMWg==
Message-ID: <sashiko-outbox-176719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: iproc: Skip BCMA-attached controllers in the
 platform bus driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Semih Baskan" <strst.gs@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065249.552-1-strst.gs@gmail.com>
References: <20261019065249.552-1-strst.gs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:56:00 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since commit 767012397976 ("ARM: dts: BCM5301X: Describe PCIe
> controllers fully"), the Northstar PCIe nodes under the "brcm,bus-axi"
> node have compatible =3D "brcm,iproc-pcie". bcma_bus_register() creates
> platform devices for the children of that node before it registers its
> own cores, so pcie-iproc-platform probes these controllers before
> pcie-iproc-bcma does, as IPROC_PCIE_PAXB.
>=20
> IPROC_PCIE_PAXB sets has_apb_err_disable, so the first config read on
> bus 1 reads APB_ERR_EN at offset 0xf40. The report in the Closes: link
> shows that read taking an external abort. On a BCM47081 (PCIe core
> revision 0x01) with a device behind the root port, the board does not
> boot, and it boots when has_apb_err_disable is cleared.
>=20
> Return -ENODEV for a controller whose parent is "brcm,bus-axi", before
> the driver allocates or maps anything, so that the controller is left
> [ ... ]
> Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully=
")
> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Closes: https://lore.kernel.org/r/0dcfb2db-5536-465a-bee1-afe160535748@br=
oadcom.com
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.c=
om>
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065249.552-=
1-strst.gs@gmail.com?part=3D1

