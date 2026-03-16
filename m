Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62161C84DE;
	Mon, 16 Mar 2026 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773636846; cv=none; b=dUpdqHMFAQUoaF3EIuPpPn40stLQ+mTn1ULXPo2NMS1jM5p8r2ounnK6/A7rE/238AozjtFZIJjzt5vGVaK1Cklr3CdnyyYMfqZjOgYU3lqlnrafVh6aJNrp+T1624yjqHQhe3aa1xNGafI2RNae6u4om9gzzole/UitBX4D3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773636846; c=relaxed/simple;
	bh=CmXCQjIOoeBEaHIQ8nhMucM0P+y6BE836pFoje8TgPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl27Ur0JVqLOcNmIfJd/8WJ4tz1lRhXOVqcJrLD1e0icwiMZwPeTY+UZeOAQFd9sl4k3gwG/3EZxyB3lap35QJ0rNOAFTSOotO1oaTOUUrnux7Z6GX1sePeAEzLoXxsTTz+A2JMH5IByYbw65QTOgZSpS2DQy3Nyy4j3Cac9JiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA3bDCCD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA3bDCCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2EBC19425;
	Mon, 16 Mar 2026 04:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773636845;
	bh=CmXCQjIOoeBEaHIQ8nhMucM0P+y6BE836pFoje8TgPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OA3bDCCDz/RQ8piBkuNpfhBXuJ/ZLXfX7MVAfq6kzVVweqSwEF3cn03mPu0mjFbA8
	 SM3UOSR9Ij3n9/QjDbRtZDAxMbnn63LjDrUT48Mn3gq5FSWvRT977A3vaU7KtK1IhK
	 uq77fvr/wImXcBuFL80bfnUtplJiV9teL9oACmjyY65uel4A+oRt9/tq4TC/10F7xd
	 j1awbmd+Z8WxfiknUu0zvZNNvbRP0LIQuKG4TVoDCPqhv5AMsAiLnq3qlbQGd2MBBy
	 5kULgTnW5OO/isrH1OVLky7bIJh4wL+u1ANp08J4UHIuRZ9ylLqlMfzlCHZ+Wl/C8B
	 Ev2TQQPYey2bw==
Date: Mon, 16 Mar 2026 10:23:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com, 
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 3/3] PCI: qcom: Program T_POWER_ON
Message-ID: <wofjlohumsdyyfhndrdwf4ujxiwlrajm2rpobd6gofpqyasttb@ze54bm6pwbgq>
References: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
 <20260311-t_power_on_fux-v3-3-9b1f1d09c6f3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311-t_power_on_fux-v3-3-9b1f1d09c6f3@oss.qualcomm.com>

On Wed, Mar 11, 2026 at 06:10:40PM +0530, Krishna Chaitanya Chundru wrote:
> Some platforms have incorrect T_POWER_ON value programmed in hardware.
> Generally these will be corrected by bootloaders, but not all targets
> support bootloaders to program correct values due to that
> LTR_L1.2_THRESHOLD value calculated by aspm driver can be wrong, which
> can result in improper L1.2 exit behavior and if AER happens to be
> supported and enabled, the error may be *reported* via AER.
> 
> Parse "t-power-on-us" property from each root port node and program them
> as part of host initialization using dw_pcie_program_t_power_on() before
> link training.
> 
> This property in added to the dtschema here[1].
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Link[1]: https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 67a16af69ddc75fca1b123e70715e692a91a9135..63d5628e988d3c07f42099c0d86e6b80fd54ce32 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -269,6 +269,7 @@ struct qcom_pcie_perst {
>  struct qcom_pcie_port {
>  	struct list_head list;
>  	struct phy *phy;
> +	u32 l1ss_t_power_on;
>  	struct list_head perst;
>  };
>  
> @@ -1283,6 +1284,14 @@ static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_port *port;
> +
> +	list_for_each_entry(port, &pcie->ports, list)
> +		dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
> +}
> +
>  static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1317,6 +1326,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
>  	dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
>  
> +	qcom_pcie_configure_ports(pcie);
> +
>  	qcom_pcie_perst_deassert(pcie);
>  
>  	if (pcie->cfg->ops->config_sid) {
> @@ -1759,6 +1770,8 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
>  	if (ret)
>  		return ret;
>  
> +	of_property_read_u32(node, "t-power-on-us", &port->l1ss_t_power_on);
> +

Since this is going to be common for all controller drivers, it'd be good to
move this inside the dwc API.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
