Return-Path: <SRS0=fr7Z=FR=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=fr7Z=FR=arm.com=lorenzo.pieralisi@kernel.org>
Date: Fri, 23 Feb 2018 10:35:03 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Paul Burton <paul.burton@mips.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vineet Gupta <vgupta@synopsys.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Christoph Hellwig <hch@lst.de>,
	Michal Nazarewicz <mina86@mina86.com>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	Will Deacon <will.deacon@arm.com>, Tony Lindgren <tony@atomide.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 20/20] x86/PCI: VMD: Fix malformed Kconfig default
Message-ID: <20180223103455.GA20461@e107981-ln.cambridge.arm.com>
References: <0180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
 <20180206221106.16620-1-ulfalizer@gmail.com>
 <20180222230052.GA14632@bhelgaas-glaptop.roam.corp.google.com>
 <CAFkk2KScFZE0sjZovi1vq2xBQ_-wx2XoSbWG6_qL2W0rR5B7YQ@mail.gmail.com>
 <20180223002142.GG14632@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180223002142.GG14632@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 22, 2018 at 06:21:42PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 23, 2018 at 12:42:28AM +0100, Ulf Magnusson wrote:
> > On Fri, Feb 23, 2018 at 12:00 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Feb 06, 2018 at 11:11:06PM +0100, Ulf Magnusson wrote:
> > >> 'default N' should be 'default n', though they happen to have the same
> > >> effect here, due to undefined symbols (N in this case) evaluating to n
> > >> in a tristate sense.
> > >>
> > >> Remove the default instead of changing it. bool and tristate symbols
> > >> implicitly default to n.
> > >
> > > s/bool/Bool/
> > 
> > Not a great excuse, but I was thinking syntactically -- 'bool' and
> > 'tristate' symbols... :)
> > 
> > >
> > >> Discovered with the
> > >> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> > >> script.
> > >>
> > >> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> > >
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Since only this patch was posted to linux-pci, I assume it will be merged
> > > via some other tree.
> > 
> > I didn't have a particular tree in mind for this patchset. I imagined
> > people would pick up patches into the trees where they make the most
> > sense, and only created the patchset to keep track of the patches more
> > easily. Might have created some confusion in retrospect.
> > 
> > I just did a --cc-cmd="scripts/get_maintainer.pl -i" for the
> > individual patches by the way.
> 
> OK, then either Lorenzo or I will pick it up.
> 
> It's in drivers/pci/host/, so ideally Lorenzo will take it since he
> looks after everything else in there.

Sure I will take it, thanks.

Lorenzo
