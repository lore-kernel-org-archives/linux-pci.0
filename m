Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247801A6806;
	Wed, 22 Jul 2026 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723660; cv=none; b=myX3UL6IpGok0Hj6Z0IlnsHmWqS/xP2/HrM8U2SwqHtXB+yWEh2h5fDa+KtW7RfYOBfSc8Lhu06R14d1mSgEoAwYbj3dpMXzkA2w7euCwuU528Vy89ZovyawOI+j6wFmvAgVxrOf8pffn6LhWU9UmCZzEInpI0LJd82zvZfNiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723660; c=relaxed/simple;
	bh=VIqWzxU/8q1ij/hsSfSdRtpYkcojanLbxcX+rVj+lyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+myZXNwbTESINYKLLzNyP3ySEeTZq+m3D9Jf0+kz3GXL6WFQBKE/tmsZSCYMkHo5KKX4SQBiPuJZOoykDacJAKuH1XLvzVx0j6x+7Ln286ZmwE7NxeuoeTtqHT+apQxT0nG4lvgt1gqrRZwCzSn+f/7eapTBd86pN/URyXzRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzvHdx8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzvHdx8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D017C1F000E9;
	Wed, 22 Jul 2026 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784723658;
	bh=UnTZnEO1RmvpgW4LLUlogfu73djdSpGYvoqvHkTazF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bzvHdx8LoV6t9yiZxpbzqhBsdprPK4HsXqvJ40GzizC08zdeQ6izK0Njcytxoqz/m
	 qZ6os7sPm0i/jHQ4UkxtoU+RTGzMLVkV4DuBqCdX6SoSvik3b1tBTTgEZNKF9S6NSK
	 ObP5a14FZxCSqlPzlXcBd0h1S9o4cXMlWKa1hSwDH4IC6ioTLLqhcY8+To9HiGHel/
	 79ott/JeefLTFIsGvRVdU6VgheaTqwLovfBhYBNlGgPQBzu5rCVKgYk8dSpA079QRf
	 ihhWOulVs7cjZ9DaZIrgz8o1dAX/rTQfFu8z8VtqSqeeoWNxnRTA6wlxfq0HU3qJYl
	 tB+dIONxnwnmA==
Date: Wed, 22 Jul 2026 14:34:07 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>, 
	Brian Norris <briannorris@chromium.org>, Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <fij5nuydnb7d6o3i7mwq2nz64wnkicr6hgs4r6dpv6uca7cnyf@ujn4andla3iq>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <abFMa6DCGGLUHddA@fedora>
 <dp2rem4gj7zhfgykvekmcrhq4ticm6m6ido6tbgflwzfcuuwkl@4wuxgle27eyx>
 <srdn3bspgwff7f7tnst7wzg4us4buifrv7o3ylo527hmuciyl3@6ioyrl6rfhaz>
 <abk3rU2EDKjkefUD@ryzen>
 <tgsh3cum6qxrqjzbdeqjsp6bf7cqedj7il77hww3oxecadndin@idjnwib7cz4z>
 <agybt3onTAJO2Dl9@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agybt3onTAJO2Dl9@ryzen>

On Tue, May 19, 2026 at 07:19:51PM +0200, Niklas Cassel wrote:
> Hello Mani,
> 
> On Mon, May 18, 2026 at 11:51:56AM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > With the patch above. There is zero difference before/after reset, and all
> > > the BAR tests pass. However, MSI/MSI-X tests still fail with:
> > > 
> > > # pci_endpoint_test.c:143:MSI_TEST:Expected 0 (0) == ret (-110) 
> > > # pci_endpoint_test.c:143:MSI_TEST:Test failed for MSI1
> > > 
> > > ETIMEDOUT.
> > > 
> > > This suggests that pci_endpoint_test on the host side did not receive an
> > > interrupt.
> > > 
> > > I don't know why, but considering that lspci output is now (with the
> > > save+restore) identical, I assume that the problem is not related to
> > > the host. Unless somehow the host will use a new/different MSI address
> > > after the root port has been reset, and we restore the old MSI address,
> > > but looking at the code, dw_pcie_msi_init() is called by
> > > dw_pcie_setup_rc(), so I would expect the MSI address to be the same.
> > > 
> > 
> > Hi Niklas,
> > 
> > When I rebased this series on top of v7.1-rc1, I ended up seeing the issue what
> > you described here (not sure why I didn't see it earlier). So after the Root
> > Port reset, MSI tests fail, but BAR tests succeed. Also, I got IOMMU faults on
> > the host after endpoint triggers MSI.
> > 
> > I investigated it and found that the MSI iATU mapping gets cleared in hw after
> > LDn happens. But the host continues to use the same address/size for the
> > endpoint MSI even after reset. Due to this, the existing checks in
> > dw_pcie_ep_raise_msi_irq() don't pass and the stale MSI iATU mapping gets
> > reused.
> > 
> > The fix would be to clear the mapping in dw_pcie_ep_cleanup(), which gets called
> > as part of the PERST# assert/deassert sequence post LDn and also set
> > msi_iatu_mapped flag to 'false'. This will force dw_pcie_ep_raise_msi_irq() to
> > use fresh iATU mapping when it gets called for the first time:
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index d4dc3b24da60..4ae0e1b55f39 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -1035,6 +1035,11 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
> >  {
> >         struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> > +       if (ep->msi_iatu_mapped) {
> > +               dw_pcie_ep_unmap_addr(ep->epc, 0, 0, ep->msi_mem_phys);
> > +               ep->msi_iatu_mapped = false;
> > +       }
> > +
> >         dwc_pcie_debugfs_deinit(pci);
> >         dw_pcie_edma_remove(pci);
> >  }
> > 
> > With this change, MSI works after Root Port reset without any issues on our Qcom
> > endpoint/host setup.
> > 
> > Please test this change on your rockchip setup as well. You have to make sure
> > that dw_pcie_ep_cleanup() is called during PERST# assert/deassert.
> > 
> > I'm going to respin the series with this fix. If you confirm it works for you,
> > then we can merge your Rockchip Root Port change.

Somehow, this reply fell into the cracks...

> 
> I am happy to hear that you managed to find the root cause!
> 
> Hopefully your series can finally move forward :)
> 
> While e.g. RK3588 does have a PERST# input GPIO, so it could theoretically
> add a perst_deassert()/assert() function. However, when the EPC support was
> added, you did not want that, since I remember that you said that you only
> wanted that for drivers that required an external refclock.
> 

Hmm, I don't recall exactly that conversation, but if I said that then I was
wrong. PERST# assert()/dessert() have nothing to do with REFCLK. Maybe I was too
focused on doing things assuming that REFCLK won't be available.

But anyhow, feel free to add it now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
