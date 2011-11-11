Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37805 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab1KKUff (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Nov 2011 15:35:35 -0500
Message-ID: <4EBD8714.30401@redhat.com>
Date: Fri, 11 Nov 2011 15:35:32 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: James Paradis <jparadis@redhat.com>,
	Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, matthew wilcox <matthew.wilcox@linux.intel.com>,
	jbarnes@virtuousgeek.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com> <4EBD73C8.8070407@redhat.com> <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com>
In-Reply-To: <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/11/2011 03:29 PM, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2011 at 12:13 PM, Don Dutile<ddutile@redhat.com>  wrote:
>> On 11/11/2011 12:41 PM, James Paradis wrote:
>>>
>>> Hmmm... would it be better to do this as a quirk or as a boot
>>> parameter?  I've heard reports that other systems may be running
>>
>> Hearsay?  if you have definite cases, then please share them,
>> so folks know when to flip the boot parameter on.  note: it would have to be
>> an early boot param as well.
>
> It'd definitely be good to know all the specific cases.
>
> But merely sharing them so folks will know when to use the parameter
> is a broken model.  We should make it work automatically, either with
> some sort of machine-dependent quirk, or (preferably) with a change to
> the generic algorithm so it can handle these "broken" topologies along
> with all the correct ones.
>
> Bjorn

In this case, doing a check that the parent is downstream PPB and the child is
downstream PPB could be done to identify the broken topology and automatically
scan dev nums > 0.




