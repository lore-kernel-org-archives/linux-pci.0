Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A863EDAB9;
	Wed,  6 May 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087316; cv=none; b=X0yR03SJTZKqWEZhMNIhMCXmag+hnKl9GQsr8dCWYZdSpTJFNmjzeEDAvXgzCnbhrdUxnSZxUnnSi47kPH9bb6pFTHYF86tqONRPBelWo+iNIlchXjaWHMDKo3WXXQXxUMTiVRCaYjyPVD9hyHT9qG6/wnOfvbXbFKWJf1C5SNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087316; c=relaxed/simple;
	bh=BMEOMKlCQHVzxUJsWvxH+VWNDNsnOa86BVNbOsfuUpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ9ROA9V0euN7qkDvXR4YfFGmb4ARqhph9Ns692BNYlRMCfSrW48DyBw/8yxJRclW+/SjssvtKuPq4lxhXJDDEmpUwtOpCj2TzVZOxnydpf5K92A2JYonGQVUYbVJw2m/TMr6jFHMaIrYhLqj6PEvRhzOtz9XNCmrJXmguOizx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCgO/4lf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCgO/4lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C94C2BCB0;
	Wed,  6 May 2026 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778087314;
	bh=BMEOMKlCQHVzxUJsWvxH+VWNDNsnOa86BVNbOsfuUpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCgO/4lfvlhr58bNd1rnosxSp3cQL0RDHVEFc0noaCY0Dy4skeO1ZVlYjCHH6pq8D
	 mg23M7LCdrRdSNNVMglJimnDHXgVdN7f6qMRnKt+RD8wr+fbex8VusCrSOj+1PQcHe
	 /4lDBJdfVMZBwp+oAv0VlfZFb0RVb4AJS//pYejsSMGOoWVaj58yyhk/e761StBwGs
	 1OCycAJREI9arLs0pkiQSvV8leGcY2xw7170XL1l04kw7LtiQDnDyu/ZAw5QTpL1tn
	 B6qOmt9xFACoE3kzKWpodenJKQ/7ivA4waHngKu27qyV8O0mZAvFRsGTa0No/AzOG2
	 BN9nqp9qzfwyQ==
Date: Wed, 6 May 2026 22:38:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-pci@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hans Zhang <18255117159@163.com>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: brcmstb: Assign pcie->gen from
 of_pci_get_max_link_speed()
Message-ID: <t3u7r2ee6gdkjceula2ctvgditgxibwxcpaejc7ekbgdjog3br@c6n6ztzsbhpu>
References: <mid:20260501202438.376033-1-florian.fainelli@broadcom.com>
 <20260506164537.103196-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506164537.103196-1-florian.fainelli@broadcom.com>

On Wed, May 06, 2026 at 09:45:37AM -0700, Florian Fainelli wrote:
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

Since this is a 7.1 material:

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> Change-Id: Ic5431469dd7a6c8b391f84f27119dad876256880

This Change-Id is irrelevant to upstream.

- Mani

> ---
> Changes in v2:
> 
> - utilize of_pci_get_max_link_speed() directly
> - also validate against exceeding Gen3
> 
>  drivers/pci/controller/pcie-brcmstb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 714bcab97b60..08a0e7091ced 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -2072,8 +2072,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pcie->clk);
>  
>  	ret = of_pci_get_max_link_speed(np);
> -	if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
> +	if (ret < 0 || ret > 3)
>  		pcie->gen = 0;
> +	else
> +		pcie->gen = ret;
>  
>  	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
