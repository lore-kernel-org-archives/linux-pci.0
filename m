Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A5221F0C;
	Mon, 16 Mar 2026 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641070; cv=none; b=Jk44WonVvhyHCgiCTCpu2bZJ8imiaihdHBbEv9yZ19UvJ0d8AqQxmmKmsDgyNPw0LQOIRk4b18G51iiG0iuOWsl/UuZK87BdfPasRQTg6iiia7NVYUf/0feVy3NCSW7dX02r32fS+nR3f8SKSQzgdYEq57Z01+b3b0CYKmKep+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641070; c=relaxed/simple;
	bh=WN3yfJ3zXoQ2ZODFv7YUiHHYTyhwghsV8HJyM/YeQxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4mIK5EeKeSDInZai1wXVizPwI2yQ1s0dvHpAyJgbGNE7cS5FTq9C3Y8C+aUwd65m0fU5aq4mQHhnE0c8DVi9z0WBV1XS72Ar50RwSp7yK0cvS22YX+sqRA/2bz0LpU1MXctkWc+9J9MmURj3tsRbokYSvvK5CJAYjW0qg15b78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u34hZwGM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u34hZwGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85D3C19421;
	Mon, 16 Mar 2026 06:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773641069;
	bh=WN3yfJ3zXoQ2ZODFv7YUiHHYTyhwghsV8HJyM/YeQxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u34hZwGMuEW2JI7wclq1OZIFStesOurFL/TuE9PgjLLMekXAQ2vRJBrZ3Kp/Hiree
	 Re9JAyFzRRqFJxw4j38F6/ea/imVR2KURPJ9ZjTTBkV8y3HNaU2VRD5aVxHsWq6/tw
	 XbtS9FyBH5vJ8017vayj/7+9feiJZcwUeCvLaFqqrqcVjHn/5c9J66v+tJVH3Xe6MS
	 2iHhso8KZ2RY1UyCTNft5yRdPqBfl7DJUrrgq4GEDePvZOXySrGOuUFVRZ1yX42P8R
	 hprKy1IF4oT2azCBEBkbZVYN3fJOeQI0WjSm7v6fJ3NWXb1UktAQ2XeXo9ghIiUfVF
	 O06DmAwy/Tzfg==
Date: Mon, 16 Mar 2026 11:34:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, kernel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 05/13] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <tot7suhdkydo5er4zjcxkdvfalii7k72kqyw54o5frtoklkxif@l6x6ipaezlmq>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-6-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313020823.1592389-6-sherry.sun@nxp.com>

On Fri, Mar 13, 2026 at 10:08:15AM +0800, Sherry Sun wrote:
> The current DT binding for pci-imx6 specifies the 'reset-gpios' property
> in the host bridge node. However, the PERST# signal logically belongs to
> individual Root Ports rather than the host bridge itself. This becomes
> important when supporting PCIe KeyE connector and PCI power control
> framework for pci-imx6 driver, which requires properties to be specified
> in Root Port nodes.
> 
> With the common Root Port parsing now handled in dw_pcie_host_init(),
> update the reset GPIO handling to use the parsed port list from
> bridge->ports. To maintain DT backwards compatibility, fallback to the
> legacy method of parsing the host bridge node if the reset property is
> not present in the Root Port node (indicated by an empty ports list).
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 74 +++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 83beca5a1fc2..cb18e1579788 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -34,6 +34,7 @@
>  #include <linux/pm_runtime.h>
>  
>  #include "../../pci.h"
> +#include "../pci-host-common.h"
>  #include "pcie-designware.h"
>  
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> @@ -150,7 +151,6 @@ struct imx_lut_data {
>  
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
> -	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
>  	int			num_clks;
>  	bool			supports_clkreq;
> @@ -1222,6 +1222,44 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
>  	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
>  }
>  
> +static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	struct pci_host_bridge *bridge = pcie->pci->pp.bridge;
> +	struct pci_host_port *port;
> +	struct gpio_desc *reset;
> +
> +	if (!bridge) {
> +		dev_err(dev, "Bridge not allocated yet\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * For DT backward compatibility: if no Root Port nodes were parsed
> +	 * (indicated by empty ports list), parse reset-gpios from the host
> +	 * bridge node.
> +	 */
> +	if (!list_empty(&bridge->ports))

You should move this check and the comment to imx_pcie_host_init() and call
imx_pcie_parse_legacy_binding() conditionally to make it clear that this is a
fallback.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
