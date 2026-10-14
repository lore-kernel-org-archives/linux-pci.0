Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F75592E0;
	Wed, 14 Oct 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997503; cv=none; b=iBYWFwgo1ojdD7l7h39uFL2OJUP8TAR56DzQxsJtF3TO5Z0dBOJ/UGhATrlBvPDVshxQqtnTwhFROZ5GIv8yHO71xYs98KcmkgV41sbu8CV5GUGZAtvzEiISP9JXggocPdLYhOscYeUMC1d5wHDeziIPEEVqrHfGbs/XbZyIsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997503; c=relaxed/simple;
	bh=lMjIZh/tGS1pgeh9x0Y8QhxqxxoA3y0STPrZtjZmPV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VYsGzQ24fT2zPpmKAAXLwMz5Iai6Ab0lMUSdhzRFExi9Zga65M0NJ/L50sBLO3E6rL9E8ZrRPbvFLPa1cDadEc1OiMR/7/tbctyL87nvkBJ91xGgjoUxAPYd5OMSWuqkvCLirEJkoEb8eqogr/wtWIqK9wnUJtBEJVpFk196rpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcoHHM7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcoHHM7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092C01F000CA;
	Wed, 14 Oct 2026 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791997502;
	bh=1m60YDqNW+LLDiN0gAY1o7wtInSpKM/VAZpHsdkBTVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UcoHHM7Yy9jQQo/s9LaDO1/kIlF5g0BUErFbhH+e1Txk5hY46odghehSF+eS32/iR
	 GPj/5l/pp4VUtNLzqDfQvmIPai4BzknaaUCrIBh0+LF29Do48ZvVN5TlpEcqITw+cW
	 kbU/waPp9nl5BszSOnN/R0rm99UFjWeb+NyuVccmIfVpGACotQUxX6IrvbO11H4L3D
	 gJO+qgDs5GDZ8rXeFdka9MiZ1GFSc0tdfJqf4ycRhs1CA25fVDSFh+JM70DbuxhVVI
	 sk9CVJCaPz2TXDcMx39c6DNo2jo/prFEtfNGkQCFlj9Xg+jdpZpNRkMqLUe0CVCQEu
	 Vg18hvbm7ttGw==
Date: Wed, 14 Oct 2026 12:05:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, alex@shazbot.org, skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Message-ID: <20261014170500.GA1638946@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903164615.5744-1-raizudeen.kerneldev@gmail.com>

On Thu, Sep 03, 2026 at 10:16:15PM +0530, Mohamad Raizudeen wrote:
> In nvme_disable_and_flr(), the PCI bar is mapped using
> NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)
> 
> However, the function later reads the controller status from
> NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> boundary. This violates the API contract.
> 
> Fix this by increasing the mapping size to include NVME_REG_CSTS. Also
> change sizeof(cfg) to sizeof(u32) to make the intent clearer.
> 
> Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Applied to pci/misc for v7.4, thanks for the reminder!

> ---
> Changes in v3:
> - Changed sizeof(cfg) to sizeof(u32) to decouple it from the mapping
>   size as suggested by Alex Williamson.
> - Updated the commit message to use "violates the API contract" instead
>   of "undefined behavior" to avoid overstating the risk.
> 
> Link for v1: https://lore.kernel.org/all/20260817092448.4395-1-raizudeen.kerneldev@gmail.com/T/
> Link for v2: https://lore.kernel.org/all/20260903040049.5460-1-raizudeen.kerneldev@gmail.com/T/
> 
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..06436a96db30 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> +	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(u32));
>  	if (!bar)
>  		return -ENOTTY;
>  
> -- 
> 2.53.0
> 
