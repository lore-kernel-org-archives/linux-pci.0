Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "paul.gortmaker@windriver.com"
 <paul.gortmaker@windriver.com>, "robh@kernel.org" <robh@kernel.org>,
 "colin.king@canonical.com" <colin.king@canonical.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] PCI: Xilinx NWL: Fix, proc interrupts for legacy
 virtual irq shown as edge
Date: Mon, 30 Jan 2017 05:57:23 +0000
Message-ID: <8520D5D51A55D047800579B094147198263DC9BE@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1485334353-26815-1-git-send-email-bharatku@xilinx.com>
 <1485334353-26815-2-git-send-email-bharatku@xilinx.com>
 <0833bdec-b05e-57c0-c740-ac7735036450@arm.com>
In-Reply-To: <0833bdec-b05e-57c0-c740-ac7735036450@arm.com>
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

> 
> On 25/01/17 08:52, Bharat Kumar Gogada wrote:
> > - Legacy interrupts are level triggered, virtual irq line of End Point
> > shows as edge in /proc/interrupts.
> > - Setting irq flags of virtual irq line of EP to level triggered at
> > the time of mapping.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > ---
> >  drivers/pci/host/pcie-xilinx-nwl.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> > b/drivers/pci/host/pcie-xilinx-nwl.c
> > index 6ac3e1d..1cddd1f 100644
> > --- a/drivers/pci/host/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> > @@ -434,6 +434,7 @@ static int nwl_legacy_map(struct irq_domain
> > *domain, unsigned int irq,  {
> >  	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
> >  	irq_set_chip_data(irq, domain->host_data);
> > +	irq_set_status_flags(irq, IRQ_LEVEL);
> >
> >  	return 0;
> >  }
> >
> 
> As said in my previous review [1], this should be folded in the previous patch, as
> it doesn't make much sense on its own.
> 
Agreed, will send in same previous patch. 

bharat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
