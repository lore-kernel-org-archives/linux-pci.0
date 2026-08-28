Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC141DF27F
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909363; cv=none; b=RlFX/1LIW8fT42XPQua8hW5LbtU0ffcHCw0X/uc1Xk+dIor99Lk5lGqSjOGdSoJrG9K6eejcqVoChLJISsRRqmQeBfikJLAWxCvDNcy0piufc8Ip07E61V6G6N9cuoLwp7oCsfj96/mcIiDggcF3CU2I/Vh+48JJ0ZWgP3awOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909363; c=relaxed/simple;
	bh=Iy3h3TNKKG4a9/4AJi+XbR1bItuZAzoQOJpmtr83vAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZQYv2pNFNaJJkmGtbrJSZ6AHW1UCmpRN2epPgv4hIZSJKuTgiC3B9dgry1OVWm2sBnAzYNRRtTYuCLtxWXlS2PjbNhTnlJurNNUvX2q0IIufUMfL530ERiQkkWZuc5Ey2837K48igoAJ4fPASN67MAEmvm4ENR/ixsJr81hkdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izKt4zUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izKt4zUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD061F000E9;
	Fri, 28 Aug 2026 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787909362;
	bh=hjoJri+gQ3cUIJKU2fuCn24AyBCWYYW/l/tQpCqEsL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=izKt4zUJ4M0KRANH5IDd22DVN4CyIfc4JtTj9VcL+DrebSHgowgAT4sExWXtWrCy4
	 v6bCQSuSyCJ9DheiLiMtPp0uUt88EzVl8Ny0eaFx0kpBm85DV1SrTNzLqNp49FPDKI
	 mu1/08H6eyoEp9HBCrS/VGMda+69RvibxaIatmK6jrwhwQYbkGIpfPAk6XXeQZ6roC
	 zqzFGcE2/40sYrNdm+OtQ1s7SJJAFsRdDpJic9TOGL2Jx8mDhdSoiUeqjc9ykKrOn4
	 PBnfJKNgUDWLU2htJ6tWQlFrJILskSxXuTdDZftS2aXGQGIZPsuCaeUgaQbr/CbH0x
	 Mi4rngjzXfu+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: tegra: Unwind partial PHY power-on failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260828091747.7976-1-pengpeng@iscas.ac.cn>
References: <20260828091747.7976-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:29:21 +0000
Message-Id: <20260828092922.2CD061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new error unwinding path for `tegra_pcie_phy_power_on` uses =
`tegra_pcie_port_phy_power_off` to power off fully initialized previous por=
ts. However, `tegra_pcie_port_phy_power_off` iterates over the port's lanes=
 in forward order and returns early on the first `phy_power_off` failure. T=
his violates the commit message's claim to unwind in reverse order at both =
levels, and introduces a resource leak if a `phy_power_off` call fails, bec=
ause the remaining lanes for that port will incorrectly remain powered on.
--

commit 98ccb4105337a9e0fdf96c19a4beba14a45d67f0
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

PCI: tegra: Unwind partial PHY power-on failures

This commit adds error handling to unwind successfully powered PHYs in the
Tegra PCIe PHY setup. It attempts to power off PHYs in reverse order for
both nested acquisition loops (lanes within a port, and ports within the
controller) when an error occurs.

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 59b56446c507e..443fa33b7f0ec 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c

[ ... ]

> @@ -1051,6 +1053,8 @@ static int tegra_pcie_phy_power_on(struct tegra_pci=
e *pcie)
>  			dev_err(dev,
>  				"failed to power on PCIe port %u PHY: %d\n",
>  				port->index, err);
> +			list_for_each_entry_continue_reverse(port, &pcie->ports, list)
> +				tegra_pcie_port_phy_power_off(port);

[Severity: Medium]
The commit message states the code will unwind successfully powered PHYs in
reverse order at both levels. However, does delegating to
tegra_pcie_port_phy_power_off() here contradict this design?

Looking at tegra_pcie_port_phy_power_off(), it iterates over the lanes in
forward order rather than reverse:

static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
{
	...
	for (i =3D 0; i < port->lanes; i++) {
		err =3D phy_power_off(port->phys[i]);
	...
}

Additionally, if an error occurs during unwinding, does this cause a resour=
ce
leak of the remaining PHY power states?

If phy_power_off() fails for any lane, tegra_pcie_port_phy_power_off()
returns early:

		err =3D phy_power_off(port->phys[i]);
		if (err < 0) {
			dev_err(dev, "failed to power off PHY#%u: %d\n", i,
				err);
			return err;
		}

This early return abandons the power-off sequence for the remaining lanes
in the port, leaving those PHYs incorrectly powered on.

>  			return err;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828091747.7976=
-1-pengpeng@iscas.ac.cn?part=3D1
