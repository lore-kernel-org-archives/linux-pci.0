Return-Path: <pratyush.anand@gmail.com>
Return-Path: <pratyush.anand@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20161012160711.GT4308@localhost>
References: <20161012140058.30368.94283.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012160711.GT4308@localhost>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Tue, 18 Oct 2016 07:01:20 +0530
Message-ID: <CAHM4w1nAV2vr7rG4spCfShazgm8Smj3ivdAwqWN87tAD32mHxQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PCI: spear: Cleanups
To: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 9:37 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Oct 12, 2016 at 09:04:20AM -0500, Bjorn Helgaas wrote:
>>   - Remove unused constants.  There's some documentation value in these,
>>     but they're only marginally useful to people without the spec, and
>>     I think it's preferable to rely on the spec directly to avoid
>>     transcription errors.
>>
>>   - Pass device-specific struct to internal functions for consistency.
>>
>>   - Tidy up usage of local struct device pointers.
>>
>> Nothing here should change the behavior of the driver.
>>
>> Changes from v1:
>>   I dropped the following patch because it was lot of churn for
>>   questionable benefit:
>>     PCI: spear: Name private struct pointer "spear13xx" consistently
>>
>> ---
>>
>> Bjorn Helgaas (4):
>>       PCI: spear: Remove unused constants
>>       PCI: spear: Pass device-specific struct to internal functions
>>       PCI: spear: Reorder struct spear13xx_pcie
>>       PCI: spear: Clean up struct device usage
>>
>>
>>  drivers/pci/host/pcie-spear13xx.c |  108 +++++++------------------------------
>>  1 file changed, 20 insertions(+), 88 deletions(-)
>
> I applied these to pci/host-spear for v4.9.  I hope to ask Linus to
> pull them tomorrow, so if you see any issues, let me know soon.

Bjorn, Thanks for the cleanup and sorry for late reply.

Patches were all fine. Anyway, they are already in Linus's tree.

I have no more SPEAr platform with me, and my working area has also
changed in last two years So, if someone would like to take over its
maintainership, I would be very happy.

~Pratyush
