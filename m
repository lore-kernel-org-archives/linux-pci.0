Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8A2DE6FB;
	Mon,  2 Feb 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026104; cv=none; b=q/AQZPiIJHv7pIkGc1gVj4R1SSmoxKBuhwCFCzA3n11Bb9YXNQ7LIrk1kOsKTdLenAOKjsu8aiqIXE/DjO2VF40/D7EmeB+Qpc5ZJUw96pAeHBVQNrVra8HwJsxperi4VCxLYX7Hf5DZGs8sFVsyunyQaFdYAh75uRMi650bLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026104; c=relaxed/simple;
	bh=lsw0eR4c5APt/3xcULKgpWlgBGnITGXccb/xcCY4y9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCAXBHY49SdWC4UdhCN687DFX6Rn2e+gaTpBB3lmKxpNh+xV5wIPAi64xZbodA3DeZjJ4LeaD4IbP0YVR/Daf59Knfq6fU9YBCwJX/oQY2W+ceZEfhzi8/UEI/Njszz/y+S3VIjpRiJsVKoe8lfw12WiFYbBYxDdME5zmfTlbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKgtmkwv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKgtmkwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4ACC116C6;
	Mon,  2 Feb 2026 09:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026103;
	bh=lsw0eR4c5APt/3xcULKgpWlgBGnITGXccb/xcCY4y9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKgtmkwvenC5rUOPJx/d/zVCRcKWIeYzY4mwq7El18fBm9iOqhm30DX3MCOsrO5oX
	 se2xbggP8B2krp/yrQfnJe48CUZ7EC6IerR03YirktkzOFNDsibrgdqhLM+2Ac2UxR
	 o1zC6Mj6FilVouTWnZrQ1+Dae769Kkhsk7FKMIVNcxktW8y8UcAyqCSFpfOi+f8EXt
	 nmE5+PiosYWXFE/oHIuOQD2YLGLoJbIaN7RWeGIAufjdFPKTc9QsqAHzbNkQh3P9O1
	 NQ1s+T1Zw4hbfb4EBWR4ykXyZbCrC5mZoM24rzNjgchmpswb9GAgGD4jxZDFquiFR+
	 GndESMf1gY/cQ==
Date: Mon, 2 Feb 2026 10:54:58 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Grimmauld <grimmauld@grimmauld.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <aYB0ctHF1ZeIIzbq@ryzen>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <aXtpg0V_sifQEWHJ@grimm-nixos-ssd-2>
 <aXyHITrZ89Mmn8_J@ryzen>
 <CANAwSgTQ-cdyzd2WjHMYCY33p7um3CpjMeTzRO7vcd0fTF6X9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgTQ-cdyzd2WjHMYCY33p7um3CpjMeTzRO7vcd0fTF6X9Q@mail.gmail.com>

On Sat, Jan 31, 2026 at 03:08:42PM +0530, Anand Moon wrote:
> >
> I’ve attempted to reproduce the warning but was unable to trigger it locally.
> 
> I have tested with the built-in module
> CONFIG_R8169=y
> CONFIG_R8169_LEDS=y
> 
> As well as the module
> CONFIG_R8169=m
> CONFIG_R8169_LEDS=y
> 

I'm running with:
CONFIG_R8169=y
CONFIG_PHYLIB=y
CONFIG_REALTEK_PHY=y
CONFIG_REALTEK_PHY_HWMON=y

CONFIG_PCIE_ROCKCHIP_DW=y
CONFIG_PCIE_ROCKCHIP_DW_HOST=y
CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=y
(PHY for the PCIe 2x)

$ cat /proc/cmdline
root=/dev/nfs nfsroot=192.168.1.10:/srv/nfs/rootfs_rc,nfsvers=4 ip=dhcp earlycon rootwait loglevel=8

Considering that all PHY drivers (for both Ethernet and PCIe),
and drivers (for both Ethernet and PCIe) are built as built-in,
having nfsroot= on the kernel command line should be no issue.

But, perhaps that is the reason why you cannot reproduce it?


> >
> > Having async probing for the Rockchip PCIe controller driver, which is
> > used a LOT of rockchip based SoCs, is a good thing, so I don't think it
> > is right to avoid enabling async probing just because it results in a
> > splat on a single rockchip based board (rock5b).
> >
> Yes, this could help in the module probe pci module.
> 
> Earlier, I thought gmac will control the r8169 module, but I was wrong.
> Could you please try these changes at your end? These changes are
> related to MIMO..
> 
> $ git diff ./arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> index b3e76ad2d869..fb3a8ba4085a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
> @@ -477,7 +477,6 @@ &pcie2x1l0 {
>  &pcie2x1l2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pcie2_2_rst>;
> -       reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
>         vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
>         status = "okay";
>  };
> @@ -535,6 +534,12 @@ pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>                 };
>         };
> 
> +       rtl8211f {
> +               rtl8211f_0_rst: rtl8211f-0-rst {
> +                       rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
>         usb {
>                 usbc0_int: usbc0-int {
>                         rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> @@ -550,6 +555,19 @@ &pwm1 {
>         status = "okay";
>  };
> 
> +&mdio0 {
> +       rgmii_phy0: ethernet-phy@1 {
> +               /* RTL8211F */
> +               compatible = "ethernet-phy-id001c.c916";
> +               reg = <0x1>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&rtl8211f_0_rst>;
> +               reset-assert-us = <20000>;
> +               reset-deassert-us = <100000>;
> +               reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +       };
> +};
> +
>  &rknn_core_0 {
>         npu-supply = <&vdd_npu_s0>;
>         sram-supply = <&vdd_npu_s0>;
> 

I tried your patch above, but I still see the splat.

But as I said, I don't think the splat should be a showstopper.


Kind regards,
Niklas
