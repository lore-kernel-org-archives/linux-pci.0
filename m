Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B7339386;
	Thu, 23 Jul 2026 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836186; cv=none; b=R9lsBdRHS+jVUmuoU6qIMPxMb213YP3WTkwMaNXhClj+h1PvgPVipD6eJqjdorkvneFXkaG+qH/P5wfqenGlS72pqi+K0lifTVVUUEG9wmaSBr3Nb9/KnNanIHKxE28h1R3oouyZK20ZbppbAJh4CMD8Vrv+jVyX5DT/4STRBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836186; c=relaxed/simple;
	bh=J2l+orxQkq/X47YlgAq1O9eVkoZJbAcmHB5+SszjhaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VeIpQ3CrBoX7DWlhvIRRhL97X/rAwJekO+ajHnAGGMdbnHETBMUuKrU02Rx8Yyzn1rK7V0BXIddSkLw3OGPyh1zkXiJA37I+kJRSBkx3gYdIGBqt2dtq7fSVrrDf+rV2gEu1/PYKFyowpdGuTFwwmuvYCKL/PT+hLKIg4VJAH6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHEyfqKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHEyfqKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5B61F000E9;
	Thu, 23 Jul 2026 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836183;
	bh=hd35ezz/qRRzqlESySsTjZX8Na6y63xNvZlfn93+y/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=oHEyfqKs+qIAGhNg8ku1g8HLye7HRNceaQR5nVhVORDSMRPvDk5wJbiNVYoltP0ef
	 q3c3c1LUZJ0v0v+iHt0YGC0IV/s+1w4CjvF4V+/r69vHOuUCPc1o2j7dIx45ovP4xy
	 Zv3WOK1re0ATDkbTpUQuM+l86aabi0dJ7acys2+7UqhnEKVF9BbNxxw1M4at8UNbjl
	 KSRO8OKGHbwWChQdq2B67fHz9S0nS0SJM5B4gk8tL39wDX1Aq97vhVxFsRJaeIkLkQ
	 nsDUoDR+e2QFZPQwFHXcuSJdBgdaMZNZlzHv5E49nuHfHWmtJnE7uC+mqmfWrL0KD7
	 eh4AIHVTo9MKg==
Date: Thu, 23 Jul 2026 14:49:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add 2-lanes mode support for
 Airoha AN7581
Message-ID: <20260723194941.GA850329@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a626006.4d70c427.b2b96.c939@mx.google.com>

On Thu, Jul 23, 2026 at 08:40:03PM +0200, Christian Marangi wrote:
> On Wed, Jul 22, 2026 at 12:40:10PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 14, 2026 at 01:58:46PM +0200, Christian Marangi wrote:
> > > The Airoha AN7581 SoC supports configuring the first PCIe0 lane to 2-lanes
> > > mode (2x link) by bonding it with the second PCIe lane (PCIe1). This is
> > > done by configuring the PCIe MUX in the SCU register.
> ...

> > > -	 * Airoha EN7581 performs PCIe reset via clk callbacks since it has a
> > > -	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
> > > -	 * complete the PCIe reset.
> > > +	 * Old Airoha EN7581 clock driver performed PCIe reset via
> > > +	 * clk callbacks since it has a hw issue with PCIE_PE_RSTB signal.
> > > +	 * This is now handled by dedicated PERSTOUT resets with clk
> > > +	 * driver only enabling the refclk.
> > 
> > This reference to the "old Airoha EN7581 clock driver" makes me think
> > there's a dependency between a EN7581 clock driver change and this
> > PERSTOUT change.  If so, please mention the commit SHA1 for the EN7581
> > clock driver change so they're connected and people backporting to
> > older kernels know to be careful to get both of them.
> > 
> > It sounds like this PERSTOUT change might be independent of the x2
> > configuration support.  If so, it should be done in a separate patch.
> 
> thanks for the review. The clock change can go on a separate patch but
> since the hash will change when it will get merged what should I use as
> reference? Also any hint on the tag to use or the format?

Where is the clock change?  Is it the one in this series ([PATCH v4
2/4] clk: en7523: add support for dedicated PCIe PERSTOUT reset)?

If so, perhaps this PERSTOUT change and the clk-en7523.c PERSTOUT
change could be in the same patch?  It would just require an ack from
the clk folks and then we could merge it via PCI.
