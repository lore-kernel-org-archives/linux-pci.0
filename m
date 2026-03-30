Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29343E274E;
	Mon, 30 Mar 2026 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909511; cv=none; b=LfNH1XUyFNCtSMD03UlExfZOWZVZe3O1VZTQxfSA2DWRShkd1nMWHnOqmyQilu2uy36nfu5RFWCZ9wBirzoanEwALOoq7Ew8Cerl0PNWbPbsuXROB2msiamgcfTu6/Hl2ZaJdRfuk7JZOLN3y0ONVpzRvddWefDwimwE3buPnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909511; c=relaxed/simple;
	bh=9f0cvspdY2DUKrq2fcU6JTmV7gpISidXMJ0kIlSgFQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ifeqbouIFQZudM9Y4cxH0qp+4tJuhJh5tL58/a0sIkq5eLRVsbmPAy/KhhpHcktEdLQlR5tVHit18Cjl2ZMYetGJewtlYRLE1mkOQXeXK4e9Xa5GXyrcQfPFspAiM/DIRQU3LJDogywOJxtfI1//GLUBIdlQQjA5fAyAKzNZfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUwxN7oV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUwxN7oV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD93C2BCB0;
	Mon, 30 Mar 2026 22:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774909510;
	bh=9f0cvspdY2DUKrq2fcU6JTmV7gpISidXMJ0kIlSgFQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FUwxN7oV5aH/oo0r0mn9N8ttjTu3PC1TQx9O1k0hDjfZumGQ1qbPuRwPDUsqoCnzh
	 cv+vgtbDRw61+4ozga9l5z4eX+pbEUVmOCsZiyWOL1s5n2/FPIqcFuFTUv5eQmmanK
	 bGKzqr2nMd9rmKR//YeigVVriJlJtJgKuqqDN/lRLJUi0geKvLpboiJdxwMm2QJ8/E
	 NbWzAJRPsuLCFFKrXmbL0E429WWYCkIUneOVkGKLIcirZo+wu1zMIfc3Q26MTp6l2Q
	 34IQ2Tszo+GK2SXY4CRLgpkMLQyDKnbEvuuwVKr3yxN5x4DYPFKy9PJotI0uzTlCT1
	 46eVybt565ZRQ==
Date: Mon, 30 Mar 2026 17:25:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: bhelgaas@google.com, robh@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: dead code cleanup in Kconfig
Message-ID: <20260330222508.GA108010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330214549.16157-1-julianbraha@gmail.com>

On Mon, Mar 30, 2026 at 10:45:49PM +0100, Julian Braha wrote:
> There is already an 'if PCI' condition wrapping several config options
> e.g. PCI_DOMAINS and VGA_ARB, making the 'depends on PCI' statement for
> each of these a duplicate dependency (dead code).
> 
> I propose leaving the outer 'if PCI...endif' and removing the individual
> 'depends on PCI' statement from each option.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Applied to pci/misc for v7.1, thanks!

> ---
>  drivers/pci/Kconfig | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e3f848ffb52a..33c88432b728 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -31,7 +31,6 @@ if PCI
>  
>  config PCI_DOMAINS
>  	bool
> -	depends on PCI
>  
>  config PCI_DOMAINS_GENERIC
>  	bool
> @@ -255,7 +254,7 @@ config PCI_DYNAMIC_OF_NODES
>  choice
>  	prompt "PCI Express hierarchy optimization setting"
>  	default PCIE_BUS_DEFAULT
> -	depends on PCI && EXPERT
> +	depends on EXPERT
>  	help
>  	  MPS (Max Payload Size) and MRRS (Max Read Request Size) are PCIe
>  	  device parameters that affect performance and the ability to
> @@ -272,20 +271,17 @@ choice
>  
>  config PCIE_BUS_TUNE_OFF
>  	bool "Tune Off"
> -	depends on PCI
>  	help
>  	  Use the BIOS defaults; don't touch MPS at all.  This is the same
>  	  as booting with 'pci=pcie_bus_tune_off'.
>  
>  config PCIE_BUS_DEFAULT
>  	bool "Default"
> -	depends on PCI
>  	help
>  	  Default choice; ensure that the MPS matches upstream bridge.
>  
>  config PCIE_BUS_SAFE
>  	bool "Safe"
> -	depends on PCI
>  	help
>  	  Use largest MPS that boot-time devices support.  If you have a
>  	  closed system with no possibility of adding new devices, this
> @@ -294,7 +290,6 @@ config PCIE_BUS_SAFE
>  
>  config PCIE_BUS_PERFORMANCE
>  	bool "Performance"
> -	depends on PCI
>  	help
>  	  Use MPS and MRRS for best performance.  Ensure that a given
>  	  device's MPS is no larger than its parent MPS, which allows us to
> @@ -303,7 +298,6 @@ config PCIE_BUS_PERFORMANCE
>  
>  config PCIE_BUS_PEER2PEER
>  	bool "Peer2peer"
> -	depends on PCI
>  	help
>  	  Set MPS = 128 for all devices.  MPS configuration effected by the
>  	  other options could cause the MPS on one root port to be
> @@ -317,7 +311,7 @@ endchoice
>  config VGA_ARB
>  	bool "VGA Arbitration" if EXPERT
>  	default y
> -	depends on (PCI && !S390)
> +	depends on !S390
>  	select SCREEN_INFO if X86
>  	help
>  	  Some "legacy" VGA devices implemented on PCI typically have the same
> @@ -340,4 +334,4 @@ source "drivers/pci/endpoint/Kconfig"
>  source "drivers/pci/switch/Kconfig"
>  source "drivers/pci/pwrctrl/Kconfig"
>  
> -endif
> +endif # PCI
> -- 
> 2.51.2
> 
