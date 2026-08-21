Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3C34D4E9;
	Fri, 21 Aug 2026 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348645; cv=none; b=lhqzixnsrl/+4mOkwvigUbTMTkk6ffMILtQS7ucrk7l3CHvQEdVGz2m81vlAbdPHA/Jv2o5jYQ+LHeu/mIC2+PRV7LoQKv9CFk6dWh3pHtQ6Vbrsuz4Heoaf1/31jPORnEI9sjt3I9k20NQbYj1h+hazzyPDDNKny5/Q9ta5Mfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348645; c=relaxed/simple;
	bh=ZVa9ENG9ZuqSmZZ4OR/pap2eKmR5d68IwC+UAotJ2Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QleujJplVZlUcvnYMLhkI5gP1Qa6mTAOtsSCoqyogGKTBDRTCHUnmL+YzzlK3dEW+LqpbLrFrMzXvyhEkz+XjrRWelqUHMjgLOxNOidQcOnaDhUzBMg7pk/aARqlqleFPYBf4prgnrNdCMp/awidvspWPfrhdYth3EbRFqW4VtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpX0cTfK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpX0cTfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4661F000E9;
	Fri, 21 Aug 2026 21:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348644;
	bh=ur6AGZnDWX2UGxSjokXvTfNXVZtXnK2EU3b863xIK78=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UpX0cTfKcOQvUyaHai+MIupaUrdoTzSoi5ClJOEYlaU6cbfnLOyzzm3B12Gvq4Skl
	 DpqUUnna3Zk3yoAKLSGFonLePnaJnKMrDAoHlYe33p8TM4uy0NqGQ2fhCXelz1dcMD
	 fBarXUzpYNp6NjdaI/SWZBRhubaFQ6zODyeZwN6XnhCEKU/Y5VND4qeVQ4KqgN82WE
	 LhYCcKPNEXGIsHVp71o+8C1A8Ft5zcaljZV1CPdk11Os8yXPI0QXh5XyV7Je86acoQ
	 6fQ1/Sit49v/XpuWEIrsvc7kyWr6GunnlnamWjNHCex8B2ySKew5NjZb1PIbcUNkZ1
	 zQvdYUUatmOxw==
Date: Fri, 21 Aug 2026 16:44:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support +
 clock
Message-ID: <20260821214403.GA1015524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821203639.GA4153689-robh@kernel.org>

On Fri, Aug 21, 2026 at 03:36:39PM -0500, Rob Herring wrote:
> On Fri, Aug 14, 2026 at 05:36:38PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 06, 2026 at 06:53:30PM +0200, Christian Marangi wrote:
> > > This small series introduce support for 2-lanes mode for Airoha AN7581
> > > SoC. This is needed for correctly functionality of Eagle WiFi Card
> > > normally attached to this SoC that require a 2-line PCIe card to
> > > correctly work (and give the proper performance)
> > > ...
> > 
> > > Christian Marangi (2):
> > >   dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document
> > >     2-lanes
> > 
> > This is applied on pci/controller/mediatek-gen3:
> > https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=39f758dc5fbd
> > ("dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document
> > 2-lanes")
> 
> As reported by 0-day, this introduces a bunch of warnings and I don't 
> see any .dts fixes (plus the need for fixes indicates a ABI change).
> 
> This should be dropped if dts changes aren't going in in the same cycle.

I dropped pci/controller/mediatek-gen3 for now; we can address this
for v7.4:

  26c53c644350 ("PCI: mediatek-gen3: Add 2-lane mode support for Airoha AN7581")
  39f758dc5fbd ("dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document 2-lanes")

