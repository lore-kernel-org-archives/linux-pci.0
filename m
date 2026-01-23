Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4C3EBF1B
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194212; cv=none; b=KR3DIf4YEV/CgtZvbNk72q49C8Hfibj0QF6o1FPlltofdt36GeGXMsjMzbK3INOACoki+6HS0v9qCUm64SDsGjy6XWUb1Dty8qdc8tjZtAOusAQ3ZHCrDpRJaINrh3KIOirMxW7dS3QizL8VXE47fxWkQYq4EBBMXwdKzqS/GZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194212; c=relaxed/simple;
	bh=arkRVdkMT/sTGrBLSm06RobOMfJBAkghSVoqh5qK0jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAlaEgxxUV01jJKXJ7UWQtJn9AMIbrJlnl6FvW6xdqOd+Cb5HDN2VWVmxE+YeDJMOM7Mr4RVjchOvgq6++Q4s9svwrWXVc1V3GcElUpeC0VLMBUY0AOSZUWIVVThv7wXtTm+8tZyTW+iY0jp4gYjUTNJ24y1EdfmGqOvIX+0Hv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3fBHNSi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3fBHNSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF12C19423;
	Fri, 23 Jan 2026 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194211;
	bh=arkRVdkMT/sTGrBLSm06RobOMfJBAkghSVoqh5qK0jU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q3fBHNSilt3lijVnyizW/Fv2Xh3ngrypItu4jIp7NmZwgEACHSira74rNtoEZj7nT
	 EnU8DWrF+oMKGSYfVfi6LExUED1IL2ddmP1bTW/Ww7doQTOp9AWUEQPusIPaWTwWdX
	 sKQ5pUC1YM5kyxVQwSW6Rah2LaEZU1v/5uYL8Z235K/57Gi9aDTtszAcgVG8pgwbRQ
	 J2knobZmHdD2kx+0lTwlZhFI1cqyBB1j5oaZGFpftZ+bGVg0+3n60bXbgauebABXfE
	 mby+E9ZwuP90IJqpmnuQ0yn7XT1ZCLbL38WQxk2NYut1jR3bRa7aRI5K81MRTE2INH
	 tfsIVnvg6WlqQ==
Message-ID: <45ed56fb-15b2-455a-bdac-a208ee93a7da@kernel.org>
Date: Sat, 24 Jan 2026 05:50:06 +1100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] PCI: dwc: Improve msg_atu_index error handling
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <Frank.Li@nxp.com>
Cc: Randolph Lin <randolph@andestech.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Shawn Lin
 <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
References: <20260123182835.831710-6-cassel@kernel.org>
 <20260123182835.831710-8-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260123182835.831710-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/01/24 5:28, Niklas Cassel wrote:
> Only try to dedicate an outbound iATU to MSG TLP if use_atu_msg is set.
> If use_atu_msg is not set, it is completely useless to bump the index.
> 
> Additionally, if use_atu_msg is set, and there is no outbound iATU
> available, return an error.
> 
> Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ae5f2d8a3857..d7f57d77bdf5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,7 +982,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>  
> -	pp->msg_atu_index = ++i;
> +	if (pp->use_atu_msg) {
> +		if (pci->num_ob_windows > ++i) {

	if (pp->use_atu_msg) {
		i++;
		if (pci->num_ob_windows > i) {

is far more readable in my opinion.

> +			pp->msg_atu_index = i;
> +		} else {
> +			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
> +			return -ENOMEM;
> +		}
> +	}

Seeing this, I do not really see the point of the previous patch since you
completely nuke that change here. So maybe drop patch 1 ?

>  
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {


-- 
Damien Le Moal
Western Digital Research
