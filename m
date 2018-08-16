Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389696AbeHPLTc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2018 07:19:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 16 Aug 2018 13:52:41 +0530
From: poza@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: okaya@kernel.org, Thomas Tai <thomas.tai@oracle.com>,
        bhelgaas@google.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <54d19e0e3d44bedf247853144c6bbfed5561a125.camel@kernel.crashing.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
 <42bd39aef30fe24bfc48d378e1f5d35d@codeaurora.org>
 <54d19e0e3d44bedf247853144c6bbfed5561a125.camel@kernel.crashing.org>
Message-ID: <f022581a9ecb88e5501a09bdcdc62954@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-16 13:45, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-16 at 13:35 +0530, poza@codeaurora.org wrote:
>> >
>> > Bjorn, we are the main authors of that spec (Linas wrote it under my
>> > supervision) and created those callbacks for EEH. AER picked them up
>> > only later. Those changes must be at the very least acked by us before
>> > going upstream.
>> >
>> > Ben.
>> 
>> 
>> + Sinan
>> 
>> This patch set was there in mailing list for nearly 17 to 18 revisions
>> for 7 months.
> 
> Right and sadly the guy doing EEH on our side left and I didn't notice
> what was going on in the list.
> 
> But Bjorn should know better :-)
> 
>> besides the intent was to bring DPC and AER into the same well defined
>> way of error handling.
> 
> That's a good idea, but we need to fix DPC and AER understanding of the
> intent of those callbacks, not change the spec to match the broken
> implementation.
> 

ok lets start with what we have rather than going back, because 
reverting the changes is not going to solve anything
as I mentioned the behavior of some of the functions and DPC (was the 
same before and now)
but the good thing happened because of the patches is; there is a common 
framework defined in err.c
and DPC and AER both act on similar rules (the rule is what we define 
understanding of SPEC)

and all we have to do is discuss and evolve it or change it
we can catch up on webex, (Sinan is going to be there in Plumber's 
conference, I might not be able to join there, as we have bring-up 
coming)


>> The way DPC used to behave in 2016, is still the same; which involved
>> removing and re-enumerating the devices.
> 
> Which is mostly useless for anything that isn't a network device.
> 
> We've been doing EEH for something like 15 to 20 years, so we have a
> long experience with what it takes to get PCI(e) devices to recover on
> enterprise systems.
> 
> Removing and re-enumerating is one of the very worst thing you can do
> in that area.
> 
> Cheers,
> Ben.
