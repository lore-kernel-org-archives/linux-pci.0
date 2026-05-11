Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B89356748;
	Mon, 11 May 2026 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541968; cv=none; b=RyCyco02J8QZrRSXuHimKSNA1YW/EtclwLI924hP2A3hYN1tg+/4oGUhxlKfuZTFnsfsXlw7rEeeTx8O99rnPgs295/mVLQtLaBqnSDEm2bR/VQjvaR7RU+tzlKqcIdBZLabauEyjHtv41wMtHNwL15l1wuDsKsEDj94bUwLrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541968; c=relaxed/simple;
	bh=FFxy2qGG5uICxZy6GlEVZYlyFPB95KU8iomidDtk2XA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UHVbc3FnbmTboZT4yOPzmc3bV+Hr0F6O92mP/oVgWZT0pgxjiZ+uB/eFo1vIy1FZx9OtRXFflp8xXBtf3KFLQRQXv501T4iJ6XOfOKFOMcslA5JUvQI77a0Prq11l2a9aERi5qBDgQsTrHzVyvc//JFJytvLTXbQQdn+SXYaxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k62h1kKb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k62h1kKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C8AC2BCB0;
	Mon, 11 May 2026 23:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541968;
	bh=FFxy2qGG5uICxZy6GlEVZYlyFPB95KU8iomidDtk2XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k62h1kKb8vIErULvwuFtu8BzMPVBtg/C0t94FaJwu1JkTOruCcndsTZXQ/GajYWxK
	 wlFsLI8RTi2FRa60IHJNZb6wACBwwYmHR1LwDwalDHpWPNfrltv8hl/oaR0PHgrcw6
	 HT1zLVJNCezcYuPq9xN8mEZ4RSh0Okom68+W11pLDGMgpC1wJLJSpUEpvhb60uEXnM
	 vcXD+NNf747+JlPQcdLM1QyIpc4R7iEeY+y9D9EHuI6xfO1xFx7P9pi2GMnfm8vN7r
	 BzmnWI+FL4JP94QNz1GsSk9LmkoTxlSs+wEqXDqWfVtOj4Boar94+Q7VEnrA/xqRLn
	 s7JVqAKc3Td9Q==
Date: Mon, 11 May 2026 18:26:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
Subject: Re: [PATCH v5 1/7] MAINTAINERS: Remove bouncing intel-gw maintainer
Message-ID: <20260511232606.GA194054@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-pcie-intel-gw-v5-1-0a2b933fe04f@dev.tdt.de>

On Fri, Apr 17, 2026 at 10:35:45AM +0200, Florian Eckert wrote:
> The maintainer's email address has been bouncing for months. Mark the PCI
> intel-gw driver as orphaned.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>

I pulled this one into pci/for-linus because we can merge it for v7.1
and avoid more bouncing.

Mani, if you add more intel-gw patches this cycle, you'll have to
re-fetch the pci/controller/dwc-intel-gw branch first.

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f004da89b1aa339116908f642e894..725f333f265bef416b5144c56649cb6eae736e40 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20518,9 +20518,8 @@ F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
>  F:	drivers/pci/controller/dwc/pcie-keembay.c
>  
>  PCIE DRIVER FOR INTEL LGM GW SOC
> -M:	Chuanhua Lei <lchuanhua@maxlinear.com>
>  L:	linux-pci@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>  F:	drivers/pci/controller/dwc/pcie-intel-gw.c
>  
> 
> -- 
> 2.47.3
> 
