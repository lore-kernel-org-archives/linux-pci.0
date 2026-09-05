Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6416A395
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577471; cv=none; b=eBRbY80IZhxrx+EgSxgF7dVJ/ayBfX0aDfVVV5EsXpXwuLDfq/qjGcgtcvDQtSEgSxbby+IjeN0lr6UFsotb+FWc6JbqUN4zM3emQsCCwF2IZPI4SQZBXHWSZ8Szs3PP7qCMNf6z2Tc1Ncm9wBQLHcgXbqrUcVfmnllTEw6QeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577471; c=relaxed/simple;
	bh=fT1V/CS+2fa6DxwiYJuSqh7wLNl8D7GfdPjA0ToV5ow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=da6Aa6E+yeKCLwQjzF5YJWEtpmD3vUA+a/zDUWwlaUjhLOUZbYWDBXpe+bZQ2LSA6MeSZu8fjrIhV6BAxqqJXBIWiLEO438oezWhS5pARuufLhv3djGVn2APWlBc7ErvRDtCK3JMQ17ZZyxAr+nXT40sF+J0cXgzF3/YFNbeau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9ArbNM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9ArbNM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9A21F00A3D;
	Sat,  5 Sep 2026 03:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788577470;
	bh=ZQnbb0MiOFab/fyHnSBkpmm5tt/bmtRwdMX5AXOXkuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y9ArbNM29S/VMUa3w89hra6bCRNpSvQ4DgtG4TK23f3DS2CwDVnxmWzZGP9c/HCS8
	 B/hK8GKQTI5PyN53SJz5AI3/h7wd5ZwAOm+ApS0tYJuuZujsAC/BW+7+SyX4WZchGb
	 LSl8cLdyb4Y0ktVNbD8THYxYl1bvt1lYNEMi5Lk9uK+Dc8GiHerJFJyryxtj7/ha4M
	 llz1rPw3O2V41vf3bAWEO+nmBI7kScaY4qM4TcLsdB79wvusl80Ilf9bPawli5prLQ
	 8iuFqVYSGtKgM3NA5Tsw5vcuTxqhZBVplnwE6pq8wJZQ4yXaa15Btd3pxzPLGl0vlm
	 aFvPlj6iKNr+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Allow drivers to skip MEM outbound
 iATU setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xincheng Zhang" <zhangxincheng@ultrarisc.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905025635.211390-2-zhangxincheng@ultrarisc.com>
References: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
 <20260905025635.211390-2-zhangxincheng@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 03:04:29 +0000
Message-Id: <20260905030429.BC9A21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Callers of dw_pcie_setup_rc() ignore its return value, missing pot=
ential errors.
--

commit b48f3b5259744f25f4f7ea094bd8ed4860783aa6
Author: Xincheng Zhang <zhangxincheng@ultrarisc.com>

PCI: dwc: Allow drivers to skip MEM outbound iATU setup

This commit adds a flag to bypass outbound iATU programming for
identity-mapped MEM ranges on DWC controllers. It introduces a check
that returns -EINVAL if a skipped MEM range is not identity-mapped.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -918,6 +918,20 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		atu.parent_bus_addr =3D entry->res->start - pci->parent_bus_offset;
>  		atu.pci_addr =3D entry->res->start - entry->offset;
> =20
> +		if (pp->bypass_ob_mem_iatu) {
> +			/*
> +			 * The no-match pass-through path preserves the correct
> +			 * PCI address only for identity-mapped MEM ranges.
> +			 */
> +			if (atu.parent_bus_addr !=3D atu.pci_addr) {
> +				dev_err(pci->dev,
> +					"Cannot bypass outbound iATU for non-identity MEM range %pr\n",
> +					entry->res);
> +				return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but adding this new failure path
highlights that callers of dw_pcie_setup_rc() (which calls
dw_pcie_iatu_setup()) ignore its return value.

For example, in drivers/pci/controller/dwc/pcie-designware-host.c during
system resume:

dw_pcie_resume_noirq() {
    ...
    dw_pcie_setup_rc(&pci->pp);
    ...
}

The core suspend/resume framework ignores the setup return value here.
The same pattern exists in driver-specific functions like
exynos_pcie_resume_noirq(), tegra_pcie_dw_resume_noirq(), and
tegra_pcie_dw_start_link().

If dw_pcie_setup_rc() fails because of an invalid ATU configuration
(like this new -EINVAL path) or an iATU enablement timeout, the controller
proceeds with link initialization without proper configuration. Missing
outbound memory windows or broken MSI can result in system crashes or silent
I/O failures when accessing PCI memory.

Could the callers of dw_pcie_setup_rc() be updated to check and handle
these failures appropriately?

> +			}
> +			continue;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905025635.2113=
90-1-zhangxincheng@ultrarisc.com?part=3D1
