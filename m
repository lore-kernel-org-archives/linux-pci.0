Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6C47CC8D
	for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2026 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644729; cv=none; b=ipmOK9yukgN/X68vj8Awpa7TnheA3jQCoaUuPrJt4fkJzMUxIYhBrXpIGubfLrIBwQIJhnz7nIGNUT245RtAKBJRcJndRMO5V1i1cG3Rnr3EQLOBgc6X2CBzbZjb3gOkiCfEOk0s8HdPKi6s2n1dzMb/b+ihRwWoOofziT5NsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644729; c=relaxed/simple;
	bh=2P/rUWNorLIOVqSo7ocjaYXfCFUXb4SPxUqNQWFyjck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nav9hTwRgmI9X1FCKSP5RHSv/3vY7tVQRP/0iHDGj1mVRCkV4UPScmZGz8Cz2PQOvh5g0mmQb6OMk43NcWWXbI0pnlue6W2ZhjQGHqsj63eZ7xFR/OMDeKQCq5qx75muSaEFc9+fnzpCmejVOn7h8OHYaFckBH4gd8VvpCrOwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crHo+7Sn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crHo+7Sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7521F00898;
	Fri,  5 Jun 2026 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780644728;
	bh=mSS31JB7icXhTnggbdbtFqios7V4Rrkr8T+sf9LY8Zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=crHo+7SnRW+g5dB20VBSTkYIYkUo5NN3yDVBmW9XePQ/F9UZXpANEXA6ESMTvfDbS
	 4jLDWJE7J/fQKsDZglJt55rJ7NAluGVH25r+opsJ4CcOFCQAgm85cSJ/rY1/ypMhoE
	 JU6G789Z2MOI26LrZR+kbainu5Ll4ixzsz35/lxV/XSEjvlsKMWPKCBvmtlBZLTrbd
	 qJ3SygPLWSfPnVprdbe+WLt8q1+/YOjyDNKHCS1s1cppVe7S8YZIjXTrankIEy2NA7
	 Kx5rUMi/mtYdPnaDT2wIb4fnbHaNQlSXMlvVDwR1yIVc4ARDM7v8ilMySpZNG8P5qd
	 HKKrUH8aIz9sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260605071922.1724499-1-a-garg7@ti.com>
References: <20260605071922.1724499-1-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 07:32:07 +0000
Message-Id: <20260605073208.1C7521F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using the PCIe link status during suspend to skip link polling on =
resume breaks devices that enter low-power states (e.g., D3cold).
--

commit e21ed7192e9296fcc0d194c87d46cca7a3106268
Author: Aksh Garg <a-garg7@ti.com>

PCI: cadence: skip the link polling when endpoint not connected

This commit adds a skip_link_polling flag to track the link state across
suspend/resume cycles. If the link was down before suspend, it skips the
expensive polling in resume since it assumes no endpoint was present.

> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/con=
troller/cadence/pci-j721e.c
> index bfdfe98d5aba7..849eb8bb9e452 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device *d=
ev)
>  	struct j721e_pcie *pcie =3D dev_get_drvdata(dev);
> =20
>  	if (pcie->mode =3D=3D PCI_MODE_RC) {
> +		struct cdns_pcie_rc *rc =3D cdns_pcie_to_rc(pcie->cdns_pcie);
> +
> +		/* If link is down before suspend, skip polling in resume */
> +		rc->skip_link_polling =3D !j721e_pcie_link_up(pcie->cdns_pcie);
> +

[Severity: High]
Will this cause problems for devices that enter low-power states like
D3cold before the root complex suspends?

During system suspend, the PCI core suspends downstream endpoints before
the root complex's suspend_noirq phase. If a connected device is placed
into a low-power state, its link will drop.

This logic interprets the link-down state as "no endpoint connected", which
would incorrectly set skip_link_polling to true for connected devices in
low-power states.

>  		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>  		clk_disable_unprepare(pcie->refclk);
>  	}

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers=
/pci/controller/cadence/pcie-cadence-host.c
> index 0bc9e6e90e0e0..026414c21ee1b 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -352,6 +352,9 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>  		return ret;
>  	}
> =20
> +	if (rc->skip_link_polling)
> +		return 0;
> +

[Severity: High]
Could skipping the link wait here cause Completion Timeouts or Master Aborts
during resume?

If skip_link_polling was incorrectly set to true during suspend because the
endpoint was in a low-power state, returning here bypasses waiting for the
link to come up and skips the Gen2 retraining quirk.

Later, when the PCI core attempts to resume the downstream endpoint and
restore its config space, the link might not be active yet, which could fail
the device's resume or cause the system to hang.

>  	ret =3D cdns_pcie_host_start_link(rc, cdns_pcie_link_up);
>  	if (ret)
>  		dev_dbg(dev, "PCIe link never came up\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605071922.1724=
499-1-a-garg7@ti.com?part=3D1
