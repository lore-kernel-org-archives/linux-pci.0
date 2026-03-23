Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559B3BF665;
	Mon, 23 Mar 2026 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284641; cv=none; b=dumBk1yHQvPYBHK9k6b/k0Py3/r9ECJKDnczxpOVJ5S6/2qgczjCYb/niuFES/8xDlNY+eSXZqnnlW5WmliG9wIx3skwEWAT99G8qZ6arUsQjCkgLsm0ixfE5RVBRjWBX+F0bqg3W7wPZ5zlEa5+xk/XHzR0o7qPUMCdrmwn3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284641; c=relaxed/simple;
	bh=x4UyYYR8+iwWvMg2BIGbPYGIypU602o9uURawY09SJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uZwRFHXn9ao4RvVgdNXkFMFIxLnmNsilF4TjlNUGGH8pTx1gyKjluRcxDwhnQWbX/JLjtRu/ARJ/uRqBazI5ZzZYDQlZ6wy7tNF3S0pi/AREz1CcWW0fUI1VG/JfVu2iLW0j6+1VtanTzOMBoNFmjZEZilNsqRyrgo1VGetjE40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT2AWrtU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT2AWrtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07EFC4CEF7;
	Mon, 23 Mar 2026 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774284641;
	bh=x4UyYYR8+iwWvMg2BIGbPYGIypU602o9uURawY09SJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JT2AWrtUMFhsc4V1mxvSKjOPzLB1zrksvFEvxUyI1nlFCGlSNmetXtLJWDaF08iZ8
	 NEl0PGvOzh3rVmyg9rOXffF7W4mVtsYyGrAdWWJDJL7Hf/lw/FQSZISZacn1IPmvSz
	 G9GIDcnc2pl/nU05DQ+568cLPp10/4ylp1cDlZu9Jpl+aV6P0Wcv9qk9UZub6HYTN/
	 hj7kI6PPgpN3tg6bf+YPBa4JVjSxpQ5ax+xn/cZZGPM7+z7trSG8jg8h+pmMK2OSRg
	 pwSHsRN+40nsF4RR5P3T9X/JwRC1fkADBHBOuKQCYcH0HiDVWci2hinsV8apGLspUL
	 cTBZN7kLu3k9g==
Date: Mon, 23 Mar 2026 11:50:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Maciej Grochowski <mx2pg@pm.me>,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: Re: [PATCH] Documentation: PCI: Document decoding of TLP Header in
 AER messages
Message-ID: <20260323165038.GA830530@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf826c41b4c1d255c7dcb16e266b52f774d944ed.1774246067.git.lukas@wunner.de>

On Mon, Mar 23, 2026 at 07:52:39AM +0100, Lukas Wunner wrote:
> The prefix/header of the TLP that caused an error is recorded by the Root
> Complex and emitted to the kernel log in raw hex format.  Document the
> existence and usage of tlp-tool, which allows decoding the TLP Header
> into human-readable form.
> 
> The TLP Header hints at the root cause of an error, yet is often ignored
> because of its seeming opaqueness.  Instead, PCIe errors are frequently
> worked around by a change in the kernel without fully understanding the
> actual source of the problem.  With more documentation on available tools
> we'll hopefully come up with better solutions.
> 
> There are also wireshark dissectors for TLPs, but it seems they expect a
> complete TLP, not just the header, and they cannot grok the hex format
> emitted by the kernel directly.  tlp-tool appears to be the most cut and
> dried solution out there.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Maciej Grochowski <mx2pg@pm.me>

Applied to pci/for-linus for v7.0, thanks!

I tweaked the commit log to note that the Header Log is in the AER
Capability, which may be in any PCIe function.

> ---
> We could also go one step further and point users to this tool
> in a printk_once() message when the first error occurs.
> For now, just amending the documentation is probably sufficient.
> 
>  Documentation/PCI/pcieaer-howto.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 3210c47..90fdfdd 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -85,6 +85,16 @@ In the example, 'Requester ID' means the ID of the device that sent
>  the error message to the Root Port. Please refer to PCIe specs for other
>  fields.
>  
> +The 'TLP Header' is the prefix/header of the TLP that caused the error
> +in raw hex format. To decode the TLP Header into human-readable form
> +one may use tlp-tool:
> +
> +https://github.com/mmpg-x86/tlp-tool
> +
> +Example usage::
> +
> +  curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --aer
> +
>  AER Ratelimits
>  --------------
>  
> -- 
> 2.51.0
> 
