Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64343 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419Ab2EWSfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 14:35:48 -0400
Received: by lbbgm6 with SMTP id gm6so5298498lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 11:35:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FBD23BD.6050703@linux.vnet.ibm.com>
References: <4FBC4C92.7080902@jp.fujitsu.com> <4FBD23BD.6050703@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 23 May 2012 12:35:26 -0600
Message-ID: <CAErSpo5G1gFXdQwyjm1uhL41G7gLijbVd6gGkz_k8=XsWdcPNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/PCI: Add pcibios_device_change_notifier
 for powerpc
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
Cc: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	jbarnes@virtuousgeek.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2012 at 11:51 AM, Jesse Larrew
<jlarrew@linux.vnet.ibm.com> wrote:
> On 05/22/2012 09:33 PM, Hiroo Matsumoto wrote:
>
>> +static int pcibios_device_change_notifier(struct notifier_block *nb,
>> +                                       unsigned long action, void *data)
>> +{
>> +     struct pci_dev *dev = to_pci_dev(data);
>> +
>
>
>
> In the general case, we don't know what *data contains until we evaluate
> 'action'. This conversion should probably be moved inside the case:
> statement.

We registered it with  "bus_register_notifier(&pci_bus_type, ...)" and
every user of the bus_notifier change passes a "struct device *", so I
think we do know that we have a PCI device.

A future bus_notifier user *could* pass something other than a "struct
device *", but the pattern Hiroo used here ("struct pci_dev *dev =
to_pci_dev(data);" before looking at "action") seems pretty common, so
I don't think it's likely.

>> +     switch (action) {
>> +     case BUS_NOTIFY_ADD_DEVICE:
>> +             /* Setup OF node pointer in the device */
>> +             dev->dev.of_node = pci_device_to_OF_node(dev);
>> +
>> +             /* Fixup NUMA node as it may not be setup yet by the generic
>> +              * code and is needed by the DMA init
>> +              */
>> +             set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
>> +
>> +             /* Hook up default DMA ops */
>> +             set_dma_ops(&dev->dev, pci_dma_ops);
>> +             set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
>> +
>> +             /* Additional platform DMA/iommu setup */
>> +             if (ppc_md.pci_dma_dev_setup)
>> +                     ppc_md.pci_dma_dev_setup(dev);
>> +
>> +             /* Read default IRQs and fixup if necessary */
>> +             pci_read_irq_line(dev);
>> +             if (ppc_md.pci_irq_fixup)
>> +                     ppc_md.pci_irq_fixup(dev);
>> +
>> +             break;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static struct notifier_block device_nb = {
>> +     .notifier_call = pcibios_device_change_notifier,
>> +};
>
>
>
> This is just a nit pick, but I think the naming of
> pcibios_device_change_notifier() is a bit misleading. It doesn't
> actually notify anything, but instead it *handles* notifications.
> Perhaps a better name would be pcibios_device_change_handler() or
> pcibios_device_change_callback()?

Good point.  "_notify()" seems to be a common name, how about
pci_bus_notify()?  It's static to the file, so it doesn't have to be
very unique.

I happened to be merging these patches just now, so I'll make this
change provisionally, pending any more discussion.

Thanks a lot for reviewing this!

Bjorn
