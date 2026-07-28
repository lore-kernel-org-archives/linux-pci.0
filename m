Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6746F49C;
	Tue, 28 Jul 2026 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265888; cv=none; b=mQwnXESxhdZKGgGfD4Xs7mNRZXXzBIR9UswXvuzW4PGO+gXsrwaw3AzBqq4SKcja8CBncDC9BPliF9ZC2Yxq2A8Vtdk95XbE42TUGRCfWQAJbl0tO8xXJWDT6NW+YuDZ79zxUx+fiJE03pBdpUPVes7lCG/iKmJx+wNgwWtHlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265888; c=relaxed/simple;
	bh=G7a5znlnMMtFqHXqlczFlNhb42klP6dvtpJdPwWSkIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BIasQBY3bzkmWQZ/GSVgxxRNdquk6p4sNP/VP+TUdqXE6eHUnVx17lriyzsTVJRSpngnMjLvGk7qH+0Igk27rDZooVQ2DYrc85bfrgLk/BfviW334//S+kQa9N6WYTeUitdUNz/5gWdskXmdYDqelebUtvRsduvUfbAcEaCaLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyKaiIMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyKaiIMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B6E1F00A3A;
	Tue, 28 Jul 2026 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785265886;
	bh=9AfpiNTnaTbBJgQl+OPk+AMQw8pM/0InoLiRQuUHOIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=FyKaiIMY1AzDCbXRa3zOxzqqlAi9A748oTQmc3v9xp6K7zd/L20qYz8ipS6K//djg
	 UO4VIdUj5XCQg7zL5gnL/cuuwCFwrG6mnMkHh400zeodUpTxbswgZz660Sc3xgQviv
	 IqLrCZBAftvTbDe/piSqiJkc6lEzm6geJSHcjsjIew17VA02zegB07vWl1XOB+dhnx
	 WgF0oelX6r6lOJ7gWJhUjc0OZJxHTyJeVT96Yk02EfbaCpeMSSKkhpqAjrGQiimwYO
	 GneuccKyxdlezDYvOx2uKpyTcVxIzDKwyyJEI/dkhM+TK7GIIWR2q5aUynXR/TcQnf
	 B9ujEWCsUlDPw==
Date: Tue, 28 Jul 2026 14:11:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <20260728191124.GA1386613@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1934c51592fc56c65232b1379680c52c6d0cea3.camel@intel.com>

