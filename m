Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27D2C2363
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157568; cv=none; b=WR780csvF4SgYiQbl3o9mfnlHcLe2Cb6eUDYMxw15nj11ghp78dpC84+pR3Rug+K3SzFh4+UFVWBYfySRtTqGDyMnN4l/uzvsVm1rp487KpKALukYYyFtJtth2z+NauVuhNZTWKWmSofLH6JsDtjx/Rt2H2DnVv4pfLnGbv9KmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157568; c=relaxed/simple;
	bh=hBaAtGkm6b5nPan2JqXL9zO1AXTy45TtkpfZ0OQt2UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3qceW880Cau6cvvGjVayWgfnjVa1/+TEbS7UkQ7yR5j/moFe52u6UEcweqrEqtXt/R41ZRBOZJ5+R7jzdeuGgnrEMdXpTpOqf6FfPUy2vbxy+d3zZrOI5RT1QxWdZbr05N+OBUhBp8SdH2AxqbwYtIbVB3V+ZIQeL8CQVz9XKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opENHFyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opENHFyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC2A1F00893;
	Thu, 11 Jun 2026 05:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781157566;
	bh=Fyntgr8x1W0aiYM1+gEIFSAd+jEbz9QHnx/VG5oMKOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=opENHFyR2lntYzfj/Ruh7hlwtxRTk1yhIAQ0ojhmx+vjVv8AyJdukq4QrtsDJa0Zq
	 7lYROfn76CFoPWHIDFDviy07auNpZtSR3TeUdLZsd3iqJYut6eJr+cgTGuAPs0M0ma
	 r1AEccZhqNO9oBY37TdFJ5aOKmp+JA6Z8lhEj9QkA6/3IPH+16YDTTngNB36fUFyZs
	 f70yuncNDKJnHNUReLtW4uQYHQmOiQXmRXxbUBxgs+6XCp3j6ER31sS+Q3m2kU6qLA
	 4OH6Pdc4XB4E/VPmaf+HwycSZu+BhLsAwiaDBv7rY6AKxxBZf5F0QW2WlwNdPL3Ff9
	 BOwLl9do5Moxg==
Date: Thu, 11 Jun 2026 07:59:21 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
Message-ID: <kg7uvgl4kaupiea56e63xiikhl3xqtgug4dqynxchw7prgdo6t@gclq5wdan4tc>
References: <20260519195219.189323-1-marek.vasut+renesas@mailbox.org>
 <20260519202037.8BD001F000E9@smtp.kernel.org>
 <orrpfub5f2hkrgkmxrdtykhzmxyuclnky4dn6vnz3cgvvbdcvb@5altvzufcq53>
 <bc40e4c6-1922-4bce-99d1-341730a4e6f8@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc40e4c6-1922-4bce-99d1-341730a4e6f8@mailbox.org>

On Wed, Jun 10, 2026 at 08:50:58PM +0200, Marek Vasut wrote:
> On 6/10/26 7:11 PM, Manivannan Sadhasivam wrote:
> 
> [...]
> 
> > > > +static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
> > > > +					struct pci_dev *dev)
> > > > +{
> > > [ ... ]
> > > > +	if (pcie_get_mps(dev) > 256) {
> > > > +		pci_info(dev, "Limiting MPS to 256 bytes\n");
> > > > +		pcie_set_mps(dev, 256);
> > > 
> > > [Severity: High]
> > > Will modifying the Max_Payload_Size locally in the enable_device hook
> > > desynchronize it from the rest of the PCIe fabric?
> > > 
> > > The PCIe specification and Linux PCI core generally manage MPS uniformly
> > > across the hierarchy during boot via pcie_bus_configure_settings().
> > > Because this hook runs later during driver probe via pci_enable_device(),
> > > if the upstream Root Port or Switch retains a larger MPS and transmits a
> > > TLP exceeding 256 bytes, could the downstream device drop it as a Malformed
> > > TLP and cause a fatal link error?
> > > 
> > > Would it be safer to restrict the Root Port's MPS capabilities before
> > > enumeration so the core logic correctly scales the entire fabric?
> > > 
> > 
> > Marek, you said that Root Port's MPSS is fixed to 256B. So this means, PCI core
> > will only set the endpoint's MPS to <=256B. So I don't see a need to limit MPS
> > here.
> 
> The MPS limiter is optional and I never saw MPS > 256 in my tests, however I
> feel that to make this bulletproof, it would be good to keep this check. If
> you feel strongly about this, I can drop it, just let me know.
> 

There is no way the PCI core will let device MPS to go beyond Root Port's MPSS.
So this check is mostly redundant and I would drop it. Also, add this note in
the commit message since it is not documented anywhere.

> [...]
> 
> > > Should pp->bridge->no_inc_mrrs = 1 be set during this initialization
> > > to enforce the limit permanently?
> > > 
> > 
> > This is a valid concern. I believe you should set 'pp->bridge->no_inc_mrrs = 1'
> > in the Rcar driver to prevent client drivers from increasing MRRS.
> 
> I will add this one.
> 
> And I will also re-ask about the MRRS 256 Byte limit now.

Okay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
