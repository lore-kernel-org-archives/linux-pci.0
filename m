Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62888 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbaHLXbE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 19:31:04 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so13447734pdj.30
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 16:31:03 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <361417F9-AEA8-4C83-BD04-D5DD8CD4A391@purestorage.com>
References: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
	<20140812213626.GA6333@google.com>
	<361417F9-AEA8-4C83-BD04-D5DD8CD4A391@purestorage.com>
Date: Tue, 12 Aug 2014 16:31:03 -0700
Message-ID: <CAA93t1rZ23dUQ4mJfLaHHdDBzEwnm=oYbv=B4fpYxuDieOapew@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
From: Rajat Jain <rajatxjain@gmail.com>
To: Sandeep S Mann <sandeep@purestorage.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tue, Aug 12, 2014 at 3:30 PM, Sandeep S Mann <sandeep@purestorage.com> wrote:
>
>> Did you find this by code inspection, or did you actually observe a
>> problem?  If the latter, what were the symptoms?
>>
>> shpchp does the same thing, so I assume it requires the same fix.
>
> Hi Bjorn,
>
> This issue was observed on a system, where I was experimenting with
> pcie hot-plug and the device being hot plugged is not the most well
> behaved.  It exhibits the following behavior:
>
>   - Initialization of the device can take “relatively” long (order 100s ms)
>   - On hot add the link presence can toggle before stabilizing

Yup, this would be a problem if the work queue was reordered in this case.

>
> The toggle of device presence can generate multiple events on a single
> hot plug, where one hot add event can lead to following events
> ADD->REMOVE->ADD.  And given the device can take some time to initialize,
> we can have three HP events being processed concurrently.

The HP events are actually serialized, but only from the perspective
if PCI subsystem (i.e. once they have been dispatched from the
workqueue):
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=50b52fdee050745935d92e7026373edea2647e60

>
> Also note this seen with surprise ADD and REMOVE.
>

Can you please send lspci -vvvv for the slot? I suspect that your
device has a power controller. In absense of it, the link state
changes would generate HP events regardless of "surprise" bit.

Thanks,

Rajat

> S
>
>
