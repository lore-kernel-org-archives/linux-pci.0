Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:60008 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbcAZMMV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2016 07:12:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Michal Simek <michal.simek@xilinx.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	bhelgaas@google.com, lorenzo.pieralisi@arm.com,
	paul.burton@imgtec.com, yinghai@kernel.org, wangyijing@huawei.com,
	robh@kernel.org, russell.joyce@york.ac.uk, sorenb@xilinx.com,
	jiang.liu@linux.intel.com, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver to work on both Zynq and Microblaze
Date: Tue, 26 Jan 2016 13:11:20 +0100
Message-ID: <2270955.TlqP7HlQk4@wuerfel>
In-Reply-To: <56A74370.4090000@xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com> <4734542.KZZp0TeeeM@wuerfel> <56A74370.4090000@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 26 January 2016 10:59:12 Michal Simek wrote:
> >> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> >> index 3e3757f..1981948 100644
> >> --- a/drivers/pci/host/pcie-xilinx.c
> >> +++ b/drivers/pci/host/pcie-xilinx.c
> >> @@ -92,7 +92,12 @@
> >>  #define ECAM_DEV_NUM_SHIFT          12
> >>  
> >>  /* Number of MSI IRQs */
> >> -#define XILINX_NUM_MSI_IRQS         128
> >> +#define XILINX_NUM_MSI_IRQS 128
> >> +#ifdef CONFIG_ARM
> >> +#define TOT_NR_IRQS         XILINX_NUM_MSI_IRQS
> >> +#else
> >> +#define TOT_NR_IRQS         (NR_IRQS + XILINX_NUM_MSI_IRQS)
> >> +#endif
> > 
> > Something looks wrong here in the microblaze variant. What does NR_IRQS
> > have to do with it?
> 
> Arnd: What was the story regarding NR_IRQS?
> I remember some discussion about it but just forget.
> 
> Default value in include/asm-generic/irq.h is 64.
> Current value is 32 because microblaze primary interrupt controller is
> axi_intc core which has up to 32 input lines.

The value in asm-generic is completely arbitrary, it's just something
that happens to work for a number of the simpler architectures.

Traditionally, there is a a fixed NR_IRQS which defines the maximum
number of interrupts that can be used, and each irqchip has a fixed
start offset below that number.

On modern systems, you have CONFIG_SPARSE_IRQ, which lets an irqchip
allocate its own interrupts, without an upper limit. This is more
flexible and avoids preallocating space for all irq_desc instances,
so it saves memory.

This code however doesn't do either of the two on microblaze:

+       irq = pos;
+#ifdef CONFIG_MICROBLAZE
+#define TOT_NR_IRQS            (NR_IRQS + XILINX_NUM_MSI_IRQS)
+       irq = XILINX_NUM_MSI_IRQS + pos;
+#endif
+       if (irq < TOT_NR_IRQS)
                set_bit(pos, msi_irq_in_use);

So you define XILINX_NUM_MSI_IRQS to mean the number of interrupts
that the xilinx_pcie_port can handle itself, but then pick a number
outside of this range by making the hwirq number something between
XILINX_NUM_MSI_IRQS and (2*XILINX_NUM_MSI_IRQS - 1), and in the
end compare it to (NR_IRQS + XILINX_NUM_MSI_IRQS), which is the
sum of two things that are not related: the total number of interrupts
including the MSIs and the number of MSI.

	Arnd
