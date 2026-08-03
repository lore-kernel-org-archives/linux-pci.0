Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559BA415F3A;
	Mon,  3 Aug 2026 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770921; cv=none; b=qgTMnFSw+dBSxUna3/7BfxP/P5avWWlSV9zOdsRHphjzPuoBYyzQf69nwpyfVtjuuCVdi5XkheeubMEjAEOt0Y3aknLEjUduq70Q6LwZiAH43lk57oLM1y6bFU3TWAyxX9O8MLZIf6ibFK3q9Wa4gGWM5ASybEhKzE5E2wNCp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770921; c=relaxed/simple;
	bh=SO6NavkfPfkwCX6BKrK6mBzBLZYL2sEZGvIRoI4ekUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUWi7LQvlI1wl038KnHzEAblKmZgR2J0D/uBqKNu72thCKj3tPynAbmMx1G4kuTOmxe8xpdHPD2e13lvV6iuEJscEQNWwd73jIpsut7LHqfaRawV8XhVgf0NGlR9MVzUMg5oDQemu4UiBuh3yOXaMfTweIs3yhtEUcARGzDW+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGOUOCC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGOUOCC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0601F000E9;
	Mon,  3 Aug 2026 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770919;
	bh=QdLI7i6NmXhs3e/8wzfrAbBJfvcATmR4O7TZTLdEEwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PGOUOCC1neYO3Pj4JiiJrbKXQu7xg5ou/DxwOvC8Li/WTLMVSPngejogWVDXh4lZR
	 o5bW3UOxG/IuF+QF2qPsY1LW1K/zfd0SoXyYuF8X+0ulzNhMHv7ExardoOJHlTtPWt
	 RqJS7X4CqBlc/ahI3b4A2sDHu0dLS2mJSvBrR1c5HyGFHhxa/sq31KhQgr4yyRDRUi
	 3JEjnWx/ror6y1x+T9wqMB84v5zRvBSMnxDiGHa6cUSuG7ioq/mdJ6F8sm7Thn6VUF
	 icNrO/9xTovcpfPudJjTQ8kBQvpl3Oj0AV4pEh7s6RHuymMKvKU3oAnQfLtW/oO9bu
	 MEpXY9FrW9VRA==
Date: Mon, 3 Aug 2026 17:28:30 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCHv2] PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup
Message-ID: <ducc6fhoe6t3bivbpdanmojgtnntwykzwfog7vasps7tj6mp5t@vifnuyn4fjtn>
References: <20260716205811.800920-1-rosenp@gmail.com>
 <g3gtckpqgacw44jqqb5hb3oejpelxvbba47tdwsvksxbbskygp@mcwtsbypoyar>
 <CAKxU2N_f1nN4Oo94V9MY6Q-wp66j=3kodfMs0BeXVGB9XivvNA@mail.gmail.com>
 <5ea47pp3ctiieqahn3mkcg3dqrlmwdgdjyv6pa65qmjuqop4lb@tbax2lojuwkr>
 <CAKxU2N-2Vj1pugC_L=jhMS06CA34_-a-txZCrAoUtrRwFQ1Stg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-2Vj1pugC_L=jhMS06CA34_-a-txZCrAoUtrRwFQ1Stg@mail.gmail.com>

On Thu, Jul 30, 2026 at 11:54:29AM -0700, Rosen Penev wrote:
> On Wed, Jul 29, 2026 at 8:48 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Wed, Jul 29, 2026 at 11:18:15AM -0700, Rosen Penev wrote:
> > > On Wed, Jul 29, 2026 at 9:00 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Thu, Jul 16, 2026 at 01:58:11PM -0700, Rosen Penev wrote:
> > > > > Replace irq_of_parse_and_map() with fwnode_irq_get(dev_fwnode(dev), 0)
> > > > > in xilinx_pcie_parse_dt(). For an OF-backed device this is equivalent to
> > > > > the previous call, but uses the generic firmware-node API.
> > > > >
> > > >
> > > > What is the benefit of using fwnode API for OF only driver?
> > > I get conflicting information. Apparently of_irq_get needs a call to
> > > irq_dispose_mapping but fwnode_irq_get does not.
> >
> > That's not true. fwnode_irq_get() becomes a wrapper to of_irq_get() if OF is
> > used. So both needs a call to irq_dispose_mapping() in the error path.
> I don't see  irq_dispose_mapping() for fwnode_irq_get() in the codebase.

That doesn't matter. You need to check with irqchip maintainers and see if those
drivers need fix or not.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
