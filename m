Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436965;
	b=ZHflgB3euWyN6vBX2p0AWXqfjaoochvwWtTU/h7GjDTNkRhMtbUBhYCVdCt47tennJgs
	 3fUrzAV0M3BwUACpn02k3Z49+JX+jPzzdJzBGLlQuSPtJTfAWMgrjx3zg77HRzccXvFCE
	 tq2CG4p85aW2Wod7ivahDEWgepvKkxST1gEuJL/rIYbNUAhTxBl8wAI2kEj/NG/S27MpX
	 PDXdN/iE7olMf5cXtbNT09tbwgLzcff5n9LeQIi+VYLDlPcFLMPIX8xRfLLJ+AIIHC8qv
	 tcFKmbAFYqwxcVN1U6WGWVoO/xbrbv8INr7ZZ/y9K6sYkLhYsyzvssj1rl6nUd4XPLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=swYGRs5qeJ5/v/wqZ/CRY8UEo2gifcUomkoXZjWQd6M=;
	b=TrkE0UeA2mP/rZUnfiG7V5VKwVXBNboV5rzJDMiqZGI4F4CwpSVViSsO5++05/7iua9q
	 2tDOfLaH5G1kmcc3J1e6KLlh2cqth/7YIC3tu4+MXA3IkTwO01BklOP7UZOSnY5FDNxr2
	 YRxTVH4gxPwGrs029UVibnQQQ+aYwnFUjwumH9tOdgJoHbBA9Mka40A7Nx6elt0J/+1xy
	 /uLu0hJgU8/5yQTkL1DnBGFD/3piLdNDSEr4eTyvKov/w1+QlOr9ZUTb6lstQBDGu47Ii
	 QfO+JamTRCu/OlXDqc2CXb2nm7fRtjEa+CC3IyFOsYJNyZaWDYFQAt+xHIyqqojKyBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXcfrcWl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B08606A31E
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXcfrcWl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6871D1F000D0;
	Mon, 23 Nov 2026 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436964;
	bh=swYGRs5qeJ5/v/wqZ/CRY8UEo2gifcUomkoXZjWQd6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nXcfrcWlNM9iA6LOWFtGJgzeaGjOrhmZKpqppvHxzSpG3nI9lG/z7sanzyls/w6Tk
	 Dz0bs4nHdeItMd+yQSX9dsM5ccJBv7/AJJtqrZjVcG84nyvbuw7skspPX8o+wQ09g5
	 SoWKDmxGYKhbJEe6S62i3myzxsv5wn36VNHZc7vMQVzn2HLrXpDJxcy9W2h7jx+btC
	 OXdmcZdJ9O8KRQHOkjS/bYFzADaps1pT/eui2lHLbx2KArCc9Z8QGAh2UV3XMfwYLQ
	 Df2JjN85BKtUFVdjVXTQqq/eGy8Xi5HxyKLhBSSkOGssjHqp0kQbQHjH2+qfBn7ZBE
	 3RA0aDGJivljQ==
Message-ID: <sashiko-outbox-229219@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Clear stale link down interrupt
 before unmasking it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123121217.1107902-2-cassel@kernel.org>
References: <20261123121217.1107902-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:29:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] PCI: dw-rockchip: resource underflow in
  rockchip_pcie_rc_reset_root_port() [1]
--

commit 923d90cd91ba94b914ca3ad6a3e4e9904ee542db
Author: Niklas Cassel <cassel@kernel.org>

PCI: dw-rockchip: Clear stale link down interrupt before unmasking it

This commit clears the pending PCIE_LINK_REQ_RST_NOT_INT status bit before
unmasking the link-down interrupt, and keeps it masked during Root Port
resets until link training completes.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index ab2e266994095..2ef7ae97eb10b 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
[ ... ]
> @@ -898,6 +908,9 @@ static int rockchip_pcie_rc_reset_root_port(struct pc=
i_host_bridge *bridge,
>  	u32 val;
>  	int ret;
> =20
> +	val =3D FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 1);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +
>  	dw_pcie_stop_link(pci);
>  	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>  	rockchip_pcie_phy_deinit(rockchip);

[Severity: High]
This problem wasn't introduced by this patch, but can a failure in
rockchip_pcie_rc_reset_root_port() leave rockchip->clks and rockchip->phy
disabled and underflow their enable counts [1] on a later reset?

After clk_bulk_disable_unprepare() and rockchip_pcie_phy_deinit() run, an
error from reset_control_assert() (or any of the later failure paths that
unwind back to deinit_clk / deinit_phy) returns with the clocks and PHY
disabled, so the next rockchip_pcie_rc_reset_root_port() call disables
them a second time.

[1] https://sashiko.dev/#/bug/linux-8ab80679-6144-4519-a14c-191434f49050

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123121217.1107=
902-2-cassel@kernel.org?part=3D1
