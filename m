Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59E4A341C;
	Mon,  5 Oct 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209975; cv=none; b=uFe/RS8GPvVO5UyDOz6KMz3/e9ee1n1HXFbeLPf16CMaQ313DfSOYiN9ZKoBOiL/qp4Nl3s25wcTi5rBVzpdHSyBrHl6SbnHMqzM/1BQ0XgpjrbMe8RhvcmmQzaAGyLzumGVTTQQu02pe4vLAbSn7WgI97l6xD47B4dNSHA0an0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209975; c=relaxed/simple;
	bh=dR3nf6xCW4np55kOQycEYodNj9RL9fJ2Y54GNF1lX0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR/ujU/Ikk15zP556/gie31IvEB1cbUm1DIoT6ThOhexupODr0ZQyuzvpgEMP67OYOvqT+8DM7lFWKNRiIwWcc8wQMlImbdcpxe+0sOP5L6O96kAsBt3kXj3Ud0OHGSVWng4h1Aiu1uYbUAbvqMcT4RKSKaKPImtE/esRpyomJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE1+f07b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE1+f07b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741221F000FF;
	Mon,  5 Oct 2026 14:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209966;
	bh=REP6MYHxsdh3OHkYaHhZIo0xot4Ti1gN9Nb+mTFa5RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WE1+f07bVgtvLavxmSBzqprPbpkXFOKlk+AzeqIBV9ESKFJmUNeBQgD2OlvEY7anA
	 tgC/husuLQxl3QkKLJFhDRGFbWjl2hdB5TaSrzYK/vfJrTDAZnseNJ4yVi2/5dMfBQ
	 DmjHwK2s0h42kz5kyVcBUJTUmAa0R4GI43AmEfYSYZY2FBF3L1xYEAqsDwOWW7ovyS
	 hXDasPMgIDiT2TvpHi3UoUGEpMkkArtHZOvp0Tukab6boJJUyP8w634EVNMCnVZKgA
	 P/38Rqy6wR40fiKNc9oleBEmgEyr1y93KbFOiS+2J6HJLpNSiD6D1gSvI7WIX3YaGX
	 QZJrkuZ30ntbw==
Date: Mon, 5 Oct 2026 16:19:23 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, frank.li@kernel.org, den@valinux.co.jp,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Sort Register Field Macros by
 Bit Position
Message-ID: <asOx6y7hiVrEUNGa@parshuram>
References: <20260917103050.1020982-1-devverma@amd.com>
 <20260917103050.1020982-2-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917103050.1020982-2-devverma@amd.com>

On 17-09-26, 16:00, Devendra K Verma wrote:
> Sort register field macros by bit position to improve readability.
> No functional change.

This fails on current code and needs a bit more sorting.

> 
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---
> Changes in v1:
>    o Corrected heading and body as per reviewer's suggestion
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 9f237ba916de..006dea7d6322 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -31,8 +31,8 @@
>  
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>  #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>  
> -- 
> 2.43.0

-- 
~Vinod
