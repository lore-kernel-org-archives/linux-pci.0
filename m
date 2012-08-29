Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:41328 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2H2Wos (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Aug 2012 18:44:48 -0400
Received: by qaas11 with SMTP id s11so848324qaa.19
        for <linux-pci@vger.kernel.org>; Wed, 29 Aug 2012 15:44:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <503E39DE.7000109@gmail.com>
References: <CAErSpo73r3yzzndUek-NJ3d0pDKtg8zTrnjk4ihudBE5gngBAA@mail.gmail.com>
	<503E39DE.7000109@gmail.com>
Date: Wed, 29 Aug 2012 15:44:47 -0700
Message-ID: <CAPoiz9yRzEr68=NB53SVXb5+nRmEa_J4Mtt6eGAAo5EWFbDbmQ@mail.gmail.com>
Subject: Re: PCI mini-summit notes
From: Jon Mason <jdmason@kudzu.us>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	ksummit-2012-discuss
	<ksummit-2012-discuss@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 29, 2012 at 8:48 AM, Jiang Liu <liuj97@gmail.com> wrote:
> On 08/29/2012 03:28 PM, Bjorn Helgaas wrote:
>> We held a PCI mini-summit on Aug 28 in San Diego in conjunction with
>> Kernel Summit and the Linux Plumbers Conference.  I want to thank
>> everybody who participated.  We had a good discussion and I really
>> appreciate all the input and ideas everybody provided.
>>
>> My summary of the major discussions we had is below.
>>
>> Bjorn
>>
>>
>>
>> Host bridge hotplug
>>
>>     There's a lot of interest in this functionality, mostly on x86 using
>>     ACPI-mediated hotplug.
>>
>>     The acpiphp driver handles both host bridge and PCI device hotplug.  We
>>     believe these should be separated.
>>
>>     Host bridge hotplug requires IOAPIC and DMAR hotplug with proper sequencing
>>     (started before PCI enumeration and removed after PCI drivers are removed).
>>     On x86, we think this should happen naturally if we add this support to the
>>     ACPI pci_root.c driver.  We do need some tweaks to x86 IOAPIC init and
>>     IOMMU drivers.
>>
>>     We'd like a sysfs interface to this, and it's not clear what form
>>     it should take.  One way is to add hooks in the PCI side, e.g.,
>>     /sys/devices/.../pci_bus/remove.  This has the advantage of looking the
>>     same across all architectures, but it doesn't map well to firmware
>>     interfaces and it's not obvious how to deal with hot-adds, when the pci_bus
>>     doesn't exist yet.  Another way would be to have them connected to the host
>>     bridge and its enclosing scope, e.g., /sys/devices/.../PNP0A08:00/remove
>>     and /sys/devices/.../LNXSYBUS:00/rescan.  This is architecture-specific but
>>     has the advantage of matching the logical system topology.
>>
>> Hot Plug Issues
>>
>>     We know we have locking issues and races in the PCI device hotplug area.
>>     We have some pending patches to address these.  They may be merged for 3.7
>>     or 3.8.
>>
>>     We still have some device setup being done by initcalls, and obviously this
>>     doesn't work for hot-added devices.  We've fixed some of these areas, but
>>     there are a few more to do.
>>
>>     What about CONFIG_HOTPLUG?  We didn't discuss this in the mini-summit,
>>     but it was raised on the ksummit-discuss list.
>>
>> SR-IOV Management
>>
>>     Currently drivers implement module parameters like "max_vfs".  This means
>>     all devices claimed by the driver get the same number of VFs, and you can't
>>     change anything without unloading and reloading the driver.
>>
>>     Consensus that we should try to implement a knob for this in sysfs so it
>>     can be generic (not in each driver) and set individually for each device.
> Hi Bjorn,
>         One of my team member reported another corner case for SR-IOV. There's
> are two NIC cards in the system driven by the same driver, but one supports
> SR-IOV and the other doesn't. It runs into trouble if "max_vfs" parameter is
> set for the NIC driver.
>         --Gerry

I believe it was decided that a per-pf sysfs interface would be used
to replace the current module parameter that specifies the number of
vf's.  This should enable different numbers of vf's for each physical
device.  The driver interface that was discussed would introduce new
function pointers for handlers to setup/teardown the vf's.  I believe
this will solve your problem once it has been implemented.

Thanks,
Jon

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
