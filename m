Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4EA30E83F;
	Sat, 12 Sep 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221732; cv=none; b=hjapRS3goT6MOh3Z5A7HfnWMKKiJ0H1p140xmpKmkpCvAmnaF1GyA4fjcu1HnWcWSN+J323W4Z52/0H4waVCohvyYfJVbzsVZV2D4/j6XqHSP7c/WIj64bKcVdTUNpjipz61IBabT3L9IGMYfVZlky6zO+qjU/Z48Ib9LuEt70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221732; c=relaxed/simple;
	bh=2YYCJ2s6GQYJpcQs9gm+aBIcu9XOuOO5fkBNS/DWslg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UvnjJf5vgh0Ict28eaah5sRT5rrHybWGXW1Dcov0L1SWGm1WTsJCA1CRylvfYykHJ/Eb32OS7aAHEWozUVm+boBTS6whdA+7nluiOasAfx/TIPWnmDgZtx8fpanMBXeWNAPQnL5+hPk1ZYRr9yli8/R70q6dpB+ZKSQOuoU09Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQxmc4al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQxmc4al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424521F00898;
	Sat, 12 Sep 2026 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789221728;
	bh=HhkQLlPB59P0XClAYNcVy9iMiNOvmVp4sSejcGpryII=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eQxmc4al0/OBE1frFyBPWrBQeC8rqLIOOFpOZ1Eh0/sVTb5pVrusuo+fUb3jR1S8c
	 iCeDUxE85eohxy69nT/S7tpQcSvSegbQ7TprbePLCJf5w+afOkgXJ++9Eip5QKqaJX
	 40VWN89atDSA/gAiV6anwIQO2gV/tE2mcF2kHChHcQK7Q2WkKbOcex/5hjNYo68t6N
	 Kb+HgNFEg+MlUa5SI2CIPu8He30HwygovEJqDyRaZr0EAjXTpUZYg+cK/aMk73Cbmv
	 zA/ZzF4MzI+qos/s6ZWYyX4HuuJkO2t/a5rvFBuT7uWS6oZjx0povsrmy32HQuvVNn
	 KfqOnvm9pDI4Q==
Date: Sat, 12 Sep 2026 09:02:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH v9 3/3] PCI: Remove device links to PHY
Message-ID: <20260912140207.GA655851@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912113944.cfs6tebsv2eqctvw@skbuf>

On Sat, Sep 12, 2026 at 02:39:44PM +0300, Vladimir Oltean wrote:
> Hi Bjorn,
> 
> On Fri, Sep 11, 2026 at 05:12:09PM -0500, Bjorn Helgaas wrote:
> > [+cc Felix, author of device link leak fixes]
> > 
> > On Mon, Aug 10, 2026 at 03:43:15PM +0300, Vladimir Oltean wrote:
> > > This is practically a full revert of commit
> > > 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> > > and a partial revert of the device link pieces from commits
> > > dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
> > > 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> > 
> > Can we split this into three commits (dra7xx, cadence, keystone)?
> > This combined commit is applied on the pci/controller/misc branch, and
> > then we have conflicts between that branch and
> > pci/controller/dwc-dra7xx.
> > 
> > I think if we split this into three separate commits, we can apply the
> > dra7xx one on pci/controller/dwc-dra7xx and drop Felix's device link
> > leak fixes below so we don't clutter the git history with conflict
> > resolutions or irrelevant commits:
> > 
> >   https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=2b9a036b568c ("PCI: dra7xx: Fix device link leak when devm_phy_get() fails")
> > 
> >   https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=bdfdf654b4b2 ("PCI: dra7xx: Fix device links leak when dra7xx_pcie_enable_phy() fails")
> 
> Isn't this patch already merged in pci/next as
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d
> ?

Yes, it is, but until Linus pulls it, the PCI tree is a draft subject
to revision.  IMO the git history will be much cleaner.  The end
result will be the same but we won't have conflict resolutions and
fixes to code that was removed.
