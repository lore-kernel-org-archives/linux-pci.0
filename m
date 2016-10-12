Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
Subject: Re: [PATCH v2 0/5] PCI: iproc: Cleanups
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012160114.GC4308@localhost>
Cc: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, linux-pci@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <4e1e4df1-15b0-7deb-eaa9-4ac683812be9@broadcom.com>
Date: Wed, 12 Oct 2016 09:04:26 -0700
MIME-Version: 1.0
In-Reply-To: <20161012160114.GC4308@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 10/12/2016 9:01 AM, Bjorn Helgaas wrote:
> On Wed, Oct 12, 2016 at 07:53:03AM -0500, Bjorn Helgaas wrote:
>>   - Add local "dev" pointers to reduce repetition of things like
>>     "&pdev->dev".
>>
>>   - Tidy up drvdata usage.
>>
>>   - Remove some null pointer checking after adding corresponding checking
>>     elsewhere.
>>
>>   - Hard-code the PCIe capability offset instead of searching for it.  This
>>     removes a little bit of dependency on struct pci_bus, with an eye
>>     toward moving the link maintenance before enumeration.
>>
>> Changes from v1:
>>   I dropped the following patches because they were a lot of churn for
>>   questionable benefit:
>>     PCI: iproc: Rename accessors
>>     PCI: iproc: Name private struct pointer "iproc" consistently
>>
>> ---
>>
>> Bjorn Helgaas (5):
>>       PCI: iproc: Add local struct device pointers
>>       PCI: iproc: Set drvdata at end of probe function
>>       PCI: iproc: Validate CSR base in BCMA setup code
>>       PCI: iproc: Remove redundant null pointer checking
>>       PCI: iproc: Hard-code PCIe capability offset instead of searching
>
> I applied these to pci/host-iproc for v4.9.  I hope to ask Linus to
> pull them tomorrow, so if you see any issues, let me know soon.
>

That sounds good. Are these patches in the git repo: 
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git at branch 
pci/host-iproc?

I plan to sanity test them on various iProc based SoCs.

Thanks,

Ray
