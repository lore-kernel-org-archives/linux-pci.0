Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37538 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675Ab1LGTdi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2011 14:33:38 -0500
Received: by yenm11 with SMTP id m11so380974yen.19
        for <linux-pci@vger.kernel.org>; Wed, 07 Dec 2011 11:33:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111207092531.GF19129@ram-ThinkPad-T61>
References: <CAErSpo58okGsDW4dOK4i0g_RUejkuQa=iw2uQ5HAJJZCwFtsbw@mail.gmail.com>
	<20111007232516.GF2980@ram-ThinkPad-T61>
	<1318057168.29415.333.camel@pasglop>
	<20111008075353.GK2980@ram-ThinkPad-T61>
	<1318060793.29415.347.camel@pasglop>
	<20111102140325.004b9dad@jbarnes-desktop>
	<20111103013014.GB393@ram-ThinkPad-T61>
	<20111106023310.GA2383@ram-ThinkPad-T61>
	<20111205103202.29faf6e1@jbarnes-desktop>
	<CAE9FiQXx_nkOFP2S=hXKyjcFHh4R4f5c+J-aCiDoYS=3Tgdmqw@mail.gmail.com>
	<20111207092531.GF19129@ram-ThinkPad-T61>
Date: Wed, 7 Dec 2011 11:33:37 -0800
Message-ID: <CAE9FiQXb3HPmpYrDCe90_3LYw-wQx2y=YtQCz-YsEnn-fA1=6A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 7, 2011 at 1:25 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Wed, Dec 07, 2011 at 12:22:47AM -0800, Yinghai Lu wrote:
>> On Mon, Dec 5, 2011 at 10:32 AM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
>> > On Sun, 6 Nov 2011 10:33:10 +0800
>> > Ram Pai <linuxram@us.ibm.com> wrote:
>> >
>> >>
>> >>   NOTE: Note, there is subtle change in the pci_enable_device() API.
>> >>   Any driver that depends on SRIOV BARS to be enabled in pci_enable_device()
>> >>   can fail.
>> >>
>> >> ---
>> >
>> > Applied to my for-linus branch, thanks.
>> >
>>
>> please don't push to linus now.
>>
>> this one causes regression.
>>
>> please check attached patch.
>>
>> Thanks
>>
>> Yinghai
>
>> [PATCH] pci: Fix hotplug of Express Module with pci bridges
>>
>> Found hotplug of one setup does not work with recent change in pci tree.
>>
>> After checking the bridge conf setup, found bridges get assigned, but not get enabled.
>>
>> Finally found following commit, simplely ignore bridge resource when enabling pci device.
>>
>> | commit bbef98ab0f019f1b0c25c1acdf1683c68933d41b
>> | Author: Ram Pai <linuxram@us.ibm.com>
>> | Date:   Sun Nov 6 10:33:10 2011 +0800
>> |
>> |    PCI: defer enablement of SRIOV BARS
>> |...
>> |    NOTE: Note, there is subtle change in the pci_enable_device() API.  Any
>> |    driver that depends on SRIOV BARS to be enabled in pci_enable_device()
>> |    can fail.
>>
>> Put back bridge resource and ROM resource checking to fix the problem.
>>
>> That should fix regression like BIOS does not assign correct resource to bridge.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>
>> ---
>>  drivers/pci/pci.c |    6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> Index: linux-2.6/drivers/pci/pci.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/pci/pci.c
>> +++ linux-2.6/drivers/pci/pci.c
>> @@ -1139,7 +1139,11 @@ static int __pci_enable_device_flags(str
>>       if (atomic_add_return(1, &dev->enable_cnt) > 1)
>>               return 0;               /* already enabled */
>>
>> -     for (i = 0; i < PCI_ROM_RESOURCE; i++)
>> +     /* only skip sriov related */
>> +     for (i = 0; i <= PCI_ROM_RESOURCE; i++)
>> +             if (dev->resource[i].flags & flags)
>> +                     bars |= (1 << i);
>> +     for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++)
>>               if (dev->resource[i].flags & flags)
>>                       bars |= (1 << i);
>>
>
> Oops. My patch inadvertently dropped ROM and BRIDGE resources.
>
> This patch is right. However would it help if we did something like this
> to avoid some code duplication?
>
>        for (i = 0; i < DEVICE_COUNT_RESOURCE;
>                i == PCI_ROM_RESOURCE ? PCI_BRIDGE_RESOURCES: i++)
>                if (dev->resource[i].flags & flags)
>                        bars |= (1 << i);

just don't want to make for () too big.

Thanks

Yinghai
