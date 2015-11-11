Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47811 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbbKKUKQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2015 15:10:16 -0500
Subject: Re: [PATCH v2] pci: Limit VPD length for megaraid_sas adapter
To: Myron Stowe <myron.stowe@gmail.com>
References: <1447257297-198460-1-git-send-email-babu.moger@oracle.com>
 <CAL-B5D1pn3Rk3RVmmjKy+ChwSCOYf0y+REfiwznrFTj8e70Zcg@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <5643A093.6050301@oracle.com>
Date: Wed, 11 Nov 2015 14:09:55 -0600
MIME-Version: 1.0
In-Reply-To: <CAL-B5D1pn3Rk3RVmmjKy+ChwSCOYf0y+REfiwznrFTj8e70Zcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 11/11/2015 1:30 PM, Myron Stowe wrote:
> On Wed, Nov 11, 2015 at 8:54 AM, Babu Moger <babu.moger@oracle.com> wrote:
>> Changes since v1 -> v2
>> Removed the changes in pci_id.h. Kept all the vendor
>> ids in quirks.c
>>
>> Reading or Writing of PCI VPD data causes system panic.
>> We saw this problem by running "lspci -vvv" in the beginning.
>> However this can be easily reproduced by running
>>  cat /sys/bus/devices/XX../vpd
>>
>> VPD length has been set as 32768 by default. Accessing vpd
>> will trigger read/write of 32k. This causes problem as we
>> could read data beyond the VPD end tag. Behaviour is un-
>> predictable when this happens. I see some other adapter doing
>> similar quirks(commit id bffadffd43d438c3143b8d172a463de89345b836)
>>
>> I see there is an attempt to fix this right way.
>> https://patchwork.ozlabs.org/patch/534843/ or
>> https://lkml.org/lkml/2015/10/23/97
>>
>> Tried to fix it this way, but problem is I dont see the proper
>> start/end TAGs(at least for this adapter) at all. The data is
>> mostly junk or zeros. This patch fixes the issue by setting the
>> vpd length to 0.
>>
>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>> ---
>>  drivers/pci/quirks.c |   38 ++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 38 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index b03373f..f739e47 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2123,6 +2123,44 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
>>
>>  /*
>> + * A read/write to sysfs entry ('/sys/bus/pci/devices/<id>/vpd')
>> + * will dump 32k of data. The default length is set as 32768.
>> + * Reading a full 32k will cause an access beyond the VPD end tag.
>> + * The system behaviour at that point is mostly unpredictable.
>> + * Also I dont believe vendors have implemented this VPD headers properly.
>> + * Atleast I dont see it in following megaraid sas controller.
>> + * That is why adding the quirk here.
>> + */
>> +static void quirk_megaraid_sas_limit_vpd(struct pci_dev *dev)
>> +{
>> +       if (dev->vpd)
>> +               dev->vpd->len = 0;
>> +}
>> +
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d,
>> +               quirk_megaraid_sas_limit_vpd);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f,
>> +               quirk_megaraid_sas_limit_vpd);
>> +
>> +/*
>>   * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
>>   * VPD end tag will hang the device.  This problem was initially
>>   * observed when a vpd entry was created in sysfs
>> --
>> 1.7.1
>>
> 
> Just to confirm, I've encountered similar results on a MegaRAID SAS 2208 -

Myron, Thanks for confirmation. With most of the devices behaving this way, 
I feel the default length is set too high. Anyway that is Bjorn's call. 
For this adapter, I think we should set the length to 0.
  
> 
>   $ lspci -vvv -s 02:00.0
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
> and got the following on the NIC related ports of a Brocade device -
> 
>  $ lspci -vvv -s 03:00.0
>   03:00.0 Fibre Channel: Brocade Communications Systems, Inc.
>   1010/1020/1007/1741 10Gbps CNA (rev 01)
>         Capabilities: [a0] Vital Product Data
>                 No end tag found
> 
>   $ cat /sys/devices/pci0000:00/0000:00:02.0/0000:03:00.0/vpd |
>      od -A x -t x1z -v
>   000000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
>   *
>   007ff0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
>   008000
> 
> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
