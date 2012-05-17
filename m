Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25794 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762241Ab2EQRjD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 May 2012 13:39:03 -0400
Message-ID: <4FB537B4.1040505@redhat.com>
Date: Thu, 17 May 2012 13:39:00 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Shyam_Iyer@Dell.com
CC: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
References: <1337274270-18785-1-git-send-email-prarit@redhat.com> <DBFB1B45AF80394ABD1C807E9F28D15707BC8F0CE9@BLRX7MCDC203.AMER.DELL.COM>
In-Reply-To: <DBFB1B45AF80394ABD1C807E9F28D15707BC8F0CE9@BLRX7MCDC203.AMER.DELL.COM>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 05/17/2012 01:29 PM, Shyam_Iyer@Dell.com wrote:
> 
> 
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>> owner@vger.kernel.org] On Behalf Of Prarit Bhargava
>> Sent: Thursday, May 17, 2012 1:05 PM
>> To: linux-pci@vger.kernel.org
>> Cc: Prarit Bhargava; Bjorn Helgaas
>> Subject: [PATCH] pci, Add AER_panic sysfs file
>>
>> Consider the following case
>>
>> 		[ RP ]
>> 		  |
>> 		  |
>> 	+---------+-----------+
>> 	|	  |	      |
>>        [H1]      [H2]        [X1]
>>
>> where RP is a PCIE Root Port, H1 and H2 are devices with drivers that
>> support
>> PCIE AER driver error handling (ie, they have pci_error_handlers
>> defined in
>> the driver), and X1 is a device with a driver that does not support
>> PCIE
>> AER driver error handling.
>>
>> If the Root Port takes an error what currently happens is that the
>> bus resets and H1 & H2 call their slot_reset functions.  X1 does
>> nothing.
>>
>> In some cases a user may not wish the system to continue because X1 is
>> an unhardened driver.  In these cases, the system should not do a bus
>> reset,
>> but rather the system should panic to avoid any further possible data
>> corruption.
> 
> Do we neeed to panic for both correctable and uncorrectable errors.. ?
> 
> I thought correctable errors could recover without a bus reset.

Will a bus reset be issued on a correctable error?  I thought the code path was
that the bus reset was issued on the uncorrectable error.

drivers/pci/pcie/aer/aerdrv_core.c: do_recovery()

        if (severity == AER_FATAL) {
                result = reset_link(dev);
                if (result != PCI_ERS_RESULT_RECOVERED)
                        goto failed;
        }

I may not be looking at the right spot of code.  Care to enlighten me? :)

P.
