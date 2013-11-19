Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64613 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab3KSRSy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 12:18:54 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so1149916iec.21
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 09:18:53 -0800 (PST)
Date: Tue, 19 Nov 2013 10:18:50 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [3.11.4] Thunderbolt/PCI unplug oops in pci_pme_list_scan
Message-ID: <20131119171850.GA4261@google.com>
References: <CAErSpo4KU9VAC=SnKuYH3EPz8NuozixAhUQBKv+=Y=76wywdTg@mail.gmail.com>
 <20131015024452.GA31951@srcf.ucam.org>
 <20131016202123.GA17866@google.com>
 <CAMxnaaV1DhaxKo6h85Upa8sPQz2jSYSaW1OJ7+JtvR5F9sAYZw@mail.gmail.com>
 <CAErSpo4q0rcvkHX3_L2rcJrwT-Ofu4My8JXxtxH8gyULLxTDEw@mail.gmail.com>
 <CAE9FiQUMKSak4tWiyZ-N1_50M5ytUp-JAhb7GTG29Y1aRBPuSQ@mail.gmail.com>
 <CAErSpo5yhg1EgJmmOtJeh0myd50tJuu6qVMdVnwR276WTxL8kg@mail.gmail.com>
 <20131115115235.GA2281@intel.com>
 <20131119013343.GA17294@google.com>
 <528AC4F2.40708@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <528AC4F2.40708@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 19, 2013 at 09:54:58AM +0800, Yijing Wang wrote:
> > The pcie_portdrv .probe() method calls pci_enable_device() once, in
> > pcie_port_device_register(), but the .remove() method calls
> > pci_disable_device() twice, in pcie_port_device_remove() and in
> > pcie_portdrv_remove().
> > 
> > That causes a "disabling already-disabled device" warning when removing a
> > PCIe port device.  This happens all the time when removing Thunderbolt
> > devices, but is also easy to reproduce with, e.g.,
> > "echo 0000:00:1c.3 > /sys/bus/pci/drivers/pcieport/unbind"
> > 
> > This patch removes the disable from pcie_portdrv_remove().
> > 
> > [bhelgaas: changelog, tag for stable]
> > Reported-by: David Bulkow <David.Bulkow@stratus.com>
> > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > CC: stable@vger.kernel.org	# v2.6.32+
> 
> Hi Bjorn,
>    This issue in X86 seems to be introduced after commit 928bea9 "PCI: Delay enabling bridges until they're needed"
> So this patch needs to back port to 2.6.32+ ?

928bea9 might have made it more visible, but the underlying problem is that
we enable the device once in the probe path, and disable it twice in the
remove path.  That problem exists in 2.6.32.61:

  pcie_portdrv_probe                # .probe() method
    pcie_port_device_register
      pci_enable_device             <-- enable

  pcie_portdrv_remove               # .remove() method
    pcie_port_device_remove
      pci_disable_device            <-- disable #1
    pci_disable_device              <-- disable #2

Bjorn
