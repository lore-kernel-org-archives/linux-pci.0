Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA5296BD2;
	Thu, 12 Feb 2026 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931711; cv=none; b=fY1oGLiJ4k9o8UTsZbWkOAot9iBHZdB72v4Lx07WH6rL241J71UJC8+9oWAbaT2c7FYONzUPWIqUkNafl2/Rx8jBPBVO7XmpjOYSJmN+0w5IbHyQNXkmDvUp/lo/jHSiVxeid1UJ/wDlXomZD7pTvOvkFTY3aYcEydUEcIH0DIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931711; c=relaxed/simple;
	bh=nWO5M2vv7U2eAIVGBCR1C5NnOXPoJqeq0K9YOO8fig0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c1X6upWbAQN1hPIam37kxcM/1krLoJf61bZQwm/p6o1t7qsEIUHTM3wiV76B9YFk/Nvps2wU/W81KUhFwrVQxhdhk0P87yXvyjakZosn8lH89ejndcxptz+CMUkxTjIpdTDn7q7E6FoDVh9AUbUjgMMfyrx77KGpfkhkYwPlZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcDdt4NT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcDdt4NT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00E4C4CEF7;
	Thu, 12 Feb 2026 21:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770931711;
	bh=nWO5M2vv7U2eAIVGBCR1C5NnOXPoJqeq0K9YOO8fig0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AcDdt4NTlLiWV2mXwYeRt3NS63f7ocw/xMCpeIiI8UBIB3EvyAGmBRFED3LqMafkD
	 tK4l+umApR53ogu4fLsceGz9GmFY0bXyH1OxJvZw3WiPujth+zt+ayADSaaFn0sE7E
	 2Js26LpLbYMcTeQeh30rcmBcAPkC4xSVDcq8aebNAGCxZDcJ3IAvLZgI8o1kYdzlOl
	 f+PYLkYsIBCOo2HkmB1zkRt3cIhynlHlvAe66MRMOxm1e3VFA+CnkpvlvWlDaqeDIY
	 CAguM3ucGN5dEA4Sz74YXnnvgNM9QIb6+rg3oF5jGHWt9OCh0muA7Sl1tc2vABHC0X
	 rTre973bgoPDA==
Date: Thu, 12 Feb 2026 15:28:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH v2 0/3] Clarify pci_free_irq_vectors() usage constraints
Message-ID: <20260212212829.GA3089824@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1770798299-202288-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Feb 11, 2026 at 04:24:56PM +0800, Shawn Lin wrote:
> pcim_enable_device() automatically manages IRQ vectors, which can cause
> double-free issues if drivers manually call pci_free_irq_vectors().
> 
> This series adds documentation and warnings to prevent this:
> 1. msi-howto.rst guidance
> 2. kernel-doc warning
> 3. TODO comment for future cleanup
> 
> 
> Changes in v2:
> - rework the commit message and documentation
> 
> Shawn Lin (3):
>   Documentation: PCI: Clarify pci_free_irq_vectors() usage for managed
>     devices
>   PCI/MSI: Add warning to pci_free_irq_vectors() documentation
>   PCI/MSI: Add TODO comment about legacy pcim_enable_device()
>     side-effect
> 
>  Documentation/PCI/msi-howto.rst |  7 +++++--
>  drivers/pci/msi/api.c           |  5 +++++
>  drivers/pci/msi/msi.c           | 10 ++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)

Squashed the first two patches and applied to pci/msi for v7.1,
thanks!

This will be rebased to v7.0-rc1 after it is tagged.
