Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757776Ab3FCWDy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Jun 2013 18:03:54 -0400
Message-ID: <51AD12AB.1000903@redhat.com>
Date: Mon, 03 Jun 2013 18:03:23 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Beno=EEt_Canet?= <benoit.canet@irqsave.net>
CC: linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
References: <20130601121320.GC5157@irqsave.net> <51ACE340.1030406@redhat.com> <20130603192958.GB31044@irqsave.net> <51AD02B1.8070503@redhat.com> <20130603212723.GG4094@irqsave.net> <51AD0DB8.8090109@redhat.com> <20130603215855.GC31044@irqsave.net>
In-Reply-To: <20130603215855.GC31044@irqsave.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/03/2013 05:58 PM, Benoît Canet wrote:
>>> When the PF does an FLR the hardware go back to its default state, the SR-IOV
>>> configuration is gone and the VFs disappears from the bus.
>>> Then the restore state function of the kernel reset code would bring the SR-IOV
>>> PF configuration back.
>>>
>> Ok, now you're a bit mis-led here.
>> The configuration header for SRIOV is _not_ put back.
>> Only the std, PCI config header section is put back in place, along with
>> msi(x), pm-caps.
>> If the hw wipes out all VF state setup (which it should, IMO), all VF configuration
>> will be lost in the hw...
>> *but*, the PCI core will still think the VFs exist (not hot-unplugged, no more than PF was);
>> trying to setup the VFs again, will fail (or worse).
>
> I read the following code on a not so hold kernel.
>
> -----------
> int pci_reset_function(struct pci_dev *dev)
> {
>> .......int rc;
>
>> .......rc = pci_dev_reset(dev, 1);
>> .......if (rc)
>> .......>.......return rc;
>
>> .......pci_save_state(dev);
>
>> ......./*
>> ....... * both INTx and MSI are disabled after the Interrupt Disable bit
>> ....... * is set and the Bus Master bit is cleared.
>> ....... */
>> .......pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
>
>> .......rc = pci_dev_reset(dev, 0);
>
>> .......pci_restore_state(dev);
>
>> .......return rc;
> }
> EXPORT_SYMBOL_GPL(pci_reset_function);
> -----------
>
> and
>
> -----------
> /**
>   * pci_restore_state - Restore the saved state of a PCI device
>   * @dev: - PCI device that we're dealing with
>   */
> void pci_restore_state(struct pci_dev *dev)
> {
>> .......if (!dev->state_saved)
>> .......>.......return;
>
>> ......./* PCI Express register must be restored first */
>> .......pci_restore_pcie_state(dev);
>> .......pci_restore_ats_state(dev);
>
>> .......pci_restore_config_space(dev);
>
>> .......pci_restore_pcix_state(dev);
>> .......pci_restore_msi_state(dev);
>> .......pci_restore_iov_state(dev);
>
>> .......dev->state_saved = false;
> }
> -----------
>
> with pci_restore_iov_state calling sriov_restore_state:
>
> -----------
> static void sriov_restore_state(struct pci_dev *dev)
> {
>> .......int i;
>> .......u16 ctrl;
>> .......struct pci_sriov *iov = dev->sriov;
>
>> .......pci_read_config_word(dev, iov->pos + PCI_SRIOV_CTRL,&ctrl);
>> .......if (ctrl&  PCI_SRIOV_CTRL_VFE)
>> .......>.......return;
>
>> .......for (i = PCI_IOV_RESOURCES; i<= PCI_IOV_RESOURCE_END; i++)
>> .......>.......pci_update_resource(dev, i);
>
>> .......pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
>> .......pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, iov->num_VFs);
>> .......pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>> .......if (iov->ctrl&  PCI_SRIOV_CTRL_VFE)
>> .......>.......msleep(100);
> }
> --------
>
> The sriov_restore_state looked like if it does the right thing but maybe I missread
> the code.
>
/my bad; I forgot about the save|restore_iov_state calls.... doh!

Now it gets down to how well your hw (& driver) works after the reset is done...

>>
>>> The hardware also have a privately owned SR-IOV related configuration in the PF
>>> configuration space. This configuration is used to configure the VFs resources.
>>> (memory)
>>>
>> Per the SRIOV spec, yes, but that's in PCIe ext cfg space.
>> That area of the PCI configuration is not saved or restored by dev-reset.
>
> Can a callback be added so PF driver can restore this state ?
>
As you pointed out, no need to, unless it's a device-specific,
PCIe cap structure.  the SRIOV caps are re-instated, as you showed above...

> Best regards
>
> Benoît Canet
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

