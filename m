Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0B23BD06;
	Thu, 25 Jun 2026 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425244; cv=none; b=fxiBKZ/gNK94ZryUY14I9DFvfn0Tp/1N6iaX3xMHP6m9AFzTTQPkODj2tm3D22oOV+d+yRvN1eXMOvs9yshyPnRQ/X3IE3W/fPRWN6pi58RSElmAfBTnb+Ay8jvcoYA2wjUkmPcTmqnnQWwq7BKbiNTJOubQg5SyQ5XO0XvY5CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425244; c=relaxed/simple;
	bh=muxrBQywzUXhDRkiTRVvC3lvFvXTqRuMbsIc3X0mGz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cQ+QNUUWxsDdIMWpTKP6ZbM0yUJ2maUBNKkr3al4jP5Wta08SK7EQO039VpF02TRp3CdTf53CnHocRMC8Bl4PUdpnA0GK+TC/PlImzawE7p0gMXeJjCw2TSQw8gH10a6c4QHetxvwUP789tK6Q22d4EVJUiiaAPOv9juevl4g0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSO3eECH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSO3eECH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BDD1F000E9;
	Thu, 25 Jun 2026 22:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782425243;
	bh=8/8AmWqNvxsv/3NFZh0J4JdNhuDYYW8+AhcDD55TwHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PSO3eECHUgMrlAmAcJD+GIS+Jf44CxmL5UU0wk404wpD8V6MdfvqRXsFCrwuW4zvX
	 6GBphdepe2hMCaaQkUGid4BPFbmv3WNeo+u0NffLyw/Gfa88FqQC192bj0OHy8jYyB
	 6FKUf6elO0X/4D/5Pkjy5fNqtPw0rbUwS+tHt/Cw2n8VAUKhjGQqMKLnG72i1iMyAE
	 u88J426x/J55iox3WYR7ui+gtNcfmzHx3uLzOtTn0WxnIMx2piwt8ZtVZ4iMtJNs2/
	 k9jfrbSg/ym6kJxv44Gj/c3TDnKjzy7fmv4BqmbgdRmQz5TyIB9PGLzBymzg31Fo9H
	 B2XwoFFlLWdOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: airoha: Add additional reset
 for PCIe PERSTOUT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260625215741.3253212-2-ansuelsmth@gmail.com>
References: <20260625215741.3253212-1-ansuelsmth@gmail.com>
 <20260625215741.3253212-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:07:22 +0000
Message-Id: <20260625220722.E1BDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race between direct MMIO and regmap accesses on the SCU_PCIC =
register.
--

commit 900fc8364d6744e062fdb68cdff6066cb3ba875d
Author: Christian Marangi <ansuelsmth@gmail.com>

dt-bindings: clock: airoha: Add additional reset for PCIe PERSTOUT

Add additional reset to control PCIe PERSTOUT reset line for each of the 3
PCIe lines.

> diff --git a/include/dt-bindings/reset/airoha,en7581-reset.h b/include/dt=
-bindings/reset/airoha,en7581-reset.h
> --- a/include/dt-bindings/reset/airoha,en7581-reset.h
> +++ b/include/dt-bindings/reset/airoha,en7581-reset.h

[ ... ]

> @@ -62,5 +62,9 @@
>  #define EN7581_CPU_TIMER_RST		50
>  #define EN7581_PCIE_HB_RST		51
>  #define EN7581_XPON_MAC_RST		52
> +/* RST_PCIC */
> +#define EN7581_PCIC_PERSTOUT0_RST	53
> +#define EN7581_PCIC_PERSTOUT1_RST	54
> +#define EN7581_PCIC_PERSTOUT2_RST	55

[Severity: High]
Will adding these resets expose a data race between the reset controller and
the PCIe controller during link bring-up?

When these resets are asserted, en7523_reset_update() in clk-en7523.c
performs an unlocked direct MMIO read-modify-write on the SCU_PCIC register:

drivers/clk/clk-en7523.c:en7523_reset_update() {
    ...
    val =3D readl(addr);
    val &=3D ~BIT(id % RST_NR_PER_BANK);
    ...
    writel(val, addr);
}

At the same time, mtk_pcie_en7581_power_up() in pcie-mediatek-gen3.c
modifies the same SCU_PCIC register using a regmap:

drivers/pci/controller/pcie-mediatek-gen3.c:mtk_pcie_en7581_power_up() {
    ...
    regmap_update_bits(pcie->scu, SCU_PCIC, SCU_PCIC_PCIE_CTRL,
                       FIELD_PREP(SCU_PCIC_PCIE_CTRL, BIT(1)));
}

Since the regmap internal lock does not protect against direct MMIO accesses
from clk-en7523.c, could concurrent operations (like one port triggering a
reset while another powers up) silently corrupt the SCU_PCIC hardware
register state and cause PCIe links to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625215741.3253=
212-1-ansuelsmth@gmail.com?part=3D1
