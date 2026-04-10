Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281629BDB4;
	Fri, 10 Apr 2026 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860100; cv=none; b=kJZXGctjem/+/cJyj9klkdPPOiqAGo7H6XYlw9c1BVhSUpV7zCeMM+Wh7OeqGne86VQZXI9vE4wc5Ee5XR0c/Yik2VeJW5PALVYHamra9ZXaubrlGZWLTuegSHhed13idcPedBCC3/iEHqbSNCTp+J8cF2B7bsgB+7gZI/yRjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860100; c=relaxed/simple;
	bh=//ESncPHqZI45kc7AHVMexSXNtpBl7VQo0dpROKPmwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PaMK0RgUl2ru57+Lz1PmwZN2rj7QjNAKKfQZf3LClYrg7rPspXkoXbspaHtYKN5c/4qtOEBI+3qyLWd994hFk5MblorLyM7oIqfoytqBHtANhepCDnmsR2b7OH3gzO0JMbTSQQ8zHv9+bLEG85H/GwwDi0YYjn4F9RmOmCT/ymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtFiUMP7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtFiUMP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7C9C19421;
	Fri, 10 Apr 2026 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860100;
	bh=//ESncPHqZI45kc7AHVMexSXNtpBl7VQo0dpROKPmwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZtFiUMP7vlgQK1wPXNpruAKgHekTCZtsm+I2JcVRcliKHviTXCwy8uwAeFlg73Jlc
	 lxNmbciH+x1OxPj0smFEdGW9WM0ppJkgSvubqQcOVKHQ8sr7W4jMcLoF0iB0wz0gGu
	 y/EqLdB5OJvMxDJwZNstqzSfSbJi/awsJWipEBM4ZYlR8vKY41VWgLzDxMavuWE6kk
	 ush1NvannCmuDp0Fa0X3V9liqNSdJtEY1YK5687dSvQWPb6r/7Y3/qjO0jp6OybmEw
	 hJDvT+M+3iuW10qaroptu0IacbXM99I3VzavUHFpHwfTp8KwXpl0bVjMWLStpVGXI0
	 ima+HXpnwK6tA==
Date: Fri, 10 Apr 2026 17:28:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacob Moroni <jmoroni@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	David Hu <xuehaohu@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Allow wildcard device IDs in host bridge
 list
Message-ID: <20260410222818.GA597166@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409150123.3538444-1-jmoroni@google.com>

On Thu, Apr 09, 2026 at 03:01:22PM +0000, Jacob Moroni wrote:
> Currently, the pci_p2pdma_whitelist array requires an exact match
> for both vendor and device ID. Some hardware vendors support cross
> bridge p2p across their entire silicon lineup, so add support for
> wildcard device IDs to avoid the need to continuously update this
> array.
> 
> Signed-off-by: Jacob Moroni <jmoroni@google.com>

Both applied to pci/p2pdma for v7.1, thanks!

> ---
>  drivers/pci/p2pdma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index e0f546166..25e9358d0 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -530,7 +530,7 @@ static bool cpu_supports_p2pdma(void)
>  
>  static const struct pci_p2pdma_whitelist_entry {
>  	unsigned short vendor;
> -	unsigned short device;
> +	int device;
>  	enum {
>  		REQ_SAME_HOST_BRIDGE	= 1 << 0,
>  	} flags;
> @@ -601,8 +601,12 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>  	device = root->device;
>  
>  	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
> -		if (vendor != entry->vendor || device != entry->device)
> +		if (vendor != entry->vendor)
>  			continue;
> +
> +		if (entry->device != PCI_ANY_ID && device != entry->device)
> +			continue;
> +
>  		if (entry->flags & REQ_SAME_HOST_BRIDGE && !same_host_bridge)
>  			return false;
>  
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
