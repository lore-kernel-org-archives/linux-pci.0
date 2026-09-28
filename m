Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B22EEE9E;
	Mon, 28 Sep 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634285; cv=none; b=Dr/iaOXaVKHPYkhJyqB772PlkUMrmsBGglk3Cdj6agZOdtPC94EH7O0mAZWaQhL2EulbtqwX7CEQSKTfhOSOyN3F0uDgojWNZVbpoe9YsImcT8V8rL0LrhwR5csQ8l3EvakEa2cemLDQH6Mg57aGjUHRuAg91wjtN44WT3v5SNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634285; c=relaxed/simple;
	bh=CQ1sHx0JdzzR5DVXNUibmZyTLdxwADEgfkQSPEiTcW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DSVr9U9LZCTqflYl0DOw/r3iMRHKE/jaCGmy32KNimtC7uB2XD01EU6cfy2+k24cWDyfo6pnSpLyzZ+I1T6V/+ii18kae1l5zN/xukhPfQ4rk6RDyx66X6zD0UdSRXXmpfZ+daUNBL6Eq80TyJtipYr5C/xlUXKj9RKKLNZm5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/m4TO+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/m4TO+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16091F000FF;
	Mon, 28 Sep 2026 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790634283;
	bh=QXHVC5yMZceL5J1JsKV4vQfSwG3c2NxZWnu6Pfi0xFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=F/m4TO+b8y+Bwyx9DgGsfW0txIaTWEuEM6ClnjSJfebYcblSdTTjbzP1Fcioz33Pd
	 z3mvkX5AA3HiF+s2GgpeYaqXzJNxX2cIb9F2uS6yG//b3i7eeqkqU+fusQmhy7ni6i
	 zmSxlnBxTofWY65Q/tGeTVyQhIL9s/EEtOJ/6+9vtVPgEcN4QjaxRS0OBAxwGBuDsM
	 vl4NblMQBj/oOcOrChd2PZJMbltqau8oJvI50Kx+BEqLH8uOINJAuCsGRWERYM8WMW
	 kHViKsa++YJSl9B8dh2Q39BC/C2THqEfjkKB/ofLWXMqMUqQtxKe9SP4IWb349mMBh
	 QjlNROFCx2nEg==
Date: Mon, 28 Sep 2026 17:24:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
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
Message-ID: <20260928222442.GA2266778@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb47958-09e2-4726-85e3-8e5d3873840e@mailbox.org>

On Mon, Sep 28, 2026 at 11:32:37PM +0200, Marek Vasut wrote:
> On 9/28/26 11:01 PM, Bjorn Helgaas wrote:
> > On Mon, Sep 21, 2026 at 10:27:48PM +0200, Marek Vasut wrote:
> > > Add support for R8A78000 (R-Car X5H) PCIe4.
> > > 
> > > This driver previously supported R-Car Gen4 S4/V4H/V4M. PCIe features
> > > of R-Car X5H PCIe4 are almost all the same.
> > > 
> > > The controller initialization sequence is slightly different and is
> > > factored out into controller specific callbacks, in a manner similar
> > > to previous R-Car Gen4 handling.
> > > 
> > > The controller does have a PHY attached to it, but the PHY is operated
> > > by a separate PHY driver, the PHY driver instance binding is handled
> > > in rcar_gen4_pcie_get_resources() and controlled in the aforementioned
> > > controller specific callbacks.
> > > 
> > > The controller driver is deliberately using "renesas,rcar-gen5-pcie4"
> > > DT compatible string to discern R-Car X5H PCIe4 controller supported
> > > by this driver, from R-Car X5H PCIe6 controller which will most likely
> > > use a separate driver.
> > 
> > The gen5/pcie4 usage is confusing.
> > 
> > I often push back on things like "PCIe Gen4" because it's ambiguous
> > (does it mean "compliant with base spec r4.0" or "supports 16 GT/s" or
> > something else), but it's so widely used to mean transfer rate that
> > it's hard to resist, and the best I can hope for is clarification.
> > 
> > But in "renesas,rcar-gen5-pcie4", I don't know what the 5 and the 4
> > mean.  Maybe "gen5" refers to some internal R-Car thing, and "pcie4"
> > is something like "PCIe Gen4, i.e., 16 GT/s"?
> 
> Gen5 refers to R-Car Gen5 (5th R-Car SoC generation).
> 
> PCIe4 refers to the PCIe Gen4 core in the R-Car Gen5 SoC. There is also PCIe
> Gen6 core in the same SoC, but that will require a different driver and
> different compatible string.
> 
> Since none of this shipped in any kernel version yet, would you prefer some
> sort of rename ? I can send patches.

Huh.  TIL that pcie-rcar-gen4.c refers to the 4th generation R-Car
SoCs (and, I guess the point of this series is to add support for 5th
generation SoCs), not to PCIe Gen4 link speeds.  I see that
"renesas,rcar-genX" is all over the place in 'compatible' strings, so
I guess we should follow that precedent.

If the "renesas,rcar-gen5" SoC includes both PCIe Gen4 and PCIe Gen6
cores, I suppose everybody refers to them as pcie-gen4 and pcie-gen6,
so the "renesas,rcar-gen5-pcie4" you used is probably the obvious
choice.

But maybe we can make commit logs less confusing by saying things
like:

  - R-Car Gen4 SoCs S4/V4H/V4M
  - R-Car Gen5 SoC X5H
  - the R-Car Gen5 SoC PCIe Gen4 core
  - the R-Car R8A78000 X5H PCIe Gen4 core, which supports a x8 link at
    16 GT/s
