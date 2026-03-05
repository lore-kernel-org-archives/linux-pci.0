Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29363E3DA6;
	Thu,  5 Mar 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731731; cv=none; b=GIxnNEpoVOUjdD1HJCryZVYgAPRJ/O4yYSIlX3Zrqf8Nc+cV95NawB097RVfuEhP1WFDXPYm+gghSf5vHfIlXyMVq4opXprfFeNBT2YSb73euLH2esZEdLftPheQ2dZpGVcPoiSOP6ZqUPINS7BEsizohY6W9GkdvW8DuWet7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731731; c=relaxed/simple;
	bh=MZowxmZsTnAYFPKyxeIySa/IbSDgxrfSx9JoaetZPcM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oOwygIHyqjMM1/QtlsTIIcwy4gl2lHxrbCCCNk+7RXBHNeB31kRhO7HBEpTKd+Jl0AqqbzsvpK/0E4+DpuIPuwCDjRaXNgUzWNlm/l3RTc4dGS1swZbY8FI4j1Z98IGJFid3l1IktUhzTQJtsHnmNa6fgpOtAzTJcxj8O/3eLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvINH9ZM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvINH9ZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D30C116C6;
	Thu,  5 Mar 2026 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772731730;
	bh=MZowxmZsTnAYFPKyxeIySa/IbSDgxrfSx9JoaetZPcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tvINH9ZMYNfpv6lDLIaqP8EGGgl4HGHOlateL5M/0p3t8M4/IMc18wKYyTjcZ2Wi2
	 GPqganjXpopWgk9u6p/FMSKeZEsOcZMQRcdbBX8jcRPY1ggKfZ8j4RQTBV5kp24Bjk
	 diI75BCJTWMuYFKzZJwbWye6tlZoQX0pcknFUcoEFBWmTMfTXG0WKEfZBR2dHMM0Ow
	 g/5AeCW+fcgPDNSYxoumqxozEipsx2+/MSWY00MrcaIWswmz25XKNMornlAhbifG2a
	 TIDxP1a0u8sq50G0UqHM7CwbiCgjVtZtIdmzBO6pDJ1jasMUeW+EwtPLPxKAkE9/IF
	 06HMaH1lhLU5A==
Date: Thu, 5 Mar 2026 11:28:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing maintaner, mark Altera
 drivers as orphans
Message-ID: <20260305172849.GA69524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305171852.3114177-1-dave.hansen@linux.intel.com>

On Thu, Mar 05, 2026 at 09:18:52AM -0800, Dave Hansen wrote:
> This maintainer's email is now bouncing. Remove them and mark
> the code as an orphan for now.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Thanks for the update.

Signed-off-by?

> ---
>  MAINTAINERS | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c32d76a949979..d010689fa91a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20121,9 +20121,8 @@ F:	Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
>  F:	drivers/pci/controller/pci-aardvark.c
>  
>  PCI DRIVER FOR ALTERA PCIE IP
> -M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	linux-pci@vger.kernel.org
> -S:	Supported
> +S:	Orphan
>  F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>  F:	drivers/pci/controller/pcie-altera.c
>  
> @@ -20368,9 +20367,8 @@ S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
>  PCI MSI DRIVER FOR ALTERA MSI IP
> -M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	linux-pci@vger.kernel.org
> -S:	Supported
> +S:	Orphan
>  F:	Documentation/devicetree/bindings/interrupt-controller/altr,msi-controller.yaml
>  F:	drivers/pci/controller/pcie-altera-msi.c
>  
> -- 
> 2.43.0
> 
