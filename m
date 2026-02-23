Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A526E6E1;
	Mon, 23 Feb 2026 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870374; cv=none; b=THnpBfVPnESoKsXo1dH6dccZVjY4jjJ4R9Kay6jVwcOZTzakzSvDjtF2ZRicRCM+i1lJ5xHuClkp7UkXo8ulp+83CEZfKzvUXjdA50KZGmv+PC8BNDqP+sEI1PI/pUoRySltRfQqqtqSwsKIfrgYWFDschZ8EpCawXJiFXFpLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870374; c=relaxed/simple;
	bh=mAfMACn7cA0xwRCSeRbxVKVfjuZLUNZIAjgI633b7C0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FmPiBbsRh/sRKcUKcQodw5Q6gUSTaIBre7KwBULx1551kAcQTbF/cHtBHfBOKPQjqJ7vRYkP0+NxUl4vLnIw/eccmbWkcLmnNMGh753tqjhrZr/Yu2e51qyjaNihvlBny+q5rp0DKMWR7WMOBppy+GFm39jaIRWx5ywhykcUh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4RNga8v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4RNga8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48C5C116C6;
	Mon, 23 Feb 2026 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771870374;
	bh=mAfMACn7cA0xwRCSeRbxVKVfjuZLUNZIAjgI633b7C0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D4RNga8vvgBBNuDtJryd47Zs1Sz8vw3i06nSUtAiXhD10Wl91pqO3AqzY/o0IOdFL
	 YBQ+jG9Lrf8arOcrBeQ8g0do3xapT8KRwsCcd5sYxcR7luO2BfP6kZ2MLPEh0tkox9
	 MGO9f6nPils2W9RmFVXNgd/R4Y6zVUqOntp+wCI7lzR0xNKKTY7ANJa0bfhPTP5hrX
	 wNBDGcEvRDys6zkIz4ttCem+oDIrpTFGNfNj06xvPueYnFhWiyfss2tosJ+PDW6Rpe
	 93Jv4e3Y/260WbZE+apjYoK24Y6meKO9TcKRRx+UyOny0X+FxSqfCO5YE8Nx1UcLU7
	 4WrAV6R2coK8g==
Date: Mon, 23 Feb 2026 12:12:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com,
	yoshihiro.shimoda.uh@renesas.com, fancer.lancer@gmail.com,
	Zhiqiang.Hou@nxp.com, gustavo.pimentel@synopsys.com,
	cassel@kernel.org, linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Mirror the max link width and speed
 fields to all functions
Message-ID: <20260223181252.GA3700622@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kr3yh3unbsynddcgzhl2zpxmna7hbc4dxgbqo3bmlwsn5twlyr@7gxzh4rqjubg>

On Wed, Feb 18, 2026 at 07:08:20PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 02, 2026 at 12:57:58PM +0530, Aksh Garg wrote:
> > PCIe r6.0, section 7.5.3.6 states that for multi-function devices, the
> > Max Link Width and Max Link Speed fields in the Link Capabilities
> > Register must report the same values for all functions.
> ...

> > @@ -1102,6 +1103,27 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> >  		dw_pcie_ep_init_rebar_registers(ep, func_no);
> >  
> >  	dw_pcie_setup(pci);
> > +
> > +	/*
> > +	 * PCIe r6.0, section 7.5.3.6 states that for multi-function endpoints,
> > +	 * max link width and speed fields must report same values for all functions.
> > +	 * However, dw_pcie_setup() programs these fields only for physical function 0.
> > +	 * Hence, mirror these fields to all other physical functions as well.
> > +	 */
> > +	if (funcs > 1) {
> > +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +		ref_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> > +		ref_lnkcap &= PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS;
> 
> Use FIELD_* macros please.
> 
> > +
> > +		for (func_no = 1; func_no < funcs; func_no++) {
> > +			offset = dw_pcie_ep_find_capability(ep, func_no, PCI_CAP_ID_EXP);
> > +			lnkcap = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_EXP_LNKCAP);
> > +			lnkcap &= ~(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
> > +			lnkcap |= ref_lnkcap;

I think this can also use FIELD_MODIFY().

> > +			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_EXP_LNKCAP, lnkcap);
> > +		}
> > +	}
> > +
> >  	dw_pcie_dbi_ro_wr_dis(pci);
> >  }
