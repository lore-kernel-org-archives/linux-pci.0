Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14E1E1A33;
	Thu,  5 Mar 2026 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692299; cv=none; b=KkitRqiTGOW3DFQDYvNHQ1MHhdte1xODR0cn6aBGVtTp/2X6t8tUi8h2DifzvHAHbRB0dA9D4qLWbYhkXY4XAPuWDCNdPsKAuaD45WsgWAYZCI8OWRitcP+Dwu+BrnxQGwTCdXTRckP4ptPHsynvRiGv01hXUys0r37QYgTJOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692299; c=relaxed/simple;
	bh=vYqKAjigSGK+e2mJl4KSQ7Ay4nPe/Fhoh8VuBDSDuPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYanMPvMxvJsB130vsCcubS6tWLxi/ZAtSCl5xIBoQd2h/He+T97w4CbHKHO4fpIXTz3Ba1fo78bUbdIDlO/tsE/Bbd8JvSrSBcPU0vozf5V2RYhodjgPzt8/AQCJRKAKtvf6WflJuSikTS78w5Dpj5KqDdLbda4L9nY550oTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiL/1lGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiL/1lGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2AEC116C6;
	Thu,  5 Mar 2026 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772692299;
	bh=vYqKAjigSGK+e2mJl4KSQ7Ay4nPe/Fhoh8VuBDSDuPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iiL/1lGU9jqMT97ePehSNPRel+pHwzNy8Sc211RvK7J4OxNjf8ET3jCFjdTbLqUWK
	 uPlDf4XuWj0ZPK8jTSmKEAArWxC5yDFB6tNypcTjtflbYxTtaBPgK/6jPMQmV58ulB
	 zQC0s9sMf2vjaMJch9hFxWKmtUs7QwgdSOC37VAKlpEcqLO+EySgoco/taryGwruTe
	 KJfMxQPazaMns29WtfW/dZRYHB2iKn3PidkF/IRuWb+htj53x/SOLTow+gLXLB624n
	 +B8DMER6GZB52uLa+7oQOxSFe/h16LXi94UPWjC+M/3sMaQybd2ukllEf86GCtOLP5
	 V+aJEbSEDOPag==
Date: Thu, 5 Mar 2026 12:01:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Randolph <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, ben717@andestech.com, 
	inochiama@gmail.com, thippeswamy.havalige@amd.com, namcao@linutronix.de, 
	shradha.t@samsung.com, pjw@kernel.org, christian.bruel@foss.st.com, 
	Ghennadi.Procopciuc@nxp.com, quic_wenbyao@quicinc.com, qiang.yu@oss.qualcomm.com, 
	vincent.guittot@linaro.org, vidyas@nvidia.com, elder@riscstar.com, s-vadapalli@ti.com, 
	ciprianmarian.costea@nxp.com, randolph.sklin@gmail.com, tim609@andestech.com
Subject: Re: [PATCH v11 2/4] riscv: dts: qilai: Add PCIe node into the QiLai
 SoC
Message-ID: <rkrado7sb3vevzacprcyphk3amvvognvgqbt74ti6nvk65iqzm@kthkqssjonx6>
References: <20260225085504.3757601-1-randolph@andestech.com>
 <20260225085504.3757601-3-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225085504.3757601-3-randolph@andestech.com>

On Wed, Feb 25, 2026 at 04:55:02PM +0800, Randolph wrote:
> From: Randolph Lin <randolph@andestech.com>
> 
> Add the Andes QiLai PCIe node, which includes 3 Root Complexes.
> 
> Signed-off-by: Randolph Lin <randolph@andestech.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

One nit below.

