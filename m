Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6083F0AB0;
	Fri,  1 May 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654112; cv=none; b=JDWJlOMHpNoo62T055uBPYe5yHnxNLQju/B532WFJwxHlG57F6d8zptGr08eyTQV+evBKDkzUtWxSvwdhtne1Pu2YVNh6ngR/8gkSuAZwLoYTrKJ73NJqRiPGnMTNHtlJmNqMeRJyxS3mbcJQk4VfQhFmIEJnZQ46kxPXUcwzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654112; c=relaxed/simple;
	bh=AWm5k5rh61c8sKLm/bJ/DwjxxxfErE0vjMIsl1WJGZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QehB9pHTCvlVbP4w22OIY59SG3Iy2SdnwZ/MDkvQWSmjTscKgkJEtilKlxvMPMwjkP5teI1wEcOeb9/vUSwmfWYze+A9ecmPcjIBEx/qBbjfkilVkPtGsfRyjwQ1K4ii0eNqX2vCjeGB+4Ggenne5fq5ivQ4r+NzitjAAlUHAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtbMc8WP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtbMc8WP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294D1C2BCC4;
	Fri,  1 May 2026 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777654111;
	bh=AWm5k5rh61c8sKLm/bJ/DwjxxxfErE0vjMIsl1WJGZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CtbMc8WPNwDkH6/w15y7nRb2KmHvbc7kk0s0FYg/ocfwUlDQzcNK+LIlANXpEGrED
	 cKqKUySfiRd8ClEZeUyvG9qXyRS8Kr1UyX2BNWFEgvBENizmC9+dg8KWdw6a+NSVoH
	 EzqlYeDb0C3lEbkQICIgsMf7BmHL6ru7D83eesWzLQvPxJexl64qcqozfOM1LeHGBY
	 HMzRGVeLaGTeJn4Y2ZDKydcwYL+e5AR3amOElaVMgWOvGvVmFU5pOS628K7btkGsCK
	 Bbe+nXJlpjE1SK72dUvdZ2vgjGm6wVaIQ1p5d3GRwXVKpZj+T8bKcs33GaumQ8Yy4Q
	 cwLEb5hW8lJEA==
Date: Fri, 1 May 2026 11:48:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org, vigneshr@ti.com,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: dwc: designware-plat: Use common mode field in
 struct dw_pcie
Message-ID: <20260501164219.GA490400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501161010.71688-1-18255117159@163.com>

[cc: xrobh->robh@kernel.org]

On Sat, May 02, 2026 at 12:10:06AM +0800, Hans Zhang wrote:
> Several DesignWare PCIe controller drivers (dra7xx, artpec6,
> designware-plat, and keembay) duplicated the device mode field
> in their private structures, while struct dw_pcie already contains
> this field. This led to:
> 1. Data redundancy and potential inconsistencies
> 2. Increased maintenance complexity
> 3. Error-prone device type checks
> 
> This series fixes these issues by:
> - Removing redundant mode fields from all four drivers
> - Standardizing on dw_pcie->mode for device type detection
> - Simplifying conditional logic in probe/suspend/resume paths
> - Ensuring consistent error reporting
> 
> The changes improve code maintainability and eliminate class of bugs
> related to mode synchronization.
> 
> Hans Zhang (4):
>   PCI: dra7xx: Use common mode field in struct dw_pcie
>   PCI: artpec6: Use common mode field in struct dw_pcie
>   PCI: dwc: Use common mode field in struct dw_pcie
>   PCI: keembay: Use common mode field in struct dw_pcie
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c           | 11 +++++------
>  drivers/pci/controller/dwc/pcie-artpec6.c         |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  7 +++----
>  drivers/pci/controller/dwc/pcie-keembay.c         |  9 ++++-----
>  4 files changed, 16 insertions(+), 20 deletions(-)

Thanks for doing this!

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
