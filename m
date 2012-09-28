Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44351 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572Ab2I1QTg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 12:19:36 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo74kQkxS2L5cmpn6++QoVODAf6LdUd-h=TzwQ==rTig5A@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com>
	<CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
	<CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
	<CAE9FiQUUjPza9Hq8jJR0nLN__26zQooQAr=paB6dRjQtTM=ngw@mail.gmail.com>
	<CAErSpo7Vf1Pz3bFfMAfWXoh0gF844X2JT7RQ9-ecr3uWj=z9_w@mail.gmail.com>
	<CAE9FiQUrovv143dTo_k2m0DYXqwGc4BtbjmzGxo2Fk21Fp2EJw@mail.gmail.com>
	<CAErSpo74kQkxS2L5cmpn6++QoVODAf6LdUd-h=TzwQ==rTig5A@mail.gmail.com>
Date: Fri, 28 Sep 2012 09:19:34 -0700
Message-ID: <CAE9FiQUbk+Z0OVYMuouEfXTZuwG0ZyPOi=PNwFdmuij_J07-QA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 28, 2012 at 9:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Sep 27, 2012 at 2:17 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Today we have this, which is more complicated than it should be.  Note
> how we do some ACPI stuff, some PCI stuff, some more ACPI stuff, then
> more PCI stuff:
>
>     acpi_pci_root_add
>         pci_acpi_scan_root
>             pci_scan_child_bus
>         acpi_pci_irq_add_prt
>         acpi_pci_osc_control_set
>     acpi_pci_root_start
>         pci_bus_add_devices
>
> I don't think the ACPI/PCI mixture is anything essential dictated by
> the way the hardware or firmware works.  I think it's just an artifact
> of the current design, and it could be changed.  It would be better to
> have this:
>
>     acpi_pci_root_add
>         acpi_pci_irq_add_prt
>         acpi_pci_osc_control_set
>         pci_acpi_scan_root
>             pci_scan_root_bus
>                 pci_scan_child_bus
>                 pci_bus_add_devices
>
> We can't get to this latter strategy as long as the ACPI interfaces
> depend on the struct pci_bus.  So the _PRT change is a small thing in
> itself, but I do think it helps enable significant improvements in the
> future.

still to handle to those fallback path like create_bus and scan bus failure.

in my for-pci-next branch, with Jiang's patches and mine, now we achieved at

    acpi_pci_root_add
        pci_acpi_scan_root
            pci_scan_root_bus
                pci_scan_child_bus
        acpi_pci_osc_control_set
        pci_bus_add_devices

acpi_pci_irq_add_prt is called later during acpi binding that is
triggered by adding to device tree.
thought os_control set via pci_host_bridge add interface..

with those BUS ADD notification, we can pass bus safely, and without
considering about cleanup PRT and OSC setting.
