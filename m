Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809643C9454
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092169; cv=none; b=Wo9QDL/2AoNs+L9/BaeFyQTvKqZSAMxn/VU0zqfBlxhQTSOnQjBUCBdhTkTJ3rKfD3cXzvEu8fbC9/LC15iJxjOixgQsbFe2Phn3bVYYBT5R/FaE4TeZlaZsMWPJfIQaw1DmDkVurpIDT5wi3mxAh0kJu6EJGlKyWpGp9SRugkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092169; c=relaxed/simple;
	bh=lT+bbTM3sJV9/H1zEBnOzkPlndZz0ktx7MU6tKySAXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7BIhw/GIrRMcTRhqnNFxawbyomfdMV1vc1wJSICod3JbgqV1ty0GP6USt4cLii27kDEtTpBI2/az4maexRR2TJT/h7+pzJBL6Yd1d1imzoYIGVLCL8U8PYQyg1sr1fohEjvUKJjenUX/lSXki9vomBlTBtbktlJ9s3atZ6sWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7zHhNRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7zHhNRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54101F000FF;
	Tue, 22 Sep 2026 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092168;
	bh=X9CHSdRLDDAZJoybKw7ZLa2vsdiTZUlx0toVQ1xmYnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B7zHhNRAV3HeCPnUUXrNU+1VsegBrFT8UwnOdkcubgUJCbmKiYLhb2l4uzdJtHMEf
	 bNty4/zy8QbdlK1AViMFG0zQ1G+BVwIHNp2EWI5/RnT9qSrwbP54gQFwnUi80xUDd7
	 tProd7/MLIJgolU3evz6yyj45obt6mwofgOObOsyJELQcEWJ54XyKSVjIiM9gaX4Jw
	 nq08TmzKksHw81uww2kGgVrIraMXlR2Lm4Z4lfZwRW7gDY3+MI3yUI1rXcqq5SOM8E
	 lDvbFPd0Pdh5JqwfZBqPpjfTGHGTjurhlSyTEl6wPejjD9ysQoYEMnItmsr4J3VPPy
	 pwWP5C1KTTZUw==
Date: Tue, 22 Sep 2026 17:49:20 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: helgaas@kernel.org, nirmal.patel@linux.intel.com, djbw@kernel.org, 
	linux-pci@vger.kernel.org, lukas@wunner.de, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 0/8] VMD add second root bus support
Message-ID: <hfbfem5jyufk7r7dulo6kny73xkii3lhtafbaxdjds54u2o4qh@voxvd47qtvti>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>

On Mon, Sep 21, 2026 at 04:43:06PM +0000, Szymon Durawa wrote:
> This series adds support for a second VMD root bus.
> 
> Today the VMD driver can enumerate and manage devices only behind the
> first VMD root bus. Starting with Intel Arrow Lake, VMD may expose a
> second root bus (BUS1), and devices behind that bus are not discovered
> by the current driver.
> 
> The hardware model for Intel Arrow Lake VMD is slightly different
> from earlier VMD generations:
> 
> - CFGBAR, MEMBAR1, and MEMBAR2 are shared by both VMD root buses.
> - BUS1 uses a fixed primary bus number in hardware.
> - Interrupt handling remains based on the existing VMD MSI/MSI-X and
>   irq_domain model; this series does not introduce a separate interrupt
>   domain for BUS1.
> 
> To support that layout, the series first refactors the current code so
> resource setup, bus creation, and enumeration are split into helpers.
> It then partitions the shared CFGBAR/MEMBAR apertures between BUS0 and
> BUS1, creates a second root bus, and adds a VMD-specific workaround for
> the fixed BUS1 primary bus number so PCI core bridge scanning does not
> reassign BUS1 and lose subordinate device discovery.
> 
> Patch overview:
> 
> - Patches 1-4 extract helper functions for bus enumeration, CFGBAR and
>   MEMBAR configuration, and root-bus creation.
> - Patch 5 replaces hardcoded resource indices and constants with enums
>   and defines.
> - Patch 6 converts single-bus state into per-root-bus arrays.
> - Patch 7 adds BUS1 resource partitioning and second-root-bus support.
> - Patch 8 keeps the BUS1 root bus number aligned with the hardware-fixed
>   primary bus number so PCI core bridge scanning does not reconfigure it
>   and lose BUS1 subordinate enumeration.
> 
> Tested on an Arrow Lake platform with NVMe devices present behind both
> VMD root buses. With the series applied, devices behind BUS0 and BUS1
> are enumerated and become visible to the kernel. Without patch 8,
> devices behind BUS1 are not discovered.
> 

./scripts/get_maintainer.pl drivers/pci/controller/vmd.c
Nirmal Patel <nirmal.patel@linux.intel.com> (maintainer:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
Jonathan Derrick <jonathan.derrick@linux.dev> (reviewer:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
Lorenzo Pieralisi <lpieralisi@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
"Krzysztof Wilczyński" <kwilczynski@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Manivannan Sadhasivam <mani@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Rob Herring <robh@kernel.org> (reviewer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Bjorn Helgaas <bhelgaas@google.com> (maintainer:PCI SUBSYSTEM)
linux-pci@vger.kernel.org (open list:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
linux-kernel@vger.kernel.org (open list)

For some reason, VMD patch submitters are keep forgetting to CC relevant
maintianers/reviewers.

Anyhow, I'd need a review from either Nirmal or Jonathan.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
