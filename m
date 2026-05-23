Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509CA3090D9;
	Sat, 23 May 2026 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779527682; cv=none; b=kPJIlGOIVGOoOM5bY0XWLAhZMSsHcS43OFmksHtfmsBR6rEhSBD0No7VhimRAGzbdlhZoHXU4kmvwDfgyrR5NTbcQDBSlMmfMaw1tL5LcTi49MyhxnrOmzG6EoVyr0lTulrmKc7prjyr6lZ/jZ3HDEfcrBFVS4ouMnRc0dv4CBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779527682; c=relaxed/simple;
	bh=o/jc2dgMDSQqc/gI/pFyISCitzuTchbB+ASfJAx2ekQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSkoaeuAsD8MRdsisc1swyoBozZMrtcg48y13GWVe3MbTXYjHSIbxrKtlHrvDq9Zs8IfAFFUut3mqaWCjzZk13bJZccYLx9UYem4d0HOKFUeqzhCFDwbPdjSVmJ+m6iRHh1jLzfRQOKt2MSzq2ApDp+F5+cE74zt4GkFyM5MKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrFHY/vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrFHY/vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FC91F000E9;
	Sat, 23 May 2026 09:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779527681;
	bh=kvkwJV4uc2vp6W6UJgKhJPxtWVlxGXEgWLFdwIFHlFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RrFHY/vmMfkvufgW9eHYEzrv18yAvY2JN2O7kBNfkxtosQEkO9Us2+/z0R3GamOsz
	 dQjwpxmxZ8/5r7uXzsLwKdikEHAKtfvXbLd25T2OYvE9TvXAgJKjEV4bvEAOg+dJ9f
	 3CuEfrIacArrKRwSF4nTAqDRxh+zbrXcjbgWBN9k0oX5G9Pk86MwKdIAPlxvLIaKqD
	 omBH52MM0vq3TjY4HnsnObwtIECigZmZiXmTCYPbq7gKhCzzVwYN7j+JZeZy4Bp7T0
	 ez/T+zkIN6X5Fj6iK1fmkyuLzx3o26f5a034EOa8Os/2xGe2fcNJscxc4A7f9vIXFi
	 xZwQUj8/Zbv0w==
Date: Sat, 23 May 2026 14:44:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/4] PCI: Indicate context lost if L1ss exit is broken
 during resume from system suspend
Message-ID: <yqqvmiq7tdsul3m7hguhakgrfyhdz7tjakgjnvtsdzzw3gqaak@oj43wdjywk3y>
References: <20260519-l1ss-fix-v2-2-b2c3a4bdeb15@oss.qualcomm.com>
 <20260522232110.GA258915@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522232110.GA258915@bhelgaas>

On Fri, May 22, 2026 at 06:21:10PM -0500, Bjorn Helgaas wrote:
> On Tue, May 19, 2026 at 01:41:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > The PCIe spec v7.0, sec 5.5.3.3.1, states that for exiting L1.2 due to an
> > endpoint asserting CLKREQ# signal, the refclk must be turned on no earlier
> > than TL10_REFCLK_ON, and within the latency advertised in the LTR message.
> > This same behavior applies to L1.1 as well.
> 
> It sounds like only the "within the latency advertised in the LTR
> message" part is relevant in this case, and there's no issue with the
> "no earlier than TL10_REFCLK_ON" part?
> 

Yes, that's true. I took the exerpt from the spec here, but there is no issue
in enabling REFCLK no earlier than TL10_REFCLK_ON.

> > On some platforms like Qcom, these requirements are satisfied during OS
> > runtime, but not while resuming from the system suspend. This happens
> > because the PCIe RC driver may remove all resource votes and turns off the
> > analog circuitry of PHY during suspend to maximize power savings while
> > keeping the link in L1ss.
> > 
> > Consequently, when the endpoint asserts CLKREQ# to wake up, the OS must
> > first resume and the RC driver must restore the PHY and enable the REFCLK.
> > When this recovery process exceeds the L1ss exit latency time (roughly
> > L10_REFCLK_ON + T_COMMONMODE), the endpoint may treat it as a fatal
> > condition and triger Link Down (LDn). If the endpoint device is used to
> > host the RootFS, it will result in an OS crash. For other endpoints, it
> > may result in a complete device reset/recovery.
> 
> s/triger/trigger/
> 
> > So to indicate this platform limitation to the client drivers, introduce a
> > new flag 'pci_host_bridge::broken_l1ss_resume' and check it in the
> > pci_suspend_retains_context() API. If the flag is set by the RC driver, the
> > API will return 'false' indicating the client drivers that the device
> > context may not be retained and the drivers must be prepared for context
> > loss.
> 
> Thanks for the details, this makes sense to me now.
> 

Since we got an ack from NVMe maintainer, will you be queuing the series for
v7.2? I'd like this series to get soaked in linux-next for some time, though the
impact is very minimal.

- Mani

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pci.c   | 11 +++++++++++
> >  include/linux/pci.h |  2 ++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 38cc5172d259..a7d2cb69b42e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2910,6 +2910,8 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
> >   */
> >  bool pci_suspend_retains_context(struct pci_dev *pdev)
> >  {
> > +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> > +
> >  	/*
> >  	 * If the platform firmware (like ACPI) is involved at the end of system
> >  	 * suspend, device context may not be retained.
> > @@ -2917,6 +2919,15 @@ bool pci_suspend_retains_context(struct pci_dev *pdev)
> >  	if (pm_suspend_via_firmware())
> >  		return false;
> >  
> > +	/*
> > +	 * Some host bridges power off the PHY to enter deep low-power modes
> > +	 * during system suspend. Exiting L1 PM Substates from this condition
> > +	 * violates strict timing requirements and results in Link Down (LDn).
> > +	 * On such platforms, the endpoint must be prepared for context loss.
> > +	 */
> > +	if (bridge && bridge->broken_l1ss_resume)
> > +		return false;
> > +
> >  	/* Assume that the context is retained by default */
> >  	return true;
> >  }
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index f60f9e4e7b39..1e5b59fa258a 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -660,6 +660,8 @@ struct pci_host_bridge {
> >  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> >  	unsigned int	size_windows:1;		/* Enable root bus sizing */
> >  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> > +	unsigned int	broken_l1ss_resume:1;	/* Resuming from L1ss during
> > +						   system suspend is broken */
> >  
> >  	/* Resource alignment requirements */
> >  	resource_size_t (*align_resource)(struct pci_dev *dev,
> > 
> > -- 
> > 2.48.1
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
