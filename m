Return-Path: <SRS0=6mTy=IL=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=6mTy=IL=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 24 May 2018 14:50:43 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: rcar: Rename
 rcar_pcie_parse_request_of_pci_ranges()
Message-ID: <20180524135043.GB22455@e107981-ln.cambridge.arm.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
 <20180523161711.GA8113@e107981-ln.cambridge.arm.com>
 <5fc7b4ff-1c75-4d3f-6cb7-fda4559a3635@gmail.com>
 <20180523215626.GG150632@bhelgaas-glaptop.roam.corp.google.com>
 <56b86e01-394e-0cf0-5da2-e884c29bb41e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56b86e01-394e-0cf0-5da2-e884c29bb41e@gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2018 at 09:24:27AM +0200, Marek Vasut wrote:
> On 05/23/2018 11:56 PM, Bjorn Helgaas wrote:
> > On Wed, May 23, 2018 at 07:05:06PM +0200, Marek Vasut wrote:
> >> On 05/23/2018 06:17 PM, Lorenzo Pieralisi wrote:
> >>> On Mon, May 21, 2018 at 03:11:20PM +0200, Marek Vasut wrote:
> >>>> The function name is just too confusing, rename it, no functional change.
> >>>> Rename the function to rcar_pcie_alloc_and_parse_pci_resource_list() as
> >>>> it's matching failpath function is pci_free_resource_list() so the names
> >>>> align much better and the new name also describes what the function does
> >>>> much better.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> >>>> Cc: Simon Horman <horms+renesas@verge.net.au>
> >>>> Cc: Wolfram Sang <wsa@the-dreams.de>
> >>>> Cc: linux-renesas-soc@vger.kernel.org
> >>>> ---
> >>>>  drivers/pci/host/pcie-rcar.c | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> Can you rebase this series against my pci/rcar branch please ?
> >>>
> >>> I will merge it then, thanks.
> >>
> >> Where is that tree/branch located ?
> >>
> >> It applies fine on current next 20180517, is there a problem ?
> > https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=pci/rcar
> 
> OK, 1/4 is dropped, the remaining patches are resubmitted. I added one
> more (6/6) since the phy patches in that tree added a bug into the fail
> path, so I fixed that too.

Please CC me if you want me to merge your code, I monitor linux-pci
but that would help me, thanks.

You did not add the review tags you received to the new series (also a
cover letter - however minimal - and a version number would help),
please add them and post a v2 so that I can merge them, I can do that
for you but it is good practice for the future.

Thanks,
Lorenzo

> > I don't think next 20180517 includes Lorenzo's pci/rcar branch, so
> > there might be conflicts.  I think Stephen is on vacation until next
> > week, so there isn't a newer -next tree yet.
> 
> OK
> 
> -- 
> Best regards,
> Marek Vasut
