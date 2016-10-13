Return-Path: <lftan.linux@gmail.com>
Return-Path: <lftan.linux@gmail.com>
MIME-Version: 1.0
Sender: lftan.linux@gmail.com
In-Reply-To: <20161012160053.GB4308@localhost>
References: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012160053.GB4308@localhost>
From: Ley Foon Tan <lftan@altera.com>
Date: Thu, 13 Oct 2016 18:28:13 +0800
Message-ID: <CAFiDJ58G42coDUOJ9X+MNb37m6OUnGQpZoCUoKFY=M+TocMChQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] PCI: altera: Cleanups
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>,
	Rocketboard Maillist <rfi@lists.rocketboards.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 13, 2016 at 12:00 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Oct 12, 2016 at 07:46:59AM -0500, Bjorn Helgaas wrote:
>>   - Add local "dev" pointers to reduce repetition of things like
>>     "&pdev->dev".
>>
>>   - Remove platform drvdata because it appears unused (we called
>>     platform_set_drvdata() but not platform_get_drvdata()).
>>
>>   - Removed an unnecessary platform_get_resource() return value check.
>>
>>   - Rework TLB_CFG_DW0 and TLP_CFG_DW1 to make the code prettier.
>>
>> Nothing here should change the behavior of the driver.
>>
>> Changes from v1:
>>   I dropped the following patches because they were a lot of churn for
>>   questionable benefit:
>>     PCI: altera: Name private struct pointer "altera" consistently
>>     PCI: altera: Rename _altera_pcie_cfg_read() to altera_raw_cfg_read()
>>     PCI: altera: Rename CRA accessors
>>     PCI: altera: Swap order of altera_cra_writel() reg/val arguments
>>
>> ---
>>
>> Bjorn Helgaas (6):
>>       PCI: altera: Add local struct device pointers
>>       PCI: altera: Remove unused platform data
>>       PCI: altera: Remove redundant platform_get_resource() return value check
>>       PCI: altera: Rename altera_pcie_valid_config() to altera_pcie_valid_device()
>>       PCI: altera: Simplify TLB_CFG_DW0 usage
>>       PCI: altera: Simplify TLP_CFG_DW1 usage
>
> I applied these to pci/host-altera for v4.9.  I hope to ask Linus to
> pull them tomorrow, so if you see any issues, let me know soon.

Acked-by: Ley Foon Tan <lftan@altera.com>
