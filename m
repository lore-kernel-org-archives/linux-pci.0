Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0754C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BE7217D6
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOgsveZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDOPP6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:15:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50273 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfDOPP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:15:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so21261113wmi.0;
        Mon, 15 Apr 2019 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kFVQxx0RMsA+rPIDzRYeK/aDWr4o2uY9oVxAfBImF1I=;
        b=LOgsveZtAQoN/4HPSg5Xmj7aQLJFedu5l69wd/Ljj3MmfIGnuNJuqezKH1uQZDttmL
         rvYp9zxOqhifKs3kL2E0cG5YWytjiPGCiVk8dYcGRxNN1ikD63pVQN2tyUodApCmZj4M
         W5IbMFp1bN+MjhpnmT8eqdpK9W6ZpednvDGSXEvJy8NbrzFvjTFnZWvFHLsYeXvj9aun
         qSyAfP+bmrPZOiQw8VopcTzjGbk25ZRtGjPY/3t/sgaHZB/k95q1ikxH98kBu/cin6D3
         HjpmF6dVhuhxbGIRvoDpZNpk7QE5vLOvxXD/WyKEg6RMQqvWkDVD7DDGnmnu2oMtVBwS
         iBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kFVQxx0RMsA+rPIDzRYeK/aDWr4o2uY9oVxAfBImF1I=;
        b=CxXGvxtidFFPpFVf7ZRcpG13zFtFeuXpUvMP2I0muHNCmum+ZFZNpn2r8UQp6F45vN
         bsDytMa09OLAy/TmGaxZHJNdQ2zOPOSYo5QZNFqqdCOvxUNRhrXirFOdcPGA5Zw1bGXo
         9V+Cp0MM2Xqwi8cIWJ284iD4hN5uaOJyqZG4wVy6r53RhczT6cVg5cNqCAxyGAlVibyc
         4MKNPCMJFhepaNkpxHjNxo99KFIEOL/FInMlNpOicnjN+Q/hIKfT8sMNYOPcFUx/q8mz
         y6Y1+7R7BhSBExgC0CQkaKkciv090ygH8dmECqu1qzZOfxTYCJIkgi465axw09C2Xl5h
         E+TQ==
X-Gm-Message-State: APjAAAWttYnSf1ly1kpft1kqU8hWyFa26+ilz+H0kJrPObNIxuDYUaTz
        7Z1PCjwNUiA4T7VY/OQ5cpU=
X-Google-Smtp-Source: APXvYqx07h0y+IVbWgXk5OfeMdI5SGYwQHcTpU3/XBQR5K10Vwq2PafIAvkecV5258cjzPlFnmt0bg==
X-Received: by 2002:a1c:f308:: with SMTP id q8mr33039wmq.1.1555341354366;
        Mon, 15 Apr 2019 08:15:54 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id e1sm83067788wrw.66.2019.04.15.08.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:15:53 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:15:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 12/16] arm64: tegra: Add P2U and PCIe controller nodes
 to Tegra194 DT
