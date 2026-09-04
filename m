Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AE370AC0
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485695; cv=none; b=f17RF9JzT6rRZ9+Yegni0yaTGb6VlW8FuAbZAw4R5KfkMqekcEWXhwr1ipVI0Mlpag22GF4Jke15euyxY9ld3z3jn+ADPuKlzFGa2saimDZ0D8Zn/8gUXyDbRUTtyAfcX9KARLQzjiQvKB2NbWI8QBQ5e0ghTAY0wmjYh6kRvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485695; c=relaxed/simple;
	bh=RNaRJA/g3n3g0Jb+32AsYix9Ci5GSE/V2Fci9MRFrjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZXdNgTCJERy+QcXer8xWrd7LNXtRIs3SftkJudEPv/18e/E/IMu0hvqOrbiaxpYzqIn9b7jT6XL2XlpmsqKSYC1e/C9gPmJpzw+N/S3KJnGYbJt5NaQ3+Y7bns+4ZwMeINX6K1gkW+q/11Gijb25QS6qQBhrJ5fCrTPLgpp9CKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbhZOjgE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbhZOjgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E01F000E9;
	Fri,  4 Sep 2026 01:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788485683;
	bh=EvJh02t0i1/t7wEXJ0c/6tooAkNguEhnZKwg360+2vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XbhZOjgEmd/ZTLZ8eEEwxmMDKPBpjLjzLPImlQkiSeoi9kX0zcn0FLc9nbAzXTo1N
	 y2fgL4QJtgiWULf2OdDZh48ol3mdIST4xZS8nv0VAZFVGzp2Wrg8lREO6eDgP43UrV
	 4uJOKqO/NyPo8jfmhPplHbxmxVjXdSUP19MeLSRj4tNpVt5/OxqxFBmtsTwtK9iOHp
	 jRvF+8++3HZewm86vJpN99A4HDh88GJVW2wgiWiud42F39IttJ0ioi8iGhPhk/wr8y
	 rDc93/0rKsUg0S0qopYK9otEG4EpDazarp86Van/u81XOTzrxAiDdaTryNWLOzbRt1
	 PTypXpRMXs7TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dw-rockchip: Mask the INTx IRQ while the
 controller clocks are gated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1788484709-139123-3-git-send-email-shawn.lin@rock-chips.com>
References: <1788484709-139123-1-git-send-email-shawn.lin@rock-chips.com>
 <1788484709-139123-3-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 01:34:42 +0000
Message-Id: <20260904013442.DA7E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unbalanced `disable_irq()` on error paths permanently masks the IN=
Tx IRQ if the root port reset is retried.

Pre-existing issues:
- [Critical] Retrying `.reset_root_port()` after a failure causes clock and=
 PHY reference underflows and a synchronous external abort.
- [High] The threaded `sys` IRQ handler can race with `.reset_root_port()` =
and access unclocked APB registers, causing a synchronous external abort.
--

commit cc5a74b643533e890391de6a7a4d14fe8bd7c3e8
Author: Shawn Lin <shawn.lin@rock-chips.com>

PCI: dw-rockchip: Mask the INTx IRQ while the controller clocks are gated

This patch masks the INTx IRQ during root port reset to prevent the chained
handler from reading APB registers while clocks are gated. The IRQ is then
re-enabled after clocks are restored.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index ecf0d7e043b36..aee5ca8a6ca84 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c

[ ... ]

> @@ -925,6 +924,16 @@ static int rockchip_pcie_rc_reset_root_port(struct p=
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
> +

[Severity: High]
If rockchip_pcie_rc_reset_root_port() fails and returns early, it
intentionally skips calling enable_irq() to keep the IRQ masked while the
controller is unclocked.

If the reset is later retried (e.g., via AER recovery or sysfs), will the
second call to disable_irq() increment the IRQ descriptor's nesting depth
counter to 2?

If a subsequent reset attempt succeeds and calls enable_irq() exactly once,
could this regression leave the INTx IRQ permanently masked with a depth of=
 1,
even though the clocks have been successfully restored?

>  	dw_pcie_stop_link(pci);
>  	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);

[Severity: Critical]
This is a pre-existing issue, but retrying the reset after a failure appears
to be problematic here.

If a previous call to rockchip_pcie_rc_reset_root_port() failed after turni=
ng
off the APB clocks and returning early, the clocks and PHY remain
deinitialized.

On a retry, dw_pcie_stop_link() is called immediately while the APB clocks =
are
still gated. Since dw_pcie_stop_link() accesses the unclocked APB registers,
will this cause a fatal synchronous external abort?

Additionally, could the subsequent calls to clk_bulk_disable_unprepare() and
rockchip_pcie_phy_deinit() cause clock and PHY reference count underflows on
a retry?

[Severity: High]
This isn't a bug introduced by this patch, but does the threaded sys IRQ
handler have a similar clock gating race condition?

The threaded handler rockchip_pcie_rc_sys_irq_thread() reads the APB regist=
er
PCIE_CLIENT_INTR_STATUS_MISC without synchronizing against clock gating.

If dw_pcie_stop_link() triggers a link-down event, it could fire the sys IRQ
just before clk_bulk_disable_unprepare() disables the APB clocks. Can this
cause the concurrently running sys IRQ handler to access unclocked APB
registers and trigger a fatal synchronous external abort?

>  	rockchip_pcie_phy_deinit(rockchip);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1788484709-139123-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D2
