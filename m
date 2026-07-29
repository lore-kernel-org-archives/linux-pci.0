Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D14052BE;
	Wed, 29 Jul 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340840; cv=none; b=DpR6WlOyI2FPp+RcLczHgpEaDfrItMw6rnBoHcuoLg8MAAzwlTSKNFsGnzjKu2NRNJMwyRAaYXL5JhlxTuGjTxubjjXQ+d+wpd8FgguIF2aFBjInG8s7uqlPwzArASVrKW3DKbEUoNr6Cjlof1f6aRdjc5vp3inoqP9UwwdJgGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340840; c=relaxed/simple;
	bh=/6vPJeqcvtvtCvZtmsJi6u6JB0QeylO/CDur/wmJJgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHPFXtGdwJ0IubzkvyNhE3WTwmhl3H0QqfgiRQh7GdIqU/up/GqZ/oP5hlCeDcMZVswJ0rfp65XUtNAo51q6SVSALWDYOVCCrEA9+90H+BNJdjJmUFFGZjJTRmWibPfYp0/1Bgwbu3AL7lKErdYhkF6USrUqERlObVyAtySFfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReVk91Su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReVk91Su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172621F000E9;
	Wed, 29 Jul 2026 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785340839;
	bh=maBSX4x4149xGscMIRI+eWtyIRtwupXnBB1oY9K+LCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ReVk91SuVmAlMIEJUY3lALq9p7JPqmfIp4FaohTAVCG9zjpLA1rXW6DEK5pI6L3Lt
	 Vlx87KwvhrLeAoNAVYOi/q5YmeXaj0kJwvjNIY4COk3g0Hz5BAWYn8kQdRGXoSpCcb
	 3oXa3D7femsLl2w2LIZeNtUjZSkMmxHbrDXPB6BjJKCOzcWNHQWos3V4tqQB2c5Lxo
	 A8onamXl+69+QslW9DcoMrZWd8ik8NoWZR2KxQY6rjFTgoLH87q40v3bjdw8vxKZWC
	 NO//u9SWUEcGpR9kInUwCfRLACoMQ8SCsvEcjZKiyfFra8KlWBQgg4qpcRAYw4OMjo
	 LJXZZ5v7U3yEw==
Date: Wed, 29 Jul 2026 18:00:29 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCHv2] PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup
Message-ID: <g3gtckpqgacw44jqqb5hb3oejpelxvbba47tdwsvksxbbskygp@mcwtsbypoyar>
References: <20260716205811.800920-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716205811.800920-1-rosenp@gmail.com>

On Thu, Jul 16, 2026 at 01:58:11PM -0700, Rosen Penev wrote:
> Replace irq_of_parse_and_map() with fwnode_irq_get(dev_fwnode(dev), 0)
> in xilinx_pcie_parse_dt(). For an OF-backed device this is equivalent to
> the previous call, but uses the generic firmware-node API.
> 

What is the benefit of using fwnode API for OF only driver?

- Mani

> Unlike irq_of_parse_and_map(), fwnode_irq_get() returns a positive IRQ or
> a negative errno and never 0 (it rewrites 0 to -EINVAL). Store the result
> in an int and check for irq < 0, returning the error (including
> -EPROBE_DEFER). This also adds the error handling the previous code
> lacked, where irq_of_parse_and_map() failures were passed straight into
> devm_request_irq().
> 
> Built for ARM (multi_v7_defconfig + CONFIG_PCIE_XILINX) with LLVM=1;
> drivers/pci/controller/pcie-xilinx.o compiles cleanly.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: use dev_err_probe to handle EPROBE_DEFER.
>  drivers/pci/controller/pcie-xilinx.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 4aa139abac16..58532296182f 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -20,10 +20,10 @@
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
> -#include <linux/of_irq.h>
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  
>  #include "../pci.h"
>  
> @@ -535,7 +535,7 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie *pcie)
>  	struct device *dev = pcie->dev;
>  	struct device_node *node = dev->of_node;
>  	struct resource regs;
> -	unsigned int irq;
> +	int irq;
>  	int err;
>  
>  	err = of_address_to_resource(node, 0, &regs);
> @@ -548,7 +548,10 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie *pcie)
>  	if (IS_ERR(pcie->reg_base))
>  		return PTR_ERR(pcie->reg_base);
>  
> -	irq = irq_of_parse_and_map(node, 0);
> +	irq = fwnode_irq_get(dev_fwnode(dev), 0);
> +	if (irq < 0)
> +		return irq;
> +
>  	err = devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
>  			       "xilinx-pcie", pcie);
> @@ -585,10 +588,8 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  	pcie->dev = dev;
>  
>  	err = xilinx_pcie_parse_dt(pcie);
> -	if (err) {
> -		dev_err(dev, "Parsing DT failed\n");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(dev, err, "Parsing DT failed\n");
>  
>  	xilinx_pcie_init_port(pcie);
>  
> -- 
> 2.55.0
> 

-- 
மணிவண்ணன் சதாசிவம்
