Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514D2ED843
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 05:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635712; cv=none; b=sl/cW1fssM9WP1cDVHgsZQHOzhTbdq/9E7hgJaDkGbtsyYSuebPSwA5HFO8qhgzZCNbJEGKQJ+N7uk0Y0FITZpHOhAEUbxuhdJrvli6aUoJdl8rh4cYFgpFE3I/Hg8/UrqBMs0kn97i2/PvOKWGYL/VOSVmyh+1Uz+jxRI10pNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635712; c=relaxed/simple;
	bh=H8hMe2CPrruFyorlFImmzEBXKC/buJAlMS5MZkRkNcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kVpH9afRo2MC+1ODcGhNxbZu203TCN0EnDZZqodrw5KiIazFEFmcuIUjKoxCdOl4NN4V8rvYvvm1uv+CpN2PQ+YU96itCkrHk0vx3EUVQRqxG23KzyQgvneWffCfyQ50m3c7FgNkTj8v4UysEDym4CJMWCdwxAJ0rcdXI7HywHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceHIZ/F+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceHIZ/F+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957911F000E9;
	Tue, 25 Aug 2026 05:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787635709;
	bh=tETn1Xo8m8EWRoFQnNB8ZMHhFsRdPuYE2c1Zn7LFRzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ceHIZ/F+lzd1nZV8J1KltvVLuLf/Ap2B9gmHYyjsPRyDVyzFIYBJ7XoJxeoXwSp+P
	 E4b74amDb4MpOuLcKA3SmCne9xWRcAPJ3DZefT0cRNHPpdrgRa6Ck/V/yWGYXimPL8
	 cNgbUQJKOnUebATvl13O59X5jB9f1XK9XwMgIL1P96HtjIjLilRT/fHFCvO76qxl21
	 YHtRfWymvemckrowpKlOHE0tsPqxkWl2GH6jh46hZ+1HqkvajsM1RvvwtYBh31xC/I
	 fO+mE9vfomFuNQlNPWcbOZBVlkRlKnNeN+wUVQaMu2EynKRuuY8p8wx7i2VgZQOVfD
	 Kuko7slascJdQ==
From: sashiko-bot@kernel.org
Subject: Re: [BUG] PCI: spacemit-k1: port C probe hard-hangs a CPU with one
 endpoint on Milk-V Jupiter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bruno Banelli" <bbanelli@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260825052249.66921-1-bbanelli@gmail.com>
References: <20260825052249.66921-1-bbanelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 05:28:29 +0000
Message-Id: <20260825052829.957911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch consists entirely of temporary debugging instrumentation=
 and is explicitly marked as 'not for merging'.

Pre-existing issues:
- [High] DBI register accesses before full Root Complex configuration cause=
 dropped writes and a hard CPU hang with certain endpoints.
--

--- Patch [1]: [BUG] PCI: spacemit-k1: port C probe hard-hangs a CPU with o=
ne endpoint on Milk-V Jupiter ---
commit f0ecce23df303a660d238225801529617e3ee9df
Author: Bruno Banelli <bbanelli@gmail.com>

PCI: spacemit-k1: port C probe hard-hangs a CPU with one endpoint on Milk-V=
 Jupiter

This patch adds debug instrumentation to k1_pcie_init() in the spacemit-k1
PCIe driver to localize a hard CPU hang during probe on the Milk-V Jupiter
board. The commit message details extensive testing and indicates the hang
occurs on the first DBI write. The diff itself consists of temporary
dev_info calls to trace the execution flow.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index 0564c46e2f484..e35307d693360 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -127,17 +127,21 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct k1_pcie *k1 =3D to_k1_pcie(pci);
> +	struct device *dev =3D pci->dev;
>  	u32 reset_ctrl;
>  	u32 val;
>  	int ret;
> =20
> +	dev_info(dev, "K1DBG 1 toggle_soft_reset\n");

[Severity: High]
Since this patch consists entirely of temporary debugging instrumentation a=
nd
the commit message explicitly mentions it is "not for merging", should this
patch be dropped from the merge queue?

>  	k1_pcie_toggle_soft_reset(k1);
> =20
> +	dev_info(dev, "K1DBG 2 enable_resources\n");
>  	ret =3D k1_pcie_enable_resources(k1);
>  	if (ret)
>  		return ret;
> =20
>  	/* Set the PCI vendor and device ID */
> +	dev_info(dev, "K1DBG 3 first DBI write (vendor/device ID)\n");
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
>  	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);
>  	dw_pcie_dbi_ro_wr_dis(pci);

[Severity: High]
This is a pre-existing issue, but does performing early DBI writes (such as
the Vendor/Device ID here) before asserting PERST#, configuring Root Complex
mode, and completing PHY initialization cause the CPU to hard-hang waiting
for an unanswered completion on certain endpoints?

Is it possible to defer these DBI register accesses until after the full Ro=
ot
Complex configuration is completed to prevent the CPU from wedging?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825052249.6692=
1-1-bbanelli@gmail.com?part=3D1
