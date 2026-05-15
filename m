Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F9246781;
	Fri, 15 May 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863082; cv=none; b=im+nZW3ASTlxneiYsivwCOiUYcnse0UdrH2LmL7dCOPURVv8PEIZYKXJB0EqQiinG39iOMzej9v7wrBtZPL4dkqbIBguhvjI4DkOkLyYix10a7kkC+0VjMcLeBopMErd2RClZze+M8/gDQl1F/DOo5Qi6OvWy7GmRPHiOKDcHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863082; c=relaxed/simple;
	bh=4LdAuosZ3gLl5ldnT6Wb/iOVobL7IjhwJIw+0NReLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S1Ery+tmiRMAB6LFYk2I+0rckaKXka+wxw6i8RJN0s35FmETOJlcyb/3J4xrHFOhwPLF7SHExw8m9+hiU4RJM30xVYNuny3f/PqO8Hwrtqm1Du2kY//N8cajiZvVNf6PY0RF3K0A3+5hwJ3QDxShGYev+ZTztvIXk36ahX1akU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKUGFPee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKUGFPee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B703C2BCB0;
	Fri, 15 May 2026 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778863082;
	bh=4LdAuosZ3gLl5ldnT6Wb/iOVobL7IjhwJIw+0NReLzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EKUGFPeeXzM+hWW25sMm100kXslkLAjij398t8UroQn5KZ/+FMzZe+dyt4V8goWNO
	 2CfgbHYliW47Ya5OZwlW7DCuumZYj7URS6bjx7OeSOb2vhdXt9ylPk2gGRXzgYI4Tv
	 MECp1cbidiVSsRR2I4Y7nx/OnnGE9ValkQXzK1wJAGfek02ZTGkK3o7z0y9YIllWuB
	 F5tmwZS7NJ/1IJ8K2pIDPAbpVCijJ4osK30quXhJKn4Co6VOBRzOua6kKpGEBgimAy
	 eDlGWEdNm48NfO1INQ6ePFp+Fk1GRYXIVvjT+KnbjWjshv47giMR468NT07dugx2h2
	 Qr5vCrbVKDHwQ==
Date: Fri, 15 May 2026 11:38:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, mani@kernel.org, ryder.lee@mediatek.com,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianjun Wang <jianjun.wang@mediatek.com>
Subject: Re: [PATCH] MAINTAINERS: Remove invalid email for Jianjun Wang
Message-ID: <20260515163801.GA496866@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515153635.136054-1-18255117159@163.com>

[+cc Jianjun]

On Fri, May 15, 2026 at 11:36:35PM +0800, Hans Zhang wrote:
> Email to Jianjun Wang <jianjun.wang@mediatek.com> bounces with error:
> "550 Relaying mail to jianjun.wang@mediatek.com is not allowed".
> Remove the address to avoid sending future kernel maintenance queries
> to an unreachable destination.
> 
> The MediaTek PCIe driver remains supported by Ryder Lee.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Applied to pci/for-linus for v7.1, thanks!

The most recent traffic I see from Jianjun in lore was from January
2025.

> ---
> Hi Bjorn and Mani,
> 
> Recently, when replying to emails in the Linux community, I kept
> encountering that Jianjun Wang's emails were being returned. The
> detailed information is as follows:
> 
> """
> Dear user 18255117159@163.com:
> Sorry to inform you that your email (send to jianjun.wang@mediatek.com) has been returned. The details are as follows: 
> 
>  ------- Original Mail Information -------
> Time:2026-05-15 23:04:39
> Subject:Re: [PATCH v2 6/8] PCI: aardvark: Add 100 ms delay after link training
> To:jianjun.wang@mediatek.com
> Relpy Code:
> SMTP error, RCPT TO: Host mediatek.com(1.203.163.78) RCPT TO said 550 Relaying mail to jianjun.wang@mediatek.com is not allowed 
> """
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6aa3fe2ee1bb..b2609dc33c62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20745,7 +20745,6 @@ F:	drivers/pci/controller/dwc/pcie-intel-gw.c
>  
>  PCIE DRIVER FOR MEDIATEK
>  M:	Ryder Lee <ryder.lee@mediatek.com>
> -M:	Jianjun Wang <jianjun.wang@mediatek.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
> -- 
> 2.34.1
> 
