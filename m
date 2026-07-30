Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF982D9EE4;
	Thu, 30 Jul 2026 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785398085; cv=none; b=GmonFoGvTx1iEj33T1kMGSkswewYgeQHGQj0phnuReIwTYFIKcKcO8SvLTFM0k9fnXmj+ZDaJOR/co4cUmQt2T+yz4YJqtOdYJZGciKU/c1e7sHLEtCIt/7cfWbn+JA3dwkkkP9JqKSI+v3CkydFuLEDCZTsIPbgjzKa0+CwUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785398085; c=relaxed/simple;
	bh=bTLinolm4YrwrOSK9751rOPi9OqlsDci6fE67Xx6aBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxSDWLexs0RiD4SAf67r40XYImWGXlZdsUp/EXZFJ6TGHv4/ZPE7OiGWMK1iVQ1T/ok1vIEqZMN0HU50//+v9Uxl9D7Ol4vp3uM0ZA9NfMcWFjvosm59ut0k50/ZKnwWsFzdQ7H0i9eQDdy//lbwhDkw5uJ3iPbIzUJeCQGV1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw+OhZjT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw+OhZjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271DE1F000E9;
	Thu, 30 Jul 2026 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785398083;
	bh=Dud5JWbWV6et5kasT0nG/bZaWXn/xT5s1MUs4m9NpoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kw+OhZjT5JewR5gS03hooCZBgiNA8OJqTRR5qqkm9v17MFRNlt5Z84NA+SDoLUgGS
	 ZUc3e1/3RL7SZ+t7uWmtVTSJX/TvKTSuBUMceluMVlerAothQQgD7LtCwHDu5uAYFS
	 i3S5X+DSMZ5CSMzJ72enzQvntQpid/sY984eWefmnrU6iboTblL+SdMESq6FfbFYJO
	 9/jrqDBBWoUikWQtsdIjPYVgYkD48A4AQvnEZ95dcaB3OLaPY78/6G+e6J0BhymDjl
	 f405GW1P3guMTbmIibbVzEPW1Y8V4datK+FuBu0rh7wBPqjjDYULPhQxDWUsn9dJdm
	 QB1FWefFq/nBg==
Date: Thu, 30 Jul 2026 09:54:35 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Message-ID: <4tpfvvzb7qu72smfcntt5nj3z3nwqknb7lagpcn2nkamb7a7xl@ud32syigbqf6>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
 <20260730-eliza_evk-v6-1-40ece2d33114@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-eliza_evk-v6-1-40ece2d33114@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 10:18:53AM +0530, Krishna Chaitanya Chundru wrote:
> Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
> (PCIe1). Add PCIe controller and PHY nodes for both instances, and update
> the GCC clock references to use the newly added PHY nodes instead of
> placeholder zeros.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/eliza.dtsi | 413 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 411 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
> index 977de44b816e..01e9d4c91404 100644
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
> +			reg = <0x0 0x01c00000 0x0 0x3000>,
> +			      <0x0 0x40000000 0x0 0xf1d>,
> +			      <0x0 0x40000f20 0x0 0xa8>,
> +			      <0x0 0x40001000 0x0 0x1000>,
> +			      <0x0 0x40100000 0x0 0x100000>,
> +			      <0x0 0x01c03000 0x0 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x3d00000>;
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
> +			iommu-map = <0x0 &apps_smmu 0x1480 0x1>,
> +				    <0x100 &apps_smmu 0x1481 0x1>;

As we learned recently, you need to use 2 cells for SID, since apps_smmu uses
'#iommu-cells = <2>':
			iommu-map = <0x0 &apps_smmu 0x1480 0x0 0x1>,
				    <0x100 &apps_smmu 0x1481 0x0 0x1>;

Same for the other node.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
