Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:58380 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759293Ab3DCKjk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2013 06:39:40 -0400
Message-ID: <515C06E8.4080906@fold.natur.cuni.cz>
Date: Wed, 03 Apr 2013 12:39:36 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: huang ying <huang.ying.caritas@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <51548C9E.9090703@fold.natur.cuni.cz> <2990024.LMTIBUbM3d@vostro.rjw.lan> <51564804.9000700@fold.natur.cuni.cz> <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com> <515AF312.1010507@fold.natur.cuni.cz> <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com> <515B17D9.6030805@fold.natur.cuni.cz> <515B45A6.1020404@fold.natur.cuni.cz> <CAC=cRTPNfhwSC=3VuxNxXLcp5D_fK3UCwKykWk1yN-6SpGAbVQ@mail.gmail.com>
In-Reply-To: <CAC=cRTPNfhwSC=3VuxNxXLcp5D_fK3UCwKykWk1yN-6SpGAbVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

huang ying wrote:
> Hi, Martin,
> 
> On Wed, Apr 3, 2013 at 4:55 AM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>> [ +linux-pci and Yinghai as they suffered already those many emails on individual
>>  threads so one overviewing email hopefully won't harm] ;-)
>>
>> Martin Mokrejs wrote:
>>>
>>>
>>> Bjorn Helgaas wrote:
>>>> On Tue, Apr 2, 2013 at 9:02 AM, Martin Mokrejs
>>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>>> Hi Ying,
>>>>>
>>>>> huang ying wrote:
>>>>
>>>>>> And please give me the full dmesg for boot and incremental dmesg for
>>>>>> operations.
>>>>>
>>>>>
>>>>> The incremental bits here, the full dmesg will send only directly to your email, due to its size.
>>>>
>>>> Is there a bugzilla for this issue?  Please attach the complete dmesg
>>>> there or somewhere similar so we can all benefit.
>>>
>>> I changed my mind. I am attaching the dmesg here but omitting linux-acpi
>>> list. After I hear a proposal from Rafel/Bjorn I will open separate bugs.
>>> I thought that the threads I started so far were enough but yes, dmesg
>>> files don't pass through list filters so I should move that to bugzilla.
>>>
>>> so far my view of the the bugs was:
>>>
>>> 1) acpiphp hotplug broken due to upstream pcieport 1c.7 PME# enabled
>>>   (eSATA-based card)
>>
>> Fixed by Ying Huang port_dbg.patch applied over 3.8.5 (fixes acpiphp hotplug
>> of eSATA and Firewire cards, NOT the hotplug of a NEC-based USB3 card -> hence
>> the bug 4) below). Now I can continue using laptop-mode-tools.
>>
>>
>>> 2) xHCI dead due to to its suspend - 3.8 series and above
>>
>> Not fixed by port_dbg.patch applied over 3.8.5. Interestingly, a NEC-based
>> XHCI card *in an express card slot* does not suffer this suspend issue.
>> Although it is being put into suspend if a device is unplugged.
> 
> Do not find the dmesg or any other details about this.  Could you
> provide some details?  Or I miss some emails from you?

No, I did not send them away. ;-) I was really waiting for answers how to separate
the bugs, how to name them, what components in bugzilla, etc.


So? ;)

> 
> Best Regards,
> Huang Ying
> 
> 
