Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42374 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444AbcAIXQ1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jan 2016 18:16:27 -0500
Subject: Re: [PATCH] Limit VPD length on Atheros wifi cards
To: Bjorn Helgaas <helgaas@kernel.org>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
References: <1451427542-30482-1-git-send-email-Jordan_Hargrave@dell.com>
 <20160109005736.GP5354@localhost> <20160109010545.GA31085@localhost>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
	Hannes Reinecke <hare@suse.de>,
	Michal Kubecek <mkubecek@suse.com>,
	"Shane M. Seymour" <shane.seymour@hpe.com>,
	Myron Stowe <myron.stowe@gmail.com>,
	Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <569194AC.8060301@oracle.com>
Date: Sat, 9 Jan 2016 17:15:56 -0600
MIME-Version: 1.0
In-Reply-To: <20160109010545.GA31085@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for bringing this topic up.

On 1/8/2016 7:05 PM, Bjorn Helgaas wrote:
> [+cc Hannes, Michal, Shane, Myron, Venkat; sorry I missed you guys the
> first time around]
> 
> On Fri, Jan 08, 2016 at 06:57:36PM -0600, Bjorn Helgaas wrote:
>> [+cc Babu]
>>
>> Hi Jordan, Babu, et al,
>>
>> On Tue, Dec 29, 2015 at 04:19:02PM -0600, Jordan Hargrave wrote:
>>> Attempt to read VPD on these cards causes kernel hang or delay
>>>
>>> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
>>> ---
>>>  drivers/pci/quirks.c |   10 ++++++++++
>>>  1 files changed, 10 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index e6376f6..a72667f 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2161,6 +2161,16 @@ static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
>>>  	}
>>>  }
>>>  
>>> +static void quirk_atheros_vpd(struct pci_dev *dev)
>>> +{
>>> +	/* Atheros WiFi cards hang when reading VPD */
>>> +	if (dev->vpd)
>>> +		dev->vpd->len = 0;
>>> +}
>>> +
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATHEROS, PCI_ANY_ID, quirk_atheros_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_atheros_vpd);
>>
>> We're accumulating several quirks like this, and they don't do
>> anything device-specific, so we could probably use a single quirk for
>> all of them, i.e., Babu's quirk_megaraid_sas_limit_vpd() and your
>> quirk_atheros_vpd() are needlessly duplicated.
>>
>> I'd really like to have more details about what the "kernel hang or
>> delay" that happens when we try to read VPD.
>>
>> Looking at pci_vpd_pci22_read(), it basically just does config
>> accesses, so I only see two ways things could go wrong:
>>
>>   1) If the device responds with data, but the PCI_VPD_ADDR_F flag
>>   isn't set, we should be able to timeout gracefully.
>>
>>   2) If the device doesn't respond at all, we could see machine
>>   checks, master aborts, processor read timeouts, or similar hardware
>>   problems.

 I think I saw the the second problem. It appears to respond ok when the length
is smaller(i tried 0x80). Problem with that is, lspci reports error when it cannot find
start/end tags. I saw all the data as 00. I think Myron saw everything 00 and 0xFF sometimes.

When I increase the length, kernel hangs and panics at some unknown location.
Looking at the crash I saw this stack(it did not panic at this location though)

 PID: 5274   TASK: ffff800fe1198680  CPU: 0   COMMAND: "cat"
#0 [ffff800fe25f6f81] switch_to_pc at 8d725c
#1 [ffff800fe25f70e1] pci_user_read_config_word at 6c4698
#2 [ffff800fe25f71a1] pci_vpd_pci22_wait at 6c4710
#3 [ffff800fe25f7261] pci_vpd_pci22_read at 6c4994
#4 [ffff800fe25f7321] pci_read_vpd at 6c3e90
#5 [ffff800fe25f73d1] read_vpd_attr at 6ccc78
#6 [ffff800fe25f7481] read at 5be478
#7 [ffff800fe25f7531] vfs_read at 54fdb0
#8 [ffff800fe25f75e1] sys_read at 54ff10
#9 [ffff800fe25f76a1] linux_sparc_syscall at 4060f4
TSTATE=0x8082000223 TT=0x16d TPC=0xfffffc0100295e28 TNPC=0xfffffc0100295e2c
 r0=0x0000000000000000  r1=0x0000000000000003  r2=0x000000000020aec0
 r3=0x000000000020aec4  r4=0x000000000b000000  r5=0x00000000033fffff
 r6=0x0000000000000001  r7=0xfffffc01000006f0 r24=0x0000000000000003
r25=0x000000000020e000 r26=0x0000000000008000 r27=0x0000000000000000
r28=0x0000000000000000 r29=0x0000000000000000 r30=0x000007feffb468d1
  
  
>>
>> If there are other failure modes, I'd like to learn what they are.
>>
>> If we're seeing problems like (1), there must be something we can
>> improve in the way we handle timeouts.
>>
>> If we're seeing failures like (2), they're probably caused by a
>> hardware or firmware problem on the device, and there's not much we
>> can do in the kernel, so disabling VPD access completely is probably
>> all we can do.
>>
>> So if/when we add quirks like this, I'm looking for bugzilla entries
>> that clearly show that the problem is (2).  I'd also like to log
>> something in dmesg as a clue about why lspci or other utilities don't
>> find any VPD data.

Sure. I can open a bugzilla on Monday with more details.  I like the idea
of having a one solution to cover all these cases. I can post a RFC patch
with one function to cover all these buggy adapters. Please let me know.

>>
>> Bjorn
>>
>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>>>  			PCI_DEVICE_ID_NX2_5706,
>>>  			quirk_brcm_570x_limit_vpd);
