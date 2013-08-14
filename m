Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51259 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760268Ab3HNUgL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 16:36:11 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so9821284pbc.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2013 13:36:10 -0700 (PDT)
Date: Wed, 14 Aug 2013 14:36:06 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH v2 2/3] PCI: Separate stop and remove devices in pciehp
Message-ID: <20130814203606.GA9044@google.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
 <20130807040112.GA14662@google.com>
 <CAE9FiQVXhg299RKsoa8eCqoN7b9c0HaeTGHCnxQY=9vkSYaJJg@mail.gmail.com>
 <CAE9FiQWftukxyNiyM2znVPh7x82de3nhRMQwGHigZtOvU6xQ6g@mail.gmail.com>
 <20130809170404.GA29690@google.com>
 <CAE9FiQXuNPfhndRAm7uX4phvVqqVsQuuEzEqEi8at9f2oWPYOg@mail.gmail.com>
 <CAErSpo5uYciz4dZtf6utfehXGnooRAT3BcVHyz+EoZ4m7tbitg@mail.gmail.com>
 <CAE9FiQULOCz3snO26EHy_dumRULyOT34_iEjM_rZeP=pH8KGvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQULOCz3snO26EHy_dumRULyOT34_iEjM_rZeP=pH8KGvw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 14, 2013 at 01:15:35PM -0700, Yinghai Lu wrote:
