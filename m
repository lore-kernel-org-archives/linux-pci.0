Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:64748 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaLYUtV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Dec 2014 15:49:21 -0500
Received: by mail-la0-f54.google.com with SMTP id pv20so7990864lab.41
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2014 12:49:19 -0800 (PST)
Message-ID: <549C784D.8090000@gmail.com>
Date: Thu, 25 Dec 2014 21:49:17 +0100
From: Thomas Lindroth <thomas.lindroth@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>
Subject: Re: [Bug 90311] New: Hibernate failure with intel_iommu
References: <bug-90311-41252@https.bugzilla.kernel.org/> <CAErSpo7rtsQfqkMCRy7u+Tn_iCEPN5HbMQdz1hQTOvUt=67CkQ@mail.gmail.com>
In-Reply-To: <CAErSpo7rtsQfqkMCRy7u+Tn_iCEPN5HbMQdz1hQTOvUt=67CkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/25/2014 08:55 PM, Bjorn Helgaas wrote:
> [+cc Alex, linux-pci, iommu]
> 
> On Thu, Dec 25, 2014 at 12:13 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=90311
>>
>>             Bug ID: 90311
>>            Summary: Hibernate failure with intel_iommu
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: 3.18.1
>>           Hardware: x86-64
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: PCI
>>           Assignee: drivers_pci@kernel-bugs.osdl.org
>>           Reporter: thomas.lindroth@gmail.com
>>         Regression: No
>>
>> Created attachment 161811
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=161811&action=edit
>> dmesg with iommu on
>>
>> Enabling intel_iommu=on causes uswsusp s2disk to fail. Hibernate always works
>> fine without iommu and as far as I can tell everything works fine with iommu on
>> without hibernating. With intel_iommu set to on I can enter hibernate but the
>> system doesn't come back properly. By that I mean the kernel can't read from
>> swap and everything freezes. I can still switch between virtual terminals, view
>> the system log and use magic sysrq to reboot. The system log is spammed with
>> error messages from the scsi subsystem. http://i.imgur.com/ToFd8NM.jpg sdb
>> contains root and swap.
>>
>> I'm guessing the iommu mapping isn't setup properly after resume so the disk
>> controller can't do DMA anymore. I have made sure the kernel command line
>> contains intel_iommu=on before and after suspend. I have one of the bad marvell
>> 88SE9172 controllers but the swap is not connected to it (bug #42679).
>>
>> I'm running a gentoo system with kernel 3.18.1 on a Gigabyte Z97X-Gaming G1
>> mobo with bios F7 (latest). Finding the problem might be difficult and I don't
>> know what kind of information to provide. I can give you any debug output
>> needed and apply debug patches if needed.
> 
> Is this a regression?  If so, what was the most recent working kernel?

It's not a regression but I've only been able to test iommu on kernel
3.17 and up because of that faulty marvell controller. Hibernate fails
on both 3.17 and 3.18 but I don't know about older kernels.
