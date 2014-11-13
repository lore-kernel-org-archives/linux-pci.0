Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:53043 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbaKMEcN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 23:32:13 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so15091657iec.12
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 20:32:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6Bfya60UMeN3cxSH3A+cesAAgPuZEb6b6FHnVBFsOxfA@mail.gmail.com>
References: <bug-88131-41252@https.bugzilla.kernel.org/>
	<CAErSpo6Bfya60UMeN3cxSH3A+cesAAgPuZEb6b6FHnVBFsOxfA@mail.gmail.com>
Date: Wed, 12 Nov 2014 20:32:12 -0800
Message-ID: <CAE9FiQU-8dusyj6BAKV0w2C_xW6w6fO4vsyAca-TdoRY6xQhVA@mail.gmail.com>
Subject: Re: [Bug 88131] New: PCI device intel ixgbe and xhci with 64-bit bar
 address can NOT work on x86_32 PAE kernel.
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Aaron Ma <mapengyu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 8:14 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc linux-pci, Yinghai]
>
> Thanks for the report!
>
> On Wed, Nov 12, 2014 at 8:57 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=88131
>>
>>             Bug ID: 88131
>>            Summary: PCI device intel ixgbe and xhci with 64-bit bar
>>                     address can NOT work on x86_32 PAE kernel.
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: 3.18-rc4
>>           Hardware: i386
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: PCI
>>           Assignee: drivers_pci@kernel-bugs.osdl.org
>>           Reporter: mapengyu@gmail.com
>>         Regression: No
>>
>> Created attachment 157441
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=157441&action=edit
>> dmesg
>>
>> PCI device intel ixgbe and xhci with 64-bit bar address can NOT work on x86_32
>> kernel.
>>
>> The bar0 base address of intel ixgbe ethernet card and xhci are above 4G.
>> The commit d56dbf5bab8ce44c5407bb099f71987f58d18bb4 try to map the resource
>> above 4G.
>> Enabled PAE and HIGHMEM64G, it should support 64-bit BAR, but failed on high
>> bar address.
>
> Can you also attach your .config to the bugzilla?
>
> Is this a regression?  Did it work correctly before d56dbf5bab8c
> ("PCI: Allocate 64-bit BARs above 4G when possible")?
>
> I assume this is the problem you're seeing (for igbe):

This is some kind of bug that is uncovered by that commit.

I already have two patches for ixgbe one.

but xhci could be different problem.

Aaron, can you split the bug to two ?
one for ixgbe and one for xhci.

Thanks

Yinghai
