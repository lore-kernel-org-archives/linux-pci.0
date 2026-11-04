Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822601;
	b=XPW3iYAmVZKWrrjcc/2SeNK6HiHJMqS7wVrG55AQJvSThk+Qlml3TX67AqeMMh4dxtIc
	 4WQAk77JC7+BkzrSIwxMIo8lILtPW4rjsDaSObAZMI3WL0sB+8Fg02ZoYS47PNB8gnRNN
	 dgflPe4NMxfjNayH5sZH5+c5zFTz+x/auD7Y2MaERlxCTiGMmcD5W52Tu3zUdTTdFlycu
	 MnZvLBSZRZ7anvzvGSjlCyT/wjdtXTFUFcBm7/AWqkiTAZ72HXzqCefo3ujQBTJy8/tGL
	 f0iMPCoEOrfCYdKQ3x5vxaSSKK1NWlP0kBCpEeIJm7X4+ykwfhOmUNzfzYeVikZJ5Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822601;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9IULmGPZ4jVgwQAIqjH5AY41r8sHsEPWp9jaRxJtz5g=;
	b=0kP/s19QGl9+MvhW9OGsZJzB3+v1kfaebXTnt1tEGIpVeD6UcWbjWRzAWk/TQvbhqCND
	 cTruKeCs4TS5sSqbcbY2T+AnLm+wUaBUrD3GLBiBdHOTtd2QhdFwHZAhusCvs4vXjLOmy
	 fsuofuZ6E9lsqlr/MVNuEStl/hnZfn6Xo24TH7MkcKfpoHGsAzwMAK5jay4IY8jkRo2yz
	 YbcDFDkBSlekJI4J5bdCONEgG+YgCJKdH06Fn278+S38ToN1Ynv8KYGvp3KbVMVU249I/
	 hI0Qa047bYh35ggMPjmBdcOl/NaFumzh64X+JD5p3RMPN6eBTtlqO85q23rRWeim/Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+424uzA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BE606D4D5
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+424uzA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0834F1F00919;
	Wed,  4 Nov 2026 20:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822601;
	bh=9IULmGPZ4jVgwQAIqjH5AY41r8sHsEPWp9jaRxJtz5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+424uzAYJnyudkNzSiYvIxpjqIiZbDPF7Cx4nL7FTIJddD2d74U7+KT4QwO1ki2l
	 N67/ZLoXvkLWKt0y3U6QYsUUTX80NlsS1fE5nJgI2O1hhLC4HKfC2a3KCkwajcZIIJ
	 UXIqIytWC6e28PUCCdGXc1E4+VaWQiC8dAhsmLJssRUyHpD4dLSN95Sq6+Yq8WhXMJ
	 hb2/NcEIdVocVub6WZN/mYaOd67Xh15WBQlcvxal1c/wEHRebPN7bn8eAYGoDTEscu
	 uq68Sv6HHBJiiTDgIMnXQhHNicl0ypDWq1PHGnYgEWEoAswzg17c5/qlfuJtQuq6JH
	 gbsgIaPifemRA==
Message-ID: <sashiko-outbox-197989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] PCI: dw-rockchip: Clear debug buffer before
 entering L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-10-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-10-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:03:20 +0000
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
- [Medium] PCI: dw-rockchip: ineffective debug register clear in rockchip_p=
cie_suspend()
--

commit f0e5805bf8d7dc88d910a870a6063138c20497af
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Clear debug buffer before entering L2

This commit adds rockchip_pcie_link_status_clear() to write 0x0 to
PCIE_CLIENT_GENERAL_DEBUG during system suspend in rockchip_pcie_suspend() =
so
that post-resume diagnostics reflect the new link bring-up.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 75b40091bb953..66b3d31d7bc9c 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -81,6 +81,9 @@
>  #define PCIE_CLIENT_MSG_GEN		0x34
>  #define  PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
> =20
> +/* General Debug Register */
> +#define PCIE_CLIENT_GENERAL_DEBUG	0x104
> +
>  /* RASDES TBA information */
>  #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
>  #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
> @@ -1039,6 +1042,11 @@ static int rockchip_pcie_rc_reset_root_port(struct=
 pci_host_bridge *bridge,
>  	return ret;
>  }
> =20
> +static void rockchip_pcie_link_status_clear(struct rockchip_pcie *rockch=
ip)
> +{
> +	rockchip_pcie_writel_apb(rockchip, 0x0, PCIE_CLIENT_GENERAL_DEBUG);
> +}
> +
>  static int rockchip_pcie_suspend(struct device *dev)
>  {
>  	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> @@ -1050,6 +1058,8 @@ static int rockchip_pcie_suspend(struct device *dev)
> =20
>  	rockchip->intx =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_M=
ASK_LEGACY);
> =20
> +	rockchip_pcie_link_status_clear(rockchip);

[Severity: Medium]
Does clearing PCIE_CLIENT_GENERAL_DEBUG at this point in
rockchip_pcie_suspend() have any effect on link or LTSSM diagnostics in the
upstream driver?

In drivers/pci/controller/dwc/pcie-dw-rockchip.c, PCIE_CLIENT_GENERAL_DEBUG
(0x104) is never written during link bring-up and is never read by any stat=
us,
diagnostic, or trace path. Live LTSSM state is read from
PCIE_CLIENT_LTSSM_STATUS and PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN in
rockchip_pcie_get_ltssm(), while hardware LTSSM state transition history is
recorded in the debug FIFO at PCIE_CLIENT_DBG_FIFO_MODE_CON through
PCIE_CLIENT_DBG_FIFO_STATUS managed by rockchip_pcie_ltssm_trace() in
rockchip_pcie_start_link() and rockchip_pcie_stop_link(). (In the downstream
vendor kernel, PCIE_CLIENT_GENERAL_DEBUG is used as a software scratchpad
register written by vendor-specific link-up code that is not present
upstream.)

Furthermore, even if PCIE_CLIENT_GENERAL_DEBUG latched hardware LTSSM
transitions, rockchip_pcie_link_status_clear() is called before
dw_pcie_suspend_noirq() while the link is still active:

rockchip_pcie_suspend()
  rockchip_pcie_link_status_clear()
  dw_pcie_suspend_noirq()
    rockchip_pcie_pme_turn_off()
    dw_pcie_get_ltssm() /* polls for L2_IDLE */
    dw_pcie_stop_link()
  ...
  clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
  reset_control_assert(rockchip->rst);

Because dw_pcie_suspend_noirq() subsequently broadcasts PME_Turn_Off,
transitions LTSSM to L2_IDLE, and stops the link, and rockchip_pcie_suspend=
()
then disables clocks and asserts reset_control_assert(rockchip->rst) (which
resets the APB client registers across suspend/resume, requiring
rockchip->intx to be saved and restored), is this write to
PCIE_CLIENT_GENERAL_DEBUG needed or intended to target a different mechanis=
m?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D10
