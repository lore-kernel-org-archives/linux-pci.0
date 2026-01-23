Received: from mail-m21473.qiye.163.com (mail-m21473.qiye.163.com [117.135.214.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A5378D81
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134093; cv=none; b=Ukaba7geiGeJ3Z/cRltGHCAc4jtyJ92E1EI7Fna95/9pmtTOG+0gxsLQ3wdlGqOJgBNWONEhAPihkknc2+ue+Avv+M5pny4e8ALiJeaE+haLZPQWLeyOy14NnrChkzKZKXGTwfPWEBeCpMkKd/G7TOapJVx014FJHx3vDAyCGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134093; c=relaxed/simple;
	bh=3wuprJFs/xhuaXj6G5FZKM4wf1LcPDYOmdNPHAzFKv8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IIqRePpmAVZs8wlKMTppRn4fZMtAWSxGNq0EYwQ1+yHReHbFqFpFRmQa0M/MmfqbfXDkqtaTa1w3DY95zbr2kHyjjgEPVxfhp7W6lt9T9piLjZ4pcxH4YZ3f74LCwfLITpMENvIRBtC3+GR3qxufLUmyZLFApdlechySd4EJaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Es8GVuPO; arc=none smtp.client-ip=117.135.214.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Es8GVuPO"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31aadece0;
	Fri, 23 Jan 2026 10:07:31 +0800 (GMT+08:00)
Message-ID: <1fc62af3-4b97-46b0-9ace-bcf2d5e6fc7f@rock-chips.com>
Date: Fri, 23 Jan 2026 10:07:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Randolph Lin <randolph@andestech.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI: dwc: Improve msg_atu_index error handling
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <Frank.Li@nxp.com>
References: <20260122222914.523238-6-cassel@kernel.org>
 <20260122222914.523238-8-cassel@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260122222914.523238-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be89b50b009cckunm6542607c13e266
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4fGVZMGU5KH04fTB8ZGUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Es8GVuPOlnesGIT0HkTKhp0gL9T+NSTAPWKi+2+eMF487U1cj0YGU1QT++I5OqBPhzCTbR7gSxHpH/HqQTdA+UpHVsHDU8bADpu7ksi898HxhyRjq0Zhp/5Hh+hdvROE1pd1Td3vHluROsQsTd6Yjib7qVo9DXC8tKXfWd7ZMB8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=1iRpOvj+NANMEmY5kCXkOvcCTD+YepOLETW3JiozAKE=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/23 星期五 6:29, Niklas Cassel 写道:
> Only try to dedicate an outbound iATU to MSG TLP if use_atu_msg is set.
> If use_atu_msg is not set, it is completely useless to bump the index.
> 
> Additionally, if use_atu_msg is set, and there is no available outbound
> iatu available, return an error.
> 

Nit: there is no outbound iATU available....

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cca5fc886409..991fe5b9a7b3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,7 +982,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>   			 pci->num_ob_windows);
>   
> -	pp->msg_atu_index = ++i;
> +	if (pp->use_atu_msg) {
> +		if (pci->num_ob_windows > ++i) {
> +			pp->msg_atu_index = i;
> +		} else {
> +			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
> +			return -ENOMEM;
> +		}
> +	}
>   
>   	i = 0;
>   	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {

