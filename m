Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0229B8D0;
	Fri, 30 Jan 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770078; cv=none; b=S+13FPb8vvjpZRPrSVCOOl+j2eyHsuQG05MkFtlw/9yoHw54+Qdt1Fg4B0VDf7qpxo3pPu/FcCBp46q0/xRH25EuiEscxTGBvZPug+3TlXLP5uL/DAO5D09CstJEG44HziNwpjI66+H2HTPXkzDQP+Fg4PIHQlpbhLmhv66f4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770078; c=relaxed/simple;
	bh=Qupg066gMKPj6vgsyfB3rFpzpUhT63sNzkr4dHXMrlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlTJe3yyMG3SHM5Bouk7strpMRRaeoP6E8Bs6b4zkm1RTmEmCrhWORQHo3HlBYPF2rDuESwEboC9uota8ToR7f0+3vxHDBfGIDXdpByiyWcn5daIMzJfPae6VEKfUTfQZ15Ln/wPDrXbqhzTIPd9B2SbKJsBAJOjqKX45SnbRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axmcSN/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axmcSN/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3B8C4CEF7;
	Fri, 30 Jan 2026 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769770078;
	bh=Qupg066gMKPj6vgsyfB3rFpzpUhT63sNzkr4dHXMrlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axmcSN/xPMB8W0R9PhRDHegjIRspVMwxqtzGG0mS23/OSXNpKNDHMG9CT/kqjDmLW
	 +cCEoAVzpq3Ndb6eKW6gvIHxOi5a/ExwQD4ww4XgpjzxXlYXHH2AAVWnAwcOkLHdA7
	 R/PCMmIn5j6JUaaU4R0+giJtbll3dNLGkKkUpXe4LWFiR2Nz9QpEeob/44Sn9JfO6Y
	 P4lhifaqK/dHguKT6/Pbt2We0F84cW8DxwhDMAgCsnSFP+FkPBQWUWRI+t3YrgHx4q
	 tkK+KxCM8azNSPI/rzNcf47GT+iz3RDcbcRAJaGNZ8NQtT8MjZjeA0uXkdzaSjNVgv
	 Y5PfO9P1H/5fA==
Date: Fri, 30 Jan 2026 11:47:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com, gustavo.pimentel@synopsys.com,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
Message-ID: <aXyMWIHy_gMnIxOX@ryzen>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com>
 <aXtrW7viGZfMNZur@ryzen>
 <4c71700d-e4a5-496b-825e-01f346f73949@ti.com>
 <aXx_oaBxCmAXAZQt@ryzen>
 <8202cb0f-3d04-449e-ac37-181afbb35fa1@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8202cb0f-3d04-449e-ac37-181afbb35fa1@ti.com>

On Fri, Jan 30, 2026 at 04:09:26PM +0530, Aksh Garg wrote:
> On 30/01/26 15:23, Niklas Cassel wrote:
> > On Fri, Jan 30, 2026 at 09:42:43AM +0530, Aksh Garg wrote:
> > > On 29/01/26 19:44, Niklas Cassel wrote:
> > > > On Thu, Jan 29, 2026 at 02:47:52PM +0530, Aksh Garg wrote:
> > > > > -static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> > > > > +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
> > > > >  {
> > > > > +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> > > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > >  	struct device *dev = pci->dev;
> > > > >  	unsigned int i, num;
> > > > > @@ -152,18 +157,18 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> > > > >  	u32 *indexes;
> > > > > Hello Aksh,
> > > > > Considering that all other functions that you have modified, you
> > > have added a:
> > > > > if (!ep_func)
> > > > 	return;
> > > > > > I think you should do the same to this function.
> > > >
> > > 
> > > I omitted this NULL check here because all the current call sites of
> > > dw_pcie_ep_clear_ib_maps() already perform this validation. I felt
> > > adding it here would add redundancy in the code.
> > 
> > Ok, but with that logic, shouldn't we also remove the NULL checks from
> > dw_pcie_ep_ib_atu_bar() and dw_pcie_ep_ib_atu_addr(), because they are
> > only called from dw_pcie_ep_set_bar(), which already has the ep_func
> > NULL check?
> > 
> 
> Yes, that's correct. Alternatively, we can add the NULL check in
> dw_pcie_ep_clear_ib_maps() as well, making all the functions using
> ep_func self-contained and defensive, removing the dependency on whether
> the callers perform NULL checks. This makes the code more future proof,
> as new callers won't need to be aware of the NULL pointer possibility.

Sounds like a good idea to me.

Neither of these functions is in the hot path, so the performance of having
one less NULL check is not super critical.


Kind regards,
Niklas