> ---
>  arch/riscv/boot/dts/andes/qilai.dtsi | 109 +++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/andes/qilai.dtsi b/arch/riscv/boot/dts/andes/qilai.dtsi
> index de3de32f8c39..731ba12ccc95 100644
> --- a/arch/riscv/boot/dts/andes/qilai.dtsi
> +++ b/arch/riscv/boot/dts/andes/qilai.dtsi
> @@ -123,6 +123,7 @@ cpu3_intc: interrupt-controller {
>  	soc {
>  		compatible = "simple-bus";
>  		ranges;
> +		dma-ranges;
>  		interrupt-parent = <&plic>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -182,5 +183,113 @@ uart0: serial@30300000 {
>  			reg-io-width = <4>;
>  			no-loopback-test;
>  		};
> +
> +		bus@80000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
> +			ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x20000000>,
> +				 <0x00 0x04000000 0x00 0x04000000 0x00 0x00001000>,
> +				 <0x00 0x00000000 0x20 0x00000000 0x20 0x00000000>;
> +
> +			pcie@80000000 {
> +				compatible = "andestech,qilai-pcie";
> +				device_type = "pci";
> +				reg = <0x00 0x80000000 0x00 0x20000000>, /* DBI registers */
> +				      <0x00 0x04000000 0x00 0x00001000>, /* APB registers */
> +				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */

No need to add comments about the register name space. You have reg-names below.

- Mani

> +				reg-names = "dbi", "apb", "config";
> +				dma-coherent;
> +
> +				linux,pci-domain = <0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x00 0xf0000000>,
> +					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x02 0x00000000>;
> +
> +				#interrupt-cells = <1>;
> +				interrupts = <0xf 0x4>;
> +				interrupt-names = "msi";
> +				interrupt-parent = <&plic>;
> +				interrupt-map-mask = <0 0 0 0>;
> +				interrupt-map = <0 0 0 1 &plic 0xf 0x4>,
> +						<0 0 0 2 &plic 0xf 0x4>,
> +						<0 0 0 3 &plic 0xf 0x4>,
> +						<0 0 0 4 &plic 0xf 0x4>;
> +			};
> +		};
> +
> +		bus@a0000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
> +			ranges = <0x00 0xa0000000 0x00 0xa0000000 0x00 0x20000000>,
> +				 <0x00 0x04001000 0x00 0x04001000 0x00 0x00001000>,
> +				 <0x00 0x00000000 0x10 0x00000000 0x08 0x00000000>;
> +
> +			pcie@a0000000 {
> +				compatible = "andestech,qilai-pcie";
> +				device_type = "pci";
> +				reg = <0x00 0xa0000000 0x00 0x20000000>, /* DBI registers */
> +				      <0x00 0x04001000 0x00 0x00001000>, /* APB registers */
> +				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
> +				reg-names = "dbi", "apb", "config";
> +				dma-coherent;
> +
> +				linux,pci-domain = <1>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x00 0xf0000000>,
> +					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x02 0x00000000>;
> +
> +				#interrupt-cells = <1>;
> +				interrupts = <0xe 0x4>;
> +				interrupt-names = "msi";
> +				interrupt-parent = <&plic>;
> +				interrupt-map-mask = <0 0 0 0>;
> +				interrupt-map = <0 0 0 1 &plic 0xe 0x4>,
> +						<0 0 0 2 &plic 0xe 0x4>,
> +						<0 0 0 3 &plic 0xe 0x4>,
> +						<0 0 0 4 &plic 0xe 0x4>;
> +			};
> +		};
> +
> +		bus@c0000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
> +			ranges = <0x00 0xc0000000 0x00 0xc0000000 0x00 0x20000000>,
> +				 <0x00 0x04002000 0x00 0x04002000 0x00 0x00001000>,
> +				 <0x00 0x00000000 0x18 0x00000000 0x08 0x00000000>;
> +
> +			pcie@c0000000 {
> +				compatible = "andestech,qilai-pcie";
> +				device_type = "pci";
> +				reg = <0x00 0xc0000000 0x00 0x20000000>, /* DBI registers */
> +				      <0x00 0x04002000 0x00 0x00001000>, /* APB registers */
> +				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
> +				reg-names = "dbi", "apb", "config";
> +				dma-coherent;
> +
> +				linux,pci-domain = <2>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x00 0xf0000000>,
> +					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x02 0x00000000>;
> +
> +				#interrupt-cells = <1>;
> +				interrupts = <0xd 0x4>;
> +				interrupt-names = "msi";
> +				interrupt-parent = <&plic>;
> +				interrupt-map-mask = <0 0 0 0>;
> +				interrupt-map = <0 0 0 1 &plic 0xd 0x4>,
> +						<0 0 0 2 &plic 0xd 0x4>,
> +						<0 0 0 3 &plic 0xd 0x4>,
> +						<0 0 0 4 &plic 0xd 0x4>;
> +			};
> +		};
>  	};
>  };
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
