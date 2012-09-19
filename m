Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59173 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab2ISEyF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2012 00:54:05 -0400
Date: Wed, 19 Sep 2012 13:53:22 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Subject: Re: [PATCH v3 0/6] acpi,pci: hostbridge hotplug support
Message-Id: <20120919135322.85c608fa.izumi.taku@jp.fujitsu.com>
In-Reply-To: <CAE9FiQW3pyFFt714yuG-BzuK55eUjN4ojhNZ6LvwGqGWuAtMYQ@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<CAE9FiQVRGK-Of1RuvFZRtuT-yZ7LGDD_oNWr2ier2aaUqrugmA@mail.gmail.com>
	<CAE9FiQW3pyFFt714yuG-BzuK55eUjN4ojhNZ6LvwGqGWuAtMYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 18 Sep 2012 11:57:59 -0700
Yinghai Lu <yinghai@kernel.org> wrote:

> On Tue, Sep 18, 2012 at 11:41 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Mon, Sep 17, 2012 at 11:12 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> >> Hi all,
> >>
> >>   This patchset is 3rd version of the following:
> >>     http://marc.info/?l=linux-pci&m=134457928913775&w=2
> >>     http://marc.info/?l=linux-pci&m=134665909321684&w=2
> >>
> >>  v2 -> v3:
> >>    - change acpi_pci_drivers' add/remove interface according to Bjorn's suggestion
> >>    - abandon RCU for protecting acpi_pci_roots list according to Bjorn's suggestion
> >>    - change acpi_pci_find_root implementation to avoid potential deadlock
> >>
> >>   * [PATCH v3 1/8] ACPI, PCI: Use normal list for struct acpi_pci_driver
> >>   * [PATCH v3 2/8] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
> >>   * [PATCH v3 3/8] ACPI, PCI: add acpi_pci_drivers protection
> >>   * [PATCH v3 4/8] ACPI, PCI: change acpi_pci_drivers' add/remove interface
> >>   * [PATCH v3 5/8] ACPI, PCI: change acpi_pci_find_root implementation
> >>   * [PATCH v3 6/8] ACPI, PCI: add acpi_pci_roots protection
> >>   * [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
> >>   * [PATCH v3 8/8] ACPI, PCI: add resoruce-assign code for devices under hot-added hostbridge
> >
> > now it is more similar to my for-pci-root-bus-hotplug-part4 and part5
> >
> > http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-root-bus-hotplug-part5
> >
> > big difference:
> > I separated code from acpiphp_glue.c to pci_root_hp.c for root bridge
> > hotplug support
> >
> > I thought we all agreed on that acpi root bridge hotplug plug need to
> > be separated from acpiphp at first.
> >
> > http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=ab9fd4ccbfb6120a4a4adf9833487d656b0501d3
> >
> > and CONFIG_HOTPLUG will always be enabled, so root bridge hotplug will
> > be always enabled.
> > acpiphp will still be used as one module, and to keep it simple pciehp
> > will be used for pcie etc.
> > That make the system BIOS much simple to avoid acpiphp.
> 
> also current acpiphp only have root bridge add notification.
> and your code do not add any code for remove notification.
> 
> So how to you test your code with removal path?

 You were saying how to hot-remove hostbridge ?
 I tested by ejecting ACPI container which includes hostbridge.
 acpiphp is not the only way to hotplug hostbridge, so I ommit acpiphp
 work from this patchset. This patchset is core part.
  
Best regards,
Taku Izumi <izumi.taku@jp.fujitsu.com>

