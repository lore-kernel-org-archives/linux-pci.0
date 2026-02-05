Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404523D7D4
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278660; cv=none; b=Cq/E6v0RjBGnNZxQ8oLBISIK+B5X4zfNWkLTNSR/77rItFI/IpH4dscIKiJTiOZ3ISIUgLpqLVk51yWedn2AfLrsUC475Ebohv/R+AFmH/1+aawEj/XcvvLprx5Uy3WYQ9Mfx2Kz3k+rG5lR7QGw0+zQaB0SYk6f0JzYnDp0w48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278660; c=relaxed/simple;
	bh=NuTnfWMLkaNnCn9Wm6xJ2kv52vSP7Fh8/WQg/2+3wCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeeIeK34N/W6LJ8M3U61FHrHXCRlQMVsP/0cmemdbz9JCR/serbLSDbSm1yHiVfET4g4lnCJA7tjwsazC1nyd3vvkATOljMCc+ibvEdBsCzpmzXsPAj5g0WjdhcnLg9ScVX5+A5k07hIZzwY4Ku3hlDeNXjpjdCyFYD/S6D7DKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY3PHzoO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY3PHzoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06406C4CEF7;
	Thu,  5 Feb 2026 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770278660;
	bh=NuTnfWMLkaNnCn9Wm6xJ2kv52vSP7Fh8/WQg/2+3wCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AY3PHzoOGgpTxoNe4O/XaR4423LEYLME0QXk0kqxHV1syhL8xG1IMUhbEkc/m0Jz9
	 Bmv1Vb9V5PX33XRw+TCWGIZvmaHLk7dHksmyYuyomoYF9auKQD7UBQuvCPY8Z8Jg4K
	 y4EYEM/k3mePlRe6gTx+qdzlpokoFcQDNxwKY93yIL3qb2hUbuaEXcS/RFUP2Tg337
	 QHgI2+YfMz1l/Xj28yTZYHveuvEaIfHoE3TYQZ7Q8oPhPlGva5O8k2hPjTU2PLdrxN
	 Nl8yQPRTuUNEP8VONXQTfKdNHLd+DMLEpVK7zDYmePyu5hN23KrSXVlOnjWl/L1Y3/
	 nf0amaD8mYetA==
Date: Thu, 5 Feb 2026 09:04:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI: dwc: Clean up iATU index mess
Message-ID: <aYRO_vQW6d_UfIZE@ryzen>
References: <20260127151038.1484881-5-cassel@kernel.org>
 <zdxpiisnc4eq5a26dlaelchri3vu4aoyndy2pnif2rotbiyj72@c3hbnd3cwubz>
 <aYCc1GpSr4k2HdHJ@ryzen>
 <alpine.DEB.2.21.2602041606040.12532@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2602041606040.12532@angie.orcam.me.uk>

On Wed, Feb 04, 2026 at 04:13:05PM +0000, Maciej W. Rozycki wrote:
> On Mon, 2 Feb 2026, Niklas Cassel wrote:
> 
> > > Series looks good to me. However, I'd prefer waiting for Maciej's testing before
> > > merging.
> > 
> > Maciej,
> > 
> > Any chance to get a Tested-by?
> > 
> > 6.19-rc8 is already out.
> > 
> > Even if they are fixes, it would be nice if it they could make it for 7.0.
> 
>  Hectic time here.  I've verified it now using the system I've originally 
> encountered the regression with.  No significant change in the kernel log 
> compared to the previous fix by Krishna, except for different IRQ numbers 
> assigned to devices (but that I reckon could be something else present in 
> the pci tree that isn't there in Linus's master), and the system seems to 
> boot correctly, so I do hope all is in order.

Thank you for testing!

Considering that it is fixes, I suggest that we queue it up for 6.20 / 7.0,
even though it will not have time to be in linux-next for a week.

(The requirement to spend time in linux-next is for new stuff, not for fixes.)


Kind regards,
Niklas
