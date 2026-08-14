Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE47353A80;
	Fri, 14 Aug 2026 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685242; cv=none; b=ewgVcI1p1Ii3pm+s7bFAt+cSzcD1Pz1D/B4eQTjYySZEfrU4ZHZM9h5kp54xL8EkLSj6ZraVtxvRytt9pjVwbkmZI6PaqjryuTz8bWn6PKtcMuVQPzdDWEEAe73jAnOgNLPg6EDPTc3k1vkEj9UmdLt06AqIwH6TLDXw/bBCrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685242; c=relaxed/simple;
	bh=NK1m/1D6M3jTBQ5nmDeHBnnlRlutP5/R8we9pihbVw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azanEUdI7kUM1C5iJrOvniIVdOCOsxGtSNitfABnQro4UXWCl0MXuqBZY++OtflyrGPTn9rHngbWSBRjPO11kw/2MIymm6v/SDp1dx90ndLK2rApyMkbWqCHWK6Suy+SAE3rM1oBzSxwCTaE4O0T8j/zSjzzdvp3//iyo6ympnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLrlbxeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLrlbxeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7741F000E9;
	Fri, 14 Aug 2026 05:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786685241;
	bh=Jf4qaFJl5b1RUI0wYv6hr0/sFhbHSCSEjQXks3a/Nmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jLrlbxeJb5NiD3FSgZ3yWUtjrXZZwHWaqk0QFZpLzuZhsURouAxHs+iURFcjt/smV
	 c7H1xveeY3DORgBZqoKgjOM/SQXJ22ojaZo3pMrPqxMKVtrBbl2MWP/rsGOKkmLO4T
	 VDR35FAFQeyyfYcks5ByGVTBxOLRsoV+ZmbNO7jDRYn/MurRTpncH1U+fLfrWP7kgo
	 YIV7vDh6QSJqq7/7LwjKWUaiHYJnwA8+ywImESocLGIt9p6fJtyE6P+FaR1qnulM2+
	 tVvx5/NGB0N5AN9wHJ8IqyKOtLVH2LhDzhgOTuwM2KG+TrLxZCGccgjvwafMvmcZ94
	 gtfFLXvyecOPg==
Date: Fri, 14 Aug 2026 07:27:10 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Message-ID: <7kzvkrbc6w7yojufwekzjubndgg4ao2o65gnla6mjwhwn5ji2d@vhrj4kg6uia2>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <an2uf5mXzGq1Q7cj@ryzen>
 <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
 <ztn47y23ctbjrbkmgyyhc6d5x3i2lzz5txotpgtbjtcsvbsvf4@fzadsvt5fl4d>
 <an3p_j-F10e9x0vM@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an3p_j-F10e9x0vM@SMW015318>

On Thu, Aug 13, 2026 at 10:59:58AM -0500, Frank Li wrote:
> On Thu, Aug 13, 2026 at 11:15:31PM +0900, Koichiro Den wrote:
> > On Thu, Aug 13, 2026 at 02:50:59PM +0200, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 13, 2026 at 01:46:07PM +0200, Niklas Cassel wrote:
> > > > Hello Koichiro,
> > > >
> > > > On Thu, Aug 13, 2026 at 03:37:47PM +0900, Koichiro Den wrote:
> > > > > This is v7, the remaining patch set for PCI endpoint DMA.
> > > > > Parts 2 and 3 were merged per Frank's suggestion.
> > > >
> > > > (snip)
> > > >
> > > > > One open question is how to support endpoint controllers with only one
> > > > > PF. Keeping DMA in a separate EPF requires multi-function endpoint
> > > > > support. Folding it into vNTB would work on single-function
> > > > > controllers, but would also couple the two implementations. This series
> > > > > keeps the separate EPF model.
> > > >
> > > > I see all the work you are putting in and I admire the effort.
> > > >
> > > > This is now v7. I think it is time that we close the open question by
> > > > waiting for a reply from the PCI endpoint maintainers' opinion on the
> > > > design before continuing. (I am not a PCI endpoint maintainer.)
> > > >
> > > > I understand that you want a common DMA abstraction, that can represent
> > > > different (embedded) DMA controllers on the endpoint side.
> > > >
> > > > But if vNTB is the only consumer of this, then why not simply embed this
> > > > DMA abstraction in some BAR exposed by the vNTB EPF?
> > > >
> > > > Looking at the host side driver that goes with the (v)NTB driver:
> > > > drivers/ntb/hw/epf/ntb_hw_epf.c
> > > >
> > > > The BAR layouts are hard coded, and it only supports three different
> > > > layouts. Would it not be possible to add a fourth layout that has the
> > > > DMA abstraction somewhere in one of the BARs? ('BAR_DMA' ?)
> > > >
> > > >
> > > > Right now, I wonder if it is not a bit premature optimization to create a
> > > > DMA EPF, if vNTB will be the only (ever?) user.
> > > >
> > >
> > > Yeah, I feel the same. I haven't seen an usecase to program the DMA controller
> > > from the host outside of vNTB. This feature is supported mostly because it
> > > exists in hardware and someone wants to tick the checkbox.
> > >
> > > Though, I'm not against doing it within vNTB as Niklas suggested, but
> > > generalising it in the form of a new EPF driver just for the sake of a single
> > > driver sounds like an overkill and maintenance burden.
> > >
> > > Sorry for saying this in v7. I've been meaning to say it, but somehow ended up
> > > procrastinating too much.
> >
> > No bother. Since Frank has given a lot of feedback on this series, I'd also like
> > to hear his view.
> >
> > I'm fine with either direction, and can revisit the earlier vNTB-embedded
> > approach:
> > https://lore.kernel.org/r/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/
> 
> One of the important value is test dw-edma-pcie.c, which generally depend
> on some fpga hardware. If there are epf driver work as fpga hardware, it
> will help cover edma remote user case. So more user can test it.
> 

Testing is one thing, but using is what matters. Are there any products or
use case based on remote eDMA? Or even dw-edma-pcie.c?

Most of the time, dw-edma-pcie.c driver feels like a dead code to me which no
one actively uses or tests. So unless a real justification is put forward, I
don't want to add a whole new EPF driver for it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
