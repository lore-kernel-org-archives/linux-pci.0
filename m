Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1406848CD70;
	Wed, 29 Jul 2026 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338375; cv=none; b=VgOjlrLvg9fQEdCLsiWTlp/j9oOQIIsKjMWbjqyzNOez0tU7oECxnKdpXJktg2EtCm6v1MJ2H08sgwZAj1Lxr2JP6yCBZmUm+smjMwocoP/t8tlgONv3VprQrjkdM+j5ShOpSQ1jVktHZPmXYdxoX1x7AjDDen/Zl4rMHs6PnTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338375; c=relaxed/simple;
	bh=GmQZQ2hNwpEiCz0AALObdG81lVEERleXHO2dIRJGj6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQWqOOd8s/U7rqK+SojzwGihUXuXqQB1yszXDn3W6BLelTsEHRnZzoi6gQYRz4tBliBjKTgP66deAiNL0K+8DFr6rWOlYR/5WpveKk8mtOdRoOe8FvVZPJ5VeNAsMsahwQxhrrSClkIKW3g5kn3JxHQfeOZXuJ3bW3Yoo+WfW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMJ1pqZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMJ1pqZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8961F00A3A;
	Wed, 29 Jul 2026 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785338373;
	bh=58z9lcdA1tHcAEkot+Dn0zkP7sOy9zJYB/FYpfsLemw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bMJ1pqZLUSqoOUY0jcHkDPLDBK96gk0BRxGIPLrSGYZnWe4VC7FVpQhpWu+I+jalE
	 4F+lNNq23VVfkal5NFXR8ddzNLbSSFa4ngaruAXPsixQTiODA5wp2OKJULuN+YMGw8
	 pLt0Y0Cw3TeBS0l9JiSjyY1eXABgmz+fHVd0dUkoZHUvNGWkrphsP8FEdb+/B2uJ8/
	 LLtq9vNPRNOhyBnAO9Hz1E01gxNgdHRoKzKw/yJGFsKDQbcjTBD5IZh6ih8zDtnr7p
	 3K8L4WmP3n6yjhGwiN0F3lXCXrIGQ7Gl6m7hsXQbCk2fPqBlS/eskXTxoZtlaRGUlZ
	 Y2dXS4/TDMLFQ==
Date: Wed, 29 Jul 2026 17:19:24 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Message-ID: <iu3bp3wmtrnmxfqndtsjphu6n3dppsx2miy3l3xkw5iqqmisxr@mvgpe3ddqbsk>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
 <20260729-eliza_evk-v5-1-41790a5a24de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729-eliza_evk-v5-1-41790a5a24de@oss.qualcomm.com>

On Wed, Jul 29, 2026 at 08:18:36PM +0530, Krishna Chaitanya Chundru wrote:
> Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
> (PCIe1). Add PCIe controller and PHY nodes for both instances, and update
> the GCC clock references to use the newly added PHY nodes instead of
> placeholder zeros.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Couple of comments below. With those addressed,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> ---
>  arch/arm64/boot/dts/qcom/eliza.dtsi | 413 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 411 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
> index 977de44b816e..a54a956531e5 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
> @@ -640,8 +640,8 @@ gcc: clock-controller@100000 {
>  
>  			clocks = <&bi_tcxo_div2>,
>  				 <&sleep_clk>,
> -				 <0>,
> -				 <0>,
> +				 <&pcie0_phy>,
> +				 <&pcie1_phy>,
>  				 <&ufs_mem_phy 0>,
>  				 <&ufs_mem_phy 1>,
>  				 <&ufs_mem_phy 2>,
> @@ -1786,6 +1786,369 @@ mmss_noc: interconnect@1780000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		pcie0: pcie@1c00000 {
> +			device_type = "pci";
> +			compatible = "qcom,eliza-pcie", "qcom,pcie-sm8550";
> +			reg = <0 0x01c00000 0 0x3000>,
> +			      <0 0x40000000 0 0xf1d>,
> +			      <0 0x40000f20 0 0xa8>,
> +			      <0 0x40001000 0 0x1000>,
> +			      <0 0x40100000 0 0x100000>,
> +			      <0 0x01c03000 0 0x1000>;

0x0

> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0 0x00000000 0 0x40200000 0 0x100000>,
> +				 <0x02000000 0 0x40300000 0 0x40300000 0 0x3d00000>;

0x0

> +
> +			interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 537 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 540 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 653 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7",
> +					  "global";
> +
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
> +				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "noc_aggr",
> +				      "cnoc_sf_axi";
> +
> +			resets = <&gcc GCC_PCIE_0_BCR>,
> +				 <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
> +			reset-names = "pci",
> +				      "link_down";
> +
> +			interconnects = <&pcie_noc MASTER_PCIE_0 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &cnoc_main SLAVE_PCIE_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "pcie-mem",
> +					     "cpu-pcie";
> +
> +			power-domains = <&gcc GCC_PCIE_0_GDSC>;
> +
> +			operating-points-v2 = <&pcie0_opp_table>;
> +
> +			iommu-map = <0 &apps_smmu 0x1480 0x1>,
> +				    <0x100 &apps_smmu 0x1481 0x1>;
> +
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 564 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 0 565 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 566 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 567 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			#interrupt-cells = <1>;
> +
> +			linux,pci-domain = <0>;
> +			num-lanes = <1>;

Drop this property. This value can be extracted from MLW.

> +			bus-range = <0 0xff>;
> +
> +			dma-coherent;
> +
> +			pinctrl-0 = <&pcie0_default_state>;
> +			pinctrl-names = "default";
> +
> +			status = "disabled";
> +
> +			pcie0_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/* 2.5 GT/s x1 */
> +				opp-2500000-1 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +					opp-level = <1>;
> +				};
> +
> +				/* 5 GT/s x1 */
> +				opp-5000000-2 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +					opp-level = <2>;
> +				};
> +
> +				/* 8 GT/s x1 */
> +				opp-8000000-3 {
> +					opp-hz = /bits/ 64 <8000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <984500 1>;
> +					opp-level = <3>;
> +				};
> +
> +			};
> +
> +			pcie0_port0: pcie@0 {

Add compatible.

Same comments to other instance.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
