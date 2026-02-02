Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3F28152A;
	Mon,  2 Feb 2026 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022063; cv=none; b=bGFFcxQquAVOBlpKDlm3hpB4rXvwa3lhOGU+MMPUY/hQfUsONEAHEouBwobEgOpCh8XXER1rl6T1vqASGgxfBWKDjWb7toOXjUjpH4+YWpA3M4+eAExyN298nCqzUfBeJgaDgHhQORvRlFr6YdUOOQAkSHXcs1pDamjlE2YUIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022063; c=relaxed/simple;
	bh=Y5k/DcESGhxodl8MmlHPHIaXYgS0c61zNUTSEtoEwOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHIoonHoCZUIR8o2RCk0zvdwoEmG1NibUP1Y38NfeHvPRpaJz49jkDcZbVX3rWN75B4svwvzrTeh06N/K4fjrvGdwa9Yne3nDfe5rjasxCBATdR5p6ozv/nCE8kEE/FBGlz/1NTpNTmn6PXjPZ9WSSYiZLopVJOVZ6JagUMnlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJc/edvE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJc/edvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B22C116C6;
	Mon,  2 Feb 2026 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770022062;
	bh=Y5k/DcESGhxodl8MmlHPHIaXYgS0c61zNUTSEtoEwOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJc/edvEbtln2V8bed2UVJJT8aGcbhAa4dmrIf+OjKKbFJwK24Ze3CVHuPXMGe967
	 Ev6VLoQ7c2kqKiCuO2AT02yiT1pMSbfSBDMJ0sMvmQ341LfND4aa93ewYzmwwkuiax
	 ATmOJi1GmMioOej1J7CJ+v0watkEVWWewhe9h7CORCUG/u4qJToQV6GuvLpLNOsuMY
	 qR9/S4gH4AOESiin9+00wT+UvpRQoxLhViFljrwMpYmDTFK3Z8h8Fij+q4h0EJbkdW
	 LCagibKebGqacc829mFsWQgIqUyvasGYnWeCldXuRuvXItO8VMTUVR69JsRShe1Svb
	 8NoJ9jIroelGg==
Date: Mon, 2 Feb 2026 09:47:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, yoshihiro.shimoda.uh@renesas.com,
	fancer.lancer@gmail.com, Zhiqiang.Hou@nxp.com,
	gustavo.pimentel@synopsys.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix MSI-X configuration to write to
 correct physical function
Message-ID: <aYBkqcl4jzETU8ow@ryzen>
References: <20260202072758.101845-1-a-garg7@ti.com>
 <20260202072758.101845-2-a-garg7@ti.com>
 <aYBYgrM6SPWQy6iP@ryzen>
 <aYBY_K21cmj4ICxx@ryzen>
 <7e1c38de-c3a8-4275-a9a4-03773ed9dd6e@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e1c38de-c3a8-4275-a9a4-03773ed9dd6e@ti.com>

On Mon, Feb 02, 2026 at 01:45:49PM +0530, Aksh Garg wrote:
> On 02/02/26 13:27, Niklas Cassel wrote:
> > On Mon, Feb 02, 2026 at 08:55:52AM +0100, Niklas Cassel wrote:
> > > On Mon, Feb 02, 2026 at 12:57:57PM +0530, Aksh Garg wrote:
> > > > The MSI-X configuration code reads from the correct physical function's
> > > > register space using dw_pcie_ep_readw_dbi(), but writes back only to
> > > > PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
> > > > MSI-X configuration for other PFs.
> > > > > Fix this by using dw_pcie_ep_writew_dbi() to write to the
> > > correct PF's
> > > > register space, matching the read operation.
> > > > > Fixes: 70fa02ca1446 ("PCI: dwc: Add
> > > dw_pcie_ep_{read,write}_dbi[2] helpers")
> > > > Signed-off-by: Aksh Garg <a-garg7@ti.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 7e7844ff0f7e..771241e1a2c9 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -745,7 +745,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > >  	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
> > > >  	val &= ~PCI_MSIX_FLAGS_QSIZE;
> > > >  	val |= nr_irqs - 1; /* encoded as N-1 */
> > > > -	dw_pcie_writew_dbi(pci, reg, val);
> > > > +	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
> > > >  >  	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
> > > >  	val = offset | bir;
> > > > -- > 2.34.1
> > > >
> > > 
> > > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > > 
> > > 
> > > However, please also fix the only remaining place in this file which still
> > > uses the incorrect dw_pcie_writew_dbi() instead of dw_pcie_ep_writew_dbi()
> > > 
> > > i.e.:
> > > dw_pcie_ep_raise_msix_irq_doorbell().
> > 
> > Perhaps doorbell is special, and there is only one register for this...
> > 
> 
> Yes, we have only one doorbell register.
> 
> > But then, perhaps add a comment why this is the only place that needs
> > to not supply func_no.
> 
> However, I think the offset (0x948) of the register is self-explanatory,
> as after 0x700, we have port logic registers, which are per-device, not
> per-PF.

The macro PCIE_MSIX_DOORBELL does kind of hide the offset, and not everyone
who reads the driver might know the that PL registers start at 0x700.

But sure, msg_data which is written to the doorbell was crafted with a func_no
shift, so perhaps it is self explanatory if you look some lines above the
dw_pcie_writel_dbi() which does not supply func_no, so perhaps a comment is
superfluous in this case.


Kind regards,
Niklas
