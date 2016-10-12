Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
MIME-Version: 1.0
In-Reply-To: <20161012160300.GH4308@localhost>
References: <20161012130508.25368.95560.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012160300.GH4308@localhost>
From: Duc Dang <dhdang@apm.com>
Date: Wed, 12 Oct 2016 16:20:41 -0700
Message-ID: <CADaLNDnHPZR2nn-Rqt7Vm_SjJKv-aJnt32sg0N4pcCa0cqg93Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PCI: xgene: Cleanups
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tanmay Inamdar <tinamdar@apm.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 9:03 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Oct 12, 2016 at 08:07:35AM -0500, Bjorn Helgaas wrote:
>>   - Add local "dev" pointers to reduce repetition of things like
>>     "&pdev->dev".
>>
>>   - Remove platform drvdata because it appears unused (we called
>>     platform_set_drvdata() but not platform_get_drvdata()).
>>
>>   - Pass the struct xgene_pcie_port pointer, not addresses, to setup
>>     functions to enable simplifications.
>>
>>   - Add register accessors to encapsulate usage of port->csr_base a bit.
>>
>> Nothing here should change the behavior of the driver.
>>
>> Changes from v1:
>>   I dropped the following patch because it was a lot of churn for
>>   questionable benefit:
>>     PCI: xgene: Name private struct pointer "xgene" consistently
>>
>> ---
>>
>> Bjorn Helgaas (4):
>>       PCI: xgene: Add local struct device pointers
>>       PCI: xgene: Remove unused platform data
>>       PCI: xgene: Pass struct xgene_pcie_port to setup functions
>>       PCI: xgene: Add register accessors
>
> I applied these to pci/host-xgene for v4.9.  I hope to ask Linus to
> pull them tomorrow, so if you see any issues, let me know soon.

Hi Bjorn,

I tested the v2 series on X-Gene 1 and X-Gene 2 and no surprise
happens. Please feel free to add my Acked-by/Tested-by.

Regards,
Duc Dang.
