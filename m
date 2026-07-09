Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8F217704;
	Thu,  9 Jul 2026 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601851; cv=none; b=Glg/G0JZGQXIcYrgmOXKUp3QxlfCaPmTKeKl86StAiL2fTKsCyPBVcOU3plM4i1apE5IbnH75L7dDPbeLOXJnwiRyqDCrObh4UU9JXGWqqWpZMGSDn+vHyDbEArKcL73syKo+qtq6Rd8UTgvfz76/Ax46GaahnaQgYfhj0bUmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601851; c=relaxed/simple;
	bh=afQzXJ+0CjkGnXDlAiyd32psPQehN71Vfe9SNTHgKK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7NsJfloEdgraLKwN6HAj6EvAEhj1NYAx12uG68hVSkeuJZgcqDQ35VeYJucMNAiO2a6YyjcUmi5LRIvvadL4ZDINc7bD5+AhBpJXsD42ggOHBNuQdtwvO2InuFTKTDzyUW3KTv+oumZ3p7J0J+LQ3ku0OEjynevnLaZozBF1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdCo0lnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdCo0lnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB201F000E9;
	Thu,  9 Jul 2026 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601850;
	bh=YblE1pNMWghumBOqyovee2xFVUAWORIaMcWs+X24Wtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QdCo0lnHZGXSEGH2XWisUKthmC4qq/N8ZC1PVmmUAwPMirhbIuNXCmYTcBC4RKzFd
	 fwRjX4hJaqjhgJ1N8s9gsJNvzlLQauAMbh0CctAw5MT0D6Hs5yK17iOLnX4aXX2UNG
	 wPLkapYRXOxukzzyX6ffj1PIh9xvi4KQIWE8UKweZVtwXgVTVX4kinm5ydBoI8ThYA
	 Fb42DUgLeoXKIAw7ELvwtC7+wNFt6Q5wlr0GXCTxArMiv+HVbI5fk7Y4Akh/NlByl2
	 KtqCxtfLUN/l5NyEaNPsCgjbb/pauPuKZOExKuIrBCr8agFK2/yEeYo/1Wd5jczwo1
	 WRYrATU13KAnw==
Date: Thu, 9 Jul 2026 14:57:20 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 0/5] PCI: rcar-gen4: irqchip/gic-v3: Handle GIC ITS
Message-ID: <lkxuw3lgr6gbi4vnj33pfq5kh7h7qefkwiovlqsltnfivbrfit@khnoyfmibg5f>
References: <20260707203743.88299-1-marek.vasut+renesas@mailbox.org>
 <ybnitlgx3dcqsesubz6jz7pn6snseuxhtz564tinbtvukianaq@33ubmcynyqmt>
 <c12941e4-3715-404e-b674-090c62b868b8@mailbox.org>
 <87v7ao5o5t.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7ao5o5t.wl-maz@kernel.org>

On Thu, Jul 09, 2026 at 01:43:26PM +0100, Marc Zyngier wrote:
> On Thu, 09 Jul 2026 13:33:22 +0100,
> Marek Vasut <marek.vasut@mailbox.org> wrote:
> > 
> > On 7/9/26 2:19 PM, Manivannan Sadhasivam wrote:
> > > On Tue, Jul 07, 2026 at 10:35:38PM +0200, Marek Vasut wrote:
> > >> Configure all R-Car Gen4 PCIe controller MSI registers fully, both in
> > >> case MSI are enabled and disabled.
> > >> 
> > >> Patch GIC ITS driver and add quirks for R-Car Gen4 GIC ITS, which is
> > >> configured to 32-bit address width for AXI or APB interface.
> > >> 
> > >> Switch R-Car V4H to use GIC ITS in its DT and describe the GIC ITS
> > >> implementation cacheable and shareable limitations.
> > >> 
> > >> Marek Vasut (5):
> > >>    PCI: dwc: Determine whether iMSI is used before calling .init
> > >>    PCI: rcar-gen4: Configure AXIINTC if iMSI-RX not used
> > >>    irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
> > >>    irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
> > > 
> > > Is there a functional dependency between irqchip and PCI patches? Since the
> > > irqchip patches touch ARM64 Kconfig etc... I'm wondering if it still need to go
> > > through PCI tree.
> > I do not believe there is.
> > 
> > These two configure the PCIe controller hardware:
> >   PCI: dwc: Determine whether iMSI is used before calling .init
> >   PCI: rcar-gen4: Configure AXIINTC if iMSI-RX not used
> > 
> > These two fill in GIC ITS quirks:
> >   irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
> >   irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
> > 
> > This one does yes depend on the two and two patches above, and can
> > only be applied once all four aforementioned patches land, otherwise
> > things really yes will break:
> >   arm64: dts: renesas: r8a779g0: Add GICv3 ITS and update PCIe nodes
> > 
> > Would you like me to split the series up , or can you and Marc (?)
> > pick the relevant parts via matching trees ?
> 
> I don't think there's anything for me to pick. The whole thing looks
> like a consistent set, and it probably should be kept together.
> 
> Given that the irqchip stuff has been acked by the relevant party, and
> that the last patch will cause havoc if taken on its own, the only
> course of action is to route the whole thing together, the PCI tree
> being the most obvious victim.

Alright then. I'll merge all 4 patches to PCI tree.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
