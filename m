Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36321 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756002Ab3JHU31 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Oct 2013 16:29:27 -0400
Message-ID: <1381264135.645.230.camel@pasglop>
Subject: Re: [RFC] Architecture independent pcibios?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robherring2@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <monstr@monstr.eu>,
	Grant Likely <grant.likely@linaro.org>,
	devicetree@vger.kernel.org
Date: Wed, 09 Oct 2013 07:28:55 +1100
In-Reply-To: <525438F6.3090600@gmail.com>
References: <20131008144211.GA25231@e102652-lin.cambridge.arm.com>
	 <CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com>
	 <525438F6.3090600@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-10-08 at 11:55 -0500, Rob Herring wrote:

> > I wonder if pci_process_bridge_OF_ranges() would fit somewhere in
> > drivers/of?  The implementations I looked at are mostly concerned with
> > parsing OF resources, and they don't have much to do with PCI
> > directly.
> 
> This was being done until Ben weighed in:
> 
> https://lkml.org/lkml/2013/5/4/103

Well, I proposed an alternative (better) approach which I of course had
no time to actually implement yet :-)

I have done the changes I needed to do to powerpc
pci_process_bridge_OF_ranges so it would be possible to move that now to
a generic place, but I still think it's not a great idea. It means the
pci_controller structure with its resources will have to become generic
which somewhat overlaps with the pci_host_bridge that Bjorn introduced,
so that's really not great.

I still think an arch with DT and simpler PCI code that powerpc could
start looking at the transition to a better model that I hinted at...

Cheers,
Ben.


