Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408713CD8A1;
	Fri, 27 Mar 2026 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599614; cv=pass; b=OhGByL/jwkxFqFnX3E59yeRKwl93zmaTZS5wvse/1U7ZD1zaSg6CUvAyu/JZqcQLQ1PfjVq7apFPAJVrVALrbgkenFHFLLgdqNqljOXfTmkxG8L+e2lWbMsdshBhBTpN9IZdk8draoGDgY/a5NhMggSNkfIakXAK326U0+EQugM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599614; c=relaxed/simple;
	bh=NAk///Aw8jnMJibnfd+DHj7yL9L0lAgV6rkqS0kNNN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu9BxGy8NhHNeLVYVjiavDI19j4rPFSNz8fUo/q6XFhxyA54TlIRrsrX0FRPsB2NqAEiHGsfKngKjk0c30S+Nyvl4l7RTTbgofJyl+HruHmxfZss1jzMSJJTjtAK/EY5N9ENCH7pND7s2w0VWSskYoDo2xIxavjVzASzv0LSg6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=UwjFhgFS; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="UwjFhgFS"
ARC-Seal: i=1; a=rsa-sha256; t=1774599588; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gf9b3WuIDMVSWCLQxPJFilTQIPOfDBeNwv/uX3xOx7nFTkD/3Ycd5r3tkacUzA6Q+6Hw9iHFLMtWsdXuh3WTiPkuAp2hnuk+9xAr3M9n2w6Moc0jHA8HUSsOuJ+fHCklWinK/It5UrzXdVLRI3OokLud11AoyRS0brrzwS0755I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774599588; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=okohqEoU1Mjfy3ZF+aKNpubORuXnkox4yr9vAlK52Cg=; 
	b=l3TxXJYBFxil711KtmFPvv0EzZ5JKR4Qljo7bV9cBjNqxVTgZxIcI6IuZJi7sAaWlw05iKQMFRTcQQlF91XWwYF2ZhXNyrzsyImdxYnmwdcPnPxhyoBp5nEUszles5aODujL3mWjAJwaRnsVY6SrMGsOvpMxxvMsn5/P64i7s1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774599588;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=okohqEoU1Mjfy3ZF+aKNpubORuXnkox4yr9vAlK52Cg=;
	b=UwjFhgFScYw5fXeGL5/9ZD0/SMKoL+cY5GrBoq9oIRekfw+0sStR6o+Euxahaoan
	M9GBA1wNTor7SOgkXINfYkirBxMsa5zVhKxbB2SZXLpd0LoY7boQeyjVImaC7JuQCf3
	+0WjQUslHfYKZij4IL9KmgFnfJM9zz/7bmxRwyn4=
Received: by mx.zohomail.com with SMTPS id 1774599586363555.7214675351182;
	Fri, 27 Mar 2026 01:19:46 -0700 (PDT)
Date: Fri, 27 Mar 2026 08:19:37 +0000
From: Yao Zi <me@ziyao.cc>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Hans Zhang <18255117159@163.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe
 Root Ports
Message-ID: <acY9kUDAuexKy19C@pie>
References: <20260227181925.52475-1-me@ziyao.cc>
 <20260227181925.52475-3-me@ziyao.cc>
 <wykv2qz7lt3v67n3hjjqlprjbhlv7eur5wiw2reagvu2sq3dhc@4y5x2yok4kho>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wykv2qz7lt3v67n3hjjqlprjbhlv7eur5wiw2reagvu2sq3dhc@4y5x2yok4kho>
X-ZohoMailClient: External

On Thu, Mar 26, 2026 at 10:15:16PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Feb 27, 2026 at 06:19:25PM +0000, Yao Zi wrote:
> > Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> > states for devicetree platforms") force enable ASPM on all device tree
> > platform, the SG2042 root port breaks as it advertises L0s and L1
> > capabilities without supporting it.
> > 
> > Provide a platform-specific initialization hook to override the L0s and
> > L1 support advertised in LNKCAP register of SG2042 Root Ports, so it
> > doesn't try to enable those states.
> > 
> > Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
> > Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > ---
> >  drivers/pci/controller/cadence/pcie-sg2042.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> > index 0c50c74d03ee..3142f82bd393 100644
> > --- a/drivers/pci/controller/cadence/pcie-sg2042.c
> > +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> > @@ -32,6 +32,25 @@ static struct pci_ops sg2042_pcie_child_ops = {
> >  	.write		= pci_generic_config_write,
> >  };
> >  
> > +static int sg2042_pcie_disable_l0s_l1(struct cdns_pcie_rc *rc)
> > +{
> > +	struct cdns_pcie *pcie = &rc->pcie;
> > +	u32 pcie_lnkcap_off;
> > +	u32 lnkcap;
> > +
> > +	pcie_lnkcap_off = CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP;
> > +
> > +	lnkcap = cdns_pcie_rp_readw(pcie, pcie_lnkcap_off);
> > +	lnkcap &= ~PCI_EXP_LNKCAP_ASPMS;
> > +	cdns_pcie_rp_writew(pcie, pcie_lnkcap_off, lnkcap);
> > +
> 
> cadence-host driver already has cdns_pcie_host_init_root_port() to initialize
> the Root Port. Since your intention is to modify the LNKCAP field, which belongs
> to the Root Port, you should do that in cdns_pcie_host_init_root_port() instead.
> I see no sg2042 specific registers used in this patch, so just set a flag in
> this driver like 'broken_aspm' and clear PCI_EXP_LNKCAP_ASPMS if set in
> cdns_pcie_host_init_root_port().

Okay, it makes sense. Will do it in v3.

> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

Regards,
Yao Zi
