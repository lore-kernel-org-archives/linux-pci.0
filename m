Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5CA328267;
	Thu,  3 Sep 2026 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473875; cv=none; b=snMy4OV4HTw+eQsTTexgSbK9BVGI1/U0YjhZxsjPIW/IGnPvcQ961PtADrh0F7hmw1zZElLCI5zv59w0FSZaDbI3AV0AbRG/CHMcyV8o3O6wUxYMBZYB3W6sXYjFNBWV97G4x79GHoO+qY8k2aHoJ4NlgXLq3YL99Ry/dVk2JSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473875; c=relaxed/simple;
	bh=WmSIN4aqynxXVJ4QHAsHJKb4FC8Tq+HJsC5nkI3IaiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qzk+sZqPy6hcPnfDN7L3z3Gs/JcC5lr9KrPwxiFJ1bdrjP9B/qTga85E/asMUCSC8hGVzUGrH/q37MklSZwN4k78Kp03sBiUi/H+KLY0lgkIShoh6AuXYclhFb+VbaQCHwxfxca9oTfVfhwfURwjha07GbGUK8MIq6XwWzCIV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8+4s0TL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8+4s0TL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E551F000E9;
	Thu,  3 Sep 2026 22:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788473874;
	bh=CB1xkpplzPJhyqXKWJWGeJ4rJLJCwQWrNJJOr4em59c=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=O8+4s0TLieIT8aAw1m5u+P/RocZZTAU5sUTQYxcbjifmPeHRpey9nNSYS8HwU9CFT
	 qfcN6uLP5Biu40ZNZQ8Lgdv6rOONA/r8GhtZDA31sqN7+9sC8n+BGf9gn8rbuMpK+X
	 SqbVIS7sH4xJmW7gUSbwqoquJTURpva2lpTxHZgyZxKUj1hV45hAcS8yvfNSHUBre5
	 9TPwO0s+GXK5Ak8S+Uttqt5PdT1zcZkZaX4c0Y2Up+TbTKFmLPMaslgmFYbRJIZHDD
	 cAuzMeUSangQRJzUZYl57VFS1EXn3V/qtiayRFqchSUtg+jgyjau78r3eo3cB+6t0S
	 aiEG8aoqeZuhA==
Date: Thu, 3 Sep 2026 17:17:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <leoliu-oc@zhaoxin.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eros Zhang <eroszhang@zhaoxin.com>,
	Cobe Chen <cobechen@zhaoxin.com>,
	"Tony W . Wang" <tonywwang@zhaoxin.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add Zhaoxin host bridges to whitelist
Message-ID: <20260903221752.GA2266182@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901083653.48890-1-leoliu-oc@zhaoxin.com>

On Tue, Sep 01, 2026 at 04:36:53PM +0800, LeoLiu-oc wrote:
> Zhaoxin host bridges support peer-to-peer DMA. Add their device IDs
> (0x1003, 0x1005-0x1008) to the whitelist so that p2pdma works on these
> platforms.
> 
> The entries cover the KX-6000, KH-40000, KX-6000G, KX-7000 and KH-50000
> families.
> 
> The KX-6000/KH-40000/KX-6000G/KX-7000 entries are marked
> REQ_SAME_HOST_BRIDGE because P2P requests crossing different host bridges
> are not supported on these parts. The KH-50000 entry is whitelisted
> without this restriction.
> 
> Signed-off-by: LeoLiu-oc <leoliu-oc@zhaoxin.com>

Applied to pci/p2pdma for v7.4, thank you!

> ---
>  drivers/pci/p2pdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9334eb314663..9fbbf1692f0e 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -569,6 +569,12 @@ static const struct pci_p2pdma_whitelist_entry {
>  	{PCI_VENDOR_ID_NVIDIA, 0x2f96, 0},
>  	{PCI_VENDOR_ID_NVIDIA, 0x2f97, 0},
>  	{PCI_VENDOR_ID_NVIDIA, 0x2f98, 0},
> +	/* Zhaoxin KX-6000/KH-40000/KX-6000G/KX-7000/KH-50000 */
> +	{PCI_VENDOR_ID_ZHAOXIN, 0x1003, REQ_SAME_HOST_BRIDGE},
> +	{PCI_VENDOR_ID_ZHAOXIN, 0x1005, REQ_SAME_HOST_BRIDGE},
> +	{PCI_VENDOR_ID_ZHAOXIN, 0x1006, REQ_SAME_HOST_BRIDGE},
> +	{PCI_VENDOR_ID_ZHAOXIN, 0x1007, REQ_SAME_HOST_BRIDGE},
> +	{PCI_VENDOR_ID_ZHAOXIN, 0x1008, 0},
>  	{}
>  };
>  
> -- 
> 2.43.0
> 
> 
