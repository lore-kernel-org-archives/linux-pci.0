Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F10556B8A;
	Thu, 15 Oct 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097154; cv=none; b=czdyZyvcFV3mj7/CZrtb41HL6xx26T9S4Wrsz54htRZxDtnLktfeIR+CqaS5eMAajxRjrmMWpfSS07cGYUBtW8N2AsEDVm1JV3MG0ec5OiPIVCxdzbEYn7ae7AUvbGvUlU8QXbl6pl/dq+XBM4SgVt7g/NzrixgtL/fDbftk7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097154; c=relaxed/simple;
	bh=QGTlqUDYf6+dQWXvdOmPKU6UZQPh6NYY+Iaw7R+EOWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u8bS1IAQJvYx36640OLK/YgDNh7+yFaqtUQ1yVeOM4bMwTzN+gU9JKVIsr5gW+lu555ASAL1hEUr0Su/HbRBhuqY5v9EKJ87lE81M/YensF6tsGxbU6qrNdwP5m3i/Qh+JROwkAe9nc2Ka3fj612PX9HRE5CeKu/I20qXSnN4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax2S36Dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax2S36Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B655F1F000C4;
	Thu, 15 Oct 2026 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792097150;
	bh=JI8cos0DeBZwqgU3xgKQTheXjtcLPhmJEiAcd1ht54c=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ax2S36DhvUA8wOkFm9CYDx04QXNVvIwoMel2dK5m9srQ0Ek8mVfYd92X8iS+rCPt9
	 Tc7lhO6qisGJd0cSRW2jNB3X2yHspyE4+FLLQ4ZQ2Pfbl4nmC7ru2N81vUqQ/7FKeB
	 KMsyTOFmCbu2jdTAlKAvdzmbCyMvx0aIyMKPv8q4lHGJnBXQtW9vot86pXNrw5iaER
	 3LCEJKhgjMdQX5O6mnwIZNZq0b7nx5Bi9DNgq8BQycHtadTBGsjXXznnBZU6lK475F
	 nf1V+cKuxVobIcf1jZr4ZzL72H5GxQ4x0Hwu/+s3nXi3s9DhBC+MSCUfMAWGSp/N08
	 15rPgAFj5j2FA==
Date: Thu, 15 Oct 2026 15:45:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Semih Baskan <strst.gs@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Rosen Penev <rosenp@gmail.com>,
	Rani Hod <rani.hod@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 0/2] PCI: iproc-bcma: Use EROM instead of devicetree
Message-ID: <20261015204549.GA1796999@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7cf09c5-dba1-4501-b93e-ce4ad555edeb@broadcom.com>

On Thu, Oct 15, 2026 at 12:10:22PM -0700, Florian Fainelli wrote:
> On 10/15/26 11:51, Semih Baskan wrote:
> > > Humm, this is not materially different for me before/after applying tihs
> > > patch and unfortunately but here is what I am getting with these two
> > > patches applied on top of Linus' master at
> > > 0fcb05b72344f40806cbe810de8872f1698bf053:
> > [...]
> > > Unhandled fault: external abort on non-linefetch (0x1008) at 0xc896df40
> > [...]
> > > r3 : c896df40  r2 : 0000ffff  r1 : 00000f40  r0 : c1ce1a00
> > [...]
> > >    pci_host_probe from iproc_pcie_setup+0x8a0/0xd94
> > >    iproc_pcie_setup from iproc_pltfm_pcie_probe+0x10c/0x1d4
> > 
> > The series only changes the pcie-iproc-bcma path, and this kernel probes
> > the controller with pcie-iproc-platform, so the patches do not run here.
> 
> Yes, clearly not enough coffee, thank you Semih.
> 
> > I think the abort is the read of APB_ERR_EN at offset 0xf40 (r1). I
> > measured the same on an RT-N18U (core revision 0x01) in September: the
> > platform-only kernel does not come up, and with this one line it boots
> > and enumerates the BCM4360 [1]:
> > 
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -1388,7 +1388,7 @@
> >           break;
> >       case IPROC_PCIE_PAXB:
> >           regs = iproc_pcie_reg_paxb;
> > -        pcie->has_apb_err_disable = true;
> > +        pcie->has_apb_err_disable = false;
> >           if (pcie->need_ob_cfg) {
> >               pcie->ob_map = paxb_ob_map;
> >               pcie->ob.nr_windows = ARRAY_SIZE(paxb_ob_map);
> 
> Yes that works for me, and I was able to establish the last working baseline
> was v7.0 which did not include 76701239797698b620f2b7ec713fe08ef50ee664
> ("ARM: dts: BCM5301X: Describe PCIe controllers fully"), whereas v7.1 and
> onwards crashes unless your patch is applied.

I assume this means
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/iproc-bcma&id=9850907ee1dd4376c09c4129e0adbe3b39d191b7
is ok after all?

I do think it's unexpected that the kernel would panic even if the
correct driver hasn't been loaded.

If we don't have the right driver for the PCI controller, ideally the
wrong driver's .probe() method wouldn't be called at all, and if it
*is* called, its .probe() should fail gracefully.

The kernel shouldn't panic until it fails to find a root filesystem.

> Also, the good thing is that my local test bed has been resurrected and will
> be more regularly testing now.
> 
> > 
> > [1] https://lore.kernel.org/all/CAAsRjRnV-RTddO6h2XCUz2N5pB0pS8i_-_2XRcD=WOTA7AAFZQ@mail.gmail.com/
> > 
> > Best regards,
> > Semih
> 
> 
> -- 
> Florian
