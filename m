Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1133CBE7C;
	Tue, 28 Jul 2026 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244381; cv=none; b=J7mUb4hT+fF/bxuH5LZaDtGiuWpcbQ+/iAlkAkXJcB9XU1bL9iWGcXpwCbLXnRvVQSWwbxzwTmSqNPif8NSrTEYdedO4/WzUOcJUkHtXLQ74tGV8JRpXLqRZJn0sM6S9wYO12+qm9hDnjqPwB+3vS+lCS82/AQ4CDzFFE32JCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244381; c=relaxed/simple;
	bh=5S+z0vqrCxs2/tEJ+pfDZtP1PTKj6T1kHCUqWV/iAxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aglLq6eocoArvZyENZLU1SZMg3L7FgRBLGewH497IcOf7OuM1eRVObSGijn+2qWMus1b8NvxaQuuyY8y0e045l+07Pf/CJiQG6MuRfPwRShJAmX1AMeHgs1iYeiEXCyF27VYpNiSl8rs5DVWsDw4RWaRt94zkHYTeKg5Yu3slLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeP0mZMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeP0mZMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFA51F000E9;
	Tue, 28 Jul 2026 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244380;
	bh=5W5k99RT2jl1GRjzI1fMqdKG7vHd55WEyzs/MHFOEGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eeP0mZMv2mqWoYg/DUnRFySkLjxA47Ig0SetfN9KMusX56Rz8CG5y5Q45sx6ZqrUj
	 9bdXOoe1c1Jk2sb8AVtI/Y4GTetZvuy8xovC2yNQ3eNf1IWzwSgsKkR0q18ttpzkGX
	 UzR3e4cCktxj6yqTzPGTCR3rXXfWfqJu1rjGNNF2JgqFpn+T3eBMn1Crt6PgtlRvkW
	 yRG3fa1ZlihfVEfi53gIdv5yTTMsox5i5A7EJUgnt1AvSFNgI+Fpem9qyDBhsR2SFJ
	 zNZpincDO82RsYT9KOqnLRZCdlxCSA+HwYUFaiTIL8o7YERJn1yZmj5zaZRA5P9iF1
	 E+Y1CFgwoTN2g==
Date: Tue, 28 Jul 2026 15:12:49 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI/pwrctrl: tc9563: Fix parsing the integrated
 Ethernet MAC Endpoint node
Message-ID: <uavzur74w3w6d4acq4keoi42pcob4p3jez7e5p2aubw27k5geo@ccaewywqbz3b>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
 <5348ff47-910b-4614-a935-6e99ad3b066d@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5348ff47-910b-4614-a935-6e99ad3b066d@riscstar.com>

On Mon, Jul 27, 2026 at 10:59:05AM -0500, Alex Elder wrote:
> On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > DSP3 has an integrated Ethernet MAC Endpoint which has its own set of
> > config registers for configuring settings such as ASPM. The Endpoint
> > device has 2 physical functions and those 2 functions share the same
> > settings.
> 
> This was not clear from the code.  So this explanation alone
> represents an improvement.
> 
> > Hence, parse the Endpoint node under DSP3 instead of parsing both the
> > functions. The existing parsing logic also has one OOB issue as parsing
> > both functions will result in accessing past the tc9563_pwrctrl->cfg array.
> 
> The issue you mention is that the array has exactly one entry
> available for the Ethernet MAC endpoints, so parsing more than
> one (if defined in devicetree) references a non-existent entry.
> Right?
> 

Yes.

> But this constraint only applies to power control.  There can be
> multiple MAC nodes (for their PCI functions) defined.  And it
> seems the pwrctl settings (if any) *must* be specified for
> function 0 and if specified for any others, they are quietly
> ignored.
> 
> Is that accurate?
> 

Exactly. DT can define both functions, but since there is no per-function
tuning, these properties cannot exist in both nodes, but only in function 0,
which also corresponds to the Endpoint.

> If so I think the DT binding could explain and possibly enforce
> that, but I won't insist on that...
> 

It is being enforced in Patch 1.

- Mani

> Reviewed-by: Alex Elder <elder@riscstar.com>
> 
> > 
> > Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > index 488e1ec34a7f..482e82e433dd 100644
> > --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > @@ -596,12 +596,17 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
> >   		ret = tc9563_pwrctrl_parse_device_dt(tc9563, child, port);
> >   		if (ret)
> >   			break;
> > -		/* Embedded ethernet device are under DSP3 */
> > +
> > +		/*
> > +		 * The integrated Ethernet MAC Endpoint under DSP3 is a single
> > +		 * device whose functions share the same config registers.
> > +		 */
> >   		if (port == TC9563_DSP3) {
> > -			for_each_child_of_node_scoped(child, child1) {
> > -				port++;
> > +			struct device_node *eth __free(device_node) =
> > +					of_get_next_available_child(child, NULL);
> 
> I'd add a blank line here.
> 
> > +			if (eth) {
> >   				ret = tc9563_pwrctrl_parse_device_dt(tc9563,
> > -								child1, port);
> > +								eth, TC9563_ETHERNET);
> >   				if (ret)
> >   					break;
> >   			}
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்
