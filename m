Received: from mail-m1973189.qiye.163.com (mail-m1973189.qiye.163.com [220.197.31.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8623EAB4;
	Fri, 13 Mar 2026 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369971; cv=none; b=kKkTX4uXHMAvQcDJeR3qnYSHNG3oux+O54wNPmSyN7ovGkMlKzz8gziFMRlT8cC9IEblk3OQl4wArOSVtMotTg7MwUlro4+8PNLyBjob4JsPprKHVZKBn/QdVauDFA2EXl88lYgNbYDhdXF20mnZwNoy8fLUIRSMlAVU3VTLee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369971; c=relaxed/simple;
	bh=fswSJKNrf4EoT/tF0WAuknxmOAME5KLLvIeNgbDli0M=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=udDVGyyB5kStDZiXtAVC6Oqm1K6CZvXQ43qyz+jqFv0K6cfm2OFNa0JWcEGsFqfrshxuKu0MBjz64j52P2c2CuRIBoBt5lhp4oG8e8wSSGZ2MFp8QetcBzut0ygUeOxrMyvy26knciI8mABkUloFNoEIPyAXrk5kk8t4ZTzDXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=M8Wjyn0Y; arc=none smtp.client-ip=220.197.31.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="M8Wjyn0Y"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36c8f51b3;
	Fri, 13 Mar 2026 10:45:58 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 2/3] PCI: dwc: Add helper to Program T_POWER_ON
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>
References: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
 <20260311-t_power_on_fux-v3-2-9b1f1d09c6f3@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <ce2381fd-7c5c-be49-753a-bfc86346a0a9@rock-chips.com>
Date: Fri, 13 Mar 2026 10:45:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260311-t_power_on_fux-v3-2-9b1f1d09c6f3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ce516219809cckunm8c60b179698cf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhCH1ZLTh1PSUxDSxkYSB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=M8Wjyn0Y8Ij7HefnvbzLlU8ZMn0Fa9L1S7FHzNq0/jQBDf4FEB4ZPN9FQRbnXNiU+hEN1L3Ne/baQWXl0P6TLkaZEf5Sls7eGwh3ZiGuegl10SDXIQqACMkD2O8C4BtUPAQETG8l5O1WPziNqQmaPwH3zINR8k12u6N0Xty1UmU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=9LeyQWEFO3EX3gB1qmDkWaeYNHuXwpLGCY0ywMDqlMo=;
	h=date:mime-version:subject:message-id:from;

在 2026/03/11 星期三 20:40, Krishna Chaitanya Chundru 写道:
> The T_POWER_ON indicates the time (in μs) that a Port requires the port
> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
> asserted before actively driving the interface. This value is used by
> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
> 
> Currently, some controllers exposes T_POWER_ON value of zero in the L1SS
> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations,
> which can result in improper L1.2 exit behavior and if AER happens to be
> supported and enabled, the error may be *reported* via AER.
> 
> Add a helper to override T_POWER_ON value by the DWC controller drivers.
> 

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 28 ++++++++++++++++++++++++++++
>   drivers/pci/controller/dwc/pcie-designware.h |  1 +
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 5741c09dde7f40487c6da6dfd66f7c8d96a74259..6289329ef2b2a4ac9264d1c6cb5ea4e88c261634 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1249,6 +1249,34 @@ void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci)
>   	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
>   }
>   
> +/* TODO: Need to handle multi root ports */
> +void dw_pcie_program_t_power_on(struct dw_pcie *pci, u16 t_power_on)
> +{
> +	u8 scale, value;
> +	u16 offset;
> +	u32 val;
> +
> +	if (!t_power_on)
> +		return;
> +
> +	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (!offset)
> +		return;
> +
> +	pcie_encode_t_power_on(t_power_on, &scale, &value);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
> +	val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
> +	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_SCALE, &val, scale);
> +	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val, value);
> +
> +	writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>   void dw_pcie_setup(struct dw_pcie *pci)
>   {
>   	u32 val;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ae6389dd9caa5c27690f998d58729130ea863984..da67beece3f11e33d9a1937fa23d443feea3bbc7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -602,6 +602,7 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>   				u8 bar, size_t size);
>   void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
>   void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci);
> +void dw_pcie_program_t_power_on(struct dw_pcie *pci, u16 t_power_on);
>   void dw_pcie_setup(struct dw_pcie *pci);
>   void dw_pcie_iatu_detect(struct dw_pcie *pci);
>   int dw_pcie_edma_detect(struct dw_pcie *pci);
> 
