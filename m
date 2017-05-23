Return-Path: <SRS0=iwkW=45=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=iwkW=45=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 23 May 2017 10:07:29 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org,
	hongxing.zhu@nxp.com, tharvey@gateworks.com,
	patchwork-lst@pengutronix.de,
	Peter Senna Tschudin <peter.senna@collabora.com>,
	kernel@pengutronix.de, bhelgaas@google.com, festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: imx6: fix downstream bus scanning
Message-ID: <20170523090729.GB18204@red-moon>
References: <20170510175752.6519-1-l.stach@pengutronix.de>
 <20170522221346.GG19733@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170522221346.GG19733@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 22, 2017 at 05:13:46PM -0500, Bjorn Helgaas wrote:
> On Wed, May 10, 2017 at 07:57:52PM +0200, Lucas Stach wrote:
> > The change in Linux 4.12 to make PCI configuartion requests non-posted
> > means that we are now getting a synchronous abort when the CFG space
> > read to probe for downstream devices times out.
> > 
> > Synchronous aborts need to be handled differently from the async aborts
> > we were getting before, in particular the PC needs to be advanced when
> > resolving the abort. This is mostly a copy of what other PCI drivers do
> > on ARM to handle those aborts.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Applied to for-linus for v4.12 with tested-by and acks from Fabio,
> Peter, and Richard.  I updated the subject line to:
> 
>   PCI: imx6: Fix config read timeout handling
> 
> because I don't think this change is specific to bus scanning and I
> wanted a hint that it's related to the config space mapping changes.
> 
> In fact, I'd really like to include the specific commit that caused
> this problem so that if the original commit is backported, there's a
> hint that we should backport this one, too.  I *think* it might be
> cc7b0d495589, so I updated the changelog to this:
> 
>   Commit cc7b0d495589 ("PCI: designware: Update PCI config space remap 
>   function") made PCI configuration requests non-posted, which means we now
>   get a synchronous abort when the CFG space read to probe for downstream
>   devices times out. 
> 
>   Synchronous aborts need to be handled differently from the async aborts we
>   were getting before, in particular the PC needs to be advanced when
>   resolving the abort.  This is mostly a copy of what other PCI drivers do on
>   ARM to handle those aborts.
> 
>   [bhelgaas: changelog, "Fixes"]
>   Fixes: cc7b0d495589 ("PCI: designware: Update PCI config space remap function")
> 
> Please let me know if this is the wrong commit.

I think it is the right commit but it is better if Lucas can confirm,
apologies for the breakage caused, I just could not test on iMX6.

Thanks,
Lorenzo

> > This is a fix that needs to go in for 4.12, but I would hope to get
> > some thorough testing before.
> > ---
> >  drivers/pci/dwc/pci-imx6.c | 33 ++++++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> > index a98cba55c7f0..19a289b8cc94 100644
> > --- a/drivers/pci/dwc/pci-imx6.c
> > +++ b/drivers/pci/dwc/pci-imx6.c
> > @@ -252,7 +252,34 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
> >  static int imx6q_pcie_abort_handler(unsigned long addr,
> >  		unsigned int fsr, struct pt_regs *regs)
> >  {
> > -	return 0;
> > +	unsigned long pc = instruction_pointer(regs);
> > +	unsigned long instr = *(unsigned long *)pc;
> > +	int reg = (instr >> 12) & 15;
> > +
> > +	/*
> > +	 * If the instruction being executed was a read,
> > +	 * make it look like it read all-ones.
> > +	 */
> > +	if ((instr & 0x0c100000) == 0x04100000) {
> > +		unsigned long val;
> > +
> > +		if (instr & 0x00400000)
> > +			val = 255;
> > +		else
> > +			val = -1;
> > +
> > +		regs->uregs[reg] = val;
> > +		regs->ARM_pc += 4;
> > +		return 0;
> > +	}
> > +
> > +	if ((instr & 0x0e100090) == 0x00100090) {
> > +		regs->uregs[reg] = -1;
> > +		regs->ARM_pc += 4;
> > +		return 0;
> > +	}
> > +
> > +	return 1;
> >  }
> >  
> >  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> > @@ -819,8 +846,8 @@ static int __init imx6_pcie_init(void)
> >  	 * we can install the handler here without risking it
> >  	 * accessing some uninitialized driver state.
> >  	 */
> > -	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> > -			"imprecise external abort");
> > +	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
> > +			"external abort on non-linefetch");
> >  
> >  	return platform_driver_register(&imx6_pcie_driver);
> >  }
> > -- 
> > 2.11.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
