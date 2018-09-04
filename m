Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH v7 0/1] PCI: Handle conflict between hotplug and error
 handling
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
References: <20180805225136.5800-1-okaya@kernel.org>
 <20180904181824.GH107892@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <0c3002fd-a8de-ca1c-2378-35c893b48df8@kernel.org>
Date: Tue, 4 Sep 2018 11:28:26 -0700
MIME-Version: 1.0
In-Reply-To: <20180904181824.GH107892@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 9/4/2018 11:18 AM, Bjorn Helgaas wrote:
> On Sun, Aug 05, 2018 at 03:51:35PM -0700, Sinan Kaya wrote:
>> Lukas:
>> 'Your patch "[PATCH v6 1/1] PCI: pciehp: Ignore link events when there
>> is a fatal error pending" only checks once for a pending fatal error,
>> it should poll until either the fatal error is gone or a timeout is
>> hit.  If the fatal error is gone and the link is up, you can just return
>> from pciehp_handle_presence_or_link_change().  Else (in the timeout case)
>> fall back to the normal handling of a Link Down, i.e. let it bring down
>> the slot.'
>>
>>
>> Sinan Kaya (1):
>>    PCI: pciehp: Ignore link events when there is a fatal error pending
>>
>>   drivers/pci/hotplug/pciehp_ctrl.c | 19 ++++++++++
>>   drivers/pci/pci.h                 |  2 ++
>>   drivers/pci/pcie/err.c            | 60 +++++++++++++++++++++++++++++++
>>   3 files changed, 81 insertions(+)
> 
> Dropping for now because it sounds like you intend to mask out the
> error for hotplug ports.
> 

Yes, I handed this work off-list to Keith and Lucas. I don't have hardware
to test.
