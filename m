Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B90219EB;
	Fri, 17 Apr 2026 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418505; cv=none; b=THwE/pWXyIgkk+uAPJioBPcGRtky0/61QIHs6kL2g3LEKoU3pXMfe1H1gY8s+lK87a0RTk0BSV4BqA8GePV5bIv219QUgAorGpsTkM14LleVgWzi/O5VZx60QjDdAlrE3LRSBBsPgxS8a0CiOuUmPIXsoGhVaaazQosGhbbemqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418505; c=relaxed/simple;
	bh=a9gbty5WFhq3JGklAorMAB3mAtTv1TV9SZwNDXwQnx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihy6b8ouhQ9niAhgE02YUC9RswPp46J8TAf0pZK/v0eE7e78tvksPl+01cfL9TeLLagiz6wZQ5fxZJtO4CSAG383pdWXfOSeHuBTo0LE6VesxxBtQ8w3w/sgc1Gcn6oQM3CUjMRMzbwIeAQcwqtoTFiW/HDprFjtaAA5PSeXIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERphNZZO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERphNZZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5AFC2BCB4;
	Fri, 17 Apr 2026 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776418505;
	bh=a9gbty5WFhq3JGklAorMAB3mAtTv1TV9SZwNDXwQnx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERphNZZOxs/V1W7iuK2axQct/Ynkw63V4JCVpEptUtQo9DROAGZrBVYDaIaOJBEkt
	 RUaG+sEYQpkwjrAtqpKkFFqS05rKf6hk9nSlafs5JRkGuxg19TDkhZqDFYWwOzNQvR
	 +TkLXxTDCFpJxoXdjN7Nm8tKi6NFsI4TZDyO4XJYcxcqyuX9bCtyT4cgojYhV41xhE
	 Pf+g2CIaaAccz2qtAVA+1ONzyUmeGZ5+xFojx3GXCmYRByWHGRKNkIf9aDKawC0rJM
	 IkzlDv3LUIOR/Msc8/astuThSDCQdn1tyIKZcjzxbw7RYCvEhRtY3U9y9PhUIT5rvN
	 S7yKKsg+VoAYA==
Date: Fri, 17 Apr 2026 15:04:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yanghui Ou <ouyanghui@eswincomputing.com>, Yu Ning <ningyu@eswincomputing.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: eswin: Fix resource leak on dw_pcie_host_init()
 failure
Message-ID: <gs3kbuwifduoa3gdhyxpg25tl5kifmlxdavgjgyxmihyt4hmr4@bcwz36emppw6>
References: <20260416-eswin-v1-1-a4991725b5ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416-eswin-v1-1-a4991725b5ca@gmail.com>

On Thu, Apr 16, 2026 at 08:30:20PM +0800, Felix Gu wrote:
> When dw_pcie_host_init() fails, the code jumps to err_init which
> only calls pm_runtime_put() but skips the clean up of port resources.
> 
> Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-eswin.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
> index 2845832b3824..0185b55e09e3 100644
> --- a/drivers/pci/controller/dwc/pcie-eswin.c
> +++ b/drivers/pci/controller/dwc/pcie-eswin.c
> @@ -348,7 +348,7 @@ static int eswin_pcie_probe(struct platform_device *pdev)
>  	ret = dw_pcie_host_init(&pci->pp);
>  	if (ret) {
>  		dev_err(dev, "Failed to init host\n");
> -		goto err_init;
> +		goto err_pm_runtime_put;
>  	}
>  
>  	return 0;
> @@ -358,7 +358,6 @@ static int eswin_pcie_probe(struct platform_device *pdev)
>  		reset_control_put(port->perst);
>  		list_del(&port->list);
>  	}
> -err_init:
>  	pm_runtime_put(dev);

Error path is really messed up. On pm_runtime_get_sync() failure, it should
go to 'err_free_ports' and on dw_pcie_host_init() failure, it should go to
err_pm_runtime_put.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
