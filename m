Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:55644 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEH1k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 03:27:40 -0400
Subject: Re: RFC on PCI Device Lock
To: Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
 <20180904165202.4e5bb59d@t450s.home>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <3428a4e6-0095-3eb8-a6d2-c889e201ab98@intel.com>
Date: Tue, 4 Sep 2018 22:59:27 -0400
MIME-Version: 1.0
In-Reply-To: <20180904165202.4e5bb59d@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/4/2018 6:52 PM, Alex Williamson wrote:
> On Fri, 31 Aug 2018 16:03:38 -0700
> Sinan Kaya <okaya@kernel.org> wrote:
> 
>> Hi Bjorn, Alex;
>>
>> Since my recent series to relocate secondary bus reset code into the PCI core,
>> we hit a deadlock while trying to obtain a device lock during probe since
>> device lock is already held.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=200985
>>
>> I posted a patch into the bugzilla so that we skip locks if we are probing
>> to follow the same strategy found in other lock routines in pci.c.
>>
>> https://bugzilla.kernel.org/attachment.cgi?id=278221
>>
>> I wanted to hear some opinions since this is a regression and need to find
>> a solution and also waiting for test feedback

Responded on the bugzilla, the patch seems to pass basic tests. I will 
queue up some more but so far so good.

> TBH, I'm having a hard time seeing the value in the original series.
> Commit 811c5cb37df4 is fiddling with two drivers, hfi1 and vfio-pci.
> In the case of hfi1 the comment before the call is specifically talking
> about performing a secondary bus reset, so all they're looking for is
> bouncing the link, it seems they don't even necessarily want a slot
> reset, which might entail a full power cycle.

Correct. Keep it simple as possible is usually the best approach.

> I won't deny that we're getting a little sloppy with some of the reset
> interfaces and I'd love to solve the device lock issue more generally,
> but trying to abstract slot vs bus and hide the lower level interfaces
> from drivers doesn't seem like it's really working here. 

The issue I have with all of this is we used to have a function that did 
a very simple thing. Do an SBR, get out. Changing the API, I'm fine 
with, but these changes did more than just change the API. They changed 
the underlying behavior and what is happening now is different.

It sounds like all that is being done is put a band-aid on things and 
there is some redesign work needed. Perhaps the best thing to do is back 
this out for 4.19 and revisit with a more general solution for 4.20. 
That's a call for you folks to make. My concern is getting our HW 
functioning again with 4.19 and Sinan's patch along with my 1/1 seems to 
allow that at least.

-Denny
