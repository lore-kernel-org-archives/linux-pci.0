Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4439A4CF
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 02:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045517; cv=none; b=Oopzu0pcgHoeRjtjRCA9if/SwV3u8stfIuYWCFyFAG2qWnVogqO+VApW0cv/1JriQPlGYuNr1JPQvwHwD+nJUwSnT7eauwfBtEuj481kHsxiY2U8xVeJrYdPOpMVExXfloaPwhDSpkHj9KC5+tLUwcjs8zcfHQ3WwBtKwQ1LbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045517; c=relaxed/simple;
	bh=wV5Gy1TzYCmc0LZ9VAQh8GhRTuBr4y0tws+N53CNvjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jEfvtR/bPjCSzqbdwNRaT+TxgQZ3uA8FBHjbhdLDaoXHwQVRgmAetiehJ0FEqgwgPjBdciBWa1RGlNYsYu8+g6G4beJWZEakqoX7X7Tl5HDIJDpq0A2Y39yzUCVty4+i/WVVnsky1JekUiTIc0OREoU7TdDbrua/VncIkHGUOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH7AaR4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH7AaR4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1557D1F000FF;
	Tue, 22 Sep 2026 02:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790045516;
	bh=GABmxU6B0d9YM/BwSLWlhF7Qw1udafc/z8RtFiOjNNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QH7AaR4V1+oqh724lo4JjXyhg0NsZbpPo4XBosxeuVsHo+j7KY9hd8LakM4h0KYCl
	 AP62l09EOg5jGlFGQrQ7hyafJLI7T2CwGu0IGXOL3GbRlC2LxBviXDa728qj2x6gGt
	 A9Ykyen+Xt41RvZZ6n4XAHIplEWiygsY2SvOrOHOXp0uj3aalrbPskS0sUuiAHz6DU
	 Uo5KCQxwB/1PI5jDPbaC163XB1GzdSTbXwd+wB8f3WGDDQyvkMrC4NM4Sn1SFn/1Vz
	 T2kmc6XSKZ666XD2L8wfOocegv1ZABCt8k/hRenQEjlTUZjjKeCvDN4QD2bq90GEWI
	 iYzuvgT9vFOPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] PCI: dw-rockchip: Mask the INTx IRQ while the
 controller clocks are gated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1790044622-164744-4-git-send-email-shawn.lin@rock-chips.com>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
 <1790044622-164744-4-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 02:51:55 +0000
Message-Id: <20260922025156.1557D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: dw-rockchip: leaked IRQ depth permanently masks INTx on reset=
 failure
--

commit d458997529aaf8410a72de39760a744213ab9092
Author: Shawn Lin <shawn.lin@rock-chips.com>
Subject: PCI: dw-rockchip: Mask the INTx IRQ while the controller clocks ar=
e gated

This commit masks the INTx IRQ during root port resets to prevent synchrono=
us
external aborts when downstream devices keep their INTx line asserted. The =
IRQ
is left masked on error paths since the clocks remain gated.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 561c296c770eb..aee5ca8a6ca84 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -924,6 +924,16 @@ static int rockchip_pcie_rc_reset_root_port(struct p=
ci_host_bridge *bridge,
>  	u32 val;
>  	int ret;
> =20
> +	/*
> +	 * Devices may keep their INTx line asserted across the reset. Mask
> +	 * the INTx IRQ so that the chained handler does not touch the
> +	 * unclocked APB bus, which would raise a synchronous external abort.
> +	 * The IRQ is re-enabled once the clocks are restored, and is
> +	 * deliberately left masked on the error paths where the controller
> +	 * remains unclocked.
> +	 */
> +	disable_irq(rockchip->intx_irq);

[Severity: High]
Since disable_irq() increments the IRQ descriptor depth unconditionally,
does leaving the IRQ masked on error paths cause a permanent loss of INTx
interrupts if the reset is retried?

If rockchip_pcie_rc_reset_root_port() is called again after a failure,
disable_irq() will be called a second time, incrementing the depth counter
to 2. If that retry succeeds:

[ ... ]

> @@ -974,6 +984,7 @@ static int rockchip_pcie_rc_reset_root_port(struct pc=
i_host_bridge *bridge,
> =20
>  	/* Ignore errors, the link may come up later */
>  	dw_pcie_wait_for_link(pci);
> +	enable_irq(rockchip->intx_irq);

the depth counter will only be decremented to 1, and the INTx interrupts for
all downstream devices will remain permanently masked. Is there a way to
ensure the enable/disable depth remains balanced when recovering from reset
failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1790044622-164744-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D3
