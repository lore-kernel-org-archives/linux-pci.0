Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3338B143;
	Fri, 20 Mar 2026 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000672; cv=none; b=XveG1KiJT4xKkqfFYc5qd1uwuS0r4P8HbvhRqNh5tLNhdxUudgWQqlg4D6+DkwZKvTAfTP1UBWzs7hA4fKuOt3EmkllZiBRRdJ7jUl7kIJ2ugfKtZDGQWioNYmaGyG1lyczAtc8g4OLQLWAUTsCPdFpmWrTaTDqfe8Sv+M+BWPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000672; c=relaxed/simple;
	bh=+Qvge834KAIk5ZZ81dLKS3Me4JSrJxJtPlFmMPRlNo8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbtojIr00XWL7tzdrK9F/6QatbgETRLyL9A7x8vd7ts4X4zdGLWmtooFnpjbswwOUsyigesscMo+2s7YHmZ5SwnzC+XbtJ02GYwv2kOnDq9ZvKWBS+7mrVooK9QdiYIeVC1np0Sf3sxGnp7hTpGxe9YECpwEIeVxx+3IfY4OUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcdJH71rFzJ46sQ;
	Fri, 20 Mar 2026 17:56:47 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CB0F140584;
	Fri, 20 Mar 2026 17:57:48 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 09:57:47 +0000
Date: Fri, 20 Mar 2026 09:57:46 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
CC: <rafael@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam"
	<mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v2 2/3] PCI: hisi: Use
 devm_ghes_register_vendor_record_notifier()
Message-ID: <20260320095746.00006a32@huawei.com>
In-Reply-To: <20260319111315.87624-2-kaihengf@nvidia.com>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
	<20260319111315.87624-2-kaihengf@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 19 Mar 2026 19:13:08 +0800
Kai-Heng Feng <kaihengf@nvidia.com> wrote:

> Switch to the device-managed variant so the notifier is automatically
> unregistered on device removal, allowing the open-coded remove callback
> to be dropped entirely.
> 
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
+CC Shiju.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
> v2:
>  - New patch.
> 
>  drivers/pci/controller/pcie-hisi-error.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
> index aaf1ed2b6e59..36be86d827a8 100644
> --- a/drivers/pci/controller/pcie-hisi-error.c
> +++ b/drivers/pci/controller/pcie-hisi-error.c
> @@ -287,25 +287,16 @@ static int hisi_pcie_error_handler_probe(struct platform_device *pdev)
>  
>  	priv->nb.notifier_call = hisi_pcie_notify_error;
>  	priv->dev = &pdev->dev;
> -	ret = ghes_register_vendor_record_notifier(&priv->nb);
> +	ret = devm_ghes_register_vendor_record_notifier(&pdev->dev, &priv->nb);
>  	if (ret) {
>  		dev_err(&pdev->dev,
>  			"Failed to register hisi pcie controller error handler with apei\n");
>  		return ret;
>  	}
>  
> -	platform_set_drvdata(pdev, priv);
> -
>  	return 0;
>  }
>  
> -static void hisi_pcie_error_handler_remove(struct platform_device *pdev)
> -{
> -	struct hisi_pcie_error_private *priv = platform_get_drvdata(pdev);
> -
> -	ghes_unregister_vendor_record_notifier(&priv->nb);
> -}
> -
>  static const struct acpi_device_id hisi_pcie_acpi_match[] = {
>  	{ "HISI0361", 0 },
>  	{ }
> @@ -317,7 +308,6 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
>  		.acpi_match_table = hisi_pcie_acpi_match,
>  	},
>  	.probe		= hisi_pcie_error_handler_probe,
> -	.remove		= hisi_pcie_error_handler_remove,
>  };
>  module_platform_driver(hisi_pcie_error_handler_driver);
>  

