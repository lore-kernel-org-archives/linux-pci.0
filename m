Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADB2FFF90
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366603; cv=none; b=fLKcz9FW2FVl7j5iwNNvBc+x2VZ3mDAte85yfGypHPKMU44ROVSNFSPZvfWS46WjvdVAVfzPhlwzNEY70Wm/qg94itU59bQhjcE5b9DEjEPkiQM+9KI3kD9VZ1xuovQ7z1CH4URrUR5cPHnoeu4iLMvQJtE96asHkKnNEVRKIEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366603; c=relaxed/simple;
	bh=Xnasg6Df+wi943m10/98QKY6A7Y5YcE58RyedchM8VM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D8ac9aIJkdDm3M32kPCiZ9h7YtVEaGXkzRf279pqB4xgrxqRa4QwNXJyvsCsB0KjNGbqLiWFwWWeii7WSMfQ9uFeS2JPJAYJG9jB35UX11dsbG9ujyzTENvRA9VQEdq9SbzbIxIUEPy/GRYJsmObx2q4MNr38BKJSA41ZwI+c6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apkbuNN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apkbuNN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A875C1F000E9;
	Mon, 10 Aug 2026 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366601;
	bh=wIk/RmYnfT5bbCBxd6eDL5xmjHkleE+ShTiLTEBeh7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=apkbuNN2lWR7hs2xMPgvUGt2IyoFop5MZ7Vl+W4mkQmwWe9iBtio72gIg/mNm5jmT
	 r5VcBVAjL7oJD3CKcsrsQIYHJtZSK/GQDa2E3AgNwS47OfbDwR0tQ8yJ1KGvTVcWK/
	 ubuArcJoRVACwcoMU+l0nvFpFDz1c6qcBpbh8Ku2SJCweVnNVNp2K9e1yiqrTRW7Aw
	 n2XFw3rTRDIuEP3GIiaDIMYwIKpLg0qAnlmXxmzaaNV1rdWUwhXM7WUpdTpgbq/us9
	 Q/BMBNDiMYs6vzWYf4KjKDNyS6vwyrjo0/06hMEtKsG9tSp/a3KGj9+Db2F/ViP2gq
	 +c1udSmUleWoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] PCI: cadence: Preserve all error codes in
 cdns_plat_pcie_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260810124315.433448-2-vladimir.oltean@nxp.com>
References: <20260810124315.433448-1-vladimir.oltean@nxp.com>
 <20260810124315.433448-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:56:41 +0000
Message-Id: <20260810125641.A875C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver lacks a `.remove` callback and does not set `.suppress_=
bind_attrs =3D true`, leading to severe resource leaks and a potential use-=
after-free when unbound via sysfs.
--

--- Patch [1]: [PATCH v9 1/3] PCI: cadence: Preserve all error codes in cdn=
s_plat_pcie_probe() ---
commit 8180a8544f7ea362a9f7505de96e98a724635cba
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()

This commit modifies the error path of cdns_plat_pcie_probe() to correctly
propagate error codes instead of returning zero. Errors from pm_runtime_get=
_sync()
and setup functions are now correctly handled.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers=
/pci/controller/cadence/pcie-cadence-plat.c
> index a1ea24fc3b63f..8aed8b4c3e11c 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -126,7 +126,7 @@ static int cdns_plat_pcie_probe(struct platform_devic=
e *pdev)
>  	while (phy_count--)
>  		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static void cdns_plat_pcie_shutdown(struct platform_device *pdev)

[Severity: High]
This is a pre-existing issue, but since you are fixing the probe path, coul=
d we
also address the missing driver removal handling?

Looking at cdns_plat_pcie_driver:

static struct platform_driver cdns_plat_pcie_driver =3D {
	.driver =3D {
		.name =3D "cdns-pcie",
		.of_match_table =3D cdns_plat_pcie_of_match,
		.pm =3D &cdns_pcie_pm_ops,
	},
	.probe =3D cdns_plat_pcie_probe,
	.shutdown =3D cdns_plat_pcie_shutdown,
};

The driver lacks a .remove callback and does not set .suppress_bind_attrs =
=3D true.

If a user unbinds the driver via sysfs or unloads the module, the platform
driver core will successfully unbind it. The devm subsystem will then
automatically free all managed resources, including cdns_plat_pcie, the host
bridge, and memory mappings.

However, since pci_stop_root_bus() and pci_remove_root_bus() are never expl=
icitly
called, the PCI root bus and its child devices remain registered in the sys=
tem.

Could any subsequent access to the PCI bus (such as running lspci) derefere=
nce
the freed host bridge structure and cause a use-after-free panic?

Would it make sense to set .suppress_bind_attrs =3D true to prevent unbindi=
ng
via sysfs, or implement a proper .remove callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124315.4334=
48-1-vladimir.oltean@nxp.com?part=3D1
