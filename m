Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A127396588
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580570; cv=none; b=Fv2yOfxud6P3GDU6fA0zOi7iM3YufCZV66ALz7qxUg0rOo9yN2/WaFYYgFYPnDqLkG8Z1B78htqUUAQLjNt5rB0vYz3NPPNFWYqawKgwbvMsDNAFW/mD3aJoGm0Uri3vD8dZtDBgzGQyz75KSWTYWdhtHqM4qkoK30kk//xuQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580570; c=relaxed/simple;
	bh=0IBH/MtbdQDXOZwYw7drBXhlDvJg+cO74o12NOEpeYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mt3NFlHuWVUAl5RQZFzP4M6V/ZiKZSvRcixm+/tBA5hPDn5yeDRSTek4Jbc93KfU0vpaybdL2BU9mZSuDWKrppnDrehFx65K2c/zuepkBYmb339/hFge78M+9nDriVLaaUY73gTRxDs33s7XVRWDGrfLevW3aiT8S92p2fniRdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+w9AViZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+w9AViZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A296A1F000E9;
	Thu,  9 Jul 2026 07:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580569;
	bh=NzIqQ2D9aMXkHds0tnuIATjx2bm6szjPYh6ykWpAR+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+w9AViZIaK6t2//w6EtsvDN7Guhk9/iX7y8SI6IoPE4JkIkM49nUO0hMPa/sKxtl
	 XoH/kpvbvzGBDd5dKAkv+VefyBwpfHJrR784n6yiRNLcP860vNBQPlR8SbYC0MEiTc
	 5WkEZd0c+B22TwO75sJP7jhlr3DYWQ2pkKs8Qsjsz/XYeO5lvcVUjS0Jz3g0AuxDPp
	 SYCHD/MWIxg8W3s1nVa2q18UUhE9lQmQoFmtNBGAOW9yhz2x4S5uxXx92Hz2JRlMa8
	 NBoPMet5CwS5y7WS4fI5C6fpPPpsyewRZzEfPQXvbCKX+PrzvrLKTE4+k4sdYPWUtU
	 ooAvyum94o3Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] PCI: qcom: enable Link retain logic for Hamoa
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, linux-phy@lists.infradead.org, olteanv@gmail.com, neil.armstrong@linaro.org
In-Reply-To: <20260709-link_retain-v3-4-81a9d187bb61@oss.qualcomm.com>
References: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
 <20260709-link_retain-v3-4-81a9d187bb61@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:02:48 +0000
Message-Id: <20260709070248.A296A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Probe deferral leaks PHY power-on, clock, and regulator enable cou=
nts when `link_retain` is active.
--

--- Patch [4]: [PATCH v3 4/4] PCI: qcom: enable Link retain logic for Hamoa=
 ---
commit a80ea22accc5e92e309b80e7933e0f0bac88c9ec
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: qcom: enable Link retain logic for Hamoa

The Hamoa platform supports keeping the PCIe link active across
bootloader and kernel handoff. To take advantage of this, introduce a
specific configuration (cfg_x1e80100) with link_retain =3D true and
update the device match table to use it.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 77d2d989e9da5..0b345a16f4cf6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1671,6 +1671,12 @@ static const struct qcom_pcie_cfg cfg_sc8280xp =3D=
 {
>  	.no_l0s =3D true,
>  };
> =20
> +static const struct qcom_pcie_cfg cfg_x1e80100 =3D {
> +	.ops =3D &ops_1_21_0,
> +	.no_l0s =3D true,
> +	.link_retain =3D true,

[Severity: High]
Does enabling link_retain here cause a resource leak during probe deferral?

In qcom_pcie_host_init(), if an initialization step returns -EPROBE_DEFER a=
nd
link_retain is true, the error path returns early:

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_host_init() {
    ...
err_pwrctrl_destroy:
    if (pp->link_retain && ret =3D=3D -EPROBE_DEFER)
        return ret;
    ...
}

This bypasses err_disable_phy and err_deinit which would balance the
resource counts.

Since qcom_pcie_init_2_7_0() unconditionally enables the regulators and
clocks, and qcom_pcie_phy_power_on() enables the PHYs, won't these reference
counts be leaked on each deferral retry? When the driver is eventually
removed, deinit() will only decrement them once, leaving the resources
permanently enabled.

Is there a way to balance these reference counts during a probe deferral
when link_retain is active?

> +};
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-link_retai=
n-v3-0-81a9d187bb61@oss.qualcomm.com?part=3D4
