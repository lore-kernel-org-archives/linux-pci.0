Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40754 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161032Ab2ERK0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 May 2012 06:26:06 -0400
Message-ID: <4FB623BC.1010202@redhat.com>
Date: Fri, 18 May 2012 06:26:04 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
References: <1337274270-18785-1-git-send-email-prarit@redhat.com> <20120518045130.GA3281@kroah.com>
In-Reply-To: <20120518045130.GA3281@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 05/18/2012 12:51 AM, Greg KH wrote:
> On Thu, May 17, 2012 at 01:04:30PM -0400, Prarit Bhargava wrote:
>> Consider the following case
>>
>> 		[ RP ]
>> 		  |
>> 		  |
>> 	+---------+-----------+
>> 	|	  |	      |
>>        [H1]      [H2]        [X1]
>>
>> where RP is a PCIE Root Port, H1 and H2 are devices with drivers that support
>> PCIE AER driver error handling (ie, they have pci_error_handlers defined in
>> the driver), and X1 is a device with a driver that does not support PCIE
>> AER driver error handling.
>>
>> If the Root Port takes an error what currently happens is that the
>> bus resets and H1 & H2 call their slot_reset functions.  X1 does nothing.
>>
>> In some cases a user may not wish the system to continue because X1 is
>> an unhardened driver.  In these cases, the system should not do a bus reset,
>> but rather the system should panic to avoid any further possible data
>> corruption.
>>
>> This patch implements an AER_panic sysfs entry for each root port which
>> a user can modify.  AER_panic = 1, means the system will panic on a
>> PCIE error which would have normally resulted in a secondary bus reset.
> 
> If you add/modify/delete a sysfs file, you have to also have a
> corrisponding patch to Documentation/ABI/ in order to keep things sane.
> Please do that as part of this patch the next time you submit it.

Sorry about that Greg.  I'll submit a [v2] with that modification.

P.
> 
> thanks,
> 
> greg k-h
