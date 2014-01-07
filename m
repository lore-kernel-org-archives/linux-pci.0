Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54719 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbaAGTAO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jan 2014 14:00:14 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: Jingoo Han <jg1.han@samsung.com>, Mohit Kumar <mohit.kumar@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: pcie-designware: query on MSI IRQ handling
Date: Tue, 7 Jan 2014 19:00:05 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B704662F8F@DFLE11.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am porting my current PCI Linux driver (based on v3.8) to designware
core driver (pcie-designware.c) to submit the patches to the mailing list
and got following question. Could someone clarify this please?

I see the following code in pcie-designware.c

void dw_pcie_msi_init(struct pcie_port *pp)
{
	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);

	/* program the msi_data */
	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
			virt_to_phys((void *)pp->msi_data));
	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
}

and then in 

static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
			struct msi_desc *desc)
{

         <---Cut--->

	msg.address_lo = virt_to_phys((void *)pp->msi_data);
	msg.address_hi = 0x0;
	msg.data = pos;
	printk("dw_msi_setup_irq address_lo = %x\n", msg.address_lo);
	write_msi_msg(irq, &msg);
}

In our designware IP, in the Application space, there is a MSI_IRQ register
that the EP needs to write with msi vector value to generate msi irq. So in
our case, pp->msi_data should be updated with address RC's MSI_IRQ
register. So I plan to update the msi_data in port's data structure with
MSI_IRQ virtual address and not call dw_msi_setup_irq().

I am trying to understand how MSI IRQ works on currently supported
designware PCIE hardwares (Samsung, Freescale etc). I am assuming
dw_pcie_wr_own_conf () write into RC's config space. But in the above
code, I see the code is updating the PCIE_MSI_ADDR_LO/HI
of the RC's config with a DDR address and in  write_msi_msg() this address
along with vector gets written to EP's MSI config space registers. In this case
how is the MSI IRQ gets generated from the EP?

EP writes to DDR address with the vector value. Does the PCIE hardware
match the address in the MSI irq message from EP with that in 
PCIE_MSI_ADDR_LO/HI and then raise an IRQ? Is this part of the Per Vector
Masking (PVM) option support as discussed in the PCI spec? Anyone
can explain this?

Also as part of my development, I plan to enhance this driver to override the
dw_msi_irq_chip with our platform specific chip data since MSI interrupt
controller is using application specific registers instead of the one at offset
0x828. I will sending an patch for review once my driver is tested.     

Thanks

Murali Karicheri
Linux Kernel, Software Development


