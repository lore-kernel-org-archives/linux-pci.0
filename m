Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:3867 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751739AbbIPHh3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2015 03:37:29 -0400
Message-ID: <55F91C34.4070800@internode.on.net>
Date: Wed, 16 Sep 2015 17:07:24 +0930
From: Arthur Marsh <arthur.marsh@internode.on.net>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, x86@kernel.org
Subject: Re: [Bugfix 0/3] Convert eata driver to a normal PCI device driver
References: <CAErSpo4oignSpK-LCLO=deW_FZ-V58GUhBxJ5uvmXe4DYo4WdA@mail.gmail.com> <1442200140-30808-1-git-send-email-jiang.liu@linux.intel.com> <55F6EF40.50403@internode.on.net> <55F78306.3000802@linux.intel.com> <55F7C691.8000406@internode.on.net> <55F8F90D.2050703@linux.intel.com>
In-Reply-To: <55F8F90D.2050703@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Jiang Liu wrote on 16/09/15 14:37:
> On 2015/9/15 15:19, Arthur Marsh wrote:
>>
>>
>> Jiang Liu wrote on 15/09/15 12:01:
>>
>>> HI Arthur,
>>>      Really appreciate your help to test the patches. That's
>>> a good sign we have moved forward a bit:)
>>>      For kexec, it's always challenging to me. So could you
>>> please help to provide full dmesg logs with working kernels
>>> so I could try to figure out the order among scsi and PCI devices.
>>> It may be shutdown order related.
>>> Thanks!
>>> Gerry
>>
>> OK, attached is the dmesg output from the 4.2.0 kernel where kexec worked.
> Hi Arthur,
> 	Could you please also help to capture the log messages
> of kexec, I need to those log messages to figure out the order
> to shutdown PCI devices and scsi devices during kexec.
> Thanks!
> Gerry
>

How would I capture the log messages of kexec (assuming that there are 
any, I couldn't see from the manual page entries and haven't seen 
anything beyond the screen images that I have already sent you)?

Regards,

Arthur.
