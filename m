Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 16 Mar 2018 11:22:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [PATCH v5 1/2] PCI: mediatek: Clear IRQ status after IRQ
 dispatched to avoid reentry
Message-ID: <20180316112216.GA24325@e107981-ln.cambridge.arm.com>
References: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
 <1514336394-17747-2-git-send-email-honghui.zhang@mediatek.com>
 <20180104184040.GE12239@red-moon>
 <88c84a3e-17ea-08f2-e5fc-4799b41de267@arm.com>
 <1515153107.25872.57.camel@mhfsdcap03>
MIME-Version: 1.0
In-Reply-To: <1515153107.25872.57.camel@mhfsdcap03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 05, 2018 at 07:51:47PM +0800, Honghui Zhang wrote:
> On Thu, 2018-01-04 at 19:04 +0000, Marc Zyngier wrote:
> > On 04/01/18 18:40, Lorenzo Pieralisi wrote:
> > > [+Marc]
> > > 
> > > On Wed, Dec 27, 2017 at 08:59:53AM +0800, honghui.zhang@mediatek.com wrote:
> > >> From: Honghui Zhang <honghui.zhang@mediatek.com>
> > >>
> > >> There maybe a same IRQ reentry scenario after IRQ received in current
> > >> IRQ handle flow:
> > >> 	EP device		PCIe host driver	EP driver
> > >> 1. issue an IRQ
> > >> 			2. received IRQ
> > >> 			3. clear IRQ status
> > >> 			4. dispatch IRQ
> > >> 						5. clear IRQ source
> > >> The IRQ status was not successfully cleared at step 2 since the IRQ
> > >> source was not cleared yet. So the PCIe host driver may receive the
> > >> same IRQ after step 5. Then there's an IRQ reentry occurred.
> > >> Even worse, if the reentry IRQ was not an IRQ that EP driver expected,
> > >> it may not handle the IRQ. Then we may run into the infinite loop from
> > >> step 2 to step 4.
> > >> Clear the IRQ status after IRQ have been dispatched to avoid the IRQ
> > >> reentry.
> > >> This patch also fix another INTx IRQ issue by initialize the iterate
> > >> before the loop. If an INTx IRQ re-occurred while we are dispatching
> > >> the INTx IRQ, then iterate may start from PCI_NUM_INTX + INTX_SHIFT
> > >> instead of INTX_SHIFT for the second time entering the
> > >> for_each_set_bit_from() loop.
> > > 
> > > This looks like two different issues that should be fixed with two
> > > patches.
> 
> Ok, I split this into two patches and figure out a more reasonable
> approach by using irq_chip solution.

For the time being, I will mark this patch as "Changes Requested"
waiting for a new version.

Thanks,
Lorenzo

> 
> > > 
> > >> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > >> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > >> ---
> > >>  drivers/pci/host/pcie-mediatek.c | 11 ++++++-----
> > >>  1 file changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > For the sake of uniformity, I first want to understand why this
> > > driver does not call:
> > > 
> > > chained_irq_enter/exit()
> > > 
> > > in the primary handler (mtk_pcie_intr_handler()).
> > > 
> > > With the GIC as a primary interrupt controller we have not
> > > even figured out how current code can actually work without
> > > calling the chained_* API.
> > > 
> > > I want to come up with a consistent handling of IRQ domains for
> > > all host bridges and any discrepancy should be explained.
> > 
> > That's because this driver is a huge hack, see below:
> > 
> > > 
> > >> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> > >> index db93efd..fc29a9a 100644
> > >> --- a/drivers/pci/host/pcie-mediatek.c
> > >> +++ b/drivers/pci/host/pcie-mediatek.c
> > >> @@ -601,15 +601,16 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
> > 
> > This function is not a chained irqchip, but an interrupt handler...
> > 
> > >>  	struct mtk_pcie_port *port = (struct mtk_pcie_port *)data;
> > >>  	unsigned long status;
> > >>  	u32 virq;
> > >> -	u32 bit = INTX_SHIFT;
> > >> +	u32 bit;
> > >>  
> > >>  	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
> > >> +		bit = INTX_SHIFT;
> > >>  		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
> > >> -			/* Clear the INTx */
> > >> -			writel(1 << bit, port->base + PCIE_INT_STATUS);
> > >>  			virq = irq_find_mapping(port->irq_domain,
> > >>  						bit - INTX_SHIFT);
> > >>  			generic_handle_irq(virq);
> > 
> > and nonetheless, this calls into generic_handle_irq(). That's a complete
> > violation of the interrupt layering. Maybe there is a good reason for
> > it, but I'd like to know which one.
> > 
> > Which means that all of the ack/mask has to be done outside of the
> > irqchip framework too... Disgusting.
> > 
> > >> +			/* Clear the INTx */
> > >> +			writel(1 << bit, port->base + PCIE_INT_STATUS);
> > > 
> > > I think that these masking/acking should actually be done through
> > > the irq_chip hooks (see for instance pci-ftpci100.c) - that would
> > > make this kind of bugs much easier to prevent (because the IRQ
> > > layer does the sequencing for you).
> > 
> > +1.
> > 
> 
> Thanks for your advice, I need to do some homework to have a better
> understanding of the irq_chip approach.
> 
> > > Marc (CC'ed) has a more comprehensive view on this than me - I would
> > > like to get to a point where all host bridges uses a consistent
> > > approach for chained IRQ handling and I hope this bug fix can be
> > > a starting point.
> > 
> > +1 again. We definitely need to come up with some form of common
> > approach for all these host drivers, and maybe turn that into a library...
> > 
> 
> Well, this is beyond my knowledge now, I guess I can figure out how to
> using irq_chip for the first step, then I may following this "common
> approach" after we have a solution for that?
> 
> thanks.
> > Thanks,
> > 
> > 	M.
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
