Return-Path: <m-karicheri2@ti.com>
Return-Path: <m-karicheri2@ti.com>
Subject: Re: [PATCH v2 0/6] PCI: keystone: Cleanups
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012160622.GQ4308@localhost>
CC: <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <57FFCADE.7040300@ti.com>
Date: Thu, 13 Oct 2016 13:56:46 -0400
MIME-Version: 1.0
In-Reply-To: <20161012160622.GQ4308@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 10/12/2016 12:06 PM, Bjorn Helgaas wrote:
> On Wed, Oct 12, 2016 at 08:53:00AM -0500, Bjorn Helgaas wrote:
>>   - Add local "dev" pointers to reduce repetition of things like
>>     "&pdev->dev".
>>
>>   - Use generic DesignWare accessors when possible.
>>
>>   - Pass device-specific struct instead of register addresses to IRQ and
>>     DBI functions.
>>
>>   - Add app register accessors to encapsulate usage of va_app_base.
>>
>> Nothing here should change the behavior of the driver.
>>
>> Changes from v1:
>>   Added local struct device pointers.
>>   I dropped the following patch because it was a lot of churn for
>>   questionable benefit:
>>     PCI: keystone: Name private struct pointer "keystone" consistently
>>
>> ---
>>
>> Bjorn Helgaas (6):
>>       PCI: keystone: Add local struct device pointers
>>       PCI: keystone: Use generic DesignWare accessors
>>       PCI: keystone: Pass keystone_pcie, not address, to IRQ functions
>>       PCI: keystone: Pass keystone_pcie, not va_app_base, to DBI functions
>>       PCI: keystone: Add app register accessors
>>       PCI: keystone: Reorder struct keystone_pcie
>>
>>
>>  drivers/pci/host/pci-keystone-dw.c |  123 ++++++++++++++++++++----------------
>>  drivers/pci/host/pci-keystone.c    |   28 ++++----
>>  drivers/pci/host/pci-keystone.h    |    9 +--
>>  3 files changed, 88 insertions(+), 72 deletions(-)
> 
> I applied these to pci/host-keystone for v4.9.  I hope to ask Linus to
> pull them tomorrow, so if you see any issues, let me know soon.
> 
Bjorn,

I have reviewed them and they look good to me. For testing, I am in the
middle of a high visibility debug and it will be a while before I can test
these.

Thanks 
-- 
Murali Karicheri
Linux Kernel, Keystone
