Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD0430CD8;
	Tue, 15 Sep 2026 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492582; cv=none; b=Ziv/VuNXsP8ZB0shYu1+L7H5OQOAPPackOivLWyGzkRxhGXvF/rP3PSpVXcpQyzAWQVcYo0HWMKGUSBn28Fsq61r4XRVdeNjRfhR1hGlYXX1E0nNElE6RUNc+9b9YjX2KQHTZl43fHrIj2yTmO7lOKgXdhOP8oqEi9cH5kpH1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492582; c=relaxed/simple;
	bh=3iCawYRhIdUmQYjz7gwER5Gj/m2Nzx7Xsyj5Ck+jaD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0quMKvneZlmk0dnmPh6Y87kSxTLKtIKHYVkofpSqerxQaSbuIHV43CB3qSVLgaNtZ43vA8OlCmf4abUskrq+ecx3iowwucZW/UPDsLVsgKs/C2sb2BaES1Z2+YHzW/a/hiCpit9a2R290SChyAyl1gNk4m8VLxzfyzqmlVQQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/3J9QO3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/3J9QO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D54B1F00893;
	Tue, 15 Sep 2026 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789492580;
	bh=NqodpybQYzQMYyiAsa6eDfHM+c1mgTm+hYeUbm6qFwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B/3J9QO363ccRg3QEcgHDuPKpJXSjJy4w79gSCuLYEN00K3BtUwbJgWwu/vAzblVF
	 IX0fBQnIOyK+i6oY5V7LlWvfRtOSu8XK52alZI0snZegp0+gwcMr8k+6lsbJEbo+c+
	 M++k4A48R1/oFv+ZtgNy7Ped4VC3D/KUDboIjU/Vbk20p1Hp1GJ+mMgRbqHa3VvqPW
	 ZcIj6woUv/8TtWrQ7RbW2nhn0qkZy4PnA1GZXn0n6gpCFN8qFRr1gIX8hrYsTOf5n1
	 R5+cV91DrMTaOZk9bzR5pYlGovfyn7pKAUYgWSAFY4JzH01QKONluk3zMtHVGAaBJc
	 V8v9MpqQQD0Xg==
Date: Tue, 15 Sep 2026 19:16:11 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
Message-ID: <2ibficaitalz4lacqffsrp4kuqzanxnxr2bwd6x5yti4mmfabf@h3y63kuz7fjh>
References: <ienbx5wjdzhgtdtbmuqcc76ovzy5d4wid7x4nhq5e4bco6u4il@264db3obw2qq>
 <20260911171807.GA402207@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911171807.GA402207@bhelgaas>

On Fri, Sep 11, 2026 at 12:18:07PM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 11, 2026 at 08:17:29AM +0200, Manivannan Sadhasivam wrote:
> > On Tue, Sep 08, 2026 at 06:00:30PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 19, 2026 at 11:36:54PM -0700, Qiang Yu wrote:
> > > > After a PCIe link goes down, software may still access the BAR
> > > > (MMIO) space or configuration space of devices behind that link
> > > > before recovery has run. As the link is down, these accesses
> > > > never complete, resulting in a storm of Completion Timeout AERs.
> > > 
> > > What is special about qcom here?  It seems like the Completion
> > > Timeouts and AER interrupts should happen with every PCIe
> > > controller.
> > 
> > The special behavior which is common across many (not all) ARM SoCs
> > is that they don't synthesize all-one response for completion
> > timeouts, unlike RCs in x86 machines. Rather, they return AXI error
> > response, resulting in CPU treating them as SError, in-addition to
> > AER storm.
> > 
> > Commit message missed mentioning SError though.
> 
> I don't know how SError works, but this sounds like a pretty big open
> issue with respect to RAS.  I don't think we want a kernel panic
> because a device failed to respond to a config or MMIO access, e.g.,
> if a card or Thunderbolt cable got unplugged.
> 
> > > Is this mitigating an issue that will still happen on other
> > > controllers and should be solved elsewhere, e.g., by changing the
> > > software that accesses the BAR to look for the error responses it
> > > gets when the Completion Timeout happens?
> > 
> > That would be too late as we don't get a proper error response.
> > That's why this patch is used.
> > 
> > > The patch refers to the ECAM blocker (which I assume affects
> > > config accesses) and doesn't mention MMIO.  Is the SLV_AXI stuff
> > > for MMIO?
> > 
> > ECAM blocker is a Qcom's custom implementation which prevents the
> > config access to go out of the link and terminate the request
> > properly. And yes, it doesn't affect MMIO like BAR.
> 
> The commit log implies that the patch blocks both config and MMIO
> accesses: "software may access MMIO or config space ... Use ECAM
> blocker to drop these accesses."  If the ECAM blocker only affects
> config accesses, we need to reword that description.
> 

Sorry, ECAM blocker blocks both config and MMIO access, my bad.

> If this patch doesn't affect MMIO accesses, I assume they will still
> fail and lead to SError?  I'm a little dubious about the utility of
> this because I assume most runtime driver accesses will be to MMIO
> space, not config space.
> 
> I assume this is also racy: any config access that happens in the
> window between the link going down and the ECAM blocker being enabled
> will still fail and result in SError, right?
> 

That's true. But this is our best effort to avoid SError.

> > > Assume the root port leads to a switch, and the switch has two
> > > links to downstream devices.  If one of the switch downstream
> > > links goes down, is this going to kill the device on the other
> > > link that is still up?
> > 
> > ECAM blocker is only enabled when the PCIe link to the Root Port
> > goes down. We don't get LDn interrupt when the switch downstream
> > link goes down. In that case, the switch should synthesize the error
> > response if the CPU tries to access the unavailable device.
> 
> For config or MMIO reads targeting a device below a switch, if the
> link to the device is down, I think the switch will return an
> Unsupported Request completion without data (PCIe r7.0, sec 2.3.1.1).
> 

Yes, that's my understanding as well. And I believe SError won't happen if the
RC gets Unsupported Request (UR). SErrors are mostly associated with Completion
Timeouts and that will only happen if the PCIe link between the Switch
downstream port and Endpoint is still active and the Endpoint becomes inactive
(rare).

But if the Endpoint gets removed, then the link between the Port and the
Endpoint will go down and the Port will return Unsupported Request to the RC for
any read request.

> The PCIe spec doesn't prescribe whether RC synthesizes data to
> complete the read, but x86 RCs typically synthesize ~0 data.  I guess
> some arm64 RCs assert SError instead of completing the read.
> 

Yes, that's the implementation issue in some ARM SoCs.

> IIUC, if the link from the RP goes down, we'll take the LDn interrupt,
> enable ECAM blocker, and future config reads would return ~0.  But if
> a link below a switch goes down, there's no LDn interrupt and it
> sounds like future config reads would result in a UR Cpl and SError.

Last sentence needs correction. UR won't trigger SError, but only Completion
Timeouts will. So when a device connected to a PCIe switch gets removed, it
won't result in SError as long as the downstream port responds with UR.

But in the case of Qcom RPs, most of the time, Completion Timeouts are observed
when the CPU issues read to device whose link is down. That's why we need this
ECAM blocker feature to avoid it (not all the time though as you noted above,
but still better than nothing).

- Mani

-- 
மணிவண்ணன் சதாசிவம்
