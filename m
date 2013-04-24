Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailhub5.stratus.com ([134.111.1.18]:33589 "EHLO
	mailhub5.stratus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab3DXSch convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 14:32:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: USB PCI quirk issue
Date: Wed, 24 Apr 2013 14:32:15 -0400
Message-ID: <5AA430FFE4486C448003201AC83BC85E03DEA483@EXHQ.corp.stratus.com>
In-Reply-To: <CAE9FiQUdGZYonHqoh=2D3N=hJVKgyWB9XpgZ0+71-8JyfHZD8g@mail.gmail.com>
References: <5AA430FFE4486C448003201AC83BC85E01F83F13@EXHQ.corp.stratus.com> <CAE9FiQUdGZYonHqoh=2D3N=hJVKgyWB9XpgZ0+71-8JyfHZD8g@mail.gmail.com>
From: "Bulkow, David" <David.Bulkow@stratus.com>
To: "Yinghai Lu" <yinghai@kernel.org>
Cc: "Sarah Sharp" <sarah.a.sharp@linux.intel.com>,
	"Lawrence, Joe" <Joe.Lawrence@stratus.com>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Kenji Kaneshige" <kaneshige.kenji@jp.fujitsu.com>,
	"Bulkow, David" <David.Bulkow@stratus.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I removed the extra call to pci_disable_device in pcie_portdrv_remove.

The 'disabling already-disabled device' messages are gone and the
enable_cnt for bridges
survives bringdown/bringup cycles without going negative.  The only
anomaly I see right now
is that for a few of the bridges the enable_cnt is 2 after boot - before
hot adds or
removes - but this resolves itself after the first hot remove, probably
because
the dev is destroyed.

-----Original Message-----
From: yhlu.kernel@gmail.com [mailto:yhlu.kernel@gmail.com] On Behalf Of
Yinghai Lu
Sent: Wednesday, April 24, 2013 1:08 PM
To: Bulkow, David
Cc: Sarah Sharp; Lawrence, Joe; linux-pci@vger.kernel.org;
linux-usb@vger.kernel.org; Bjorn Helgaas; Rafael J. Wysocki; Kenji
Kaneshige
Subject: Re: USB PCI quirk issue

[Adding Kenji]

On Wed, Apr 24, 2013 at 6:25 AM, Bulkow, David
<David.Bulkow@stratus.com> wrote:
> By relocating the call to the quirk code, the resource problem is
gone.
> Can we move forward on this change?

ok, will prepare one complete patch for that.

>
> The enable_cnt issue is now only associated with bridges managed by 
> pcieport.
> For each bridge pci_disable_device() is getting called twice during 
> hot-remove.
> This is happening because both pcie_portdrv_remove() and
> pcie_port_device_remove()
> call pci_disable_device().
>
> static void pcie_portdrv_remove(struct pci_dev *dev) {
>         pcie_port_device_remove(dev);
>         pci_disable_device(dev);
> }
>
> and
>
> void pcie_port_device_remove(struct pci_dev *dev) {
>         device_for_each_child(&dev->dev, NULL, remove_iter);
>         cleanup_service_irqs(dev);
>         pci_disable_device(dev);
> }
>
> There are no ill effects from this so far but the warnings are not 
> likely to be received well by customers.

Thanks for digging that out.

that extra pci_disable_device in pcie_port_device_remove() was added by
---
commit dc5351784eb36f1fec4efa88e01581be72c0b711
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Wed Nov 25 21:04:00 2009 +0900

    PCI: portdrv: cleanup service irqs initialization

    This patch cleans up the service irqs initialization as follows:

     - Remove 'irq_mode' field in pcie_port_data and related
definitions,
       which is not needed because we can get the same information from
       'is_msix', 'is_msi' and 'pin' fields in struct pci_dev.

     - Change the name of 'vectors' argument of assign_interrupt_mode()
to
       'irqs' because it holds irq numbers actually. People might
confuse
       it with CPU vector or MSI/MSI-X vector.

     - Change function name assign_interrupt_mode() to
init_service_irqs()
       becasuse we no longer have 'irq_mode' data structure, and new
name
       is more straightforward (IMO).
---

We should remove extra one in pcie_portdrv_remove.

Can you please prepare patch that delete that line in
pcie_portdrv_remove() ?

Thanks

Yinghai
