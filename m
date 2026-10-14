Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5BE30C16B;
	Wed, 14 Oct 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004619; cv=none; b=lyKmpduP3HOCj7mRVDeYhuU32bsjDSRRXbaZlJdyh5/0cylWVrwRFpxaB+HYyZ0x6yLLoBYWRpM0RxPOyytnFwZHUBzx2vrA9EvGJVjDzA0voca+MMlxsQfuNDaDJFqVl453hi2lp5dwDof++/yuxVrQteidaxgLP90YWVEnG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004619; c=relaxed/simple;
	bh=YPMN1pOXqynjHFk47p7Bp1UnUUS0N9YDVJj2MZlYt9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nf2Jhobfa9Q+Y5cXCw8tSwljHrZiSzurPhYOdMB2EcoGncex1fMticx8quSBj6jM+yMparmLhT3a0S5j8Ay0eDpWmbxZNjjv0KAApF44au2haWdtze2P40B3S8vaLtfks/r5J/mvrKquemHq4QrIVGAirvDI0rE+Wtshzta1bGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emSOeImn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emSOeImn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F11F000C4;
	Wed, 14 Oct 2026 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792004618;
	bh=AUetRs2JzHGXUdWL+DlgMbrH1pB/sGjSZRZVL8C7DR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=emSOeImn4oAHhugVP5HguvOVdvxsWkcT2Y/WzSHLHeuUgu7h03Iu0VACEJ/CQ9CFd
	 S1Ut2SDs4/sRSzbG1Ep+mVtZIDH7Q6zs+vKj7SnDplMfH1pRuYRHh7UP7GslqLRBEU
	 UWFeNN6g5bKNmHfohC+G+RtizagAo0ez3pNPDjuwK1oj8PVJxMkvIW4Pi5mGkfvFEG
	 1+s1pddk5RqkrX1KqtRDJMO2hI8zRh8IsWERUW2C2dQzq/Ogik4bIKNSjTuPcPcuJt
	 vT+yU0Lpulw+QXtbWAdatNOTJlSZV4Hdpb+rYz8aALoZ9rqelXoW/vXuztQ/4x1jcG
	 3CwHfvjRskO4A==
Date: Wed, 14 Oct 2026 14:03:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Aksh Garg <a-garg7@ti.com>,
	Tom Joseph <tjoseph@cadence.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: cadence: Store the core controller in platform
 drvdata
Message-ID: <20261014190336.GA1650387@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915082826.4135665-1-lilinmao@kylinos.cn>

On Tue, Sep 15, 2026 at 04:28:26PM +0800, Linmao Li wrote:
> cdns_plat_pcie_probe() stores a struct cdns_plat_pcie pointer with
> platform_set_drvdata(). cdns_plat_pcie_shutdown() and the callbacks in
> cdns_pcie_pm_ops retrieve the same pointer with dev_get_drvdata() and
> use it as a struct cdns_pcie pointer. This makes them read phy_count
> and phy beyond the wrapper.
> 
> struct cdns_plat_pcie only contains a pointer to struct cdns_pcie. Drop
> the redundant wrapper and store the struct cdns_pcie pointer directly.
> 
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
> Suggested-by: Aksh Garg <a-garg7@ti.com>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Wow, nice find!  Hard to believe this has been broken since 2019
(v5.5) and we didn't notice.

I added a stable tag.

> ---
> Changes in v2:
> - Drop the redundant struct cdns_plat_pcie wrapper (Aksh Garg).
> ---
>  .../controller/cadence/pcie-cadence-plat.c    | 27 ++++++-------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index 13edc6be21f5..4a24302cc5b2 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -14,14 +14,6 @@
>  
>  #define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF
>  
> -/**
> - * struct cdns_plat_pcie - private data for this PCIe platform driver
> - * @pcie: Cadence PCIe controller
> - */
> -struct cdns_plat_pcie {
> -	struct cdns_pcie        *pcie;
> -};
> -
>  static const struct of_device_id cdns_plat_pcie_of_match[];
>  
>  static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
> @@ -36,9 +28,9 @@ static const struct cdns_pcie_ops cdns_plat_ops = {
>  static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct cdns_plat_pcie_of_data *data;
> -	struct cdns_plat_pcie *cdns_plat_pcie;
>  	struct device *dev = &pdev->dev;
>  	struct pci_host_bridge *bridge;
> +	struct cdns_pcie *pcie;
>  	struct cdns_pcie_ep *ep;
>  	struct cdns_pcie_rc *rc;
>  	bool is_rc;
> @@ -51,11 +43,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  	is_rc = data->is_rc;
>  
>  	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
> -	cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
> -	if (!cdns_plat_pcie)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, cdns_plat_pcie);
>  	if (is_rc) {
>  		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
>  			return -ENODEV;
> @@ -67,9 +54,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  		rc = pci_host_bridge_priv(bridge);
>  		rc->pcie.dev = dev;
>  		rc->pcie.ops = &cdns_plat_ops;
> -		cdns_plat_pcie->pcie = &rc->pcie;
> +		pcie = &rc->pcie;
>  
> -		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> +		ret = cdns_pcie_init_phy(dev, pcie);
>  		if (ret) {
>  			dev_err(dev, "failed to init phy\n");
>  			return ret;
> @@ -94,9 +81,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  
>  		ep->pcie.dev = dev;
>  		ep->pcie.ops = &cdns_plat_ops;
> -		cdns_plat_pcie->pcie = &ep->pcie;
> +		pcie = &ep->pcie;
>  
> -		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> +		ret = cdns_pcie_init_phy(dev, pcie);
>  		if (ret) {
>  			dev_err(dev, "failed to init phy\n");
>  			return ret;
> @@ -114,13 +101,15 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  			goto err_init;
>  	}
>  
> +	platform_set_drvdata(pdev, pcie);
> +
>  	return 0;
>  
>   err_init:
>   err_get_sync:
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
> -	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
> +	cdns_pcie_disable_phy(pcie);
>  
>  	return ret;
>  }
> 
> base-commit: 9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d
> -- 
> 2.25.1
> 
