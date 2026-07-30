Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39E175A68;
	Thu, 30 Jul 2026 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785383303; cv=none; b=GM5BJ1adhcJQLtGOsM9NiYNwTuLPcWXGbexsAdzDakwcwNBFowk7rH7XPlelLF3knm5qaBiH6k1qo4/9tmNF6KrcqS1uhSfrbrmNmm9i88OeMgM4PszYfm3mPeXdM69YOirMliZs1YObeGP4UdAEdNQKWzFLASm7exGFkjk7wP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785383303; c=relaxed/simple;
	bh=mRzy/A8QP1rJEwW9vicUPjGnGofkSi1PxtTk8kLG0qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as3t0esMEtNlzV9gpEv//ux22weu23kLJttiunolsywyeRsdYO6sr44nsVGk+65aIxivTFqzW6qgrxkz9Pxld+A9iF24DldTZysZaypFVk8vfJPcZ4aiRAgmUmOZYLSSG87kMHieg/Z5Td7w0YcjG0aBJvVRTXKqshavDJ6WHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh3SI/4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh3SI/4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530061F000E9;
	Thu, 30 Jul 2026 03:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785383301;
	bh=Fz0OgPJHskeZCecIhowCqY7VOgUdIoTQSDl165K/eiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lh3SI/4G3RDTWRTW0NdHgz98g1xe5CFI4f5qgm15wero2ItllUSHgs45TZPbQYL2Q
	 rCHS6Zze5Q9Y2/ARfhG2TffPAN3NS6mLuKT6e4uzyPXMIDVdwLQ2DDgyYzf0aRy36e
	 CcdN19IHoaSAO4dl38o5KBknoP0CUOlRdYqRBHyzIn73xiP0LwfPnhxls9HSeOr4ex
	 Mr1oKYRbef3TG8pQez/gWER5ZdMct9iKrj4F5ocJlwCd9PrJW9wA9ijlbyLp0uwC9Z
	 bgZ67ckMARrD6Y5ujaicC3KFybE51P26CACDPAeatppWbrZYAoKyLmILliJjeKPUeb
	 S/e3xi5pSTRWQ==
Date: Thu, 30 Jul 2026 05:48:12 +0200
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
Message-ID: <5ea47pp3ctiieqahn3mkcg3dqrlmwdgdjyv6pa65qmjuqop4lb@tbax2lojuwkr>
References: <20260716205811.800920-1-rosenp@gmail.com>
 <g3gtckpqgacw44jqqb5hb3oejpelxvbba47tdwsvksxbbskygp@mcwtsbypoyar>
 <CAKxU2N_f1nN4Oo94V9MY6Q-wp66j=3kodfMs0BeXVGB9XivvNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_f1nN4Oo94V9MY6Q-wp66j=3kodfMs0BeXVGB9XivvNA@mail.gmail.com>

On Wed, Jul 29, 2026 at 11:18:15AM -0700, Rosen Penev wrote:
> On Wed, Jul 29, 2026 at 9:00 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Thu, Jul 16, 2026 at 01:58:11PM -0700, Rosen Penev wrote:
> > > Replace irq_of_parse_and_map() with fwnode_irq_get(dev_fwnode(dev), 0)
> > > in xilinx_pcie_parse_dt(). For an OF-backed device this is equivalent to
> > > the previous call, but uses the generic firmware-node API.
> > >
> >
> > What is the benefit of using fwnode API for OF only driver?
> I get conflicting information. Apparently of_irq_get needs a call to
> irq_dispose_mapping but fwnode_irq_get does not.

That's not true. fwnode_irq_get() becomes a wrapper to of_irq_get() if OF is
used. So both needs a call to irq_dispose_mapping() in the error path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
