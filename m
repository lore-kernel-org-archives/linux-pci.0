Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D9C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 16:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235472183F
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 16:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKgx5Pv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfC1Q7M (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:59:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38301 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1Q7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 12:59:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so4918062wmc.3;
        Thu, 28 Mar 2019 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lONDV1UVxJMQF8Cbdo1Owt5mcFTgAEWTY4ddj0ap9q8=;
        b=rKgx5Pv/YrVI0aSgYgPhPNxeWob/Khg97StVwhaF2tnzwjMKZDGc7cxkzCVQRd3FYw
         Ii+/IWzjMJdBJmo8906CUFEpT/GCG8u3bV/VplVilj39N2y4BCxCmwYtwywW916RVx0o
         yqdxnuU0TAluUqvsJCG0PhoV7fqk3ij+ZFHBVyL5iwPcrEHNd3YX/Else93GG5rGgmPA
         9dGiVhPNmC2zzJxlYhlGZ1YUTOHJrcdqAPPTTjmPMR+IXk/pVQaSG5nHOXp3vlyaldsD
         xvMkqPS+V+Ac1FizaY/c5Vd5Nlkp+/3asiZwl8+37mfChtcY2QZ6RjnJdk98rYHvrnDO
         x7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lONDV1UVxJMQF8Cbdo1Owt5mcFTgAEWTY4ddj0ap9q8=;
        b=GQYkwBYmSpopcWRf8Vv7iCpDVArA952sFi7xjJ+M3FEoecAKNFhc8y/33aeKHGqYqO
         bXrKQvnLpmTOATQN0jUCvyxwxJNPu6VG2iOD1d7+TF9y9ihvguO/h0uCFAGJ5MRiLUSH
         kAt/ZK19O7x6k8T35COzDMRgJ/hVRL2V/4lkz21t6kUig9po4/m2Uqhoeh8on3LTR2c1
         3DthbGgVK0yQ/aiWSusC9FolGnmbfljsuuxK4awLX5XCe43KFZ+66mhOTMNG6Wj2YmFg
         BYtWze27GaiCsZ5RttGqDUAOgnHfvLvVQ24mgWDHaqa0MmBTP08EtN5p4znZE1mvVS1A
         esqw==
X-Gm-Message-State: APjAAAXa8jB2C1ZVHBHDjNQ6/O+IUcuKYk8EeDrtrgXIjIIXzvkDZfvn
        mjGj49NkfNtnyLjDDXVqFrI=
X-Google-Smtp-Source: APXvYqx/0x9y+R23BJKi82935VpZTfz73fO8fGxx9NpSLdUXkVg2klf5NgtaJQF5c8SUovHg2T+Ycw==
X-Received: by 2002:a1c:f618:: with SMTP id w24mr656692wmc.3.1553792347321;
        Thu, 28 Mar 2019 09:59:07 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id r9sm11680425wrv.82.2019.03.28.09.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:59:06 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:59:05 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, tiwai@suse.de, spujar@nvidia.com,
        skomatineni@nvidia.com, liviu.dudau@arm.com, krzk@kernel.org,
        heiko@sntech.de, horms+renesas@verge.net.au, olof@lixom.net,
        maxime.ripard@bootlin.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        enric.balletbo@collabora.com, ezequiel@collabora.com,
        stefan.wahren@i2se.com, marc.w.gonzalez@free.fr,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        hayashi.kunihiko@socionext.com, yue.wang@amlogic.com,
        shawn.lin@rock-chips.com, xiaowei.bao@nxp.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH 06/10] arm64: tegra: Add P2U and PCIe controller nodes to
 Tegra194 DT
