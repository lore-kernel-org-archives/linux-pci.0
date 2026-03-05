Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD4613AD05;
	Thu,  5 Mar 2026 04:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772686524; cv=none; b=b0yvDe2k0wBtaojOjjcbnD4sVTVQW4zywjwBPabkSDLDEbYZYDiOQ3gnKT9RK8szWfDQDcbUEq4UR3Fr21eNBJZo01HC53+oCcVQl7XKzxUJZ3UIVbhs32RzXPD6vGLVlzTYWDvNr0ctu8uAvhntlkJ4SaXl/WApiKgJZ/wH6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772686524; c=relaxed/simple;
	bh=k6ZfvGZwa5alOXQpjmiJsxrKIn3nRvsMp4TPwNSMScI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3STo81WaWMRgjJ+6msJDcCQagQmwSmgZE79pFwBzyG8y2vhjmg5Nub8QokdCrSDX8/NByBAmicwqjqdZFRbNZJwGAisW5OSGtvByDMmLk1EZ2pLN4DKgQouskRJzk3R9mlAtryoJD8O/D/v3EbsW8nPwcJVhb+j86CHKHoYLTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6OPxysb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6OPxysb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90BDC116C6;
	Thu,  5 Mar 2026 04:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772686524;
	bh=k6ZfvGZwa5alOXQpjmiJsxrKIn3nRvsMp4TPwNSMScI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6OPxysbdUsvotufx5lEla53tkOSkDGDoTxTaoMmY+LUf4YgpBnErkS41wEp9iQx/
	 QVhgYg7Bk9EojICSVTd3IjnYV2nPe545OBh/nWE9suLcASb6uXssde2+TSFmZnrQ32
	 hh1JvZHSq45OVpIZC3Efn/1sNUaZbKsrsjsz0JVMpl3uSRvOCGiQ61VtsPzjwKXNB4
	 dJBbLo85521oWdUoQRjyzoEEH6Qh/y5x9JAw0cn8ixpHXpxPzSHe7oHq0eqOxxdisM
	 38fSofNa+uriv8khom5CLj5hKHEyqbaYziWimwEFeFs/lQrLkhCB0cToJZaUE4kJG+
	 kLUU1pqO6e17Q==
Date: Thu, 5 Mar 2026 10:25:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, s-vadapalli@ti.com, 
	arnd@arndb.de, mpillai@cadence.com, hans.zhang@cixtech.com, 
	unicorn_wang@outlook.com, kishon@kernel.org, linux-kernel@vger.kernel.org, 
	danishanwar@ti.com
Subject: Re: [PATCH] PCI: cadence: j721e: Add support for PCI NTB
 functionality
Message-ID: <iicnwbsl6o2hjlomx527fs23xyxifu3wzf56m7hwtlayzsn2o6@sfe5kuewojh3>
References: <20260220101030.852423-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220101030.852423-1-a-garg7@ti.com>

On Fri, Feb 20, 2026 at 03:40:30PM +0530, Aksh Garg wrote:
> Configure Non-Transparent Bridge (NTB) components to build along with
> J721E PCIe controller driver to add support for PCI NTB functionality
> in TI SoCs.
> 

Driver Kconfig is not the place to select your usecase specific drivers. Drivers
should only select drivers that they themselves need it, not the end usecase.

So please do it in your distro config or arch defconfig as you see fit.

- Mani

> NTB_NETDEV allows to setup a virtual ethernet interface over the
> NTB Transport layer, enabling connected systems to communicate with
> each other using standard network protocols and transfer data as
> ethernet traffic over the link.
> 
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
>  drivers/pci/controller/cadence/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 9e651d545973..2da9d4ed3ed0 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -76,6 +76,10 @@ config PCI_J721E_HOST
>  	depends on ARCH_K3 || COMPILE_TEST
>  	depends on OF
>  	select PCI_J721E
> +	imply NTB
> +	imply NTB_TRANSPORT
> +	imply NTB_EPF
> +	imply NTB_NETDEV
>  	help
>  	  Say Y here if you want to support the TI J721E PCIe platform
>  	  controller in host mode. TI J721E PCIe controller uses Cadence PCIe
> @@ -87,6 +91,7 @@ config PCI_J721E_EP
>  	depends on OF
>  	depends on PCI_ENDPOINT
>  	select PCI_J721E
> +	imply PCI_EPF_NTB
>  	help
>  	  Say Y here if you want to support the TI J721E PCIe platform
>  	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
