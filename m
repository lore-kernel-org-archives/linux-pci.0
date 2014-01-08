Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49521 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbaAHRcA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2014 12:32:00 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: pcie-designware: query on MSI IRQ handling
Date: Wed, 8 Jan 2014 17:31:50 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B7046639CA@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704662F8F@DFLE11.ent.ti.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FBAF2CCF@EAPEX1MAIL1.st.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>-----Original Message-----
>From: Karicheri, Muralidharan
>Sent: Wednesday, January 08, 2014 10:52 AM
>To: 'Mohit KUMAR DCG'; Jingoo Han; linux-pci@vger.kernel.org
>Subject: RE: pcie-designware: query on MSI IRQ handling
Mohit,

>
>>> void dw_pcie_msi_init(struct pcie_port *pp) {
>>> 	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
>>
>>I think we can implement dw_pcie_get_msi_addr() to get the MSI address
>>as  below. It checks if any specific ops is implemented then it will
>>get the address  from there otherwise default as in present case  will
>>be used. You should  implement get_msi_addr() specific to your platform.
>>
>>void dw_pcie_get_msi_addr(struct pcie port *pp) {
>>   	if (pp->ops->get_msi_addr)
>>		pp->msi_data = pp->ops->get_msi_addr;
>>	else
>>		pp->msi_data = __get_free_pages(GFP_KERNEL, 0); }
>>
>>And then call this from dw_pcie_msi_init() as:
>>
>>void dw_pcie_msi_init(..)
>>{
>>	dw_pcie_get_msi_addr(..);
>>
>>	/* program the msi_data */
>> 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
>>			virt_to_phys((void *)pp->msi_data));
>>	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0); } }

On a second thought,  I think we need some change like this
since PCIE_MSI_ADDR_LO/HIGH is not applicable for our IP.

void dw_pcie_msi_init(..)
{
        if (pp->ops->get_msi_addr)
              pp->msi_data = pp->ops->get_msi_addr();
        else {
              pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
              dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
                                     virt_to_phys((void *)pp->msi_data));
              dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
       }
}

Also see below.

>>>
>>> In our designware IP, in the Application space, there is a MSI_IRQ
>>> register that the EP needs to write with msi vector value to generate
>>> msi irq. So in our case, pp->msi_data should be updated with address
>>> RC's MSI_IRQ
>>register.
>>> So I plan to update the msi_data in port's data structure with
>>> MSI_IRQ virtual address and not call dw_msi_setup_irq().
>>> I am trying to understand how MSI IRQ works on currently supported
>>> designware PCIE hardwares (Samsung, Freescale etc). I am assuming
>>> dw_pcie_wr_own_conf () write into RC's config space. But in the above
>>> code, I see the code is updating the PCIE_MSI_ADDR_LO/HI of the RC's
>>> config with a DDR address and in  write_msi_msg() this address along
>>> with vector gets written to EP's MSI config space registers. In this
>>> case how is the MSI IRQ gets generated from the EP?
>>>
>>> EP writes to DDR address with the vector value. Does the PCIE
>>> hardware match the address in the MSI irq message from EP with that
>>> in PCIE_MSI_ADDR_LO/HI and then raise an IRQ?
>>
>>Yes.
>>
>>> Is this part of the Per Vector
>>> Masking (PVM) option support as discussed in the PCI spec? Anyone can
>>> explain this?
>>>
>>> Also as part of my development, I plan to enhance this driver to
>>> override the dw_msi_irq_chip with our platform specific chip data
>>> since MSI interrupt controller is using application specific
>>> registers instead of the one at offset 0x828. I will sending an patch
>>> for review once my driver is
>>tested.
>>
>>So in you controller you do not have regiter offset 0x820-0x830, right?
>>Then probably, its not generic MSI controller as implemented in newer verion of IP.
>>
>>Hmm....if the same registers are in your application space then maybe
>>you can handle Similar to to get_msi_addr() as suggested above.
>>

I can't just get the register address for this as in the case of msi_data. 
To support 32 MSI irqs, there are 8 application registers triplet (1 for 
Enable, 1 for disable, and status) each handling 4 IRQs.

So I need hook in assign_irq() and clear_irq() to enable/disable
the interrupts in application register

assign_irq()
{
	<--- cut --->
                if (pp->ops->enable_msi_irq)
                        pp->ops->enable_msi_irq(pp, pos0 + i);
                else {
                        res = ((pos0 + i) / 32) * 12;
                        bit = (pos0 + i) % 32;
                        dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
                        val |= 1 << bit;
                        dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
                }
}

clear_irq()
{
	<----cut --->

        if (pp->ops->disable_msi_irq)
                        pp->ops->disable_msi_irq(pp, pos);
        else {
                dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
                val &= ~(1 << bit);
                dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
        }
}

And for handling the interrupt, currently the driver rely on unmask_msi_irq
and mask_msi_irq from msi.c to mask/unmask the interrupt at the EP even
though PVM (Per Vector Masking) is an optional feature. So this may not
work on EP devices without PVM support. might need to use
desc->msi_attrib.maskbit to call unmask_msi_irq()/mask_msi_irq() or use
use masking at RC level. For our IP we have application register to disable
or enable interrupt and could make use of this. For other IPs, I am not
sure how this can be handled.

So we need to have a way to override the default irq_chip with user driver
specific (in platform specific glue driver) irq_chip that can mask the interrupt
at RC level using application register.

For the designware core driver to support non PVM supported EP device,
you might require changes to mask/unmask/enable/disable calls in the
IRQ chip. I would like to hear how this is handled in other designware 
base PCIe drivers. Any thoughts?

Murali
>That is right. Agree with both of your suggestions. Will send a patch along with my driver
>patches.
>
>>Regards
>>Mohit
>>>
>>> Thanks
>>>
>>> Murali Karicheri
>>> Linux Kernel, Software Development
>>>

