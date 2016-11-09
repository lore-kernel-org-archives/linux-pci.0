Return-Path: <prarit@redhat.com>
Return-Path: <prarit@redhat.com>
Message-ID: <58237DB8.9030009@redhat.com>
Date: Wed, 09 Nov 2016 14:49:12 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Keith Busch <keith.busch@intel.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, darcari@redhat.com, mstowe@redhat.com,
        bhelgaas@google.com, lukas@wunner.de, mika.westerberg@linux.intel.com
Subject: Re: [PATCH] pci: Only disable MSI/X and enable INTx if shutdown function
 has been called
References: <1478627867-28795-1-git-send-email-prarit@redhat.com> <20161109170529.GJ14322@bhelgaas-glaptop.roam.corp.google.com> <58237AB7.8080301@redhat.com> <20161109195458.GA3409@localhost.localdomain>
In-Reply-To: <20161109195458.GA3409@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>



On 11/09/2016 02:54 PM, Keith Busch wrote:
> On Wed, Nov 09, 2016 at 02:36:23PM -0500, Prarit Bhargava wrote:
>>
>>
>> On 11/09/2016 12:05 PM, Bjorn Helgaas wrote:
>>> Hi Prarit,
>>>
>>> Is there a bugzilla or other archive of configuration/dmesg/other info
>>
>> [I have only added Bjorn and myself to the BZ below.  Please feel free to add
>> yourself.]
>>
>> Bjorn, unfortunately this won't be caught in a dmesg log because the filesystem
>> is unmounted by the time we shutdown the PCI devices in the halt/reboot path.
>>
>> The trace is only available from serial console, and I have opened up
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=187351
>>
>> to track this.
>>
>> I have added some additional links to other bugzillas which seem to show the
>> same behavior, and included a full serial console capture of the boot to the BZ.
>>  The end of the log shows the unhandled irq stack trace for irq 16.
> 
> Just researching where this came from, the behavior to shutdown msi/msix
> and enable intx was done in commit d52877c7b1 for some kexec issue,
> and I think that was wrong in the first place. We shouldn't be changing
> interrupt configuration out from under the drivers.

Yeah .. and it was RHEL specific?  Or at least it seems that way.

P.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
