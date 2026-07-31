Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F87230BD5;
	Fri, 31 Jul 2026 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785457665; cv=none; b=GDsXZpwOncYG5a8BOSzOTQkmLqJcWEl1gRYNZ63FkKYcl4nBzu2uMzyVECB0yyo6MsfhbWdCMilsKupt3m1BN885tan82JEwTnAo5yq3YkO0Q81Pgiil7PDT2OklngHYZRNa3DmNG25C+DJs41sQXoEKkJoJt55jXlwLd5h67VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785457665; c=relaxed/simple;
	bh=Cmdkxx8Tvqi6AfbXARhoToWzOXGwiRfO0uNLZSJcyY0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kQbb3jrlwQOe4BRwQpkgjuXIYGSgndD8yTLGIYTWLB+BAeZJfh7ajiXlnJjfi01bQmZ0T+uKPQU5XRljdZ9Y0m/4tP0U7XZn9l87MC7GlHcqmuQScWA087rL7RAkSB4RrcgDahFboYZhleocQnW2eJIWQVFUoGMeEMHD4zPG6GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYujkoDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYujkoDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6457F1F000E9;
	Fri, 31 Jul 2026 00:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785457663;
	bh=DjRBdz6eLeyZuRCAsZjy9VjYTZ19f2hOiJFXB10LjwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BYujkoDIdrRlWAe1bQ9RVU9Yi7PbSUgnbvbUfBpwafQoJTTmIKbBN2uIhjpm6YDaZ
	 qJs7J00sz4Be4aHEKAYJnZNlC9AomPPsz3MA8vNViCWteeo+5MJLzg+z2ODZKC0YIc
	 fifJBDD8f2a1nwzrWfvcTp4pSW3MAvV4LNbsYaPS2pMCaVOJi8vO+CmOEZ3M2JoCtZ
	 vue9TulMC47Gxw8TMua1IJuS4hF8sUU89URzvgo4mZ1Qw+aZK/e6p0lPnjCkrj83YH
	 CKKVag5RXvp39diSnHwDaXP9Y6yX2wj3YMIdmfMc/g1eoZ52yqTciHOqqsJsfh68CK
	 8RwthDm9Pm+OA==
Date: Thu, 30 Jul 2026 19:27:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, Takuma Fujiwara <t-fujiwara1@ti.com>,
	Hans Zhang <18255117159@163.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: linux-next: Tree for Jul 30 (pci/controller/cadence/)
Message-ID: <20260731002742.GA1538321@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589ea512-93c6-4e1c-83d7-ba45a0b35843@infradead.org>

[+cc authors of everything on pci/controller/cadence; I haven't
triaged this at all, sorry, and don't have time right now to drop that
branch from pci/next]

On Thu, Jul 30, 2026 at 04:06:44PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/30/26 8:02 AM, Mark Brown wrote:
> > Hi all,
> > 
> > Changes since 20260729:
> > 
> 
> (1) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
> pcie-cadence-plat.c:(.text+0x2f8): undefined reference to `cdns_pcie_ep_setup'
> 
> In this case, a builtin driver attempts to call into a loadable module:
> 
> #
> # Cadence-based PCIe controllers
> #
> CONFIG_PCIE_CADENCE=y
> # CONFIG_PCIE_CADENCE_DEBUGFS is not set
> CONFIG_PCIE_CADENCE_HOST=y
> CONFIG_PCIE_CADENCE_EP=m
> CONFIG_PCIE_CADENCE_PLAT=y
> CONFIG_PCIE_CADENCE_PLAT_HOST=y
> CONFIG_PCIE_CADENCE_PLAT_EP=m
> # end of Cadence-based PCIe controllers
> 
> (2) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
> pcie-cadence-plat.c:(.text+0x11f): undefined reference to `cdns_pcie_host_setup'
> 
> 
> This is similar, just a different driver is =m in the failure case.
> 
> #
> # Cadence-based PCIe controllers
> #
> CONFIG_PCIE_CADENCE=y
> CONFIG_PCIE_CADENCE_DEBUGFS=y
> CONFIG_PCIE_CADENCE_HOST=m
> CONFIG_PCIE_CADENCE_EP=y
> CONFIG_PCIE_CADENCE_PLAT=y
> CONFIG_PCIE_CADENCE_PLAT_HOST=m
> CONFIG_PCIE_CADENCE_PLAT_EP=y
> 
> 
> -- 
> ~Randy
> 
