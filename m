Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33789 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab2DWRVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Apr 2012 13:21:40 -0400
Received: by lbom4 with SMTP id m4so5838834lbo.19
        for <linux-pci@vger.kernel.org>; Mon, 23 Apr 2012 10:21:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F8BBCE5.6010108@jp.fujitsu.com>
References: <4F79584B.2010301@jp.fujitsu.com> <CAErSpo4Yy9d93gNzDadFxSN+41NkEKBz4yai9KzB1aaCP3pwWw@mail.gmail.com>
 <4F7AA3A2.1080900@jp.fujitsu.com> <4F7C003B.4040208@jp.fujitsu.com>
 <4F866184.4000403@jp.fujitsu.com> <CAErSpo6Xb6rbZ757VHuQnWWsXbnygTM9JQFzvOnOiM895D+R-g@mail.gmail.com>
 <4F876C54.5040408@jp.fujitsu.com> <4F8BBCE5.6010108@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Apr 2012 11:21:18 -0600
Message-ID: <CAErSpo4yicqFBGEFWYuDfknWaeFcisWzpk4u3DR=7BkVA1XZwA@mail.gmail.com>
Subject: Re: [RFC] pciehp: Add archdata setting
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2012 at 12:32 AM, Hiroo Matsumoto
<matsumoto.hiroo@jp.fujitsu.com> wrote:
> Hi, Bjorn
>
>
> I wrote a code with bus_register_notifier().
> A function that calls bus_register_notifer() is called from rootfs_initcall
> as well as amd_iommu is.
>
> Please review this.
>
>
> Regards.
>
> Hiroo MATSUMOTO
>
>
>> Hi, Bjorn
>>
>>
>> Thanks for your research and comment.
>>
>> As you said, a way of registering code with bus_register_notifier(), which
>> will be called in device_add(), is better one than pcibios_enable_device().
>> I will try to write code with bus_register_notifier().
>>
>>
>> Regards.
>>
>> Hiroo MATSUMOTO
>>
>>> On Wed, Apr 11, 2012 at 11:00 PM, Hiroo Matsumoto
>>> <matsumoto.hiroo@jp.fujitsu.com> wrote:
>>>>
>>>> Hi, Kaneshige
>>>>
>>>>
>>>> You are right!
>>>> Setting dma_ops in pcibios_enable_device is a nice way.
>>>> In PCI driver, pci_enable_device_xxx that calls pcibios_enable_device is
>>>> called before checking archdata.dma_ops.
>>>>
>>>> I added code of checking and setting dma_ops to pcibios_enable_device in
>>>> arch/powerpc/kernel/pci-common.c.
>>>> It works good.
>>>
>>>
>>> When I researched this, I thought the best route was to use the
>>> bus_register_notifier() path, as amd_iommu_init_notifier() does.
>>>
>>> We're filling in a struct device field, not a PCI field, and
>>> bus_register_notifier() seems like a more generic path than relying on
>>> pcibios_enable_device().
>>>
>>> Bjorn
>>>
>>>
>>
>
> Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
> diff --git a/arch/powerpc/kernel/pci-common.c
> b/arch/powerpc/kernel/pci-common.c
> index 32656f1..1fe1e25 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1083,6 +1083,17 @@ void __devinit pcibios_setup_bus_self(struct pci_bus
> *bus)
>                ppc_md.pci_dma_bus_setup(bus);
>  }
>
> +static inline void pcibios_set_dma_ops(struct pci_dev *dev)
> +{
> +       /* Hook up default DMA ops */
> +       set_dma_ops(&dev->dev, pci_dma_ops);
> +       set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
> +
> +       /* Additional platform DMA/iommu setup */
> +       if (ppc_md.pci_dma_dev_setup)
> +               ppc_md.pci_dma_dev_setup(dev);
> +}
> +
>  void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
>  {
>        struct pci_dev *dev;
> @@ -1102,13 +1113,7 @@ void __devinit pcibios_setup_bus_devices(struct
> pci_bus *bus)
>                 */
>                set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
>
> -               /* Hook up default DMA ops */
> -               set_dma_ops(&dev->dev, pci_dma_ops);
> -               set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
> -
> -               /* Additional platform DMA/iommu setup */
> -               if (ppc_md.pci_dma_dev_setup)
> -                       ppc_md.pci_dma_dev_setup(dev);
> +               pcibios_set_dma_ops(dev);
>
>                /* Read default IRQs and fixup if necessary */
>                pci_read_irq_line(dev);
> @@ -1749,3 +1754,33 @@ static void fixup_hide_host_resource_fsl(struct
> pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID,
> fixup_hide_host_resource_fsl);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
> fixup_hide_host_resource_fsl);
> +
> +static int pcibios_device_change_notifier(struct notifier_block *nb,
> +                                         unsigned long action, void *data)
> +{
> +       struct pci_dev *dev = to_pci_dev(data);
> +
> +       if (!dev)
> +               return 0;

I don't think you need this check.

> +
> +       switch (action) {
> +       case BUS_NOTIFY_ADD_DEVICE:
> +               if (!get_dma_ops(&dev->dev))
> +                       pcibios_set_dma_ops(dev);
> +               break;
> +       default:
> +               break;

The "default:" case is superfluous.

> +       }
> +
> +       return 0;
> +}
> +
> +static struct notifier_block device_nb = {
> +       .notifier_call = pcibios_device_change_notifier,
> +};
> +
> +static int pcibios_bus_notifier_init(void)
> +{
> +       return bus_register_notifier(&pci_bus_type, &device_nb);
> +}
> +rootfs_initcall(pcibios_bus_notifier_init);

Instead of making this a rootfs_initcall(), can you call
bus_register_notifier() explicitly in pcibios_init()?  That way
pcibios_device_change_notifier() should get called for *all* new PCI
devices, whether we find them at boot-time or they're hot-added later.

If you do that, I think you can move all the
pcibios_setup_bus_devices() code into the
pcibios_device_change_notifier() path, including the NUMA node and IRQ
fixups.

Your patch will also need a changelog.

Bjorn
