Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF13CB54E;
	Sat, 12 Sep 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226896; cv=none; b=VyrOf42ccMDFuG+G+vf336wY16jzIbgl3yTtpgbqdrQJImk+4XLaPgLTM9zJFwLVyX2kULogSWlROn/b4NrWJMqeqQc0gFZSm/szxAKstoYpuz3kf+3WZhwXceZox1U3NKGkimZTIO2VgNnCiYzikujrY7LkwSD+yNEyPaTzyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226896; c=relaxed/simple;
	bh=C+GYL5zWSQXhuCMfkiG066nZx9RMkyX4uKkBP2mVW+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nAq4NmuNh45PmuTbKFQcuArRqubN2kIO5J0ubVlbb2ukixSYGh31LvonfrwzLZ0pFS0axYUai84FWbkD5XJjHP24dRFQirhrVQEXBOQ77PDqxuxeIr9g2yFG9oKDBheq6b6b8OJR0aVvnT9Er3sYQ326SWUrfDPXTbLUtaGU1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0kvmxEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0kvmxEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC5E1F00893;
	Sat, 12 Sep 2026 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226895;
	bh=d3/1XudPwfoaNysGe5XmX06WJ0Ohb7EccJEDKvpTh4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=E0kvmxEdthYyugdQ7N7srOoNBTCqhyH9SKxiMcd5JZFWkhBpBbzW1kydYX07u90Qr
	 LziXAR3YCPJEpI0K4qkG8j0EPf1qo5C2reECxmYoRC2dQxAuqFMBr9/qxG80uvto1T
	 O5iFBB7G//4Jt5Qb7PCpTSPHvqQ2Qm67m0HztLHnPimTN7We3W8wDf1JH9UeCcjUMa
	 XPrlmUndQtM1MVQQzTFjzRe0/0bAAFDtgRoQ7KXNb4TniJxAqArSUbZPMfhfH8OvFj
	 5bsMkQJR7SfEfSEXUEfybXl3w38TGKShH/7p5YAaRsKf2CC1dwDwJGBglSyd7k5HdH
	 4E9FhR1pP0cww==
Date: Sat, 12 Sep 2026 10:28:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?B?V2lsY3p54omIw5Fza2k=?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH v9 3/3] PCI: Remove device links to PHY
Message-ID: <20260912152813.GA666557@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912152311.uq4z3hkmf5ylmpxh@skbuf>

On Sat, Sep 12, 2026 at 06:23:11PM +0300, Vladimir Oltean wrote:
> On Sat, Sep 12, 2026 at 09:02:07AM -0500, Bjorn Helgaas wrote:
> > On Sat, Sep 12, 2026 at 02:39:44PM +0300, Vladimir Oltean wrote:
> > > Hi Bjorn,
> > > 
> > > On Fri, Sep 11, 2026 at 05:12:09PM -0500, Bjorn Helgaas wrote:
> > > > [+cc Felix, author of device link leak fixes]
> > > > 
> > > > On Mon, Aug 10, 2026 at 03:43:15PM +0300, Vladimir Oltean wrote:
> > > > > This is practically a full revert of commit
> > > > > 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> > > > > and a partial revert of the device link pieces from commits
> > > > > dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
> > > > > 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> > > > 
> > > > Can we split this into three commits (dra7xx, cadence, keystone)?
> > > > This combined commit is applied on the pci/controller/misc branch, and
> > > > then we have conflicts between that branch and
> > > > pci/controller/dwc-dra7xx.
> > > > 
> > > > I think if we split this into three separate commits, we can apply the
> > > > dra7xx one on pci/controller/dwc-dra7xx and drop Felix's device link
> > > > leak fixes below so we don't clutter the git history with conflict
> > > > resolutions or irrelevant commits:
> > > > 
> > > >   https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=2b9a036b568c ("PCI: dra7xx: Fix device link leak when devm_phy_get() fails")
> > > > 
> > > >   https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=bdfdf654b4b2 ("PCI: dra7xx: Fix device links leak when dra7xx_pcie_enable_phy() fails")
> > > 
> > > Isn't this patch already merged in pci/next as
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d
> > > ?
> > 
> > Yes, it is, but until Linus pulls it, the PCI tree is a draft subject
> > to revision.  IMO the git history will be much cleaner.  The end
> > result will be the same but we won't have conflict resolutions and
> > fixes to code that was removed.
> 
> OK, and what is your request from me? Submit 3 patches as a replacement
> to this one against which tree?

Simplest would be three patches based on v7.3-rc1.
