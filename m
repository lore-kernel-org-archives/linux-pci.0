Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from na3sys010aog113.obsmtp.com ([74.125.245.94]:58908 "HELO
	na3sys010aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751494AbaHMAJO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Aug 2014 20:09:14 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so13940364pad.10
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 17:09:13 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
From: Sandeep S Mann <sandeep@purestorage.com>
In-Reply-To: <CAA93t1rZ23dUQ4mJfLaHHdDBzEwnm=oYbv=B4fpYxuDieOapew@mail.gmail.com>
Date: Tue, 12 Aug 2014 17:09:11 -0700
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-Id: <E43BF28E-A4E6-4114-81D5-A7D4C1E22D49@purestorage.com>
References: <1406933232-1560-1-git-send-email-sandeep@purestorage.com> <20140812213626.GA6333@google.com> <361417F9-AEA8-4C83-BD04-D5DD8CD4A391@purestorage.com> <CAA93t1rZ23dUQ4mJfLaHHdDBzEwnm=oYbv=B4fpYxuDieOapew@mail.gmail.com>
To: rajatxjain@gmail.com
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Rajat,


>> 
>> This issue was observed on a system, where I was experimenting with
>> pcie hot-plug and the device being hot plugged is not the most well
>> behaved.  It exhibits the following behavior:
>> 
>>  - Initialization of the device can take “relatively” long (order 100s ms)
>>  - On hot add the link presence can toggle before stabilizing
> 
> Yup, this would be a problem if the work queue was reordered in this case.
> 
>> 
>> The toggle of device presence can generate multiple events on a single
>> hot plug, where one hot add event can lead to following events
>> ADD->REMOVE->ADD.  And given the device can take some time to initialize,
>> we can have three HP events being processed concurrently.
> 
> The HP events are actually serialized, but only from the perspective
> if PCI subsystem (i.e. once they have been dispatched from the
> workqueue):
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=50b52fdee050745935d92e7026373edea2647e60
> 

With an ordered workqueue I am wondering if the locking is needed.  My kernel tree
seems to be a bit behind and does not contain this change.  I suppose there
could still be a race between pciehp_probe and the processing of the HP event.  

>> 
>> Also note this seen with surprise ADD and REMOVE.
>> 
> 
> Can you please send lspci -vvvv for the slot? I suspect that your
> device has a power controller. In absense of it, the link state
> changes would generate HP events regardless of "surprise" bit.

Yes we are behind a slot with power management.

        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Thanks,
Sandeep