Message-ID: <20190415151552.GI29254@ulmo>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-13-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="McTFpSeH7KqpdXA3"
Content-Disposition: inline
In-Reply-To: <1554407683-31580-13-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--McTFpSeH7KqpdXA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 01:24:39AM +0530, Vidya Sagar wrote:
> Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
> The Tegra194 SoC contains six PCIe controllers and twenty P2U instances
> grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P2Us)
> and NVIDIA High Speed (NVHS-8 P2Us) respectively.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v1]:
> * Flattened all P2U nodes by removing 'hsio-p2u' and 'nvhs-p2u' super nod=
es
> * Changed P2U nodes compatible string from 'nvidia,tegra194-phy-p2u' to '=
nvidia,tegra194-p2u'
> * Changed reg-name from 'base' to 'ctl'
> * Updated all PCIe nodes according to the changes made to DT documentatio=
n file
>=20
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 449 +++++++++++++++++++++++++=
++++++
>  1 file changed, 449 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index c77ca211fa8f..5b62136d97a5 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -884,6 +884,166 @@
>  				nvidia,interface =3D <3>;
>  			};
>  		};
> +
> +		p2u_0: p2u@03e10000 {			/* HSIO-Lane-0 */
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e10000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
[...]
> +		p2u_12: p2u@03eb0000 {			/* NVHS-Lane-0 */
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03eb0000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
[...]

Do we perhaps want to include the type of P2U in the label? That would
make it more obvious which ones to list in the PCIe controller nodes'
phys properties. Something like:

		p2u_hsio_0: p2u@3e10000 {
			...
		};

		...

		p2u_nvhs_0: p2u@3eb0000 {
			...
		};

? Also, make sure to drop the leading 0 from unit-addresses. Recent
versions of DTC have checks for that in place and will warn about it in
recent Linux builds.

[...]
> @@ -1054,4 +1214,293 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent =3D <&gic>;
>  	};
> +
> +	pcie@14180000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
> +		reg =3D <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x38040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
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
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> +		reset-names =3D "core_apb", "core";
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
> +		supports-clkreq;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <0>;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;

Didn't you remove some of these from the bindings?

Thierry

> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000  /* prefe=
tchable memory (13GB) */
> +			  0x82000000 0x0 0x40000000 0x1B 0x40000000 0x0 0xC0000000>; /* non-p=
refetchable memory (3GB) */
> +	};
> +
> +	pcie@14100000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> +		reg =3D <0x00 0x14100000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x30000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x30040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x30080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
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
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_1_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_1>;
> +		reset-names =3D "core_apb", "core";
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
> +		supports-clkreq;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <1>;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000  /* prefe=
tchable memory (768MB) */
> +			  0x82000000 0x0 0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-p=
refetchable memory (256MB) */
> +	};
> +
> +	pcie@14120000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> +		reg =3D <0x00 0x14120000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x32000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x32040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x32080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
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
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_2_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_2>;
> +		reset-names =3D "core_apb", "core";
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
> +		supports-clkreq;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <2>;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x32100000 0x0 0x32100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000  /* prefe=
tchable memory (768MB) */
> +			  0x82000000 0x0 0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-p=
refetchable memory (256MB) */
> +	};
> +
> +	pcie@14140000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> +		reg =3D <0x00 0x14140000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x34000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x34040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x34080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
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
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_3_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_3>;
> +		reset-names =3D "core_apb", "core";
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
> +		supports-clkreq;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <3>;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x34100000 0x0 0x34100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000  /* prefe=
tchable memory (768MB) */
> +			  0x82000000 0x0 0x40000000 0x12 0xB0000000 0x0 0x10000000>; /* non-p=
refetchable memory (256MB) */
> +	};
> +
> +	pcie@14160000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
> +		reg =3D <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x36000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x36040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
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
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_4_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_4>;
> +		reset-names =3D "core_apb", "core";
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
> +		supports-clkreq;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <4>;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x36100000 0x0 0x36100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000  /* prefe=
tchable memory (13GB) */
> +			  0x82000000 0x0 0x40000000 0x17 0x40000000 0x0 0xC0000000>; /* non-p=
refetchable memory (3GB) */
> +	};
> +
> +	pcie@141a0000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
> +		reg =3D <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x3a080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
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
> +		clock-names =3D "core", "core_m";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
> +		reset-names =3D "core_apb", "core";
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
> +		supports-clkreq;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <5>;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x3a100000 0x0 0x3a100000 0x0 0x00100000   =
 /* downstream I/O (1MB) */
> +			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000  /* prefe=
tchable memory (13GB) */
> +			  0x82000000 0x0 0x40000000 0x1f 0x40000000 0x0 0xC0000000>; /* non-p=
refetchable memory (3GB) */
> +	};
>  };
> --=20
> 2.7.4
>=20

--McTFpSeH7KqpdXA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0oCgACgkQ3SOs138+
s6FNtA/7B3EsMLrbJS6e3JxzTdh7l3B+keT7uHuQjqEaK0zRSYfAWMuNabf4cRpS
XSe2oVzbE2NRkjL+re6BHVVrWU2usS6BflBwL8pqzDiFfN67BKp77qvNYN73b/IH
eZmIySIquh14nPRx3ThiPRks6MWcsHLR0cLNutLRzftBFbbXFuHsyluYQMeWo+Ib
VU3dJD3Ag4pPL2EprzZnuATQcRGZOfBIM5OsW57GHCTIuH6Raao5ikH5vKdwWV0a
GHwbg93lnh/TtoCwaFm+1R5XM67jAXX5FdvKdNiKpxsBGnqtWsLNRaj7gOV4GcoS
ZzlFUw44E1KCVviE3AfzaalkVNljzpK9sNM1ggvCYH+t0pvBQnFxD5C9ZVr+X8r/
EUWHEV9kT6nJFwbokLxvHQPXRXLf8nvkk7m/OTEsn4tb5NJfD/b6buyUIOyCizLi
sfiAMjQSNENCBZyTuJ52r6g6L0Zxvhxw38E7AXPXMqSKDwj7DI2Fvcz6iAyMoiKA
fxy7jiloq7LmXd8qLvhv/YD6gDG8bqHXgDNA9gNAzl4APwUXaRyBKhId8kGl+acT
H6RSS7bKeaC8jKf8CrCn6QVufy7W7NHsC1TnEs/tLoLS1BGmHXCoz9biD8PTzQJV
t0oNda+3NtBbtC95OuMfXqCismMP0OmvWgC98TAWA+u9hnkzp88=
=uQ8E
-----END PGP SIGNATURE-----

--McTFpSeH7KqpdXA3--
