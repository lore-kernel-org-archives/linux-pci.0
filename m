Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B4395ADA;
	Tue, 12 May 2026 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582448; cv=none; b=natBl62QpH+b6FoQWjit6DTiZHSJDPcfZQs451ccWJqBGHzvbenkITb026m3EIg6mv3R+mBcwbyWjpq7gitIoXLryXFIXcAhvyvHAQLexVWaFLetVRjwYF/aTmatg6KwDJoN40tDJwbCBbudtVWBvzwnQdN7u/g5gVVLD2B9fWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582448; c=relaxed/simple;
	bh=blv4HxAMetvrITJ74it9XNw0WknGH/+hNZ+QrSbKu+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4Z1OGhqfsIeDfX0YWvRLrLnHa5cD7DpUxvC7fHzSbG41Y92NRohjaiGrSG18RahLNfatzh8b7DvIJuAmZpFlJlFNLA1GCNSQjaYxm0nyanKpJRYv/KcnXyhcbc7zNn+k86ZLdxj1Ww/av8WPXQF89vFSU4lK1VCfUbHNMXkSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HgeprhN5; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HgeprhN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=gBX/lS5Yvey+ipcfVD625z3aLLWSouQtB+64uP4PZmw=;
	b=HgeprhN5srRgvQo3f11jS2a5XGVIPczW2LlmewxxQ/LCE5CB4oLOFFyWTz4KCJ
	EHFDEmMm20e1uwxQQ9kQ46yCIB3suKYPrjQ3KgTB9tCFUkwsug9Px6hUVzqveNXk
	FMY7OxSZ4KBoRu8w1Wzbk10zQR64G/oJJ0oI/0txaoIYc=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBn222WAwNq7JGwAw--.49017S2;
	Tue, 12 May 2026 18:40:23 +0800 (CST)
Message-ID: <dacd4a87-5622-4f34-92a8-8e04fbc0015b@163.com>
Date: Tue, 12 May 2026 18:40:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Fix signedness bug in fault injection test code
To: Dan Carpenter <error27@gmail.com>, Shradha Todi <shradha.t@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Fan Ni <fan.ni@samsung.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <agL-Uwfn26SI4Gb0@stanley.mountain>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <agL-Uwfn26SI4Gb0@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBn222WAwNq7JGwAw--.49017S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWDGr4DKFW8ZFyfCFyrCrg_yoW8Wr1rpa
	90ka47CFy8ta15JF9rAa4DZFySkFZrJrWUKayDu347uF1avF4vqr4rGFy7KryxGry8Ar17
	Kw1akFWqkF4fJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxdB5GoDA5ebOgAA3t



On 5/12/26 18:17, Dan Carpenter wrote:
> The kstrtou32() function returns negative error code or zero on success.
> However, in this case "val" is a u32 and the function returns signed
> longs so negative error codes from kstrtou32() are returned as high
> positive values.
> 
> Store the error code in an int instead.
> 
> Fixes: d20ee8e2dbd6 ("PCI: dwc: Add debugfs based Error Injection support for DWC")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Hans Zhang <18255117159@163.com>

> ---
>   drivers/pci/controller/dwc/pcie-designware-debugfs.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index 945f8f9b6d0e..a6737bdc46ac 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -305,6 +305,7 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf,
>   	u32 val, counter, vc_num, err_group, type_mask;
>   	int val_diff = 0;
>   	char *kern_buf;
> +	int ret;
>   
>   	err_group = err_inj_list[pdata->idx].err_inj_group;
>   	type_mask = err_inj_type_mask[err_group];
> @@ -326,10 +327,10 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf,
>   			return -EINVAL;
>   		}
>   	} else {
> -		val = kstrtou32(kern_buf, 0, &counter);
> -		if (val) {
> +		ret = kstrtou32(kern_buf, 0, &counter);
> +		if (ret) {
>   			kfree(kern_buf);
> -			return val;
> +			return ret;
>   		}
>   	}
>   

