Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91E3EA66;
	Sat,  4 Apr 2026 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320542; cv=none; b=G4rFhtmBE7y+XhFrnbulB0K+RaiQaAVtzTKuaQc6IffnCuf+OtCfQBV/1bVWyStBmUw5c7kbCEhnoSZWl5qSLLOqYqXxYYReAmKoOf/irFJEyWmHq0QUCMXWzFUzEckqWM+cMSLlMQZ76qWBMo0rF2DO0B0CHlcLFdAEvoz7qXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320542; c=relaxed/simple;
	bh=9ctP0i7I2YwRGWpLi8tn9bX5cozwdeaYEaVPPVh8ELU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtMyM0YXZriBKeK6JcOfbv8y8F4plLGxQ5pLOLqzbVwnGkPFrzgw5Srvz2FBvZXHVkCAhbtAskuIkLed4hU7+bpKjOHdB0KXDdjB4EG16Ofl5iJ04sOnd/yc9LfMDEqy3f5RFdbszyUHL0N6eaCPoLPyi+9cTLxRGJC9oFBvcDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNjlcHuX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNjlcHuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7491C19421;
	Sat,  4 Apr 2026 16:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320542;
	bh=9ctP0i7I2YwRGWpLi8tn9bX5cozwdeaYEaVPPVh8ELU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNjlcHuXcQeqNSICiHwu5GYbwGqji/sF3CFhZsmCR2cBPVuxByrG6KAEsBcouUHRk
	 bplKSuo8Jx98J9tGim9YGUJ+uHnT7pyVZdOuqz2K44gPcEoQe5gNGDhPXReQe3vpWn
	 291xazBpe8XNmsp0P5uhWc+PsqQVlLBVPW5DoU7LBXzNbHvP+cQng8Sya2Cudp+Sif
	 +SA5o++UMMNwc+IupNO6gan6VBE2oKbhPMAp48asXxCriFXcFJeK4mzKMoqy7xHbat
	 9kXNqnl1aDXPQGXjNh9NJKOWkfuomLj5Bi7MqhS5V4GpljuVscL1GeaEcZ+KxPJfHf
	 rM6MvexLteaqQ==
Date: Sat, 4 Apr 2026 22:05:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	kwilczynski@kernel.org, ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com, 
	robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] PCI: dwc: Use common speed conversion function
Message-ID: <haordo3chzioc36ciby6x44eyullcacqyoyas636urrhjexk2g@pe6htoghrd6p>
References: <20251102143206.111347-1-18255117159@163.com>
 <20251102143206.111347-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251102143206.111347-4-18255117159@163.com>

On Sun, Nov 02, 2025 at 10:32:06PM +0800, Hans Zhang wrote:
> Replace the private switch-based speed conversion in
> dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
> function.
> 
> This eliminates duplicate conversion logic and ensures consistency with
> other PCIe drivers, while handling invalid speeds by falling back to
> hardware capabilities.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

I hope Bjorn will merge this series.

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c644216995f6..20ba314e82d5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -717,24 +717,12 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>  	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
>  
> -	switch (pcie_link_speed[pci->max_link_speed]) {
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
> +	link_speed = pcie_link_speed[pci->max_link_speed];
> +	link_speed = pci_bus_speed2lnkctl2(link_speed);
> +	if (link_speed == 0) {
>  		/* Use hardware capability */
>  		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>  		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
> -		break;
>  	}
>  
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
