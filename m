Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144C34CFC2;
	Mon, 21 Sep 2026 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970328; cv=none; b=onfyhIfLZ9O138rPu0zi3nDpDw4BVmIWD83L2SX78/rRQUh8tM5F19WXytuXOSrb/xKE0HepXqRABDBiP3gUMX+2Xb92BUX7GNkBHVy0IUCT/74NZqM0iTE5nbeP5M1sTpfU0+AksEHlQ/SsArnoBGHjk6vE7IqzvQipdM9T4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970328; c=relaxed/simple;
	bh=mYelbshIhLM3wTAGQJeCbPV7e51R3e9eB3wm9LiqUXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kn4kQifxt+u+ow3c7dE9ylrByO7SPVTLBKySzrv4FK0v/7BQM9fZ0xHL5Y7i/q6qnmb32m+y4EN2zDHq06D8TeNxfDOQX+lnTQfic9PI+Bc3p/sRgYpMzm5MCnSxxAb35gpb0ky5rlxIEPFS5Amg6fKfVwZOMo3rHq7Y9nj+Xic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBuBGRNV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBuBGRNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BAE1F000FF;
	Mon, 21 Sep 2026 05:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789970327;
	bh=mgcr85KsmTYdIXIqoA0MzDTrGO2EJEYc3deB7l5mHhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RBuBGRNVHZs/jiwQ7qZI+bM1F9JLj7PE5JdBoArYPi7A9gRfTykbBIVV71JoxF7lU
	 mJ2h3aGeQRBWqXeB4b8nC7VC80ipoMNRTB9uBi4jpkm+KPMFyNw+W8GZw3gjPL6sQF
	 3j5OND1xrW3mc+tBdvwFSeaN1l8gxw488ABDrcanDhLAjQEM2I3tgtzqTb8ZbpfZVK
	 KmKBFwbtMPCZFPu2FyUUqJ6CLR5+rF3L8gar4p86d7I2akxLp/q7G8y754ByobAIEW
	 iBvUuO+kkhCg6Vwrua01N3w0GVB30MUCfg+oyf7J9bwevGAUY9GLY9P+3PNRZ+h7BK
	 UmZMsh93pLXbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, olteanv@gmail.com
In-Reply-To: <20260921-nord-v4-6-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-6-ed05c6e09240@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:58:46 +0000
Message-Id: <20260921055846.B5BAE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused static array variables due to macro typo
--

commit 426e06547f75580c252f2935af9323cd36b0aced
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe multi-PHY support

This commit adds support for the Nord Gen5x16 bifurcated QMP PCIe PHY. It
adds configurations for x16, x8+x8, x8+x4+x4, and x8+x4+x2+x2 lane modes,
along with register programming and power sequencing.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/=
phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
[ ... ]
> +static const char * const nord_pciephy_port_a_nocsr_reset_l[] =3D {
> +	"port_a_nocsr",
> +};
> +
> +static const char * const nord_pciephy_port_b_nocsr_reset_l[] =3D {
> +	"port_b_nocsr",
> +};
[ ... ]
> +NORD_QMP_PCIE_PORT_CFG(a, pciephy_port_a_reg_l, nord_pciephy_port_a_pd_l,
> +		       nord_pciephy_port_a_reset_l, pciephy_port_a_nocsr_reset_l,
> +		       nord_pciephy_port_a_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(b, pciephy_port_b_reg_l, nord_pciephy_port_b_pd_l,
> +		       nord_pciephy_port_b_reset_l, pciephy_port_b_nocsr_reset_l,
> +		       nord_pciephy_port_b_pipeclk_l, true);

[Severity: Low]
Does this code accidentally pass pciephy_port_a_nocsr_reset_l instead of
nord_pciephy_port_a_nocsr_reset_l into the NORD_QMP_PCIE_PORT_CFG macro for
port a (and similarly for port b)?

This leaves the newly defined nord_pciephy_port_a_nocsr_reset_l and
nord_pciephy_port_b_nocsr_reset_l static arrays entirely unused.

This will trigger a -Wunused-variable compiler warning, which can cause
build failures when compiling the kernel with -Werror.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-nord-v4-0-=
ed05c6e09240@oss.qualcomm.com?part=3D6
