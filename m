Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE12345EB9
	for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230294; cv=none; b=uNVTA0bGZtxsxVJI+Iv704Xdo66JaQzGzXtHnYxr4w5FrkTS3ZJPnurJbUC1dToAAGoo3V9c+vFFmZOxvqFcGQERYkrG30vcCRxaiVE3NEHnPry/h7zvl+JN1HabAIktZj105uTJPKwuTRpSgIlhAkK596IEmlnGHkasoLvIpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230294; c=relaxed/simple;
	bh=QiArLQXW+5AZtvw8sfcvW5QJjSY4yfTHI92519BYtrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QwDJoOrzgE7KMtsHu8wIij9L8gXm4KBBjAp5Yg6wFvD0u8XKC1DgB4671mN+AxA7MLrvF+myn3DBPCfUK7SCQbqJBtLP0vbnyPze0ZLkdxgJn/fFVSvT4gdwN75/bcNF+W6ERupeu3lvTVXQ4zRAfJ7xlXORT1D2Qp9Dzzqp8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEZxiuuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEZxiuuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC66C1F00898;
	Sat, 12 Sep 2026 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230292;
	bh=bAAZtF21vQqGclvaB1jKMd4PJZkRIvWmu3r9x+DRoXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZEZxiuuNBTTpyKp+oX6LdB3VxJ34D/Bejjn9gO/D/hwQhWedc6F9ytxUTNuo0HLmQ
	 4paS9vprmyIAUWvIH+Selwh2/SwGPJnONzwzFUXPcpfLwx9/yFYxOhhDLaxiRtvvy7
	 s3KkVCFsk2J2r8MCKgyqaMjqm4ddXBCC3330eEe+ZaNi8Ieb5eAxrXo85gJy9GgeHl
	 5Ro5jUuiL6yHFGNysUj2+KE//6tYuLSs11eq2+4d+4waUFFB9i1SWQUcZCFg1ZwFP3
	 KXNm8N0YmZo0ZIFrX2LfeDYfQIlTryZSQMSQ3sDP+0qLYXtcmbNaS0Zz2y+2MebGK1
	 0DYUJtd66xcQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI: cadence: Remove device links to PHY
Reply-To: sashiko-reviews@lists.linux.dev
To: vladimir.oltean@nxp.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260912161440.1032188-2-vladimir.oltean@nxp.com>
References: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
 <20260912161440.1032188-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 16:24:52 +0000
Message-Id: <20260912162452.AC66C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The probe function `cdns_plat_pcie_probe` unconditionally returns =
0 on failure paths, masking initialization errors from the driver core.
- [High] Shutdown and PM callbacks erroneously cast `struct cdns_plat_pcie =
*` to `struct cdns_pcie *`, causing severe out-of-bounds memory accesses.
--

commit 93f901fd65f6099ca141c0baa86f19be3649b0d0
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

PCI: cadence: Remove device links to PHY

This patch partially reverts device link pieces from a previous commit
because a PHY consumer driver dereferences fields from struct phy, which
will become impossible. It relies on the PHY core's own device links to
order provider and consumer suspend/resume operations.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers=
/pci/controller/cadence/pcie-cadence-plat.c
> index a1ea24fc3b63f..5900d68c6e83a 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
[ ... ]
> @@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_devic=
e *pdev)
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
> -	phy_count =3D cdns_plat_pcie->pcie->phy_count;
> -	while (phy_count--)
> -		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does this error path intentionally return=
 0?

If a setup failure occurs during probe (such as cdns_pcie_host_setup()
failing), the code jumps to this error path, performs partial cleanup,
but explicitly returns 0 instead of propagating the error code.

Since the driver core sees a successful probe, it will keep the device
bound. Will subsequent accesses to the device crash the kernel because
the internal structures and resources are partially freed or disabled?

[Severity: High]
This is another pre-existing issue, but could the platform drvdata setup
cause severe out-of-bounds memory accesses during power management?

The cdns_plat_pcie_probe() function allocates an 8-byte struct cdns_plat_pc=
ie
and assigns it as the platform drvdata. However, cdns_plat_pcie_shutdown(),
cdns_pcie_suspend_noirq(), and cdns_pcie_resume_noirq() retrieve the
drvdata and cast it to the much larger struct cdns_pcie *:

cdns_plat_pcie_shutdown() {
    ...
    struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
    ...
    cdns_pcie_disable_phy(pcie);
}

Does accessing fields at large offsets, like pcie->phy_count inside
cdns_pcie_disable_phy(), read memory completely out of bounds and
potentially cause an immediate kernel panic during suspend, resume,
or shutdown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912161440.1032=
188-1-vladimir.oltean@nxp.com?part=3D1
