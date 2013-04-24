Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:54700 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975Ab3DXRIB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 13:08:01 -0400
MIME-Version: 1.0
In-Reply-To: <5AA430FFE4486C448003201AC83BC85E01F83F13@EXHQ.corp.stratus.com>
References: <CAE9FiQVe95hT2mv4G+v_FMk5_qQDSg0e0fPdZdoe8Cgam70EnA@mail.gmail.com>
	<5AA430FFE4486C448003201AC83BC85E03DEA379@EXHQ.corp.stratus.com>
	<5AA430FFE4486C448003201AC83BC85E01F83F13@EXHQ.corp.stratus.com>
Date: Wed, 24 Apr 2013 10:08:00 -0700
Message-ID: <CAE9FiQUdGZYonHqoh=2D3N=hJVKgyWB9XpgZ0+71-8JyfHZD8g@mail.gmail.com>
Subject: Re: USB PCI quirk issue
From: Yinghai Lu <yinghai@kernel.org>
To: "Bulkow, David" <David.Bulkow@stratus.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	"Lawrence, Joe" <Joe.Lawrence@stratus.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Adding Kenji]

On Wed, Apr 24, 2013 at 6:25 AM, Bulkow, David <David.Bulkow@stratus.com> wrote:
> By relocating the call to the quirk code, the resource problem is gone.
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
> static void pcie_portdrv_remove(struct pci_dev *dev)
> {
>         pcie_port_device_remove(dev);
>         pci_disable_device(dev);
> }
>
> and
>
> void pcie_port_device_remove(struct pci_dev *dev)
> {
>         device_for_each_child(&dev->dev, NULL, remove_iter);
>         cleanup_service_irqs(dev);
>         pci_disable_device(dev);
> }
>
> There are no ill effects from this so far but the warnings are
> not likely to be received well by customers.

Thanks for digging that out.

that extra pci_disable_device in pcie_port_device_remove() was added by
---
commit dc5351784eb36f1fec4efa88e01581be72c0b711
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Wed Nov 25 21:04:00 2009 +0900

    PCI: portdrv: cleanup service irqs initialization

    This patch cleans up the service irqs initialization as follows:

     - Remove 'irq_mode' field in pcie_port_data and related definitions,
       which is not needed because we can get the same information from
       'is_msix', 'is_msi' and 'pin' fields in struct pci_dev.

     - Change the name of 'vectors' argument of assign_interrupt_mode() to
       'irqs' because it holds irq numbers actually. People might confuse
       it with CPU vector or MSI/MSI-X vector.

     - Change function name assign_interrupt_mode() to init_service_irqs()
       becasuse we no longer have 'irq_mode' data structure, and new name
       is more straightforward (IMO).
---

We should remove extra one in pcie_portdrv_remove.

Can you please prepare patch that delete that line in pcie_portdrv_remove() ?

Thanks

Yinghai
