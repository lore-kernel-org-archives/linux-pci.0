Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC834A790;
	Mon, 26 Jan 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449149; cv=none; b=DNb4eAUE6Cqb9tFphU9eAhlCMyxn17lVlIlGzSIMu2p39ob+r73LUyn4QDPbTLo8RLdZxjZlIfC5p2DP+Z7czc9qN+h2PIkxHZCN0va7z7HI9YVxz9/3u50UbQgZgLbLyRiB5S4wnRIun+YOk8C/SLf9cZEWEgCJvDYyXMMChl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449149; c=relaxed/simple;
	bh=NeDoYa+HOJiHi8fHVjfIGdxbkdi4N2D8ECip9nqLlWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jYn931YTJ8zKaJMJxGqOKKNeZpxRfqmc0yF97sQfqQh4aijyqztNeGQP92VvyYQeg0fxwIN6Tlb07ysm/GCrHxyo8X3qGZflrSWek5ISQHJpUfkMV5xYDBdmhj2aEsvy3Lk91UTrP5ra74cOmsyS3os+Bz0bGZObjA1XTilfEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH/ryVB/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH/ryVB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E194C116C6;
	Mon, 26 Jan 2026 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769449148;
	bh=NeDoYa+HOJiHi8fHVjfIGdxbkdi4N2D8ECip9nqLlWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FH/ryVB/zYIfJWV1ko4wo+EGsUooLZtlML2OxF8H7eQLHLP34IQxOjjSAR/TUm4Fz
	 6bQJupDtoyZMhw7aA3St1AK4zfJaSFlh9aGqDtRZUl5qyeYoCLrEYJ9shjzgNrgx9o
	 3sCk/cPvHb/a49DvKrFeiRpidC8ZZbm2igioF6ay6TXNRxHqWltt0fA6r5pgv+uUm3
	 h6lbxVWVR5iUdXqB2+rLW6ibJtPePwlGM4A6Y+/kfz34K/oimUwfLF3ZcFZsRBwxzB
	 toy2razAy9sE0gb2YYAwaa6gjBKsctZ36x8oXHztzP1o+cylMEOHyAk0AsIklpEPxB
	 YKibKrsRq5M0g==
Date: Mon, 26 Jan 2026 11:39:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] PCI: Resource code fixes (supercedes earlier
 series) & cleanups
Message-ID: <20260126173907.GA275525@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>

On Fri, Dec 19, 2025 at 07:40:13PM +0200, Ilpo Järvinen wrote:
> Hi all,
> 
> Here's the resource code fixes and cleanups series. The 6 patches (the
> first 5 + 1 cleanup) have been submitted earlier (not yet applied, I've
> closed the patchwork entries for them) but due to a number conflicts
> that could easily ensue if these are applied independently, I had to
> put all these into the same series.
> 
> The series consists of:
> 
> 1. The first 5 are the most important changes as they relate to
>    regressions. These may case shrinkage of bridge windows that
>    previous had surplus space beyond the HP reservation size (due to
>    sizes inherited from FW). In some HP scenarios the smaller bridge
>    window could cause a regression, but this seems a case the pci=hpmm*
>    parameters are meant to address.
> 
> 2. Followed by cleanups (no functional change intended, excluding the
>    extra debug logging added).
> 
> 3. Introduction of pbus_mem_size_optional() to avoid the need to handle
>    optional resource in a deeply nested loop (rebar awareness changes
>    will have to add some code there). Doing all optional calculations
>    in one place feels more logical and consistent anyway. There's a
>    minor functional change in this change related to bridge windows
>    with only optional resources (I don't expect issues because of it).
> 
> 4. Separating CardBus bridge setup code to own file + compile it only
>    when CONFIG_CARDBUS is set (I'd have wanted to send this separately
>    but it seems impractical given that I need to rename the
>    pci_dev_resource handling functions when exposing them to another
>    file).
> 
> Any comments are welcome.
> 
> 
> Ilpo Järvinen (23):
>   PCI: Fix bridge window alignment with optional resources
>   PCI: Rewrite bridge window head alignment function
>   PCI: Stop over-estimating bridge window size
>   resource: Increase MAX_IORES_LEVEL to 8
>   PCI: Remove old_size limit from bridge window sizing
>   PCI: Push realloc check into pbus_size_mem()
>   PCI: Pass bridge window resource to pbus_size_mem()
>   PCI: Use res_to_dev_res() in reassign_resources_sorted()
>   PCI: Fetch dev_res to local var in __assign_resources_sorted()
>   PCI: Add pci_resource_is_bridge_win()
>   PCI: Log reset and restore of resources
>   PCI: Check invalid align earlier in pbus_size_mem()
>   PCI: Add pbus_mem_size_optional() to handle optional sizes
>   resource: Mark res given to resource_assigned() as const
>   PCI: Use resource_assigned() in setup-bus.c algorithm
>   PCI: Properly prefix struct pci_dev_resource handling functions
>   PCI: Separate cardbus setup & build it only with CONFIG_CARDBUS
>   PCI: Handle CardBus specific params in setup-cardbus.c
>   PCI: Use scnprintf() instead of sprintf()
>   PCI: Add Bus Number + Secondary Latency Timer as dword fields
>   PCI: Convert to use Bus Number field defines
>   PCI: Add pbus_validate_busn() for Bus Number validation
>   PCI: Move scanbus bridge scanning to setup-cardbus.c
> 
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/pci-sysfs.c       |   2 +-
>  drivers/pci/pci.c             |  14 +-
>  drivers/pci/pci.h             |  49 ++-
>  drivers/pci/probe.c           | 128 +++----
>  drivers/pci/setup-bus.c       | 644 ++++++++++++----------------------
>  drivers/pci/setup-cardbus.c   | 306 ++++++++++++++++
>  drivers/pci/setup-res.c       |   2 +-
>  drivers/pcmcia/yenta_socket.c |   2 +-
>  include/linux/ioport.h        |   2 +-
>  include/linux/pci.h           |   6 +-
>  include/uapi/linux/pci_regs.h |   5 +
>  kernel/resource.c             |   2 +-
>  13 files changed, 648 insertions(+), 515 deletions(-)
>  create mode 100644 drivers/pci/setup-cardbus.c

Sorry I missed this earlier.  I put these on pci/resource, hoping we
can still make it for v6.20 since we have an extra week in the cycle
(two weeks left until v6.19 final).
