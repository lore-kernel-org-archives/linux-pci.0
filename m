Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF936EA99;
	Fri, 31 Jul 2026 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534106; cv=none; b=IL3trbBSCEEAQj5S3buVuuFQXrcxTs9vxp918SoAfUghGlVd6vCqEaxdFIKn/dlmqnC8nJxcfnLXZvAhUiV5Ck4WDvTRCpg2XkglXM/8F4QyjIQZ2FetAsbu+h3Uw42D9+eK7elimy+zXafcGrskK+Yd0Ex3BsLDOqxdwmjIeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534106; c=relaxed/simple;
	bh=YNgCBdXPlRiNptTjWsEecFhkyztCKu86KWZVRqqypZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IUehry/yMyYaU6PG/BODrZkTl4GS6UmBQUz11ftV/dONifs51HGiH3NVut9RunNOqA8NIPnEmQpi1HO6HtMHuW0ZVLZVB93UXD6xQBFAl43wORc1H3Yg+297Z+WpxaiRRzcXYcU7lo4xddAs9iTZ0fA09EFqyn/vutv8MLUAssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM4FnJGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM4FnJGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E921F00ACA;
	Fri, 31 Jul 2026 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785534104;
	bh=KwhAVEKoQ3+sYU+Q6M3Vy0t6IX91N0gLzTKWuR2dj5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=bM4FnJGn7DSoMT/C/8IRLDwiyf1GFuyorslBXsyVF/QXh3pd+5KSqveMi1RQTCTBP
	 gPru0tMGgFfotbus3hwuG18JMR1GUi/62MkyOWR9adHMIdrC86RbAN97pDWkVJYZkO
	 zkUnXIwe7iFktCR534yYbLfTriNpi6FVcgOdX+nsXqMPSSPI4d+W8CfSYb9eXa4HW2
	 V6aNwaftyxRiIgd69/CcK/NrigWcqhi6JrX9knk+9dKnjYDisrUre0L68bYeq5JxTg
	 FJVM3y+Hntq57jgs0W0bED2zAXsptUIDyL4yeD29q0kraP94L4IBDEi6vYq54pwWfS
	 UOSVvRoE2UV2Q==
Date: Fri, 31 Jul 2026 16:41:43 -0500
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
Message-ID: <20260731214143.GA1657481@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731002742.GA1538321@bhelgaas>

On Thu, Jul 30, 2026 at 07:27:42PM -0500, Bjorn Helgaas wrote:
> [+cc authors of everything on pci/controller/cadence; I haven't
> triaged this at all, sorry, and don't have time right now to drop that
> branch from pci/next]
> 
> On Thu, Jul 30, 2026 at 04:06:44PM -0700, Randy Dunlap wrote:
> > 
> > 
> > On 7/30/26 8:02 AM, Mark Brown wrote:
> > > Hi all,
> > > 
> > > Changes since 20260729:
> > > 
> > 
> > (1) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
> > pcie-cadence-plat.c:(.text+0x2f8): undefined reference to `cdns_pcie_ep_setup'
> > 
> > In this case, a builtin driver attempts to call into a loadable module:
> > 
> > #
> > # Cadence-based PCIe controllers
> > #
> > CONFIG_PCIE_CADENCE=y
> > # CONFIG_PCIE_CADENCE_DEBUGFS is not set
> > CONFIG_PCIE_CADENCE_HOST=y
> > CONFIG_PCIE_CADENCE_EP=m
> > CONFIG_PCIE_CADENCE_PLAT=y
> > CONFIG_PCIE_CADENCE_PLAT_HOST=y
> > CONFIG_PCIE_CADENCE_PLAT_EP=m
> > # end of Cadence-based PCIe controllers

I was unable to reproduce this issue, so I didn't do anything.  I
didn't figure out how to make CONFIG_PCIE_CADENCE_EP=m; the config I
used was:

  CONFIG_PCIE_CADENCE=y
  # CONFIG_PCIE_CADENCE_DEBUGFS is not set
  CONFIG_PCIE_CADENCE_HOST=y
  CONFIG_PCIE_CADENCE_EP=y
  CONFIG_PCIE_CADENCE_PLAT=y
  CONFIG_PCIE_CADENCE_PLAT_HOST=y
  CONFIG_PCIE_CADENCE_PLAT_EP=m

> > (2) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
> > pcie-cadence-plat.c:(.text+0x11f): undefined reference to `cdns_pcie_host_setup'
> > 
> > 
> > This is similar, just a different driver is =m in the failure case.
> > 
> > #
> > # Cadence-based PCIe controllers
> > #
> > CONFIG_PCIE_CADENCE=y
> > CONFIG_PCIE_CADENCE_DEBUGFS=y
> > CONFIG_PCIE_CADENCE_HOST=m
> > CONFIG_PCIE_CADENCE_EP=y
> > CONFIG_PCIE_CADENCE_PLAT=y
> > CONFIG_PCIE_CADENCE_PLAT_HOST=m
> > CONFIG_PCIE_CADENCE_PLAT_EP=y
> > 
> > 
> > -- 
> > ~Randy
> > 
