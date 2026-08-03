Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85832B10D;
	Mon,  3 Aug 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771208; cv=none; b=MPTLAsBO2fEJc6XaPi5tvjl1xJolnORb/ijgp1mYbDHvrrj0iVT1TvJCEB6F1jMkGh1kyGgylRkeH6ZPOxlA7XQnU3UYBFQcIjqHMvwA+BFmBuJsDoSTvzD3+y8QY2cKFU+HlaYizp/oMoamY6CPUPenQAV5FkI7HXxAV0lkfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771208; c=relaxed/simple;
	bh=k5Kmssu1/Grg6vRwr4FEdR4G2wuL/JL16WzdSa0VqMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB/vx9YNneTdRZJQ8dkaK9klqNN5CqhFa5hUIYzEu5WLEVVTDd76P4Erds0u5kr2uHrwqXK74SEzdHKi+wiUlRb+tuJZJBWyaPNCNCA//IAw6pd3pAotpGq8nOarNKskph3ES1gJIJ1pMwebxvZIzI2FAMWeZRwNPWLSbmCvpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyFB74lh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyFB74lh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1651F00A3D;
	Mon,  3 Aug 2026 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785771203;
	bh=Vg0PctaQtBQrf+tl8AD8zggSqyHRuQxDtAbyWu+DxcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FyFB74lh75/iAlB/t5+krj7Omm8rH1vuVjxw1+YCRpRHUMKmXPL4EcwtWcV2wR9O0
	 YF3lBtpPhs4cUGThZcEDwxQbeP3i5LvflOLC8CYQdNVSEmO590GT7Eh6e6P3oUKO+s
	 PpeGBnCblW+YF85sSCi5gI+qElYNNMoU64rsldqWdPZ59BIo3Fv8NRVt5elR0tS12N
	 R6ZCgkhZ5xWugaNq22hNVX4FIOMqKyWaKETl9sZBAw00t7qiS4wsgM7GL6rFFuUxFR
	 lfHHyfRJPMT5GtZW/rwXOew3eohNRd3eG6xA3dj5/VANw8MVUakNDnfDfCtpz4gChT
	 vi5lVejnRBhqQ==
Date: Mon, 3 Aug 2026 17:33:12 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>, 
	Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms
 with RC power loss
Message-ID: <hyfto5fjcda4aaknwxxxx6wn6ej3tmbhzxaqykakubahw7xxjj@zxixpkhs7khh>
References: <GV2PR04MB12019096F2A9E8337F2A1BF9F8CC92@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <20260730120913.GA1497203@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730120913.GA1497203@bhelgaas>

On Thu, Jul 30, 2026 at 07:09:13AM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 30, 2026 at 08:16:36AM +0000, Hongxing Zhu (OSS) wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Thursday, July 30, 2026 6:30 AM
> > ...
> 
> > > On Fri, Jul 17, 2026 at 03:41:21PM +0800, hongxing.zhu@oss.nxp.com wrote:
> > > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > >
> > > > Some platforms like i.MX power off their PCIe RC controllers during
> > > > system suspend, requiring full re-initialization on resume. These
> > > > platforms need to enter L2 state to properly notify endpoints before
> > > > power loss.
> > > >
> > > > According to PCIe base spec r7.0, sec 5.2, the system software should
> > > > transition the device into D3Hot before broadcasting the PME_Turn_Off
> > > > message to initiate L2 entry. However, some endpoint devices fail the
> > > > D3cold capability check in pci_host_common_d3cold_possible(), which
> > > > would normally prevent L2 entry.
> > > 
> > > Wakeup devices that don't support PME from D3cold will fail the
> > > D3cold capability check, but I don't think those are the problem
> > > you're solving.
> > > 
> > You're right.
> > 
> > > This appears to handle devices that are not in D3hot, and that's
> > > not a property of the endpoint; it's a property of its driver.  Is
> > > the problem here that some driver didn't put its device in D3hot?
> > > 
> > I observed some endpoint devices failing the D3cold capability
> > check, but I haven't identified the root cause.
> 
> Seems like some instrumentation in pci_host_common_d3cold_possible()
> could tell us which devices/drivers are relevant.
> 
> > > > For platforms where the RC loses power during suspend, L2 entry
> > > > is essential regardless of D3cold support, as the link will be
> > > > lost anyway.  Add a suspend_poweroff flag to force L2 entry in
> > > > such cases, and enable it for i.MX PCIe controllers.
> > > >
> > > > Note: This violates the spec requirement that devices be in
> > > > D3Hot before PME_Turn_Off, but is necessary for proper operation
> > > > on platforms with RC power loss during suspend.
> > > 
> > > If the device isn't in D3hot, it may still be active, and I think
> > > the PME_Turn_Off will abort any DMAs in progress, which doesn't
> > > sound like proper operation of the endpoint.
> >
> > You're correct - this isn't ideal for endpoint operation. However,
> > on i.MX platforms, the RC controller will lose power during system
> > suspend regardless. Without sending PME_Turn_Off, endpoints would
> > have no notification before the link abruptly goes down.
> 
> The PME_Turn_Off is some notification, but I don't think the endpoint
> can do DMA or MSI, so its driver won't be involved.  It may be able to
> do things internally, e.g., write caches to an SSD or transmit packets
> from its internal buffers.  But I think it might still lose power in
> the middle of operations like that, so it doesn't sound reliable.
> 
> > This patch adds a flag to force L2 entry for such platforms,
> > choosing to notify endpoints (even if not ideal) rather than having
> > the link drop unexpectedly. I'm appreciated for suggestions if
> > there's a better approach to handle this scenario.
> 
> Mani recently added pci_suspend_retains_context(), and I think it
> returns "true" on i.MX.  But if the RC is powered off and all the
> devices need full re-initialization on resume, it sounds like it
> *should* return "false".

Right. pci_suspend_retains_context() was added just for that purpose of telling
client drivers to prepare for context loss. So if this API returns 'false', then
they should not hold the device in D0.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
