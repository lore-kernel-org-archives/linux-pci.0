Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1994349BA;
	Thu, 15 Oct 2026 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052746; cv=pass; b=PnDyOuRi4TuvEaNmxj/GzdLH1z1GVzAICxtoqBzU7tZqIBEkZVmF6xhRiz3B4uHF3DepIT9MYw1eoJeCY09kvCGpHSgIE4wgPLIPhUBaSnlAMzQBcYJ4r2ZQhrF/azLGLFSp5izu6fH/KjMcJhIekX1TPD6PM4dAApBjzJpRX9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052746; c=relaxed/simple;
	bh=BWiRILA9u6x55hHKY43Wo6zyOOW+UbhVhlu+tMVrbGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V32wG/5XR5nTgNA6js097ozJjnegYL1XZZgy87zazvTEvm1HOgaIBlwiY+qfuRA6b3px4+NUl7jq+2TpJY4f8DGzGuMIsrrErNLPNiXPodk/6JpSOQSfwgMh7UNutjqGiC4QypTpsn2FvoXHCsLEoM1QF1p/QHLZZ5SdhYqhOdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=fjAlKxqU; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="fjAlKxqU"
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 13CB7202012;
	Thu, 15 Oct 2026 10:25:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792052741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrxfajdvFmJtNiWzGN9eypZ6XVjairWUkY35gVPYWFY=;
	b=fjAlKxqUKEH8jDMC0qtq5+KAH4+tBauqPTL5mgqFtf1eXTbMOYh493KztS3VNdSIxr6Gpm
	3OyLym75xe3LmZzhue3ZISgGsWRTdl56TTUB3l/bN5pxSjSObR3Bgb1XV0CCH6ZlsqZxdl
	Q1vqqEy5saF0FFbI9guNa+CkUj3k5fzmt10wXmwsgx8CZuGVv/7kurXmnv6iUP3i04koZ7
	pA10xsAN69Csf2p8PQwOLHHjpJMgvnf7TlulDBR+ROUR2yCzFifogTk3+V/S1MVbDhv3cd
	XTyfKHfG9HVAaZJuHkoHGQuB2DxHMtD/2F78oz/T1AV5hZPsteEffP/E6zpmNQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792052741; a=rsa-sha256;
	cv=none;
	b=CT0ayXFWM58Zj9nkLOzhw5fsBgfii9zgnV38JiL/MHcgu5b5GUN0Rb1KK+3920Ffnk4ePs
	eGJ50jkBCLreOItbCaO5qIfjkh13Jexqo16kWXkxKpEYq0Ft2C5AhTLZGly3pqS3YtB9fc
	vh4QFalCX2LZphi/XPdpZf/kPF86gfJLkuKuBo29Q3xawIYH/1p+fe299+F3GjsUISVoLd
	1EeQqsqE6R4AG9HsQhnap03Q06m0oiDdCbBax24eRfTlsVCrzBCYxxwn/DlJmL566O6Cky
	YXHVNryQonz2XWWog+Il/YcKBBJELPnHOApCghSdFR87nMLoAcq8ShPYJaIB4w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792052741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrxfajdvFmJtNiWzGN9eypZ6XVjairWUkY35gVPYWFY=;
	b=VHChhYmOypm0trb/T3G7ioVgQB3Gk+9RkxCOM9hSbJmABlyKnlJMMyZLA286oOH02dFZiM
	MAsPWPd2+Et6AaLPnrNWgnZqHb5Ohsdk5U9avr5zPYn6GJxjHxxmN2+dbpeO7CA4tFVF8l
	Y70B0Ol3E/3iBb4CjXW8Xje6tITRAsonYInrkW9ZRcMmJX1LGj0iIca/LBkG0K2rMzp7pp
	ch7IR3aTtYf8GiVhCFrT6Ldw6m3Lzr5nJ4m1/PBcopUBYeHHmmbJQ29/rgURvxl+KLfVyv
	TxUUA7+qW9x0jA9rnDvti6tAfSG+bAhx6v3kqD3qbjN3gj50L+iLTFt5GjK+fA==
Message-ID: <20cc437c1e95aca578ac814c2e0f4f0f3ddd71d4.camel@pengutronix.de>
Subject: Re: [PATCH v6 09/10] PCI: dw-rockchip: Add system PM support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Lorenzo Pieralisi	
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring	 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko
 Stuebner	 <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>, Shawn Lin	
 <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	 <broonie@kernel.org>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Date: Thu, 15 Oct 2026 10:25:40 +0200
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
References: 
	<20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
	 <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Di, 2026-09-08 at 16:51 +0200, Sebastian Reichel wrote:
> Add system PM support for Rockchip PCIe Designware Controllers.
>=20
> I've tested this on the Rockchip RK3576 EVB1, the Radxa ROCK 4D
> and the ArmSom Sige5 boards.
>=20
> While I haven't experienced any issues, most of my tests have been done
> without any devices attached (i.e. default board without any extras), so
> there _might_ still be some problems. As system suspend does not work at
> all right now, I think it makes sense to get at least the basic
> configurations working as soon as possible as it will allow us to catch
> regressions by enabling system suspend in CI systems like KernelCI.
>=20
> Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 100 ++++++++++++++++++++=
++++++
>  1 file changed, 100 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 47d9cab909bc..e675918ba184 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -120,6 +120,7 @@ struct rockchip_pcie {
[...]
> +static int rockchip_pcie_resume(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> +	struct dw_pcie *pci =3D &rockchip->pci;
> +	int ret;
> +
> +	if (rockchip->data->mode =3D=3D DW_PCIE_EP_TYPE) {
> +		dev_err(dev, "resume is not supported in EP mode\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret =3D clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret) {
> +		dev_err(dev, "clock init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (rockchip->vpcie3v3) {
> +		ret =3D regulator_enable(rockchip->vpcie3v3);
> +		if (ret)
> +			goto err_disable_clk;
> +	}
> +
> +	ret =3D rockchip_pcie_phy_init(rockchip);
> +	if (ret) {
> +		dev_err(dev, "phy init failed: %d\n", ret);
> +		goto err_disable_regulator;
> +	}
> +
> +	reset_control_deassert(rockchip->rst);

Missing error handling. This is inconsistent with the existing calls in
rockchip_pcie_probe() and rockchip_pcie_rc_reset_root_port().

regards
Philipp
