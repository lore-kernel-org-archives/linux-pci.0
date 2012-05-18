Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40206 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758748Ab2ERQ4o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2012 12:56:44 -0400
Received: by dady13 with SMTP id y13so4068907dad.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 09:56:43 -0700 (PDT)
Message-ID: <4FB67F40.9030804@gmail.com>
Date: Sat, 19 May 2012 00:56:32 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 6/6] PCI, ACPI, x86: update MMCFG information when
 hot-plugging PCI host bridges
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com> <1336186830-10765-7-git-send-email-jiang.liu@huawei.com> <CAErSpo5iiEqqhcMKj8gqfXZmqD2QaY4LBe7w9J2K-fgXbzO9Pg@mail.gmail.com>
In-Reply-To: <CAErSpo5iiEqqhcMKj8gqfXZmqD2QaY4LBe7w9J2K-fgXbzO9Pg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/19/2012 12:03 AM, Bjorn Helgaas wrote:
> On Fri, May 4, 2012 at 9:00 PM, Jiang Liu <liuj97@gmail.com> wrote:
>> From: Jiang Liu <jiang.liu@huawei.com>
>>
>> This patch enhances pci_root driver to update MMCFG information when
>> hot-plugging PCI root bridges on x86 platforms.
>>
>> Signed-off-by: Jiang Liu <liuj97@gmail.com>
>> ---
..........
>> @@ -504,6 +515,15 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>>        strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
>>        device->driver_data = root;
>>
>> +       status = acpi_evaluate_integer(root->device->handle, METHOD_NAME__CBA,
>> +                                      NULL, &base_addr);
>> +       if (ACPI_FAILURE(status))
>> +               base_addr = 0;
> 
> I think the MCFG lookup should happen here, since MCFG is a generic
> ACPI table and is not arch-specific.  Maybe something like
> "phys_addr_t acpi_mcfg_lookup(int domain, struct resource *bus_nr, int
> *last_bus_nr)" that would return the bus 0-relative base address (like
> what _CBA gives you) and the end of the bus number range from MCFG.
Yes, that's the most suitable place for it.
But I still have a question about blind probing. When blindly probing, we only
know the start bus and can't tell the end bus for hidden root buses. So it's 
hard to setup MMCFG information on demand for blind probe. And we only do blind
probe on segment 0 for backward compatibility. If we could take the trade-off
below, thing becomes doable.
1) For backward compatibility, add all MMCFG entries for segment 0 when
   parsing the MCFG table at boot time.
2) For root buses not on segment 0, add MMCFG info for them on demand when
   binding pci_root driver to them.
How about the trade-off above?

>> +       if (arch_acpi_pci_root_add(root, base_addr)) {
> 
> This should be something like "pci_add_mmconfig(int domain, struct
> resource *bus_nr, phys_addr_t  base)".  The bus_nr resource would be
> the range from _CRS or a copy truncated to the end we found in MCFG.
We need to set a flag on the "root" to mark whether we have succeeded to add
an MMCFG entry for this root bus. Later we will remove this MMCFG entry if it's
added by arch_acpi_pci_root_add(). So we pass in "root" instead of 
"domain, res" pair.

>> +               result = -ENODEV;
> 
> I don't think this is a fatal error.  If we don't have MMCONFIG space
> for this host bridge, we can just fall back to the default pci_ops and
> still use the host bridge.
arch_acpi_pci_root_add() in arch/x86/pci/acpi.c is designed to return error only if:
1) MMCFG is disabled and the root bus is on a segment other than segment 0.
2) We failed to add MMCFG entry for this root bus and it's on a segment other
   than segment 0.

Under above two cases, it's fatal because we have no way to access configuration
space under the new root bus.

Thanks!
Gerry
