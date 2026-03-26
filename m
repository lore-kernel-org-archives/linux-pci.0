Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2B1DD525;
	Thu, 26 Mar 2026 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533669; cv=none; b=Oo8Qf7O+2IT8XpmuL0djymtRyyNndtHduUCp3o8ttESYSk+sBeavLroMnGZTeTMUmPVKAlm4kEPaLzRuZHkIxI4lO5n0sKm5kyQiNQWnIetv52aM6dFYgDEMFhqY+lwGxrii1vfMTwbDhG+vmlSeqbP0Rj/ixs2TacXSUl23qf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533669; c=relaxed/simple;
	bh=2uYUR8Vxx/QQ0+CUbaxImVU7nnq14SpcAzkPMiNzZ0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZjAt2oIa15ZrWhkUZNPIvmOjRNO3+ceW2Mz9zH0qF6ev/dA3SYt6uXz2vxw2jkHneCXBkX+pNwHl/NwXAAwZ9nYzGyzt21bv8OIBv7Bg3jpYkJzvoKmtpWOqtfZ0eCWZuvFhtw3GJvHjQapHnFoXcONuIxb7SbdrlFKqeifKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdNRMY0t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdNRMY0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15D0C116C6;
	Thu, 26 Mar 2026 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533669;
	bh=2uYUR8Vxx/QQ0+CUbaxImVU7nnq14SpcAzkPMiNzZ0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdNRMY0tJ6W28QB3RhiFyKqPCKge5DUMdBtn8S3KsKirhWRJdkyKazTmZtsE8sCup
	 VkSzMWHpl+W0VEsPpS1/KEY8w0uiyF73jaMmp/IarY1WQF0tdJHeSMOw+duuzGc0Hq
	 vK64no7jaMAaUP4kxoS0Zoz2QbihI6rom0OzRHwwwXmExDHyQVOP5J0ISlGyQLFyQA
	 wLx40jvl1Xz7kLwtXKxP47tpVl5SdV23iXpWnIU/VD3wTO927deqO5lmRtSw6cRPwI
	 7knKJXuG/UcUMYYElHIvJFBEJrBRE5CBmy6W062cJp92VXYvv0ZAlLoglwKf4s0WLE
	 +pbSENAnRqBsg==
Date: Thu, 26 Mar 2026 19:30:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Sajid Dalvi <sdalvi@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: intel-gw: Move interrupt enable to own function
Message-ID: <wbzulv5xewnqntx4kdgeldebiumshqmk6kdqsrtbgfzzvkiz46@jr6nd6jwzy2k>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-1-7fe13726ad4f@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-pcie-intel-gw-v1-1-7fe13726ad4f@dev.tdt.de>

On Tue, Mar 17, 2026 at 11:12:49AM +0100, Florian Eckert wrote:
> To improve the readability of the code, move the interrupt enable
> instructions to a separate function. That is already done for the
> disable interrupt instruction.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index c21906eced61896c8a8307dbd6b72d229f9a5c5f..3a85bd0ef1b7f9414ce19fe56d82a78e34e9b648 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -196,6 +196,13 @@ static void intel_pcie_device_rst_deassert(struct intel_pcie *pcie)
>  	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>  }
>  
> +static void intel_pcie_core_irq_enable(struct intel_pcie *pcie)
> +{
> +	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
> +	pcie_app_wr(pcie, PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
> +	pcie_app_wr(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT);

I'm confused. Previous code changed PCIE_APP_IRNEN register by writing to
PCIE_APP_IRN_INT field. But this function is now changing PCIE_APP_IRNEN and
PCIE_APP_IRNCR registers.

- Mani

> +}
> +
>  static void intel_pcie_core_irq_disable(struct intel_pcie *pcie)
>  {
>  	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
> @@ -317,9 +324,7 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
>  	if (ret)
>  		goto app_init_err;
>  
> -	/* Enable integrated interrupts */
> -	pcie_app_wr_mask(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT,
> -			 PCIE_APP_IRN_INT);
> +	intel_pcie_core_irq_enable(pcie);
>  
>  	return 0;
>  
> 
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்