On Tue, Jul 28, 2026 at 06:21:23PM +0000, Grumbach, Emmanuel wrote:
> On Tue, 2026-07-28 at 13:03 -0500, Bjorn Helgaas wrote:
> > On Thu, Jul 23, 2026 at 11:35:41AM +0000, Grumbach, Emmanuel wrote:
> > > On Thu, 2026-07-23 at 15:19 +0530, Manikanta Maddireddy wrote:
> > > > On 22/07/26 10:34 pm, Bjorn Helgaas wrote:
> > > > > > The problem was that we didn't show up at all in the
> > > > > > enumeration.
> > > > > > We
> > > > > > send a malformed TLP. I'm not quite an expert at this, but
> > > > > > our
> > > > > > PCIe
> > > > > > experts run a PCI analyzer on the enumeration on that
> > > > > > specific
> > > > > > platform and they saw that platform's PCI controller sets the
> > > > > > NoSnoop and Relaxed ordering bit in the TLP. According to the
> > > > > > spec
> > > > > > (which I ignore), the BE200 is supposed to return the TLP as
> > > > > > received, but we reply with 0 Attributes and the enumeration
> > > > > > doesn't
> > > > > > complete successfully.
> > > > > I'm curious about the details of this enumeration failure.  Do
> > > > > you
> > > > > know which TLPs had No Snoop and Relaxed Ordering set?  Per the
> > > > > PCIe
> > > > > spec, they shouldn't be set for the config requests used for
> > > > > PCI
> > > > > core
> > > > > enumeration.
> > > > > 
> > > > > At least*some* config reads to the BE200 must work; otherwise,
> > > > > we
> > > > > wouldn't know the Vendor or Device ID, which we need to apply
> > > > > the
> > > > > quirk.  So I think you should see something like this in dmesg,
> > > > > and
> > > > > BE200 would probably appear in lspci output:
> > > > > 
> > > > >    pci 0000:04:00.0: [8086:272b] type 00 class ...
> > > > > 
> > > > > Is the failure that iwl_pci_probe() itself fails somehow?
> > > > > 
> > > > > You mentioned that this happens on Jetson Thor, but I'm not
> > > > > sure
> > > > > what PCIe controller that is.  My guess is it might be Tegra264
> > > > > [1], which doesn't look like it's merged yet.
> > > > > 
> > > > > Thierry, Manikanta, do you have any insight into this?  Does
> > > > > this PCIe controller set No Snoop and Relaxed Ordering for some
> > > > > reason?  I don't think endpoint drivers are expecting that.
> > > > > 
> > > > > [1]https://lore.kernel.org/linux-pci/20260716-tegra264-pcie- 
> > > > > v8-0-23e51589229b@nvidia.com/
> > > > 
> > > > Hi,
> > > > 
> > > > Jetson Thor(Tegra264) is not setting NoSnoop and RlxdOrd bits in
> > > > config 
> > > > read TLP.
> > > > 
> > > > I made sure that both these bits are set in RP's DevCtl
> > > > 
> > > >                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+
> > > > UnsupReq+
> > > >                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr-
> > > > NoSnoop+
> > > > 
> > > > and dumped TLP header for a config read towards BDF 0x100 with
> > > > offset
> > > > 0x24.
> > > >     0x04000001      0x0000000f      0x01000024      0x00000000
> > > > 
> > > > I think dmesg and AER log with header information might help with
> > > > this 
> > > > particular issue.
> > > 
> > > Ok, so I checked again the logs and I was wrong.
> > > We do see the device in the enumeration, it does show up in lspci.
> > > Problems start when we want to access our registers.
> > > I attached the full dmesg output. In that log we try to load
> > > iwlwifi
> > > twice.
> > > 
> > > I'm adding here the snippet of the first load:
> > > 
> > > [   15.275887] iwlwifi 0001:01:00.0: Adding to iommu group 53
> > > [   15.279737] iwlwifi 0001:01:00.0: enabling device (0100 -> 0102)
> > > [   15.280047] iwlwifi 0001:01:00.0: HW_REV=0xFFFFFFFF, PCI
> > > issues?  \\ **
> > 
> > The "enabling device" message is from pci_enable_resources(), called
> > in the pci_enable_device() path.  The 0100 is from a config read of
> > PCI_COMMAND, and the 0102 is from adding PCI_COMMAND_MEMORY to enable
> > memory BARs.
> > 
> > The "HW_REV=" is from iwl_pci_probe(), which looks like the very
> > first
> > MMIO read to a BE200 BAR.
> 
> Indeed
> 
> > So I guess the theory is that Tegra264 set NoSnoop and/or RlxdOrd in
> > the MMIO read, BE200 didn't copy the attributes from the Request to
> > the Completion as required by PCIe r7.0, sec 2.2.9.1, and Tegra264
> > logged a Malformed TLP?
> 
> That's the assumption based on the AER log, yes.
> 
> > AFAICS we still don't know why Tegra264 would set NoSnoop and/or
> > RlxdOrd in the MMIO read.
> 
> Me neither but... I can't comment on that. And de-facto, once it does
> that, the BE200 replies with the NoSnoop and RlxOrd clear in the TLP
> which is then considered as a malformed TLP.
> 
> > Unless iwlwifi asked for NoSnoop and/or RlxdOrd to be set, I think
> > it's a potential problem for drivers if Tegra264 sets them.
> 
> I ... don't think we would do that. The driver would certainly not do
> that... Regarding the hardware itself, I can't comment, but I can check
> internally.

Right, I don't see any mention of PCI_EXP_DEVCTL_RELAX_EN or
PCI_EXP_DEVCTL_NOSNOOP_EN or even PCI_EXP_DEVCTL there.  And it would
have to be set in the Root Port for it to affect the MMIO read
request, not in BE200.  That would affect everything under the RP, so
I think these are probably most useful in the DMA direction where an
individual device can control its own Requests.

But the analyzer saw them set in the request from the Root Port, so
it's still a mystery why what happened.
