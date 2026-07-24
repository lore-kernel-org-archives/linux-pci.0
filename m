Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C333A708;
	Fri, 24 Jul 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904523; cv=none; b=Ocn31U+GsvxYAE+vMoxIUM603CYCgrGDd1YiEyAY9mMo7T7RDWu8yF6WM77hASxc6VR5gPs7JyG3k+hiS7fPdxRlb0/Sv5pbteUZqul8GR/GtovLi83LO6eEef70XAoqCeScCX3ZCGs159+dwTgvoCP4mAZVvg+0k+SZMYckh+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904523; c=relaxed/simple;
	bh=BtLEnFxDeCfVkq6UHh61G86yZqBZ6PpOtZ2/vLvllTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNr62YHpz3Sk/9b3k6NUA7kfRz5+siZD9ku9ln1q6S+r60VSHOvpSBkStj0bFlbAqF70ewPFqHs15byFDik6GeXL0Bxz2oCH5RBfUH9LPBtH7MGNMmgJQ4ED5Voz5Mb/rr2p3vHUYRSfBsQNJw8PnY0qRknXzOqojSNY9wFTxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDjj/cz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDjj/cz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFC21F000E9;
	Fri, 24 Jul 2026 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784904521;
	bh=HZ+iuQadXt8foEnd9zgclkwjEUMJTFr3yvCZwnccZJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fDjj/cz/6IxzX+OYExNr02LzrhqzOWPj19th7ol4wFoTtdl7WUqSLTVTkz04jivI9
	 U+FlSPeKN4kpEO1j5OqS5K6uWuYZOU3t+LIQ/X3nAUE09m5ZxUyMep1xggX1+Uz5zV
	 yP9lXOQuHHID0SwWNV6YKRvo+h9TT4aNvQJnZJrnW+YkUJbFuZFA3iMseIa2Eneb3r
	 9ULwzJ0eeU46v/ucMowM+X8VYaojbj3YsMxRW7NN6rd7G4sVukZkTykbawn+3G9O/9
	 QQ1eACW0MYkWHKAJokvq2m26Mi+83hvQGFsfvHsZ9qaFrnHrqY6Q8rkux4PHuVXbjM
	 MRALJU8h5o09g==
Date: Fri, 24 Jul 2026 16:48:34 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
 dw_pcie_ep_cleanup()
Message-ID: <mvqftbpuuchbv7ovwkqt4ff4zaav2gdmbpkshlfrj6cg7kcrut@e5c3fezk3nvc>
References: <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>
 <20260518160413.E8BCEC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518160413.E8BCEC2BCC7@smtp.kernel.org>

On Mon, May 18, 2026 at 04:04:13PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] dw_pcie_ep_cleanup() modifies the MSI iATU mapping without holding ep->epc->lock, introducing a critical race condition with concurrent EPF interrupt requests.
> --
> 
> commit f01add14b7c42730aa5b71bb56cc8682eb2fa21a
> Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> PCI: dwc: ep: Clear MSI iATU mapping in dw_pcie_ep_cleanup()
> 
> This commit clears the MSI iATU mapping in dw_pcie_ep_cleanup() to avoid
> retaining a stale MSI iATU mapping after a fundamental reset triggered by
> PERST# assert/deassert.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index d4dc3b24da607..4ae0e1b55f390 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -1035,6 +1035,11 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> > +	if (ep->msi_iatu_mapped) {
> > +		dw_pcie_ep_unmap_addr(ep->epc, 0, 0, ep->msi_mem_phys);
> 
> Is it safe to modify the MSI iATU mapping without holding ep->epc->lock here?
> 
> dw_pcie_ep_cleanup() can be invoked asynchronously from reset/link-down
> threaded IRQ handlers (e.g., qcom_pcie_perst_irq_thread() calling
> qcom_pcie_perst_deassert()) which might not hold the endpoint controller lock.
> 
> Concurrently, an endpoint function driver can attempt to raise an MSI
> interrupt via pci_epc_raise_irq(), which acquires ep->epc->lock and invokes
> dw_pcie_ep_raise_msi_irq().
> 

False positive. Before dw_pcie_ep_cleanup(), both threaded IRQ handlers are
calling pci_epc_deinit_notify(), which should ensure that all EPF drivers are
quiesced as it happens for both epf-mhi and epf-test. So there is no way the
EPF drivers are going to raise MSI to the host triggering race.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
