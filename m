Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E583647C10D;
	Mon, 28 Sep 2026 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629319; cv=none; b=mViwVerot5ja0gWg2LFsXGl++NpNJqv9WMjJsqJR7e2op4DV1+xmx/Q//mnQZ4Ix4r628HgYcMFDgU2OdfWWPk6LyI2GrcMJ3nTL4nY/z/g+aHdv8/9FuJ9Q/jZEy1tsAXR4uhIAA55MtNM0LxiM7Xi15JXR2dLW3lgtsLjnxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629319; c=relaxed/simple;
	bh=/npj3zdP2RbC2CIoCxwIFftfUISIBxvHaVXvjpZDXWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=efp82zGtxRBS2erz8XdbltdEFIbuHw78fgi5fZMLBekdi8LAvEsl66iPROswtbA7F1U6DNz2OEGnlehWB3e4L3UBZLoMNF7gNhXMEdgoklZt5TRTjAr3aM29u4B+H1qucSv7+OiVzVJQU8MHYU9A2ZpcfukSl/7DTp9Dyf5uQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3lKCrs8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3lKCrs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A071F000FF;
	Mon, 28 Sep 2026 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790629317;
	bh=fR85tYcpWQ8ox9kILOPgK1wQGVXd4jwMDchSGmBsxeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=H3lKCrs8OLzD6PYZhjlxHmjVpkC8QKLbXJfkZUgRYy29aPCBc/igzbj8NZcCt2jmK
	 kqlRSLb98InAPQPm6wu3AEOiTnrAdpXtzlHKAoWbyk9v2sjTzs1vhTdERVys+A6iW8
	 zJp2TcZLCgH9iedmz7gqueL1UleilN7KsQHv8gxS/rSuZbhThT8sI+OcGWlfmFekIr
	 9vl7vs9jVO8vBqevuUlpc5igDrBXN5SuXaZE4TE9m6VKiJuKNPfKJzIfGZuAWfq4bu
	 6qRJKmhAgYjhwAQNTWNMt3Ya/3QZLoXO9GSD4kqGGmq9vIGgbAjubwil079kfXHGlR
	 EwF2+eS7ZEcRg==
Date: Mon, 28 Sep 2026 16:01:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 6/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H
 PCIe4
Message-ID: <20260928210155.GA2260978@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921202823.72620-7-marek.vasut+renesas@mailbox.org>

On Mon, Sep 21, 2026 at 10:27:48PM +0200, Marek Vasut wrote:
> Add support for R8A78000 (R-Car X5H) PCIe4.
> 
> This driver previously supported R-Car Gen4 S4/V4H/V4M. PCIe features
> of R-Car X5H PCIe4 are almost all the same.
> 
> The controller initialization sequence is slightly different and is
> factored out into controller specific callbacks, in a manner similar
> to previous R-Car Gen4 handling.
> 
> The controller does have a PHY attached to it, but the PHY is operated
> by a separate PHY driver, the PHY driver instance binding is handled
> in rcar_gen4_pcie_get_resources() and controlled in the aforementioned
> controller specific callbacks.
> 
> The controller driver is deliberately using "renesas,rcar-gen5-pcie4"
> DT compatible string to discern R-Car X5H PCIe4 controller supported
> by this driver, from R-Car X5H PCIe6 controller which will most likely
> use a separate driver.

The gen5/pcie4 usage is confusing.

I often push back on things like "PCIe Gen4" because it's ambiguous
(does it mean "compliant with base spec r4.0" or "supports 16 GT/s" or
something else), but it's so widely used to mean transfer rate that
it's hard to resist, and the best I can hope for is clarification.

But in "renesas,rcar-gen5-pcie4", I don't know what the 5 and the 4
mean.  Maybe "gen5" refers to some internal R-Car thing, and "pcie4"
is something like "PCIe Gen4, i.e., 16 GT/s"?

> The R-Car X5H PCIe4 controller embeds HDMA instead of EDMA embedded
> in the R-Car Gen4 PCIe controller, "dw-edma" driver supports both
> DMA variants.
> 
> Endpoint mode is currently not implemented for R-Car Gen5 PCIe4.
