Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15630346A04;
	Thu, 10 Sep 2026 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020502; cv=none; b=bjs/25K4c5Q5qBiKUzbg16SDpMSEP/wfIt6snPN+fOL9zz1VCLXiF2hp2RblkzZ4wPLw3l0ZAJBgNL94YKyGwXWbA5Gd4oFuPWzSvPtHxryRv0U5pppGiGyMKtf1z2cK/t/Mq1hnerlUuF26P9mlq7byWwk/7djF1qKlE6zoUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020502; c=relaxed/simple;
	bh=K2E8HJKKwmixZBGMikxuRE6av/5UwFtViroEDqpWL7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhHLTeTpb5OTjdd4wQNHy3xnTD65R7m/ov79+7XLwXCesLRQUeMKep9XKVgzl7tdbW2I7+A6oNfR66dMQLAM5Tcs0NKcC/cVI3TpbBXuQQVM83PIsFW8QQoLa2q+k2hzGD5QxCI4bTJiIoWkLC1mSb/lwrGhk1Bg8LVjvYCbSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9gWFHds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9gWFHds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B64A1F00893;
	Thu, 10 Sep 2026 06:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789020500;
	bh=yFkpzRTGUxAa/gcYZ+xpuv+1HVYwbL6IIJ/xeFkQyRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X9gWFHdsNieV0H8nFH56LOOdari/6PCxjiNUid9zuK64ipvL7/msC0CE6j6Xe5FsH
	 mcU064QBh7Bf0a0wKmuePmXOvVMPHOLPZkzOnjrKXfYGZHP8O1k97hJM5ONvGa/1XW
	 5YyWd8JW1oBoH7LDzyX2REN17DaNMqmKWczf/P1yXzOrFz3FnTH66c9CIWZRG1gZj1
	 y2bkFdJqdWoVYWweb6Unl+Suz1cj1Ncql5F6FRL6DUgcrgmS2gU0hwnNqoS4btrfQq
	 unVw3JANRQWQmhuu9YJYgMZ5WxiPa94g4yYj8CIVIPyPxSUsEijbY7ZaL487cGyOSY
	 aqsCx8Lek1tiw==
Date: Thu, 10 Sep 2026 08:08:10 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when
 BAR programming
Message-ID: <b4mtzimdzlk6r3yihye7f3gkdqbk7gi64ymdrhf5twmn35zej7@s3n7bqe4g6vq>
References: <rmso2szdpfjy4qoqalhhpf3zxzn2te25m573qmwmpmoilk5jz2@arvvr4hdzbbj>
 <20260909160949.GA216221@bhelgaas>
 <sbmyv6wgmdtow7rg4m7vkfpn42ts2xobqwvzjdh7japgyremyb@p5zmzskzcdvc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sbmyv6wgmdtow7rg4m7vkfpn42ts2xobqwvzjdh7japgyremyb@p5zmzskzcdvc>

On Thu, Sep 10, 2026 at 01:56:53PM +0900, Koichiro Den wrote:
> On Wed, Sep 09, 2026 at 11:09:49AM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 09, 2026 at 01:53:53PM +0900, Koichiro Den wrote:
> > > On Tue, Sep 08, 2026 at 09:23:11PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Sep 09, 2026 at 11:01:48AM +0900, Koichiro Den wrote:
> > > > > On Tue, Sep 08, 2026 at 11:53:15AM -0500, Bjorn Helgaas wrote:
> > > > > > On Wed, Jul 29, 2026 at 02:23:04AM +0900, Koichiro Den wrote:
> > > > > > > vntb_epf_mw_set_trans() programs the memory-window BAR through
> > > > > > > pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
> > > > > > > lands on the wrong function whenever the vNTB EPF is bound to anything
> > > > > > > but PF0. The other BAR programming sites in the vNTB driver already pass
> > > > > > > the EPF's own numbers.
> > > > > > > 
> > > > > > > Pass the EPF's own func_no/vfunc_no here as well.
> > > > > > 
> > > > > > We're referring to these as "PF" and "VF" in the subject and "physical
> > > > > > endpoint function" and "virtual endpoint function" in the
> > > > > > pci_epc_set_bar() kernel-doc, but I don't think these have anything to
> > > > > > do with the SR-IOV PF and VF concepts, do they?
> > > > > 
> > > > > Not in the specific case that motivated this series. But AFAICT, the EPC API
> > > > > uses the same (func_no, vfunc_no) pair to cover both ordinary functions and
> > > > > SR-IOV PFs/VFs scenarios. With vfunc_no == 0, func_no can identify either an
> > > > > ordinary function or an SR-IOV PF. A non-zero vfunc_no identifies a VF
> > > > > associated with the PF selected by func_no.
> > > > 
> > > > Now I'm even more confused :)
> > > > 
> > > > Are you saying that a non-zero vfunc_no always identifies an SR-IOV
> > > > VF?  And there's some dependency on that?  I don't any mention of
> > > > "iov" in drivers/pci/endpoint/.
> > > 
> > > Yes, that is my understanding of the current in-tree implementation. You're
> > > right that drivers/pci/endpoint/ itself contains no explicit reference to
> > > SR-IOV. E.g. pci_epf_add_vepf() just calls it a "virtual EP function".
> > > So my saying was kind of assumptive, but I still think the same because:
> > > 
> > > - The support was introduced for SR-IOV:
> > >   https://lore.kernel.org/r/20210819123343.1951-1-kishon@ti.com/
> > > 
> > > - The core rejects a non-zero vfunc_no unless the EPC provides max_vfs, and
> > >   Cadence is the only in-tree EPC driver I found that does so. For example,
> > >   cdns_pcie_ep_set_bar() calls cdns_pcie_get_fn_from_vfn(), which uses the
> > >   SR-IOV First VF Offset and VF Stride for a non-zero vfn.
> > 

Your understanding is correct.

> > Thanks, that's helpful.  I still have to work hard to change my point
> > of view from host-side drivers to endpoint drivers operating on the
> > other end of the link.  The fact that there are several interfaces
> > that need (func_no, vfunc_no) suggests that callers really do need to
> > understand what's going on, and maybe we should try to connect the
> > kernel-doc and abbreviations more closely with PCIe spec terms.
> > 
> > E.g., if "physical EP function" and "virtual EP function" refer to
> > SR-IOV PF and VF, maybe we should word them as "endpoint PF" or
> > "endpoint VF" (or "EP PF", "EP VF" for short).  If
> 
> I personally agree. That sounds reasonable and would help clarify things.
> 
> > "pci_epf_add_vepf()" adds an SR-IOV VF, maybe "pci_epf_add_vf()" would
> > be descriptive enough.  We already know we're on the endpoint because
> > of "epf", so we probably don't need another hint in "vepf", which
> > includes a "pf" that doesn't mean SR-IOV PF.
> 
> True. But I'd also like to hear what the PCI EP maintainers think about this.
> 

Fine with me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
