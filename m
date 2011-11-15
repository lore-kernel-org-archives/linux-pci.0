Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63559 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897Ab1KOXHy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Nov 2011 18:07:54 -0500
Message-ID: <4EC2F0C7.9040804@redhat.com>
Date: Tue, 15 Nov 2011 18:07:51 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: James Paradis <jparadis@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, matthew wilcox <matthew.wilcox@linux.intel.com>,
	jbarnes@virtuousgeek.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
References: <7913c5e8-ea95-4f6f-aa21-33b84e8b931f@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <7913c5e8-ea95-4f6f-aa21-33b84e8b931f@zmail15.collab.prod.int.phx2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/15/2011 05:27 PM, James Paradis wrote:
>
> BTW - for everyone's edification, here is a report on fedoraforum.org
> that looks suspiciously like the same problem we're dealing with:
>
> http://forums.fedoraforum.org/showthread.php?t=255025
>
> The mobo worked with F13, broke with F14, nothing he did seemed to
> bring the keyboard back, ended up fixing it by getting another
> brand of motherboard.  I'm going to see if I can find a copy of
> that motherboard for testing...
>
> --jim
>
No, the original mobo worked on F13; new mobo broken on f13 & f14.
It sounds like an intr-rewiring problem; note, that he got it booted once,
(in the thread) and it took 30mins to do so.


> ----- Original Message -----
>> On Fri, Nov 11, 2011 at 12:13 PM, Don Dutile<ddutile@redhat.com>
>> wrote:
>>> On 11/11/2011 12:41 PM, James Paradis wrote:
>>>>
>>>> Hmmm... would it be better to do this as a quirk or as a boot
>>>> parameter?  I've heard reports that other systems may be running
>>>
>>> Hearsay?  if you have definite cases, then please share them,
>>> so folks know when to flip the boot parameter on.  note: it would
>>> have to be
>>> an early boot param as well.
>>
>> It'd definitely be good to know all the specific cases.
>>
>> But merely sharing them so folks will know when to use the parameter
>> is a broken model.  We should make it work automatically, either with
>> some sort of machine-dependent quirk, or (preferably) with a change
>> to
>> the generic algorithm so it can handle these "broken" topologies
>> along
>> with all the correct ones.
>>
>> Bjorn
>>

