Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D632E6BD;
	Tue,  4 Aug 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867529; cv=none; b=rZer6mUx/WOfM9csj13DNaJeyb7Y0IG+96r6zppu+ZE6euAzROagWS/hQ+1+9YPbtzFvGK0p1Is6dL5KBICWFInmyuj32oVhgTXvSyA4bRlU10K+zwT5CDt77vtPIQDokv6osYBfXX414K8Vnwf/182Hv27fNtgTmjvQ1PA/JTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867529; c=relaxed/simple;
	bh=LW2ITypd6tg5gKL3iF/5UMbxTReTj5ZF3A4KI8v9fl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NV+TLhNcXEZJP941YX4rF8CwC1oxpGMki1YCdWGVNzBEaAFT1AH8FIgHW9LrVkFbnjHxjNKLJJ7JplntqvHl9yrJW9DUef7KOuhdGacMsimGE+EbVLM/B13gvCeCMJBNp4fdbZrzFUrRDYQGK6dKSW/rXAAzxe+LTF2fDubOCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3uYFMY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3uYFMY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C547A1F00A3A;
	Tue,  4 Aug 2026 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785867528;
	bh=HxUB6Z4K2mKjd5j2OvvjwhXSYwxJocB8Ks6X4koqnfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=J3uYFMY1dmtijKe5ohxsAzFTRApS3sfdyCi5AMyHvUewsSjxGnsTOSQK+p+zzMz4y
	 j8UXER1eACo3HzW/tcEkpJeWwqMbdyDuD3Di0hxYpM6W5h6bioMHPav2CJHMVH3dKe
	 U24sdl47d0N6hTMqmlmDjyDCW2LH2fMXH2FBsG1G0ZZw5cK2tOrqFQErWVSZigf72j
	 2Qv/qyWFPTuwvrs6cO397CcmsCl+RZM2J8fcuEsCYyQ8qW3RAyUu05pWpBJINK5WkD
	 PjLyurGWHSexn5VMdtCC4vxU+9qIf0+UWGYwqrOey+UFVdoNy0RKMCr3IVQIf36Stp
	 ordibkCsZqDqg==
Date: Tue, 4 Aug 2026 13:18:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms
 with RC power loss
Message-ID: <20260804181846.GA1846400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB12019D498722B4C8A94C2A1A28CD42@GV2PR04MB12019.eurprd04.prod.outlook.com>

On Tue, Aug 04, 2026 at 06:32:26AM +0000, Hongxing Zhu (OSS) wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: Monday, August 3, 2026 11:33 PM
> ...

> > On Thu, Jul 30, 2026 at 07:09:13AM -0500, Bjorn Helgaas wrote:
> > > On Thu, Jul 30, 2026 at 08:16:36AM +0000, Hongxing Zhu (OSS) wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Sent: Thursday, July 30, 2026 6:30 AM
> > > > ...
> > >
> > > > > On Fri, Jul 17, 2026 at 03:41:21PM +0800, hongxing.zhu@oss.nxp.com
> > wrote:
> > > > > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > >
> > > > > > Some platforms like i.MX power off their PCIe RC
> > > > > > controllers during system suspend, requiring full
> > > > > > re-initialization on resume. These platforms need to enter
> > > > > > L2 state to properly notify endpoints before power loss.
> > > > > >
> > > > > > According to PCIe base spec r7.0, sec 5.2, the system
> > > > > > software should transition the device into D3Hot before
> > > > > > broadcasting the PME_Turn_Off message to initiate L2
> > > > > > entry. However, some endpoint devices fail the D3cold
> > > > > > capability check in pci_host_common_d3cold_possible(),
> > > > > > which would normally prevent L2 entry.
> > > > >
> > > > > Wakeup devices that don't support PME from D3cold will fail
> > > > > the D3cold capability check, but I don't think those are the
> > > > > problem you're solving.
> > > > >
> > > > You're right.
> > > >
> > > > > This appears to handle devices that are not in D3hot, and
> > > > > that's not a property of the endpoint; it's a property of
> > > > > its driver.  Is the problem here that some driver didn't put
> > > > > its device in D3hot?
> > > > >
> > > > I observed some endpoint devices failing the D3cold capability
> > > > check, but I haven't identified the root cause.
> > >
> > > Seems like some instrumentation in
> > > pci_host_common_d3cold_possible() could tell us which
> > > devices/drivers are relevant.
> > >
> > > > > > For platforms where the RC loses power during suspend, L2
> > > > > > entry is essential regardless of D3cold support, as the
> > > > > > link will be lost anyway.  Add a suspend_poweroff flag to
> > > > > > force L2 entry in such cases, and enable it for i.MX PCIe
> > > > > > controllers.
> > > > > >
> > > > > > Note: This violates the spec requirement that devices be
> > > > > > in D3Hot before PME_Turn_Off, but is necessary for proper
> > > > > > operation on platforms with RC power loss during suspend.
> > > > >
> > > > > If the device isn't in D3hot, it may still be active, and I
> > > > > think the PME_Turn_Off will abort any DMAs in progress,
> > > > > which doesn't sound like proper operation of the endpoint.
> > > >
> > > > You're correct - this isn't ideal for endpoint operation.
> > > > However, on i.MX platforms, the RC controller will lose power
> > > > during system suspend regardless. Without sending
> > > > PME_Turn_Off, endpoints would have no notification before the
> > > > link abruptly goes down.
> > >
> > > The PME_Turn_Off is some notification, but I don't think the
> > > endpoint can do DMA or MSI, so its driver won't be involved.  It
> > > may be able to do things internally, e.g., write caches to an
> > > SSD or transmit packets from its internal buffers.  But I think
> > > it might still lose power in the middle of operations like that,
> > > so it doesn't sound reliable.
> > >
> > > > This patch adds a flag to force L2 entry for such platforms,
> > > > choosing to notify endpoints (even if not ideal) rather than
> > > > having the link drop unexpectedly. I'm appreciated for
> > > > suggestions if there's a better approach to handle this
> > > > scenario.
> > >
> > > Mani recently added pci_suspend_retains_context(), and I think
> > > it returns "true" on i.MX.  But if the RC is powered off and all
> > > the devices need full re-initialization on resume, it sounds
> > > like it *should* return "false".
> > 
> > Right. pci_suspend_retains_context() was added just for that
> > purpose of telling client drivers to prepare for context loss. So
> > if this API returns 'false', then they should not hold the device
> > in D0.
>
> Thanks for your comments.
> 
> If I update dw_pcie_suspend_noirq() to use
> pci_suspend_retains_context() to determine whether to proceed with
> L2 entry and RC power down. The new logic would be changed as below:

I'm not suggesting using pci_suspend_retains_context() in
dw_pcie_suspend_noirq().  pci_suspend_retains_context() is for
endpoint drivers.

I think pci_suspend_retains_context() should return 'false' on any
platform where dw_pcie_suspend_noirq() is going to send PME_Turn_Off.
Sending PME_Turn_Off means we intend to remove main power.  When main
power is removed, devices will be in D3cold and they will not retain
their internal context.

If pci_suspend_retains_context() returns 'false' and
pci_host_common_d3cold_possible() returns also returns 'false', it
means some driver didn't put its device in D3hot when it should have.

In that case, I think you should either fix that driver so it *does*
put the device in D3hot (based on pci_suspend_retains_context()), or
just accept that you can't power off the RC.
