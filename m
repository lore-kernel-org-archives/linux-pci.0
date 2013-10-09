Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:51310 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab3JIOua convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2013 10:50:30 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so1968856iec.21
        for <linux-pci@vger.kernel.org>; Wed, 09 Oct 2013 07:50:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <43e5eb8dd8c04af197a01dc974f52924@BLUPR05MB118.namprd05.prod.outlook.com>
References: <43e5eb8dd8c04af197a01dc974f52924@BLUPR05MB118.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Oct 2013 08:50:06 -0600
Message-ID: <CAErSpo5W9=oFo5kEzWQPCj_OePuCtYU8w7RhVRfz9jH-O=XupQ@mail.gmail.com>
Subject: Re: Difference between hot-plug on PCIe rootport vs downstream port
To: Rajat Jain <rajatjain@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 9, 2013 at 7:36 AM, Rajat Jain <rajatjain@juniper.net> wrote:
> Hello,
>
> 1) Does the pciehp support hotplug on both rootport and downstream port?

Yes.  To be precise, pciehp supports hotplug of PCIe devices below
Root Ports and Downstream Ports.

> 2) What is so different about these that downstream port hotplug was part of the kernel since very long, but root port hotplug was included releatively recently? Are there any added complexities? I couldn't find anything on the net on this. From my understanding it should be exactly similar?

Hotplugging of PCIe devices below Root Ports and Downstream Ports
should be identical.

My guess is that you're confused by the recent addition of PCI *host
bridge* hotplug.  This is for hotplugging an entire Root Complex or
other host bridge.  A host bridge is not a PCI or PCIe device (though
a Root Complex *contains* Root Ports).  It has some platform-specific
interface on the upstream side and a PCI or PCIe interface on the
downstream side.  There is no architected way to discover host bridge
existence, apertures, address translation, etc.  This is all done via
ACPI or other platform-specific methods, not via PCI mechanisms.
Therefore, hotplug of a host bridge is much different than hotplug of
a PCI device.

> 3) I understand the hotplug on downstream port is architecture independent. But is the root port hotplug architecture dependent (assuming that the CPU complies to the PCIe, spec, it shouldn't be, right)?

The PCIe spec doesn't really apply to CPUs.  The above should clarify the rest.

> 4) Can you point me to the code where the root port hotplug is implemented?

Host bridge hotplug is implemented in drivers/acpi/pci_root.c.
Obviously this only applies to arches that use ACPI (currently x86 and
ia64).

Bjorn
