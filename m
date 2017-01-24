Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "paul.gortmaker@windriver.com"
 <paul.gortmaker@windriver.com>, "robh@kernel.org" <robh@kernel.org>,
 "colin.king@canonical.com" <colin.king@canonical.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 1/4] PCI: Xilinx NWL: Fix, do not check for legacy
 status in while loop
Date: Tue, 24 Jan 2017 14:00:52 +0000
Message-ID: <8520D5D51A55D047800579B094147198263CD2C7@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
 <ec10b089-acc5-7764-6346-9dc1869d05c7@arm.com>
 <8520D5D51A55D047800579B094147198263CCF96@XAP-PVEXMBX02.xlnx.xilinx.com>
 <0def9067-5c35-f7fe-8e15-bab70d479d1e@arm.com>
In-Reply-To: <0def9067-5c35-f7fe-8e15-bab70d479d1e@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "arnd@arndb.de" <arnd@arndb.de>, Ravikiran Gummaluri <rgummal@xilinx.com>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> On 24/01/17 10:15, Bharat Kumar Gogada wrote:
> >> On 21/01/17 11:11, Bharat Kumar Gogada wrote:
> >>> - The legacy status register value for particular INTx becomes low
> >>> only after DEASSERT_INTx is received.
> >>> - Few End Points take time for sending DEASSERT_INTx, checking
> >>> legacy status register in while loop causes invoking of EP handler
> >>> continuosly until DEASSERT_INTx is received.
> >>>
> >>> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> >>> ---
> >>>  drivers/pci/host/pcie-xilinx-nwl.c |    5 +++--
> >>>  1 files changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> >>> b/drivers/pci/host/pcie-xilinx-nwl.c
> >>> index 43eaa4a..c8b5a33 100644
> >>> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> >>> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> >>> @@ -342,9 +342,10 @@ static void nwl_pcie_leg_handler(struct
> >>> irq_desc
> >>> *desc)
> >>>
> >>>  	chained_irq_enter(chip, desc);
> >>>  	pcie = irq_desc_get_handler_data(desc);
> >>> +	status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> >>> +				  MSGF_LEG_SR_MASKALL;
> >>>
> >>> -	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> >>> -				MSGF_LEG_SR_MASKALL) != 0) {
> >>> +	if (status != 0) {
> >>>  		for_each_set_bit(bit, &status, INTX_NUM) {
> >>>  			virq = irq_find_mapping(pcie->legacy_irq_domain,
> >>>  						bit + 1);
> >>>
> >>
> >> But even if you only handle the interrupt once, it is still asserted,
> >> right? You exit the low-level exception handler, only to take the
> >> interrupt immediately again. So what is the gain here?
> >>
> > Whenever masking of INTx happens (like as in my next patch[PATCH
> > 2/4]), the irq line goes low, but  status bit will be set until DEASSERT_INTx
> comes.
> > In this scenario if it is always in while loop, even though line went
> > low it will not be seen until DEASSERT_INTx, unnecessarily invoking EP
> > driver. so instead of while loop using if condition so that this change in line is
> noticed.
> 
> But what guarantees that you will observe this DEASSERT if you return to the
> interrupted context early? From what I understand, your interrupt flow is the
> following:
> 
> 
> 	read status
> 	mask
> 	handler
> 	unmask
> 
> If the EP takes time to send a deassert after the handler has poked it and the
> interrupt is still active, then the only thing that this patch buys you is that by
> returning to the interrupted context, you waste a lot of cycles, giving the device
> a chance to send its deassert. But that's just luck. Plug this on a fast CPU, and
> the same issue will resurface.
> 

Agreed, will leave it as it is.

Thanks & Regards,
Bharat


 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
