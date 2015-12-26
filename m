Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41215 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbbLZD1W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Dec 2015 22:27:22 -0500
Subject: Re: [PATCH v4] pci: Limit VPD length for megaraid_sas adapter
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1447957102-184860-1-git-send-email-babu.moger@oracle.com>
 <1449174319-52798-1-git-send-email-babu.moger@oracle.com>
 <20151207172941.GJ7994@localhost> <56661135.5050200@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <567E090A.6060902@oracle.com>
Date: Fri, 25 Dec 2015 21:27:06 -0600
MIME-Version: 1.0
In-Reply-To: <56661135.5050200@oracle.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Checking again. 
How about adding some messages in the logs to let user know that vpd has been disabled on this device in case if there is an attempt to access vpd.
What do you think?. Thanks
Babu

On 12/7/2015 5:07 PM, Babu Moger wrote:
> Hi Bjorn,
>   My old logs were lost. So, I had to recreate the issue again. So it took sometime.
> 
> On 12/7/2015 11:29 AM, Bjorn Helgaas wrote:
>> Hi Babu,
>>
>> On Thu, Dec 03, 2015 at 12:25:19PM -0800, Babu Moger wrote:
>>> Reading or Writing of PCI VPD data causes system panic.
>>> We saw this problem by running "lspci -vvv" in the beginning.
>>> However this can be easily reproduced by running
>>>  cat /sys/bus/devices/XX../vpd
>>
>> What sort of panic is this?
>  
>   Actual panic stack showed total different area.  It looked like this.
> 
>   TSTATE: 0000000080e01601 TPC: 00000000007945c8 TNPC: 00000000007945cc Y: 00000000    Not tainted
> TPC: <ehci_irq+0x94/0x388>
> g0: 0000000000004000 g1: 0000084001604020 g2: 0000084001604024 g3: 0000000000000acb
> g4: ffff800fe42d0340 g5: ffff8000291ce000 g6: ffff800fe42f4000 g7: 0000031100004000
> o0: ffff800fe085d99c o1: ffff800fe42f4008 o2: 0000000000004000 o3: 0000000000000001
> o4: 0000000000000000 o5: 0000000000000012 sp: ffff80002047b2b1 ret_pc: 0000000000794540
> RPC: <ehci_irq+0xc/0x388>
> l0: ffff800fe085d980 l1: 000000000000c001 l2: 000000000000000b l3: 00000000008e7058
> l4: 0000000000bd19a8 l5: 0000000000bd6a88 l6: 0000000000000000 l7: 0000000000000000
> i0: ffff800fe085d800 i1: 0000000000000016 i2: 8000000c20c007c3 i3: 00000000f0265f78
> i4: 00000000feff4748 i5: 00000000feff2ff8 i6: ffff80002047b3d1 i7: 000000000077adf0
> I7: <usb_hcd_irq+0x38/0xa0>
> Call Trace:
>  [000000000077adf0] usb_hcd_irq+0x38/0xa0
>  [00000000004d122c] handle_irq_event_percpu+0x8c/0x204
>  [00000000004d13d8] handle_irq_event+0x34/0x60
>  [00000000004d3998] handle_fasteoi_irq+0xdc/0x164
>  [00000000004d1178] generic_handle_irq+0x24/0x38
>  [00000000008dce68] handler_irq+0xb8/0xec
>  [00000000004208b4] tl0_irq5+0x14/0x20
>  [000000000042cfac] cpu_idle+0x9c/0x18c
>  [00000000008d2ad0] after_lock_tlb+0x1b4/0x1cc
>  [0000000000000000]           (null)
> 
> 
> While analyzing it from kdump, I saw  it stuck in  here below.
> 
>  PID: 5274   TASK: ffff800fe1198680  CPU: 0   COMMAND: "cat"
> #0 [ffff800fe25f6f81] switch_to_pc at 8d725c
> #1 [ffff800fe25f70e1] pci_user_read_config_word at 6c4698
> #2 [ffff800fe25f71a1] pci_vpd_pci22_wait at 6c4710
> #3 [ffff800fe25f7261] pci_vpd_pci22_read at 6c4994
> #4 [ffff800fe25f7321] pci_read_vpd at 6c3e90
> #5 [ffff800fe25f73d1] read_vpd_attr at 6ccc78
> #6 [ffff800fe25f7481] read at 5be478
> #7 [ffff800fe25f7531] vfs_read at 54fdb0
> #8 [ffff800fe25f75e1] sys_read at 54ff10
> #9 [ffff800fe25f76a1] linux_sparc_syscall at 4060f4
> TSTATE=0x8082000223 TT=0x16d TPC=0xfffffc0100295e28 TNPC=0xfffffc0100295e2c
>  r0=0x0000000000000000  r1=0x0000000000000003  r2=0x000000000020aec0
>  r3=0x000000000020aec4  r4=0x000000000b000000  r5=0x00000000033fffff
>  r6=0x0000000000000001  r7=0xfffffc01000006f0 r24=0x0000000000000003
> r25=0x000000000020e000 r26=0x0000000000008000 r27=0x0000000000000000
> r28=0x0000000000000000 r29=0x0000000000000000 r30=0x000007feffb468d1
> r31=0x0000000000105d94
> 
>  
> 
>>
>> This seems like a defect in the megaraid hardware or firmware.  If the
>> VPD ROM contains junk, there's no hope that software can read the data
>> and figure out how much is safe to read.
> 
> Yes this looks like problem with megaraid hardware. 
> 
> Other day,  Myron stowe(myron.stowe@gmail.com) reported similar problem with 
> his setup.
> 
>  $ lspci -vvv -s 02:00.0
>   02:00.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID SAS 2208
>   [Thunderbolt] (rev 05)
>         Capabilities: [d0] Vital Product Data
>                 Unknown small resource type 00, will not decode more.
> 
>   $ cat /sys/devices/pci0000:00/0000:00:02.2/0000:02:00.0/vpd |
>      od -A x -t x1z -v
>   000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
>   *
>   007ff0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
>   008000
> 
> 
>>
>> I assume VPD is useful for somebody, and I hate to silently disable
>> the whole thing.  We might want to at least log a note about what
>> we're doing.
> 
> Sure. Let me know what you think.
> 
> 
>>
>> Bjorn
>>
>>> VPD length has been set as 32768 by default. Accessing vpd
>>> will trigger read/write of 32k. This causes problem as we
>>> could read data beyond the VPD end tag. Behaviour is un-
>>> predictable when this happens. I see some other adapter doing
>>> similar quirks(commit bffadffd43d4 ("PCI: fix VPD limit quirk
>>> for Broadcom 5708S"))
>>>
>>> I see there is an attempt to fix this right way.
>>> https://patchwork.ozlabs.org/patch/534843/ or
>>> https://lkml.org/lkml/2015/10/23/97
>>>
>>> Tried to fix it this way, but problem is I dont see the proper
>>> start/end TAGs(at least for this adapter) at all. The data is
>>> mostly junk or zeros. This patch fixes the issue by setting the
>>> vpd length to 0x80.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>>> Tested-by: Dmitry Klochkov <dmitry.klochkov@oracle.com>
>>>
>>> Orabug: 22104511
>>>
>>> Changes since v3 -> v4
>>> We found some options of the lspci does not work very well if
>>> it cannot find the valid vpd tag(Example command "lspci -s 10:00.0 -vv").
>>> It displays the error message and exits right away. Setting the length
>>> back to 0 fixes the problem.
>>>
>>> Changes since v2 -> v3
>>> Changed the vpd length from 0 to 0x80 which leaves the
>>> option open for someone to read first few bytes.
>>>
>>> Changes since v1 -> v2
>>> Removed the changes in pci_id.h. Kept all the vendor
>>> ids in quirks.c
>>> ---
>>>  drivers/pci/quirks.c |   38 ++++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 38 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index b03373f..f739e47 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2123,6 +2123,44 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
>>>  
>>>  /*
>>> + * A read/write to sysfs entry ('/sys/bus/pci/devices/<id>/vpd')
>>> + * will dump 32k of data. The default length is set as 32768.
>>> + * Reading a full 32k will cause an access beyond the VPD end tag.
>>> + * The system behaviour at that point is mostly unpredictable.
>>> + * Also I dont believe vendors have implemented this VPD headers properly.
>>> + * Atleast I dont see it in following megaraid sas controller.
>>> + * That is why adding the quirk here.
>>> + */
>>> +static void quirk_megaraid_sas_limit_vpd(struct pci_dev *dev)
>>> +{
>>> +	if (dev->vpd)
>>> +		dev->vpd->len = 0;
>>> +}
>>> +
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f,
>>> +		quirk_megaraid_sas_limit_vpd);
>>> +
>>> +/*
>>>   * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
>>>   * VPD end tag will hang the device.  This problem was initially
>>>   * observed when a vpd entry was created in sysfs
>>> -- 
>>> 1.7.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