> On Wed, Aug 14, 2013 at 12:44 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > [+cc Don]
> >
> > On Fri, Aug 9, 2013 at 5:44 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> >> On Fri, Aug 9, 2013 at 10:04 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >
> >>> What would happen if we just reverted dc087f2f6a2 for now?  Jiang?
> >
> > I tried to reproduce the problem you reported ("Cannot add device at
> > 0000:02:00"), but I haven't been able to.  I have an ixgbe SR-IOV
> > device in an external hotplug-capable chassis, and I'm using v3.11-rc4
> > with a patch to add a little instrumentation.  Here's what I see:
> >
> >     # echo -n 8 > /sys/bus/pci/devices/0000:08:00.0/sriov_numvfs
> >     ixgbe 0000:08:00.0 eth1: SR-IOV enabled with 8 VFs
> >     pci 0000:08:10.0: [8086:1515] type 00 class 0x020000        # VF1
> >     pci 0000:08:10.2: [8086:1515] type 00 class 0x020000        # VF2
> >     ...
> >     pci 0000:08:11.6: [8086:1515] type 00 class 0x020000        # VF8
> >
> > Created 8 VFs; no problem there.
> >
> >     # echo -n 0 > /sys/bus/pci/slots/4-1/power
> >     pciehp 0000:04:03.0:pcie24: disable_slot: physical_slot = 4-1
> >     pciehp 0000:04:03.0:pcie24: pciehp_unconfigure_device:
> > domain:bus:dev = 0000:08:00
> >     ixgbevf 0000:08:11.6: pci_stop_and_remove_bus_device
> >     pci 0000:08:11.6: pci_release_dev                   # release VF8
> >     ixgbevf 0000:08:11.4: pci_stop_and_remove_bus_device
> >     pci 0000:08:11.4: pci_release_dev                   # release VF7
> >     ...
> >     ixgbevf 0000:08:10.0: pci_stop_and_remove_bus_device
> >     pci 0000:08:10.0: pci_release_dev                   # release VF1
> >     ixgbe 0000:08:00.1: pci_stop_and_remove_bus_device
> >     pci 0000:08:00.1: pci_release_dev                   # release PF1
> >     ixgbe 0000:08:00.0: pci_stop_and_remove_bus_device  # stop/remove PF0
> >                                                         # PF0 not released
> >
> > When I turn off power to the slot, pciehp stops and removes all the
> > devices, starting with the VFs.  The PF 08:00.0 is stopped but not
> > released, because we didn't call virtfn_remove(), so the reference
> > held by the VFs was never released.  This is a problem.
> >
> >    # echo -n 1 > /sys/bus/pci/slots/4-1/power
> >     pci 0000:08:00.0: [8086:1528] type 00 class 0x020000
> >     pci 0000:08:00.1: [8086:1528] type 00 class 0x020000
> >
> > When I turn the slot back on, we find both PFs; no apparent problem there.
> >
> > On v3.10 (which does not contain dc087f2f6a), I see essentially the
> > same thing.  The PFs are stopped before the VFs because v3.10 doesn't
> > contain 29ed1f29b68, which removes devices in reverse order.  But even
> > in v3.10, PF0 is stopped but not released because the VFs still hold
> > references to it.  And there's no complaint when turning the slot back
> > on.
> >
> > So we definitely have a problem: when we remove the PF, we don't
> > release it correctly because we don't release the references held by
> > VFs.  But this is not a regression, and doesn't seem urgent enough to
> > rush something for v3.11.
> >
> > I think we're headed toward tearing down all VFs when removing a PF.
> > Obviously, we *have* to do that when powering off the device, and I
> > think we also need to do it when removing the PF driver just to keep
> > all the bookkeeping sane.  I don't know how much heartburn this will
> > cause Don.
> >
> > So tell me if you still think we need to do something for v3.11.
> 
> in your test: the PF is not get freed but it is removed for bus's device list.
> so pciehp_configure_device will create new one even the old is not
> really released.

Yes.  As I said above, I do see the leak of the PF pci_dev, and
we certainly do need to fix that, but it's not a regression and
doesn't seem urgent.

> Please check with attached patch, that only release that from link-list in
> pci_release device. I posted it a while back.
> After it get applied, you will not have chance to create new device in
> pciehp_configure_device.

[I inlined your patch for convenience]

I agree that the patch below looks like a good thing to do.
However, it is not in v3.11.  So if the problem only happens when
the patch below is applied, we don't need to fix the problem in
v3.11.

I've spent a LOT of time trying to reproduce this problem and
convince myself that we need to do something in v3.11.  If you're
telling me that my time was wasted because the problem does not
happen in v3.11-rc, but only happens with your out-of-tree patch,
I'm going to be very upset.

Bjorn

> Subject: [PATCH 2/7] PCI: move resources and bus_list releasing to pci_release_dev
> From: Yinghai Lu <yinghai@kernel.org>
> 
> We should not release resource in pci_destroy that is too early
> as there could be still other use hold reference.
> 
> release them or remove it from bus devices list at last
> in pci_release_dev instead.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/probe.c  |   22 ++++++++++++++++++++--
>  drivers/pci/remove.c |   19 -------------------
>  2 files changed, 20 insertions(+), 21 deletions(-)
> 
> Index: linux-2.6/drivers/pci/probe.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/probe.c
> +++ linux-2.6/drivers/pci/probe.c
> @@ -1150,6 +1150,20 @@ static void pci_release_capabilities(str
>  	pci_free_cap_save_buffers(dev);
>  }
>  
> +static void pci_free_resources(struct pci_dev *dev)
> +{
> +	int i;
> +
> +	msi_remove_pci_irq_vectors(dev);
> +
> +	pci_cleanup_rom(dev);
> +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		struct resource *res = dev->resource + i;
> +		if (res->parent)
> +			release_resource(res);
> +	}
> +}
> +
>  /**
>   * pci_release_dev - free a pci device structure when all users of it are finished.
>   * @dev: device that's been disconnected
> @@ -1159,9 +1173,13 @@ static void pci_release_capabilities(str
>   */
>  static void pci_release_dev(struct device *dev)
>  {
> -	struct pci_dev *pci_dev;
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +
> +	down_write(&pci_bus_sem);
> +	list_del(&pci_dev->bus_list);
> +	up_write(&pci_bus_sem);
> +	pci_free_resources(pci_dev);
>  
> -	pci_dev = to_pci_dev(dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> Index: linux-2.6/drivers/pci/remove.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/remove.c
> +++ linux-2.6/drivers/pci/remove.c
> @@ -3,20 +3,6 @@
>  #include <linux/pci-aspm.h>
>  #include "pci.h"
>  
> -static void pci_free_resources(struct pci_dev *dev)
> -{
> -	int i;
> -
> - 	msi_remove_pci_irq_vectors(dev);
> -
> -	pci_cleanup_rom(dev);
> -	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> -		struct resource *res = dev->resource + i;
> -		if (res->parent)
> -			release_resource(res);
> -	}
> -}
> -
>  static void pci_stop_dev(struct pci_dev *dev)
>  {
>  	pci_pme_active(dev, false);
> @@ -36,11 +22,6 @@ static void pci_stop_dev(struct pci_dev
>  
>  static void pci_destroy_dev(struct pci_dev *dev)
>  {
> -	down_write(&pci_bus_sem);
> -	list_del(&dev->bus_list);
> -	up_write(&pci_bus_sem);
> -
> -	pci_free_resources(dev);
>  	put_device(&dev->dev);
>  }
>  
