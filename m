Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47A3D9DA8
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366717; cv=none; b=PcNs3vrlILXI2C7zOj3Ag30bbHM14EitJbkHmmzzxImlqF1YiPa4J1+lrJafuXwOyxvtlvabp5ylDU63dpL2fHWFyG0NJaXCDb1lzyuDqz5qEeFhsVX9lt2TnoeUmBkFUktEzDg5xLgp9HzIHE1lIOXCe2GRuv8EkJTuh9eT0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366717; c=relaxed/simple;
	bh=2pgNg8cZTfwPHA5aSUN9EL8grbPNaPDK6GzN0g5o0vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xr+L3qTjIcQ3Pu8reKEnI/YfFjoodCZc+/5SzUKjvXzm5fqhX/UgAgOSGdSBv6ltl2x5QiIBg2qws0/S5fFv37djN/YrFZL4cQwgzZtWYOigS2HrgIWcgo54F9GitSWsrK+5IuhPQBuftSaU6JXBjE9e7FV7RSonzgJystIpn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsMzAGLs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsMzAGLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803E61F000E9;
	Mon, 10 Aug 2026 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366715;
	bh=ItJjRXDkto/6XYH0Gi4ohebXZsEF0BkZ14MTkXQpAcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NsMzAGLsWqHjZN7QQrU+S4BxkEf9hupPTdeHS5wQGfdb/IIONX/uiL0vY+k9jU3s6
	 /3KJgqV3pIhJiEbJWLAgvvB5hIJseVzUgNZWSXqP6xi4SiTkmzm4xkxu6Lm3uTj5DU
	 En/TEUiSj5i1T7roSNe8qMW5rOR5PtZKcnkgCr1loXBsfUzeg2/u16raaAWVUMc4sH
	 Oadp7NKsdLhRkvt+aUdhf1HOVHqaPLnc07s5DB297SO6BjMBzsq36KSVsJJW8imUJw
	 VnuXE93tjbcXtsV7Xilapad05w0Oxw1d4wQ1+H7IY5pUzKUlt/ZdT41xpHce7l1xwV
	 y+8BYRIlZW81A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] PCI: Remove device links to PHY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260810124315.433448-4-vladimir.oltean@nxp.com>
References: <20260810124315.433448-1-vladimir.oltean@nxp.com>
 <20260810124315.433448-4-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:58:35 +0000
Message-Id: <20260810125835.803E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The Keystone PCIe driver completely skips deinitializing the Desig=
nWare host or endpoint during module removal, leading to severe resource le=
aks and Use-After-Free conditions.
--

--- Patch [3]: [PATCH v9 3/3] PCI: Remove device links to PHY ---
commit dba6a718906e10ffe3960ba8d21e61e4e4e62e26
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: PCI: Remove device links to PHY

This commit removes explicit device links between the PCIe controllers and
PHY providers in Cadence, DRA7xx, and Keystone drivers. The PHY core has
automatically added consumer device link support since 2019, making the
manual link management redundant.

> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/cont=
roller/dwc/pci-keystone.c
> index e9b012a5ea9a2..8085c4f614031 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
[ ... ]
> @@ -1337,25 +1321,18 @@ static int ks_pcie_probe(struct platform_device *=
pdev)
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);
> =20
> -err_link:
> -	while (--i >=3D 0 && link[i])
> -		device_link_del(link[i]);
> -
> +err:
>  	return ret;
>  }
> =20
>  static void ks_pcie_remove(struct platform_device *pdev)
>  {
>  	struct keystone_pcie *ks_pcie =3D platform_get_drvdata(pdev);
> -	struct device_link **link =3D ks_pcie->link;
> -	int num_lanes =3D ks_pcie->num_lanes;
>  	struct device *dev =3D &pdev->dev;
> =20
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);

[Severity: High]
This is a pre-existing issue, but is the driver missing a call to
deregister the dw_pcie core during module removal?

The ks_pcie_remove() function does not call dw_pcie_host_deinit() or
dw_pcie_ep_deinit(). This could leave the PCI controller registered in the
kernel's PCI subsystem while its backing memory (allocated via
devm_kzalloc) is freed by devres when the driver is unbound.=20

If this happens, wouldn't subsequent access to the PCI bus (e.g. via sysfs
or background polling) dereference freed pointers and cause a
use-after-free panic?

> -	while (num_lanes--)
> -		device_link_del(link[num_lanes]);
>  }
> =20
>  static struct platform_driver ks_pcie_driver =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124315.4334=
48-1-vladimir.oltean@nxp.com?part=3D3
