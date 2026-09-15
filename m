Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C81A2C04;
	Tue, 15 Sep 2026 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514064; cv=none; b=LxRPdmeJPEvHXLxTe8DvPvi2HKVhGBTsWaVE/OBKWN83DQXDVz5XcDe7WF6SwLTdoCyx5Jl0EQMUzf5jVmkD9ta8mxK3Er2zwGhr14sbu/TuAIarSsk+00lt0nkcJtNmg/Fkb6Oa87SwqsdQrB/RLu+A0ssN1jR3R5j9/eBVgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514064; c=relaxed/simple;
	bh=gSVCD7ttOBnaUuTZl1ZQHR+lieeaF8G2Z7XwYRI5ZuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U1TI7As+u+HaDuJET7ryI9PTkHWmWX7ZQ2Hy4e71JOKQxGvKzrA5QD8Qie7Br1L6P2Dt61BguhHTPgRlmqlMKpqB4yLzdLJxHs9c5vncbT5W0vZunTtkuAR4l6YNgfsDDkM2Xi7VhlNaoW9dwMQ1Q6go/ObFZumesEhAETpCw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmXOuZmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmXOuZmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58951F000FF;
	Tue, 15 Sep 2026 23:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789514062;
	bh=fus+PONEuzYkdGrcViZBwMcYzx5qWtxnJLG+dD5KPHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fmXOuZmk3F2RP+4+Sm96H06PqvphzqNP2SixH/6GNTX+guw8HD0uBgvZ5n2gk+hqH
	 MfObpryAjid5wvbcjDx+WCuOXjJfJ2lW4P0W0Ry6zSrzMVmiS8hcr/ehHF/AyF3LQu
	 pTCGV6Geymyx7+y+XYdz5M7HmQQM+WRaGPtRPfMoKyd+aBYG8FyQqzgDLnguEPxO34
	 rs/R5NhKc687ubyhy9NWtVc8Fo+S1vVVI5jVVqBTfsTSKbqJL+XVPaQUm5vxe7LvVw
	 jQBZbGTbgGcmcss7m8cFvzPpt/KyXRxAELd9ixqGDf0Bvc//fHtVlpE/itrf2+gGwq
	 erSKr2JDVeWdw==
Date: Tue, 15 Sep 2026 18:14:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
	Andrew Scull <ascull@google.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
Message-ID: <20260915231421.GA881410@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ibficaitalz4lacqffsrp4kuqzanxnxr2bwd6x5yti4mmfabf@h3y63kuz7fjh>

