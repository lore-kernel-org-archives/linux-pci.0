Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DE401A26;
	Tue, 30 Jun 2026 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819872; cv=none; b=p+o4YX5L26KQaoPAYIjLBVFfdLTEWxouehYIwzMgz1w9qVjKkUSiE0gV0AGIJxuhlQwriWZimwCFJFrmXDnzLJLE+KvvSx+tK0xQNR1adCbozoWeJh53VHt8GvLlCKGQGJgWY+I4m+pbzoA3OkSIfve5ZvOYD/npSj5EzpP5+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819872; c=relaxed/simple;
	bh=5yq77nu9XP0da0HQr/0ginv99dRYo67hL0d3GpMJoM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALNvD9yfTpqsUpzesTz7SPMtsYiJ4iAnvIfineAH7I9z809zsV0rYOioFNBdHC8IbD1JMXyxYpxTZthU8vRVk5/bLCf6rGztjOf57nmax7+yMVntiQnEYIPOa0ehlor4axKcldYyszNsFNvru7d6qy7JAKvU60/KqMH6Z8DF3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERiLVI57; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERiLVI57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C467D1F000E9;
	Tue, 30 Jun 2026 11:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819871;
	bh=2KBDOll4GMj8Xfu4+L85xz6BotaANVhD9Ce6vFh6LHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ERiLVI57eEZpqup9A7Um99SlDXCimXro4YdJYEivIUVgGFlwn7spuweuA2iufdsi/
	 yHis0b92rWQk8YfxXmUgT1GJ0oyH/4PwVwl3I2uOm5hG2XfV6pheU2w71PTNZLSRKp
	 c8g8dqRAECK1sEUzJxExkvnIVmQVKd9/lDrVQozsyHZa3Jd+XLqmwdiCBYZhlnzk9d
	 /xkVSsbxM3lNIGL6zQAqyFFp7q5pJSZyJ0s3zuS8Gg56KuP3LXepVnpddqLAUdTgHr
	 tQYRpQeL2sy+eEtAqEhJcRMhngohKbN+pn9x35VWoQtRpmPQ/n7ajbOLkyiGJ5KsU3
	 1q9975ubJ9gbw==
Date: Tue, 30 Jun 2026 13:44:22 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"manivannan.sadhasivam@oss.qualcomm.com" <manivannan.sadhasivam@oss.qualcomm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Message-ID: <yzittnr2ebvzcozvoquvjiuxxh4a7wn5g4lqdyqmv663jutjii@bhfrxrs4oga6>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
 <20260609-unique-magnificent-eel-eb623f@quoll>
 <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <mvxoynvocxcalxcwogbiovg5yurjczxqfu2fqkji33bunmlplz@zxqjsdjts65j>
 <VI0PR04MB12114DBDD65F25FB615EA8967921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <ihrmgh6etb2n5zqjbrykfjjms4a6zgpzwjgrd3rvy24jufbss7@f4nfxrp7jksy>
 <VI0PR04MB12114DA25D08329D3DC2C3ADA921B2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <6ouch5ybqk7gws3yrvc2sylq67nioqva6klc7o7wcgbpobs2lu@ioscmsg6ufyx>
 <VI0PR04MB1211485955B552B1F2207680592182@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB1211485955B552B1F2207680592182@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Fri, Jun 12, 2026 at 10:52:10AM +0000, Sherry Sun wrote:
> > On Thu, Jun 11, 2026 at 03:59:28AM +0000, Sherry Sun wrote:
> > > > On Wed, Jun 10, 2026 at 10:13:00AM +0000, Sherry Sun wrote:
> > > > > > On Wed, Jun 10, 2026 at 08:40:54AM +0000, Sherry Sun wrote:
> > > > > > > > On Tue, Jun 09, 2026 at 03:44:08AM +0000,
> > > > > > > > sashiko-bot@kernel.org
> > > > wrote:
> > > > > > > > > Thank you for your contribution! Sashiko AI review found 1
> > > > > > > > > potential
> > > > > > > > issue(s) to consider:
> > > > > > > > > - [Medium] The `vpcie3v3aux-supply` property describes a
> > > > > > > > > non-existent
> > > > > > > > hardware feature on the M.2 Key E connector to work around a
> > > > > > > > software policy.
> > > > > > > >
> > > > > > > > Feels valid. Describe which pin on M2 connector are you
> > representing.
> > > > > > > >
> > > > > > >
> > > > > > > Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power
> > > > > > > Sources and Grounds.
> > > > > > >
> > > > > > > PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The
> > > > > > > voltage source, 3.3 V, is expected to be available during the
> > > > > > > system’s stand-by/suspend state to support wake event
> > > > > > > processing on the communications card.
> > > > > > >
> > > > > > > But the current vpcie3v3-supply may be gated off during system
> > > > suspend.
> > > > > > > So I  tried to add vpcie3v3aux-supply to let this 3.3 V power
> > > > > > > source always on for PCIe M.2 Key E connector. That means
> > > > > > > vpcie3v3aux-supply and vpcie3v3-supply actually refer to the
> > > > > > > same 3.3 V
> > > > power source.
> > > > > > >
> > > > > > > @Mani, do you think this is reasonable? Or do you have any
> > > > > > > other better solutions? Thanks!
> > > > > > >
> > > > > >
> > > > > > There is no Vaux defined in the M.2 spec. So you cannot define
> > > > > > that supply in the binding. You can define the custom Vaux
> > > > > > supply as a fixed regulator in DT and mark it always on so that
> > > > > > it is keeps supplying
> > > > 3.3v to the card.
> > > > > >
> > > > >
> > > > > Hi Mani, thanks for the suggestion, but adding an always on
> > > > > regulator may cause board power waste, current solution ensures
> > > > > the 3.3v regulator is only enabled when M.2 connector needs to work .
> > > > >
> > > >
> > > > What do you mean by 'need to work'? For getting the M.2 card to
> > > > work, you already have 3.3v supply. If you want the board to be
> > > > always ON, then you need to supply 3.3Vaux, which should be always ON
> > too.
> > > >
> > > > But who is turning off vpcie3v3-supply? M.2 connector driver or the
> > > > platform?
> > > >
> > >
> > > Hi Mani,
> > > I'm not sure if I understand your question correctly, actually it's
> > > the platform driver that calls the M.2 connector driver to turn off vpcie3v3-
> > supply.
> > > Take i.MX pci device as an example,
> > > pm_suspend() -> imx_pcie_suspend_noirq() -> imx_pcie_host_exit() ->
> > > pci_pwrctrl_power_off_devices() -> pwrseq_power_off() ->
> > > pwrseq_unit_disable() -> pwrseq_pcie_m2_vregs_disable()
> > >
> > > Taking back to M.2 Specification:
> > > PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
> > > source, 3.3 V, is expected to be available during the system’s
> > > stand-by/suspend state to support wake event processing on the
> > > communications card.
> > >
> > > Per my understanding of the above, the M.2 Spec actually suggest the
> > > 3.3 V power source should not be turned off.
> > > Should we simply enable the 3.3 V power source in
> > > pwrseq_pcie_m2_probe() and remove the
> > pwrseq_pcie_m2_vregs_unit_data?
> > >
> > 
> > Just don't call pci_pwrctrl_power_off_devices() from the suspend path.
> > 
> 
> Hi Mani, do you mean use dw_pcie_rp::skip_pwrctrl_off flag to avoid powering
> off devices during suspend and also not power on the devices in the init path?
> 

Yes, something along those lines.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
