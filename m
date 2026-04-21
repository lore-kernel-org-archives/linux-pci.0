Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C56267B07;
	Tue, 21 Apr 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788903; cv=none; b=MzFXLi3bCLB9ioMr8lQu6BfN8zTBMFNf1sgA8144koArA00blgaeI0BZdx0wgNi30s6RXRjL4SfB2avrDY4E7gkRxQhX4Q//R/L3xETSfOGWQ0mEzdiV23vtOulBytIMSgOrqPM6eYugWIjciMjZqq4HrP505a9XjBNwepe8uuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788903; c=relaxed/simple;
	bh=libOIreDVRzbLVL5mQooynMBCBKvM25f8kwKy51rcs4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xci2hF4XNgfdty0eW90GZ0PbcNDtGLXtOnIcyG/lcMwWrBYQE80Avjdb/1h0sLE5bCnaC7FlASmJs/Cfrp2oBFCu3wtH1Ee/WffhtOwXxdu17i5+TwcHtNng6VtYQUn44xcSxHzFpNIpH25X64NXLLm+FvgwuvXaWAWY9quG3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJOmWFZU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJOmWFZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88524C2BCB0;
	Tue, 21 Apr 2026 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776788903;
	bh=libOIreDVRzbLVL5mQooynMBCBKvM25f8kwKy51rcs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GJOmWFZUzPomxZ1veWsM6GU2cTSD6/j1eMJjDyo2wTYwD4y3/InqaUbXcn3J/E51s
	 IjP4lLrTcWE/bDCy64PnJiK+6p8Fdhc+zyab1jV0wdmhRyJFrMO77Yk8/2tX520lFc
	 4GdqJekDIInX4EzlJIem0FV9n3czqfYxsgm6VdZ4y/sepjZlxp3hvHNNEsj9nimQo4
	 goV23cSLWc65A6p+iqFm3Vg9Bk3USJ4iFH+xfcrTLq4dry5Aa6bsRiaWtzbIQOxpR8
	 LLj79bAU/EPiIvpKNSUonHKpl2667OPnJnzI3lz2oqwbvXB+PyelvY+2M1ZdrJSxQN
	 zMBieLpdofWiQ==
Date: Tue, 21 Apr 2026 11:28:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: josh ziegler <joshziegler76@gmail.com>
Cc: bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: fix typos in Documentation/PCI/
Message-ID: <20260421162822.GA286561@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421012059.251492-1-joshziegler76@gmail.com>

On Mon, Apr 20, 2026 at 09:20:59PM -0400, josh ziegler wrote:
> Fix "chose" -> "choose" in pci.rst
> Fix "result an" -> "result in an" in pciebus-howto.rst
> 
> Signed-off-by: josh ziegler <joshziegler76@gmail.com>

Applied with Randy's ack to pci/misc for v7.2, thanks!

Updated subject line to match local history:

  Documentation: PCI: Fix typos

> ---
>  Documentation/PCI/pci.rst           | 2 +-
>  Documentation/PCI/pciebus-howto.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index f4d2662871ab..be35e9a1ee75 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -338,7 +338,7 @@ the PCI_IRQ_MSI and PCI_IRQ_MSIX flags will fail, so try to always
>  specify PCI_IRQ_INTX as well.
>  
>  Drivers that have different interrupt handlers for MSI/MSI-X and
> -legacy INTx should chose the right one based on the msi_enabled
> +legacy INTx should choose the right one based on the msi_enabled
>  and msix_enabled flags in the pci_dev structure after calling
>  pci_alloc_irq_vectors.
>  
> diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
> index 375d9ce171f6..9cc133ccdeec 100644
> --- a/Documentation/PCI/pciebus-howto.rst
> +++ b/Documentation/PCI/pciebus-howto.rst
> @@ -97,7 +97,7 @@ register its service with the PCI Express Port Bus driver (see
>  section 5.2.1 & 5.2.2). It is important that a service driver
>  initializes the pcie_port_service_driver data structure, included in
>  header file /include/linux/pcieport_if.h, before calling these APIs.
> -Failure to do so will result an identity mismatch, which prevents
> +Failure to do so will result in an identity mismatch, which prevents
>  the PCI Express Port Bus driver from loading a service driver.
>  
>  pcie_port_service_register
> -- 
> 2.43.0
> 
