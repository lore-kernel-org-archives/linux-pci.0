Return-Path: <SRS0=5jRI=IY=arm.com=will.deacon@kernel.org>
Return-Path: <SRS0=5jRI=IY=arm.com=will.deacon@kernel.org>
Date: Wed, 6 Jun 2018 16:45:06 +0100
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marek Vasut <marek.vasut@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-pci <linux-pci@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>,
	Wolfram Sang <wsa@the-dreams.de>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] PCI: rcar: Add bus notifier so we can limit the DMA
 range
Message-ID: <20180606154505.GJ6631@arm.com>
References: <20180521220514.30256-1-marek.vasut+renesas@gmail.com>
 <CAK8P3a1PZ_MfgEcvWdUbN-eCcs5Xo38LQ54imLc4kNtSKO9Txw@mail.gmail.com>
 <c2897d82-fe33-52cd-5aa6-3bddb478cb9f@gmail.com>
 <20180604223048.GC30381@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180604223048.GC30381@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 04, 2018 at 05:30:48PM -0500, Bjorn Helgaas wrote:
> [+cc ARM64 folks, linux-kernel]
> 
> The original patch under discussion is:
> https://lkml.kernel.org/r/20180521220514.30256-1-marek.vasut+renesas@gmail.com
> 
> On Tue, May 22, 2018 at 11:52:21AM +0200, Marek Vasut wrote:
> > On 05/22/2018 10:10 AM, Arnd Bergmann wrote:
> > > On Tue, May 22, 2018 at 12:05 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > >> From: Phil Edworthy <phil.edworthy@renesas.com>
> > >>
> > >> The PCIe DMA controller on RCar Gen2 and earlier is on 32bit bus,
> > >> so limit the DMA range to 32bit.
> > >>
> > >> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > >> Cc: Arnd Bergmann <arnd@arndb.de>
> > >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > >> Cc: Simon Horman <horms+renesas@verge.net.au>
> > >> Cc: Wolfram Sang <wsa@the-dreams.de>
> > >> Cc: linux-renesas-soc@vger.kernel.org
> > >> To: linux-pci@vger.kernel.org
> > >> ---
> > >> NOTE: I'm aware of https://patchwork.kernel.org/patch/9495895/ , but the
> > >>       discussion seems to have gone way off, so I'm sending this as a
> > >>       RFC. Any feedback on how to do this limiting properly would be nice.
> > > 
> > > Doing it in the driver is clearly not appropriate, we must do this in
> > > common code. If I remember correctly, it's specifically ARM64 that is
> > > broken here, it incorrectly allows setting a DMA mask to 64 bit
> > > when that is not available.
> > 
> > Yep, that's correct. ARM64 with devices mapping tremendous amounts of
> > memory. So did anything change since that discussion references in the NOTE?

Is it specifically arm64 that's broken here? If so, why and how do other
archs (e.g. riscv) handle this? I thought all of this behaviour was driven
by the DMA ops, and we're just using generic code for that afaict.

Will
