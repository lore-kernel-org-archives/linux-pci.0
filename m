Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34473B840E;
	Wed, 15 Jul 2026 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101477; cv=none; b=DDZsY/yOZzHdpuSsbolY1KK7mBnuO/l7pCgzqIxAKEzrocRKXDXqODZBmHxgDMixIZYjOBKQt5CC9zrGSRhnrz+Pfc0m2YMuTdYRUiqEcavCjtv+qxn2e3BQ569h+1RiIxY7ULzOGDqXMR+9FKPZ8IpiHyYvz+k0dYTV2Fq2P5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101477; c=relaxed/simple;
	bh=UdQma2hTkdoPGNuuyWFOD/sUrfqi5btc69f3eudvtyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zd7rakJHaSiE/TYeDZeiUVscLzpze6vXHMGASqB9TQR2nD8/QLLIoYnh5ZIYMipDPQ4Qlj7LuMVRxfamU6bktgsexRulc5fUkn5KJkmzLA5sjw7zqF8Zo5/KrPcAkOxax6dSU4nwTBjPvl9nY+eJw+Q/s+o1rOArvvGKUEwTpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbaxCwwQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbaxCwwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8441F000E9;
	Wed, 15 Jul 2026 07:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784101475;
	bh=MXacSfVESMbBM4Km6XTpIUSK+nBYKaMgTrWivCXMIGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hbaxCwwQaqHLOp/Kee/FS6zAt8h3JJUDlsMQ4IoajYzkk4/w8t9aoyrm87le60WrA
	 EaG2lYQS+qn+MVdou3tsRGFeniWp7UrZCVwU6EHEW/jAl3dW6rR55lqZgSjdIhSOW/
	 Re82y6o/pK0XLpECicrH+WxBAzfDksfKUGaXJhLVRVneQvf3zMPA+xTj0LpnOB9J4Q
	 azU76dxr73W2th7nt6Kkf4kYrV/pO3Xusl2heTQYbmp2qC9o19gAQSiB07DBpRGuCl
	 +AeW0gVZJFegz+L+V6fbMv7JDocNqPxsBGleqY1v2FJE4+qUFhrYPh1vjzR+bfJK2T
	 o0/j9ovvbYzCQ==
Date: Wed, 15 Jul 2026 09:44:29 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM status
Message-ID: <rrf3bid5g7hsaigimjy6d5i5sv63n6af3sriksfx7tyymg6fqz@a6vsjz6zrthr>
References: <20260701073513.1101559-1-18255117159@163.com>
 <20260701073513.1101559-3-18255117159@163.com>
 <20260701074818.E3F291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701074818.E3F291F000E9@smtp.kernel.org>

On Wed, Jul 01, 2026 at 07:48:18AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Modpost link error when building Cadence drivers as modules due to an orphaned debugfs object.
> --
> 
> commit 98a72e00615e702fb5448b12d14570527e38b67f
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: cadence: Add HPA IP debugfs for LTSSM status
> 
> This commit adds debugfs support for HPA-based Cadence PCIe controllers,
> exposing the current LTSSM state through a new ltssm_status file.
> 
> > diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> > index b8ec1cecfaa88..2cdc4617e0c20 100644
> > --- a/drivers/pci/controller/cadence/Makefile
> > +++ b/drivers/pci/controller/cadence/Makefile
> > @@ -4,6 +4,7 @@ pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-c
> >  pcie-cadence-ep-mod-y := pcie-cadence-ep.o
> >  
> >  obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
> > +obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
> 
> [Severity: Low]
> Will this cause a link error during modpost when building the Cadence drivers
> as modules? 
> 
> Since CONFIG_PCIE_CADENCE_DEBUGFS is a boolean, this adds the object directly
> to obj-y instead of appending it to a composite module target like
> pcie-cadence-mod-y. When the driver is configured as a module (e.g.,
> CONFIG_PCIE_CADENCE=m), the object is compiled but left unlinked.
> 
> Could this lead to undefined symbol errors for cdns_pcie_debugfs_init and
> cdns_pcie_debugfs_deinit in the caller modules?
> 

This is a real concern. So I fixed the Makefile with below change while
applying:

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index b8ec1cecfaa8..80be0b885ac8 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 pcie-cadence-mod-y := pcie-cadence-hpa.o pcie-cadence.o
+pcie-cadence-mod-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
 pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-cadence-host-hpa.o
 pcie-cadence-ep-mod-y := pcie-cadence-ep.o

This will ensure that the debugfs functions are always built into the
'pcie-cadence-mod*' object.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
