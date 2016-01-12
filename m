Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24602 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbcALWQV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2016 17:16:21 -0500
Subject: Re: [PATCH 0/3] PCI VPD access fixes
To: Hannes Reinecke <hare@suse.de>, Bjorn Helgaas <helgaas@kernel.org>
References: <1452609750-90760-1-git-send-email-hare@suse.de>
 <569536AE.8070704@oracle.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <56957B1E.8080708@oracle.com>
Date: Tue, 12 Jan 2016 16:15:58 -0600
MIME-Version: 1.0
In-Reply-To: <569536AE.8070704@oracle.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 1/12/2016 11:23 AM, Babu Moger wrote:
> Hannes,
> These patches cause some other issues. I still have to figure
> out what is going on here. I have seen same problem before also with your
> older patches. That is the reason I thought setting the vpd length to 0
> is an easy solution.  Here are is what panic stack looks like. I am
> looking at it now. Let me know if you see anything obvious here.
> 
> megasas: 06.807.10.00-rc1
> megasas: Waiting for FW to come to ready state
> megasas: FW now in Ready state
> NON-RESUMABLE ERROR: Reporting on cpu 3
> NON-RESUMABLE ERROR: TPC [0x0000000000730990] <msix_capability_init+0x250/0x360>
> NON-RESUMABLE ERROR: RAW [0003100000000001:0006ccae1076de96:0000000202000080:ffffffffffffffff
> NON-RESUMABLE ERROR:      0000000800030000:0000000100000000:0000000000000000:0000000000000000]
> NON-RESUMABLE ERROR: handle [0x0003100000000001] stick [0x0006ccae1076de96]
> NON-RESUMABLE ERROR: type [precise nonresumable]
> NON-RESUMABLE ERROR: attrs [0x02000080] < ASI sp-faulted priv >
> NON-RESUMABLE ERROR: raddr [0xffffffffffffffff]
> NON-RESUMABLE ERROR: insn effective address [0x000008510079700c]
> NON-RESUMABLE ERROR: size [0x8]
> NON-RESUMABLE ERROR: asi [0x00]
> CPU: 3 PID: 325 Comm: modprobe Tainted: G            E   4.1.12-uek4-bm #5
> task: fff8000ff37bda00 ti: fff8000ff2940000 task.ti: fff8000ff2940000
> TSTATE: 0000000011001607 TPC: 0000000000730990 TNPC: 0000000000730994 Y: 00000000    Tainted: G            E
> TPC: <msix_capability_init+0x250/0x360>
> g0: 0000000000000000 g1: fff8000ff33109c0 g2: 0000000000000000 g3: 000008510079700c
> g4: fff8000ff37bda00 g5: fff8000ffe58a000 g6: fff8000ff2940000 g7: 0000085100797000
> o0: fff8000ffd60d000 o1: 000000000000ffff o2: 000000000000ffff o3: 000000000111e678
> o4: 000000000000001e o5: 0000000000000000 sp: fff8000ff2942711 ret_pc: 0000000000730940
> RPC: <msix_capability_init+0x200/0x360>
> l0: fff8000ffd60d888 l1: fff8000ff28123ec l2: fff8000ffd60d888 l3: 00000000000080d0
> l4: 00000000010eace0 l5: 0000000000000001 l6: 0080000000000000 l7: 8000000000000000
> i0: fff8000ffd60d000 i1: fff8000ff28123e4 i2: 0000000000000001 i3: 0000000000000000
> i4: 0000000000000000 i5: 0000085100797000 i6: fff8000ff29427d1 i7: 0000000000730c08
> I7: <pci_enable_msix+0x168/0x1c0>
> Call Trace:
>  [0000000000730c08] pci_enable_msix+0x168/0x1c0
>  [0000000000730c80] pci_enable_msix_range+0x20/0x60
>  [00000000100d7554] megasas_init_fw+0x374/0xb40 [megaraid_sas]
>  [00000000100d8c80] megasas_probe_one+0x4a0/0x9a0 [megaraid_sas]
>  [0000000000721e74] local_pci_probe+0x34/0xa0
>  [0000000000721f88] pci_call_probe+0xa8/0xe0
>  [0000000000722270] pci_device_probe+0x50/0x80
>  [000000000079b660] really_probe+0x140/0x420
>  [000000000079b984] driver_probe_device+0x44/0xa0
>  [000000000079ba68] __driver_attach+0x88/0xa0
>  [000000000079986c] bus_for_each_dev+0x6c/0xa0
>  [000000000079b1fc] driver_attach+0x1c/0x40
>  [000000000079a2bc] bus_add_driver+0x17c/0x220
>  [000000000079c234] driver_register+0x74/0x120
>  [000000000072235c] __pci_register_driver+0x3c/0x60
>  [00000000100f00ac] megasas_init+0xac/0x1dc [megaraid_sas]
> Kernel panic - not syncing: Non-resumable error.
> CPU: 3 PID: 325 Comm: modprobe Tainted: G            E   4.1.12-uek4-bm #5
> Call Trace:
>  [00000000009c8314] panic+0xb4/0x248
>  [0000000000429638] sun4v_nonresum_error+0xb8/0xe0
>  [000000000040744c] sun4v_nonres_mondo+0xc8/0xd8
>  [0000000000730990] msix_capability_init+0x250/0x360
>  [0000000000730c08] pci_enable_msix+0x168/0x1c0
>  [0000000000730c80] pci_enable_msix_range+0x20/0x60
>  [00000000100d7554] megasas_init_fw+0x374/0xb40 [megaraid_sas]
>  [00000000100d8c80] megasas_probe_one+0x4a0/0x9a0 [megaraid_sas]
>  [0000000000721e74] local_pci_probe+0x34/0xa0
>  [0000000000721f88] pci_call_probe+0xa8/0xe0
>  [0000000000722270] pci_device_probe+0x50/0x80
>  [000000000079b660] really_probe+0x140/0x420
>  [000000000079b984] driver_probe_device+0x44/0xa0
>  [000000000079ba68] __driver_attach+0x88/0xa0
>  [000000000079986c] bus_for_each_dev+0x6c/0xa0
>  [000000000079b1fc] driver_attach+0x1c/0x40
> Press Stop-A (L1-A) to return to the boot prom
> ---[ end Kernel panic - not syncing: Non-resumable error.
> 
> 
> 
> On 1/12/2016 8:42 AM, Hannes Reinecke wrote:
>> Hi all,
>>
>> the current PCI VPD page access assumes that the entire possible VPD
>> data is readable. However, the spec only guarantees a VPD data up to
>> the 'end' marker, with everything beyond that being undefined.
>> This causes a system lockup on certain devices.
>>
>> With this patch we calculate the actual VPD size, or set it to '0'
>> if no valid VPD data could be read.
>>
>> Hannes Reinecke (3):
>>   pci: Update VPD definitions
>>   pci: Update VPD size with correct length
>>   pci: set VPD size to '0' if PCI_VPD_FLAGS_VPD_REF_F0 is set
>>
>>  drivers/pci/access.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/pci/pci-sysfs.c | 20 +++++++++------
>>  include/linux/pci.h     | 27 ++++++++++++++++++--
>>  3 files changed, 104 insertions(+), 11 deletions(-)
>>

Hannes, I think the logic to to get the PCI vpd length seems fine. I see that 
the function pci_vpd_pci22_size returns zero seeing the invalid tag. That looks
good. However, this card(LSI Logic / Symbios Logic MegaRAID SAS 2108 controllers)
locks-up when we attempt to read pci vpd area. So when the driver tries to 
initialize the card it times out and panics eventually.

I tried to set up a new flag(PCI_DEV_FLAGS_VPD_ZERO) for this device using
 DECLARE_PCI_FIXUP_CLASS_EARLY.

Changes in pci_vpd_pci22_init

 if ((dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) ||
                (dev->dev_flags & PCI_DEV_FLAGS_VPD_ZERO))
                vpd->base.len = 0;
        else
                vpd->base.len = pci_vpd_pci22_size(dev);
        return 0;

Changes in driver/quirk.c 
static void quirk_set_vpd_sero(struct pci_dev *dev)
{
        dump_stack();
        dev->dev_flags |= PCI_DEV_FLAGS_VPD_ZERO;
}

DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
                PCI_CLASS_STORAGE_RAID, 8, quirk_set_vpd_sero);

Even this did not help. I don't know sequence of these flags setting. 
When we are inside the function pci_vpd_pci22_init none of these flags
are set up.  I need to look at these early quirks again. 

In summary we may have to blindly set the length to zero for this device.

Let me know your thoughts.
