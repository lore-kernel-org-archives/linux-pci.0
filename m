Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298273A1698;
	Tue, 24 Mar 2026 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331141; cv=none; b=H2KhSFfs0qrHeBIdWiYf0yQ2RYPBWu/VJTWOMaidNRnbRZoR62ADtKVHDyebo++jfCZfVvLo9bpy2V2nLz1hFQlHYVao2IpEFo614UUgVdXcfWrxRefppDJ8n4IDW2ZWhqJBwSQyGBxfGQTNBGE4czsqbeZSZuSa1bYKgS8HhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331141; c=relaxed/simple;
	bh=0iOXdMy88Gmdg5ydhEndzikeqZTrp4f9Bun2OoMcyvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dryeCaa3Z80b71mc5qFjRZEoU0T1TZzDP2ykHtpab03jY4jjinSNnQLV63v/rXr/zefSH+4PCVn8rnDztNwNvUXkEnaVIHAXuqlCprVZIjImqBRa0znd4BK3ISBA5WXrj4KOT937g+J65EOQ8popoTMztbR1FOY6YaxYnncHQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oUohoZ+M; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oUohoZ+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=MR2E8w81K/znqi/OLyd286UhY5uk+R3kTmk+ppfFuV8=;
	b=oUohoZ+MdRevAz6XQDmWeQ8BbJst1V9WIb4rxnb6F7AAtK1ue9sTZFbUWDsn3P
	SaLKrmoYQt1SH9Vc6QxWZjJkQ/9OELbE4n1gde+rRsRkq27wjPdlB15ZYZDzWex9
	yP9vq5/CanKkjvj0fjaHzOkJaxFuTZdkRa0nMuekw7HrU=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3n6aXJMJpRTolBA--.28686S2;
	Tue, 24 Mar 2026 13:43:52 +0800 (CST)
Message-ID: <7ca0abb0-5202-4a43-a558-2b33d4a48b99@163.com>
Date: Tue, 24 Mar 2026 13:43:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: sky1: Fix missing cleanup of ECAM config on probe
 failure
To: Felix Gu <ustc.gu@gmail.com>, Hans Zhang <hans.zhang@cixtech.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260324-sky1-v1-1-6a00cb2776b6@gmail.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260324-sky1-v1-1-6a00cb2776b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3n6aXJMJpRTolBA--.28686S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWrKr43ArWxZrWrCFW8tFb_yoW8GF4DpF
	WDtrW7G3WrtayjyanrZ3WrCry5A3ZrJ3yDZws09w1avFy3ur4kGFZ2kFyYqFnrJ3y8Zr4f
	XF1ktF9rJFs0yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U53kNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBg63WnCJJiiMAAA3+



On 3/24/26 00:41, Felix Gu wrote:
> When devm_kzalloc() for reg_off fails, the code returns -ENOMEM
> without freeing pcie->cfg, which was allocated earlier by
> pci_ecam_create().
> 
> Add the missing pci_ecam_free() call to properly release the allocated
> ECAM configuration window on this error path.
> 
> Fixes: a0d9f2c08f45 ("PCI: sky1: Add PCIe host support for CIX Sky1")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Reviewed-by: Hans Zhang <18255117159@163.com>

> ---
>   drivers/pci/controller/cadence/pci-sky1.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
> index d8c216dc120d..9853a9c82c0e 100644
> --- a/drivers/pci/controller/cadence/pci-sky1.c
> +++ b/drivers/pci/controller/cadence/pci-sky1.c
> @@ -176,8 +176,10 @@ static int sky1_pcie_probe(struct platform_device *pdev)
>   	cdns_pcie->is_rc = 1;
>   
>   	reg_off = devm_kzalloc(dev, sizeof(*reg_off), GFP_KERNEL);
> -	if (!reg_off)
> +	if (!reg_off) {
> +		pci_ecam_free(pcie->cfg);
>   		return -ENOMEM;
> +	}
>   
>   	reg_off->ip_reg_bank_offset = SKY1_IP_REG_BANK;
>   	reg_off->ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK;
> 
> ---
> base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
> change-id: 20260323-sky1-890a90a72bc6
> 
> Best regards,

