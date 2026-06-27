Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F07149DF1;
	Sat, 27 Jun 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782563171; cv=none; b=aLywN33sMYejcZEKLHnRGSr4FtbcDNiYSFX/XC6y3Z04BlDB8snnLC2Aqiw10YcIJJCY0btc0itQxo0mGJpoh+F1GxGWWZNoFqAoX65F39a8W3x2C/kc4SrmPtw+I3N4+3uE3AZv5ufmBZrxCqFp3izoHD64wkDcPPjGO4GWlic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782563171; c=relaxed/simple;
	bh=6L67Q1YuT29WHdUI6cF3grnYgUEHeCJTslF7e9r/sjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=esvZJjfEzkwdYdyYjT8P0yYLs+Mo3fNg+B4Xz/ZzAe0WFCd4N5t12WuLb/OY3szgK9+GxNvgVc+5IO0y/+YXG1oB2R6yUARlYWTiJQBP12ptkB4uBR3ijJVAx/VJutHgAhu8cp30i86Q0Qp7jj7l3Oo0SWRNJ9E+BRDhQOKkz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT8+cwLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT8+cwLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391C21F000E9;
	Sat, 27 Jun 2026 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782563169;
	bh=CV2A9fxBHTBY2KPDL00oHPb22/777KD5br5FudhVXrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GT8+cwLQ4sNJBMmfiWyKPmmkDNJg9N9gRjV8eqyByFIesY5X0glVPWd+Rmha0RWAd
	 ZByLKSHUXf7q9FjcJ3K5vmD4XiOGg4XHy52lhoKyMQfOIlKEWPlXbEZrz+tJzFA59N
	 F8bGuiWt/mExtXRbThSaBtx6Aj2YCw2kiJBUKnKqOxfjnNXfsbAPdso3tNS37dAdAM
	 Q05YtPknKG7Z4H4jZ6JtsQjPNhW7dUvTWtzane20lqUe8txc2FRoUBdcbWxTw5s1tX
	 LSTLYUJRMmUD8qLrtWgMhnHGjYyPpuPXqLbvmUD734tCe15fOa28J5zTCcDvHWfA/V
	 jrMqOcn/pgFBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] clk: en7523: add support for dedicated PCIe
 PERSTOUT reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260627121450.3529133-3-ansuelsmth@gmail.com>
References: <20260627121450.3529133-1-ansuelsmth@gmail.com>
 <20260627121450.3529133-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 12:26:08 +0000
Message-Id: <20260627122609.391C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The newly added `REG_NP_SCU_PCIC` reset bank shares register `0x88=
` with the clock framework, causing a cross-subsystem data race.

Pre-existing issues:
- [High] Missing spinlock in reset controller update function leads to intr=
a-bank read-modify-write races between concurrent resets.
- [High] In `en7523_pci_prepare`, a stale local variable is reused for mult=
iple delayed register writes, which will silently overwrite any concurrent =
changes made by the reset framework.
- [High] The clock `.disable` callback (`en7581_pci_disable`) calls `usleep=
_range()`, which sleeps while holding the clock framework's IRQ-disabled sp=
inlock.
--

commit 1a24107acd835b1f50aa873616efba12fb4d03d2
Author: Christian Marangi <ansuelsmth@gmail.com>
Subject: clk: en7523: add support for dedicated PCIe PERSTOUT reset

This commit adds support for resetting the PCIe lines using the PERSTOUT
reset, controlled by the PCIC register. It implements inverted logic for
these bits within the reset function. The PCI enable and disable functions
are also updated to drop PERSTOUT bits in favor of this dedicated reset
handling.

> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> index 1ab0e2eca5d32..c9b21d9bf2f3f 100644
> --- a/drivers/clk/clk-en7523.c
> +++ b/drivers/clk/clk-en7523.c
[ ... ]
> @@ -650,9 +654,7 @@ static void en7581_pci_disable(struct clk_hw *hw)
>  	void __iomem *np_base =3D cg->base;
>  	u32 val, mask;
> =20
> -	mask =3D REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1 |
> -	       REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT2 |
> -	       REG_PCI_CONTROL_PERSTOUT;
> +	mask =3D REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1;
>  	val =3D readl(np_base + REG_PCI_CONTROL);
>  	writel(val & ~mask, np_base + REG_PCI_CONTROL);
>  	usleep_range(1000, 2000);

[Severity: High]
This is a pre-existing issue, but does this sleep cause a bug when called f=
rom
atomic context?

The clock framework core invokes .disable callbacks with the global enable_=
lock
raw spinlock held and local interrupts disabled. Inside en7581_pci_disable,
there is a call to usleep_range().

Could this lead to a system panic or deadlock by sleeping inside an atomic
context? Should this either use an atomic delay like udelay() or be moved to
the .unprepare callback?

[ ... ]
> @@ -754,14 +756,21 @@ static int en7523_reset_update(struct reset_control=
ler_dev *rcdev,
>  			       unsigned long id, bool assert)
>  {
>  	struct en_rst_data *rst_data =3D container_of(rcdev, struct en_rst_data=
, rcdev);
> -	void __iomem *addr =3D rst_data->base + rst_data->bank_ofs[id / RST_NR_=
PER_BANK];
> +	u32 offset =3D rst_data->bank_ofs[id / RST_NR_PER_BANK];
> +	void __iomem *addr =3D rst_data->base + offset;
> +	bool inverted =3D false;
>  	u32 val;
> =20
> +	/* For PCIC reset logic is inverted, 0:assert 1:deassert*/
> +	if (offset =3D=3D REG_NP_SCU_PCIC)
> +		inverted =3D true;
> +
>  	val =3D readl(addr);
> +	val &=3D ~BIT(id % RST_NR_PER_BANK);
>  	if (assert)
> -		val |=3D BIT(id % RST_NR_PER_BANK);
> +		val |=3D inverted ? 0 : BIT(id % RST_NR_PER_BANK);
>  	else
> -		val &=3D ~BIT(id % RST_NR_PER_BANK);
> +		val |=3D inverted ? BIT(id % RST_NR_PER_BANK) : 0;
>  	writel(val, addr);

[Severity: High]
This isn't a bug introduced by this patch, but does this read-modify-write
sequence need a spinlock?

The en7523_reset_update function modifies MMIO registers locklessly. If
different drivers concurrently call reset_control_assert or deassert on the
same reset bank, wouldn't they race and overwrite each other's register
changes?

[Severity: High]
Is there a cross-subsystem data race introduced here by sharing register 0x=
88
between the clock and reset frameworks?

This patch maps REG_NP_SCU_PCIC (0x88) as a reset controller bank. However,
this same register is mapped as REG_PCI_CONTROL and modified by the clock
framework in en7581_pci_enable.

Since en7581_pci_enable runs under the clock core's enable_lock spinlock, a=
nd
en7523_reset_update runs locklessly, will concurrent accesses from these two
paths result in one silently overwriting the other's bit modifications?

[Severity: High]
This is a pre-existing issue, but does en7523_pci_prepare overwrite concurr=
ent
register changes made by the reset framework?

In en7523_pci_prepare, a local variable is reused for multiple delayed regi=
ster
writes:

drivers/clk/clk-en7523.c:en7523_pci_prepare() {
    val =3D readl(np_base + REG_RESET_CONTROL1);
    ...
    writel(val & ~mask, np_base + REG_RESET_CONTROL1);
    usleep_range(1000, 2000);
    writel(val | mask, np_base + REG_RESET_CONTROL1);
    msleep(100);
    writel(val & ~mask, np_base + REG_RESET_CONTROL1);
}

If a device requests a reset on bank 1 (REG_RESET_CONTROL1) during the ~115=
ms
sleep window, won't the final writel() in en7523_pci_prepare silently overw=
rite
those state changes using the stale val?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627121450.3529=
133-1-ansuelsmth@gmail.com?part=3D2
