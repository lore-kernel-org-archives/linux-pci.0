Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH 1/3] PCI: Xilinx NWL PCIe: Expanding PCIe core errors
 and printing event occurred.
Date: Wed, 14 Sep 2016 05:26:44 +0000
Message-ID: <8520D5D51A55D047800579B094147198258D615E@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
 <20160913143202.GB27748@localhost>
In-Reply-To: <20160913143202.GB27748@localhost>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Ravikiran Gummaluri <rgummal@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Michal Simek <michals@xilinx.com>, Soren Brinkmann <sorenb@xilinx.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "colin.king@canonical.com" <colin.king@canonical.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> Hi Bharat,
> 
> On Tue, Aug 30, 2016 at 04:09:16PM +0530, Bharat Kumar Gogada wrote:
> > The current driver prints pcie core error, for all core events.
> > Instead of just printing PCIe core error, now adding prints to show
> > individual core events occurred.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > ---
> >  drivers/pci/host/pcie-xilinx-nwl.c | 48
> > +++++++++++++++++++++++++++++++-------
> >  1 file changed, 40 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> > b/drivers/pci/host/pcie-xilinx-nwl.c
> > index 3479d30..86c1834 100644
> > --- a/drivers/pci/host/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> > @@ -85,10 +85,15 @@
> >  #define MSGF_MISC_SR_MASTER_ERR		BIT(5)
> >  #define MSGF_MISC_SR_I_ADDR_ERR		BIT(6)
> >  #define MSGF_MISC_SR_E_ADDR_ERR		BIT(7)
> > -#define MSGF_MISC_SR_UR_DETECT          BIT(20)
> > -
> > -#define MSGF_MISC_SR_PCIE_CORE		GENMASK(18, 16)
> > -#define MSGF_MISC_SR_PCIE_CORE_ERR	GENMASK(31, 22)
> > +#define MSGF_MISC_SR_FATAL_AER		BIT(16)
> > +#define MSGF_MISC_SR_NON_FATAL_AER	BIT(17)
> > +#define MSGF_MISC_SR_CORR_AER		BIT(18)
> > +#define MSGF_MISC_SR_UR_DETECT		BIT(20)
> > +#define MSGF_MISC_SR_NON_FATAL_DEV	BIT(22)
> > +#define MSGF_MISC_SR_FATAL_DEV		BIT(23)
> > +#define MSGF_MISC_SR_LINK_DOWN		BIT(24)
> > +#define MSGF_MSIC_SR_LINK_AUTO_BWIDTH	BIT(25)
> > +#define MSGF_MSIC_SR_LINK_BWIDTH	BIT(26)
> >
> >  #define MSGF_MISC_SR_MASKALL
> 	(MSGF_MISC_SR_RXMSG_AVAIL | \
> >  					MSGF_MISC_SR_RXMSG_OVER | \
> > @@ -96,9 +101,15 @@
> >  					MSGF_MISC_SR_MASTER_ERR | \
> >  					MSGF_MISC_SR_I_ADDR_ERR | \
> >  					MSGF_MISC_SR_E_ADDR_ERR | \
> > +					MSGF_MISC_SR_FATAL_AER | \
> > +					MSGF_MISC_SR_NON_FATAL_AER | \
> > +					MSGF_MISC_SR_CORR_AER | \
> >  					MSGF_MISC_SR_UR_DETECT | \
> > -					MSGF_MISC_SR_PCIE_CORE | \
> > -					MSGF_MISC_SR_PCIE_CORE_ERR)
> > +					MSGF_MISC_SR_NON_FATAL_DEV | \
> > +					MSGF_MISC_SR_FATAL_DEV | \
> > +					MSGF_MISC_SR_LINK_DOWN | \
> > +					MSGF_MSIC_SR_LINK_AUTO_BWIDTH
> | \
> > +					MSGF_MSIC_SR_LINK_BWIDTH)
> >
> >  /* Legacy interrupt status mask bits */
> >  #define MSGF_LEG_SR_INTA		BIT(0)
> > @@ -291,8 +302,29 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void
> *data)
> >  		dev_err(pcie->dev,
> >  			"In Misc Egress address translation error\n");
> >
> > -	if (misc_stat & MSGF_MISC_SR_PCIE_CORE_ERR)
> > -		dev_err(pcie->dev, "PCIe Core error\n");
> > +	if (misc_stat & MSGF_MISC_SR_FATAL_AER)
> > +		dev_err(pcie->dev, "Fatal Error in AER Capability\n");
> > +
> > +	if (misc_stat & MSGF_MISC_SR_NON_FATAL_AER)
> > +		dev_err(pcie->dev, "Non-Fatal Error in AER Capability\n");
> > +
> > +	if (misc_stat & MSGF_MISC_SR_CORR_AER)
> > +		dev_err(pcie->dev, "Correctable Error in AER Capability\n");
> > +
> > +	if (misc_stat & MSGF_MISC_SR_UR_DETECT)
> > +		dev_err(pcie->dev, "Unsupported request Detected\n");
> > +
> > +	if (misc_stat & MSGF_MISC_SR_NON_FATAL_DEV)
> > +		dev_err(pcie->dev, "Non-Fatal Error Detected\n");
> > +
> > +	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
> > +		dev_err(pcie->dev, "Fatal Error Detected\n");
> > +
> > +	if (misc_stat & MSGF_MSIC_SR_LINK_AUTO_BWIDTH)
> > +		dev_info(pcie->dev, "Link Autonomous Bandwidth Management
> Status
> > +bit set\n");
> > +
> > +	if (misc_stat & MSGF_MSIC_SR_LINK_BWIDTH)
> > +		dev_info(pcie->dev, "Link Bandwidth Management Status bit
> set\n");
> >
> >  	/* Clear misc interrupt status */
> >  	nwl_bridge_writel(pcie, misc_stat, MSGF_MISC_STATUS);
> 
> This patch looks fine, but looking at the code as a whole, I have a question.  You
> basically have this:
> 
>   misc_stat = nwl_bridge_readl(pcie, MSGF_MISC_STATUS) &
> MSGF_MISC_SR_MASKALL;
>   if (!misc_stat)
>     return IRQ_NONE;
>   ...
>   nwl_bridge_writel(pcie, misc_stat, MSGF_MISC_STATUS);
> 
> The masking with MSGF_MISC_SR_MASKALL seems wrong.  Let's say
> MSGF_MISC_STATUS had some other bit set, e.g., BIT(31), indicating some yet-
> unsupported interrupt cause.  BIT(31) is not in MSGF_MISC_SR_MASKALL, so we
> return IRQ_NONE without clearing the interrupt bit in MSGF_MISC_STATUS.
> Won't that cause an interrupt storm where the interrupt is continually re-
> asserted because we never clear it?
> 
> It seems like it would make more sense to do this:
> 
>   misc_stat = nwl_bridge_readl(pcie, MSGF_MISC_STATUS);
>   if (!misc_stat)
>     return IRQ_NONE;
>   ...
>   if (misc_stat != (misc_stat & MSGF_MISC_SR_MASKALL))
>     dev_err(dev, "unexpected IRQ, MSGF_MISC_STATUS %#010x\n", misc_stat);
>   nwl_bridge_writel(pcie, misc_stat, MSGF_MISC_STATUS);

Hi Bjorn,

Thanks for the suggestion. The above mentioned bits are reserved and they will never go high. 
We haven't seen such kind of issue until now. 
So I feel the current implementation is fine.

Thanks & Regards,
Bharat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
