Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E32E974D;
	Mon,  6 Apr 2026 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775472915; cv=none; b=JTeoXN2+nvpAWoLTQPRywS1zheiYMSeS/P57EYKQ8ZL+MMO+xWLoEXI9Bljbs2BVmaObFEENJcMF0DmnXX/Lo1OqFO8y/isoqz+PkD5LMUa43xg0nn95WhOk4U357PK720pPpqeeacwCGDh6/u2O5JJF/48Lg8X1/wfU6hOzYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775472915; c=relaxed/simple;
	bh=PjL1O094goJPwvKMjnW3pq4BOcq6wShbZVNzj9P7xSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCLj95ojtkyb+/WPy2tBsgP+83jK0AfkaQgiZpAdEk8G7HWPmQH36Kt+RAqRL8Ernjqn4RAqedUIluNvZO2X398fd9/mgNFFa1CHdmQDXICz2YEFVry+GpEgNHn/QbVoPNp/Xgbby/XHgOO7aAG6zqrcIWJQrC/iTdW7MQRhl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TY+l1gte; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TY+l1gte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wdECQ9vyPO+uKEXwe24ZBljRaqjOmr0tA8pbSBC0lcY=;
	b=TY+l1gteHhou0/HrHzOUJodi15gQGSASpb44P3ArCLI0kUvkfqQIR+nw4XrOiQ
	scnH8y78nXzrHBcTnY1d78Qj+x9fzwaMJ56q8CNppGjMXgABrDnKbeH3nqBzkVpe
	OwAEHv/4dZOIPPxlpjpOXsCmsjJnJ9Yd3tDq2u+9K/jbw=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3X4zukNNpsE6tVQ--.1427S2;
	Mon, 06 Apr 2026 18:54:40 +0800 (CST)
Message-ID: <045cd971-7c84-4ca5-b64f-74c08abec0f9@163.com>
Date: Mon, 6 Apr 2026 18:54:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI: dwc: Use common speed conversion function
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, ilpo.jarvinen@linux.intel.com,
 jingoohan1@gmail.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260406104708.1218648-1-18255117159@163.com>
 <20260406104708.1218648-4-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260406104708.1218648-4-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgD3X4zukNNpsE6tVQ--.1427S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7Kr17CrWktw1rur17Wrg_yoW8Zry3pa
	y3AF4xAF4rJF43uF4DWa4kXFyUXFsxGrZ8CFZ8Was5XFyayas3KF40vr1ft34akFZ2yr12
	9w17JrWUG3ZrtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeSoXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xCvU2nTkPA2AAAA3r

Hi Mani,

This patch is missing one line of code:
link_speed = pcie_get_link_speed(pci->max_link_speed);


I'll send out v6. Sorry for the noise.

Best regards,
Hans

On 4/6/26 18:47, Hans Zhang wrote:
> Replace the private switch-based speed conversion in
> dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
> function.
> 
> This eliminates duplicate conversion logic and ensures consistency with
> other PCIe drivers, while handling invalid speeds by falling back to
> hardware capabilities.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 17 ++---------------
>   1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 06792ba92aa7..f2dd5da69c76 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -861,24 +861,11 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>   	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>   	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
>   
> -	switch (pcie_get_link_speed(pci->max_link_speed)) {
> -	case PCIE_SPEED_2_5GT:
> -		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
> -		break;
> -	case PCIE_SPEED_5_0GT:
> -		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
> -		break;
> -	case PCIE_SPEED_8_0GT:
> -		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
> -		break;
> -	case PCIE_SPEED_16_0GT:
> -		link_speed = PCI_EXP_LNKCTL2_TLS_16_0GT;
> -		break;
> -	default:
> +	link_speed = pci_bus_speed2lnkctl2(link_speed);
> +	if (link_speed == 0) {
>   		/* Use hardware capability */
>   		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>   		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
> -		break;
>   	}
>   
>   	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);

