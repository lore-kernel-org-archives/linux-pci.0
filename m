Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A554654;
	Tue,  5 May 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016188; cv=none; b=rE8feCM5b989djCvovURMEGh//dfMSytxaWVFi0xpFooXqGjShPJkNxWxkRvNYk+Yz19eFyTLPAP/mzt6/9+/QmKoUnd69nY2Ai2jhggIpjVGG8F8c0PR2CupHgRVRXNsi63BSxCfl7ISIzt92ddtCabIk23iKN4cxji0quwSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016188; c=relaxed/simple;
	bh=+umIMDtcMebdhJqgtSoV7BFtE++KssU85kbZ6gqvnaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uGvVZ49E3V7BlrtuJ0A311madEobnoPDsC8efCv0r9/ScurAz/hBw/7k5jQFv3OeG5cAQQ9okoShomzkF2AxNyKYMhCbheXfaO75ZSWWvkUFcmwOM5E8E8k7srgHYuui96FEhXHMMi0fTeYXhxp3wrYU5ICHwB98N/4mwgiVh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGKV4Man; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGKV4Man"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE940C2BCB4;
	Tue,  5 May 2026 21:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778016187;
	bh=+umIMDtcMebdhJqgtSoV7BFtE++KssU85kbZ6gqvnaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jGKV4ManQPUtTeYi60DDVKHaT/N2eStYocB+v/dA1QuR/dxUfKSr3Bv9a3evDluHR
	 S7Y6i8hSujuSsbbEU8NuMoKQLtPjzFG7/eXEA5vIiJ44os2fPxcR4mDTrS0KvlFgZ8
	 ee9wk9AtTfgAdzCduZG49OFfvgb9Qq/6mF2ZVqCh8kzc0WRemIQiROCykO3FoPHWFY
	 gN7h0cjYVNgtOLnWe6l/TjrISNLrZMpqYi0hA8Oe820TlxKqKWrp0DtMLcSZBXbR7c
	 1Z5YNJnbDOefgLdcOZuFgTQoQEVlyrMShlaDSPyt8hXqdXi6Ohs9CM3nte6sVEz5bR
	 yLPZsULHH8eHg==
Date: Tue, 5 May 2026 16:23:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: sashiko@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: Use cdns_pcie_find_capability() to get
 PCIe Cap offset in host driver
Message-ID: <20260505212306.GA744158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5823faec-d972-4c77-90ec-a215c686e0a8@163.com>

On Mon, May 04, 2026 at 04:22:26PM +0800, Hans Zhang wrote:
> On 5/4/26 00:52, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1
> > potential issue(s) to consider:
> >
> > - [Critical] cdns_pcie_find_capability() searches the wrong
> > register space in Host mode and its return value is not validated,
> > leading to Root Port configuration space corruption.
> > --
> > 
> > commit 09b3c64b8f5892eb365acd13030a8067652a15e8
> > Author: Hans Zhang <18255117159@163.com>
> > 
> > PCI: cadence: Use cdns_pcie_find_capability() to get PCIe Cap offset in host driver
> > 
> > This commit replaces the hardcoded CDNS_PCIE_RP_CAP_OFFSET with a dynamic
> > lookup using cdns_pcie_find_capability() in Cadence PCIe host-related
> > functions. The goal is to ensure correct operation across various SoC designs
> > where the capability might not reside at offset 0xC0.
> > 
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > index 2b0211870f02..5013d3fe23b5 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > @@ -26,14 +26,14 @@ EXPORT_SYMBOL_GPL(bar_max_size);
> > >   int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
> > >   {
> > > -	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> > >   	unsigned long end_jiffies;
> > >   	u16 lnk_stat;
> > > +	u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
> > 
> > Does this capability search scan the correct register space when
> > operating in host mode?
> > 
> > Looking at the helper function, it uses cdns_pcie_read_cfg() which
> > reads directly from the base address without the Root Port offset:
> > 
> > drivers/pci/controller/cadence/pcie-cadence.c:cdns_pcie_find_capability() {
> >      return PCI_FIND_NEXT_CAP(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
> >                               cap, NULL, pcie);
> > }
> > 
> > However, the Root Port configuration registers are physically
> > located at pcie->reg_base + CDNS_PCIE_RP_BASE. Could this cause
> > the search to scan the Local Management register space instead,
> > failing to find PCI_CAP_ID_EXP and returning 0?
> 
> I don't think we need to worry about this issue.
> 
> As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions
> are required to implement the PCI Express Capability structure,
> which must be included somewhere in this linked list;
> 
> So, it won't return 0 here.

It's true that all Root Ports must have a PCIe Capability, but 
that's not related to this issue.

cdns_pcie_host_init_root_port() accesses PCI_EXP_LNKCAP at the
address:

  pcie->reg_base + CDNS_PCIE_RP_BASE + CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP

but when we search with cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP),
we start reading at:

  pcie->reg_base + PCI_CAPABILITY_LIST

It should be starting at:

  pcie->reg_base + CDNS_PCIE_RP_BASE + PCI_CAPABILITY_LIST

Previously, cdns_pcie_find_capability() and
cdns_pcie_find_ext_capability() were only used for endpoints, and I
assume they work fine there.  There is pcie->is_rc, so there should be
a way to make this work for both endpoints and Root Ports.


Separate issue: I think some of the config accessors ended up being
sub-optimal.  They should all have the same structure, but
cdns_pcie_read_cfg_dword() is different from the rest, I think because
some devices don't support 1- and 2-byte accesses.

  cdns_pcie_read_cfg_byte
    addr = pcie->reg_base + where
    cdns_pcie_read_sz(addr, 0x1)
     readl(addr)

  cdns_pcie_read_cfg_word
    addr = pcie->reg_base + where
    cdns_pcie_read_sz(addr, 0x2)
     readl(addr)

  cdns_pcie_read_cfg_dword
    cdns_pcie_readl
      readl(pcie->reg_base + reg)

I think it would be better to use "cdns_pcie_read_sz(addr, 0x4)"
even for cdns_pcie_read_cfg_dword().

> > [ ... ]
> > 
> > > @@ -68,27 +68,26 @@ EXPORT_SYMBOL_GPL(cdns_pcie_host_wait_for_link);
> > >   int cdns_pcie_retrain(struct cdns_pcie *pcie,
> > >   		      cdns_pcie_linkup_func pcie_link_up)
> > >   {
> > > -	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> > > +	u32 lnk_cap_sls;
> > >   	u16 lnk_stat, lnk_ctl;
> > >   	int ret = 0;
> > > +	u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
> > >   	/*
> > >   	 * Set retrain bit if current speed is 2.5 GB/s,
> > >   	 * but the PCIe root port support is > 2.5 GB/s.
> > >   	 */
> > > -	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
> > > +	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + cap +
> > >   					     PCI_EXP_LNKCAP));

Could reduce the size of the diff by keeping the original
"pcie_cap_off" name.
