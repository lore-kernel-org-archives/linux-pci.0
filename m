Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4A38A72B;
	Tue, 12 May 2026 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582562; cv=none; b=d5Lpyj+2FvIaaWzVVC49MmBd+0ZYJwZRgnCUpM+btpCXpOAZxgzRd6yR5bCZ5qfRL4Us2O08n0axxi9GmQCMMZtwzFYItHevC0ZKXM/CPkHG17qj2pxBq0sD2j/DbI9wu1J5sWzsOHTFoKvr8sI7/mobvDGZ42Ajk8LedEFuJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582562; c=relaxed/simple;
	bh=LGbAO0AHFLRNyAw70dCe0+CzyGjGuUuAmp4E6C+EFYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfBK34bvgSHFSRApE1F/d4Q0YtUDY/wYVWoHBXIj5rAmNxSJjBL6cFHbwkOHzyvgLujyVOSQ+ufllR345tBDXaEDGWE0IzzJltre6rWnpyVdgA11wpyK62VV8zNLqpdDc2/uOqPsGiKtCsSM8SA4i0/vMeSEr6R/b1tY/eORntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=etIvsHbx; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="etIvsHbx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=LmFvmlOx2BLdUyJ4yewuhyKhlGjbS/4yGn66ucZ8zh4=;
	b=etIvsHbxSod4Uuck08SumNoE7SF6uTjLvqRgyoU9a5ma4K5nRaZ34QQWK+PtFw
	eGKhpc/7Pr4kEub1QkEclz8J5OY/UZdyFHXA3hPDYxr88bvftLwCw4dgqVG+wb4X
	I39ZukDllVZoh3q9raTp2KPtHyNXYFctxjpHIRmx62iTk=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC3KAnjAwNqLBufAw--.49467S2;
	Tue, 12 May 2026 18:41:40 +0800 (CST)
Message-ID: <8e5dacab-9698-4d65-8101-f5d680760cbd@163.com>
Date: Tue, 12 May 2026 18:41:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mediatek-gen3: fix incorrectly skipped pwrctrl error
 message
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>
References: <20260512103347.1751080-1-wenst@chromium.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260512103347.1751080-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wC3KAnjAwNqLBufAw--.49467S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr15tF48tr48ur1xKrWfKrg_yoW8GF4xpa
	yDKFyfAF95trs8ZFsFk3W3u3WYgwnxurW8Gan7Ww1fArZxCFyDK342934FgF4xtrWv9w17
	X3ZFya48GrsxuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRK-ewUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwVV+GoDA+Wi8wAA31



On 5/12/26 18:33, Chen-Yu Tsai wrote:
> When pwrctrl integration was added, the error message for when
> pci_pwrctrl_create_devices() fails was incorrectly put after the error
> goto statement, causing it to be skipped.
> 
> Move the goto statement after the dev_err_probe() call so that the
> error message actually gets printed (or saved if probe is deferred).
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/all/adjNaKB5KGpl6qIp@stanley.mountain/
> Fixes: 1a152e21940a ("PCI: mediatek-gen3: Integrate new pwrctrl API")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Hans Zhang <18255117159@163.com>

> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 6f0ae946d501..ef64778bbf8b 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1221,8 +1221,8 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>   
>   	err = pci_pwrctrl_create_devices(pcie->dev);
>   	if (err) {
> -		goto err_tear_down_irq;
>   		dev_err_probe(dev, err, "failed to create pwrctrl devices\n");
> +		goto err_tear_down_irq;
>   	}
>   
>   	err = mtk_pcie_setup(pcie);

