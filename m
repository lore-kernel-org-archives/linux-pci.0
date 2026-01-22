Received: from mail-m21470.qiye.163.com (mail-m21470.qiye.163.com [117.135.214.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848736C5B9;
	Thu, 22 Jan 2026 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071551; cv=none; b=Ki9f/A/B+9Wtx4VY5+o/W+/mjU8MEKyah81+gIcNF258UI7VlbIpoFrhp2XPbFU/h4JzXMX/Yowm59fL5oPKP/SSvpZiI8Ayo+RGMdo5w3+m73HHr8BmrbU/U/k4vh0Rpm2fpMvFKMA46J+LPxKB3GTcmgSrDMDZDfA+BAwRLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071551; c=relaxed/simple;
	bh=S3XisMEVcTeOIDl4Xi1lEY/z+IjUOLE+KYeUDAeaZQo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dj936e6ulnxzTuO2HLHxIHQ3bHITlUihQeYC/pCF4y2571dizwmBEQ+1g6ZIoGo2PpbQGJBsP2/f+yjV+5PLx9WIaEsJZzfxFGGgsCGhsrh1+XQIixFAPhvSs3pYpIZXCKCJuTG+e/t5bmHrYWEj2Y7xsX7axOwFHlq2ZKqjWCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kuGUStVS; arc=none smtp.client-ip=117.135.214.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kuGUStVS"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 319273eed;
	Thu, 22 Jan 2026 16:10:10 +0800 (GMT+08:00)
Message-ID: <1363546a-328b-4242-b1e9-9daa009d2b3c@rock-chips.com>
Date: Thu, 22 Jan 2026 16:10:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Fix grammar and formatting in
 dw_pcie_remove_ext_capability()
To: Qiang Yu <qiang.yu@oss.qualcomm.com>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20260121-remove_cap_clean_up-v1-0-e78115e5d467@oss.qualcomm.com>
 <20260121-remove_cap_clean_up-v1-1-e78115e5d467@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260121-remove_cap_clean_up-v1-1-e78115e5d467@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be4c0f86709cckunma8e39ccbbe176
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05JTFZPSR0YQhgeQkwZTx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kuGUStVS4kWlzYMJsyTN94LKDE8YUCKWjSFWDgovt4DDM8fFpcHwq2plU+Fs8/cm3Qs1hDLRjFf8a2VOv93ZtDmQt76SdzhkhHAwkJVQwb4HnA0sDsd41ssHwTMJq01ilqAzaxOiJ9X55eAEItvfrO8LIJCmVVEgT0ZrnuG/BZc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=M5uF0f2HBPfZP6sk1nmrpXb8b5/6ayTGG3XI76sO23k=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/22 星期四 15:45, Qiang Yu 写道:
> Fix a grammatical error in the comment by changing "it's" to "its". Also
> add a blank line after the variable declaration for better code
> formatting.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 2fa9f6ee149ed76ee84e8129a47f4bde2fa4d513..18331d9e85be30462277532afa71b5850438f32e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -268,9 +268,10 @@ void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap)
>   		return;
>   
>   	header = dw_pcie_readl_dbi(pci, cap_pos);
> +
>   	/*
>   	 * If the first cap at offset PCI_CFG_SPACE_SIZE is removed,
> -	 * only set it's capid to zero as it cannot be skipped.
> +	 * only set its capid to zero as it cannot be skipped.
>   	 */
>   	if (cap_pos == PCI_CFG_SPACE_SIZE) {
>   		dw_pcie_dbi_ro_wr_en(pci);
> 

