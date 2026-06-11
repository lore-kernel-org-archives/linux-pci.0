Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4E2BD58A;
	Thu, 11 Jun 2026 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158214; cv=none; b=rh09aZZ0P4RiI5bw5YJ0h5788qiV2UdJwkOtrdByWLFiAtrP+xcfJA9CHF9GrzT435IbsSoT8JY8f/quFL+KTqYNVp5pUAFPJ0lUg1pNPhpIBhVCdoXGomz6EA9MFT/85vpEjPD22LiZk51oZ5mhjk92x8ueRKYZGqSmMybkk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158214; c=relaxed/simple;
	bh=t2WRqjUsFELcSyHpuIYWTBzanLaf8gP8z46IW8xDkiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh8aSBOl2KCjRxB60WNlwD9cMB7aRhOYTHTihDbxxPbVEtB0b6k2I2KNV65qCxIVLUF9D5nwfYoGnEEf7nxvHncYAFnSQZmt73MD78mDRazfrDgfeBmRJnret5pNCq70/ZGjYXpE8rPKeEp4CHMvIrr6SemAe36snzuiiyuQQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEK4OmPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEK4OmPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87C91F00898;
	Thu, 11 Jun 2026 06:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781158213;
	bh=rKMmMKeuz2fRooQhiP60q8uhlHxR04FyvuIbk8BELm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JEK4OmPQqu/AINjDWh7OeWFdsCKnRRBZo7pwUtVTSgBjwfAZE9reBqrQgsIt/TAJk
	 3Ydb8VFZ+SGE02xeyV1gmLiJSx6uwkJ5s4bUXbOA2Eimf+0rr5vWXuTYdpCYWfMN0M
	 V9OSJ6QdNopMijhZuxeFw2jRrS8RYfuwCKm8aseLa0c9V0vTDdZik09+FLH6UfbiJX
	 oX3B4jFQeO8VIMjvLnz/nyGXoTaeHMSQWjvB7knj/lb4wX3xU0a2mjWLzrwfHedFoy
	 TUEVe/wWovnQii8IgaJz66lLraFMn+Zc0kE5QvRLYGiluoaXF5YHobmUSyRaujyned
	 YjxYpEXktqICA==
Date: Thu, 11 Jun 2026 08:10:05 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"manivannan.sadhasivam@oss.qualcomm.com" <manivannan.sadhasivam@oss.qualcomm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Message-ID: <6ouch5ybqk7gws3yrvc2sylq67nioqva6klc7o7wcgbpobs2lu@ioscmsg6ufyx>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
 <20260609-unique-magnificent-eel-eb623f@quoll>
 <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <mvxoynvocxcalxcwogbiovg5yurjczxqfu2fqkji33bunmlplz@zxqjsdjts65j>
 <VI0PR04MB12114DBDD65F25FB615EA8967921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <ihrmgh6etb2n5zqjbrykfjjms4a6zgpzwjgrd3rvy24jufbss7@f4nfxrp7jksy>
 <VI0PR04MB12114DA25D08329D3DC2C3ADA921B2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB12114DA25D08329D3DC2C3ADA921B2@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Thu, Jun 11, 2026 at 03:59:28AM +0000, Sherry Sun wrote:
> > On Wed, Jun 10, 2026 at 10:13:00AM +0000, Sherry Sun wrote:
> > > > On Wed, Jun 10, 2026 at 08:40:54AM +0000, Sherry Sun wrote:
> > > > > > On Tue, Jun 09, 2026 at 03:44:08AM +0000, sashiko-bot@kernel.org
> > wrote:
> > > > > > > Thank you for your contribution! Sashiko AI review found 1
> > > > > > > potential
> > > > > > issue(s) to consider:
> > > > > > > - [Medium] The `vpcie3v3aux-supply` property describes a
> > > > > > > non-existent
> > > > > > hardware feature on the M.2 Key E connector to work around a
> > > > > > software policy.
> > > > > >
> > > > > > Feels valid. Describe which pin on M2 connector are you representing.
> > > > > >
> > > > >
> > > > > Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources
> > > > > and Grounds.
> > > > >
> > > > > PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The
> > > > > voltage source, 3.3 V, is expected to be available during the
> > > > > system’s stand-by/suspend state to support wake event processing
> > > > > on the communications card.
> > > > >
> > > > > But the current vpcie3v3-supply may be gated off during system
> > suspend.
> > > > > So I  tried to add vpcie3v3aux-supply to let this 3.3 V power
> > > > > source always on for PCIe M.2 Key E connector. That means
> > > > > vpcie3v3aux-supply and vpcie3v3-supply actually refer to the same 3.3 V
> > power source.
> > > > >
> > > > > @Mani, do you think this is reasonable? Or do you have any other
> > > > > better solutions? Thanks!
> > > > >
> > > >
> > > > There is no Vaux defined in the M.2 spec. So you cannot define that
> > > > supply in the binding. You can define the custom Vaux supply as a
> > > > fixed regulator in DT and mark it always on so that it is keeps supplying
> > 3.3v to the card.
> > > >
> > >
> > > Hi Mani, thanks for the suggestion, but adding an always on regulator
> > > may cause board power waste, current solution ensures the 3.3v
> > > regulator is only enabled when M.2 connector needs to work .
> > >
> > 
> > What do you mean by 'need to work'? For getting the M.2 card to work, you
> > already have 3.3v supply. If you want the board to be always ON, then you
> > need to supply 3.3Vaux, which should be always ON too.
> > 
> > But who is turning off vpcie3v3-supply? M.2 connector driver or the
> > platform?
> > 
> 
> Hi Mani,
> I'm not sure if I understand your question correctly, actually it's the platform
> driver that calls the M.2 connector driver to turn off vpcie3v3-supply.
> Take i.MX pci device as an example, 
> pm_suspend() -> imx_pcie_suspend_noirq() -> imx_pcie_host_exit() ->
> pci_pwrctrl_power_off_devices() -> pwrseq_power_off() ->
> pwrseq_unit_disable() -> pwrseq_pcie_m2_vregs_disable()
> 
> Taking back to M.2 Specification:
> PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The
> voltage source, 3.3 V, is expected to be available during the
> system’s stand-by/suspend state to support wake event processing
> on the communications card.
> 
> Per my understanding of the above, the M.2 Spec actually suggest the
> 3.3 V power source should not be turned off.
> Should we simply enable the 3.3 V power source in pwrseq_pcie_m2_probe()
> and remove the pwrseq_pcie_m2_vregs_unit_data?
> 

Just don't call pci_pwrctrl_power_off_devices() from the suspend path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
