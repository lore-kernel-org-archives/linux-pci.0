Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53448 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcANMBI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2016 07:01:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>,
	"CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>,
	"Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>
Subject: Re: [PATCH v5 1/2] PCI support added to ARC
Date: Thu, 14 Jan 2016 12:59:56 +0100
Message-ID: <4888629.rSv29HOrHE@wuerfel>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E84DC7@us01wembx1.internal.synopsys.com>
References: <cover.1452611234.git.jpinto@synopsys.com> <56977B80.2040600@synopsys.com> <C2D7FE5348E1B147BCA15975FBA23075F4E84DC7@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 14 January 2016 10:51:32 Vineet Gupta wrote:
> >>
> >> A somewhat nicer method would be to have callback pointers in struct
> >> pci_host_bridge, and call those when they are non-NULL so we can
> >> remove the global pcibios_* functions from the API. That would also
> >> bring us a big step closer to having PCI support itself as a loadable
> >> module, and it would better reflect that those functions are really
> >> host bridge specific rather than architecture specific. When you use
> >> the same host bridge on multiple architectures, you typically have
> >> the same requirements for hacks in there, but each architectures may
> >> need to support multiple host bridges with different requirements.
> > Since we will be constantly improving the driver and the core itself, I suggest
> > that this functions be made __weak and in an update we can turn it struct
> > pointers just like Arnd suggested. Is this good for you?
> 
> There is no point in making it weak, w/o a fallback version in generic code. For
> this series, I suggest you just remove the straggler EXPORT_SYMBOL and respin.
> 

To clarify: I don't particularly like __weak functions anywhere, but they
are already common in drivers/pci, so we can add a couple more to reach
the goal of removing all architecture specific code.

However, there should never be a reason to add a __weak function in
arch code that gets overridden by common code, that would be very confusing
and not helpful.

	Arnd
