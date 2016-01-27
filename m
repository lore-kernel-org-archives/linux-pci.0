Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0064.outbound.protection.outlook.com ([104.47.36.64]:40304
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932494AbcA0Ole convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2016 09:41:34 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>, Michal Simek <michals@xilinx.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"paul.burton@imgtec.com" <paul.burton@imgtec.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"russell.joyce@york.ac.uk" <russell.joyce@york.ac.uk>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge
 driver to work on both Zynq and Microblaze
Date: Wed, 27 Jan 2016 14:41:27 +0000
Message-ID: <8520D5D51A55D047800579B09414719825873DCF@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <4734542.KZZp0TeeeM@wuerfel> <56A74370.4090000@xilinx.com>
 <2270955.TlqP7HlQk4@wuerfel>
In-Reply-To: <2270955.TlqP7HlQk4@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> 
> On Tuesday 26 January 2016 10:59:12 Michal Simek wrote:
> > >> diff --git a/drivers/pci/host/pcie-xilinx.c
> > >> b/drivers/pci/host/pcie-xilinx.c index 3e3757f..1981948 100644
> > >> --- a/drivers/pci/host/pcie-xilinx.c
> > >> +++ b/drivers/pci/host/pcie-xilinx.c
> > >> @@ -92,7 +92,12 @@
> > >>  #define ECAM_DEV_NUM_SHIFT          12
> > >>
> > >>  /* Number of MSI IRQs */
> > >> -#define XILINX_NUM_MSI_IRQS         128
> > >> +#define XILINX_NUM_MSI_IRQS 128
> > >> +#ifdef CONFIG_ARM
> > >> +#define TOT_NR_IRQS         XILINX_NUM_MSI_IRQS
> > >> +#else
> > >> +#define TOT_NR_IRQS         (NR_IRQS + XILINX_NUM_MSI_IRQS)
> > >> +#endif
> > >
> > > Something looks wrong here in the microblaze variant. What does
> > > NR_IRQS have to do with it?
> >
> > Arnd: What was the story regarding NR_IRQS?
> > I remember some discussion about it but just forget.
> >
> > Default value in include/asm-generic/irq.h is 64.
> > Current value is 32 because microblaze primary interrupt controller is
> > axi_intc core which has up to 32 input lines.
> 
> The value in asm-generic is completely arbitrary, it's just something that
> happens to work for a number of the simpler architectures.
> 
> Traditionally, there is a a fixed NR_IRQS which defines the maximum number
> of interrupts that can be used, and each irqchip has a fixed start offset below
> that number.
> 
> On modern systems, you have CONFIG_SPARSE_IRQ, which lets an irqchip
> allocate its own interrupts, without an upper limit. This is more flexible and
> avoids preallocating space for all irq_desc instances, so it saves memory.
> 
> This code however doesn't do either of the two on microblaze:
> 
> +       irq = pos;
> +#ifdef CONFIG_MICROBLAZE
> +#define TOT_NR_IRQS            (NR_IRQS + XILINX_NUM_MSI_IRQS)
> +       irq = XILINX_NUM_MSI_IRQS + pos; #endif
> +       if (irq < TOT_NR_IRQS)
>                 set_bit(pos, msi_irq_in_use);
> 
> So you define XILINX_NUM_MSI_IRQS to mean the number of interrupts
> that the xilinx_pcie_port can handle itself, but then pick a number
> outside of this range by making the hwirq number something between
> XILINX_NUM_MSI_IRQS and (2*XILINX_NUM_MSI_IRQS - 1), and in the
> end compare it to (NR_IRQS + XILINX_NUM_MSI_IRQS), which is the
> sum of two things that are not related: the total number of interrupts
> including the MSIs and the number of MSI.
> 
Agreed, I have crosschecked something's which I missed previously, NR_IRQS have nothing to do with the count, and also no need to add, irq = XILINX_NUM_MSI_IRQS + pos; in microblaze, I will remove these checks in next patch series.
