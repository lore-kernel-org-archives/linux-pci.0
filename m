Return-Path: <SRS0=zuZq=2Z=jonmasters.org=jcm@kernel.org>
Return-Path: <SRS0=zuZq=2Z=jonmasters.org=jcm@kernel.org>
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
References: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20170130211236.GW20550@bhelgaas-glaptop.roam.corp.google.com>
 <20170131102830.GA13854@localhost.localdomain>
 <20170131142525.GA9942@bhelgaas-glaptop.roam.corp.google.com>
 <20170131145720.GA14231@localhost.localdomain>
 <20170131203109.GA14127@bhelgaas-glaptop.roam.corp.google.com>
 <20170201125325.GA15805@localhost.localdomain>
 <20170201151807.GA15793@bhelgaas-glaptop.roam.corp.google.com>
 <376ae1df-da85-e576-75d6-3ae2ab0f1b41@jonmasters.org>
 <20170315113323.GA28027@localhost.localdomain>
Cc: Bjorn Helgaas <helgaas@kernel.org>, David.Daney@cavium.com,
 tn@semihalf.com, linux-kernel@vger.kernel.org,
 stemerkhanov@CAVIUMNETWORKS.onmicrosoft.com, linux-pci@vger.kernel.org,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <251db823-591b-483b-9c55-13c911020fd1@jonmasters.org>
Date: Thu, 16 Mar 2017 10:32:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170315113323.GA28027@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
List-ID: <linux-pci.vger.kernel.org>

Hi Vadim,

Thanks for your followup and attention to this matter. More below.

On 03/15/2017 07:33 AM, Vadim Lomovtsev wrote:

>> The upstream Linux kernel contains a quirk matching entry that looks for
>> "THRX". Therefore, you have already agreed (as of at least January) that
>> this is the prefix that you will use in any firmware updates to support
>> the latest upstream Linux kernel. Please register this prefix promptly.
> 
> And from what I know for now - we wont going to register this
> since we have already regsitered "CAV" prefix for that. And this was the part
> of our discussion also.
> 
> We had a bit long review of proper implementation of legacy firmware support,
> so my apologise on that.
> 
> Please take a look at link to the patchset posted by Tomasz.
> https://www.spinics.net/lists/arm-kernel/msg568741.html

I'll let others comment on the suitability of taking that for upstream.

>>>> So the FW will be updated accordingly.
>>
>> Indeed.
> 
> Yes, it is now contains "CAVxxx" as _HID for device config object.

Which is different from the version that was merged into upstream. That
should never have happened. It will never happen again. I have spent some
time over the past few days ensuring folks understand that I will not
allow a repeat of this to occur the next time around. We will have
platforms that are bulletproof and supported by upstream with any
errata fixes in a very carefully controlled manner. There will
under no circumstances ever be a situation like this again.

>> The version Bjorn merged looks for "THRX". This is the version that you will
>> use, and you will promptly register that prefix with UEFI and provide fixes
>> for existing firmware to correctly use the solution that is upstream.
> 
> Cavium FW is updated accordingly to use already registered prefix.
> For existent FW legacy support is posted by Tomasz.

I'm watching this to ensure it's cleaned up properly.

Jon.
