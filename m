Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20637BE6F;
	Wed,  7 Oct 2026 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410379; cv=none; b=aq+JQ6VL4wY+2Rf6VNJ5FfHxisSoVXHKhc8XEkQGyB/HuRMS6e4yS1CxL0VLc5DzyRLKjq9BYz/D6DJnBqGC+HbGvdsm7PqODLsblPYqIhMTSVnaCWL7jMCqfz51BVaUyrtqavrgUJHTuggjAfuvKo9n0v6v2DYgmCJJhrA6MIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410379; c=relaxed/simple;
	bh=HCisYVyHuOt1Hl1RJtdU8Ahhk6Agi+UowMPeXMfnAIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CY+LB/9JPkhTNyf7T7WUo+244AkvMX/TGnXwlqh0352ELXOvzkmVmVwHhTP57doV5tODP42gmJBjwxQRDBVofBp8RB03phk4jwsCSEth7R0bYCXaTDm9jAPAeLDfGrI9zYaoeBV8TUHPi6ZfK1lX+2Ed6IR4q41SfocjgBq+WuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCBp12eK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCBp12eK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BE91F000FF;
	Wed,  7 Oct 2026 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791410378;
	bh=3LXX1fZfCmlhsg/cLFy1P2HrEOxLYbT9UZmAiwabkQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=TCBp12eK7AvBTS1XCQoHSt9UsyF8lRq8qxrKiB5WdvEREOamKdzh26d/9TJl7RHyR
	 1dKKHEsqxRR1TK5yv7vHP9HnacWhAWv0LVDwrhY/j+f5QMZ+1bEHKtbsgwFyxsXDrT
	 rt0S1RwrhSZkVn72feK6sbUaZaTMLoas5+xdh73YFfayskCQJ3nYrCQCuJZoaSt/nl
	 1gd69xDgJUvuS1jgmwnwxe9NgdUDgkd3snIViBAfUzbRZYiEvFpTI/vXlF2QvIOwso
	 zk3rJxgHEuguPF+wX1UwzfEiTNTPRXwKy/h1ab8X/Geb09fJAFOjXhfsb+TfH9aXnh
	 Hw0m2UQDMCmOA==
Date: Wed, 7 Oct 2026 16:59:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kai zhang <zhangkai.cool@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel 0x6f00 host bridge to the whitelist
Message-ID: <20261007215936.GA847773@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007141558.59852-1-zhangkai.cool@gmail.com>

On Wed, Oct 07, 2026 at 10:15:58PM +0800, kai zhang wrote:
> For P2P paths routed through a host bridge, the P2PDMA core consults a
> whitelist of known-good hardware. Add Intel 8086:6f00 with
> REQ_SAME_HOST_BRIDGE so the entry permits peers only below the same host
> bridge.
> 
> The bridge was tested on a single-socket Intel Xeon E5-2697A v4 system
> with two PCIe GPUs below different Root Ports of the same host bridge.
> Without the whitelist entry, peer access was rejected before a transfer
> was issued. With the entry, 64 MiB peer transfers completed in both
> directions with data integrity verified while the IOMMU used translated
> mode.
> 
> Assisted-by: LLM
> Signed-off-by: kai zhang <zhangkai.cool@gmail.com>

Applied to pci/p2pdma for v7.4, thanks!

> ---
>  drivers/pci/p2pdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9334eb314663..84413920e39b 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -542,6 +542,7 @@ static const struct pci_p2pdma_whitelist_entry {
>  	/* Intel Xeon E5/Core i7 */
>  	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
>  	{PCI_VENDOR_ID_INTEL,	0x3c01, REQ_SAME_HOST_BRIDGE},
> +	{PCI_VENDOR_ID_INTEL,	0x6f00, REQ_SAME_HOST_BRIDGE},
>  	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
>  	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
>  	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
> -- 
> 2.54.0 (Apple Git-157)
> 
