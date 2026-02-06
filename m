Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2132D59E8;
	Fri,  6 Feb 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389213; cv=none; b=jGfdD+DmxTLScP1enTdsbSDOPqXaQgdYd0uvolheiEtpxcgTfa+NcDY6EEY/BxC5Jt0f9joEcvCkt8mnhry3Mkbi5Bjgf/30oZRzgT3D7fHL6IM2WQAjoq6yBiFh/BF07Cq2TN6cFdNUrI3b+5V9wXWhiyYKTS6XZtDfjRiWv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389213; c=relaxed/simple;
	bh=oI/+8Y9g+b+Nj4voIqjZWVWXtvHYS29DGjd7pwqfhOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YqCX0uXqlYbzD2CFHqrNvgXTRx9PyMoZ6pEfbgmdENR/bsScTFubti91hxwVhVrsybhcEEuKloq6fPN6U1XopDk6VCp7IpD9EJYX3K34SshExspSZYT2QFZSG+epoPyT0Oly/p+uWQNghAcaVhRz9RAh5PiQ5iFN6WKwbOqi4OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKnVPesX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKnVPesX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4E8C116C6;
	Fri,  6 Feb 2026 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770389213;
	bh=oI/+8Y9g+b+Nj4voIqjZWVWXtvHYS29DGjd7pwqfhOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZKnVPesXwCdK9NPqqNzn3y1Q9elrbLwvCvTXxPkCBOmRau5T7GiW0cNLin1ulKejX
	 O1202Nhktoi/OL1qesEkN77toIjEVRdhdwZHAioqzglKU9TYDGuKkIMYswWrWqfIAr
	 Arvi9JomO/Y+ZmeobwLMiBVC1/fvxK2kVhTaZ4d8wVsf21mQ886263wCVHcasTVvpU
	 8cG8Oht/qVi7HujWX3j9+cz/lc353eD8IU04G9+LR9DjF/Fr2D2SyDqN6PzqS6mxpn
	 iVGNLH1r72ByRxRx5HqSscmAtmpRInYmwEOCT+epFTGTyiA/2WYLim8RvSFahknlre
	 hkr6WKWbSoKIA==
Date: Fri, 6 Feb 2026 08:46:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20260206144651.GA57945@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206143014.GH943673@ziepe.ca>

On Fri, Feb 06, 2026 at 10:30:14AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 06, 2026 at 02:41:36PM +0530, Manivannan Sadhasivam wrote:
> > > It'd be worth expanding on this and what the effect of avoiding
> > > ACS SV is.  Does this change which devices can be safely passed
> > > through to virtual guests?  Does it give up isolation that users
> > > expect?
> > 
> > IMO, ACS SV is somewhat broken on this switch. But we can still
> > passthrough the downstream devices to the guests. There won't be
> > ACS SV apparently, but that's what users will get with broken hw.
> 
> I agree with this, the HW is very broken, let's have it at least
> work properly in Linux on bare metal out of the box.

I'm assuming the bare metal part could be done by something like this:

  @@ -2555,7 +2555,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
	   * ACS Source Validation errors on completions for config reads.
	   */
	  if (bridge && bridge->vendor == PCI_VENDOR_ID_IDT &&
  -	    bridge->device == 0x80b5)
  +	    (bridge->device == 0x80b5 || bridge->device == 0x8090)
		  return pci_idt_bus_quirk(bus, devfn, l, timeout);

> If someone really insists they need virtualization with narrow
> groups on this HW then they need to come with a more complete fix.
> Using VFIO is going to open up the reset flows that are problematic
> with the current solution, so it isn't like that is already working
> fully.

IIUC the current situation is that for these IDT switches, ACS SV is
enabled when downstream devices are passed through to guests, but
after these patches, it will no longer be enabled.

So my question is whether users are giving up some isolation.  If so,
should we even allow devices to be passed through to guests?  If we do
allow that, do users have any indication that they're not getting what
they expect?
