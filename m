Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F2282F1D
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781418164; cv=none; b=kZm9v5x7QO2eyWoTaFzdbjuFhrMJXfsnNwqnnrr2TRQLu3sfxel4o4R7ax0nRkzbrXKBJA/np1lKeK6jV4I42SRiYk5tloi6mtTVrwkUfyqzGfZHUcRbu6jwyQqMc0Cy9LwRmt1Vd9Hu6SvgAkqJPmqoFHfehw7bnYrVV4UW9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781418164; c=relaxed/simple;
	bh=VwLxq4D9WAbn/f4iwWOLeW2mjZZkeHR/31c+EmzOytY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbZsYiZgNY/Ij8jxBF0S7afxnokiH167m2w2ryto+wVm8VIYOVhDOagMmuNe6MHj+oHTQXPkAnw3H7RPhTw5XvsdjI60HELYPTzB5N0yRgh6QT2eWAh7ko5tOgzGxZ7fiuQWdNdbn/9bWZziL9YvWcciEekA6RP7rarhf1xjuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmyTYi2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmyTYi2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6035E1F000E9;
	Sun, 14 Jun 2026 06:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781418162;
	bh=bHxkuFdq0vtdpEjagQ0dZT3o3vV8oLajOYhHCPnf+cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UmyTYi2pPrElN4+2AvEWT3fW0+oZfpOv9TRWSIRW4DrrSmX3E31isPlAmE6NbIGpq
	 jdczQi6dlChNylcceckEDHb/IQL0VNybGqBhm/w5+EOoUczAM0+lMhlS8V+/irZ44z
	 XMBmEuyrJ8YE02TYhjJXiwYhb5hhHUpYWb9H0SKnPAv3x6+ci2c7USPbvzAGQBW9a2
	 WBVJC5WNHnoQ855g8/5GKNw8R1RlbuuviE+2rwuyknbnRBQBoHvG/tnUWtd8bbbR+R
	 IK6yVCtbyPahObmc7KL9942t2ok9ivtU09QE5zzha2fbDCA3LuK5pPRWAobF374gJP
	 7z8YORguNt2rg==
Date: Sun, 14 Jun 2026 08:22:32 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
Message-ID: <ltenx3sxptnzkut6z2xkpv6lpkp5qyzoutf2lqgua5hperr7hc@54ligpf2cdjy>
References: <20260519195219.189323-1-marek.vasut+renesas@mailbox.org>
 <20260519202037.8BD001F000E9@smtp.kernel.org>
 <orrpfub5f2hkrgkmxrdtykhzmxyuclnky4dn6vnz3cgvvbdcvb@5altvzufcq53>
 <bc40e4c6-1922-4bce-99d1-341730a4e6f8@mailbox.org>
 <kg7uvgl4kaupiea56e63xiikhl3xqtgug4dqynxchw7prgdo6t@gclq5wdan4tc>
 <14888440-fb68-489e-b894-e90df4c32fab@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14888440-fb68-489e-b894-e90df4c32fab@mailbox.org>

On Sun, Jun 14, 2026 at 03:56:42AM +0200, Marek Vasut wrote:
> On 6/11/26 7:59 AM, Manivannan Sadhasivam wrote:
> > On Wed, Jun 10, 2026 at 08:50:58PM +0200, Marek Vasut wrote:
> > > On 6/10/26 7:11 PM, Manivannan Sadhasivam wrote:
> > > 
> > > [...]
> > > 
> > > > > > +static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
> > > > > > +					struct pci_dev *dev)
> > > > > > +{
> > > > > [ ... ]
> > > > > > +	if (pcie_get_mps(dev) > 256) {
> > > > > > +		pci_info(dev, "Limiting MPS to 256 bytes\n");
> > > > > > +		pcie_set_mps(dev, 256);
> > > > > 
> > > > > [Severity: High]
> > > > > Will modifying the Max_Payload_Size locally in the enable_device hook
> > > > > desynchronize it from the rest of the PCIe fabric?
> > > > > 
> > > > > The PCIe specification and Linux PCI core generally manage MPS uniformly
> > > > > across the hierarchy during boot via pcie_bus_configure_settings().
> > > > > Because this hook runs later during driver probe via pci_enable_device(),
> > > > > if the upstream Root Port or Switch retains a larger MPS and transmits a
> > > > > TLP exceeding 256 bytes, could the downstream device drop it as a Malformed
> > > > > TLP and cause a fatal link error?
> > > > > 
> > > > > Would it be safer to restrict the Root Port's MPS capabilities before
> > > > > enumeration so the core logic correctly scales the entire fabric?
> > > > > 
> > > > 
> > > > Marek, you said that Root Port's MPSS is fixed to 256B. So this means, PCI core
> > > > will only set the endpoint's MPS to <=256B. So I don't see a need to limit MPS
> > > > here.
> > > 
> > > The MPS limiter is optional and I never saw MPS > 256 in my tests, however I
> > > feel that to make this bulletproof, it would be good to keep this check. If
> > > you feel strongly about this, I can drop it, just let me know.
> > > 
> > 
> > There is no way the PCI core will let device MPS to go beyond Root Port's MPSS.
> > So this check is mostly redundant and I would drop it. Also, add this note in
> > the commit message since it is not documented anywhere.
> 
> How about I keep at least a WARN_ON(pcie_get_mps(dev) > 256); in the code ?
> 

That's fine.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
