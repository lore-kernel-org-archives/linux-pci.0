Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276344418CD;
	Wed, 21 Jan 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983845; cv=none; b=DX00bUu7gr7M9pEJ5FgkSu7t518eeYDMzi2jNZZdk20wgGCc8o7x58fn7KFTxF3NCH3yPVg0msQECUqW3kCRE5XsRWMK4I4MR/MOtv3wx+9V4x4EFEBKfTsHP3MKqh8AdmwsELCQaDJ4zrtIsO9MK3cn7trtJfIZP8xAJNk8kEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983845; c=relaxed/simple;
	bh=3HQkcEjGCJ1yj66X82L5MXqnsBqdob461Aysn75m7ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5jjqkNHUGY1RvBu8vLaIqq71Cke8xawb4PGagJUTDUwBandXE/UWPwZ3JS09XfUD85DGZOaSrrI1CLi7Jc/fdREFpg3+Q5erIInDxrLu1bOihNEkKuOpaOqtq59NvXAmqsljPZocubLwSznbvGwcFe7NKg/Dtg/TgkCqLEARzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx544VGv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx544VGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F001C116D0;
	Wed, 21 Jan 2026 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768983844;
	bh=3HQkcEjGCJ1yj66X82L5MXqnsBqdob461Aysn75m7ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nx544VGvcMGn44GQA1ApNm5cSU9DOdJGVFG1gQhFREaB+8NRkcUGU4b92izBFa8eT
	 bC4KFpFjosz/C/ctE3hgXqY9p+m2IN1RHt1Ieq13d5FJO0/oSWWGRLUmm04YRM4e8l
	 qg2lcBFOCyEwmI6mYZrl9x9T+FAAcCizle30SgnjNAPRGm+D1VXqPqp3WPVvYmNLpn
	 CfqWIcmO21qNTDgnCtRgrBxxBoWqCkD3RZnOT3YlzUyRC4eXhFiFmgvQRU+WJ+rRYU
	 DzsL+/Hc06BAqS0TA+Ag9ehWi1TFk4FCsYyvLSW8X7XReisfzF3s/nlwCx5tKFa1kz
	 QROcQJ0ZyZRKw==
Date: Wed, 21 Jan 2026 09:23:58 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 4/5] PCI: dwc: Rework the error print of
 dw_pcie_wait_for_link()
Message-ID: <aXCNHnuvXJJZPU3y@ryzen>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
 <20260120-pci-dwc-suspend-rework-v4-4-2f32d5082549@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-4-2f32d5082549@oss.qualcomm.com>

On Tue, Jan 20, 2026 at 11:17:43PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> If the link fails to come up even after detecting the device on the bus
> i.e., if the LTSSM is not in Detect.Quiet and Detect.Active states, then
> dw_pcie_wait_for_link() should log it as an error.

Nit: maybe you should mention Poll.Active and Poll.Compliance here too?


> 
> So promote dev_info() to dev_err(), reword the error log to make it clear
> and also print the LTSSM state to aid debugging.
> 
> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
