Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60474 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965Ab3JHUdS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Oct 2013 16:33:18 -0400
Message-ID: <1381264375.645.234.camel@pasglop>
Subject: Re: [RFC] Architecture independent pcibios?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <monstr@monstr.eu>,
	Grant Likely <grant.likely@linaro.org>,
	devicetree@vger.kernel.org
Date: Wed, 09 Oct 2013 07:32:55 +1100
In-Reply-To: <CAPcvp5Fvf5nkYXWviz8cKnOsMd0nOBJXrBXgMrDKCXkSP5L-Hw@mail.gmail.com>
References: <20131008144211.GA25231@e102652-lin.cambridge.arm.com>
	 <CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com>
	 <525438F6.3090600@gmail.com>
	 <CAPcvp5Fvf5nkYXWviz8cKnOsMd0nOBJXrBXgMrDKCXkSP5L-Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-10-08 at 18:20 +0100, Andrew Murray wrote:
> I then refactored some of the pci_process_bridge_OF_ranges functions
> to use this parser, this was accepted by Microblaze [2] and has been
> recently acked by Ralf for MIPS but not made it upstream yet [3]. I
> think I submitted a patch for PowerPC at one point, but not sure what
> happened to that.

Probably slipped through as I was doing some other changes in that
area on powerpc and things conflicted. I can have a look at introducing
the use of your helpers again whenever I manage to get my head out of
meetings and patch monkeying for more than 5mn...

Cheers,
Ben.

> [1]
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=29b635c00f3ebcdaf7a52c4948f6d948ad3757d3
> [2]
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4f7b6de437544cd1e2e210919cb58cbe5cc3c393
> [3]
> http://www.linux-mips.org/archives/linux-mips/2013-09/msg00125.html
> 
> I'd like to get involved, but don't have any time at the moment.


