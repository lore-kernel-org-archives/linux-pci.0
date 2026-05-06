Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BF4A13BF;
	Wed,  6 May 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087550; cv=none; b=olb8W1LtXNrB6SnnTq+JZM359AgIowEzgjigwT+7aCZf7z2zirGvRnlS0qe72wgW9CehGpFUn/1sqctv2C4Eon5KtX0bwgktdbxeaCqFRjFUR5txh8ClTvnWHulkdHseVz9Pf4hWcyAerUdJB206J9QGqpb0RpOx2KYq83UWoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087550; c=relaxed/simple;
	bh=4UTh1+V2xr8wQjaCmcYORVivtr5ISCP3YfmJwCUuXSk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Du3uk9OIK9Cg+KLsvgeffvONm2D/oyWL0M8i3fxsZYuQOxaH3PwNSL4QXC1iDe0M35FdBxfne8we0mHCHuAnWjAHfx/yarrz+uwLCWblK4EGmXDfM0Dci5HcPWNMmLBwvL+Jg7BCR38+oim3LgIajMDVzxebjMuq40mjZ7GMkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlCr3kc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlCr3kc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39874C2BCC9;
	Wed,  6 May 2026 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778087549;
	bh=4UTh1+V2xr8wQjaCmcYORVivtr5ISCP3YfmJwCUuXSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PlCr3kc6uIpPRilSsSx714+bxudOEPRDMdh2m/Zgo0etieg+uvlKnAbrTN7eXRkGN
	 9O4vQA0buxY8AILyKfKegpDkfhFLPualPhYrHXATsfKJLbi0JXzAC9tw+MaDc1m+zC
	 pYJvLO5Ul/uCvoNvSQaevgdx+HSyuINXkfHw6rcOh0IyFAkaxtFXMHE+lwBfEbmzr8
	 ZASIwqLj0IpwnIfEYb2TUZHI/Upv4DjG6tjhese2R35eOpy+g1jBCnzgVHNuatSFxN
	 r/+mEGoSeKS8PAq0O8uGArxp3HMhGUXvNiEX/FXbJWm7/EZxuwbuBCEUZLDO1X9YKf
	 b2+RJyUQvDGWQ==
Date: Wed, 6 May 2026 12:12:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>, t@bhelgaas
Cc: sashiko@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: Use cdns_pcie_find_capability() to get
 PCIe Cap offset in host driver
Message-ID: <20260506171227.GA797577@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <505b1138-b4a7-4519-b6e5-5da6e06d615d@163.com>

On Thu, May 07, 2026 at 12:04:34AM +0800, Hans Zhang wrote:
> On 5/6/26 05:23, Bjorn Helgaas wrote:
> > On Mon, May 04, 2026 at 04:22:26PM +0800, Hans Zhang wrote:
> > > On 5/4/26 00:52, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1
> > > > potential issue(s) to consider:
> > > > 
> > > > - [Critical] cdns_pcie_find_capability() searches the wrong
> > > > register space in Host mode and its return value is not validated,
> > > > leading to Root Port configuration space corruption.
> > > > --
> > > > 
> > > > commit 09b3c64b8f5892eb365acd13030a8067652a15e8
> > > > Author: Hans Zhang <18255117159@163.com>
> > > > 
> > > > PCI: cadence: Use cdns_pcie_find_capability() to get PCIe Cap offset in host driver
> > > > 
> > > > This commit replaces the hardcoded CDNS_PCIE_RP_CAP_OFFSET with a dynamic
> > > > lookup using cdns_pcie_find_capability() in Cadence PCIe host-related
> > > > functions. The goal is to ensure correct operation across various SoC designs
> > > > where the capability might not reside at offset 0xC0.
> > > > 
> > > > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > > > index 2b0211870f02..5013d3fe23b5 100644
> > > > > --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > > > +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > > > @@ -26,14 +26,14 @@ EXPORT_SYMBOL_GPL(bar_max_size);
> > > > >    int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
> > > > >    {
> > > > > -	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> > > > >    	unsigned long end_jiffies;
> > > > >    	u16 lnk_stat;
> > > > > +	u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
> > > > 
> > > > Does this capability search scan the correct register space when
> > > > operating in host mode?
> > > > 
> > > > Looking at the helper function, it uses cdns_pcie_read_cfg() which
> > > > reads directly from the base address without the Root Port offset:
> > > > 
> > > > drivers/pci/controller/cadence/pcie-cadence.c:cdns_pcie_find_capability() {
> > > >       return PCI_FIND_NEXT_CAP(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
> > > >                                cap, NULL, pcie);
> > > > }
> > > > 
> > > > However, the Root Port configuration registers are physically
> > > > located at pcie->reg_base + CDNS_PCIE_RP_BASE. Could this cause
> > > > the search to scan the Local Management register space instead,
> > > > failing to find PCI_CAP_ID_EXP and returning 0?
> > > 
> > > I don't think we need to worry about this issue.
> > > 
> > > As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions
> > > are required to implement the PCI Express Capability structure,
> > > which must be included somewhere in this linked list;
> > > 
> > > So, it won't return 0 here.
> > 
> > It's true that all Root Ports must have a PCIe Capability, but
> > that's not related to this issue.
> > 
> > cdns_pcie_host_init_root_port() accesses PCI_EXP_LNKCAP at the
> > address:
> > 
> >    pcie->reg_base + CDNS_PCIE_RP_BASE + CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP
> > 
> > but when we search with cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP),
> > we start reading at:
> > 
> >    pcie->reg_base + PCI_CAPABILITY_LIST
> > 
> > It should be starting at:
> > 
> >    pcie->reg_base + CDNS_PCIE_RP_BASE + PCI_CAPABILITY_LIST
> > 
> > Previously, cdns_pcie_find_capability() and
> > cdns_pcie_find_ext_capability() were only used for endpoints, and I
> > assume they work fine there.  There is pcie->is_rc, so there should be
> > a way to make this work for both endpoints and Root Ports.
> 
> The reason for using the "is_rc" tag is that for Cadence IP, it is not only
> applicable to the RC or EP mode, but also there are significant differences
> between the LGA and HPA generations of IP. Including register offset values,
> definitions, etc., it fails to achieve good compatibility. It is not like
> Synopsys IP, where compatibility has been handled very well. It was truly
> out of necessity.

I think cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP) fails on Root
Ports because it doesn't include the CDNS_PCIE_RP_BASE offset.  Do you
have hardware where you can test that?