Message-ID: <20190328165905.GB31762@ulmo>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-7-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <1553613207-3988-7-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 08:43:23PM +0530, Vidya Sagar wrote:
> Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
> The Tegra194 SoC contains six PCIe controllers and twenty P2U instances
> grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P2Us)
> and NVIDIA High Speed (NVHS-8 P2Us) respectively.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 473 +++++++++++++++++++++++++=
++++++
>  1 file changed, 473 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index c77ca211fa8f..266a3058fa66 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1054,4 +1054,477 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent =3D <&gic>;
>  	};
> +
> +	hsio-p2u {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;

It doesn't look to me like there's really a bus here. Perhaps just leave
out that top-level hsio-p2u node? If you only want to somehow organize
these, perhaps a better way would be to add a comment.

Or: the address map lists something called PIPE2UPHY_XBAR at addresses
0x03e00000-0x03e0ffff. Perhaps that really ought to be the "bus" in this
case?

Also, please leave a blank linke between the properties and the nodes
for readability.

> +		p2u_0: p2u@03e10000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03e10000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_1: p2u@03e20000 {

Please leave blank lines between nodes for readability.

> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03e20000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_2: p2u@03e30000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03e30000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_3: p2u@03e40000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03e40000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_4: p2u@03e50000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03e50000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_5: p2u@03e60000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03e60000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_6: p2u@03e70000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03e70000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_7: p2u@03e80000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03e80000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_8: p2u@03e90000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03e90000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_9: p2u@03ea0000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03ea0000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_10: p2u@03f30000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03f30000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_11: p2u@03f40000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03f40000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +	};
> +
> +	nvhs-p2u {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +		p2u_12: p2u@03eb0000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03eb0000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_13: p2u@03ec0000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03ec0000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_14: p2u@03ed0000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03ed0000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_15: p2u@03ee0000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03ee0000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_16: p2u@03ef0000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03ef0000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_17: p2u@03f00000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03f00000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_18: p2u@03f10000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03f10000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +		p2u_19: p2u@03f20000 {
> +			compatible =3D "nvidia,tegra194-phy-p2u";
> +			reg =3D <0x0 0x03f20000 0x0 0x00010000>;
> +			reg-names =3D "base";
> +
> +			#phy-cells =3D <0>;
> +		};
> +	};

It's not clear to me why NVHS PHYs are listed as a separate bus. Also,
these really should be sorted by unit-address. If that means that HSIO
and NVHS PHYs are mixed, so be it. We can use comments to highlight
which PHYs are of which type. Or perhaps we really should be using
different compatible strings for them?

Same comments on the below as for the bindings earlier.

Thierry

> +
> +	pcie@14180000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
> +		reg =3D <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x38000000 0x0 0x02000000   /* window1 (32M)              =
*/
> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x38040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x38080000 0x0 0x00040000   /* DBI reg space (256K)       =
*/
> +		       0x18 0x00000000 0x4 0x00000000>; /* window2 (16G)              =
*/
> +		reg-names =3D "appl", "window1", "config", "atu_dma", "dbi", "window2";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <8>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <0>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
> +		clock-names =3D "core_clk";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> +		reset-names =3D "core_apb_rst", "core_rst";
> +
> +		interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic 0 72 0x04>;
> +
> +		nvidia,bpmp =3D <&bpmp>;
> +
> +		nvidia,max-speed =3D <4>;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <&bpmp 0x0>;
> +		nvidia,aspm-cmrt =3D <0x3C>;
> +		nvidia,aspm-pwr-on-t =3D <0x14>;
> +		nvidia,aspm-l0s-entrance-latency =3D <0x3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000  /* prefe=
tchable memory (13GB) */
> +			  0x82000000 0x0 0x40000000 0x1B 0x40000000 0x0 0xC0000000>; /* non-p=
refetchable memory (3GB) */
> +
> +		nvidia,event-cntr-ctrl =3D <0x1d8>;
> +		nvidia,event-cntr-data =3D <0x1dc>;
> +	};
> +
> +	pcie@14100000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> +		reg =3D <0x00 0x14100000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x30000000 0x0 0x02000000   /* window1 (32M)              =
*/
> +		       0x00 0x30000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x30040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x30080000 0x0 0x00040000   /* DBI reg space (256K)       =
*/
> +		       0x12 0x00000000 0x0 0x40000000>; /* window2 (1G)               =
*/
> +		reg-names =3D "appl", "window1", "config", "atu_dma", "dbi", "window2";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <1>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <1>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_1>;
> +		clock-names =3D "core_clk";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_1_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_1>;
> +		reset-names =3D "core_apb_rst", "core_rst";
> +
> +		interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic 0 45 0x04>;
> +
> +		nvidia,bpmp =3D <&bpmp>;
> +
> +		nvidia,max-speed =3D <4>;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <&bpmp 0x1>;
> +		nvidia,aspm-cmrt =3D <0x3C>;
> +		nvidia,aspm-pwr-on-t =3D <0x14>;
> +		nvidia,aspm-l0s-entrance-latency =3D <0x3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000  /* prefe=
tchable memory (768MB) */
> +			  0x82000000 0x0 0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-p=
refetchable memory (256MB) */
> +
> +		nvidia,event-cntr-ctrl =3D <0x1a8>;
> +		nvidia,event-cntr-data =3D <0x1ac>;
> +	};
> +
> +	pcie@14120000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> +		reg =3D <0x00 0x14120000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x32000000 0x0 0x02000000   /* window1 (32M)              =
*/
> +		       0x00 0x32000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x32040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x32080000 0x0 0x00040000   /* DBI reg space (256K)       =
*/
> +		       0x12 0x40000000 0x0 0x40000000>; /* window2 (1G)               =
*/
> +		reg-names =3D "appl", "window1", "config", "atu_dma", "dbi", "window2";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <1>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <2>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_2>;
> +		clock-names =3D "core_clk";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_2_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_2>;
> +		reset-names =3D "core_apb_rst", "core_rst";
> +
> +		interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic 0 47 0x04>;
> +
> +		nvidia,bpmp =3D <&bpmp>;
> +
> +		nvidia,max-speed =3D <4>;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <&bpmp 0x2>;
> +		nvidia,aspm-cmrt =3D <0x3C>;
> +		nvidia,aspm-pwr-on-t =3D <0x14>;
> +		nvidia,aspm-l0s-entrance-latency =3D <0x3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x32100000 0x0 0x32100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000  /* prefe=
tchable memory (768MB) */
> +			  0x82000000 0x0 0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-p=
refetchable memory (256MB) */
> +
> +		nvidia,event-cntr-ctrl =3D <0x1a8>;
> +		nvidia,event-cntr-data =3D <0x1ac>;
> +	};
> +
> +	pcie@14140000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> +		reg =3D <0x00 0x14140000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x34000000 0x0 0x02000000   /* window1 (32M)              =
*/
> +		       0x00 0x34000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x34040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x34080000 0x0 0x00040000   /* DBI reg space (256K)       =
*/
> +		       0x12 0x80000000 0x0 0x40000000>; /* window2 (1G)               =
*/
> +		reg-names =3D "appl", "window1", "config", "atu_dma", "dbi", "window2";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <1>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <3>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_3>;
> +		clock-names =3D "core_clk";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_3_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_3>;
> +		reset-names =3D "core_apb_rst", "core_rst";
> +
> +		interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic 0 49 0x04>;
> +
> +		nvidia,bpmp =3D <&bpmp>;
> +
> +		nvidia,max-speed =3D <4>;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <&bpmp 0x3>;
> +		nvidia,aspm-cmrt =3D <0x3C>;
> +		nvidia,aspm-pwr-on-t =3D <0x14>;
> +		nvidia,aspm-l0s-entrance-latency =3D <0x3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x34100000 0x0 0x34100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000  /* prefe=
tchable memory (768MB) */
> +			  0x82000000 0x0 0x40000000 0x12 0xB0000000 0x0 0x10000000>; /* non-p=
refetchable memory (256MB) */
> +
> +		nvidia,event-cntr-ctrl =3D <0x1a8>;
> +		nvidia,event-cntr-data =3D <0x1ac>;
> +	};
> +
> +	pcie@14160000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
> +		reg =3D <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x36000000 0x0 0x02000000   /* window1 (32M)              =
*/
> +		       0x00 0x36000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x36040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x36080000 0x0 0x00040000   /* DBI reg space (256K)       =
*/
> +		       0x14 0x00000000 0x4 0x00000000>; /* window2 (16G)              =
*/
> +		reg-names =3D "appl", "window1", "config", "atu_dma", "dbi", "window2";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <4>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <4>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_4>;
> +		clock-names =3D "core_clk";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_4_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_4>;
> +		reset-names =3D "core_apb_rst", "core_rst";
> +
> +		interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic 0 51 0x04>;
> +
> +		nvidia,bpmp =3D <&bpmp>;
> +
> +		nvidia,max-speed =3D <4>;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <&bpmp 0x4>;
> +		nvidia,aspm-cmrt =3D <0x3C>;
> +		nvidia,aspm-pwr-on-t =3D <0x14>;
> +		nvidia,aspm-l0s-entrance-latency =3D <0x3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x36100000 0x0 0x36100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000  /* prefe=
tchable memory (13GB) */
> +			  0x82000000 0x0 0x40000000 0x17 0x40000000 0x0 0xC0000000>; /* non-p=
refetchable memory (3GB) */
> +
> +		nvidia,event-cntr-ctrl =3D <0x1c4>;
> +		nvidia,event-cntr-data =3D <0x1c8>;
> +	};
> +
> +	pcie@141a0000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
> +		reg =3D <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x3a000000 0x0 0x02000000   /* window1 (32M)              =
*/
> +		       0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       =
*/
> +		       0x1c 0x00000000 0x4 0x00000000>; /* window2 (16G)              =
*/
> +		reg-names =3D "appl", "window1", "config", "atu_dma", "dbi", "window2";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <8>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <5>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX1_CORE_5>,
> +			<&bpmp TEGRA194_CLK_PEX1_CORE_5M>;
> +		clock-names =3D "core_clk", "core_clk_m";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
> +		reset-names =3D "core_apb_rst", "core_rst";
> +
> +		interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		nvidia,bpmp =3D <&bpmp>;
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic 0 53 0x04>;
> +
> +		nvidia,max-speed =3D <4>;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <&bpmp 0x5>;
> +		nvidia,aspm-cmrt =3D <0x3C>;
> +		nvidia,aspm-pwr-on-t =3D <0x14>;
> +		nvidia,aspm-l0s-entrance-latency =3D <0x3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x3a100000 0x0 0x3a100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000  /* prefe=
tchable memory (13GB) */
> +			  0x82000000 0x0 0x40000000 0x1f 0x40000000 0x0 0xC0000000>; /* non-p=
refetchable memory (3GB) */
> +
> +		nvidia,event-cntr-ctrl =3D <0x1d8>;
> +		nvidia,event-cntr-data =3D <0x1dc>;
> +	};
>  };
> --=20
> 2.7.4
>=20

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyc/VUACgkQ3SOs138+
s6FURhAAnKhYYvl0f9gh2hwcLJ22PJHM9uTz755mG4PlieyHiEDZSZizzbgFXbWK
GNzsjdb0x563PSFMX9ocYFRwRI6RdW+MmOj8asICbILm0kzMydVhd6N6b+cxDUp4
ytUoLPA3aC4mmGPhuVwMC4X0QSU2byQZfEEaXqLmkJXRKnBd1+pG//zXwLUTVs2c
Q7ERh8kJxhqzl+WruhhmAoeJJC6uyZd3RUTzpYNyJnrY1NyJUzI/wsAW0uO/QvHo
slovxemeSRAejWBqz9uh2evUIetdPHlbZbUNssiyJ0PchpZQNHR+Dah9Th89YBIt
2Vn+T/YTRsc1RnPJ1YeSkyrIQi2AB0YNpPiwxphjqIEWJuabjvTP1BdZs5UgCto/
IO9o1nOzluVJnCGeMIhg49DzUpdTAE2TNdrsh71koSoW8AZl7/2EmUZlziUyaKOE
EwTjXVZkbyZdx30LWYSX8hzNfo3yNwgkCLFT2tqXPCQhHseJA25uu8hXkJ0fEO+D
TqED2B56eSQW9+QCe+LidbE8J3FHi1QbLqcPF3nLVPZ9ZQJYf9Etto8HE00YYkXq
C70oUWveCfcciJ/qAC+klsuEtXIDq6oECbd0gBaSEo/qVTSItPDWh9YDb756zKCS
zrcCybbG9SAP0WjXxDeOtgRMKrAC2AM/iOO3IAXDOAWXK+14rns=
=KxnT
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
