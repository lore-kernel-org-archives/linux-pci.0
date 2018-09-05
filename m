Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeIEWV7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 18:21:59 -0400
Subject: Re: RFC on PCI Device Lock
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
 <20180904165202.4e5bb59d@t450s.home>
 <17720f56-2caa-2d2e-b655-867debf55934@kernel.org>
 <20180904204649.415491f8@t450s.home>
 <571b8341-f6fd-d92a-7091-f4fb02a2aadf@kernel.org>
 <7087eeca-e004-1b15-0ea6-103722399fd0@kernel.org>
 <20180904221302.3031f952@t450s.home>
 <9e130f04-c570-b4ee-e040-b02c9ff80755@kernel.org>
 <20180905113735.3139120c@t450s.home>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <3fe29f84-7e56-b2e8-3f38-8ffdf06e0629@kernel.org>
Date: Wed, 5 Sep 2018 10:50:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180905113735.3139120c@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/5/2018 10:37 AM, Alex Williamson wrote:
> On Wed, 5 Sep 2018 07:26:52 -0700
> Sinan Kaya <okaya@kernel.org> wrote:
> 
>> On 9/4/2018 9:13 PM, Alex Williamson wrote:
>>>> Let me know if I misunderstood you. I'll again wait for test feedback first.
>>> Yep, that's essentially it.  I assume we'd want to trickle this through
>>> other interfaces and the hfi1 folks can look at whether they want to
>>> drop their custom config save/restore in favor of using
>>> pci_reset_function_locked(), which would do that for them.
>>> pci_reset_bus() should also allow the caller to set a mask so vfio
>>> doesn't worry about defaults changing in the core.  Thanks,
>> The testing was successful.
>>
>> "--- Comment #15 from Dennis (dennis.dalessandro@intel.com) ---
>> I have tested the two new patches applied on top of 4.19-rc1 and they seem to
>> be working as well."
>>
>> Before I post the code on the list, I want to make sure I capture your
>> request correctly.
>>
>> You are asking for more APIs to have the mask feature. I can add
>> slot and bus reset options to pci_reset_bus().
>>
>> If there are other functions that need mask feature, we can deal
>> with them later as I want to focus on the regression short term.
>>
>> Though, it would be good to enumerate the functions with needed masks
>> to start the conversation.
> 
> Well, if __pci_reset_function_locked() has this option, would only make
> sense that these would as well:
> 
> pci_probe_reset_function()
> pci_reset_function()
> pci_reset_function_locked()
> pci_try_reset_function()
> 
> Then I'd like to see the same sort of caller specification added to
> pci_reset_bus() so that vfio can specify whether it's expecting a sbr
> or slot reset.  Thanks,

OK. I can work on these. We can review and hopefully reach to a consensus.

I posted the bare minimum needed to bugfix this specific issue for the moment.

> 
> Alex
> 
