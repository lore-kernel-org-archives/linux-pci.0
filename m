Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149979;
	b=nTBJKf4Em178FmX7KQTLQEs/GEK09nCUjt/9dB4Vhv6TT6mU5LAIM/xNAv655G1w+tXb
	 Hw8tSkbTeBCyF46uNU0FaI5edrQzBgbY6dwgynlAMJVOviPhxS9wP7ZMY47mHiKHpeNgC
	 Zuv5Q/lHFEYGS25vx717uzbz1qyaeK8eW5uKQjihmsbUDCcJBjGWJBM+HnLbYX0r+rK5E
	 BRhpjtEEphxQiLavRkLWUkEICCIlVqTkTMW16zgmh6EjcbyCi64ES6Ha8k0u/c0mAwvOP
	 ZRI7v3BXUeuGs8wQdiT1Cx4Ga3Pz/8yNucAzGBjjv3kPuskIYJDyGDMwTJbjGNRGlqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149979;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MQc208is34wWIIeh09uVYYvGbmXO5iwqqMrf5NSTTno=;
	b=4weH804+oIj5Mfda+b1mrYU1Xtn0ZPbsW1Mqs0ACAXxtSJf7lI6ZEpla/hjv2UtdYb7b
	 njRNiHpLRnE0AA6Q+Tp2t0cycErJQpvpMdO48uXqtifKSJYLZZiwwr/6PvaH71CtNBNn0
	 Ql9Kr68qWLw0mmM6xdHLvi2GyqU6xhoj69NhdxDmw88BlBAvuTNJ+HbskWxu4KGjoS0H6
	 i53KxN5WYgD3dQR/ovmQnMakwU/uDlB4rowPVqq5iFslLhXMpzE6FoX2jYnji4xIRlA28
	 G6mB0AgOvjWZfcgn4MicAKITXQ55JlNe3yGtCgBTvLm1d3B64fyiG4X8IPtQIfAGKlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XkxZ5VjX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C0606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XkxZ5VjX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953721F01829;
	Wed, 28 Oct 2026 01:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149978;
	bh=MQc208is34wWIIeh09uVYYvGbmXO5iwqqMrf5NSTTno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XkxZ5VjXGSTA3dBmuLwtpk+SmeMlQadiuwi6qO4L2gAPccrnyl1ZTCXFbTVMPvwmY
	 cqy+j1r5rzLy6DxeDUoyRJt/gVR3fTCu7KSVtlBN4VXYfJzAOAkKQFnUxn6TWG61Eo
	 jRVjixrMasD+eyPffaeYkluLOixx3duLmY03Qnc5sshIjPE78CbFpInUuQtohHFHaz
	 A5G/FKHHO+rEZfX59hbJ9Cyyv6MA7C7D+6R4efcpv1gzMS3uQhLjcDv0jT7rqsZ3bh
	 9qvYC6tVGAdBdcb7+w8uLOX4nKY5vgzxPoz3dvazb7UvuCINdBz1qsqfVGZ3Qt7ooe
	 2bWd/zYqtJ18w==
Message-ID: <sashiko-outbox-187305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: rockchip: Don't lengthen PERST# when power is
 already valid
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RW5yaXF1ZSBIZXJuw6FuZGV6IEJlbGxv?= <ehbello@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028005603.2399220-1-ehbello@gmail.com>
References: <20261028005603.2399220-1-ehbello@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:12:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: rockchip: missing T_PERST-CLK delay in rockchip_pcie_host_i=
nit_port()
--

commit 3ad27c7e477b1d892784f009b205c0444bfcd8fb
Author: Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com>

PCI: rockchip: Don't lengthen PERST# when power is already valid

This commit checks whether all PCIe voltage supplies are already enabled
before the driver enables them during probe and resume, and skips the
PCIE_T_PVPERL_MS sleep before deasserting PERST# when power was already val=
id
to avoid lengthening the PERST# pulse.

> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/co=
ntroller/pcie-rockchip-host.c
> index 5b071bdc4f903..2bfbd3481c5b2 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -315,7 +315,9 @@ static int rockchip_pcie_host_init_port(struct rockch=
ip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
> =20
> -	msleep(PCIE_T_PVPERL_MS);
> +	if (!rockchip->supplies_pre_enabled)
> +		msleep(PCIE_T_PVPERL_MS);
> +
>  	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);

[Severity: Medium]
When rockchip->supplies_pre_enabled is true during rockchip_pcie_probe() ->
rockchip_pcie_host_init_port() or rockchip_pcie_resume_noirq() ->
rockchip_pcie_host_init_port(), does skipping msleep(PCIE_T_PVPERL_MS)
without a fallback fsleep(PCIE_T_PERST_CLK_US) violate the PCIe CEM
T_PERST-CLK timing requirement?

Commit c47f90be4c89 ("PCI: rockchip-host: Fix rockchip_pcie_host_init_port()
PERST# handling") added msleep(PCIE_T_PVPERL_MS) to satisfy both T_PVPERL
(100 ms after power is stable) and T_PERST-CLK (PCIE_T_PERST_CLK_US, 100 us
minimum after the reference clock is stable before deasserting PERST#).

Even when the voltage regulators are already enabled,
rockchip_pcie_host_init_port() calls rockchip_pcie_init_port() in
drivers/pci/controller/pcie-rockchip.c, which resets the PHY via phy_init()=
 ->
rockchip_pcie_phy_init() and then configures and locks the 100 MHz reference
clock PLL in phy_power_on() -> rockchip_pcie_phy_power_on() in
drivers/phy/rockchip/phy-rockchip-pcie.c:

	phy_wr_cfg(rk_phy, PHY_CFG_CLK_TEST, PHY_CFG_SEPE_RATE);
	phy_wr_cfg(rk_phy, PHY_CFG_CLK_SCC, PHY_CFG_PLL_100M);

	err =3D regmap_read_poll_timeout(rk_phy->reg_base,
				       rk_phy->phy_data->pcie_status,
				       status,
				       !(status & PHY_PLL_OUTPUT),
				       200, 100000);

and then polls PCIE_CLIENT_SIDE_BAND_STATUS in rockchip_pcie_init_port():

	err =3D readx_poll_timeout(rockchip_pcie_read_addr,
				 PCIE_CLIENT_SIDE_BAND_STATUS,
				 regs, !(regs & PCIE_CLIENT_PHY_ST),
				 RK_PHY_PLL_LOCK_SLEEP_US,
				 RK_PHY_PLL_LOCK_TIMEOUT_US);

Once rockchip_pcie_init_port() returns with the reference clock stable,
rockchip_pcie_host_init_port() only performs a few APB MMIO register access=
es
(and rockchip_pcie_set_power_limit(), which is a no-op when vpcie3v3 is
absent) before deasserting rockchip->perst_gpio. Additionally, on the
rockchip_pcie_resume_noirq() path, PERST# is only asserted at the start of
rockchip_pcie_host_init_port(), so if the PLL lock poll loops succeed on th=
eir
first read, the active PERST# pulse width is also not guaranteed to meet
PCIE_T_PERST_US (100 us).

Should an else branch with fsleep(PCIE_T_PERST_CLK_US) be used when
rockchip->supplies_pre_enabled is true so the 100 us reference clock
stabilization delay before PERST# deassertion is still met?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028005603.2399=
220-1-ehbello@gmail.com?part=3D1