[+cc James, Andrew, Marc for guidance on generic arm64 PCIe error
recovery; beginning of thread:
https://lore.kernel.org/all/20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com]

On Tue, Sep 15, 2026 at 07:16:11PM +0200, Manivannan Sadhasivam wrote:
> On Fri, Sep 11, 2026 at 12:18:07PM -0500, Bjorn Helgaas wrote:
> > On Fri, Sep 11, 2026 at 08:17:29AM +0200, Manivannan Sadhasivam wrote:
> > > On Tue, Sep 08, 2026 at 06:00:30PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Aug 19, 2026 at 11:36:54PM -0700, Qiang Yu wrote:
> > > > > After a PCIe link goes down, software may still access the
> > > > > BAR (MMIO) space or configuration space of devices behind
> > > > > that link before recovery has run. As the link is down,
> > > > > these accesses never complete, resulting in a storm of
> > > > > Completion Timeout AERs.
> > > > 
> > > > What is special about qcom here?  It seems like the Completion
> > > > Timeouts and AER interrupts should happen with every PCIe
> > > > controller.
> > > 
> > > The special behavior which is common across many (not all) ARM
> > > SoCs is that they don't synthesize all-one response for
> > > completion timeouts, unlike RCs in x86 machines. Rather, they
> > > return AXI error response, resulting in CPU treating them as
> > > SError, in-addition to AER storm.
> > > 
> > > Commit message missed mentioning SError though.
> > 
> > I don't know how SError works, but this sounds like a pretty big
> > open issue with respect to RAS.  I don't think we want a kernel
> > panic because a device failed to respond to a config or MMIO
> > access, e.g., if a card or Thunderbolt cable got unplugged.

I still don't know anything about arm64 or SError, but I see these KVM
commits about using ESB to manage SError in some cases:

  0e5b9c085dce ("KVM: arm64: Consume pending SError as early as possible")
  472fc011ccd3 ("KVM: arm64: nVHE: Don't consume host SErrors with ESB")

I assume it's not possible or practical to use ESB in the native host
case to deal with issues like this in a generic way instead of the
vendor-specific feature Qcom is using here?

> > > > Is this mitigating an issue that will still happen on other
> > > > controllers and should be solved elsewhere, e.g., by changing
> > > > the software that accesses the BAR to look for the error
> > > > responses it gets when the Completion Timeout happens?
> > > 
> > > That would be too late as we don't get a proper error response.
> > > That's why this patch is used.
> > > 
> > > > The patch refers to the ECAM blocker (which I assume affects
> > > > config accesses) and doesn't mention MMIO.  Is the SLV_AXI
> > > > stuff for MMIO?
> > > 
> > > ECAM blocker is a Qcom's custom implementation which prevents
> > > the config access to go out of the link and terminate the
> > > request properly. And yes, it doesn't affect MMIO like BAR.
> > 
> > The commit log implies that the patch blocks both config and MMIO
> > accesses: "software may access MMIO or config space ... Use ECAM
> > blocker to drop these accesses."  If the ECAM blocker only affects
> > config accesses, we need to reword that description.
> 
> Sorry, ECAM blocker blocks both config and MMIO access, my bad.
> 
> > If this patch doesn't affect MMIO accesses, I assume they will
> > still fail and lead to SError?  I'm a little dubious about the
> > utility of this because I assume most runtime driver accesses will
> > be to MMIO space, not config space.
> > 
> > I assume this is also racy: any config access that happens in the
> > window between the link going down and the ECAM blocker being
> > enabled will still fail and result in SError, right?
> 
> That's true. But this is our best effort to avoid SError.
> 
> > > > Assume the root port leads to a switch, and the switch has two
> > > > links to downstream devices.  If one of the switch downstream
> > > > links goes down, is this going to kill the device on the other
> > > > link that is still up?
> > > 
> > > ECAM blocker is only enabled when the PCIe link to the Root Port
> > > goes down. We don't get LDn interrupt when the switch downstream
> > > link goes down. In that case, the switch should synthesize the
> > > error response if the CPU tries to access the unavailable
> > > device.
> > 
> > For config or MMIO reads targeting a device below a switch, if the
> > link to the device is down, I think the switch will return an
> > Unsupported Request completion without data (PCIe r7.0, sec
> > 2.3.1.1).
> 
> Yes, that's my understanding as well. And I believe SError won't
> happen if the RC gets Unsupported Request (UR). SErrors are mostly
> associated with Completion Timeouts and that will only happen if the
> PCIe link between the Switch downstream port and Endpoint is still
> active and the Endpoint becomes inactive (rare).

OK, I guess this part of handling of UR/CT is device-specific, not
prescribed by the PCIe spec.

> But if the Endpoint gets removed, then the link between the Port and
> the Endpoint will go down and the Port will return Unsupported
> Request to the RC for any read request.
> 
> > The PCIe spec doesn't prescribe whether RC synthesizes data to
> > complete the read, but x86 RCs typically synthesize ~0 data.  I
> > guess some arm64 RCs assert SError instead of completing the read.
> 
> Yes, that's the implementation issue in some ARM SoCs.
> 
> > IIUC, if the link from the RP goes down, we'll take the LDn
> > interrupt, enable ECAM blocker, and future config reads would
> > return ~0.  But if a link below a switch goes down, there's no LDn
> > interrupt and it sounds like future config reads would result in a
> > UR Cpl and SError.
> 
> Last sentence needs correction. UR won't trigger SError, but only
> Completion Timeouts will. So when a device connected to a PCIe
> switch gets removed, it won't result in SError as long as the
> downstream port responds with UR.
> 
> But in the case of Qcom RPs, most of the time, Completion Timeouts
> are observed when the CPU issues read to device whose link is down.
> That's why we need this ECAM blocker feature to avoid it (not all
> the time though as you noted above, but still better than nothing).
> 
> - Mani
> 
> -- மணிவண்ணன் சதாசிவம்
