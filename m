Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D518050;
	Thu,  7 May 2026 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122625; cv=none; b=uHXbbJuhCNHB3srNfXTEb1GdPIZKFO6rm9ivdMbUUvA6eVY6gxmHCUHclibTaVtrdKyrP1nGAl3dv2zhGliEbdHcGMighytPxBSTRzgylgMzjcA3bIxGl9elUiAc5ZOYs0Cxq7DkUc9ZY9eMCnP9BRELljNOYBvWcNNnVGlUjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122625; c=relaxed/simple;
	bh=3DBsfkH7gzYhvM2dIY6FZDcSe2ttFz8i0azMzDepDPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgyLigj25ribcnXL28ad5KML5C0ED65hMx0cpS0aTlYo5UDDp88dZiQgXF0Y2OjRUmJBeGS/9Ez8+pZbtB3gVRYQyamzQb8/CGe/rwDgocYoyg2ReZXpoNzNOp41ALWJsYMa9iH1wKQHQ8+faI/ha7wl8emLOEPZZsWvxVkI+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DUOy+8oh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DUOy+8oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=rcexbzChlIPm5ezwkYYKsN/sTQpx30eqrb2Z67XEnQQ=;
	b=DUOy+8ohKqqvW2jpwsFKZZUC4czjWDI4CVp5StqhEa1h7q3YG+6lNdXd4ns7Qe
	afDrFlzProb4Qf1RNsTc6T1XVTc9Ui2OtupmW15JmT73g4Ur+moa+xR+rYSRQCP4
	kMx5L1Mxkt28VmNasoxt9VSofgCGz8pSdm9IUhN7CaBWY=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3R6Yn__tp9RRWDw--.64792S2;
	Thu, 07 May 2026 10:55:35 +0800 (CST)
Message-ID: <a236aca1-bc31-4ee5-b1b3-59d0a7d70c8b@163.com>
Date: Thu, 7 May 2026 10:55:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: brcmstb: Assign pcie->gen from
 of_pci_get_max_link_speed()
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-pci@vger.kernel.org
Cc: Dom Cobley <popcornmix@gmail.com>, Phil Elwell <phil@raspberrypi.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <mid:20260501202438.376033-1-florian.fainelli@broadcom.com>
 <20260506164537.103196-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260506164537.103196-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3R6Yn__tp9RRWDw--.64792S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1fZr4fXry7KF4xJF1DKFg_yoW8Ar1Dpa
	9rJay8tFyUtFWrua1UG3W5uF1Ygan5urW7KwsxWw17uanIy34rKFy29ryfJF9rKFs7uw13
	X3Way3W7GF1ayF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR573PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AhjB2n7-yhitgAA3R



On 5/7/26 00:45, Florian Fainelli wrote:
> After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
> pcie->gen stopped being assigned and as a result the established PCIe
> link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
> to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
> 
> Whether the 'max-link-speed' property is not specified, or it exceeds
> Gen3, resort to the HW defaults.
> 
> Link: https://github.com/raspberrypi/linux/issues/7343
> Reported-by: Dom Cobley <popcornmix@gmail.com>
> Reported-by: Phil Elwell <phil@raspberrypi.com>
> Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: Ic5431469dd7a6c8b391f84f27119dad876256880

Reviewed-by: Hans Zhang <18255117159@163.com>

> ---
> Changes in v2:
> 
> - utilize of_pci_get_max_link_speed() directly
> - also validate against exceeding Gen3
> 
>   drivers/pci/controller/pcie-brcmstb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 714bcab97b60..08a0e7091ced 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -2072,8 +2072,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>   		return PTR_ERR(pcie->clk);
>   
>   	ret = of_pci_get_max_link_speed(np);
> -	if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
> +	if (ret < 0 || ret > 3)
>   		pcie->gen = 0;
> +	else
> +		pcie->gen = ret;
>   
>   	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>   

